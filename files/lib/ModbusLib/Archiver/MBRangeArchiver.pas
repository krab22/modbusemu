unit MBRangeArchiver;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs, contnrs,
     LoggerItf,
     MBArchiverConst, MBArchiverTypes;

type
  TMBRangeArchiver = class;

  {
   Поток занимается открытием/закрытием файла архива, отслеживанием его размера,
   записью пакетов в файл.
  }

  { TMBRangeArchThread }

  TMBRangeArchThread = class(TThreadLogged)
   private
    FArchiver       : TMBRangeArchiver;
    FIsOwnIncomPack : Boolean;
    FIsTextArch     : Boolean;
    FFileStream     : TFileStream;
    FFileName       : String;
    FDevNum         : Byte;
    FRangeLen       : Word;
    FRangeType      : TMBArchiverRangeType;
    FRangeStartAddr : Word;
    FRangeByteLen   : Word;
    FMaxFileLen     : Cardinal;
    FTextCaption    : String;
    FDelimiter      : String;
    FPollDelay      : Cardinal;
   protected
    procedure Execute; override;

    function  Init : Boolean;
    procedure Close;

    procedure FileFlush;
    procedure FreePack(APack : Pointer);
    procedure WritePack(APack : Pointer);

    procedure WriteCaption;

    procedure WriteAsText(ARecord: PMBWordArchRecord); overload;
    procedure WriteAsText(ARecord: PMBBoolArchRecord); overload;

    procedure WriteAsBin(ARecord: PMBWordArchRecord); overload;
    procedure WriteAsBin(ARecord: PMBBoolArchRecord); overload;
   public
    constructor Create(ARengeArch : TMBRangeArchiver);
    destructor  Destroy; override;

    property PollDelay : Cardinal read FPollDelay write FPollDelay default DefPollDelay;
  end;

  { TMBRangeArchiver }

  TMBRangeArchiver = class(TComponentLogged)
   private
     FCSection       : TCriticalSection;
     FThread         : TMBRangeArchThread;
     FQueue          : TQueue;
     FDevNum         : Byte;
     FFileName       : String;
     FIsTextArch     : Boolean;
     FIsOwnIncomPack : Boolean;
     FMaxFileLen     : Cardinal;
     FPath           : String;
     FRangeLen       : Word;
     FRangeStartAddr : Word;
     FRangeType      : TMBArchiverRangeType;
     FTextCaption    : String;
     FDelimiter      : String;

     function  GetActive: Boolean;
     function  GetDevNum: Byte;
     function  GetFileName: String;
     function  GetIsOwnIncomPack: Boolean;
     function  GetIsTextArch: Boolean;
     function  GetMaxFileLen: Cardinal;
     function  GetPath: String;
     function  GetQueue: TQueue;
     function  GetRangeLen: Word;
     function  GetRangeStartAddr: Word;
     function  GetRangeType: TMBArchiverRangeType;
     function  GetTextCaption: String;
     procedure SetDelimiter(AValue: String);
     procedure SetDevNum(AValue: Byte);
     procedure SetFileName(AValue: String);
     procedure SetIsOwnIncomPack(AValue: Boolean);
     procedure SetIsTextArch(AValue: Boolean);
     procedure SetMaxFileLen(AValue: Cardinal);
     procedure SetPath(AValue: String);
     procedure SetRangeLen(AValue: Word);
     procedure SetRangeStartAddr(AValue: Word);
     procedure SetRangeType(AValue: TMBArchiverRangeType);
     procedure SetTextCaption(AValue: String);
   protected
    procedure SetLogger(const AValue: IDLogger); override;
   public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    procedure Lock;
    procedure Unlock;
    function  GenFullFileName : String;
    function  GenTextCaption : String;
    procedure CleanQueue;

    procedure AddRecordToArchive(ATimeStamp : TDateTime; AData : PWordarray); overload;
    procedure AddRecordToArchive(ATimeStamp : TDateTime; AData : PByteArray); overload;

    function  Start : Boolean;
    procedure Stop;

    property Queue          : TQueue read GetQueue;

    property Active         : Boolean read GetActive;
    property IsOwnIncomPack : Boolean read GetIsOwnIncomPack write SetIsOwnIncomPack default True;

    property Path           : String read GetPath write SetPath {DefLinFilePath DefWinFilePath};
    property FileName       : String read GetFileName write SetFileName;
    property MaxFileLen     : Cardinal read GetMaxFileLen write SetMaxFileLen default DefMaxFileSize;

    property IsTextArch     : Boolean read GetIsTextArch write SetIsTextArch default False;
    property TextCaption    : String read GetTextCaption write SetTextCaption;
    property Delimiter      : String read FDelimiter write SetDelimiter {default DefColDelimiter};

    property DevNum         : Byte read GetDevNum write SetDevNum;
    property RangeStartAddr : Word read GetRangeStartAddr write SetRangeStartAddr;
    property RangeLen       : Word read GetRangeLen write SetRangeLen;
    property RangeType      : TMBArchiverRangeType read GetRangeType write SetRangeType default artWord;
  end;

