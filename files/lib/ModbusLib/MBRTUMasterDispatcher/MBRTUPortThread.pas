unit MBRTUPortThread;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs, contnrs,
     LoggerItf,
     MBRTUMasterDispatcherTypes, MBRTUMasterDispatcherConst,
     MBRTURequestBase,
     COMCrossTypes;

type

  { TMBRTUPortThread }

  TMBRTUPortThread = class(TThreadLogged)
   private
    FIntervalBetweenPolls : Cardinal;
    FIsActive             : Boolean;
    FCSection             : TCriticalSection;
    FPortParams           : TMBDispPortParam;
    FPoolinObjList        : TList;
    FSingleObjQueue       : TObjectQueue;
    FComPort              : TNPCCustomCOMPort;
    FResponceBuff         : TMBPacket;
    FOwnedSingleRequest   : Boolean;
    function  GetIsActive: Boolean;
    procedure SetActive(AIsActive : Boolean);
    procedure SetIntervalBetweenPolls(AValue: Cardinal);
   protected
    procedure Execute; override;
    function  InitThread : Boolean;
    procedure CloseThread;

    procedure Lock;
    procedure UnLock;
    procedure ProcessSingleRequests;
    procedure ExecuteRequest(ARequest : TMBRTURequestBase);
   public
    constructor Create(APortParam : TMBDispPortParam;
                       ACSection  : TCriticalSection;
                       APool      : TList;
                       AQueue     : TObjectQueue;
                       AOwnedSingleRequest : Boolean = False); virtual;
    destructor Destroy; override;

    property IsActive             : Boolean read GetIsActive;
    property IntervalBetweenPolls : Cardinal read FIntervalBetweenPolls write SetIntervalBetweenPolls default DefIntervalBetweenPolls;
  end;

implementation

uses MBDefine, MBRTUObjItf,
     ExceptionsTypes;

{ TMBRTUPortThread }

constructor TMBRTUPortThread.Create(APortParam: TMBDispPortParam;
  ACSection: TCriticalSection; APool: TList; AQueue: TObjectQueue; AOwnedSingleRequest : Boolean);
begin
  inherited Create(True,65535);
  FIsActive             := False;
  FCSection             := ACSection;
  FPortParams           := APortParam;
  FPoolinObjList        := APool;
  FSingleObjQueue       := AQueue;
  FComPort              := nil;
  FOwnedSingleRequest   := AOwnedSingleRequest;
  FIntervalBetweenPolls := DefIntervalBetweenPolls;
  SetLength(FResponceBuff,DefRSReadBuffSize);
end;

destructor TMBRTUPortThread.Destroy;
begin
  SetLength(FResponceBuff,0);
  inherited Destroy;
end;

procedure TMBRTUPortThread.SetIntervalBetweenPolls(AValue: Cardinal);
begin
  if FIntervalBetweenPolls = AValue then Exit;
  if AValue < MinIntervalBetweenPolls then AValue := MinIntervalBetweenPolls;
  FIntervalBetweenPolls := AValue;
end;

function TMBRTUPortThread.GetIsActive: Boolean;
begin
  Lock;
  try
   Result := FIsActive;
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortThread.SetActive(AIsActive : Boolean);
begin
  Lock;
  try
   FIsActive := AIsActive;
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortThread.Execute;
var TempReqCount : Integer;
    TempRequest  : TMBRTURequestBase;
    i : Integer;
begin
  SetActive(InitThread);
  try
  while not Terminated do
   begin
     if not IsActive then
      begin
       Sleep(FIntervalBetweenPolls);
       CloseThread;
       SetActive(InitThread);
       Continue;
      end;

     // выполняем запросы из пула
     Lock;
     try
      TempReqCount := FPoolinObjList.Count;
      if TempReqCount = 0 then
       begin
        // выполняем все одиночные запросы
        ProcessSingleRequests;
        Continue;
       end;
      for i := 0 to TempReqCount - 1 do
       begin
        // сначала выполняем все одиночные запросы
        ProcessSingleRequests;
        TempRequest := TMBRTURequestBase(FPoolinObjList[i]);
        if TempRequest = nil then Continue;
        // выполняем запрос из пула
        ExecuteRequest(TempRequest);
       end;
     finally
       UnLock;
     end;

     Sleep(10); // нужно для возможности добавления одиночных запросов
   end;

  finally
   CloseThread;
  end;
