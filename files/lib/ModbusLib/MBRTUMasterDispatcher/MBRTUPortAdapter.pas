unit MBRTUPortAdapter;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs, contnrs,
     LoggerItf,
     MBRTUMasterDispatcherTypes, MBRTURequestBase,
     MBRTUObjItf,
     MBRTUPortThread;

type

  { TMBRTUPortAdapter }

  TMBRTUPortAdapter = class(TObjectLogged)
   private
     FCSection       : TCriticalSection;
     FOwnedRequests  : Boolean;
     FPordIDStr      : String;
     FPortParams     : TMBDispPortParam;
     FPoolingObjList : TObjectList;
     FSingleObjQueue : TObjectQueue;
     FPortThread     : TMBRTUPortThread;

     function  GetActive: Boolean;
     function  GetPoolingRequestCount: Integer;
     function  GetPoolingRequests(Index : Integer): TMBRTURequestBase;
     procedure SetActive(AValue: Boolean);
     procedure SetOwnedRequests(AValue: Boolean);
     procedure RemoveRequestFromPoolingObj(ASubscriber : IMBMasterItf);
     procedure RemoveRequestFromSingleObj(ASubscriber : IMBMasterItf);
     // меняет только параметры порта(паритет, битданных и т.п.) но не его имя порта
     procedure SetPortParams(AValue: TMBDispPortParam);
   public
     constructor Create(APortParam : TMBDispPortParam); virtual;
     destructor  Destroy; override;

     procedure AddPoolRequest(var ARequest : TMBRTURequestBase);
     procedure ClearPoolList;
     procedure SendSingleRequest(var ARequest : TMBRTURequestBase);
     procedure ClearSingleQueue;

     // удаляет все запросы подписчика
     procedure RemoveRequests(ASubscriber : IMBMasterItf);

     procedure Lock;
     procedure UnLock;

     procedure Start;
     procedure Stop;
     procedure Restart;

     property PordIDStr     : String read FPordIDStr;
     // установка параметров не меняет имени порта. Имя порта задается только при создении порта.
     property PortParams    : TMBDispPortParam read FPortParams write SetPortParams;
     property Active        : Boolean read GetActive write SetActive;
     property OwnedRequests : Boolean read FOwnedRequests write SetOwnedRequests default True;

     property PoolingRequestCount : Integer read GetPoolingRequestCount;
     property PoolingRequests[Index : Integer] : TMBRTURequestBase read GetPoolingRequests;
  end;

implementation

uses MBRTUMasterDispatcherFunc;

{ TMBRTUPortAdapter }

constructor TMBRTUPortAdapter.Create(APortParam: TMBDispPortParam);
begin
  FCSection       := TCriticalSection.Create;
  FOwnedRequests  := True;
  FPortParams     := APortParam;
  FPordIDStr      := GetPortAdapterIDStr(FPortParams);
  FPoolingObjList := TObjectList.Create(FOwnedRequests);
  FSingleObjQueue := TObjectQueue.Create;
  FPortThread     := nil ;
end;

destructor TMBRTUPortAdapter.Destroy;
begin
  Stop;
  ClearSingleQueue;
  FreeAndNil(FSingleObjQueue);
  ClearPoolList;
  FreeAndNil(FPoolingObjList);
  FreeAndNil(FCSection);
  inherited Destroy;
end;

function TMBRTUPortAdapter.GetActive: Boolean;
begin
  if Assigned(FPortThread) then
   begin
    Result := FPortThread.IsActive;
   end
  else Result := False;
end;

function TMBRTUPortAdapter.GetPoolingRequestCount: Integer;
begin
  Result := FPoolingObjList.Count;
end;

function TMBRTUPortAdapter.GetPoolingRequests(Index : Integer): TMBRTURequestBase;
begin
  Result := nil;
  if (FPoolingObjList.Count = 0) or (Index > (FPoolingObjList.Count-1)) or (Index < 0) then Result := nil;
  Result := TMBRTURequestBase(FPoolingObjList[Index]);
end;

