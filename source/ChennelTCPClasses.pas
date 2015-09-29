unit ChennelTCPClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     ChennelClasses,
     SocketMyServerTypes;

type
  TChennelTCPThread = class(TChannelBaseThread)
   private
    FBindAddress : String;
    FPort        : Word;
    FSrvSocket   : TBaseServerSocket;
   protected
    procedure Execute; override; // вертит путой цикл в 500 мс
    procedure InitThread;        // создает серверное соединение
    procedure CloseThread;       // уничтожает серверное соединение

    procedure OnClientConnectProc(Sender : TBaseServerSocket; aClient : TServerClientObj);
    procedure OnClientDisconnectProc(Sender : TBaseServerSocket; aClient : TServerClientObj);
    procedure OnClientReceiveDataProc(Sender : TServerClientObj; Buff : array of Byte; DataSize : Cardinal; QuantityDataCame : Cardinal);
   public
    constructor Create(CreateSuspended: Boolean; const StackSize: SizeUInt = 65535); reintroduce;
    property BindAddress : String read FBindAddress write FBindAddress;
    property Port        : Word read FPort write FPort;
  end;

  TChennelTCP = class(TChannelBase)
   private
    FBindAddress : String;
    FPort        : Word;
   protected
    procedure SetActiveTrue; override;
   public
    constructor Create; override;
    property BindAddress : String read FBindAddress write FBindAddress;
    property Port        : Word read FPort write FPort default 502;
  end;

implementation

uses LoggerItf, ModbusEmuResStr,
     MBDefine,
     MBRequestReaderTCPClasses,
     MBDeviceClasses, MBRequestTypes,
     MBBuilderTCPAnswerPacketClasses;

{ TChennelTCP }

procedure TChennelTCP.SetActiveTrue;
begin
  if Active then Exit;
  FChannelThread := TChennelTCPThread.Create(True);
  FChannelThread.Logger := Logger;
  FChannelThread.CSection := CSection;
  FChannelThread.DeviceArray := DeviceArray;
  TChennelTCPThread(FChannelThread).BindAddress := FBindAddress;
  TChennelTCPThread(FChannelThread).Port        := FPort;

  FChannelThread.Start;
end;

constructor TChennelTCP.Create;
begin
  inherited Create;
  FPort        := 502;
  FBindAddress := '0.0.0.0';
end;

{ TChennelTCPThread }

constructor TChennelTCPThread.Create(CreateSuspended : Boolean; const StackSize : SizeUInt);
begin
  inherited Create(CreateSuspended,StackSize);
  FPort        := 502;
  FBindAddress := '0.0.0.0';
end;

procedure TChennelTCPThread.OnClientReceiveDataProc(Sender : TServerClientObj; Buff : array of Byte; DataSize : Cardinal; QuantityDataCame : Cardinal);
var TempReader : TMBTCPRequestReader;
    TempPackData : Pointer;
    TempPackDataSize : Cardinal;
    TempDevice : TMBDevice;
    TempAnswBits : TBuilderMBTCPBitAswerPacket;
    TempAnswWord : TBuilderMBTCPWordAswerPacket;
    TempAnswError : TBuilderMBTCPErrorPacket;
    TempBits  : TBits;
    TempWords : TWordRegsValues;
    TempStartAddr : Word;
    TempQuantity  : Word;
    TempAnswPackData : Pointer;
    TempAnswPackDataSize : Cardinal;
    TempSendRes : Integer;
    TempBool : Boolean;
