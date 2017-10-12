unit COMPortInfoObj;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, IniFiles,
     LoggerItf;

type

  { TCOMMPortInfo }

  TCOMMPortInfo = class(TObjectLogged)
   private
     FData           : Pointer;
     FIsAvailable    : Boolean;
     FIsExist        : Boolean;
     FNum            : Byte;
     FPrefix         : String;
     FOnChangeStatus : TNotifyEvent;
     FOnDeviceLost   : TNotifyEvent;

     function GetFullPath: String;
     function GetName: String;
   public
     constructor Create(ANum : Byte; APrefix : String); virtual;
     destructor  Destroy; override;

     function CheckDeviceAvailability : Boolean; // проверка наличия и доступности устройства

     property FullPath    : String read GetFullPath;
     property Name        : String read GetName;
     property Num         : Byte read FNum;
     property Prefix      : String read FPrefix;
     property IsAvailable : Boolean read FIsAvailable;
     property IsExist     : Boolean read FIsExist;
     property Data        : Pointer read FData write FData;

     // устройство дотупно для использования или нет
     property OnChangeStatus : TNotifyEvent read FOnChangeStatus write FOnChangeStatus;
     // устройство пропало - USB
     property OnDeviceLost   : TNotifyEvent read FOnDeviceLost write FOnDeviceLost;
  end;

  TOnFoundNewDevice = procedure (Sender : TObject; APortInfo : TCOMMPortInfo) of object;

  { TCOMMPortInfoList }

  TCOMMPortInfoList = class(TObjectLogged)
   private
     FOnChangeDeviceStatus: TOnFoundNewDevice;
     FPortList                : THashedStringList;
     FOnAfterFillingList      : TNotifyEvent;
     FOnBeforeClearDeviceList : TNotifyEvent;
     FOnFoundNewDevice        : TOnFoundNewDevice;
     FOnLostDevice            : TOnFoundNewDevice;
     function GetPortCount: Integer;
     function GetPorts(Index : Integer): TCOMMPortInfo;

     procedure OnChangeStatusProc(Sender : TObject);
     procedure OnDeviceLostProc(Sender : TObject);

     function MakeDevPath(APath : String; APrefix : String; ADevNum : Byte) : String;
     function MakeDevName(APrefix : String; ADevNum : Byte) : String;
   protected
     procedure SetLogger(const AValue: IDLogger); override;
   public
     constructor Create; virtual;
     destructor  Destroy; override;

     procedure UpdateAllStatus;         // проверить статус всех устройств
     procedure RereadDeviceList;        // перечитать список устройств(с уничтожением имеющегося списка)
     procedure UpdeteDeviceList;        // перечитать список устройств(без уничтожения имеющегося списка)
     procedure Clear;                   // очистить список устройств

     function  GetPortList : TStrings;

     property PortCount : Integer read GetPortCount;
     property Ports[Index : Integer] : TCOMMPortInfo read GetPorts;

     // перед очисткой списка устройств
     property OnBeforeClearDeviceList : TNotifyEvent read FOnBeforeClearDeviceList write FOnBeforeClearDeviceList;
     // после заполнения списка устройств
     property OnAfterFillingList      : TNotifyEvent read FOnAfterFillingList write FOnAfterFillingList;
     // события могут возникать при UpdateDeviceList - найдено новое устройство - его нет в списке
     property OnFoundNewDevice        : TOnFoundNewDevice read FOnFoundNewDevice write FOnFoundNewDevice;
     // пропало устройство имеющееся в писке
     property OnLostDevice            : TOnFoundNewDevice read FOnLostDevice write FOnLostDevice;
     // вызывается при изменении статуса какого либо устройства
     property OnChangeDeviceStatus    : TOnFoundNewDevice read FOnChangeDeviceStatus write FOnChangeDeviceStatus;
  end;

implementation

uses COMPortConsts, COMPortParamTypes, COMPortInfoResStr
     {$IFDEF WINDOWS}
     ,strutils
     {$ENDIF}
     ;