procedure TMBRTUPortAdapter.SetActive(AValue: Boolean);
begin
  if Active = AValue then Exit;
  if AValue then Start
   else Stop;
end;

procedure TMBRTUPortAdapter.Lock;
begin
  FCSection.Enter;
end;

procedure TMBRTUPortAdapter.SetOwnedRequests(AValue: Boolean);
begin
  if FOwnedRequests = AValue then Exit;
  FOwnedRequests := AValue;
  FPoolingObjList.OwnsObjects := AValue;
end;

procedure TMBRTUPortAdapter.UnLock;
begin
  FCSection.Leave;
end;

procedure TMBRTUPortAdapter.AddPoolRequest(var ARequest: TMBRTURequestBase);
begin
  Lock;
  try
   FPoolingObjList.Add(ARequest);
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortAdapter.ClearPoolList;
begin
  Lock;
  try
   FPoolingObjList.Clear;
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortAdapter.SendSingleRequest(var ARequest: TMBRTURequestBase);
begin
  Lock;
  try
    FSingleObjQueue.Push(ARequest);
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortAdapter.ClearSingleQueue;
var TempReq : TMBRTURequestBase;
begin
  Lock;
  try
    TempReq := TMBRTURequestBase(FSingleObjQueue.Pop);
    if FOwnedRequests then FreeAndNil(TempReq);
  finally
   UnLock;
  end;

end;

procedure TMBRTUPortAdapter.RemoveRequests(ASubscriber: IMBMasterItf);
begin
  if not Assigned(ASubscriber) then Exit;
  RemoveRequestFromPoolingObj(ASubscriber);
  RemoveRequestFromSingleObj(ASubscriber);
end;

procedure TMBRTUPortAdapter.RemoveRequestFromPoolingObj(ASubscriber: IMBMasterItf);
var i       : Integer;
    TempReq : TMBRTURequestBase;
begin
  Lock;
  try
    i := FPoolingObjList.Count-1;
    while (i >= 0) do
     begin
      TempReq := TMBRTURequestBase(FPoolingObjList[i]);
      if TempReq.CallBackItf <> ASubscriber then
       begin
        Dec(i);
        Continue;
       end;
      FPoolingObjList.Delete(i);
      if FOwnedRequests then FreeAndNil(TempReq);
      Dec(i);
     end;
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortAdapter.RemoveRequestFromSingleObj(ASubscriber: IMBMasterItf);
var i       : Integer;
    TempReq : TMBRTURequestBase;
begin
  Lock;
  try
    i := FSingleObjQueue.Count-1;
    while (i >= 0) do
     begin
      TempReq := TMBRTURequestBase(FSingleObjQueue.Pop);
      if TempReq.CallBackItf <> ASubscriber then
       begin
        FSingleObjQueue.Push(TempReq);
        Dec(i);
        Continue;
       end;
      if FOwnedRequests then FreeAndNil(TempReq);
      Dec(i);
     end;
  finally
   UnLock;
  end;
end;

procedure TMBRTUPortAdapter.SetPortParams(AValue: TMBDispPortParam);
begin
  FPortParams.BaudRate := AValue.BaudRate;
  FPortParams.DataBits := AValue.DataBits;
  FPortParams.Parity   := AValue.Parity;
  FPortParams.StopBits := AValue.StopBits;
end;

procedure TMBRTUPortAdapter.Start;
begin
  if Assigned(FPortThread) then Exit;

  FPortThread := TMBRTUPortThread.Create(FPortParams,
                                         FCSection,
                                         FPoolingObjList,
                                         FSingleObjQueue,
                                         FOwnedRequests);
  FPortThread.Logger := Logger;
  FPortThread.Start;
end;

procedure TMBRTUPortAdapter.Stop;
begin
  if not Assigned(FPortThread) then Exit;
  FPortThread.Terminate;
  FPortThread.WaitFor;
  FreeAndNil(FPortThread);
end;

procedure TMBRTUPortAdapter.Restart;
begin
  if Assigned(FPortThread) then Stop;
  Start;
end;

end.

