unit ChennelTCPClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs,
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

uses LoggerItf, ModbusEmuResStr;

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
begin

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

