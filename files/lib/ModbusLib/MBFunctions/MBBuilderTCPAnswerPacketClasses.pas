{
$Author: npcprom\fomin_k $
$Date: 2014-04-25 16:37:06 +0600 (Fri, 25 Apr 2014) $
$Rev: 266 $
}
unit MBBuilderTCPAnswerPacketClasses;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBDefine, MBInterfaces, MBBuilderPacketClasses;

resourcestring
  rsIllegalFunctionNumber = 'Не допустимый номер функции.';     

type
  TBuilderMBTCPAswerPacket = class(TBuilderMBTCPPacket, IBuilderTCPAnswerPacket)
  protected
   FSubFunction : Byte;
   function  GetFunctionNum: TMBFunctionsEnum;
   procedure SetFunctionNumber(const Value : TMBFunctionsEnum); stdcall;
  public
   constructor Create; override;
   property FunctionNum : TMBFunctionsEnum read GetFunctionNum write SetFunctionNumber;
  end;

  TBuilderMBTCPErrorPacket = class(TBuilderMBTCPAswerPacket, IBuilderTCPErrorAnswer)
  private
   FErrorCode   : Byte;
  protected
   procedure SetErrorCode(const Value : Byte); stdcall;
  public
   constructor Create; override;
   procedure Build; override;
   property ErrorCode   : Byte read FErrorCode write SetErrorCode;
  end;

  TBuilderMBTCPBitAswerPacket = class(TBuilderMBTCPAswerPacket, IBuilderTCPBitAnswerPacket)
  private
    FBitData : TBits;
  protected
    procedure SetBitData(const BitList : TBits); stdcall;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Build; override;
    property BitData : TBits read FBitData write SetBitData;
  end;

  TBuilderMBTCPWordAswerPacket = class(TBuilderMBTCPAswerPacket, IBuilderTCPWordAnswerPacket)
  private
    FWordData : TWordRegsValues;
  protected
    procedure SetWordData(const WordList : TWordRegsValues); stdcall;
  public
    destructor Destroy; override;
    procedure Build; override;
    property WordData : TWordRegsValues read FWordData write SetWordData;
  end;

implementation

uses SysUtils,
     MBRequestTypes, MBResponseTypes, MBBuilderBase;

{ TBuilderMBTCPErrorPacket }

constructor TBuilderMBTCPErrorPacket.Create;
begin
  inherited;
  FErrorCode   := 0;
end;

procedure TBuilderMBTCPErrorPacket.Build;
var TempW : Word;
begin
  FLenPacket:=sizeof(TMBTCPErrorHeder);
  GetPacketMem;
  PMBTCPErrorHeder(FPacket)^.TransactioID := Swap(FTransactionID);
  PMBTCPErrorHeder(FPacket)^.ProtocolID   := Swap(FProtocolID);
  TempW := FLenPacket-6;
  PMBTCPErrorHeder(FPacket)^.Length       := swap(TempW);
  PMBTCPErrorHeder(FPacket)^.DeviceID     := FDeviceAddress;
  PMBTCPErrorHeder(FPacket)^.ErrorData.FunctionCode := FFunctionNum+$80;
  PMBTCPErrorHeder(FPacket)^.ErrorData.ErrorCode := FErrorCode;
  Notify(betBuild);
end;

procedure TBuilderMBTCPErrorPacket.SetErrorCode(const Value: Byte); stdcall;
begin
  FErrorCode := Value;
end;

{ TBuilderMBTCPAswerPacket }

constructor TBuilderMBTCPAswerPacket.Create;
begin
  inherited;
  FFunctionNum := 0;
  FSubFunction := 0;
end;

function TBuilderMBTCPAswerPacket.GetFunctionNum: TMBFunctionsEnum;
begin
  Result := fnNon;
  case FFunctionNum of
   0.. 24 : Result := TMBFunctionsEnum(FFunctionNum);
   43     : begin
              case FSubFunction of
               13 : Result := fn43_13;
               14 : Result := fn43_14;
              end;
            end;
  end
end;

procedure TBuilderMBTCPAswerPacket.SetFunctionNumber(const Value: TMBFunctionsEnum); stdcall;
begin
  if Value = fnNon then raise Exception.Create(rsIllegalFunctionNumber);
  case Value of
   fn01..fn24 : FFunctionNum:=Byte(Value);
   fn43_13    : begin
                  FFunctionNum := 43;
                  FSubFunction := 13;
                end;
   fn43_14    : begin
                  FFunctionNum := 43;
                  FSubFunction := 14;
                end;
  end;
end;

{ TBuilderMBTCPBitAswerPacket }

constructor TBuilderMBTCPBitAswerPacket.Create;
begin
  inherited;
  FBitData := TBits.Create;
end;