{ TCOMMPortInfoList }

constructor TCOMMPortInfoList.Create;
begin
  FPortList := THashedStringList.Create;
end;

destructor TCOMMPortInfoList.Destroy;
begin
  Clear;
  FreeAndNil(FPortList);
  inherited Destroy;
end;

function TCOMMPortInfoList.GetPortCount: Integer;
begin
  Result := FPortList.Count;
end;

function TCOMMPortInfoList.GetPorts(Index : Integer): TCOMMPortInfo;
begin
  Result := TCOMMPortInfo(FPortList.Objects[Index]);
end;

procedure TCOMMPortInfoList.OnChangeStatusProc(Sender: TObject);
begin
  if Assigned(FOnChangeDeviceStatus) then
   begin
    try
     FOnChangeDeviceStatus(Self,TCOMMPortInfo(Sender));
    except
     on E : Exception do SendLogMessage(llError,rsPortList,Format('%s',[E.Message]));
    end;
   end;
end;

procedure TCOMMPortInfoList.OnDeviceLostProc(Sender: TObject);
begin
  if Assigned(FOnLostDevice) then
   begin
    try
     FOnLostDevice(Self,TCOMMPortInfo(Sender));
    except
     on E : Exception do SendLogMessage(llError,rsPortList,Format('%s',[E.Message]));
    end;
   end;
end;

function TCOMMPortInfoList.MakeDevPath(APath: String; APrefix: String; ADevNum: Byte): String;
begin
  Result := Format('%s%s%d',[APath,
                             APrefix,
                             ADevNum]);
end;

function TCOMMPortInfoList.MakeDevName(APrefix: String; ADevNum: Byte): String;
begin
  Result := Format('%s%d',[APrefix,
                           ADevNum]);
end;

procedure TCOMMPortInfoList.SetLogger(const AValue: IDLogger);
var i,Count : Integer;
    TempPort : TCOMMPortInfo;
begin
  inherited SetLogger(AValue);
  Count := FPortList.Count;
  for i := 0 to Count-1 do
   begin
    TempPort := TCOMMPortInfo(FPortList.Objects[i]);
    if Assigned(TempPort) then TempPort.Logger := AValue;
   end;
end;

procedure TCOMMPortInfoList.UpdateAllStatus;
var i,Count : Integer;
    TempPort : TCOMMPortInfo;
begin
  Count := FPortList.Count;
  for i := 0 to Count-1 do
   begin
    TempPort := TCOMMPortInfo(FPortList.Objects[i]);
    if Assigned(TempPort) then TempPort.CheckDeviceAvailability;
   end;
end;

procedure TCOMMPortInfoList.RereadDeviceList;
begin
  Clear;
  UpdeteDeviceList;
end;

procedure TCOMMPortInfoList.UpdeteDeviceList;
var TempPrefix, TempName : String;
    i, TempIndex : Integer;
    TempPortInfo : TCOMMPortInfo;
    isFillingList : Boolean;
    {$IFDEF LINUX}
     TempPath : String;
     ii : Integer;
    {$ENDIF}
    {$IFDEF WINDOWS}
    TempPortList : TStringList;
    TempPortNum  : Byte;
    {$ENDIF}