implementation

uses MiscFunctions
     {$IFDEF UNIX} , Unix{$ELSE} , windows {$ENDIF},
     MBArchiverResStrings;

{ TMBRangeArchThread }

constructor TMBRangeArchThread.Create(ARengeArch: TMBRangeArchiver);
begin
  if not Assigned(ARengeArch) then Exit;
  inherited Create(True,65535);
  FArchiver       := ARengeArch;
  FFileStream     := nil;
  FIsOwnIncomPack := FArchiver.IsOwnIncomPack;
  FIsTextArch     := FArchiver.IsTextArch;
  FFileName       := FArchiver.GenFullFileName;
  FMaxFileLen     := FArchiver.MaxFileLen;
  FTextCaption    := FArchiver.TextCaption;
  if FTextCaption = '' then FTextCaption := FArchiver.GenTextCaption;
  FDelimiter      := FArchiver.Delimiter;
  FDevNum         := FArchiver.DevNum;
  FRangeType      := FArchiver.RangeType;
  FRangeLen       := FArchiver.RangeLen;
  if FRangeType = artBoolean then
   begin
    FRangeByteLen := FRangeLen div 8;
    if (FRangeLen mod 8) <> 0 then Inc(FRangeByteLen);
   end
  else FRangeByteLen := FRangeLen * 2;
  FRangeStartAddr := FArchiver.RangeStartAddr;
  FPollDelay      := DefPollDelay;
end;

destructor TMBRangeArchThread.Destroy;
begin
  Close;
  inherited Destroy;
end;

procedure TMBRangeArchThread.Execute;
var IsInit : Boolean;
    TempPack : Pointer;
begin
  IsInit := Init;
  try
   while not Terminated do
    begin
      FArchiver.Lock;
      try
       TempPack := FArchiver.Queue.Pop;

       if not IsInit then
        begin
         FreePack(TempPack);
         Sleep(FPollDelay);
         Continue;
        end;

       WritePack(TempPack);
       FreePack(TempPack);

       if FFileStream.Size > FMaxFileLen then
        begin
         Close;
         FFileName := FArchiver.GenFullFileName;
         IsInit := Init;
         Continue;
        end;

       Sleep(FPollDelay);
      finally
       FArchiver.Unlock;
      end;
    end;
  finally
   Close;
  end;
end;

function TMBRangeArchThread.Init: Boolean;
begin
  Result := False;

  try
   FFileStream := TFileStream.Create(FFileName,fmCreate);
  except
   On E : Exception do
    begin
     SendLogMessage(llError,rsArchiver, Format(rsArchErrorCreateFile,[E.Message]));
     FFileStream := nil;
     Exit;
    end;
  end;

  try
   FreeAndNil(FFileStream);
   FFileStream := TFileStream.Create(FFileName,fmOpenWrite or fmShareDenyWrite);

   SendLogMessage(llInfo,rsArchiver,Format(rsArchFileOpen,[FFileName]));

  except
   On E : Exception do
    begin
     SendLogMessage(llError,rsArchiver, Format(rsArchErrorOpenFile,[E.Message]));
     FFileStream := nil;
     Exit;
    end;
  end;

  WriteCaption;
  Result := True;
end;