end;

procedure TMBRTUPortThread.ProcessSingleRequests;
var TempRequest : TMBRTURequestBase;
begin
 if FSingleObjQueue.Count = 0 then Exit;

 while FSingleObjQueue.Count > 0 do
  begin
   TempRequest := TMBRTURequestBase(FSingleObjQueue.Pop);

   if not Assigned(TempRequest) then Continue;

   ExecuteRequest(TempRequest);

   if FOwnedSingleRequest then FreeAndNil(TempRequest);
  end;
end;

procedure TMBRTUPortThread.ExecuteRequest(ARequest: TMBRTURequestBase);
var TempRquest   : TMBPacket;
    TempLen      : Integer;
    TempRes      : Integer;
    TempWaitRes  : TWaitResult;
    TempTimeOut  : QWord;
    TempErr      : Cardinal;
begin
  if (not Assigned(FComPort)) or (not FComPort.Active) then Exit;
  TempLen    := Length(ARequest.GetRequest);
  if TempLen = 0 then ARequest.BuilRequest;
  TempRquest := ARequest.GetRequest;

  TempRes := FComPort.WriteData(TempRquest[0],TempLen);
  if TempLen <> TempRes then
   begin
    ARequest.LastError := ARequest.CurError;
    TempErr := FComPort.LastError;
    if ARequest.LastError<>TempErr then
     begin
      ARequest.CallBackItf.SendEvent(mdeeRSWriteErr,TempErr,1);
     end;
    ARequest.CurError := TempErr;
    Exit;
   end;

  TempTimeOut := ARequest.ResponceTimeout;
  TempWaitRes := FComPort.WaitForData(TempTimeOut);
  if TempWaitRes <> wrSignaled then
   begin
     ARequest.LastError := ARequest.CurError;
     if ARequest.LastError<>ERR_RESIVE_DATA_TIMEOUT then
      begin
       ARequest.CallBackItf.SendEvent(mdeeMBError,ERR_RESIVE_DATA_TIMEOUT,2);
      end;
     ARequest.CurError := ERR_RESIVE_DATA_TIMEOUT;
     Exit;
   end;

  TempLen := Length(FResponceBuff);
  TempRes := FComPort.ReadData(FResponceBuff[0],TempLen);
  ARequest.SetResponce(FResponceBuff,TempRes);

  FillByte(FResponceBuff[0],TempLen,0);
end;

function TMBRTUPortThread.InitThread: Boolean;
begin
  Result := False;
  FComPort := TNPCCustomCOMPort.Create(nil);
  FComPort.Logger          := Logger;
  FComPort.PortNumber      := FPortParams.PortNum;
  FComPort.PortPrefixOther := FPortParams.PortPrefix;
  FComPort.BaudRate        := FPortParams.BaudRate;
  FComPort.ByteSize        := FPortParams.DataBits;
  FComPort.StopBits        := FPortParams.StopBits;
  FComPort.Parity          := FPortParams.Parity;

  FComPort.Open;
  if not FComPort.Active then
   begin
    CloseThread;
    Exit;
   end;

  Result := True;
end;

procedure TMBRTUPortThread.CloseThread;
begin
  if not Assigned(FComPort) then Exit;
  if FComPort.Active then FComPort.Close;

  FreeAndNil(FComPort);
end;

procedure TMBRTUPortThread.Lock;
begin
  if Assigned(FCSection) then FCSection.Enter;
end;

procedure TMBRTUPortThread.UnLock;
begin
  if Assigned(FCSection) then FCSection.Leave;
end;

end.