destructor TBuilderMBTCPBitAswerPacket.Destroy;
begin
  FBitData.Free;
  inherited;
end;

procedure TBuilderMBTCPBitAswerPacket.Build;
var TempBuff  : PByteArray;
    ByteIndex : Integer;
    BitIndex  : Integer;
    i,Count   : Integer;
begin
  // получаем память под пакет
  GetPacketMem;
  // формируем пакет
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.TransactioID := Swap(FTransactionID);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.ProtocolID   := Swap(FProtocolID);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.Length       := Swap(FLen);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.DeviceID     := FDeviceAddress;
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.FunctionNum                := FFunctionNum;
  PMBTCPAnswerHeader(FPacket)^.ByteCount                                  := Byte(FLenPacket-9);
  Count:=FBitData.Size-1;
  TempBuff:=Pointer(PtrUInt(@PMBTCPAnswerHeader(FPacket)^.ByteCount) + 1);
  for i := 0 to Count do
  begin
   ByteIndex:=i div 8;
   BitIndex:= i mod 8;
   case BitIndex of
     0 : if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 1
          else
           if (TempBuff^[ByteIndex] and 1)=1 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 1;
     1 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 2
          else
           if (TempBuff^[ByteIndex] and 2)=2 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 2;
     2 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 4
          else
           if (TempBuff^[ByteIndex] and 4)=4 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 4;
     3 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 8
          else
           if (TempBuff^[ByteIndex] and 8)=8 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 8;
     4 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 16
          else
           if (TempBuff^[ByteIndex] and 16)=16 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 16;
     5 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 32
          else
           if (TempBuff^[ByteIndex] and 32)=32 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 32;
     6 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 64
          else
           if (TempBuff^[ByteIndex] and 64)=64 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 64;
     7 :if FBitData.Bits[i] then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] or 128
          else
           if (TempBuff^[ByteIndex] and 128)=128 then TempBuff^[ByteIndex]:= TempBuff^[ByteIndex] xor 128;
   end;
  end;
  Notify(betBuild);
end;

procedure TBuilderMBTCPBitAswerPacket.SetBitData(const BitList: TBits); stdcall;
var i,Count : Integer;
    TemDataByteCount : Byte;
begin
  FBitData.Size := 0;
  Count := BitList.Size-1;
  FBitData.Size := Count+1;
  for i:=0 to Count do FBitData.Bits[i] := BitList.Bits[i];
  // вычисляем количество байт необходимых для передачи значений полученных бит
  TemDataByteCount:=FBitData.Size div 8;
  if (FBitData.Size mod 8)>0 then TemDataByteCount:=TemDataByteCount+1;
  // определяем размер пакета
  FLenPacket:=SizeOf(TMBTCPAnswerHeader)+TemDataByteCount;
  FLen := Word(FLenPacket) - 6;
end;

{ TBuilderMBTCPWordAswerPacket }

destructor TBuilderMBTCPWordAswerPacket.Destroy;
begin
  if Length(FWordData)>0 then SetLength(FWordData,0);
  inherited;
end;

procedure TBuilderMBTCPWordAswerPacket.Build;
var TempBuff  : PByteArray;
    i, Count : Integer;
begin
  // получаем память под пакет
  GetPacketMem;
  // формируем пакет
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.TransactioID := Swap(FTransactionID);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.ProtocolID   := Swap(FProtocolID);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.Length       := Swap(FLen);
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.TCPHeaderFull.DeviceID     := FDeviceAddress;
  PMBTCPAnswerHeader(FPacket)^.HeaderFullFName.FunctionNum                := FFunctionNum;
  PMBTCPAnswerHeader(FPacket)^.ByteCount                                  := Byte(FLenPacket-9);
  // получаем указатель на область памяти под значения регистров
  TempBuff:=Pointer(PtrUInt(@PMBTCPAnswerHeader(FPacket)^.ByteCount) + 1);
  Count := (PMBTCPAnswerHeader(FPacket)^.ByteCount div 2)-1;
  for i := 0 to Count do
   begin
     PWordArray(TempBuff)^[i] := Swap(FWordData[i]);
   end;
  // переносим значения регистров
  //Move(FWordData[0],TempBuff^[0],PMBTCPAnswerHeader(FPacket)^.ByteCount);
  Notify(betBuild);
end;

procedure TBuilderMBTCPWordAswerPacket.SetWordData(const WordList: TWordRegsValues); stdcall;
var TempLenght : Word;
begin
  SetLength(FWordData,0);
  TempLenght := Length(WordList);
  if TempLenght = 0 then Exit;
  SetLength(FWordData,TempLenght);
  Move(WordList[0],FWordData[0],TempLenght*2);
  FLenPacket := SizeOf(TMBTCPAnswerHeader)+TempLenght*2;
  FLen := TempLenght*2+3;
end;

end.