procedure TMBRangeArchThread.Close;
begin
  if not Assigned(FFileStream) then Exit;

  SendLogMessage(llInfo,rsArchiver, Format(rsArchFileClose,[FFileStream.Size]));

  FileFlush;
  FreeAndNil(FFileStream);
end;

procedure TMBRangeArchThread.FileFlush;
begin
{$IFDEF MSWINDOWS}
  FlushFileBuffers(FFileStream.Handle);
{$ELSE}
  fpfsync(FFileStream.Handle);
{$ENDIF}
end;

procedure TMBRangeArchThread.FreePack(APack: Pointer);
begin
  if not Assigned(APack) then Exit;
  if not FIsOwnIncomPack then
   begin
    if Assigned(PMBWordArchRecord(APack)^.RegsData) then Freemem(PMBWordArchRecord(APack)^.RegsData);
   end;
  Freemem(APack);
end;

procedure TMBRangeArchThread.WritePack(APack: Pointer);
begin
  if not Assigned(APack) then Exit;
  if FIsTextArch then
   begin
     case FRangeType of
      artWord    : WriteAsText(PMBWordArchRecord(APack));
      artBoolean : WriteAsText(PMBBoolArchRecord(APack));
     end;
   end
  else
   begin
     case FRangeType of
      artWord    : WriteAsBin(PMBWordArchRecord(APack));
      artBoolean : WriteAsBin(PMBBoolArchRecord(APack));
     end;
   end;
end;

procedure TMBRangeArchThread.WriteCaption;
var Tempbyte : Byte;
    Tempstr  : String;
begin
  if FIsTextArch then
   begin // заголовок текстового файла
    Tempstr := Format('%d%s%d%s%d%s%d%s%s',[FDevNum,
                                            FDelimiter,
                                            FRangeStartAddr,
                                            FDelimiter,
                                            FRangeLen,
                                            FDelimiter,
                                            Byte(FRangeType),
                                            FDelimiter,
                                            LineEnding]);
    FFileStream.Write(Tempstr[1],Length(Tempstr));
    FFileStream.Write(FTextCaption[1],Length(FTextCaption))
   end
  else
   begin // загорловок бинарного файла
    FFileStream.Write(FDevNum,SizeOf(FDevNum));                 // 1 байт
    FFileStream.Write(FRangeStartAddr,SizeOf(FRangeStartAddr)); // 2 байта
    FFileStream.write(FRangeLen,SizeOf(FRangeLen));             // 2 байта - количество переменных, а не длинна пакета
    Tempbyte := Byte(FRangeType);
    FFileStream.Write(Tempbyte,1);                              // 1 байт
   end;
   FileFlush;
end;

procedure TMBRangeArchThread.WriteAsText(ARecord: PMBWordArchRecord);
var TempRecord : String;
begin
  TempRecord := Format('%s%s%s',[FormatDateTime(DateTimeStrFormat,ARecord^.TimeStamp),
                                 FDelimiter,
                                 GetWordArrayAsCSVLine(ARecord^.RegsData,FRangeLen,FDelimiter)]);
  FFileStream.Write(TempRecord[1],Length(TempRecord));
  FileFlush;
end;

procedure TMBRangeArchThread.WriteAsText(ARecord: PMBBoolArchRecord);
var TempRecord : String;
begin
  TempRecord := Format('%s%s%s',[FormatDateTime(DateTimeStrFormat,ARecord^.TimeStamp),
                                 FDelimiter,
                                 GetBoolArrayAsCSVLine(ARecord^.RegsData,FRangeByteLen,FDelimiter)]);
  FFileStream.Write(TempRecord[1],Length(TempRecord));
  FileFlush;
end;

procedure TMBRangeArchThread.WriteAsBin(ARecord: PMBWordArchRecord);
begin
  FFileStream.Write(ARecord^.TimeStamp,SizeOf(TDateTime));
  FFileStream.Write(ARecord^.RegsData^[0],FRangeByteLen);
  FileFlush;
end;

procedure TMBRangeArchThread.WriteAsBin(ARecord: PMBBoolArchRecord);
begin
  FFileStream.Write(ARecord^.TimeStamp,SizeOf(TDateTime));
  FFileStream.Write(ARecord^.RegsData^[0],FRangeByteLen);
  FileFlush;
