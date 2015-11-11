unit MBBuilderRTUAnswerPacketClasses;

{$mode objfpc}{$H+}

interface

uses Classes,
     MBDefine, MBInterfaces, MBBuilderPacketClasses,
     CRC16Func;

type

  TBuilderMBRTUAswerPacket = class(TBuilderMBRTUPacket, IBuilderRTUAnswerPacket)
  protected
   FSubFunction : Byte;
   function  GetFunctionNum: TMBFunctionsEnum;
   procedure SetFunctionNumber(const Value : TMBFunctionsEnum);
  public
   constructor Create(AOwner : TComponent); override;
   property FunctionNum : TMBFunctionsEnum read GetFunctionNum write SetFunctionNumber;
  end;

  TBuilderMBRTUErrorPacket = class(TBuilderMBRTUAswerPacket, IBuilderRTUErrorAnswer)
  private
   FErrorCode   : Byte;
  protected
   procedure SetErrorCode(const Value : Byte);
  public
   constructor Create(AOwner : TComponent); override;
   procedure Build; override;
   property ErrorCode   : Byte read FErrorCode write SetErrorCode;
  end;

  TBuilderMBRTUBitAswerPacket = class(TBuilderMBRTUAswerPacket, IBuilderRTUBitAnswerPacket)
  private
    FBitData : TBits;
  protected
    procedure SetBitData(const BitList : TBits);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Build; override;
    property BitData : TBits read FBitData write SetBitData;
  end;

  TBuilderMBRTUWordAswerPacket = class(TBuilderMBRTUAswerPacket, IBuilderRTUWordAnswerPacket)
  private
    FWordData : TWordRegsValues;
  protected
    procedure SetWordData(const WordList : TWordRegsValues);
  public
    destructor Destroy; override;
    procedure Build; override;
    property WordData : TWordRegsValues read FWordData write SetWordData;
  end;

implementation

uses MBResourceString, sysutils;

{ TBuilderMBRTUWordAswerPacket }

destructor TBuilderMBRTUWordAswerPacket.Destroy;
begin
  if Length(FWordData)>0 then SetLength(FWordData,0);
  inherited Destroy;
end;

procedure TBuilderMBRTUWordAswerPacket.SetWordData(const WordList : TWordRegsValues);
var TempLenght : Word;
    TempLenPack : Word;
begin
  SetLength(FWordData,0);
  TempLenght := Length(WordList);
  if TempLenght = 0 then Exit;

  SetLength(FWordData,TempLenght);

  Move(WordList[0],FWordData[0],TempLenght * 2);

//  TempLenPack := SizeOf(TMBTCPAnswerHeader) + TempLenght*2;
//
//  if FLenPacket <> TempLenPack then ClearPacket;
//
//  FLenPacket := TempLenPack;
//
//  FLen := TempLenght*2+3;
end;

procedure TBuilderMBRTUWordAswerPacket.Build;
begin

 Notify(betBuild);
end;

{ TBuilderMBRTUBitAswerPacket }

constructor TBuilderMBRTUBitAswerPacket.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FBitData := TBits.Create;
end;

destructor TBuilderMBRTUBitAswerPacket.Destroy;
begin
  FreeAndNil(FBitData);
  inherited Destroy;
end;

procedure TBuilderMBRTUBitAswerPacket.SetBitData(const BitList : TBits);
var i,Count : Integer;
    TemDataByteCount : Byte;
    TempLenPack : Word;
begin
  FBitData.Size := 0;
  Count := BitList.Size-1;
  FBitData.Size := Count+1;
  for i:=0 to Count do FBitData.Bits[i] := BitList.Bits[i];
  // вычисляем количество байт необходимых для передачи значений полученных бит
  TemDataByteCount := FBitData.Size div 8;
  if (FBitData.Size mod 8)>0 then TemDataByteCount := TemDataByteCount+1;
  // определяем размер пакета

//  TempLenPack := SizeOf(TMBRTUAnswerHeader) + TemDataByteCount;
//
//  if FLenPacket <> TempLenPack then ClearPacket;
//
//  FLenPacket := TempLenPack;
//
//  FLen := Word(FLenPacket) - 6;
end;

procedure TBuilderMBRTUBitAswerPacket.Build;
begin

  Notify(betBuild);
end;

{ TBuilderMBRTUErrorPacket }

constructor TBuilderMBRTUErrorPacket.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FErrorCode   := 0;
end;

procedure TBuilderMBRTUErrorPacket.SetErrorCode(const Value : Byte);
begin
  FErrorCode := Value;
end;

procedure TBuilderMBRTUErrorPacket.Build;
begin

  Notify(betBuild);
end;

{ TBuilderMBRTUAswerPacket }

constructor TBuilderMBRTUAswerPacket.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFunctionNum := 0;
  FSubFunction := 0;
end;

function TBuilderMBRTUAswerPacket.GetFunctionNum : TMBFunctionsEnum;
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

procedure TBuilderMBRTUAswerPacket.SetFunctionNumber(const Value : TMBFunctionsEnum);
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

end.

