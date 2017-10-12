unit LoggerFile;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs,
     LoggerItf,
     LogConst;

type

  TMessageQueue = class;

  { TLoggerFileThread }

  TLoggerFileThread = class(TThread)
   private
     FLogFile        : TFileStream;
     FLogQueue       : TMessageQueue;
     FFilePath       : String;
     FFileNamePrefix : String;
     FFileName       : String;
     FEndLine        : String;
     FFileMaxSize    : Int64;
     FCSection       : TCriticalSection;
     function  GetFilePath: String;
     procedure SetFilePath(AValue: String);
     function  GetFileNamePrefix: String;
     procedure SetFileNamePrefix(AValue: String);
     function  GetFileName: String;
     function  GetLogQueue: TMessageQueue;
     procedure SetLogQueue(AValue: TMessageQueue);
     function  GetFileMaxSize: Int64;
     procedure SetFileMaxSize(AValue: Int64);
   protected
     procedure Execute; override;
     function  InitThread : Boolean;
     procedure CloseThread;
     function  MakeFileLogName : String;
     procedure LogReopen;
     procedure WriteMessage(AMessage : String);
     procedure FileFlush;
   public
     constructor Create(CreateSuspended: Boolean; const StackSize: SizeUInt);
     constructor CreateThread(AQueue : TMessageQueue; APath, APrefix : String);
     destructor  Destroy; override;

     property FileName       : String read GetFileName;
     property FilePath       : String read GetFilePath write SetFilePath;
     property FileNamePrefix : String read GetFileNamePrefix write SetFileNamePrefix;
     property FileMaxSize    : Int64 read GetFileMaxSize write SetFileMaxSize default defFileMaxSize;

     property LogQueue       : TMessageQueue read GetLogQueue write SetLogQueue;
  end;

  { TMessageQueue }

  TMessageQueue = class
    private
     FCsection     : TCriticalSection;
     FMessagesList : TStringList;
    public
     constructor Create; virtual;
     destructor  Destroy; override;

     procedure EnQueue(AMessage : String);
     function  DeQueue : String;
     procedure Clear;

     procedure Lock;
     procedure Unlock;

     function IsEmpty : Boolean;
     function CountMessages : Integer;
  end;

  { TFileLogger }

  TFileLogger = class(TComponent, IDLogger)
   private
    FLogLayerSet   : TLogMesTypeSet;
    FLoggerThread  : TLoggerFileThread;
    FLoggerQueue   : TMessageQueue;
    FOwnerName     : String;
    FLogFilePath   : String;
    FFileMaxSize   : Int64;
    function  GetLogEnable: Boolean;
    procedure SetLogEnable(AValue: Boolean);
    procedure SetLogFilePath(AValue: String);
    procedure WriteMessageToQueue(AMessType : TLogMesTypeEnum; Source, Msg : String);
    function  GetFileMaxSize: Int64;
    procedure SetFileMaxSize(AValue: Int64);
   public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    // IDLogger
    procedure info(Source, Msg: String); stdcall;
    procedure warn(Source, Msg: String); stdcall;
    procedure error(Source, Msg: String); stdcall;
    procedure debug(Source, Msg: String); stdcall;

    property LogFilePath : String read FLogFilePath write SetLogFilePath;               // путь к файлам лога
    property OwnerName   : String read FOwnerName write FOwnerName;                     // имя программы использующей логгер
    property LogEnable   : Boolean read GetLogEnable write SetLogEnable default False;  // вести или нет лог - при установке в True активируется
    property LogLayerSet : TLogMesTypeSet read FLogLayerSet write FLogLayerSet;         // по умолчанию [lmtInfo,lmtError,lmtWarn]

    property FileMaxSize : Int64 read GetFileMaxSize write SetFileMaxSize default defFileMaxSize;
  end;

procedure InitLogger;
procedure CloseLogger;

var LoggerObj : TFileLogger;

implementation

