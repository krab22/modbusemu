unit MyFormat;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, sysconst;

Const
  feInvalidFormat   = 1;
  feMissingArgument = 2;
  feInvalidArgIndex = 3;

var
  MyDefaultFormatSettings : TFormatSettings = (
    CurrencyFormat: 1;
    NegCurrFormat: 5;
    ThousandSeparator: ',';
    DecimalSeparator: '.';
    CurrencyDecimals: 2;
    DateSeparator: '-';
    TimeSeparator: ':';
    ListSeparator: ',';
    CurrencyString: '$';
    ShortDateFormat: 'd.m.y';
    LongDateFormat: 'dd" "mm" "yyyy';
    TimeAMString: 'AM';
    TimePMString: 'PM';
    ShortTimeFormat: 'hh:nn';
    LongTimeFormat: 'hh:nn:ss';
    ShortMonthNames: ('Jan','Feb','Mar','Apr','May','Jun',
                      'Jul','Aug','Sep','Oct','Nov','Dec');
    LongMonthNames: ('January','February','March','April','May','June',
                     'July','August','September','October','November','December');
    ShortDayNames: ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
    LongDayNames:  ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
    TwoDigitYearCenturyWindow: 50;
  );

function MyFormat (Const Fmt : AnsiString; const Args : Array of const; const FormatSettings: TFormatSettings) : AnsiString;
function MyFormat (Const Fmt : AnsiString; const Args : Array of const) : AnsiString;

procedure ReadInteger(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                      var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt);
procedure ReadIndex(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                    var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt);
procedure ReadLeft(const AFmt : AnsiString; var AChPos : SizeInt; var ALeft : Boolean);
procedure ReadWidth(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                        var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt; var AWidth : LongInt);
procedure ReadPrec(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                        var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt; var APrec : LongInt);
function ReadFormat(const AFmt : AnsiString; const AArgs : Array of const;
                    var AOldPos,AChPos,AArgpos,ALen,AIndex : SizeInt;
                    var AWidth,APrec : LongInt; var ALeft : Boolean) : Char;
function Checkarg (const AFmt : AnsiString; var ADoArg,AArgPos,AIndex : SizeInt;
                   const AArgs : Array of const; AT : SizeInt; Err:boolean):boolean;

procedure DoFormatError (ErrCode : Longint;const fmt:ansistring);

implementation

function MyFormat (Const Fmt : AnsiString; const Args : Array of const; const FormatSettings: TFormatSettings) : AnsiString;
var ChPos,OldPos,
    ArgPos,DoArg,
    Len,Index     : SizeInt;
    Hs,ToAdd      : AnsiString;
    Width,Prec    : Longint;
    Left          : Boolean;
    Fchar         : Char;
    Vq            : QWord;
