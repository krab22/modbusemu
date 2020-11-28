unit COMPortChooseFrame;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, CheckLst, StdCtrls,
     LoggerItf,
     MBRTUMasterDispatcherTypes,
     COMPortInfoObj,COMPortParamTypes;

type

  { TframCoosePort }

  TframCoosePort = class(TFrame)
   btnAply           : TButton;
   btnCancel         : TButton;
   gbPort            : TGroupBox;
   chlPortList       : TCheckListBox;
   btnPortListUpdate : TButton;
   gbPortParams      : TGroupBox;
   lbPortBaudRate    : TLabel;
   cbPortBaudRate    : TComboBox;
   lbPortDataBits    : TLabel;
   cbPortDataBits    : TComboBox;
   lbPortStopBits    : TLabel;
   cbPortStopBits    : TComboBox;
   lbPortParity      : TLabel;
   cbPortParity      : TComboBox;
   lbPortList        : TLabel;
   procedure btnAplyClick(Sender: TObject);
   procedure btnCancelClick(Sender: TObject);
   procedure btnPortListUpdateClick(Sender: TObject);
   procedure cbPortBaudRateChange(Sender: TObject);
   procedure cbPortDataBitsChange(Sender: TObject);
   procedure cbPortParityChange(Sender: TObject);
   procedure cbPortStopBitsChange(Sender: TObject);
   procedure chlPortListClickCheck(Sender: TObject);
  private
   FLogger       : IDLogger;
   FOnCancelPort : TNotifyEvent;
   FOnSelectPort : TNotifyEvent;
   FPortParams   : TMBDispPortParam;

   FPortsIfoObj  : TCOMMPortInfoList;

   procedure OnFoundDevProc(Sender : TObject; APortInfo : TCOMMPortInfo);
   procedure OnLostDevProc(Sender : TObject; APortInfo : TCOMMPortInfo);
   procedure OnChangeDevProc(Sender : TObject; APortInfo : TCOMMPortInfo);

   procedure SetLogger(AValue: IDLogger);
   procedure SetPortParams(AValue: TMBDispPortParam);

   function  SearchIndexOfPort(APortName : String): Integer;
   procedure UncheckOther(ACheckedIndex : Integer);

   procedure SetPortParamData(APortIndex : Integer);
  public
   constructor Create(AOwner : TComponent); override;
   destructor  Destroy; override;

   procedure UpdatePortsList;
   procedure UpdatePortsStatus;

   property Logger             : IDLogger read FLogger write SetLogger;
   property SelectedPortParams : TMBDispPortParam read FPortParams write SetPortParams;

   property OnSelectPort       : TNotifyEvent read FOnSelectPort write FOnSelectPort;
   property OnCancelPort       : TNotifyEvent read FOnCancelPort write FOnCancelPort;
  end;

implementation

{$R *.frm}

uses COMPortResStr, COMPortConsts,
     Localize;

{ TframCoosePort }

constructor TframCoosePort.Create(AOwner: TComponent);
var i, TempLen : Integer;
begin
  inherited Create(AOwner);

  TranslateAppObject(Self);

  TempLen := Length(ComPortBaudRateNames) - 2;
  for i := 0 to TempLen do cbPortBaudRate.AddItem(ComPortBaudRateNames[TComPortBaudRate(i)],nil);
  cbPortBaudRate.ItemIndex := Integer(br9600);

  TempLen := Length(ComPortDataBitsNames) - 2;
  for i := 0 to TempLen do cbPortDataBits.AddItem(ComPortDataBitsNames[TComPortDataBits(i)],nil);
  cbPortDataBits.ItemIndex := Integer(db8BITS);

  TempLen := Length(ComPortStopBitsNames) - 2;
  for i := 0 to TempLen do cbPortStopBits.AddItem(ComPortStopBitsNames[TComPortStopBits(i)],nil);
  cbPortStopBits.ItemIndex := Integer(sb1BITS);

  TempLen := Length(ComPortParityEngNames) - 2;
  for i := 0 to TempLen do cbPortParity.AddItem(ComPortParityEngNames[TComPortParity(i)],nil);
  cbPortParity.ItemIndex := Integer(ptEVEN);

  {$IFDEF LINUX}
  FPortParams.PortNum    := 0;
  FPortParams.PortPrefix := csLinuxCOMMPrefix0;
  {$ENDIF}
  {$IFDEF WINDOWS}
  FPortParams.PortNum    := 1;
  FPortParams.PortPrefix := csWindowsCOMMPrefix;
  {$ENDIF}
  FPortParams.BaudRate := br9600;
  FPortParams.DataBits := db8BITS;
  FPortParams.StopBits := sb1BITS;
  FPortParams.Parity   := ptEVEN;

  FPortsIfoObj := TCOMMPortInfoList.Create;
  FPortsIfoObj.OnFoundNewDevice        := @OnFoundDevProc;
  FPortsIfoObj.OnLostDevice            := @OnLostDevProc;
  FPortsIfoObj.OnChangeDeviceStatus    := @OnChangeDevProc;

  FPortsIfoObj.UpdeteDeviceList;
end;

destructor TframCoosePort.Destroy;
begin
  FreeAndNil(FPortsIfoObj);
  inherited Destroy;
end;

procedure TframCoosePort.UpdatePortsList;
begin
  FPortsIfoObj.UpdeteDeviceList;
end;

procedure TframCoosePort.UpdatePortsStatus;
begin
  FPortsIfoObj.UpdateAllStatus;
end;

