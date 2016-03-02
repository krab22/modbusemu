unit DigitalTypes;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils;

const
  csByteBitsString      = '00000000';
  csWordBitsString      = '00000000 00000000';
  csCardinalBitsString  = '00000000 00000000 00000000 00000000';
  csCardinalBitsString1 = '00000000000000000000000000000000';
  csOne                 = '1';

type
  PCardinal = ^TCardinal;
  TCardinal = packed record
   case integer of
       0: (Bytes : array [0..3] of Byte);
       1: (Words : array [0..1] of Word);
       2: (Value : Cardinal);
  end;

  PQWordRec = ^TQWord;
  TQWord = packed record
   case integer of
       0: (Bytes : array [0..7] of Byte);
       1: (Words : array [0..3] of Word);
       2: (Cardinals : array [0..1] of Cardinal);
       3: (Value : QWord);
  end;

  { TCardinalClass }

  TCardinalClass = class
   private
    FCardinal : TCardinal;
    function  GetValue : Cardinal;
    procedure SetValue(const AValue : Cardinal);
    function  GetValueAsString : String;
    procedure SetValueAsString(const AValue : String);
    function  GetValueAsHex : String;
    procedure SetValueAsHex(const AValue : String);
    function  GetValueAsBitsStr : String;
    procedure SetValueAsBitsStr(const AValue : String);
    function  GetValueBit0 : Boolean;
    procedure SetValueBit0(const AValue : Boolean);
    function  GetValueBit1 : Boolean;
    procedure SetValueBit1(const AValue : Boolean);
    function  GetValueBit2 : Boolean;
    procedure SetValueBit2(const AValue : Boolean);
    function  GetValueBit3 : Boolean;
    procedure SetValueBit3(const AValue : Boolean);
    function  GetValueBit4 : Boolean;
    procedure SetValueBit4(const AValue : Boolean);
    function  GetValueBit5 : Boolean;
    procedure SetValueBit5(const AValue : Boolean);
    function  GetValueBit6 : Boolean;
    procedure SetValueBit6(const AValue : Boolean);
    function  GetValueBit7 : Boolean;
    procedure SetValueBit7(const AValue : Boolean);
    function  GetValueBit8 : Boolean;
    procedure SetValueBit8(const AValue : Boolean);
    function  GetValueBit9 : Boolean;
    procedure SetValueBit9(const AValue : Boolean);
    function  GetValueBit10 : Boolean;
    procedure SetValueBit10(const AValue : Boolean);
    function  GetValueBit11 : Boolean;
    procedure SetValueBit11(const AValue : Boolean);
    function  GetValueBit12 : Boolean;
    procedure SetValueBit12(const AValue : Boolean);
    function  GetValueBit13 : Boolean;
    procedure SetValueBit13(const AValue : Boolean);
    function  GetValueBit14 : Boolean;
    procedure SetValueBit14(const AValue : Boolean);
    function  GetValueBit15 : Boolean;
    procedure SetValueBit15(const AValue : Boolean);
    function  GetValueBit16 : Boolean;
    procedure SetValueBit16(const AValue : Boolean);
    function  GetValueBit17 : Boolean;
    procedure SetValueBit17(const AValue : Boolean);
    function  GetValueBit18 : Boolean;
    procedure SetValueBit18(const AValue : Boolean);
    function  GetValueBit19 : Boolean;
    procedure SetValueBit19(const AValue : Boolean);
    function  GetValueBit20 : Boolean;
    procedure SetValueBit20(const AValue : Boolean);
    function  GetValueBit21 : Boolean;
    procedure SetValueBit21(const AValue : Boolean);
    function  GetValueBit22 : Boolean;
    procedure SetValueBit22(const AValue : Boolean);
    function  GetValueBit23 : Boolean;
    procedure SetValueBit23(const AValue : Boolean);
    function  GetValueBit24 : Boolean;
    procedure SetValueBit24(const AValue : Boolean);
    function  GetValueBit25 : Boolean;
    procedure SetValueBit25(const AValue : Boolean);
    function  GetValueBit26 : Boolean;
    procedure SetValueBit26(const AValue : Boolean);
    function  GetValueBit27 : Boolean;
    procedure SetValueBit27(const AValue : Boolean);
    function  GetValueBit28 : Boolean;
    procedure SetValueBit28(const AValue : Boolean);
    function  GetValueBit29 : Boolean;
    procedure SetValueBit29(const AValue : Boolean);
    function  GetValueBit30 : Boolean;
    procedure SetValueBit30(const AValue : Boolean);
    function  GetValueBit31 : Boolean;
    procedure SetValueBit31(const AValue : Boolean);
    function  GetValueByte0 : Byte;
    procedure SetValueByte0(const AValue : Byte);
    function  GetValueByte0Str : String;
    procedure SetValueByte0Str(const AValue : String);
    function  GetValueByte0Hex : String;
    procedure SetValueByte0Hex(const AValue : String);
    function  GetValueByte0StrBits : String;
    procedure SetValueByte0StrBits(const AValue : String);
    function  GetValueByte1 : Byte;
    procedure SetValueByte1(const AValue : Byte);
    function  GetValueByte1Str : String;
    procedure SetValueByte1Str(const AValue : String);
    function  GetValueByte1Hex : String;
    procedure SetValueByte1Hex(const AValue : String);
    function  GetValueByte1StrBits : String;
    procedure SetValueByte1StrBits(const AValue : String);
    function  GetValueByte2 : Byte;
    procedure SetValueByte2(const AValue : Byte);
    function  GetValueByte2Str : String;
    procedure SetValueByte2Str(const AValue : String);
    function  GetValueByte2Hex : String;
    procedure SetValueByte2Hex(const AValue : String);
    function  GetValueByte2StrBits : String;
    procedure SetValueByte2StrBits(const AValue : String);
    function  GetValueByte3 : Byte;
    procedure SetValueByte3(const AValue : Byte);
    function  GetValueByte3Str : String;
    procedure SetValueByte3Str(const AValue : String);
    function  GetValueByte3Hex : String;
    procedure SetValueByte3Hex(const AValue : String);
    function  GetValueByte3StrBits : String;
    procedure SetValueByte3StrBits(const AValue : String);
    function  GetValueWord0 : Word;
    procedure SetValueWord0(const AValue : Word);
    function  GetValueWord0Str : String;
    procedure SetValueWord0Str(const AValue : String);
    function  GetValueWord0Hex : String;
    procedure SetValueWord0Hex(const AValue : String);
    function  GetValueWord0StrBits : String;
    procedure SetValueWord0StrBits(const AValue : String);
    function  GetValueWord1 : Word;
    procedure SetValueWord1(const AValue : Word);
    function  GetValueWord1Str : String;
    procedure SetValueWord1Str(const AValue : String);
    function  GetValueWord1Hex : String;
    procedure SetValueWord1Hex(const AValue : String);
    function  GetValueWord1StrBits : String;
    procedure SetValueWord1StrBits(const AValue : String);
   protected
    property CardinalRec : TCardinal read FCardinal;

    function GetByteBitsStr(AValue : Byte) : String;
    function GetWordBitsStr(AValue : Word) : String;
   public
    constructor Create; virtual;

    property Value             : Cardinal read GetValue write SetValue;
    property ValueAsString     : String   read GetValueAsString write SetValueAsString;
    property ValueAsHex        : String   read GetValueAsHex write SetValueAsHex;
    property ValueAsBitsStr    : String   read GetValueAsBitsStr write SetValueAsBitsStr;
    //
    property ValueBit0         : Boolean read GetValueBit0  write SetValueBit0;
    property ValueBit1         : Boolean read GetValueBit1  write SetValueBit1;
    property ValueBit2         : Boolean read GetValueBit2  write SetValueBit2;
    property ValueBit3         : Boolean read GetValueBit3  write SetValueBit3;
    property ValueBit4         : Boolean read GetValueBit4  write SetValueBit4;
    property ValueBit5         : Boolean read GetValueBit5  write SetValueBit5;
    property ValueBit6         : Boolean read GetValueBit6  write SetValueBit6;
    property ValueBit7         : Boolean read GetValueBit7  write SetValueBit7;
    property ValueBit8         : Boolean read GetValueBit8  write SetValueBit8;
    property ValueBit9         : Boolean read GetValueBit9  write SetValueBit9;
    property ValueBit10        : Boolean read GetValueBit10 write SetValueBit10;
    property ValueBit11        : Boolean read GetValueBit11 write SetValueBit11;
    property ValueBit12        : Boolean read GetValueBit12 write SetValueBit12;
    property ValueBit13        : Boolean read GetValueBit13 write SetValueBit13;
    property ValueBit14        : Boolean read GetValueBit14 write SetValueBit14;
    property ValueBit15        : Boolean read GetValueBit15 write SetValueBit15;
    property ValueBit16        : Boolean read GetValueBit16 write SetValueBit16;
    property ValueBit17        : Boolean read GetValueBit17 write SetValueBit17;
    property ValueBit18        : Boolean read GetValueBit18 write SetValueBit18;
    property ValueBit19        : Boolean read GetValueBit19 write SetValueBit19;
    property ValueBit20        : Boolean read GetValueBit20 write SetValueBit20;
    property ValueBit21        : Boolean read GetValueBit21 write SetValueBit21;
    property ValueBit22        : Boolean read GetValueBit22 write SetValueBit22;
    property ValueBit23        : Boolean read GetValueBit23 write SetValueBit23;
    property ValueBit24        : Boolean read GetValueBit24 write SetValueBit24;
    property ValueBit25        : Boolean read GetValueBit25 write SetValueBit25;
    property ValueBit26        : Boolean read GetValueBit26 write SetValueBit26;
    property ValueBit27        : Boolean read GetValueBit27 write SetValueBit27;
    property ValueBit28        : Boolean read GetValueBit28 write SetValueBit28;
    property ValueBit29        : Boolean read GetValueBit29 write SetValueBit29;
    property ValueBit30        : Boolean read GetValueBit30 write SetValueBit30;
    property ValueBit31        : Boolean read GetValueBit31 write SetValueBit31;
    //
    property ValueByte0        : Byte   read GetValueByte0 write SetValueByte0;
    property ValueByte0Str     : String read GetValueByte0Str write SetValueByte0Str;
    property ValueByte0Hex     : String read GetValueByte0Hex write SetValueByte0Hex;
    property ValueByte0StrBits : String read GetValueByte0StrBits write SetValueByte0StrBits;
    //
    property ValueByte1        : Byte   read GetValueByte1 write SetValueByte1;
    property ValueByte1Str     : String read GetValueByte1Str write SetValueByte1Str;
    property ValueByte1Hex     : String read GetValueByte1Hex write SetValueByte1Hex;
    property ValueByte1StrBits : String read GetValueByte1StrBits write SetValueByte1StrBits;
    //
    property ValueByte2        : Byte   read GetValueByte2 write SetValueByte2;
    property ValueByte2Str     : String read GetValueByte2Str write SetValueByte2Str;
    property ValueByte2Hex     : String read GetValueByte2Hex write SetValueByte2Hex;
    property ValueByte2StrBits : String read GetValueByte2StrBits write SetValueByte2StrBits;
    //
    property ValueByte3        : Byte   read GetValueByte3 write SetValueByte3;
    property ValueByte3Str     : String read GetValueByte3Str write SetValueByte3Str;
    property ValueByte3Hex     : String read GetValueByte3Hex write SetValueByte3Hex;
    property ValueByte3StrBits : String read GetValueByte3StrBits write SetValueByte3StrBits;
    //
    property ValueWord0        : Word   read GetValueWord0 write SetValueWord0;
    property ValueWord0Str     : String read GetValueWord0Str write SetValueWord0Str;
    property ValueWord0Hex     : String read GetValueWord0Hex write SetValueWord0Hex;
    property ValueWord0StrBits : String read GetValueWord0StrBits write SetValueWord0StrBits;
    //
    property ValueWord1        : Word   read GetValueWord1 write SetValueWord1;
    property ValueWord1Str     : String read GetValueWord1Str write SetValueWord1Str;
    property ValueWord1Hex     : String read GetValueWord1Hex write SetValueWord1Hex;
    property ValueWord1StrBits : String read GetValueWord1StrBits write SetValueWord1StrBits;
  end;