uses LazUTF8, LogResStrings
     {$IFDEF UNIX}
     ,Unix
     {$ENDIF}
     {$IFDEF WINDOWS}
     ,Windows
     {$ENDIF}
     ;

procedure InitLogger;
begin
  if not Assigned(LoggerObj) then LoggerObj := TFileLogger.Create(nil);
end;

procedure CloseLogger;
begin
  if Assigned(LoggerObj) then FreeAndNil(LoggerObj);
end;

{ TFileLogger }

constructor TFileLogger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLoggerQueue  := TMessageQueue.Create;
  FLoggerThread := nil;
  FLogLayerSet  := [lmtInfo,lmtError,lmtWarn];
  FFileMaxSize  := defFileMaxSize;
end;

destructor TFileLogger.Destroy;
begin
  LogEnable := False;
  FreeAndNil(FLoggerQueue);
  inherited Destroy;
end;

function TFileLogger.GetLogEnable: Boolean;
begin
  Result := FLoggerThread <> nil;
end;

procedure TFileLogger.SetLogEnable(AValue: Boolean);
begin
  if AValue then
   begin
    if LogEnable then Exit;
    FLoggerThread := TLoggerFileThread.CreateThread(FLoggerQueue,FLogFilePath,FOwnerName);
    FLoggerThread.FileMaxSize := FFileMaxSize;
    FLoggerThread.Start;

   end
  else
   begin
    if not LogEnable then Exit;
    FLoggerThread.Terminate;
    FLoggerThread.WaitFor;
    FreeAndNil(FLoggerThread);
   end;
end;

procedure TFileLogger.SetLogFilePath(AValue: String);
begin
  if SameText(FLogFilePath,AValue) then Exit;
  FLogFilePath := AValue;

  if FLogFilePath <> '' then
   if not DirectoryExists(FLogFilePath) then
    if ForceDirectories(FLogFilePath) then
      raise Exception.CreateFmt(rsErrDirCreate,[FLogFilePath]);

  if FLogFilePath[Length(FLogFilePath)-1] <> DirectorySeparator then FLogFilePath := FLogFilePath+DirectorySeparator;

  if LogEnable then
   begin
    LogEnable := False;
    LogEnable := True;
   end;
end;

procedure TFileLogger.WriteMessageToQueue(AMessType: TLogMesTypeEnum; Source, Msg: String);
var TemTypeStr : String;
begin
  TemTypeStr := '';
  case AMessType of
   lmtInfo   : TemTypeStr := rsInfo;
   lmtWarn   : TemTypeStr := rsWarning;
   lmtError  : TemTypeStr := rsError;
   lmtDebug  : TemTypeStr := rsDebug;
  end;
  {$IFDEF WINDOWS}
  FLoggerQueue.EnQueue(
                       UTF8ToWinCP(
                                   Format('%s [%s] %s: %s',[
                                                            FormatDateTime('yyyy.mm.dd hh:nn:ss,zzz',Now),
                                                            TemTypeStr,
                                                            Source,
                                                            Msg])));
  {$ELSE}
  FLoggerQueue.EnQueue(
                       Format('%s [%s] %s: %s',[
                                                FormatDateTime('yyyy.mm.dd hh:nn:ss,zzz',Now),
                                                TemTypeStr,
                                                Source,
                                                Msg]));
  {$ENDIF}
end;

function TFileLogger.GetFileMaxSize: Int64;
begin
  Result := FFileMaxSize;
end;

procedure TFileLogger.SetFileMaxSize(AValue: Int64);
begin
  FFileMaxSize := AValue;
  if LogEnable then
   begin
    FLoggerThread.FileMaxSize := FFileMaxSize;
   end;
end;

procedure TFileLogger.info(Source, Msg: String); stdcall;
begin
  if not LogEnable then Exit;
  if not (lmtInfo in FLogLayerSet) then Exit;
  WriteMessageToQueue(lmtInfo,Source,Msg);
end;

procedure TFileLogger.warn(Source, Msg: String); stdcall;
begin
  if not LogEnable then Exit;
  if not (lmtWarn in FLogLayerSet) then Exit;
  WriteMessageToQueue(lmtWarn,Source,Msg);
