unit MBRTUMasterDispatcherFunc;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     MBRTUMasterDispatcherTypes;

function IsValidCRC(var APacket : TMBPacket; APacketLen : Word) : Boolean;
function GetPortAdapterIDStr(APortParam : TMBDispPortParam) : String;
function IsEqualPortInfo(AOld : TMBDispPortParam; ANew : TMBDispPortParam) : Boolean;

implementation

uses CRC16Func, COMPortParamTypes;

function IsValidCRC(var APacket: TMBPacket; APacketLen: Word): Boolean;
begin
  Result := GetCRC16(@APacket[0],APacketLen) = 0;
end;

function GetPortAdapterIDStr(APortParam: TMBDispPortParam): String;
var TempPrefix    : String;
begin
  {$IFDEF WINDOWS}
   TempPrefix := cCOMPrefixWindows;
  {$ENDIF}
  {$IFDEF UNIX}
   TempPrefix := cCOMPrefixLinux;
  {$ENDIF}
  if APortParam.PortPrefix <> '' then TempPrefix := APortParam.PortPrefix;
  Result := Format('%s%d',[TempPrefix,APortParam.PortNum]);
end;

function IsEqualPortInfo(AOld: TMBDispPortParam; ANew: TMBDispPortParam): Boolean;
begin
  Result := (AOld.Parity = ANew.Parity) and
            (AOld.StopBits = ANew.StopBits) and
            (AOld.DataBits = ANew.DataBits) and
            (AOld.BaudRate = ANew.BaudRate) and
            SameText(AOld.PortPrefix, ANew.PortPrefix) and
            (AOld.PortNum = ANew.PortNum);
end;

end.