implementation

{ TCardinalClass }

constructor TCardinalClass.Create;
begin
  FCardinal.Value := 0;
end;

function TCardinalClass.GetValue : Cardinal;
begin
  Result := FCardinal.Value;
end;

function TCardinalClass.GetValueAsBitsStr : String;
begin
  Result := csCardinalBitsString;
  if (FCardinal.Value and $00000001) = $00000001 then Result[35] := csOne;
  if (FCardinal.Value and $00000002) = $00000002 then Result[34] := csOne;
  if (FCardinal.Value and $00000004) = $00000004 then Result[33] := csOne;
  if (FCardinal.Value and $00000008) = $00000008 then Result[32] := csOne;
  if (FCardinal.Value and $00000010) = $00000010 then Result[31] := csOne;
  if (FCardinal.Value and $00000020) = $00000020 then Result[30] := csOne;
  if (FCardinal.Value and $00000040) = $00000040 then Result[29] := csOne;
  if (FCardinal.Value and $00000080) = $00000080 then Result[28] := csOne;
                                                        //27
  if (FCardinal.Value and $00000100) = $00000100 then Result[26] := csOne;
  if (FCardinal.Value and $00000200) = $00000200 then Result[25] := csOne;
  if (FCardinal.Value and $00000400) = $00000400 then Result[24] := csOne;
  if (FCardinal.Value and $00000800) = $00000800 then Result[23] := csOne;
  if (FCardinal.Value and $00001000) = $00001000 then Result[22] := csOne;
  if (FCardinal.Value and $00002000) = $00002000 then Result[21] := csOne;
  if (FCardinal.Value and $00004000) = $00004000 then Result[20] := csOne;
  if (FCardinal.Value and $00008000) = $00008000 then Result[19] := csOne;
                                                        //18
  if (FCardinal.Value and $00010000) = $00010000 then Result[17] := csOne;
  if (FCardinal.Value and $00020000) = $00020000 then Result[16] := csOne;
  if (FCardinal.Value and $00040000) = $00040000 then Result[15] := csOne;
  if (FCardinal.Value and $00080000) = $00080000 then Result[14] := csOne;
  if (FCardinal.Value and $00100000) = $00100000 then Result[13] := csOne;
  if (FCardinal.Value and $00200000) = $00200000 then Result[12] := csOne;
  if (FCardinal.Value and $00400000) = $00400000 then Result[11] := csOne;
  if (FCardinal.Value and $00800000) = $00800000 then Result[10]  := csOne;
                                                        //9
  if (FCardinal.Value and $01000000) = $01000000 then Result[8]  := csOne;
  if (FCardinal.Value and $02000000) = $02000000 then Result[7]  := csOne;
  if (FCardinal.Value and $04000000) = $04000000 then Result[6]  := csOne;
  if (FCardinal.Value and $08000000) = $08000000 then Result[5]  := csOne;
  if (FCardinal.Value and $10000000) = $10000000 then Result[4]  := csOne;
  if (FCardinal.Value and $20000000) = $20000000 then Result[3]  := csOne;
  if (FCardinal.Value and $40000000) = $40000000 then Result[2]  := csOne;
  if (FCardinal.Value and $80000000) = $80000000 then Result[1]  := csOne;
