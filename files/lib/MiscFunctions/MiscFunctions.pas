unit MiscFunctions;

interface

function SerializeBuff(Buff : Pointer; BuffSize : Cardinal): AnsiString;
function GetGUIDStr(AClearBraces : Boolean = True) : String;

implementation

uses SysUtils;

function GetGUIDStr(AClearBraces : Boolean = True) : String;
var TempGUID : TGuid;
begin
  CreateGUID(TempGUID);
  Result := GUIDToString(TempGUID);
  if AClearBraces then
   begin
    Result := StringReplace(Result,'{','',[rfIgnoreCase,rfReplaceAll]);
    Result := StringReplace(Result,'}','',[rfIgnoreCase,rfReplaceAll]);
   end;
end;

function SerializeBuff(Buff : Pointer; BuffSize : Cardinal): AnsiString;
var TempByteBuff : PByteArray;
    i : Integer;
begin
  Result:='';
  if Buff=nil then Exit;
  TempByteBuff:=Buff;
  for i:=0 to BuffSize-1 do
   if i = 0 then Result:=Format('%s',[IntToHex(TempByteBuff^[i],2)])
     else Result:=Format('%s %s',[Result, IntToHex(TempByteBuff^[i],2)]);
end;

end.