begin
  isFillingList := False;
  {$IFDEF LINUX}
   for i := 0 to ComPortLinuxPrefixMaxIndex do
    begin
     TempPrefix     := ComPortLinuxPrefixNames[TComPortLinuxPrefixEnum(i)];
     for ii := 0 to 255 do
      begin
       TempName  := MakeDevName(TempPrefix, ii);
       TempPath  := MakeDevPath(csLinuxCOMMPath, TempPrefix, ii);
       TempIndex := FPortList.IndexOf(TempName);
       // выходим при ненахождении устройства с номером ii - нумерация непрерывная
       if not FileExists(TempPath) then
        begin // порта нет в системе
         if TempIndex <> -1 then
          begin // порт был, но пропал
            TempPortInfo := TCOMMPortInfo(FPortList.Objects[TempIndex]);
            if Assigned(FOnLostDevice) then
             begin
              FOnLostDevice(Self,TempPortInfo);
             end;
            // удаляем устройство из списка
            FPortList.Delete(TempIndex);
            FreeAndNil(TempPortInfo);
            isFillingList := True;
          end
         else Break;
        end
       else
        begin; // порт есть в системе
         if TempIndex = -1 then
          begin // порта не было раньше в списке
           TempPortInfo := TCOMMPortInfo.Create(ii,TempPrefix);
           TempPortInfo.Logger := Logger;
           TempPortInfo.OnChangeStatus := @OnChangeStatusProc;
           TempPortInfo.OnDeviceLost   := @OnDeviceLostProc;
           FPortList.AddObject(TempPortInfo.Name,TempPortInfo);
           if Assigned(FOnFoundNewDevice) then
            begin
             FOnFoundNewDevice(Self,TempPortInfo);
            end;
           isFillingList := True;
          end
         else TempPortInfo := TCOMMPortInfo(FPortList.Objects[TempIndex]); // порт уже есть в списке
         TempPortInfo.CheckDeviceAvailability;
        end;
      end;
    end;
  {$ELSE}
  // https://github.com/inthehand/32feet/wiki/Getting-Virtual-COM-Port-Names
  // http://forums.codeguru.com/showthread.php?326884-How-to-enumerate-serial-ports-(please-not-GetDefaultCommConfig!)
  // https://msdn.microsoft.com/ru-ru/library/windows/desktop/aa363262(v=vs.85).aspx
    TempPrefix := csWindowsCOMMPrefix;
    TempPortList := GetPortListFromRegistry;
    if not Assigned(TempPortList) then // не найдено ни одного порта
     begin
      Clear;
      Exit;
     end;
    try
     // проверяем проподание порта
     for i := 0 to FPortList.Count - 1 do
      begin
       TempIndex := TempPortList.IndexOf(FPortList.Strings[i]);
       if TempIndex <> -1 then Continue; //порт уже есть
       // порта в новом списке нет, а в старом еще есть
       TempPortInfo := TCOMMPortInfo(FPortList.Objects[i]);
       if Assigned(FOnLostDevice) then
        begin
         FOnLostDevice(Self,TempPortInfo);
        end;
       // удаляем устройство из списка
       FPortList.Delete(i);
       FreeAndNil(TempPortInfo);
       isFillingList := True;
      end;
     // добавляем существующие
     for i := 0 to TempPortList.Count - 1 do
      begin
       TempPortNum := StrToInt(StringReplace(TempPortList.Strings[i],csWindowsCOMMPrefix,'',[rfReplaceAll,rfIgnoreCase]));
       TempName    := MakeDevName(TempPrefix,TempPortNum);
       TempIndex   := FPortList.IndexOf(TempName);

       if TempIndex = -1 then
        begin // порта не было раньше в списке
         TempPortInfo := TCOMMPortInfo.Create(TempPortNum,TempPrefix);
         TempPortInfo.Logger := Logger;
         TempPortInfo.OnChangeStatus := @OnChangeStatusProc;
         TempPortInfo.OnDeviceLost   := @OnDeviceLostProc;
         FPortList.AddObject(TempPortInfo.Name,TempPortInfo);
         if Assigned(FOnFoundNewDevice) then
          begin
           FOnFoundNewDevice(Self,TempPortInfo);
          end;
         isFillingList := True;
        end
       else TempPortInfo := TCOMMPortInfo(FPortList.Objects[TempIndex]); // порт уже есть в списке
       TempPortInfo.CheckDeviceAvailability;
      end;
    finally
      FreeAndNil(TempPortList);
    end;
  {$ENDIF}

  if isFillingList then //вызывать только после добавления чего либо в список
   if Assigned(FOnAfterFillingList) then
    begin
     try
      FOnAfterFillingList(Self);
     except
      on E : Exception do SendLogMessage(llError,rsPortList,Format('%s',[E.Message]));
     end;
    end;