end;

procedure TFileLogger.error(Source, Msg: String); stdcall;
begin
  if not LogEnable then Exit;
  if not (lmtError in FLogLayerSet) then Exit;
  WriteMessageToQueue(lmtError,Source,Msg);
end;

procedure TFileLogger.debug(Source, Msg: String); stdcall;
begin
  if not LogEnable then Exit;
  if not (lmtDebug in FLogLayerSet) then Exit;
  WriteMessageToQueue(lmtDebug,Source,Msg);
end;

{ TLoggerFileThread }

constructor TLoggerFileThread.Create(CreateSuspended: Boolean; const StackSize: SizeUInt);
var StSize : SizeUInt;
begin
  StSize := StackSize;
  if StSize = DefaultStackSize then StSize := 65535;
  inherited Create(CreateSuspended,StSize);
  FFilePath       := '';
  FFileNamePrefix := defFileLogPrx;
  FLogQueue       := nil;
  FLogFile        := nil;
  FFileMaxSize    := defFileMaxSize;
  {$IFDEF WINDOWS}
  FEndLine        := #13#10;
  {$ELSE}
  FEndLine        := #10;
  {$ENDIF};
  FCSection       := syncobjs.TCriticalSection.Create;
end;

constructor TLoggerFileThread.CreateThread(AQueue: TMessageQueue; APath, APrefix: String);
begin
  Create(true,65535);
  FLogQueue       := AQueue;
  FFilePath       := APath;
  FFileNamePrefix := APrefix;
end;

destructor TLoggerFileThread.Destroy;
begin
  FreeAndNil(FCSection);
  inherited Destroy;
end;

procedure TLoggerFileThread.Execute;
var IniRes : Boolean;
begin
  IniRes := InitThread;

  while not Terminated do
   begin
    if IniRes then
     begin
      FLogQueue.Lock;
      try
        while not FLogQueue.IsEmpty do
         begin
          WriteMessage(FLogQueue.DeQueue);
          if Terminated then Break;
         end;
      finally
       FLogQueue.Unlock;
      end;
     end;
    Sleep(500);
   end;

  CloseThread;
end;

function TLoggerFileThread.InitThread : Boolean;
begin
  Result := False;
  if FLogQueue = nil then Exit;
  FFileName := MakeFileLogName;
  try
   LogReopen;
   Result := true;
  except
   Result := False;
  end;
end;

procedure TLoggerFileThread.CloseThread;
begin
  try
   WriteMessage(Format('%s [%s] %s',[FormatDateTime('yyyy.mm.dd hh:nn:ss:zzz',Now),rsInfo,rsStopLog]));
   FreeAndNil(FLogFile);
  except
  end;
end;

function TLoggerFileThread.MakeFileLogName: String;
begin
  Result := Format('%s%s%s%s',[FFilePath,FFileNamePrefix,FormatDateTime('_yyyy_mm_dd_hh_nn_ss',Now),defFileLogExt]);
end;

procedure TLoggerFileThread.LogReopen;
var TempMsg : String;
begin
  if Assigned(FLogFile) then
   begin
    TempMsg := Format('%s [%s] %s',[FormatDateTime('yyyy.mm.dd hh:nn:ss:zzz',Now),rsInfo,rsCloseLog]) + FEndLine;
    FLogFile.Write(TempMsg[1],Length(TempMsg));
    FreeAndNil(FLogFile);
   end;

  FLogFile := TFileStream.Create(FFileName,fmCreate);
  FreeAndNil(FLogFile);
  FLogFile := TFileStream.Create(FFileName,fmOpenWrite+fmShareDenyWrite);

  WriteMessage(Format('%s [%s] %s',[FormatDateTime('yyyy.mm.dd hh:nn:ss:zzz',Now),rsInfo,rsStartLog]));
end;