begin
  Result := '';
  Len    := Length(Fmt);
  ChPos  := 1;
  OldPos := 1;
  ArgPos := 0;
  While ChPos <= Len do
   begin
    // пробегаем до первого знака %
    While (ChPos <= Len) and (Fmt[ChPos] <> '%') do inc(ChPos);
    // копируем пройденный кусок в результат
    If ChPos > OldPos Then Result := Result + Copy(Fmt, OldPos, ChPos-OldPos);
    // не конец строки?
    If ChPos < Len then
     begin
      // читаем формат
      FChar := ReadFormat(Fmt,Args,OldPos,ChPos,ArgPos,Len,Index,Width,Prec,Left);

      case FChar of
        'D' : begin
               //записываем числовое значение в строку
               if Checkarg(Fmt,DoArg,ArgPos,Index,Args,vtinteger,false) then  Str(Args[DoArg].VInteger,ToAdd)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtInt64,false) then  Str(Args[DoArg].VInt64^,ToAdd)
                  else
                   if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtQWord,true) then Str(int64(Args[DoArg].VQWord^),ToAdd);

               Width := Abs(Width);
               Index := Prec-Length(ToAdd);
               // вставляем знак
               If ToAdd[1] <> '-' then ToAdd := StringOfChar('0',Index) + ToAdd
                else Insert(StringOfChar('0',Index + 1),toadd,2);// + 1 to accomodate for - sign in length !!
              end;
        'U' : begin
               if Checkarg(Fmt,DoArg,ArgPos,Index,Args,vtinteger,false) then Str(cardinal(Args[Doarg].VInteger),ToAdd)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtInt64,false) then  Str(qword(Args[DoArg].VInt64^),toadd)
                  else
                   if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtQWord,true) then Str(Args[DoArg].VQWord^,toadd);

               Width := Abs(width);
               Index := Prec - Length(ToAdd);
               ToAdd := StringOfChar('0',Index) + ToAdd
              end;
        {$ifndef FPUNONE}
        'E' : begin
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtCurrency,false) then  ToAdd:=FloatToStrF(Args[doarg].VCurrency^,ffexponent,Prec,3,FormatSettings)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtExtended,true) then ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffexponent,Prec,3,FormatSettings);
              end;
        'F' : begin
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtCurrency,false) then  ToAdd:=FloatToStrF(Args[doarg].VCurrency^,ffFixed,9999,Prec,FormatSettings)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtExtended,true) then ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffFixed,9999,Prec,FormatSettings);
              end;
        'G' : begin
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtCurrency,false) then  ToAdd:=FloatToStrF(Args[doarg].VCurrency^,ffGeneral,Prec,3,FormatSettings)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtExtended,true) then ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffGeneral,Prec,3,FormatSettings);
              end;
        'N' : begin
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtCurrency,false) then  ToAdd:=FloatToStrF(Args[doarg].VCurrency^,ffNumber,9999,Prec,FormatSettings)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtExtended,true) then ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffNumber,9999,Prec,FormatSettings);
              end;
        'M' : begin
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtExtended,false) then  ToAdd:=FloatToStrF(Args[doarg].VExtended^,ffCurrency,9999,Prec,FormatSettings)
                else
                 if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtCurrency,true) then ToAdd:=FloatToStrF(Args[doarg].VCurrency^,ffCurrency,9999,Prec,FormatSettings);
              end;
        {$else}
        'E','F','G','N','M':
              RunError(207);
        {$endif}
        'S' : begin
                if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtString,false) then hs := Args[doarg].VString^
                 else
                  if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtChar,false) then  hs := Args[doarg].VChar
                   else
                    if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtPChar,false) then hs := Args[doarg].VPChar
                     else
                      if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtPWideChar,false) then hs := WideString(Args[doarg].VPWideChar)
                       else
                        if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtWideChar,false) then hs := WideString(Args[doarg].VWideChar)
                         else
                          if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtWidestring,false) then hs := WideString(Args[doarg].VWideString)
                           else
                            if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtAnsiString,false) then hs := ansistring(Args[doarg].VAnsiString)
                             else
                              if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtUnicodeString,false) then hs := UnicodeString(Args[doarg].VUnicodeString)
                               else
                                if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtVariant,true) then hs := Args[doarg].VVariant^;

                Index := Length(hs);

                If (Prec <> -1) and (Index > Prec) then Index := Prec;

                ToAdd := Copy(hs,1,Index);
              end;
        'P' : Begin
               CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtpointer,true);
               ToAdd := HexStr(PtrUInt(Args[DoArg].VPointer), SizeOf(Ptruint)*2);
              end;
        'X' : begin
              if Checkarg(Fmt,DoArg,ArgPos,Index,Args,vtinteger,false) then
               begin
                Vq    := Cardinal(Args[Doarg].VInteger);
                Index := 16;
               end
              else
               if CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtQWord, false) then
                begin
                 Vq    := Qword(Args[DoArg].VQWord^);
                 Index := 31;
                end
               else
                begin
                 CheckArg(Fmt,DoArg,ArgPos,Index,Args,vtInt64,true);
                 Vq    := Qword(Args[DoArg].VInt64^);
                 Index := 31;
                end;
               If Prec > Index then ToAdd := HexStr(Int64(Vq),Index)
                else
                 begin
                  // determine minimum needed number of hex digits.
                  Index := 1;

                  While (QWord(1) shl (Index * 4) <= Vq) and (Index < 16) do Inc(Index);

                  If Index > Prec then Prec := Index;
                  ToAdd := HexStr(int64(Vq),Prec);
                  end;
              end;
        '%': ToAdd:='%';
      end;

      if Width <> -1 then
        if Length(ToAdd) < Width then
          if not Left then ToAdd := Space(Width - Length(ToAdd)) + ToAdd
           else ToAdd := ToAdd + Space(Width - Length(ToAdd));

       Result := Result + ToAdd;
     end;

    Inc(ChPos);
    OldPos := ChPos;
   end;
end;

procedure ReadInteger(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                      var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt);
var Code: Word;
    ArgN: SizeInt;
begin
  If AValue <> -1 then Exit; // Was already read.
  AOldPos := AChPos;

  While (AChPos <= ALen) and (AFmt[AChPos] <= '9') and (AFmt[AChPos] >= '0') do inc(AChPos);

  If AChPos > ALen then DoFormatError(feInvalidFormat,AFmt);

  If AFmt[AChPos] = '*' then
    begin
     if AIndex = -1 then ArgN := AArgpos
     else
      begin
        ArgN := AIndex;
        Inc(AIndex);
      end;

     If (AChPos > AOldPos) or (ArgN > High(AArgs)) then DoFormatError(feInvalidFormat,AFmt);

     AArgPos := ArgN + 1;

     case AArgs[ArgN].Vtype of
       vtInteger : AValue := AArgs[ArgN].VInteger;
       vtInt64   : AValue := AArgs[ArgN].VInt64^;
       vtQWord   : AValue := AArgs[ArgN].VQWord^;
     else
       DoFormatError(feInvalidFormat,AFmt);
     end;
     Inc(AChPos);
    end
  else
    begin
     If (AOldPos < AChPos) Then
      begin
       Val (Copy(AFmt,AOldPos,AChPos-AOldPos), AValue, Code);
       // This should never happen !!
       If Code > 0 then DoFormatError (feInvalidFormat,AFmt);
      end
     else AValue := -1;
    end;
