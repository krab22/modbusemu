unit MBRTURequestBase;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     LoggerItf,
     MBRTUObjItf, MBRTUMasterDispatcherTypes;

type

  { TMBRTURequestBase }

  TMBRTURequestBase = class(TObjectLogged)
   private
    FCallBackItf     : IMBMasterItf;
    FDevNum          : Byte;
    FMBFunc          : Byte;
    FResponceTimeout : Cardinal;
    FLastResponceCRC : Word;
    procedure SetDevNum(AValue: Byte);
    procedure SetMBFunc(AValue: Byte);
    procedure SetResponceTimeout(AValue: Cardinal);
   protected
    FRequest      : TMBPacket;
    FResponceSize : Word;
    FCurError     : Cardinal;
    FLastError    : Cardinal;
    function IsDataChange(ANewCRC : Word): Boolean;
    function IsValidResponce(var AResponce: TMBPacket; AResponceLen: Word) : Boolean; virtual;
   public
    constructor Create; virtual;
    destructor  Destroy; override;

    function  GetRequest : TMBPacket;

    procedure BuilRequest; virtual; abstract;
    procedure SetResponce(var AResponce : TMBPacket; AResponceLen : Word); virtual; abstract;

    property CallBackItf     : IMBMasterItf read FCallBackItf write FCallBackItf;
    property ResponceTimeout : Cardinal read FResponceTimeout write SetResponceTimeout;
    property DevNum          : Byte read FDevNum write SetDevNum;
    property MBFunc          : Byte read FMBFunc write SetMBFunc;
    property ResponceSize    : Word read FResponceSize;
    property CurError        : Cardinal read FCurError write FCurError;
    property LastError       : Cardinal read FLastError write FLastError;
  end;

implementation

uses MBRTUMasterDispatcherConst,
     MBDefine, ExceptionsTypes,
     MBRTUMasterDispatcherFunc;

{ TMBRTURequestBase }

constructor TMBRTURequestBase.Create;
begin
  FDevNum          := 1;
  FMBFunc          := 1;
  FCallBackItf     := nil;
  FResponceTimeout := DefResponseTimeout;
  FResponceSize    := 0;
  FLastResponceCRC := 0;
end;

destructor TMBRTURequestBase.Destroy;
begin
  SetLength(FRequest,0);
  inherited Destroy;
end;

function TMBRTURequestBase.GetRequest: TMBPacket;
begin
  Result := FRequest;
end;

procedure TMBRTURequestBase.SetDevNum(AValue: Byte);
begin
  if FDevNum = AValue then Exit;
  FDevNum := AValue;
end;

procedure TMBRTURequestBase.SetMBFunc(AValue: Byte);
begin
  if FMBFunc = AValue then Exit;
  FMBFunc := AValue;
end;

procedure TMBRTURequestBase.SetResponceTimeout(AValue: Cardinal);
begin
  if FResponceTimeout=AValue then Exit;
  if AValue < MinResponseTimeout then AValue := MinResponseTimeout;
  FResponceTimeout := AValue;
end;

function TMBRTURequestBase.IsDataChange(ANewCRC: Word): Boolean;
begin
  Result := FLastResponceCRC <> ANewCRC;
  if Result then FLastResponceCRC := ANewCRC;
end;

function TMBRTURequestBase.IsValidResponce(var AResponce: TMBPacket; AResponceLen: Word): Boolean;
var TempErr : Cardinal;
begin
  Result := False;

  if (CallBackItf = nil) then Exit;

  FLastError := FCurError;
  FCurError  := 0;

  // длинна пришедшего пакета
  if (FResponceSize <> 0) then
   if (AResponceLen <> FResponceSize) and (AResponceLen <> 5) then
    begin
     if FLastError <> ERR_MASTER_PACK_LEN then
      begin
       CallBackItf.SendEvent(mdeeMBError,ERR_MASTER_PACK_LEN,AResponceLen);
      end;
     FCurError := ERR_MASTER_PACK_LEN;
     Exit;
    end;

  // контрольная сумма совпадает с контрольной суммой предыдущего пакета - данные не изменились
  if not IsDataChange(PWord(@AResponce[AResponceLen - 2])^) then Exit;

  // валидность CRC
  if not IsValidCRC(AResponce,AResponceLen) then
   begin
     if FLastError <> ERR_MASTER_CRC then
      begin
        CallBackItf.SendEvent(mdeeMBError,ERR_MASTER_CRC);
      end;
     FCurError := ERR_MASTER_CRC;
     Exit;
   end;
  // ошибка от устройства
  if AResponce[1] and $80 = $80 then
   begin
     TempErr := ERR_MB_ERR_CUSTOM + AResponce[2];
     if FLastError <> TempErr then
      begin
        CallBackItf.SendEvent(mdeeMBError,TempErr);
      end;
     FCurError := TempErr;
     Exit;
   end;

  Result := True;
end;

end.