end;

function TCardinalClass.GetValueAsHex : String;
begin
  Result := IntToHex(FCardinal.Value,8);
end;

function TCardinalClass.GetValueAsString : String;
begin
  Result := IntToStr(FCardinal.Value);
end;

function TCardinalClass.GetValueBit0 : Boolean;
begin
  Result := (FCardinal.Value and $00000001) = $00000001;
end;

function TCardinalClass.GetValueBit1 : Boolean;
begin
  Result := (FCardinal.Value and $00000002) = $00000002;
end;

function TCardinalClass.GetValueBit2 : Boolean;
begin
  Result := (FCardinal.Value and $00000004) = $00000004;
end;

function TCardinalClass.GetValueBit3 : Boolean;
begin
  Result := (FCardinal.Value and $00000008) = $00000008;
end;

function TCardinalClass.GetValueBit4 : Boolean;
begin
  Result := (FCardinal.Value and $00000010) = $00000010;
end;

function TCardinalClass.GetValueBit5 : Boolean;
begin
  Result := (FCardinal.Value and $00000020) = $00000020;
end;

function TCardinalClass.GetValueBit6 : Boolean;
begin
  Result := (FCardinal.Value and $00000040) = $00000040;
end;

function TCardinalClass.GetValueBit7 : Boolean;
begin
  Result := (FCardinal.Value and $00000080) = $00000080;
