{
$Author: npcprom\fomin_k $
$Date: 2014-01-22 14:37:04 +0600 (Wed, 22 Jan 2014) $
$Rev: 253 $
}
unit MBRequestReaderRTUClasses;

{$mode objfpc}{$H+}

interface

uses
     MBInterfaces, MBRequestReaderBaseClasses;

type
  TMBRTURequestReader = class(TMBRequestReaderBase,IMBRTUReuqestReader)
   private
     FPacketCRC : Word;
   protected
    function GetPacketCRC : Word; stdcall;

    procedure FreePacket; override;
    procedure InitHeader;
    function  CheckPacketNil(Packet : Pointer): Boolean;
    function  CheckPacketLen(PacketLen : Cardinal): Boolean;
    function  CheckCRC(Packet : Pointer; PacketLen : Cardinal): Boolean;
   public
    constructor Create; override;
    function  GetPacketData(out DataSize : Cardinal): Pointer; override; stdcall;      // требует освобождения памяти после использования
    procedure RequestRead(Packet : Pointer; PacketSize : Cardinal); override; stdcall;

    property PacketCRC : Word read GetPacketCRC;
  end;

implementation

uses SysUtils,
     CRC16Func,
     MBErrorCode, MBDefine, MBRequestTypes;

{ TMBRTURequestReader }

constructor TMBRTURequestReader.Create;
begin
  inherited;
  FPacketCRC := 0;
end;

procedure TMBRTURequestReader.FreePacket;
begin
  inherited;
  InitHeader;
end;

function TMBRTURequestReader.GetPacketCRC: Word;
begin
  Result := FPacketCRC;
end;

function TMBRTURequestReader.GetPacketData(out DataSize: Cardinal): Pointer;
begin
  Result:=nil;
  if FPacket = nil then Exit;
  DataSize := FPacketSize-4;
  Result := AllocMem(DataSize);
  Move(Pointer(Cardinal(FPacket)+2)^,Result^,DataSize);
end;

procedure TMBRTURequestReader.InitHeader;
begin
  FPacketCRC :=0;
end;

procedure TMBRTURequestReader.RequestRead(Packet: Pointer; PacketSize: Cardinal);
var TempHeader : PMBDeviceInfo;
begin
  FreePacket;
  Notify(rpStartRead);
  try
   if not CheckPacketNil(Packet)     then raise Exception.Create(GetMBErrorString(FErrorCode));
   if not CheckPacketLen(PacketSize) then raise Exception.Create(GetMBErrorString(FErrorCode));
   if not CheckCRC(Packet,PacketSize)then raise Exception.Create(GetMBErrorString(FErrorCode));

   CopyPacket(Packet,PacketSize);

   TempHeader := PMBDeviceInfo(Packet);

   FDeviceAddress := TempHeader^.DeviceAddress;
   FFunctionCode  := TempHeader^.FunctionCode;
   FPacketCRC     := Word(Pointer(Cardinal(Packet)+PacketSize-2)^);

  except
   on E : Exception do
   begin
     Notify(rpError,E.Message);
     Exit;
   end;
  end;
  Notify(rpEndRead);
end;

function TMBRTURequestReader.CheckPacketLen(PacketLen: Cardinal): Boolean;
begin
   Result := False;
  FErrorCode := ERR_MASTER_PACK_LEN;
  // минимальная длинна пакета запроса: 4 байт;
  // максимальная длинна пакета: 256 байт;
  if (PacketLen < 4) or (PacketLen > 256) then Exit;
  Result     := True;
  FErrorCode := 0;
end;

function TMBRTURequestReader.CheckPacketNil(Packet: Pointer): Boolean;
begin
  Result := False;
  FErrorCode := ERR_MASTER_BUFF_NOT_ASSIGNET;
  if Packet = nil then Exit;
  Result     := True;
  FErrorCode := 0;
end;

function TMBRTURequestReader.CheckCRC(Packet: Pointer; PacketLen: Cardinal): Boolean;
begin
  Result     := False;
  FErrorCode := ERR_MASTER_CRC;
  Result:= GetCRC16(Packet,PacketLen)=0;
  if Result then FErrorCode:=0;
end;

end.