begin
  TempDevice := nil;
  TempPackData := nil;
  TempPackDataSize := 0;
  TempAnswPackData := nil;
  TempAnswPackDataSize := 0;
  if (Length(Buff) = 0) or (DataSize = 0) then Exit;
  TempReader    := TMBTCPRequestReader.Create;
  TempAnswBits  := TBuilderMBTCPBitAswerPacket.Create;
  TempAnswWord  := TBuilderMBTCPWordAswerPacket.Create;
  TempAnswError := TBuilderMBTCPErrorPacket.Create;
  try
   // читаем пакет
   try
    TempReader.RequestRead(@Buff[0],DataSize);
   except
    on E : Exception do
    begin
     SendLogMessage(llError,rsChanTCP1,Format('Клиент: %s:%d. Ошибка разбора пакета: %s',[Sender.ClientAddr,Sender.ClientPort,E.Message]));
     Exit;
    end;
   end;
   Lock; // в ходим в критическую секцию для работы с массивом устройств
   try
     // получаем требуемый девайс
     try
      TempDevice := DeviceArray[TempReader.DeviceAddress];
     except
      on E : Exception do
       begin
        SendLogMessage(llError,rsChanTCP1,Format('Клиент: %s:%d. Ошибка получения устройства: %s',[Sender.ClientAddr,Sender.ClientPort,E.Message]));
        Exit;
       end;
     end;
     if not Assigned(TempDevice) then
      begin
       SendLogMessage(llDebug,rsChanTCP1,Format('Клиент: %s:%d. Запрашивается несуществующее устройство - %d',[Sender.ClientAddr,Sender.ClientPort,TempReader.DeviceAddress]));
       Exit;
      end;
     if not(TMBFunctionsEnum(TempReader.FunctionCode) in TempDevice.DeviceFunctions) then
      begin

       // нужно вставить отсылку ошибки

       SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Запрашиваемая функция(%d) не поддерживается устройством %d',[Sender.ClientAddr,Sender.ClientPort,TempReader.FunctionCode,TempReader.DeviceAddress]));
       Exit;
      end;
     // получаем данные пакета
     TempPackData := TempReader.GetPacketData(TempPackDataSize);
     try
      case TempReader.FunctionCode of
       1  : begin // чтение Coils rw
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress);
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);

             TempBits := TempDevice.GetCoilRegValues(TempStartAddr,TempQuantity);
             try
              TempAnswBits.BitData := TempBits;
             finally
              if Assigned(TempBits) then FreeAndNil(TempBits);
             end;
             TempAnswBits.StartingAddress := TempStartAddr;
             TempAnswBits.Quantity        := TempQuantity;
             TempAnswBits.TransactionID   := TempReader.TransactionID;
             TempAnswBits.ProtocolID      := TempReader.ProtocolID;
             TempAnswBits.DeviceAddress   := TempReader.DeviceAddress;
             TempAnswBits.FunctionNum     := TMBFunctionsEnum(TempReader.FunctionCode);
             // строим ответный пакет
             TempAnswBits.Build;
             // получаем паект от построителя для отправки
             TempAnswPackData     := TempAnswBits.Packet;
             TempAnswPackDataSize := TempAnswBits.Len;
             try
              // посылаем ответ
              TempSendRes := Sender.SendDada(TempAnswPackData^,TempAnswPackDataSize);
              if TempSendRes = -1 then
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Coils. Не удалось отправить ответ на запрос.',[Sender.ClientAddr,Sender.ClientPort]));
               end
              else
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Coils. Отправили ответ на запрос клиента.',[Sender.ClientAddr,Sender.ClientPort]));
               end;
             finally
              // освобождаем память выделенную для пакета
              Freemem(TempAnswPackData);
             end;

            end;
       2  : begin // чтение Discrete r
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress);
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);

             TempBits := TempDevice.GetDiscretRegValues(TempStartAddr,TempQuantity);
             try
              TempAnswBits.BitData := TempBits;
             finally
              if Assigned(TempBits) then FreeAndNil(TempBits);
             end;
             TempAnswBits.StartingAddress := TempStartAddr;
             TempAnswBits.Quantity        := TempQuantity;
             TempAnswBits.TransactionID   := TempReader.TransactionID;
             TempAnswBits.ProtocolID      := TempReader.ProtocolID;
             TempAnswBits.DeviceAddress   := TempReader.DeviceAddress;
             TempAnswBits.FunctionNum     := TMBFunctionsEnum(TempReader.FunctionCode);

             TempAnswBits.Build;

             TempAnswPackData     := TempAnswBits.Packet;
             TempAnswPackDataSize := TempAnswBits.Len;
             try
              TempSendRes := Sender.SendDada(TempAnswPackData^,TempAnswPackDataSize);
              if TempSendRes = -1 then
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Diskrets. Не удалось отправить ответ на запрос.',[Sender.ClientAddr,Sender.ClientPort]));
               end
              else
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Diskrets. Отправили ответ на запрос клиента.',[Sender.ClientAddr,Sender.ClientPort]));
               end;
             finally
              Freemem(TempAnswPackData);
             end;

            end;
       3  : begin // чтение Holdings r
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress);
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);

             TempWords := TempDevice.GetHoldingRegValues(TempStartAddr,TempQuantity);
             try
              TempAnswWord.WordData := TempWords;
             finally
              SetLength(TempWords,0);
             end;
             TempAnswWord.StartingAddress := TempStartAddr;
             TempAnswWord.Quantity        := TempQuantity;
             TempAnswWord.TransactionID   := TempReader.TransactionID;
             TempAnswWord.ProtocolID      := TempReader.ProtocolID;
             TempAnswWord.DeviceAddress   := TempReader.DeviceAddress;
             TempAnswWord.FunctionNum     := TMBFunctionsEnum(TempReader.FunctionCode);

             TempAnswWord.Build;

             TempAnswPackData     := TempAnswWord.Packet;
             TempAnswPackDataSize := TempAnswWord.Len;
             try
              TempSendRes := Sender.SendDada(TempAnswPackData^,TempAnswPackDataSize);
              if TempSendRes = -1 then
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Holding. Не удалось отправить ответ на запрос.',[Sender.ClientAddr,Sender.ClientPort]));
               end
              else
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Holding. Отправили ответ на запрос клиента.',[Sender.ClientAddr,Sender.ClientPort]));
               end;
             finally
              Freemem(TempAnswPackData);
             end;

            end;
       4  : begin // чтение Input rw
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress);
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);

             TempWords := TempDevice.GetInputRegValues(TempStartAddr,TempQuantity);
             try
              TempAnswWord.WordData := TempWords;
             finally
              SetLength(TempWords,0);
             end;
             TempAnswWord.StartingAddress := TempStartAddr;
             TempAnswWord.Quantity        := TempQuantity;
             TempAnswWord.TransactionID   := TempReader.TransactionID;
             TempAnswWord.ProtocolID      := TempReader.ProtocolID;
             TempAnswWord.DeviceAddress   := TempReader.DeviceAddress;
             TempAnswWord.FunctionNum     := TMBFunctionsEnum(TempReader.FunctionCode);

             TempAnswWord.Build;

             TempAnswPackData     := TempAnswWord.Packet;
             TempAnswPackDataSize := TempAnswWord.Len;
             try
              TempSendRes := Sender.SendDada(TempAnswPackData^,TempAnswPackDataSize);
              if TempSendRes = -1 then
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Input. Не удалось отправить ответ на запрос.',[Sender.ClientAddr,Sender.ClientPort]));
               end
              else
               begin
                SendLogMessage(llDebug, rsChanTCP1,Format('Клиент: %s:%d. Read Input. Отправили ответ на запрос клиента.',[Sender.ClientAddr,Sender.ClientPort]));
               end;
             finally
              Freemem(TempAnswPackData);
             end;

            end;
       5  : begin // запись одного Coil
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress); // адрес
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);        // значение - должно быть либо $0000 - False либо $FF00 - True
             if TempQuantity = 0 then TempBool := False
              else TempBool := True;

             TempDevice.Coils[TempStartAddr] := TempBool;


            end;
       6  : begin // запись одного Input
             TempStartAddr := swap(PMBF1_6FRequestData(TempPackData)^.StartingAddress); // адрес
             TempQuantity  := swap(PMBF1_6FRequestData(TempPackData)^.Quantity);        // значение

             TempDevice.Inputs[TempStartAddr] := TempQuantity;


            end;
       15 : begin // запись множества Coils

            end;
       16 : begin // запись множества Inputs

            end;
      end;
     finally
      if Assigned(TempPackData) then Freemem(TempPackData);
     end;
   finally
    UnLock;
   end;
  finally
   FreeAndNil(TempReader);
   FreeAndNil(TempAnswBits);
   FreeAndNil(TempAnswWord);
   FreeAndNil(TempAnswError);
  end;