end;

function TCardinalClass.GetValueBit8 : Boolean;
begin
  Result := (FCardinal.Value and $00000100) = $00000100;
end;

function TCardinalClass.GetValueBit9 : Boolean;
begin
  Result := (FCardinal.Value and $00000200) = $00000200;
end;

function TCardinalClass.GetValueBit10 : Boolean;
begin
  Result := (FCardinal.Value and $00000400) = $00000400;
end;

function TCardinalClass.GetValueBit11 : Boolean;
begin
  Result := (FCardinal.Value and $00000800) = $00000800;
end;

function TCardinalClass.GetValueBit12 : Boolean;
begin
  Result := (FCardinal.Value and $00001000) = $00001000;
end;

function TCardinalClass.GetValueBit13 : Boolean;
begin
  Result := (FCardinal.Value and $00002000) = $00002000;
end;

function TCardinalClass.GetValueBit14 : Boolean;
begin
  Result := (FCardinal.Value and $00004000) = $00004000;
end;

function TCardinalClass.GetValueBit15 : Boolean;
begin
  Result := (FCardinal.Value and $00008000) = $00008000;
end;

function TCardinalClass.GetValueBit16 : Boolean;
begin
  Result := (FCardinal.Value and $00010000) = $00010000;
end;

function TCardinalClass.GetValueBit17 : Boolean;
begin
  Result := (FCardinal.Value and $00020000) = $00020000;
end;

function TCardinalClass.GetValueBit18 : Boolean;
begin
  Result := (FCardinal.Value and $00040000) = $00040000;
end;

function TCardinalClass.GetValueBit19 : Boolean;
begin
  Result := (FCardinal.Value and $00080000) = $00080000;
end;

function TCardinalClass.GetValueBit20 : Boolean;
begin
  Result := (FCardinal.Value and $00100000) = $00100000;
end;

function TCardinalClass.GetValueBit21 : Boolean;
begin
  Result := (FCardinal.Value and $00200000) = $00200000;
end;

function TCardinalClass.GetValueBit22 : Boolean;
begin
  Result := (FCardinal.Value and $00400000) = $00400000;
end;

function TCardinalClass.GetValueBit23 : Boolean;
begin
  Result := (FCardinal.Value and $00800000) = $00800000;
end;

function TCardinalClass.GetValueBit24 : Boolean;
begin
  Result := (FCardinal.Value and $01000000) = $01000000;
end;

function TCardinalClass.GetValueBit25 : Boolean;
begin
  Result := (FCardinal.Value and $02000000) = $02000000;
end;

function TCardinalClass.GetValueBit26 : Boolean;
begin
  Result := (FCardinal.Value and $04000000) = $04000000;