procedure TframCoosePort.chlPortListClickCheck(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  UncheckOther(TempIndex);
  if chlPortList.Checked[TempIndex] then btnAply.Enabled := True
   else btnAply.Enabled := False;
  SetPortParamData(TempIndex);
end;

procedure TframCoosePort.btnPortListUpdateClick(Sender: TObject);
begin
  FPortsIfoObj.UpdeteDeviceList;
end;

procedure TframCoosePort.cbPortBaudRateChange(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  if not chlPortList.ItemEnabled[TempIndex] then Exit;
  FPortParams.BaudRate := TComPortBaudRate(cbPortBaudRate.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TframCoosePort.cbPortDataBitsChange(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  if not chlPortList.ItemEnabled[TempIndex] then Exit;
  FPortParams.DataBits := TComPortDataBits(cbPortDataBits.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TframCoosePort.cbPortParityChange(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  if not chlPortList.ItemEnabled[TempIndex] then Exit;
  FPortParams.Parity := TComPortParity(cbPortParity.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TframCoosePort.cbPortStopBitsChange(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  if not chlPortList.ItemEnabled[TempIndex] then Exit;
  FPortParams.StopBits := TComPortStopBits(cbPortStopBits.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TframCoosePort.btnAplyClick(Sender: TObject);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.ItemIndex;
  if not chlPortList.ItemEnabled[TempIndex] then Exit;
  SetPortParamData(TempIndex);
  if Assigned(FOnSelectPort) then FOnSelectPort(Self);
end;

procedure TframCoosePort.btnCancelClick(Sender: TObject);
begin
  if Assigned(FOnCancelPort) then FOnCancelPort(Self);
end;

procedure TframCoosePort.OnFoundDevProc(Sender: TObject; APortInfo: TCOMMPortInfo);
var TempIndex : Integer;
begin
  TempIndex := chlPortList.Items.AddObject(Format('%s - %s',[APortInfo.Name,rsCOMString4]),APortInfo);
  chlPortList.ItemEnabled[TempIndex] := APortInfo.IsExist;
end;

procedure TframCoosePort.OnLostDevProc(Sender: TObject; APortInfo: TCOMMPortInfo);
var TempIndex : Integer;
begin
   TempIndex := SearchIndexOfPort(APortInfo.Name);
   if TempIndex = -1 then Exit;
   chlPortList.Items.Objects[TempIndex] := nil;
   if TempIndex = chlPortList.ItemIndex then chlPortList.ItemIndex := 0;
   if chlPortList.Checked[TempIndex] then chlPortList.Checked[0]   := True;
   chlPortList.Items.Delete(TempIndex);
end;

procedure TframCoosePort.OnChangeDevProc(Sender: TObject; APortInfo: TCOMMPortInfo);
var TempIndex : Integer;
begin
  TempIndex := SearchIndexOfPort(APortInfo.Name);
  if TempIndex = -1 then Exit;
  if APortInfo.IsExist then
   begin
    if APortInfo.IsAvailable then
     begin // свободен
      chlPortList.Items.Strings[TempIndex] := Format('%s - %s',[APortInfo.Name,rsCOMString2]);
     end
    else
     begin // занят
      chlPortList.Items.Strings[TempIndex] := Format('%s - %s',[APortInfo.Name,rsCOMString5]);
     end;
   end
  else
   begin // отсутствует
    chlPortList.Items.Strings[TempIndex] := Format('%s - %s',[APortInfo.Name,rsCOMString4]);
   end;
  chlPortList.ItemEnabled[TempIndex] := APortInfo.IsAvailable;
end;

procedure TframCoosePort.SetLogger(AValue: IDLogger);
begin
  if FLogger = AValue then Exit;
  FLogger             := AValue;
  FPortsIfoObj.Logger := FLogger;
end;

procedure TframCoosePort.SetPortParams(AValue: TMBDispPortParam);
var TempIndex : Integer;
    TempName  : String;
begin
  FPortParams := AValue;

  TempName := Format('%s%d',[FPortParams.PortPrefix,FPortParams.PortNum]);

  TempIndex := SearchIndexOfPort(TempName);
  if TempIndex = -1 then Exit;

  UncheckOther(TempIndex);
  chlPortList.ItemIndex := TempIndex;
  chlPortList.Checked[TempIndex] := True;

  cbPortBaudRate.ItemIndex := Integer(FPortParams.BaudRate);
  cbPortDataBits.ItemIndex := Integer(FPortParams.DataBits);
  cbPortStopBits.ItemIndex := Integer(FPortParams.StopBits);
  cbPortParity.ItemIndex   := Integer(FPortParams.Parity);
end;

function TframCoosePort.SearchIndexOfPort(APortName: String): Integer;
var Res, i, Count : Integer;
begin
  Result := -1;
  Count  := chlPortList.Items.Count-1;
  for i := 0 to Count do
   begin
    Res:= pos(APortName,chlPortList.Items.Strings[i]);
    if Res > 0 then
     begin
      Result := i;
      Break;
     end;
   end;
end;

procedure TframCoosePort.UncheckOther(ACheckedIndex: Integer);
var i, Count : Integer;
begin
  Count := chlPortList.Count-1;
  for i:= 0 to Count do
   begin
    if i = ACheckedIndex then Continue;
    chlPortList.Checked[i] := False;
   end;
end;

procedure TframCoosePort.SetPortParamData(APortIndex: Integer);
begin
  FPortParams.PortNum    := TCOMMPortInfo(chlPortList.Items.Objects[APortIndex]).Num;
  FPortParams.PortPrefix := TCOMMPortInfo(chlPortList.Items.Objects[APortIndex]).Prefix;
  FPortParams.BaudRate   := TComPortBaudRate(cbPortBaudRate.ItemIndex);
  FPortParams.DataBits   := TComPortDataBits(cbPortDataBits.ItemIndex);
  FPortParams.StopBits   := TComPortStopBits(cbPortStopBits.ItemIndex);
  FPortParams.Parity     := TComPortParity(cbPortParity.ItemIndex);
end;

end.