end;

procedure ReadIndex(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                    var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt);
begin
  If AFmt[AChPos] <> ':' then ReadInteger(AFmt,AArgs,AValue,AOldPos,AChPos,AArgpos,AIndex,ALen)
   else AValue := 0; // Delphi undocumented behaviour, assume 0, #11099
  If AFmt[AChPos] = ':' then
    begin
     If AValue = -1 then DoFormatError(feMissingArgument,AFmt);
     AIndex := AValue;
     AValue := -1;
     Inc(AChPos);
    end;
end;

procedure ReadLeft(const AFmt : AnsiString; var AChPos : SizeInt; var ALeft : Boolean);
begin
  If AFmt[AChPos]='-' then
   begin
    ALeft := True;
    Inc(AChPos);
   end
  else ALeft := False;
end;

procedure ReadWidth(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                        var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt; var AWidth : LongInt);
begin
  ReadInteger(AFmt,AArgs,AValue,AOldPos,AChPos,AArgpos,AIndex,ALen);
  If AValue <> -1 then
   begin
    AWidth := AValue;
    AValue := -1;
   end;
end;

procedure ReadPrec(const AFmt : AnsiString; const AArgs : Array of const; var AValue : LongInt;
                        var AOldPos,AChPos,AArgpos,AIndex,ALen : SizeInt; var APrec : LongInt);
begin
  If AFmt[AChPos]='.' then
   begin
    Inc(AChPos);
    ReadInteger(AFmt,AArgs,AValue,AOldPos,AChPos,AArgpos,AIndex,ALen);
    If AValue = -1 then AValue := 0;
    APrec := AValue;
   end;
end;

function ReadFormat(const AFmt : AnsiString; const AArgs : Array of const;
                    var AOldPos,AChPos,AArgpos,ALen,AIndex : SizeInt;
                    var AWidth,APrec : LongInt; var ALeft : Boolean) : Char;
var Value : longint;
{$ifdef INWIDEFORMAT}
var FormatChar : TFormatChar;
{$endif INWIDEFORMAT}

{   ReadFormat reads the format string. It returns the type character in
    uppercase, and sets index, Width, Prec to their correct values,
    or -1 if not set. It sets Left to true if left alignment was requested.
    In case of an error, DoFormatError is called.
  }
begin
  AIndex := -1;
  AWidth := -1;
  APrec  := -1;
  Value := -1;

  Inc(AChPos);

  if AFmt[AChPos]='%' then
   begin
    Result:='%';
    Exit;                           // VP fix
   end;

  ReadIndex(AFmt,AArgs,Value,AOldPos,AChPos,AArgpos,AIndex,ALen);
  ReadLeft(AFmt,AChPos,ALeft);
  ReadWidth(AFmt,AArgs,Value,AOldPos,AChPos,AArgpos,AIndex,ALen,AWidth);
  ReadPrec(AFmt,AArgs,Value,AOldPos,AChPos,AArgpos,AIndex,ALen,APrec);

  {$ifdef INWIDEFORMAT}
  FormatChar:=UpCase(UnicodeChar(Fmt[ChPos]));
  if word(FormatChar)>255 then
    Result:=#255
  else
    Result:=FormatChar;
  {$else INWIDEFORMAT}
  Result := Upcase(AFmt[AChPos]);
  {$endif INWIDEFORMAT}
end;

function Checkarg (const AFmt : AnsiString; var ADoArg,AArgPos,AIndex : SizeInt; const AArgs : Array of const; AT : SizeInt; Err:boolean):boolean;
{
  Check if argument INDEX is of correct type (AT)
  If Index=-1, ArgPos is used, and argpos is augmented with 1
  DoArg is set to the argument that must be used.
}
begin
  Result := False;

  if AIndex = -1 then ADoArg := AArgPos
   else ADoArg := AIndex;

  AArgPos := ADoArg + 1;

  If (ADoArg > High(AArgs)) or (AArgs[ADoArg].Vtype<>AT) then
   begin
    if Err then DoFormatError(feInvalidArgindex,AFmt);
    Dec(AArgPos);
    Exit;
   end;

  Result := True;
end;

procedure DoFormatError (ErrCode : Longint; const Fmt : ansistring);
var S : String;
begin
  //!! must be changed to contain format string...
  S := Fmt;
  Case ErrCode of
   feInvalidFormat   : raise EConvertError.Createfmt(SInvalidFormat,[s]);
   feMissingArgument : raise EConvertError.Createfmt(SArgumentMissing,[s]);
   feInvalidArgIndex : raise EConvertError.Createfmt(SInvalidArgIndex,[s]);
 end;
end;

Function MyFormat (Const Fmt : AnsiString; const Args : Array of const) : AnsiString;
begin
  Result:=Format(Fmt,Args,MyDefaultFormatSettings);
end;

end.