end;

function TCardinalClass.GetValueBit27 : Boolean;
begin
  Result := (FCardinal.Value and $08000000) = $08000000;
end;

function TCardinalClass.GetValueBit28 : Boolean;
begin
  Result := (FCardinal.Value and $10000000) = $10000000;
end;

function TCardinalClass.GetValueBit29 : Boolean;
begin
  Result := (FCardinal.Value and $20000000) = $20000000;
end;

function TCardinalClass.GetValueBit30 : Boolean;
begin
  Result := (FCardinal.Value and $40000000) = $40000000;
end;

function TCardinalClass.GetValueBit31 : Boolean;
begin
  Result := (FCardinal.Value and $80000000) = $80000000;
end;

function TCardinalClass.GetValueByte0 : Byte;
begin
  Result := FCardinal.Bytes[0];
end;

function TCardinalClass.GetValueByte0Hex : String;
begin
  Result := IntToHex(FCardinal.Bytes[0],2);
end;

function TCardinalClass.GetValueByte0Str : String;
begin
  Result := IntToStr(FCardinal.Bytes[0]);
end;

function TCardinalClass.GetValueByte0StrBits : String;
begin
  Result := GetByteBitsStr(FCardinal.Bytes[0]);
end;

function TCardinalClass.GetValueByte1 : Byte;
begin
  Result := FCardinal.Bytes[1];
end;

function TCardinalClass.GetValueByte1Hex : String;
begin
  Result := IntToHex(FCardinal.Bytes[1],2);
end;

function TCardinalClass.GetValueByte1Str : String;
begin
  Result := IntToStr(FCardinal.Bytes[1]);
end;

function TCardinalClass.GetValueByte1StrBits : String;
begin
  Result := GetByteBitsStr(FCardinal.Bytes[1]);
end;

function TCardinalClass.GetValueByte2 : Byte;
begin
  Result := FCardinal.Bytes[2];
end;

function TCardinalClass.GetValueByte2Hex : String;
begin
  Result := IntToHex(FCardinal.Bytes[2],2);
end;

function TCardinalClass.GetValueByte2Str : String;
begin
  Result := IntToStr(FCardinal.Bytes[2]);
end;

function TCardinalClass.GetValueByte2StrBits : String;
begin
  Result := GetByteBitsStr(FCardinal.Bytes[2]);
end;

function TCardinalClass.GetValueByte3 : Byte;
begin
  Result := FCardinal.Bytes[3];
end;

function TCardinalClass.GetValueByte3Hex : String;
begin
  Result := IntToHex(FCardinal.Bytes[3],2);
end;

function TCardinalClass.GetValueByte3Str : String;
begin
  Result := IntToStr(FCardinal.Bytes[3]);
end;

function TCardinalClass.GetValueByte3StrBits : String;
begin
  Result := GetByteBitsStr(FCardinal.Bytes[3]);
end;

function TCardinalClass.GetValueWord0 : Word;
begin
  Result := FCardinal.Words[0];
end;

function TCardinalClass.GetValueWord0Hex : String;
begin
  Result := IntToHex(FCardinal.Words[0],4);
end;

function TCardinalClass.GetValueWord0Str : String;
begin
  Result := IntToStr(FCardinal.Words[0]);
end;

function TCardinalClass.GetValueWord0StrBits : String;
begin
  Result := GetWordBitsStr(FCardinal.Words[0]);
end;

function TCardinalClass.GetValueWord1 : Word;
begin
  Result := FCardinal.Words[1];
end;

function TCardinalClass.GetValueWord1Hex : String;
begin
  Result := IntToHex(FCardinal.Words[1],4);
end;

function TCardinalClass.GetValueWord1Str : String;
begin
  Result := IntToStr(FCardinal.Words[1]);
end;

function TCardinalClass.GetValueWord1StrBits : String;
begin
  Result := GetWordBitsStr(FCardinal.Words[1]);
end;

procedure TCardinalClass.SetValue(const AValue : Cardinal);
begin
  FCardinal.Value := AValue;
end;

