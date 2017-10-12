unit MBDeviceArchiver;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, IniFiles,
     LoggerItf,
     MBArchiverTypes, MBArchiverConst,
     MBRangeArchiver;

type

  { TMBArchiverDevice }

  TMBArchiverDevice = class(TComponentLogged)
    private
      FActive         : Boolean;
      FDelimiter      : String;
      FFileName       : String;
      FIsOwnIncomPack : Boolean;
      FIsTextArch     : Boolean;
      FMaxFileLen     : Cardinal;
      FPath           : String;
      FDevNum         : Byte;
      FRangesList     : THashedStringList;
      function  GetDelimiter: String;
      function  GetDevNum: Byte;
      function  GetFileName: String;
      function  GetIsTextArch: Boolean;
      function  GetMaxFileLen: Cardinal;
      function  GetPath: String;
      function  GetRangeArchivers(Index : Integer): TMBRangeArchiver;
      function  GetRangeArchiversByStartAddr(AStartAddr : Word): TMBRangeArchiver;
      function  GetRangeArchiversCount: Integer;
      procedure SetActive(AValue: Boolean);
      procedure SetDelimiter(AValue: String);
      procedure SetDevNum(AValue: Byte);
      procedure SetFileName(AValue: String);
      procedure SetIsOwnIncomPack(AValue: Boolean);
      procedure SetIsTextArch(AValue: Boolean);
      procedure SetMaxFileLen(AValue: Cardinal);
      procedure SetPath(AValue: String);
    public
      constructor Create(AOWner : TComponent); override;
      destructor  Destroy; override;

      procedure AddRecordToArchive(ARecord : PMBArchRecord); overload;
      procedure AddRecordToArchive(ARecord : PMBArchRecordBool); overload;

      function  AddRangeArchiver(ARangeStartAddr: Word; ARangeLen : Word; ARangeType : TMBArchiverRangeType = artWord) : TMBRangeArchiver;
      function  SearchRangeArchiver(AStartAddr : Word) : TMBRangeArchiver;
      procedure DeleteRange(AIndex : Integer); overload;
      procedure DeleteRange(AStartAddr : Word); overload;
      procedure ClearRanges;

      procedure Start;
      procedure Stop;

      property Active : Boolean read FActive write SetActive;

      property RangeArchiversCount : Integer read GetRangeArchiversCount;
      property RangeArchivers[Index : Integer] : TMBRangeArchiver read GetRangeArchivers;
      property RangeArchiversByStartAddr[AStartAddr : Word] : TMBRangeArchiver read GetRangeArchiversByStartAddr;

      property Path           : String read GetPath write SetPath {DefLinFilePath DefWinFilePath};
      property FileName       : String read GetFileName write SetFileName;
      property MaxFileLen     : Cardinal read GetMaxFileLen write SetMaxFileLen default DefMaxFileSize;

      property IsTextArch     : Boolean read GetIsTextArch write SetIsTextArch default True;
      property IsOwnIncomPack : Boolean read FIsOwnIncomPack write SetIsOwnIncomPack default True;
      property Delimiter      : String read GetDelimiter write SetDelimiter {default DefColDelimiter};

      property DevNum         : Byte read GetDevNum write SetDevNum;
  end;

implementation

{ TMBArchiverDevice }

constructor TMBArchiverDevice.Create(AOWner: TComponent);
begin
  inherited Create(AOWner);
  FActive         := False;

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
  FDelimiter      := DefColDelimiter;
  FRangesList     := THashedStringList.Create;
end;

destructor TMBArchiverDevice.Destroy;
begin
  Stop;
  ClearRanges;
  FreeAndNil(FRangesList);
  inherited Destroy;
end;

function TMBArchiverDevice.GetDevNum: Byte;
begin
  Result := FDevNum;
end;

function TMBArchiverDevice.GetDelimiter: String;
begin
  Result := FDelimiter;
end;

function TMBArchiverDevice.GetFileName: String;
begin
  Result := FFileName;
end;

function TMBArchiverDevice.GetIsTextArch: Boolean;
begin
  Result := FIsTextArch;
end;

function TMBArchiverDevice.GetMaxFileLen: Cardinal;
begin
  Result := FMaxFileLen;
end;

function TMBArchiverDevice.GetPath: String;
begin
  Result := FPath;
end;

function TMBArchiverDevice.GetRangeArchivers(Index : Integer): TMBRangeArchiver;
begin

end;

function TMBArchiverDevice.GetRangeArchiversByStartAddr(AStartAddr : Word): TMBRangeArchiver;
begin

end;

function TMBArchiverDevice.GetRangeArchiversCount: Integer;
begin
  Result := FRangesList.Count;
end;

procedure TMBArchiverDevice.SetActive(AValue: Boolean);
begin
  if FActive=AValue then Exit;
  FActive:=AValue;
end;

procedure TMBArchiverDevice.SetDelimiter(AValue: String);
begin
  if FDelimiter=AValue then Exit;
  FDelimiter:=AValue;
end;

procedure TMBArchiverDevice.SetDevNum(AValue: Byte);
begin
  if FDevNum = AValue then Exit;
  FDevNum := AValue;
end;

procedure TMBArchiverDevice.SetFileName(AValue: String);
begin
  if FFileName = AValue then Exit;
  FFileName := AValue;
end;

procedure TMBArchiverDevice.SetIsOwnIncomPack(AValue: Boolean);
begin
  if FIsOwnIncomPack = AValue then Exit;
  FIsOwnIncomPack := AValue;
end;

procedure TMBArchiverDevice.SetIsTextArch(AValue: Boolean);
begin
  if FIsTextArch = AValue then Exit;
  FIsTextArch := AValue;
end;

procedure TMBArchiverDevice.SetMaxFileLen(AValue: Cardinal);
begin
  if FMaxFileLen = AValue then Exit;
  FMaxFileLen := AValue;
end;

procedure TMBArchiverDevice.SetPath(AValue: String);
begin
  if FPath = AValue then Exit;
  FPath := AValue;
end;

procedure TMBArchiverDevice.AddRecordToArchive(ARecord: PMBArchRecord);
begin

end;

procedure TMBArchiverDevice.AddRecordToArchive(ARecord: PMBArchRecordBool);
begin

end;

function TMBArchiverDevice.AddRangeArchiver(ARangeStartAddr: Word; ARangeLen: Word; ARangeType: TMBArchiverRangeType): TMBRangeArchiver;
begin

end;

function TMBArchiverDevice.SearchRangeArchiver(AStartAddr: Word): TMBRangeArchiver;
begin

end;

procedure TMBArchiverDevice.DeleteRange(AIndex: Integer);
begin

end;

procedure TMBArchiverDevice.DeleteRange(AStartAddr: Word);
begin

end;

procedure TMBArchiverDevice.ClearRanges;
begin

end;

procedure TMBArchiverDevice.Start;
begin

end;

procedure TMBArchiverDevice.Stop;
begin

end;

end.

