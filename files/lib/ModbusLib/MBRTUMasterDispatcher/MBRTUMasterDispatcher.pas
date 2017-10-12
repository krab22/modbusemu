unit MBRTUMasterDispatcher;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, IniFiles,
     LoggerItf,
     MBRTURequestBase, MBRTUMasterDispatcherTypes,
     MBRTUPortAdapter;

type
  { TMBRTUMasterDispatcher }

  TMBRTUMasterDispatcher = class(TObjectLogged)
    private
      FOwnedRequests : Boolean;
      FPortList      : THashedStringList;
      function  GetPortForName(AName : String): TMBRTUPortAdapter;
      function  GetPorts(Index : Integer): TMBRTUPortAdapter;
      function  GetPortsCount: Integer;
      procedure SetOwnedRequests(AValue: Boolean);

      function  SearchPort(APortName : String) : TMBRTUPortAdapter;

    protected
      procedure SetLogger(const AValue: IDLogger); override;
    public
      constructor Create; virtual;
      destructor  Destroy; override;

      function  AddPort(APortParam : TMBDispPortParam) : TMBRTUPortAdapter;
      function  DeletePort(APortParam : TMBDispPortParam) : TMBRTUPortAdapter; overload;
      function  DeletePort(Index : Integer) : TMBRTUPortAdapter; overload;
      procedure Clear;

      // поставить запрос в пул постоянного опроса
      function  AddPoolObject(APortParam : TMBDispPortParam; var ARequest : TMBRTURequestBase) : Boolean;
      // выполнить одиночный запрос
      function  SendSingleRequest(APortParam : TMBDispPortParam; var ARequest : TMBRTURequestBase) : Boolean;

      procedure Start;
      procedure Stop;

      property PortsCount : Integer read GetPortsCount;
      property Ports[Index : Integer]      : TMBRTUPortAdapter read GetPorts;
      property PortForName[AName : String] : TMBRTUPortAdapter read GetPortForName;

      property OwnedRequests : Boolean read FOwnedRequests write SetOwnedRequests default True;
  end;

implementation

uses MBRTUMasterDispatcherFunc;

{ TMBRTUMasterDispatcher }

constructor TMBRTUMasterDispatcher.Create;
begin
  FPortList      := THashedStringList.Create;
  FOwnedRequests := True;
end;

destructor TMBRTUMasterDispatcher.Destroy;
begin
  Clear;
  FreeAndNil(FPortList);
  inherited Destroy;
end;

procedure TMBRTUMasterDispatcher.Start;
var TempCount, i : Integer;
begin
  TempCount := PortsCount-1;
  for i := 0 to TempCount do Ports[i].Start;
end;

procedure TMBRTUMasterDispatcher.Stop;
var TempCount, i : Integer;
begin
  TempCount := PortsCount-1;
  for i := 0 to TempCount do Ports[i].Stop;
end;

function TMBRTUMasterDispatcher.GetPortForName(AName : String): TMBRTUPortAdapter;
begin
  Result := SearchPort(AName);
end;

function TMBRTUMasterDispatcher.GetPorts(Index : Integer): TMBRTUPortAdapter;
begin
  Result := TMBRTUPortAdapter(FPortList.Objects[Index]);
end;

function TMBRTUMasterDispatcher.GetPortsCount: Integer;
begin
  Result := FPortList.Count;
end;

function TMBRTUMasterDispatcher.SearchPort(APortName: String): TMBRTUPortAdapter;
var i : Integer;
begin
  Result := nil;
  i := FPortList.IndexOf(APortName);
  if i = -1 then Exit;
  Result := TMBRTUPortAdapter(FPortList.Objects[i]);
end;

procedure TMBRTUMasterDispatcher.SetOwnedRequests(AValue: Boolean);
var i        : Integer;
    TempPort : TMBRTUPortAdapter;
begin
  if FOwnedRequests = AValue then Exit;
  FOwnedRequests := AValue;
  for i := 0 to FPortList.Count-1 do
   begin
     TempPort := TMBRTUPortAdapter(FPortList.Objects[i]);
     TempPort.OwnedRequests := FOwnedRequests;
   end;
end;

procedure TMBRTUMasterDispatcher.SetLogger(const AValue: IDLogger);
var i        : Integer;
    TempPort : TMBRTUPortAdapter;
begin
  inherited SetLogger(AValue);
  for i := 0 to FPortList.Count-1 do
   begin
     TempPort := TMBRTUPortAdapter(FPortList.Objects[i]);
     TempPort.Logger := Logger;
   end;
end;

function TMBRTUMasterDispatcher.AddPort(APortParam: TMBDispPortParam): TMBRTUPortAdapter;
var TempName : String;
begin
  TempName := GetPortAdapterIDStr(APortParam);
  Result := SearchPort(TempName);
  if Result <> nil then Exit;
  Result := TMBRTUPortAdapter.Create(APortParam);
  Result.Logger        := Logger;
  Result.OwnedRequests := FOwnedRequests;
  FPortList.AddObject(TempName,Result);
end;

function TMBRTUMasterDispatcher.DeletePort(APortParam: TMBDispPortParam): TMBRTUPortAdapter;
var TempName : String;
    i : Integer;
begin
   Result := nil;
   TempName := GetPortAdapterIDStr(APortParam);
   i := FPortList.IndexOf(TempName);
   if i = -1 then Exit;
   Result := TMBRTUPortAdapter(FPortList.Objects[i]);
   FPortList.Delete(i);
end;

function TMBRTUMasterDispatcher.DeletePort(Index: Integer): TMBRTUPortAdapter;
begin
  Result := TMBRTUPortAdapter(FPortList.Objects[Index]);
  FPortList.Delete(Index);
end;

procedure TMBRTUMasterDispatcher.Clear;
var i, Count : Integer;
    TempPort : TMBRTUPortAdapter;
begin
  Count := FPortList.Count-1;
  if Count = -1 then Exit;
  for i := Count downto 0 do
   begin
     TempPort := TMBRTUPortAdapter(FPortList.Objects[i]);
     FPortList.Delete(i);
     FreeAndNil(TempPort);
   end;
end;

function TMBRTUMasterDispatcher.AddPoolObject(APortParam : TMBDispPortParam; var ARequest : TMBRTURequestBase) : Boolean;
var TempName : String;
    TempPort : TMBRTUPortAdapter;
begin
  Result := False;
  TempName := GetPortAdapterIDStr(APortParam);
  TempPort := SearchPort(TempName);
  if TempPort = nil then TempPort := AddPort(APortParam);
  TempPort.AddPoolRequest(ARequest);
  Result := True;
end;

function TMBRTUMasterDispatcher.SendSingleRequest(APortParam: TMBDispPortParam; var ARequest: TMBRTURequestBase) : Boolean;
var TempName : String;
    TempPort : TMBRTUPortAdapter;
begin
  Result := False;
  TempName := GetPortAdapterIDStr(APortParam);
  TempPort := SearchPort(TempName);
  if TempPort = nil then TempPort := AddPort(APortParam);
  TempPort.SendSingleRequest(ARequest);
  Result := True;
end;

end.

