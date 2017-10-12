unit MiscFunctions;

interface

uses sysutils;

resourcestring

 rsNotRealize = 'Не реализовано';

function SerializeBuff(Buff : Pointer; BuffSize : Cardinal): AnsiString;
function SerializeByteArray(AData: array of Byte; ADataLen: Word) : String;
function GetGUIDStr(AClearBraces : Boolean = True) : String;
function IsWordInArray(AWordArray : array of Word; AValue : Word): Boolean;
function IsIntInArray(AIntArray : array of Integer; AValue : Integer): Boolean;
function GetWordArrayAsStr(AWordArray : array of Word; AHex :Boolean = True) : String;
function GetByteArrayAsStr(AByteArray : array of Byte; AHex :Boolean = True) : String;

function GetWordArrayAsCSVLine(AWordArray : PWordarray; ALen : Word; ADelimiter : String = ';'; AAddLineDelimiter : Boolean = True) : String;
function GetBoolArrayAsCSVLine(AByteArray : PByteArray; ALen : Word; ADelimiter : String = ';'; AAddLineDelimiter : Boolean = True) : String;

function GetIntArrayAsStr(AIntArray : array of Integer; AHex :Boolean = True) : String;
function GetWordBitStr(ADataWord : Word) : String;


implementation

function GetWordBitStr(ADataWord: Word): String;
begin
  if ADataWord and $8000 = 0 then Result:= '0'        else Result:= '1';
  if ADataWord and $4000 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $2000 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $1000 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0800 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0400 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0200 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0100 = 0 then Result:= Result+'0 'else Result:= Result+'1 ';
  if ADataWord and $0080 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0040 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0020 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0010 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0008 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0004 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0002 = 0 then Result:= Result+'0' else Result:= Result+'1';
  if ADataWord and $0001 = 0 then Result:= Result+'0' else Result:= Result+'1';
end;

function GetWordArrayAsCSVLine(AWordArray: PWordarray; ALen: Word; ADelimiter : String; AAddLineDelimiter : Boolean): String;
var i : Integer;
begin
  Result := '';
  for i := 0 to ALen-1 do
   begin
    if i = 0 then Result := Format('%d',[AWordArray^[i], ADelimiter])
     else Result := Format('%s%d%s',[Result, AWordArray^[i], ADelimiter]);
   end;
  if AAddLineDelimiter then Result := Format('%s%s',[Result,LineEnding]);
end;

function GetBoolArrayAsCSVLine(AByteArray: PByteArray; ALen: Word; ADelimiter : String; AAddLineDelimiter : Boolean): String;
begin
  Result := rsNotRealize;
  if AAddLineDelimiter then Result := Format('%s%s',[Result,LineEnding]);
end;

function GetIntArrayAsStr(AIntArray : array of Integer; AHex :Boolean = True) : String;
var i,Count : Integer;
    TempLen : Integer;
begin
  Result := '';
  TempLen := Length(AIntArray);
  if TempLen = 0 then Exit;
  Result := IntToStr(TempLen);
  Count := High(AIntArray);
  for i := Low(AIntArray) to Count do
   begin
    if not AHex then Result := Format('%s:%d',[Result,AIntArray[i]])
     else Result := Format('%s:0x%s',[Result,IntToHex(AIntArray[i],8)]);
   end;
end;

function GetWordArrayAsStr(AWordArray : array of Word; AHex :Boolean) : String;
var i,Count : Integer;
    TempLen : Integer;
begin
  Result := '';
  TempLen := Length(AWordArray);
  if TempLen = 0 then Exit;
  Result := IntToStr(TempLen);
  Count := High(AWordArray);
  for i := Low(AWordArray) to Count do
   begin
    if not AHex then Result := Format('%s::%d',[Result,AWordArray[i]])
     else Result := Format('%s::%s',[Result,IntToHex(AWordArray[i],4)]);
   end;
end;

function GetByteArrayAsStr(AByteArray : array of Byte; AHex :Boolean = True) : String;
var i,Count : Integer;
    TempLen : Integer;
begin
  Result := '';
  TempLen := Length(AByteArray);
  if TempLen = 0 then Exit;
  Result := IntToStr(TempLen);
  Count := High(AByteArray);
  for i := Low(AByteArray) to Count do
   begin
    if not AHex then Result := Format('%s::%d',[Result,AByteArray[i]])
     else Result := Format('%s::%s',[Result,IntToHex(AByteArray[i],2)]);
   end;
end;

function IsIntInArray(AIntArray : array of Integer; AValue : Integer): Boolean;
var i,Count : Integer;
begin
  Result := False;
  if Length(AIntArray) = 0 then Exit;
  Count := High(AIntArray);
  for i := Low(AIntArray) to Count do
   begin
    if AIntArray[i] = AValue then
     begin
      Result := True;
      Break;
     end;
   end;
end;

function IsWordInArray(AWordArray : array of Word; AValue : Word): Boolean;
var i,Count : Integer;
begin
  Result := False;
  if Length(AWordArray) = 0 then Exit;
  Count := High(AWordArray);
  for i := Low(AWordArray) to Count do
   begin
    if AWordArray[i] = AValue then
     begin
      Result := True;
      Break;
     end;
   end;
end;

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
  TempByteBuff := Buff;
  for i:=0 to BuffSize-1 do
   if i = 0 then Result:=Format('%s',[IntToHex(TempByteBuff^[i],2)])
     else Result:=Format('%s %s',[Result, IntToHex(TempByteBuff^[i],2)]);
end;

function SerializeByteArray(AData: array of Byte; ADataLen: Word): String;
var i : Integer;
begin
  Result := '';
  if ADataLen = 0 then Exit;
  for i := 0 to ADataLen-1 do
   begin
    if i = 0 then Result:=Format('%s',[IntToHex(AData[i],2)])
     else Result:=Format('%s %s',[Result, IntToHex(AData[i],2)]);
   end;
end;

end.
