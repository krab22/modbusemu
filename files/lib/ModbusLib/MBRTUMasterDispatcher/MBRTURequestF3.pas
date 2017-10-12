unit MBRTURequestF3;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     MBRTURequestBase, MBRTUMasterDispatcherTypes;

type

  { TMBRTURequestF3 }

  TMBRTURequestF3 = class(TMBRTURequestBase)
   private
    FQuantity  : Word;
    FStartAddr : Word;
    procedure SetQuantity(AValue: Word);
    procedure SetStartAddr(AValue: Word);
   public
    constructor Create; override;

    procedure BuilRequest; override;
    procedure SetResponce(var AResponce : TMBPacket; AResponceLen : Word); override;

    property StartAddr : Word read FStartAddr write SetStartAddr;
    property Quantity  : Word read FQuantity write SetQuantity;
  end;

implementation

uses CRC16Func, LoggerItf,
     MBRTUMasterDispatcherResStr;

{ TMBRTURequestF3 }

constructor TMBRTURequestF3.Create;
begin
  inherited Create;
  MBFunc := 3;
end;

procedure TMBRTURequestF3.SetQuantity(AValue: Word);
begin
  if FQuantity = AValue then Exit;
  FQuantity := AValue;
end;

procedure TMBRTURequestF3.SetStartAddr(AValue: Word);
begin
  if FStartAddr=AValue then Exit;
  FStartAddr := AValue;
end;

procedure TMBRTURequestF3.BuilRequest;
begin
  SetLength(FRequest,8);
  FillByte(FRequest[0],Length(FRequest),0);
  FRequest[0] := DevNum;
  FRequest[1] := MBFunc;
  PWord(@FRequest[2])^ := swap(FStartAddr);
  PWord(@FRequest[4])^ := swap(FQuantity);
  PWord(@FRequest[6])^ := GetCRC16(@FRequest[0],Length(FRequest)-2);
  FResponceSize := FQuantity * 2 + 5;
end;

procedure TMBRTURequestF3.SetResponce(var AResponce: TMBPacket; AResponceLen: Word);
begin
  try
   // посылаем данные на обработку
   if IsValidResponce(AResponce, AResponceLen) then
     CallBackItf.ProcessWordRegChangesPackage(MBFunc,StartAddr,Quantity,PWordarray(@AResponce[3])^);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsF3SetResp,Format(rsErrSendResp,[E.Message]));
    end;
  end;
end;

end.