end;

procedure TCOMMPortInfoList.Clear;
var i,Count : Integer;
    TempPort : TCOMMPortInfo;
begin
  Count := FPortList.Count;

  if Count > 0 then // вызывать обработчие если список не пуст
   if Assigned(FOnBeforeClearDeviceList) then
    begin
      try
       FOnBeforeClearDeviceList(Self);
      except
       on E : Exception do SendLogMessage(llError,rsPortList,Format(rsErrorCLH,[E.Message]));
      end;
    end;
  for i := 0 to Count-1 do
   begin
    TempPort := TCOMMPortInfo(FPortList.Objects[i]);
    if not Assigned(TempPort) then Continue;
    if Assigned(FOnLostDevice) then
     begin
      try
       FOnLostDevice(Self,TempPort);
      except
       on E : Exception do SendLogMessage(llError,rsPortList,Format('%s',[E.Message]));
      end;
     end;
    FreeAndNil(TempPort);
    FPortList.Objects[i] := TempPort;
   end;
  FPortList.Clear;
end;

function TCOMMPortInfoList.GetPortList: TStrings;
begin
  Result := FPortList;
end;

{ TCOMMPortInfo }

constructor TCOMMPortInfo.Create(ANum: Byte; APrefix: String);
begin
  FNum            := ANum;
  FPrefix         := APrefix;
  FIsAvailable    := False;
  {$IFDEF UNIX}
  FIsExist        := False;
  {$ENDIF}
  {$IFDEF WINDOWS}
  FIsExist        := True;
  {$ENDIF}
  FData           := nil;
  FOnChangeStatus := nil;
  FOnDeviceLost   := nil;
end;

destructor TCOMMPortInfo.Destroy;
begin
  inherited Destroy;
end;

function TCOMMPortInfo.CheckDeviceAvailability: Boolean;
var TemPath : String;
    {$IFDEF WINDOWS}
     TempPortList : TStringList;
     TempName : String;
    {$ENDIF}
    TempExist : Boolean;
    procedure SetPortNotExist;
    begin
     if FIsExist then // если раньше порт был...
      begin
       FIsExist     := False;
       FIsAvailable := False;
       if Assigned(FOnDeviceLost) then
        begin
         FOnDeviceLost(Self);
        end;
      end;
    end;
begin
 Result := False;
 TemPath := GetFullPath;
 {$IFDEF LINUX}
   TempExist := FileExists(TemPath);
 {$ELSE}
   Result := False;
   TempName := GetName;
   TempPortList := GetPortListFromRegistry;
   try
    if not Assigned(TempPortList) then
     begin
      SetPortNotExist;
      Exit;
     end;
    TempExist := TempPortList.IndexOf(TempName) <> -1;
   finally
    FreeAndNil(TempPortList);
   end;
 {$ENDIF}

   if not TempExist then
    begin // порт пропал
     SetPortNotExist;
    end
   else
    begin //порт есть
     FIsExist := True;
     Result := IsPortAvailabilityForUse(TemPath);
     if FIsAvailable = Result then Exit;
     FIsAvailable := Result;
     if Assigned(FOnChangeStatus) then
      begin
       FOnChangeStatus(Self);
      end;
    end;
end;

function TCOMMPortInfo.GetFullPath: String;
begin
 {$IFDEF LINUX}
   Result := Format('%s%s%d',[csLinuxCOMMPath,FPrefix,FNum]);
 {$ELSE}
   Result := Format('%s%s%d',[csWindowsCOMMPath,FPrefix,FNum]);
 {$ENDIF}
end;

function TCOMMPortInfo.GetName: String;
begin
  Result := Format('%s%d',[FPrefix,FNum]);
end;

end.