end;

{ TMBRangeArchiver }

constructor TMBRangeArchiver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCSection       := syncobjs.TCriticalSection.Create;
  FThread         := nil;
  FQueue          := TQueue.Create;
  FDevNum         := 1;
  FFileName       := DefFileName;
  FIsTextArch     := True;
  FIsOwnIncomPack := True;
  FMaxFileLen     := DefMaxFileSize;
  {$ifdef UNIX}
  FPath           := DefLinFilePath;
  {$ELSE}
  FPath           := DefWinFilePath;
  {$ENDIF}
  FRangeLen       := 0;
  FRangeStartAddr := 0;
  FRangeType      := artWord;
  FTextCaption    := '';
  FDelimiter      := DefColDelimiter;
end;

destructor TMBRangeArchiver.Destroy;
begin
  Stop;
  CleanQueue;
  FreeAndNil(FQueue);
  FreeAndNil(FCSection);
  inherited Destroy;
end;

function TMBRangeArchiver.GenFullFileName : String;
var TempExt : String;
    TempLen : Integer;
begin
  Lock;
  try
    if FIsTextArch then TempExt := DefTxtArchExt
     else TempExt := DefBinArchExt;
    TempLen := Pos(PathDelim,FPath);
    if TempLen <> Length(FPath) then FPath := FPath + PathDelim;
    Result := Format('%s%s-%d-%d-%d-%s.%s',[FPath,
                                            FFileName,
                                            FDevNum,
                                            FRangeStartAddr,
                                            FRangeLen,
                                            FormatDateTime('yyyymmddhhnnsszzz',Now),
                                            TempExt]);
  finally
    Unlock;
  end;
end;

function TMBRangeArchiver.GenTextCaption: String;
var TemStart : Word;
    TempLen  : Word;
    TempDelimiter : String;
    i : integer;
begin
  Result := '';
  Lock;
  try
    TempLen       := FRangeLen + 1; //тамстампа
    TemStart      := FRangeStartAddr;
    TempDelimiter := FDelimiter;
  finally
   Unlock;
  end;
  for i := 0 to TempLen-1 do
   begin
    if i = 0 then Result := Format('%s%s',[rsArchTimeCaption,TempDelimiter])
     else Result := Format('%sReg%d%s',[Result,i + TemStart - 1,TempDelimiter]);
   end;
end;

procedure TMBRangeArchiver.CleanQueue;
var TempRec : PMBWordArchRecord;
begin
  Lock;
  try
   while FQueue.Count <> 0 do
    begin
     TempRec := FQueue.Pop;
     if Assigned(TempRec) then
      begin
       if Assigned(TempRec^.RegsData) then Freemem(TempRec^.RegsData);
       Freemem(TempRec);
      end;
    end;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.AddRecordToArchive(ATimeStamp: TDateTime; AData: PWordarray);
var TempRec : PMBWordArchRecord;
begin
  if not Assigned(AData) then Exit;

  if (FRangeType <> artWord) and (FIsOwnIncomPack) then
   begin
    if Assigned(AData) then Freemem(AData);
    Exit;
   end;
  TempRec := Getmem(SizeOf(TMBWordArchRecord));
  if not Assigned(TempRec) then
   begin
    if Assigned(AData) then Freemem(AData);
    Exit;
   end;
  TempRec^.TimeStamp := ATimeStamp;
  TempRec^.RegsData  := AData;

  FQueue.Push(TempRec);
end;

procedure TMBRangeArchiver.AddRecordToArchive(ATimeStamp: TDateTime; AData: PByteArray);
var TempRec : PMBBoolArchRecord;
begin
  if not Assigned(AData) then Exit;

  if (FRangeType <> artBoolean) and (FIsOwnIncomPack) then
   begin
    if Assigned(AData) then Freemem(AData);
    Exit;
   end;
  TempRec := Getmem(SizeOf(TMBBoolArchRecord));
  if not Assigned(TempRec) then
   begin
    if Assigned(AData) then Freemem(AData);
    Exit;
   end;
  TempRec^.TimeStamp := ATimeStamp;
  TempRec^.RegsData  := AData;

  FQueue.Push(TempRec);
