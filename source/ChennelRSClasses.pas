unit ChennelRSClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     ChennelClasses,
     COMCrossTypes, COMPortParamTypes,
     MBRequestReaderRTUClasses,
     MBDeviceClasses;

type
  TChennelRSThread = class(TChannelBaseThread)
   private
    FCOMPort         : TNPCCustomCOMPort;
    FRequestReader   : TMBRTURequestReader;

    FBaudRate        : TComPortBaudRate;
    FByteSize        : TComPortDataBits;
    FParity          : TComPortParity;
    FPortNum         : Word;
    FPortPrefix      : TComPortPrefixPath;
    FPortPrefixOther : String;
    FStopBits        : TComPortStopBits;
   protected
    procedure Execute; override;
    procedure InitThread;
    procedure CloseThread;

    procedure OnServerReadProc(Sender : TObject);

    procedure ResponseF1(ADev : TMBDevice); virtual;
    procedure ResponseF2(ADev : TMBDevice); virtual;
    procedure ResponseF3(ADev : TMBDevice); virtual;
    procedure ResponseF4(ADev : TMBDevice); virtual;
    procedure ResponseF5(ADev : TMBDevice); virtual;
    procedure ResponseF6(ADev : TMBDevice); virtual;
    procedure ResponseF15(ADev : TMBDevice); virtual;
    procedure ResponseF16(ADev : TMBDevice); virtual;
    procedure ResponseF17(ADev : TMBDevice); virtual;

    procedure SendErrorMsg(ADevNum,AFuncNum,AError: Byte);

   public
    constructor Create(CreateSuspended: Boolean; const StackSize: SizeUInt = 65535); reintroduce;
    destructor  Destroy; override;

    property PortNum         : Word read FPortNum write FPortNum default 1;
    property PortPrefix      : TComPortPrefixPath read FPortPrefix write FPortPrefix default {$IFDEF WINDOWS}pptWindows{$ELSE}pptLinux{$ENDIF};
    property PortPrefixOther : String read FPortPrefixOther write FPortPrefixOther;
    property BaudRate        : TComPortBaudRate read FBaudRate write FBaudRate default br9600;
    property ByteSize        : TComPortDataBits read FByteSize write FByteSize default db8BITS;
    property Parity          : TComPortParity read FParity write FParity default ptEVEN;
    property StopBits        : TComPortStopBits read FStopBits write FStopBits default sb1BITS;
  end;

  TChennelRS = class(TChannelBase)
  private
    FBaudRate        : TComPortBaudRate;
    FByteSize        : TComPortDataBits;
    FParity          : TComPortParity;
    FPortNum         : Word;
    FPortPrefix      : TComPortPrefixPath;
    FPortPrefixOther : String;
    FStopBits        : TComPortStopBits;
   protected
    procedure SetActiveTrue; override;
   public
    constructor Create; override;
    destructor  Destroy; override;

    property PortNum         : Word read FPortNum write FPortNum default 1;
    property PortPrefix      : TComPortPrefixPath read FPortPrefix write FPortPrefix default {$IFDEF WINDOWS}pptWindows{$ELSE}pptLinux{$ENDIF};
    property PortPrefixOther : String read FPortPrefixOther write FPortPrefixOther;
    property BaudRate        : TComPortBaudRate read FBaudRate write FBaudRate default br9600;
    property ByteSize        : TComPortDataBits read FByteSize write FByteSize default db8BITS;
    property Parity          : TComPortParity read FParity write FParity default ptEVEN;
    property StopBits        : TComPortStopBits read FStopBits write FStopBits default sb1BITS;
  end;

implementation

uses LoggerItf, ModbusEmuResStr,
     MBDefine, MBErrorCode,
     MBRequestTypes;

{ TChennelRS }

constructor TChennelRS.Create;
begin
  inherited Create;

  FBaudRate        := br9600;
  FByteSize        := db8BITS;
  FParity          := ptEVEN;
  FPortNum         := 1;
  FPortPrefix      := {$IFDEF WINDOWS}pptWindows{$ELSE}pptLinux{$ENDIF};
  FPortPrefixOther := '';
  FStopBits        := sb1BITS;
end;

destructor TChennelRS.Destroy;
begin
  inherited Destroy;
end;

procedure TChennelRS.SetActiveTrue;
begin
  if Active then Exit;
  FChannelThread := TChennelRSThread.Create(True);
  FChannelThread.Logger := Logger;
  FChannelThread.DeviceArray := DeviceArray;

  TChennelRSThread(FChannelThread).BaudRate        := FBaudRate;
  TChennelRSThread(FChannelThread).ByteSize        := FByteSize;
  TChennelRSThread(FChannelThread).Parity          := FParity;
  TChennelRSThread(FChannelThread).PortNum         := FPortNum;
  TChennelRSThread(FChannelThread).PortPrefix      := FPortPrefix;
  TChennelRSThread(FChannelThread).PortPrefixOther := FPortPrefixOther;
  TChennelRSThread(FChannelThread).StopBits        := FStopBits;

  FChannelThread.Start;
end;

{ TChennelRSThread }

constructor TChennelRSThread.Create(CreateSuspended : Boolean; const StackSize : SizeUInt);
begin
  inherited Create(CreateSuspended,StackSize);

  FBaudRate        := br9600;
  FByteSize        := db8BITS;
  FParity          := ptEVEN;
  FPortNum         := 1;
  FPortPrefix      := {$IFDEF WINDOWS}pptWindows{$ELSE}pptLinux{$ENDIF};
  FPortPrefixOther := '';
  FStopBits        := sb1BITS;

  FRequestReader   := TMBRTURequestReader.Create(nil);
end;

