unit MBRTURequestF6;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     MBRTURequestBase, MBRTUMasterDispatcherTypes;

type

  { TMBRTURequestF6 }

  TMBRTURequestF6 = class(TMBRTURequestBase)
  private
    FRegister: Word;
    FValue: Word;
    procedure SetRagister(AValue: Word);
    procedure SetValue(AValue: Word);
   public
    constructor Create; override;

    procedure BuilRequest; override;
    procedure SetResponce(var AResponce : TMBPacket; AResponceLen : Word); override;

    property RegisterAddr : Word read FRegister write SetRagister;
    property Value        : Word read FValue write SetValue;
  end;

implementation

uses CRC16Func, LoggerItf,
     MBRTUMasterDispatcherResStr;

{ TMBRTURequestF6 }

constructor TMBRTURequestF6.Create;
begin
  inherited Create;
  MBFunc := 6;
end;

procedure TMBRTURequestF6.SetRagister(AValue: Word);
begin
  if FRegister = AValue then Exit;
  FRegister := AValue;
end;

procedure TMBRTURequestF6.SetValue(AValue: Word);
begin
  if FValue = AValue then Exit;
  FValue := AValue;
end;

procedure TMBRTURequestF6.BuilRequest;
begin
  SetLength(FRequest,8);
  FillByte(FRequest[0],Length(FRequest),0);
  FRequest[0] := DevNum;
  FRequest[1] := MBFunc;
  PWord(@FRequest[2])^ := swap(FRegister);
  PWord(@FRequest[4])^ := Swap(FValue);
  PWord(@FRequest[6])^ := GetCRC16(@FRequest[0],Length(FRequest)-2);
  FResponceSize := 8;
end;

procedure TMBRTURequestF6.SetResponce(var AResponce: TMBPacket; AResponceLen: Word);
begin
  try
   // посылаем данные на обработку
   if IsValidResponce(AResponce, AResponceLen) then
    CallBackItf.ProcessWordRegChangesPackage(MBFunc,FRegister,1,PWordarray(@AResponce[4])^);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsF6SetResp,Format(rsErrSendResp,[E.Message]));
    end;
  end;
end;

end.

