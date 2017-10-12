unit ChoosePort;

{$MODE Delphi}

interface

uses {$IFDEF WINDOWS}Windows,{$ENDIF} SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Messages, Spin, CheckLst;

const
  // коды ошибок выполнения
  NO_ERR  = 0; // ошибок нет
  COM_ERR = 1; // ошибка СОМ-порта
  DEVICE_ERR  = 2; // ошибка устройства
  PACKAGE_ERR = 3; // ошибка пакета

resourcestring
  STR_WARNING = 'Предупреждение';
  STR_PORT_FAULT = 'Выбранный порт не существует или используется другим приложением. Применить настройки?';
  CHECK_TIMER_CTR = 'Период ожидания:';

type
  TPortParams = record
    AutoCreateDeviceNumD: boolean;
    RegsCount  : byte;
    DeviceNumM : byte;
    DeviceNumD : byte;
    MasterNumM : byte;
    MasterNumD : byte;
    PortNum    : byte;
    Baud       : byte;
    DataBits   : byte;
    StopBits   : byte;
    Parity     : byte;
    BrakeInterval: integer;
  end;

  { TfmChoosePort }

  TfmChoosePort = class(TForm)
    btnOk: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    lbPorts: TCheckListBox;
    btnUpdate: TBitBtn;
    Label3: TLabel;
    cbBaud: TComboBox;
    Label4: TLabel;
    cbDataBits: TComboBox;
    Label5: TLabel;
    cbStopBits: TComboBox;
    Label6: TLabel;
    cbParity: TComboBox;
    Label2: TLabel;
    seRespondTimeOut: TSpinEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    seDeviceNumM: TSpinEdit;
    Label7: TLabel;
    seDeviceNumD: TSpinEdit;
    cbAutoCreateDevNum: TCheckBox;
    Bevel2: TBevel;
    Label8: TLabel;
    seDeviceMasterNumM: TSpinEdit;
    Label9: TLabel;
    seDeviceMasterNumD: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    seRegsCount: TSpinEdit;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure lbPortsClickCheck(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure SpinEditExit(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cbAutoCreateDevNumClick(Sender: TObject);
  private
    { Private declarations }
    procedure IniPortsList(const CurrPort: byte);

    procedure GetCurrParams(var Dest: TPortParams);
    procedure SetCurrParams(const AValue: TPortParams);
    function  CheckCurrParams: boolean;
  public
    { Public declarations }
    SourceParams: TPortParams;
  end;

var
  fmChoosePort: TfmChoosePort;

function CheckComPort(const Num: integer): boolean;
function GetCOM_Params(AOwner: TComponent; var Params: TPortParams): boolean;

implementation

{$R *.lfm}

uses Localize;

function CheckComPort(const Num: integer): boolean;
var {$IFDEF WINDOWS}hComm : hFile;{$ENDIF}
    ComName : array[0..12] of Char;
begin
  {$IFDEF WINDOWS}
  hComm := CreateFile(StrFmt(ComName,'\\.\COM%d',[Num]),
                      GENERIC_READ or GENERIC_WRITE,
                      0,
                      nil,
                      OPEN_EXISTING,
                      FILE_ATTRIBUTE_NORMAL or
                      FILE_FLAG_OVERLAPPED,
                      0);
  if hComm <> INVALID_HANDLE_VALUE then
  begin
    Result:= true;
    CloseHandle(hComm);
  end
  else Result:= false;
  {$ENDIF}
end;

function GetCOM_Params(AOwner: TComponent; var Params: TPortParams): boolean;
begin
  with TfmChoosePort.Create(AOwner) do
  try
    SetCurrParams(Params);
    SourceParams:= Params;

    ShowModal;
    Result:= ModalResult = mrOK;
    if Result then
    begin
      GetCurrParams(Params);
    end;
  finally
    Free;
  end;
end;

procedure TfmChoosePort.FormCreate(Sender: TObject);
begin
  TranslateAppObject(Self);
end;

procedure TfmChoosePort.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  {$IFDEF WINDOWS}
  if Msg.CharCode = VK_ESCAPE then
  begin
    Handled:= true;
    ModalResult:= mrCancel;
  end;
  {$ENDIF}
end;

procedure TfmChoosePort.SpinEditChange(Sender: TObject);
var Obj: TSpinEdit;
begin
  if Sender is TSpinEdit then Obj:= Sender as TSpinEdit
  else exit;

  if (Obj.Text <> '') and (Obj.Value <= Obj.MaxValue) and (Obj.Value >= Obj.MinValue) then Obj.Tag:= Obj.Value;
  DataChange(Self);
end;

procedure TfmChoosePort.SpinEditExit(Sender: TObject);
var Obj: TSpinEdit;
begin
  if Sender is TSpinEdit then Obj:= Sender as TSpinEdit
  else exit;

  if (Obj.Text = '') or (Obj.Value > Obj.MaxValue) or (Obj.Value < Obj.MinValue) then Obj.Value:= Obj.Tag;
  DataChange(Self);
end;

procedure TfmChoosePort.DataChange(Sender: TObject);
begin
  btnOk.Enabled:= CheckCurrParams;
end;

procedure TfmChoosePort.btnOkClick(Sender: TObject);
begin
  if not CheckComPort(lbPorts.Tag) then
  begin
    {$IFDEF WINDOWS}
    if MessageBox(Handle, PChar(STR_PORT_FAULT), PChar(STR_WARNING), MB_ICONWARNING or MB_YESNO) = idNo then
    begin
      IniPortsList(lbPorts.Tag);
      exit;
    end;
    {$ENDIF}
  end;
  ModalResult:= mrOK;
end;

procedure TfmChoosePort.IniPortsList(const CurrPort: byte);
var i: integer;
begin
  lbPorts.Clear;
  lbPorts.Tag:= CurrPort;
  btnOk.Tag:= CurrPort;
  for i:= 1 to 255 do
  begin
    lbPorts.Items.Add(format('COM %d', [i]));
    lbPorts.ItemEnabled[i-1]:= true;
    lbPorts.Checked[i-1]:= i = CurrPort;
    if lbPorts.Checked[i-1] then lbPorts.ItemIndex:= i-1;
  end;
end;

procedure TfmChoosePort.btnUpdateClick(Sender: TObject);
var i: integer;
begin
  for i:= 1 to 255 do
    lbPorts.ItemEnabled[i-1]:= CheckComPort(i);
end;

procedure TfmChoosePort.lbPortsClickCheck(Sender: TObject);
begin
  if lbPorts.ItemIndex < 0 then exit;
  if not lbPorts.Checked[lbPorts.ItemIndex] and (lbPorts.ItemIndex = (lbPorts.Tag-1)) then
  begin
    lbPorts.Checked[lbPorts.ItemIndex]:= true;
    exit;
  end;

  if lbPorts.Checked[lbPorts.ItemIndex] and (lbPorts.ItemIndex <> (lbPorts.Tag-1)) then
  begin
    lbPorts.Checked[lbPorts.Tag-1]:= false;
    lbPorts.Tag:= lbPorts.ItemIndex +1;
  end;
  btnOk.Enabled:= (lbPorts.Tag <> btnOk.Tag) or (seRespondTimeOut.Tag <> seRespondTimeOut.Value);
end;

procedure TfmChoosePort.SetCurrParams(const AValue: TPortParams);
begin
  IniPortsList(AValue.PortNum);

  cbBaud.ItemIndex:= AValue.Baud;
  cbDataBits.ItemIndex:= AValue.DataBits;
  cbStopBits.ItemIndex:= AValue.StopBits;
  cbParity.ItemIndex:= AValue.Parity;

  seRespondTimeOut.Value:= AValue.BrakeInterval;

  seRegsCount.Value:= AValue.RegsCount;
  seDeviceNumM.Value:= AValue.DeviceNumM;
  seDeviceNumD.Value:= AValue.DeviceNumD;
  cbAutoCreateDevNum.Checked:= AValue.AutoCreateDeviceNumD;
  seDeviceMasterNumM.Value:= AValue.MasterNumM;
  seDeviceMasterNumD.Value:= AValue.MasterNumD;
end;

procedure TfmChoosePort.GetCurrParams(var Dest: TPortParams);
begin
  Dest.PortNum  := lbPorts.Tag;
  Dest.Baud     := cbBaud.ItemIndex;
  Dest.DataBits := cbDataBits.ItemIndex;
  Dest.StopBits := cbStopBits.ItemIndex;
  Dest.Parity   := cbParity.ItemIndex;
  Dest.BrakeInterval := seRespondTimeOut.Value;

  Dest.RegsCount:= seRegsCount.Value;
  Dest.DeviceNumM:= seDeviceNumM.Value;
  Dest.DeviceNumD:= seDeviceNumD.Value;
  Dest.AutoCreateDeviceNumD:= cbAutoCreateDevNum.Checked;
  Dest.MasterNumM:= seDeviceMasterNumM.Value;
  Dest.MasterNumD:= seDeviceMasterNumD.Value;
end;

function TfmChoosePort.CheckCurrParams: boolean;
begin
  Result:= (lbPorts.Tag > 0) and (cbBaud.ItemIndex >= 0) and (cbDataBits.ItemIndex >= 0) and (cbStopBits.ItemIndex >= 0) and (cbParity.ItemIndex >= 0) and
           ((SourceParams.PortNum <> lbPorts.Tag) or
            (SourceParams.Baud <> cbBaud.ItemIndex) or
            (SourceParams.DataBits <> cbDataBits.ItemIndex) or
            (SourceParams.StopBits <> cbStopBits.ItemIndex) or
            (SourceParams.Parity <> cbParity.ItemIndex) or
            (SourceParams.BrakeInterval <> seRespondTimeOut.Value) or
            (SourceParams.RegsCount <> seRegsCount.Value) or
            (SourceParams.DeviceNumM <> seDeviceNumM.Value) or
            (SourceParams.DeviceNumD <> seDeviceNumD.Value) or
            (SourceParams.AutoCreateDeviceNumD <> cbAutoCreateDevNum.Checked) or
            (SourceParams.MasterNumM <> seDeviceMasterNumM.Value) or
            (SourceParams.MasterNumD <> seDeviceMasterNumD.Value));
end;

procedure TfmChoosePort.cbAutoCreateDevNumClick(Sender: TObject);
begin
  seDeviceNumD.Enabled:= not cbAutoCreateDevNum.Checked;
end;

end.