procedure TLoggerFileThread.WriteMessage(AMessage: String);
begin
  if AMessage = '' then Exit;

  AMessage := AMessage + FEndLine;
  FLogFile.Write(AMessage[1],Length(AMessage));

  if FLogFile.Size > FFileMaxSize then
   begin
    FFileName := MakeFileLogName;
    LogReopen;
   end;

  FileFlush;
end;

procedure TLoggerFileThread.FileFlush;
begin
  {$IFDEF MSWINDOWS}
  FlushFileBuffers(FLogFile.Handle);
  {$ELSE}
  fpfsync(FLogFile.Handle);
  {$ENDIF}
end;

function TLoggerFileThread.GetFileNamePrefix: String;
begin
  FCSection.Enter;
  try
   Result := FFileNamePrefix;
  finally
    FCSection.Leave;
  end;
end;

function TLoggerFileThread.GetFilePath: String;
begin
  FCSection.Enter;
  try
   Result := FFilePath;
  finally
    FCSection.Leave;
  end;
end;

function TLoggerFileThread.GetFileName: String;
begin
  FCSection.Enter;
  try
   Result := FFileName;
  finally
    FCSection.Leave;
  end;
end;

function TLoggerFileThread.GetLogQueue: TMessageQueue;
begin
  FCSection.Enter;
  try
   Result := FLogQueue;
  finally
    FCSection.Leave;
  end;
end;

procedure TLoggerFileThread.SetLogQueue(AValue: TMessageQueue);
begin
  FCSection.Enter;
  try
   FLogQueue := AValue;
  finally
    FCSection.Leave;
  end;
end;

function TLoggerFileThread.GetFileMaxSize: Int64;
begin
  FCSection.Enter;
  try
   Result := FFileMaxSize;
  finally
    FCSection.Leave;
  end;
end;

procedure TLoggerFileThread.SetFileMaxSize(AValue: Int64);
begin
  FCSection.Enter;
  try
   FFileMaxSize := AValue;
  finally
    FCSection.Leave;
  end;
end;

procedure TLoggerFileThread.SetFileNamePrefix(AValue: String);
begin
  FCSection.Enter;
  try
   FFileNamePrefix := AValue;
  finally
    FCSection.Leave;
  end;
end;

procedure TLoggerFileThread.SetFilePath(AValue: String);
begin
  FCSection.Enter;
  try
   FFilePath := AValue;
  finally
    FCSection.Leave;
  end;
end;

{ TMessageQueue }

constructor TMessageQueue.Create;
begin
  FCsection     := syncobjs.TCriticalSection.Create;
  FMessagesList := TStringList.Create;
end;

destructor TMessageQueue.Destroy;
begin
  Clear;
  FreeAndNil(FMessagesList);
  FreeAndNil(FCsection);
  inherited Destroy;
end;

procedure TMessageQueue.EnQueue(AMessage: String);
begin
  FCsection.Enter;
  try
    FMessagesList.Add(AMessage);
  finally
    FCsection.Leave;
  end;
end;

function TMessageQueue.DeQueue: String;
begin
  FCsection.Enter;
  try
    Result := '';
    if FMessagesList.Count = 0 then
     begin
      Exit;
     end;
    Result := FMessagesList.Strings[0];
    FMessagesList.Delete(0);
  finally
    FCsection.Leave;
  end;
end;

procedure TMessageQueue.Clear;
begin
  FCsection.Enter;
  try
    FMessagesList.Clear;
  finally
    FCsection.Leave;
  end;
end;

procedure TMessageQueue.Lock;
begin
  FCsection.Enter;
end;

procedure TMessageQueue.Unlock;
begin
  FCsection.Leave;
end;

function TMessageQueue.IsEmpty: Boolean;
begin
  FCsection.Enter;
  try
    Result := FMessagesList.Count = 0;
  finally
    FCsection.Leave;
  end;
end;

function TMessageQueue.CountMessages: Integer;
begin
  FCsection.Enter;
  try
    Result := FMessagesList.Count;
  finally
    FCsection.Leave;
  end;
end;

initialization
 InitLogger;

finalization;
 CloseLogger;

end.