procedure TCardinalClass.SetValueAsBitsStr(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 32 then Count := 1 else Count := TempLen - 32;
  ii := 31;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     31 : ValueBit0  := TempChar = csOne;
     30 : ValueBit1  := TempChar = csOne;
     29 : ValueBit2  := TempChar = csOne;
     28 : ValueBit3  := TempChar = csOne;
     27 : ValueBit4  := TempChar = csOne;
     26 : ValueBit5  := TempChar = csOne;
     25 : ValueBit6  := TempChar = csOne;
     24 : ValueBit7  := TempChar = csOne;
     23 : ValueBit8  := TempChar = csOne;
     22 : ValueBit9  := TempChar = csOne;
     21 : ValueBit10 := TempChar = csOne;
     20 : ValueBit11 := TempChar = csOne;
     19 : ValueBit12 := TempChar = csOne;
     18 : ValueBit13 := TempChar = csOne;
     17 : ValueBit14 := TempChar = csOne;
     16 : ValueBit15 := TempChar = csOne;
     15 : ValueBit16 := TempChar = csOne;
     14 : ValueBit17 := TempChar = csOne;
     13 : ValueBit18 := TempChar = csOne;
     12 : ValueBit19 := TempChar = csOne;
     11 : ValueBit20 := TempChar = csOne;
     10 : ValueBit21 := TempChar = csOne;
     9  : ValueBit22 := TempChar = csOne;
     8  : ValueBit23 := TempChar = csOne;
     7  : ValueBit24 := TempChar = csOne;
     6  : ValueBit25 := TempChar = csOne;
     5  : ValueBit26 := TempChar = csOne;
     4  : ValueBit27 := TempChar = csOne;
     3  : ValueBit28 := TempChar = csOne;
     2  : ValueBit29 := TempChar = csOne;
     1  : ValueBit30 := TempChar = csOne;
     0  : ValueBit31 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueAsHex(const AValue : String);
var TempVal : Int64;
begin
  TempVal := StrToInt64(Format('$%s',[AValue]));
  FCardinal.Value := Cardinal(TempVal);
end;

procedure TCardinalClass.SetValueAsString(const AValue : String);
var TempVal : Int64;
begin
  TempVal := StrToInt64(AValue);
  FCardinal.Value := Cardinal(TempVal);
end;

procedure TCardinalClass.SetValueBit0(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000001
   else FCardinal.Value := FCardinal.Value and $FFFFFFFE;
end;

procedure TCardinalClass.SetValueBit1(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000002
   else FCardinal.Value := FCardinal.Value and $FFFFFFFD;
end;

procedure TCardinalClass.SetValueBit2(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000004
   else FCardinal.Value := FCardinal.Value and $FFFFFFFB;
end;

procedure TCardinalClass.SetValueBit3(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000008
   else FCardinal.Value := FCardinal.Value and $FFFFFFF7;
end;

procedure TCardinalClass.SetValueBit4(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000010
   else FCardinal.Value := FCardinal.Value and $FFFFFFEF;
end;

procedure TCardinalClass.SetValueBit5(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000020
   else FCardinal.Value := FCardinal.Value and $FFFFFFDF;
end;

procedure TCardinalClass.SetValueBit6(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000040
   else FCardinal.Value := FCardinal.Value and $FFFFFFBF;
end;

procedure TCardinalClass.SetValueBit7(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000080
   else FCardinal.Value := FCardinal.Value and $FFFFFF7F;
end;

procedure TCardinalClass.SetValueBit8(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000100
   else FCardinal.Value := FCardinal.Value and $FFFFFEFF;
end;

procedure TCardinalClass.SetValueBit9(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000200
   else FCardinal.Value := FCardinal.Value and $FFFFFDFF;
end;

procedure TCardinalClass.SetValueBit10(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000400
   else FCardinal.Value := FCardinal.Value and $FFFFFBFF;
end;

procedure TCardinalClass.SetValueBit11(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00000800
   else FCardinal.Value := FCardinal.Value and $FFFFF7FF;
end;

procedure TCardinalClass.SetValueBit12(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00001000
   else FCardinal.Value := FCardinal.Value and $FFFFEFFF;
end;

procedure TCardinalClass.SetValueBit13(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00002000
   else FCardinal.Value := FCardinal.Value and $FFFFDFFF;
end;

procedure TCardinalClass.SetValueBit14(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00004000
   else FCardinal.Value := FCardinal.Value and $FFFFBFFF;
end;

procedure TCardinalClass.SetValueBit15(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00008000
   else FCardinal.Value := FCardinal.Value and $FFFF7FFF;
end;

procedure TCardinalClass.SetValueBit16(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00010000
   else FCardinal.Value := FCardinal.Value and $FFFEFFFF;
end;

procedure TCardinalClass.SetValueBit17(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00020000
   else FCardinal.Value := FCardinal.Value and $FFFDFFFF;
end;

procedure TCardinalClass.SetValueBit18(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00040000
   else FCardinal.Value := FCardinal.Value and $FFFBFFFF;
end;

procedure TCardinalClass.SetValueBit19(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00080000
   else FCardinal.Value := FCardinal.Value and $FFF7FFFF;
end;

procedure TCardinalClass.SetValueBit20(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00100000
   else FCardinal.Value := FCardinal.Value and $FFEFFFFF;
end;

procedure TCardinalClass.SetValueBit21(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00200000
   else FCardinal.Value := FCardinal.Value and $FFDFFFFF;
end;

procedure TCardinalClass.SetValueBit22(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00400000
   else FCardinal.Value := FCardinal.Value and $FFBFFFFF;
end;

procedure TCardinalClass.SetValueBit23(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $00800000
   else FCardinal.Value := FCardinal.Value and $FF7FFFFF;
end;

procedure TCardinalClass.SetValueBit24(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $01000000
   else FCardinal.Value := FCardinal.Value and $FEFFFFFF;
end;

procedure TCardinalClass.SetValueBit25(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $02000000
   else FCardinal.Value := FCardinal.Value and $FDFFFFFF;
end;

procedure TCardinalClass.SetValueBit26(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $04000000
   else FCardinal.Value := FCardinal.Value and $FBFFFFFF;
end;

procedure TCardinalClass.SetValueBit27(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $08000000
   else FCardinal.Value := FCardinal.Value and $F7FFFFFF;
end;

procedure TCardinalClass.SetValueBit28(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $10000000
   else FCardinal.Value := FCardinal.Value and $EFFFFFFF;
end;

procedure TCardinalClass.SetValueBit29(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $20000000
   else FCardinal.Value := FCardinal.Value and $DFFFFFFF;
end;

procedure TCardinalClass.SetValueBit30(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $40000000
   else FCardinal.Value := FCardinal.Value and $BFFFFFFF;
end;

procedure TCardinalClass.SetValueBit31(const AValue : Boolean);
begin
  if AValue then FCardinal.Value := FCardinal.Value or $80000000
   else FCardinal.Value := FCardinal.Value and $7FFFFFFF;
end;

procedure TCardinalClass.SetValueByte0(const AValue : Byte);
begin
  FCardinal.Bytes[0] := AValue;
end;

procedure TCardinalClass.SetValueByte0Hex(const AValue : String);
begin
  FCardinal.Bytes[0] := Byte(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueByte0Str(const AValue : String);
begin
  FCardinal.Bytes[0] := Byte(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueByte0StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 8 then Count := 1 else Count := TempLen - 8;
  ii := 7;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     7  : ValueBit0 := TempChar = csOne;
     6  : ValueBit1 := TempChar = csOne;
     5  : ValueBit2 := TempChar = csOne;
     4  : ValueBit3 := TempChar = csOne;
     3  : ValueBit4 := TempChar = csOne;
     2  : ValueBit5 := TempChar = csOne;
     1  : ValueBit6 := TempChar = csOne;
     0  : ValueBit7 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueByte1(const AValue : Byte);
begin
  FCardinal.Bytes[1] := AValue;
end;

procedure TCardinalClass.SetValueByte1Hex(const AValue : String);
begin
  FCardinal.Bytes[1] := Byte(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueByte1Str(const AValue : String);
begin
  FCardinal.Bytes[1] := Byte(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueByte1StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 8 then Count := 1 else Count := TempLen - 8;
  ii := 7;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     7  : ValueBit8  := TempChar = csOne;
     6  : ValueBit9  := TempChar = csOne;
     5  : ValueBit10 := TempChar = csOne;
     4  : ValueBit11 := TempChar = csOne;
     3  : ValueBit12 := TempChar = csOne;
     2  : ValueBit13 := TempChar = csOne;
     1  : ValueBit14 := TempChar = csOne;
     0  : ValueBit15 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueByte2(const AValue : Byte);
begin
  FCardinal.Bytes[2] := AValue;
end;

procedure TCardinalClass.SetValueByte2Hex(const AValue : String);
begin
  FCardinal.Bytes[2] := Byte(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueByte2Str(const AValue : String);
begin
  FCardinal.Bytes[2] := Byte(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueByte2StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 8 then Count := 1 else Count := TempLen - 8;
  ii := 7;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     7  : ValueBit16 := TempChar = csOne;
     6  : ValueBit17 := TempChar = csOne;
     5  : ValueBit18 := TempChar = csOne;
     4  : ValueBit19 := TempChar = csOne;
     3  : ValueBit20 := TempChar = csOne;
     2  : ValueBit21 := TempChar = csOne;
     1  : ValueBit22 := TempChar = csOne;
     0  : ValueBit23 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueByte3(const AValue : Byte);
begin
  FCardinal.Bytes[3] := AValue;
end;

procedure TCardinalClass.SetValueByte3Hex(const AValue : String);
begin
  FCardinal.Bytes[3] := Byte(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueByte3Str(const AValue : String);
begin
  FCardinal.Bytes[3] := Byte(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueByte3StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 8 then Count := 1 else Count := TempLen - 8;
  ii := 7;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     7  : ValueBit24 := TempChar = csOne;
     6  : ValueBit25 := TempChar = csOne;
     5  : ValueBit26 := TempChar = csOne;
     4  : ValueBit27 := TempChar = csOne;
     3  : ValueBit28 := TempChar = csOne;
     2  : ValueBit29 := TempChar = csOne;
     1  : ValueBit30 := TempChar = csOne;
     0  : ValueBit31 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueWord0(const AValue : Word);
begin
  FCardinal.Words[0] := AValue;
end;

procedure TCardinalClass.SetValueWord0Hex(const AValue : String);
begin
  FCardinal.Words[0] := Word(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueWord0Str(const AValue : String);
begin
  FCardinal.Words[0] := Word(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueWord0StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 16 then Count := 1 else Count := TempLen - 16;
  ii := 15;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     15  : ValueBit0  := TempChar = csOne;
     14  : ValueBit1  := TempChar = csOne;
     13  : ValueBit2  := TempChar = csOne;
     12  : ValueBit3  := TempChar = csOne;
     11  : ValueBit4  := TempChar = csOne;
     10  : ValueBit5  := TempChar = csOne;
     9   : ValueBit6  := TempChar = csOne;
     8   : ValueBit7  := TempChar = csOne;
     7   : ValueBit8  := TempChar = csOne;
     6   : ValueBit9  := TempChar = csOne;
     5   : ValueBit10 := TempChar = csOne;
     4   : ValueBit11 := TempChar = csOne;
     3   : ValueBit12 := TempChar = csOne;
     2   : ValueBit13 := TempChar = csOne;
     1   : ValueBit14 := TempChar = csOne;
     0   : ValueBit15 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

procedure TCardinalClass.SetValueWord1(const AValue : Word);
begin
  FCardinal.Words[1] := AValue;
end;

procedure TCardinalClass.SetValueWord1Hex(const AValue : String);
begin
  FCardinal.Words[1] := Word(StrToInt(Format('$%s',[AValue])));
end;

procedure TCardinalClass.SetValueWord1Str(const AValue : String);
begin
  FCardinal.Words[1] := Word(StrToInt(AValue));
end;

procedure TCardinalClass.SetValueWord1StrBits(const AValue : String);
var TempStr     : String;
    TempLen     : Integer;
    ii,i,Count  : Integer;
    TempChar    : String;
begin
  TempStr := StringReplace(AValue,' ', '', [rfIgnoreCase,rfReplaceAll]);
  TempLen := Length(TempStr);
  if TempLen > 16 then Count := 1 else Count := TempLen - 16;
  ii := 15;
  for i := TempLen downto Count do
   begin
    TempChar := TempStr[i];
    case ii of
     15  : ValueBit16 := TempChar = csOne;
     14  : ValueBit17 := TempChar = csOne;
     13  : ValueBit18 := TempChar = csOne;
     12  : ValueBit19 := TempChar = csOne;
     11  : ValueBit20 := TempChar = csOne;
     10  : ValueBit21 := TempChar = csOne;
     9   : ValueBit22 := TempChar = csOne;
     8   : ValueBit23 := TempChar = csOne;
     7   : ValueBit24 := TempChar = csOne;
     6   : ValueBit25 := TempChar = csOne;
     5   : ValueBit26 := TempChar = csOne;
     4   : ValueBit27 := TempChar = csOne;
     3   : ValueBit28 := TempChar = csOne;
     2   : ValueBit29 := TempChar = csOne;
     1   : ValueBit30 := TempChar = csOne;
     0   : ValueBit31 := TempChar = csOne;
    end;
    Dec(ii);
   end;
end;

function TCardinalClass.GetByteBitsStr(AValue : Byte) : String;
begin
  Result := csByteBitsString;
  if (AValue and $01) = $01 then Result[8]  := csOne;
  if (AValue and $02) = $02 then Result[7]  := csOne;
  if (AValue and $04) = $04 then Result[6]  := csOne;
  if (AValue and $08) = $08 then Result[5]  := csOne;
  if (AValue and $10) = $10 then Result[4]  := csOne;
  if (AValue and $20) = $20 then Result[3]  := csOne;
  if (AValue and $40) = $40 then Result[2]  := csOne;
  if (AValue and $80) = $80 then Result[1]  := csOne;
end;

function TCardinalClass.GetWordBitsStr(AValue : Word) : String;
begin
  Result := csWordBitsString;
  if (AValue and $0001) = $0001 then Result[17] := csOne;
  if (AValue and $0002) = $0002 then Result[16] := csOne;
  if (AValue and $0004) = $0004 then Result[15] := csOne;
  if (AValue and $0008) = $0008 then Result[14] := csOne;
  if (AValue and $0010) = $0010 then Result[13] := csOne;
  if (AValue and $0020) = $0020 then Result[12] := csOne;
  if (AValue and $0040) = $0040 then Result[11] := csOne;
  if (AValue and $0080) = $0080 then Result[10] := csOne;
                                                              //9
  if (AValue and $0100) = $0100 then Result[8]  := csOne;
  if (AValue and $0200) = $0200 then Result[7]  := csOne;
  if (AValue and $0400) = $0400 then Result[6]  := csOne;
  if (AValue and $0800) = $0800 then Result[5]  := csOne;
  if (AValue and $1000) = $1000 then Result[4]  := csOne;
  if (AValue and $2000) = $2000 then Result[3]  := csOne;
  if (AValue and $4000) = $4000 then Result[2]  := csOne;
  if (AValue and $8000) = $8000 then Result[1]  := csOne;
end;

end.