destructor TChennelRSThread.Destroy;
begin
  FreeAndNil(FRequestReader);
  inherited Destroy;
end;

procedure TChennelRSThread.OnServerReadProc(Sender : TObject);
var Buff : array [0..2047] of Byte;
    ReadRes : Integer;
    TempDevice : TMBDevice;
begin
  TempDevice := nil;
  Buff[0] := 0;
  FillByte(Buff[0],2048,0);
  ReadRes := FCOMPort.ReadData(Buff,1024);
  if ReadRes = -1 then
   begin
    SendLogMessage(llError,rsChanRS1,Format(rsOnServerReadProc1,[FCOMPort.LastError,FCOMPort.LastErrorDesc]));
    Exit;
   end;

  try
   FRequestReader.RequestRead(@Buff[0],ReadRes);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanRS1,Format(rsOnServerReadProc2,[E.Message]));
    end;
  end;

  Lock;
  try
   try
    TempDevice := DeviceArray[FRequestReader.DeviceAddress];
   except
    on E : Exception do
     begin
      SendLogMessage(llError,rsChanRS1,Format(rsOnServerReadProc3,[FCOMPort.PortNumber,E.Message]));
      Exit;
     end;
   end;

   if not Assigned(TempDevice) then
    begin
     SendLogMessage(llDebug,rsChanRS1,Format(rsOnServerReadProc4,[FCOMPort.PortNumber,FRequestReader.DeviceAddress]));
     Exit;
    end;

   if not(TMBFunctionsEnum(FRequestReader.FunctionCode) in TempDevice.DeviceFunctions) then
    begin
     SendLogMessage(llDebug, rsChanRS1,Format(rsOnServerReadProc5,[FCOMPort.PortNumber,FRequestReader.FunctionCode,FRequestReader.DeviceAddress]));
     SendErrorMsg(FRequestReader.DeviceAddress,FRequestReader.FunctionCode,ERR_MB_ILLEGAL_FUNCTION - ERR_MB_ERR_CUSTOM);
     Exit;
    end;

   case FRequestReader.FunctionCode of
    1  : begin // чтение Coils rw
          ResponseF1(TempDevice);
         end;
    2  : begin // чтение Discrete r
          ResponseF2(TempDevice);
         end;
    3  : begin // чтение Holdings rw
          ResponseF3(TempDevice);
         end;
    4  : begin // чтение Input r
          ResponseF4(TempDevice);
         end;
    5  : begin // запись одного Coil
          ResponseF5(TempDevice);
         end;
    6  : begin // запись одного Holding
          ResponseF6(TempDevice);
         end;
    15 : begin // запись множества Coils
          ResponseF15(TempDevice);
         end;
    16 : begin // запись множества Holding
          ResponseF16(TempDevice);
         end;
    17 : begin // Чтение/запись Holdong регистров одним вызовом
          ResponseF17(TempDevice);
         end;
   end;
  finally
   UnLock;
  end;
end;

procedure TChennelRSThread.ResponseF1(ADev : TMBDevice);
var TempPackData     : Pointer;
    TempPackDataSize : Cardinal;
    TempStartAddr    : Word;
    TempQuantity     : Word;
    TempBits         : TBits;
begin
  TempPackData := FRequestReader.GetPacketData(TempPackDataSize);

  TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress);
  TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);

  Freemem(TempPackData);

  try
   TempBits := ADev.GetCoilRegValues(TempStartAddr,TempQuantity);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanRS1, Format('Порт %d. Ошибка получения значений Coil регистров(%d:%d:%d): %s',[FCOMPort.PortNumber,FRequestReader.DeviceAddress, TempStartAddr,TempQuantity,E.Message]));
     SendErrorMsg(FRequestReader.DeviceAddress,FRequestReader.FunctionCode,ERR_MB_SLAVE_DEVICE_FAILURE - ERR_MB_ERR_CUSTOM);
     Exit;
    end;
  end;

end;

procedure TChennelRSThread.ResponseF2(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF3(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF4(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF5(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF6(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF15(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF16(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.ResponseF17(ADev : TMBDevice);
begin

end;

procedure TChennelRSThread.SendErrorMsg(ADevNum, AFuncNum, AError : Byte);
begin

end;

procedure TChennelRSThread.Execute;
begin
  InitThread;
  try
   while Terminated do
    begin
     Sleep(500);
    end;
  finally
   CloseThread;
  end;
end;

procedure TChennelRSThread.InitThread;
begin
  try
   FCOMPort := TNPCCustomCOMPort.Create(nil);
   FCOMPort.Logger := Logger;
   FCOMPort.IsServerSide := True;
   FCOMPort.IsRaiseException := True;
   FCOMPort.OnServerReadData := @OnServerReadProc;

   FCOMPort.PortPrefix := FPortPrefix;

   case FPortPrefix of
    pptOther : begin
                if FPortPrefixOther = '' then raise Exception.Create('Признак нестандартного префикса установлен, а сам префикс не задан.');
                FCOMPort.PortPrefixOther := FPortPrefixOther;
               end;
   end;

   FCOMPort.PortNumber   := FPortNum;
   FCOMPort.BaudRate     := FBaudRate;
   FCOMPort.ByteSize     := FByteSize;
   FCOMPort.Parity       := FParity;
   FCOMPort.StopBits     := FStopBits;
   FCOMPort.RecvBuffSize := 2048;

   FCOMPort.Open;

   FCOMPort.IsRaiseException := False;
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanRS1,Format(rsChanThreadIni,[E.Message]));
    end;
  end;
end;

procedure TChennelRSThread.CloseThread;
begin
  try
   FreeAndNil(FCOMPort);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanRS1,Format(rsChanThreadClose,[E.Message]));
    end;
  end;
end;

end.

