unit MBRTURequestF4314;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     MBRTURequestBase, MBRTUMasterDispatcherTypes;

type

  { TMBRTURequestF4314 }

  TMBRTURequestF4314 = class(TMBRTURequestBase)
  private
    FObjectID         : Byte;
    FObjectLen        : Byte;
    FReadDeviceIDCode : Byte;
    procedure SetObjectID(AValue: Byte);
    procedure SetObjectLen(AValue: Byte);
    procedure SetReadDeviceIDCode(AValue: Byte);
   public
    constructor Create; override;

    procedure BuilRequest; override;
    procedure SetResponce(var AResponce : TMBPacket; AResponceLen : Word); override;

    property ReadDeviceIDCode : Byte read FReadDeviceIDCode write SetReadDeviceIDCode;
    property ObjectID         : Byte read FObjectID write SetObjectID;
    property ObjectLen        : Byte read FObjectLen write SetObjectLen;
  end;

implementation

uses CRC16Func, LoggerItf,
     MBRTUMasterDispatcherResStr;

{ TMBRTURequestF4314 }

constructor TMBRTURequestF4314.Create;
begin
  inherited Create;
  MBFunc := 43;

  FReadDeviceIDCode := $01;
  FObjectID         := $00;
  FObjectLen        := $00;
end;

procedure TMBRTURequestF4314.SetObjectID(AValue: Byte);
begin
  if FObjectID=AValue then Exit;
  FObjectID:=AValue;
end;

procedure TMBRTURequestF4314.SetObjectLen(AValue: Byte);
begin
  if FObjectLen=AValue then Exit;
  FObjectLen:=AValue;
end;

procedure TMBRTURequestF4314.SetReadDeviceIDCode(AValue: Byte);
begin
  if FReadDeviceIDCode=AValue then Exit;
  FReadDeviceIDCode:=AValue;
end;

procedure TMBRTURequestF4314.BuilRequest;
begin
  SetLength(FRequest,7);
  FillByte(FRequest[0],Length(FRequest),0);
  FRequest[0] := DevNum;
  FRequest[1] := MBFunc;
  FRequest[2] := $0E;
  FRequest[3] := FReadDeviceIDCode;
  FRequest[4] := FObjectID;
  PWord(@FRequest[5])^ := GetCRC16(@FRequest[0],Length(FRequest)-2);
  FResponceSize := 0;
end;

procedure TMBRTURequestF4314.SetResponce(var AResponce: TMBPacket; AResponceLen: Word);
begin
  try
   // посылаем данные на обработку
   if IsValidResponce(AResponce, AResponceLen) then
    CallBackItf.Process4314ResultPackage(MBFunc, $0E, PByteArray(@AResponce[3])^, AResponceLen - 5);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsF4314SetResp,Format(rsErrSendResp,[E.Message]));
    end;
  end;
end;

end.

