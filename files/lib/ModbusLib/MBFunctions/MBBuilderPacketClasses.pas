unit MBBuilderPacketClasses;

{$mode objfpc}{$H+}

{
  Реализация классов строителей запросов для
  MODBUS Application Protocol Specification V1.1b
}

interface

uses Classes,
     MBBuilderBase, MBInterfaces;

const
  cMaxBitRegCount  = 2000;
  cMaxWordRegCount = 125;
  wcMAXWORD        = 65535;
type

  TBuilderMBRTUPacket = class(TBuilderPacketBase,IBuilderRTUPacket)
   protected
    FDeviceAddress   : Byte;
    FFunctionNum     : Byte;
    FResponseSize    : Word;
    FQuantity        : Word;
    FStartingAddress : Word;
    procedure GetPacketMem; virtual;
    procedure ClearPacket; virtual;

    procedure SetQuantity(const Value: Word); virtual; stdcall;
    procedure SetStartingAddress(const Value: Word); virtual; stdcall;
    procedure SetDeviceAddress(const Value: Byte); virtual; stdcall;
    function  GetPacket : Pointer; override; stdcall;
    function  GetPacketLen : WORD; override; stdcall;
    function  GetResponseSize: Word; override; stdcall;
    function  GetDeviceID : Byte; virtual; stdcall;
    function  GetFunctionCode : Byte; virtual; stdcall;
    procedure Notify(EventType : TBuilderEventType); virtual;
    procedure ChackOutRange(AStartingAddress : Word; var AQuantity : Word); virtual;
   public
    constructor Create; override;
    destructor  Destroy; override;
    property DeviceAddress   : Byte read FDeviceAddress write SetDeviceAddress;
    property FunctionNum     : Byte read FFunctionNum;
    property ResponseSize    : Word read GetResponseSize;
    property Quantity        : Word read FQuantity write SetQuantity;
    property StartingAddress : Word read FStartingAddress write SetStartingAddress;
  end;

  TBuilderMBTCPPacket = class(TBuilderMBRTUPacket, IBuilderTCPPacket)
  protected
   FTransactionID : Word;
   FProtocolID    : Word;
   FLen           : Word;
   procedure SetTransactionID(const Value: Word); stdcall;
   procedure SetProtocolID(const Value: Word); stdcall;
   function  GetTransactionID : Word; stdcall;
   function  GetProtocolID    : Word; stdcall;
   function  GetLen           : Word; stdcall;
  public
   constructor Create; override;
   property TransactionID : Word read FTransactionID write SetTransactionID;
   property ProtocolID    : Word read FProtocolID write SetProtocolID;
   property Len           : Word read FLen;
  end;

implementation

uses SysUtils, {$IFDEF WINDOWS} Windows,{$ENDIF}
     MBResourceString, MBDefine;

{ TBuilderMBRTUPacket }

constructor TBuilderMBRTUPacket.Create;
begin
 inherited;
 FBuilderType := btMBRTU;
 FLenPacket:=0;
 FPacket:=nil;
 FDeviceAddress:=1;
 FResponseSize:=0;
 FQuantity:=0;
 FStartingAddress:=1;
end;

procedure TBuilderMBRTUPacket.ChackOutRange(AStartingAddress: Word; var AQuantity: Word);
var TempWord : Word;
begin
  TempWord := 0;
  try
   TempWord:=AStartingAddress+AQuantity;
  except
   AQuantity:=wcMAXWORD-AStartingAddress;
  end;
end;

destructor TBuilderMBRTUPacket.Destroy;
begin
  if FPacket<>nil then FreeMem(FPacket,FLenPacket);
  inherited;
end;

function TBuilderMBRTUPacket.GetDeviceID: Byte; stdcall;
begin
 Result:=FDeviceAddress;
end;

function TBuilderMBRTUPacket.GetFunctionCode: Byte; stdcall;
begin
 Result:=FFunctionNum;
end;

function TBuilderMBRTUPacket.GetPacket: Pointer; stdcall;
begin
  Result := nil;
 try
  Result := AllocMem(FLenPacket);
  Move(FPacket^,Result^,FLenPacket);
  Notify(betRead);
 except
  Result := nil;
 end;
end;

function TBuilderMBRTUPacket.GetPacketLen: WORD; stdcall;
begin
  Result:= FLenPacket;
end;

procedure TBuilderMBRTUPacket.GetPacketMem;
begin
  if FLenPacket = 0 then ClearPacket
   else
    begin
     if FPacket<>nil then FillChar(FPacket^, FLenPacket, 0)
      else FPacket:=AllocMem(FLenPacket);
     if FPacket=nil then raise Exception.Create(erMBFOutOfMemory);
    end; 
end;

procedure TBuilderMBRTUPacket.ClearPacket;
begin
  if FPacket<>nil then
   begin
    FreeMem(FPacket);
    FPacket:=nil;
   end;
end;

function TBuilderMBRTUPacket.GetResponseSize: Word; stdcall;
begin
 Result:=FResponseSize;
end;

procedure TBuilderMBRTUPacket.Notify(EventType: TBuilderEventType);
begin
 case EventType of
  betRead  : begin
              if Assigned(FOnPacketRead) then FOnPacketRead(Self);
             end;
  betBuild : begin
              if Assigned(FOnPacketBuild) then FOnPacketBuild(Self);
             end;
 end;
end;

procedure TBuilderMBRTUPacket.SetDeviceAddress(const Value: Byte); stdcall;
begin
  if (Value>247) then raise Exception.Create(erMBDeviceAddress);
  if FDeviceAddress=Value then Exit;
  FDeviceAddress := Value;
end;

procedure TBuilderMBRTUPacket.SetQuantity(const Value: Word); stdcall;
begin
  if Value = FQuantity then Exit;
  FQuantity := Value;
  ChackOutRange(FStartingAddress,FQuantity);
end;

procedure TBuilderMBRTUPacket.SetStartingAddress(const Value: Word); stdcall;
begin
  if Value = FStartingAddress then Exit;
  FStartingAddress:=Value;
  ChackOutRange(FStartingAddress,FQuantity);
end;

{ TBuilderMBTCPPacket }

constructor TBuilderMBTCPPacket.Create;
begin
  inherited;
  FBuilderType   := btMBTCP;
  FTransactionID := 0;
  FProtocolID    := 0; // Modbus protocol
  FLen           := 0;
end;

function TBuilderMBTCPPacket.GetLen: Word; stdcall;
begin
  Result:=FLen;
end;

function TBuilderMBTCPPacket.GetProtocolID: Word; stdcall;
begin
  Result:=FProtocolID;
end;

function TBuilderMBTCPPacket.GetTransactionID: Word; stdcall;
begin
  Result:=FTransactionID;
end;

procedure TBuilderMBTCPPacket.SetProtocolID(const Value: Word); stdcall;
begin
  FProtocolID := Value;
end;

procedure TBuilderMBTCPPacket.SetTransactionID(const Value: Word); stdcall;
begin
  FTransactionID := Value;
end;


end.
