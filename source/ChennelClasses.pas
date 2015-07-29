unit ChennelClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, syncobjs,
     MBDeviceClasses,
     LoggerItf;

type

  { абстрактный класс потока канала }
  TChannelBaseThread = class(TThreadLogged)
   private
    FCSection    : TCriticalSection;
    FDeviceArray : TDeviceArray;
   protected
    procedure Lock;
    procedure UnLock;
   public
    constructor Create(CreateSuspended: Boolean; const StackSize: SizeUInt = 65535); reintroduce;
    property CSection    : TCriticalSection read FCSection write FCSection;
    property DeviceArray : TDeviceArray read FDeviceArray write FDeviceArray;
  end;

  { абстрактный класс канала }
  TChannelBase = class(TObjectLogged)
   private
    FName        : String;           // наименование канала
    FCSection    : TCriticalSection; // критическая секци для доступа к списку устройств
    FDeviceArray : TDeviceArray;     // список устройств
    function  GetActive : Boolean;
    procedure SetCSection(AValue : TCriticalSection);
    procedure SetDeviceArray(AValue : TDeviceArray);
    procedure SetActive(AValue : Boolean);
    procedure SetActiveFalse;
   protected
    FChannelThread : TChannelBaseThread;
    procedure SetLogger(const AValue: IDLogger); override;
    procedure Lock;
    procedure UnLock;

    procedure SetActiveTrue; virtual; abstract;   // создание и запуск потока канала
   public
    constructor Create; virtual;
    destructor  Destroy; override;

    property Name        : String read FName write FName;
    property Active      : Boolean read GetActive write SetActive;
    property CSection    : TCriticalSection read FCSection write SetCSection;
    property DeviceArray : TDeviceArray read FDeviceArray write SetDeviceArray;
  end;

implementation

{ TChannelBaseThread }

procedure TChannelBaseThread.Lock;
begin
  if Assigned(FCSection) then FCSection.Enter;
end;

procedure TChannelBaseThread.UnLock;
begin
  if Assigned(FCSection) then FCSection.Leave;
end;

constructor TChannelBaseThread.Create(CreateSuspended : Boolean; const StackSize : SizeUInt);
begin
  inherited Create(CreateSuspended,StackSize);
end;

{ TChannelBase }

constructor TChannelBase.Create;
begin
  FCSection      := nil;
  FName          := '';
  FChannelThread := nil;
end;

destructor TChannelBase.Destroy;
begin
  if Active then Active := False;
  inherited Destroy;
end;

function TChannelBase.GetActive : Boolean;
begin
  Result := Assigned(FChannelThread);
end;

procedure TChannelBase.SetCSection(AValue : TCriticalSection);
begin
  if FCSection = AValue then Exit;
  FCSection := AValue;
  if Assigned(FChannelThread) then FChannelThread.CSection := FCSection;
end;

procedure TChannelBase.SetDeviceArray(AValue : TDeviceArray);
begin
  if FDeviceArray = AValue then Exit;
  FDeviceArray := AValue;
  Lock;
  try
   if Assigned(FChannelThread) then FChannelThread.DeviceArray := FDeviceArray;
  finally
   UnLock;
  end;
end;

procedure TChannelBase.SetActive(AValue : Boolean);
begin
  if AValue then SetActiveTrue
   else SetActiveFalse;
end;

procedure TChannelBase.SetActiveFalse;
begin
  if not Active then Exit;
  FChannelThread.Terminate;
  FChannelThread.WaitFor;
  FreeAndNil(FChannelThread);
end;

procedure TChannelBase.SetLogger(const AValue : IDLogger);
begin
  inherited SetLogger(AValue);
  if Assigned(FChannelThread) then FChannelThread.Logger := Logger;
end;

procedure TChannelBase.Lock;
begin
  if Assigned(FCSection) then FCSection.Enter;
end;

procedure TChannelBase.UnLock;
begin
  if Assigned(FCSection) then FCSection.Leave;
end;

end.