end;

function TMBRangeArchiver.Start: Boolean;
begin
  Result := Active;
  if Result then Exit;
  FThread := TMBRangeArchThread.Create(Self);
  FThread.Logger := Logger;
  FThread.Start;
end;

procedure TMBRangeArchiver.Stop;
begin
  FThread.Terminate;
  FThread.WaitFor;
  FreeAndNil(FThread);
end;

function TMBRangeArchiver.GetActive: Boolean;
begin
  Result := Assigned(FThread);
end;

function TMBRangeArchiver.GetDevNum: Byte;
begin
  Lock;
  try
    Result := FDevNum;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetFileName: String;
begin
  Lock;
  try
    Result := FFileName;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetIsOwnIncomPack: Boolean;
begin
  Lock;
  try
   Result := FIsOwnIncomPack;
  finally
   Unlock;
  end;
end;

procedure TMBRangeArchiver.SetIsOwnIncomPack(AValue: Boolean);
begin
  if FIsOwnIncomPack = AValue then Exit;
  Lock;
  try
   FIsOwnIncomPack := AValue;
  finally
  end;
end;

function TMBRangeArchiver.GetIsTextArch: Boolean;
begin
  Lock;
  try
    Result := FIsTextArch;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetMaxFileLen: Cardinal;
begin
  Lock;
  try
    Result := FMaxFileLen;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetPath: String;
begin
  Lock;
  try
    Result := FPath;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetQueue: TQueue;
begin
  Lock;
  try
    Result := FQueue;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetRangeLen: Word;
begin
  Lock;
  try
    Result := FRangeLen;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetRangeStartAddr: Word;
begin
  Lock;
  try
    Result := FRangeStartAddr;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetRangeType: TMBArchiverRangeType;
begin
  Lock;
  try
    Result := FRangeType;
  finally
   Unlock;
  end;
end;

function TMBRangeArchiver.GetTextCaption: String;
begin
  Lock;
  try
    Result := FTextCaption;
  finally
   Unlock;
  end;
end;

procedure TMBRangeArchiver.SetDelimiter(AValue: String);
begin
  if FDelimiter = AValue then Exit;
  Lock;
  try
   FDelimiter := AValue;
  finally
   Unlock;
  end;
end;

procedure TMBRangeArchiver.SetDevNum(AValue: Byte);
begin
  if FDevNum = AValue then Exit;
  Lock;
  try
   FDevNum := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetFileName(AValue: String);
begin
  if SameText(FFileName,AValue) then Exit;
  Lock;
  try
   FFileName := AValue;
  finally
   Unlock;
  end;
end;

procedure TMBRangeArchiver.SetIsTextArch(AValue: Boolean);
begin
  if FIsTextArch = AValue then Exit;
  Lock;
  try
   FIsTextArch := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetMaxFileLen(AValue: Cardinal);
begin
  if FMaxFileLen = AValue then Exit;
  Lock;
  try
   FMaxFileLen := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetPath(AValue: String);
begin
  if FPath = AValue then Exit;
  Lock;
  try
   FPath := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetRangeLen(AValue: Word);
begin
  if FRangeLen = AValue then Exit;
  Lock;
  try
   FRangeLen := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetRangeStartAddr(AValue: Word);
begin
  if FRangeStartAddr = AValue then Exit;
  Lock;
  try
   FRangeStartAddr := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetRangeType(AValue: TMBArchiverRangeType);
begin
  if FRangeType = AValue then Exit;
  Lock;
  try
   FRangeType := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetTextCaption(AValue: String);
begin
  if FTextCaption = AValue then Exit;
  Lock;
  try
   FTextCaption := AValue;
  finally
    Unlock;
  end;
end;

procedure TMBRangeArchiver.SetLogger(const AValue: IDLogger);
begin
  inherited SetLogger(AValue);
  if Active then FThread.Logger := AValue;
end;

procedure TMBRangeArchiver.Lock;
begin
  FCSection.Enter;
end;

procedure TMBRangeArchiver.Unlock;
begin
  FCSection.Leave;
end;

end.