end;

procedure TChennelTCPThread.OnClientConnectProc(Sender : TBaseServerSocket; aClient : TServerClientObj);
begin
  SendLogMessage(llError,rsChanTCP1,Format('Канал: %s:%d. Присоеденился клиент: %s:%d',[Sender.BindAddress,Sender.Port,aClient.ClientAddr,aClient.ClientPort]));
end;

procedure TChennelTCPThread.OnClientDisconnectProc(Sender : TBaseServerSocket;aClient : TServerClientObj);
begin
  SendLogMessage(llError,rsChanTCP1,Format('Канал: %s:%d. Отсоеденился клиент: %s:%d',[Sender.BindAddress,Sender.Port,aClient.ClientAddr,aClient.ClientPort]));
end;

procedure TChennelTCPThread.Execute;
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

procedure TChennelTCPThread.InitThread;
begin
  try
   FSrvSocket := TBaseServerSocket.Create;
   FSrvSocket.BindAddress := FBindAddress;
   FSrvSocket.Port        := FPort;
   FSrvSocket.OnClientConnect     := @OnClientConnectProc;
   FSrvSocket.OnClientDisconnect  := @OnClientDisconnectProc;
   FSrvSocket.OnClientReceiveData := @OnClientReceiveDataProc;
   FSrvSocket.Open;
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanTCP1,Format(rsChanThreadIni,[E.Message]));
    end;
  end;
end;

procedure TChennelTCPThread.CloseThread;
begin
  try
   FreeAndNil(FSrvSocket);
  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanTCP1,Format(rsChanThreadClose,[E.Message]));
    end;
  end;
end;

end.

