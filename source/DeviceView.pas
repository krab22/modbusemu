unit DeviceView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Grids, Spin, syncobjs,
  MBDeviceClasses, MBRegistersCalsses,
  LoggerItf;

type

  { TfrmDeviceView }

  TfrmDeviceView = class(TForm)
    lbDeviceNumber           : TLabel;
    lbDevNum                 : TLabel;
    pcDeviceRegisters        : TPageControl;
    tsCoils                  : TTabSheet;
    sgCoils                  : TStringGrid;
    btCoilAply               : TButton;
    btCoilAplyAll            : TButton;
    btCoilAplyFor            : TButton;
    edCoilRegDescription     : TEdit;
    gbCoilEditReg            : TGroupBox;
    gbCoilValue              : TGroupBox;
    lbCoilComment            : TLabel;
    lbCoilRegNum             : TLabel;
    rbCoilFalse              : TRadioButton;
    rbCoilTrue               : TRadioButton;
    speCoilRegNum            : TSpinEdit;
    tsDiscrets               : TTabSheet;
    sgDiscrets               : TStringGrid;
    btDiscretsAply           : TButton;
    btDiscretsAplyAll        : TButton;
    btDiscretsAplyFor        : TButton;
    edDiscretsRegDescription : TEdit;
    gbDiscretsEditReg        : TGroupBox;
    gbDiscretsValue          : TGroupBox;
    lbDiscretsComment        : TLabel;
    lbDiscretsRegNum         : TLabel;
    rbDiscretsFalse          : TRadioButton;
    rbDiscretsTrue           : TRadioButton;
    speDiscretsRegNum        : TSpinEdit;
    tsHoldings               : TTabSheet;
    sgHoldings               : TStringGrid;
    btHoldingsAply           : TButton;
    btHoldingsAplyAll        : TButton;
    btHoldingsAplyFor        : TButton;
    edHoldingsRegDescription : TEdit;
    gbHoldingsEditReg        : TGroupBox;
    lbHoldingsComment        : TLabel;
    lbHoldingsRegNum         : TLabel;
    speHoldingsRegNum        : TSpinEdit;
    cbHoldingsBit0           : TCheckBox;
    cbHoldingsBit1           : TCheckBox;
    cbHoldingsBit10          : TCheckBox;
    cbHoldingsBit11          : TCheckBox;
    cbHoldingsBit12          : TCheckBox;
    cbHoldingsBit13          : TCheckBox;
    cbHoldingsBit14          : TCheckBox;
    cbHoldingsBit15          : TCheckBox;
    cbHoldingsBit2           : TCheckBox;
    cbHoldingsBit3           : TCheckBox;
    cbHoldingsBit4           : TCheckBox;
    cbHoldingsBit5           : TCheckBox;
    cbHoldingsBit6           : TCheckBox;
    cbHoldingsBit7           : TCheckBox;
    cbHoldingsBit8           : TCheckBox;
    cbHoldingsBit9           : TCheckBox;
    edHoldingsValHex         : TEdit;
    gbHoldingsValue          : TGroupBox;
    gbHoldingsBits           : TGroupBox;
    speHoldingsValue         : TSpinEdit;
    tsInputs                 : TTabSheet;
    sgInputs                 : TStringGrid;
    btInputsAply             : TButton;
    btInputsAplyAll          : TButton;
    btInputsAplyFor          : TButton;
    cbInputsBit0             : TCheckBox;
    cbInputsBit1             : TCheckBox;
    cbInputsBit2             : TCheckBox;
    cbInputsBit3             : TCheckBox;
    cbInputsBit4             : TCheckBox;
    cbInputsBit5             : TCheckBox;
    cbInputsBit6             : TCheckBox;
    cbInputsBit7             : TCheckBox;
    cbInputsBit8             : TCheckBox;
    cbInputsBit9             : TCheckBox;
    cbInputsBit10            : TCheckBox;
    cbInputsBit11            : TCheckBox;
    cbInputsBit12            : TCheckBox;
    cbInputsBit13            : TCheckBox;
    cbInputsBit14            : TCheckBox;
    cbInputsBit15            : TCheckBox;
    edInputsRegDescription   : TEdit;
    edInputsValHex           : TEdit;
    gbInputsBits             : TGroupBox;
    gbInputsEditReg          : TGroupBox;
    gbInputsValue            : TGroupBox;
    lbInputsComment          : TLabel;
    lbInputsRegNum           : TLabel;
    speInputsRegNum          : TSpinEdit;
    speInputsValue           : TSpinEdit;
    procedure FormClose(Sender : TObject; var CloseAction : TCloseAction);

    procedure btCoilAplyAllClick(Sender : TObject);
    procedure btCoilAplyClick(Sender : TObject);
    procedure btCoilAplyForClick(Sender : TObject);
    procedure btDiscretsAplyAllClick(Sender : TObject);
    procedure btDiscretsAplyClick(Sender : TObject);
    procedure btDiscretsAplyForClick(Sender : TObject);
    procedure btHoldingsAplyAllClick(Sender : TObject);
    procedure btHoldingsAplyClick(Sender : TObject);
    procedure btHoldingsAplyForClick(Sender : TObject);
    procedure btInputsAplyAllClick(Sender : TObject);
    procedure btInputsAplyClick(Sender : TObject);
    procedure btInputsAplyForClick(Sender : TObject);

    procedure cbHoldingsBit0Change(Sender : TObject);
    procedure cbHoldingsBit1Change(Sender : TObject);
    procedure cbHoldingsBit2Change(Sender : TObject);
    procedure cbHoldingsBit3Change(Sender : TObject);
    procedure cbHoldingsBit4Change(Sender : TObject);
    procedure cbHoldingsBit5Change(Sender : TObject);
    procedure cbHoldingsBit6Change(Sender : TObject);
    procedure cbHoldingsBit7Change(Sender : TObject);
    procedure cbHoldingsBit8Change(Sender : TObject);
    procedure cbHoldingsBit9Change(Sender : TObject);
    procedure cbHoldingsBit10Change(Sender : TObject);
    procedure cbHoldingsBit11Change(Sender : TObject);
    procedure cbHoldingsBit12Change(Sender : TObject);
    procedure cbHoldingsBit13Change(Sender : TObject);
    procedure cbHoldingsBit14Change(Sender : TObject);
    procedure cbHoldingsBit15Change(Sender : TObject);

    procedure cbInputsBit0Change(Sender : TObject);
    procedure cbInputsBit1Change(Sender : TObject);
    procedure cbInputsBit2Change(Sender : TObject);
    procedure cbInputsBit3Change(Sender : TObject);
    procedure cbInputsBit4Change(Sender : TObject);
    procedure cbInputsBit5Change(Sender : TObject);
    procedure cbInputsBit6Change(Sender : TObject);
    procedure cbInputsBit7Change(Sender : TObject);
    procedure cbInputsBit8Change(Sender : TObject);
    procedure cbInputsBit9Change(Sender : TObject);
    procedure cbInputsBit10Change(Sender : TObject);
    procedure cbInputsBit11Change(Sender : TObject);
    procedure cbInputsBit12Change(Sender : TObject);
    procedure cbInputsBit13Change(Sender : TObject);
    procedure cbInputsBit14Change(Sender : TObject);
    procedure cbInputsBit15Change(Sender : TObject);

    procedure edHoldingsValHexKeyPress(Sender : TObject; var Key : char);

		procedure edHoldingsValHexKeyUp(Sender : TObject; var Key : Word;	Shift : TShiftState);
    procedure speHoldingsValueKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure speHoldingsValueMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);

    procedure edInputsValHexKeyUp(Sender : TObject; var Key : Word;Shift : TShiftState);
		procedure speInputsValueKeyUp(Sender : TObject; var Key : Word;	Shift : TShiftState);
		procedure speInputsValueMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);

    procedure sgCoilsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
    procedure sgDiscretsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
    procedure sgHoldingsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
    procedure sgInputsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
    procedure edHoldingsRegDescriptionEditingDone(Sender : TObject);
    procedure edHoldingsValHexEditingDone(Sender : TObject);
    procedure speHoldingsValueEditingDone(Sender : TObject);
    procedure edInputsRegDescriptionEditingDone(Sender : TObject);
    procedure edInputsValHexEditingDone(Sender : TObject);
    procedure speInputsValueEditingDone(Sender : TObject);
    procedure edDiscretsRegDescriptionEditingDone(Sender : TObject);
    procedure edCoilRegDescriptionEditingDone(Sender : TObject);
   private
    FDevice       : TMBDevice;
    FCSection     : TCriticalSection;
    FLogger       : IDLogger;
    FOnDevChange  : TNotifyEvent;
    FIsChange     : Boolean;
    procedure SetDevice(AValue : TMBDevice);
    procedure ClearForm;
    procedure UpdateCoils;
    procedure UpdateDiscrets;
    procedure UpdateHoldings;
    procedure UpdateInputs;
    procedure Lock;
    procedure UnLock;
    procedure UpdateHoldingBits;
    procedure UpdateHoldingHexAndBits;
    procedure UpdateHoldingNumAndBits;
    procedure UpdateInputBits;
    procedure UpdateInputHexAndBits;
    procedure UpdateInputNumAndBits;

    procedure OnDevChangeProc;
    procedure OnCoilsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
    procedure OnDiscretsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
    procedure OnHoldingsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
    procedure OnInputsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
   public
    property Device      : TMBDevice read FDevice write SetDevice;
    property CSection    : TCriticalSection read FCSection write FCSection;
    property Logger      : IDLogger read FLogger write FLogger;
    property OnDevChange : TNotifyEvent read FOnDevChange write FOnDevChange;
  end;

  TDevFormArray = array [0..255] of TfrmDeviceView;
  PDevFormArray = ^TDevFormArray;

var frmDeviceView : TfrmDeviceView;

implementation

{$R *.lfm}

uses ModbusEmuResStr, MBDefine,
     formRahgeEdit;

{ TfrmDeviceView }

procedure TfrmDeviceView.FormClose(Sender : TObject; var CloseAction : TCloseAction);
begin
  CloseAction := caHide;
end;

procedure TfrmDeviceView.sgCoilsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
begin
  if sgCoils.Cells[0,aRow] <> '' then speCoilRegNum.Value := StrToInt(sgCoils.Cells[0,aRow]);
  if sgCoils.Cells[1,aRow] <> '' then
   if StrToBool(sgCoils.Cells[1,aRow]) then rbCoilTrue.Checked := True
    else rbCoilFalse.Checked := True;
  edCoilRegDescription.Text := sgCoils.Cells[2,aRow];
end;

procedure TfrmDeviceView.sgDiscretsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
begin
  if sgDiscrets.Cells[0,aRow] <> '' then speCoilRegNum.Value := StrToInt(sgDiscrets.Cells[0,aRow]);
  if sgDiscrets.Cells[1,aRow] <> '' then
   if StrToBool(sgDiscrets.Cells[1,aRow]) then rbDiscretsTrue.Checked := True
    else rbDiscretsFalse.Checked := True;
  edDiscretsRegDescription.Text := sgDiscrets.Cells[2,aRow];
end;

procedure TfrmDeviceView.sgHoldingsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
begin
  if sgHoldings.Cells[0,aRow] <> '' then speHoldingsRegNum.Value := StrToInt(sgHoldings.Cells[0,aRow]);
  if sgHoldings.Cells[1,aRow] <> '' then
   begin
    speHoldingsValue.Value := StrToInt(sgHoldings.Cells[1,aRow]);
    UpdateHoldingHexAndBits;
   end;
  edHoldingsRegDescription.Text := sgHoldings.Cells[3,aRow];
end;

procedure TfrmDeviceView.sgInputsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
begin
  if sgInputs.Cells[0,aRow] <> '' then speInputsRegNum.Value := StrToInt(sgInputs.Cells[0,aRow]);
  if sgInputs.Cells[1,aRow] <> '' then
   begin
    speInputsValue.Value := StrToInt(sgInputs.Cells[1,aRow]);
   end;
  edInputsRegDescription.Text := sgInputs.Cells[3,aRow];
end;

procedure TfrmDeviceView.edHoldingsRegDescriptionEditingDone(Sender : TObject);
begin
  btHoldingsAplyClick(Self);
end;

procedure TfrmDeviceView.edHoldingsValHexEditingDone(Sender : TObject);
begin
  btHoldingsAplyClick(Self);
end;

procedure TfrmDeviceView.speHoldingsValueEditingDone(Sender : TObject);
begin
  btHoldingsAplyClick(Self);
end;

procedure TfrmDeviceView.edInputsRegDescriptionEditingDone(Sender : TObject);
begin
  btInputsAplyClick(Self);
end;

procedure TfrmDeviceView.edInputsValHexEditingDone(Sender : TObject);
begin
  btInputsAplyClick(Self);
end;

procedure TfrmDeviceView.speInputsValueEditingDone(Sender : TObject);
begin
  btInputsAplyClick(Self);
end;

procedure TfrmDeviceView.edDiscretsRegDescriptionEditingDone(Sender : TObject);
begin
  btDiscretsAplyClick(Self);
end;

procedure TfrmDeviceView.edCoilRegDescriptionEditingDone(Sender : TObject);
begin
  btCoilAplyClick(Self);
end;

procedure TfrmDeviceView.btCoilAplyClick(Sender : TObject);
var TempReg : TMBBitRegister;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempReg := FDevice.Coils[speCoilRegNum.Value];
    if rbCoilTrue.Checked then TempReg.Value := True else TempReg.Value := False;
    TempReg.Description := edCoilRegDescription.Text;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btCoilAplyAllClick(Sender : TObject);
var TempReg  : TMBBitRegister;
    TempVal  : Boolean;
    i, Count : Integer;
    TempDesc : String;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    if rbCoilTrue.Checked then TempVal := True else TempVal := False;
    TempDesc := edCoilRegDescription.Text;
    Count := FDevice.CoilCount-1;

    Logger.debug(rsDevView9,Format(rsDevView10,[Count+1]));

     for i := 0 to Count do
      begin
       TempReg := FDevice.Coils[i];
       TempReg.Value       := TempVal;
//       TempReg.Description := TempDesc;
      end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btCoilAplyForClick(Sender : TObject);
var TempReg  : TMBBitRegister;
    TempForm : TfrmRangeEdit;
    i, TempStart,
    TempStop : Integer;
    TempVal  : Boolean;
    TempDesc : String;
begin
  TempForm := TfrmRangeEdit.Create(Self);
  try
    TempForm.speRegStart.Value := speCoilRegNum.Value;
    TempForm.speRegStop.Value  := speCoilRegNum.Value;
    TempForm.ShowModal;
    if TempForm.ModalResult <> mrOK then Exit;
    TempStart := TempForm.speRegStart.Value;
    TempStop  := TempForm.speRegStop.Value;
  finally
   FreeAndNil(TempForm);
  end;

  if TempStart > TempStop then raise Exception.Create(rsRageEdit1);

  if rbCoilTrue.Checked then TempVal := True else TempVal := False;
  TempDesc := edCoilRegDescription.Text;

  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    for i := TempStart to TempStop do
     begin
      TempReg := FDevice.Coils[i];
      TempReg.Value       := TempVal;
//      TempReg.Description := TempDesc;
     end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btDiscretsAplyClick(Sender : TObject);
var TempReg : TMBBitRegister;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempReg := FDevice.Discrets[speCoilRegNum.Value];
    if rbDiscretsTrue.Checked then TempReg.ServerSideSetValue(True) else TempReg.ServerSideSetValue(False);
    TempReg.Description := edDiscretsRegDescription.Text;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btDiscretsAplyAllClick(Sender : TObject);
var TempReg  : TMBBitRegister;
    TempVal  : Boolean;
    i, Count : Integer;
    TempDesc : String;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    if rbDiscretsTrue.Checked then TempVal := True else TempVal := False;
    TempDesc := edDiscretsRegDescription.Text;
    Count := FDevice.DiscretCount-1;

    Logger.debug(rsDevView14,Format(rsDevView10,[Count+1]));

     for i := 0 to Count do
      begin
       TempReg := FDevice.Discrets[i];
       TempReg.ServerSideSetValue(TempVal);
//       TempReg.Description := TempDesc;
      end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btDiscretsAplyForClick(Sender : TObject);
var TempReg  : TMBBitRegister;
    TempForm : TfrmRangeEdit;
    i, TempStart,
    TempStop : Integer;
    TempVal  : Boolean;
    TempDesc : String;
begin
  TempForm := TfrmRangeEdit.Create(Self);
  try
    TempForm.speRegStart.Value := speCoilRegNum.Value;
    TempForm.speRegStop.Value  := speCoilRegNum.Value;
    TempForm.ShowModal;
    if TempForm.ModalResult <> mrOK then Exit;
    TempStart := TempForm.speRegStart.Value;
    TempStop  := TempForm.speRegStop.Value;
  finally
   FreeAndNil(TempForm);
  end;

  if TempStart > TempStop then raise Exception.Create(rsRageEdit1);

  if rbDiscretsTrue.Checked then TempVal := True else TempVal := False;
  TempDesc := edDiscretsRegDescription.Text;

  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    for i := TempStart to TempStop do
     begin
      TempReg := FDevice.Discrets[i];
      TempReg.ServerSideSetValue(TempVal);
//      TempReg.Description := TempDesc;
     end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btHoldingsAplyClick(Sender : TObject);
var TempReg : TMBWordRegister;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempReg := FDevice.Holdings[speHoldingsRegNum.Value];
    TempReg.Value       := Word(speHoldingsValue.Value);
    TempReg.Description := edHoldingsRegDescription.Text;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btHoldingsAplyAllClick(Sender : TObject);
var TempReg  : TMBWordRegister;
    TempVal  : Word;
    i, Count : Integer;
    TempDesc : String;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempVal  := Word(speHoldingsValue.Value);
    TempDesc := edHoldingsRegDescription.Text;
    Count := FDevice.HoldingCount-1;

    Logger.debug(rsDevView12,Format(rsDevView10,[Count+1]));

     for i := 0 to Count do
      begin
       TempReg := FDevice.Holdings[i];
       TempReg.Value       := TempVal;
//       TempReg.Description := TempDesc;
      end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btHoldingsAplyForClick(Sender : TObject);
var TempReg  : TMBWordRegister;
    TempForm : TfrmRangeEdit;
    i, TempStart,
    TempStop : Integer;
    TempVal  : Word;
    TempDesc : String;
begin
  TempForm := TfrmRangeEdit.Create(Self);
  try
    TempForm.speRegStart.Value := speCoilRegNum.Value;
    TempForm.speRegStop.Value  := speCoilRegNum.Value;
    TempForm.ShowModal;
    if TempForm.ModalResult <> mrOK then Exit;
    TempStart := TempForm.speRegStart.Value;
    TempStop  := TempForm.speRegStop.Value;
  finally
   FreeAndNil(TempForm);
  end;

  if TempStart > TempStop then raise Exception.Create(rsRageEdit1);

  TempVal := Word(speHoldingsValue.Value);
  TempDesc := edHoldingsRegDescription.Text;

  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    for i := TempStart to TempStop do
     begin
      TempReg := FDevice.Holdings[i];
      TempReg.Value       := TempVal;
//      TempReg.Description := TempDesc;
     end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.cbHoldingsBit0Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit1Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit2Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit3Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit4Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit5Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit6Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit7Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit8Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit9Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit10Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit11Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit12Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit13Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit14Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.cbHoldingsBit15Change(Sender : TObject);
begin
  UpdateHoldingBits;
end;

procedure TfrmDeviceView.edHoldingsValHexKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  UpdateHoldingNumAndBits;
end;

procedure TfrmDeviceView.cbInputsBit0Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit1Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit2Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit3Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit4Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit5Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit6Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit7Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit8Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit9Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit10Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit11Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit12Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit13Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit14Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.cbInputsBit15Change(Sender : TObject);
begin
  UpdateInputBits;
end;

procedure TfrmDeviceView.speInputsValueKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  UpdateInputHexAndBits;
end;

procedure TfrmDeviceView.speInputsValueMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  UpdateInputHexAndBits;
end;

procedure TfrmDeviceView.edInputsValHexKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  UpdateInputNumAndBits;
end;

procedure TfrmDeviceView.speHoldingsValueMouseUp(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  UpdateHoldingHexAndBits;
end;

procedure TfrmDeviceView.speHoldingsValueKeyUp(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  UpdateHoldingHexAndBits;
end;

procedure TfrmDeviceView.btInputsAplyClick(Sender : TObject);
var TempReg : TMBWordRegister;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempReg := FDevice.Inputs[speInputsRegNum.Value];
    TempReg.ServerSideSetValue(Word(speHoldingsValue.Value));
    TempReg.Description := edInputsRegDescription.Text;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btInputsAplyAllClick(Sender : TObject);
var TempReg  : TMBWordRegister;
    TempVal  : Word;
    i, Count : Integer;
    TempDesc : String;
begin
  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    TempVal  := Word(speInputsValue.Value);
    TempDesc := edInputsRegDescription.Text;
    Count := FDevice.InputCount-1;

    Logger.debug(rsDevView13,Format(rsDevView10,[Count+1]));

     for i := 0 to Count do
      begin
       TempReg := FDevice.Inputs[i];
       TempReg.ServerSideSetValue(TempVal);
//       TempReg.Description := TempDesc;
      end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btInputsAplyForClick(Sender : TObject);
var TempReg  : TMBWordRegister;
    TempForm : TfrmRangeEdit;
    i, TempStart,
    TempStop : Integer;
    TempVal  : Word;
    TempDesc : String;
begin
  TempForm := TfrmRangeEdit.Create(Self);
  try
    TempForm.speRegStart.Value := speCoilRegNum.Value;
    TempForm.speRegStop.Value  := speCoilRegNum.Value;
    TempForm.ShowModal;
    if TempForm.ModalResult <> mrOK then Exit;
    TempStart := TempForm.speRegStart.Value;
    TempStop  := TempForm.speRegStop.Value;
  finally
   FreeAndNil(TempForm);
  end;

  if TempStart > TempStop then raise Exception.Create(rsRageEdit1);

  TempVal := Word(speInputsValue.Value);
  TempDesc := edInputsRegDescription.Text;

  Lock;
  try
   FDevice.BeginPacketUpdate;
   try
    for i := TempStart to TempStop do
     begin
      TempReg := FDevice.Inputs[i];
      TempReg.ServerSideSetValue(TempVal);
//      TempReg.Description := TempDesc;
     end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.edHoldingsValHexKeyPress(Sender : TObject; var Key : char);
const TempKey : set of char = ['0'..'9','a'..'f','A'..'F',#08];
begin
  if not (Key in TempKey) then
   begin
    Key := #0;
    Exit;
   end;
end;

procedure TfrmDeviceView.SetDevice(AValue : TMBDevice);
begin
//  if FDevice = AValue then Exit;
  if not Assigned(AValue) then
   begin
     ClearForm;
     FDevice := AValue;
     Exit;
   end;
  FDevice := AValue;
  Lock;
  try
   lbDeviceNumber.Caption := IntToStr(FDevice.DeviceNum);

   FDevice.OnCoilsChange    := @OnCoilsChangeProc;
   FDevice.OnDiscretsChange := @OnDiscretsChangeProc;
   FDevice.OnHoldingsChange := @OnHoldingsChangeProc;
   FDevice.OnInputsChange   := @OnInputsChangeProc;

   if fn01 in FDevice.DeviceFunctions then
    begin
     tsCoils.TabVisible := True;
     UpdateCoils;
     pcDeviceRegisters.TabIndex := 0;
    end
   else tsCoils.TabVisible := False;

   if fn02 in FDevice.DeviceFunctions then
    begin
     tsDiscrets.TabVisible := True;
     UpdateDiscrets;
     pcDeviceRegisters.TabIndex := 1;
    end
   else tsDiscrets.TabVisible := False;

   if fn03 in FDevice.DeviceFunctions then
    begin
     tsHoldings.TabVisible := True;
     UpdateHoldings;
     pcDeviceRegisters.TabIndex := 2;
    end
   else tsHoldings.TabVisible := False;

   if fn04 in FDevice.DeviceFunctions then
    begin
     tsInputs.TabVisible := True;
     UpdateInputs;
     pcDeviceRegisters.TabIndex := 3;
    end
   else tsInputs.TabVisible := False;

   pcDeviceRegisters.Update;

  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.ClearForm;
begin
  lbDeviceNumber.Caption := '';
  sgCoils.RowCount    := 1;
  sgDiscrets.RowCount := 1;
  sgHoldings.RowCount := 1;
  sgInputs.RowCount   := 1;
end;

procedure TfrmDeviceView.UpdateCoils;
var i, Count : Integer;
    TempVal  : Boolean;
begin
  Lock;
  try
   Count := FDevice.CoilCount-1;
   sgCoils.RowCount := Count + 2;
   for i := 0 to Count do
    begin
     TempVal := FDevice.Coils[i].Value;
     sgCoils.Cells[0,i+1] := IntToStr(i);
     sgCoils.Cells[1,i+1] := BoolToStr(TempVal,True);
     sgCoils.Cells[2,i+1] := FDevice.Coils[i].Description;
    end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.UpdateDiscrets;
var i, Count : Integer;
    TempVal  : Boolean;
begin
  Lock;
  try
   Count := FDevice.DiscretCount-1;
   sgDiscrets.RowCount := Count + 2;
   for i := 0 to Count do
    begin
     TempVal := FDevice.Discrets[i].Value;
     sgDiscrets.Cells[0,i+1] := IntToStr(i);
     sgDiscrets.Cells[1,i+1] := BoolToStr(TempVal,True);
     sgDiscrets.Cells[2,i+1] := FDevice.Discrets[i].Description;
    end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.UpdateHoldings;
var i, Count : Integer;
    TempVal  : Word;
begin
  Lock;
  try
   Count := FDevice.HoldingCount-1;
   sgHoldings.RowCount := Count + 2;
   for i := 0 to Count do
    begin
     TempVal := FDevice.Holdings[i].Value;
     sgHoldings.Cells[0,i+1] := IntToStr(i);
     sgHoldings.Cells[1,i+1] := IntToStr(TempVal);
     sgHoldings.Cells[2,i+1] := IntToHex(TempVal,4);
     sgHoldings.Cells[3,i+1] := FDevice.Holdings[i].Description;
    end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.UpdateInputs;
var i, Count : Integer;
    TempVal  : Word;
begin
  Lock;
  try
   Count := FDevice.InputCount-1;
   sgInputs.RowCount := Count + 2;
   for i := 0 to Count do
    begin
     TempVal := FDevice.Inputs[i].Value;
     sgInputs.Cells[0,i+1] := IntToStr(i);
     sgInputs.Cells[1,i+1] := IntToStr(TempVal);
     sgInputs.Cells[2,i+1] := IntToHex(TempVal,4);
     sgInputs.Cells[3,i+1] := FDevice.Inputs[i].Description;
    end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.Lock;
begin
  if Assigned(FCSection) then FCSection.Enter;
end;

procedure TfrmDeviceView.UnLock;
begin
  if Assigned(FCSection) then FCSection.Leave;
end;

procedure TfrmDeviceView.UpdateHoldingBits;
var TempValue : Word;
begin
  if FIsChange then Exit;

  TempValue := 0;

  if cbHoldingsBit0.Checked  then TempValue := (TempValue or $0001) else TempValue := (TempValue and $FFFE);
  if cbHoldingsBit1.Checked  then TempValue := (TempValue or $0002) else TempValue := (TempValue and $FFFD);
  if cbHoldingsBit2.Checked  then TempValue := (TempValue or $0004) else TempValue := (TempValue and $FFFB);
  if cbHoldingsBit3.Checked  then TempValue := (TempValue or $0008) else TempValue := (TempValue and $FFF7);
  if cbHoldingsBit4.Checked  then TempValue := (TempValue or $0010) else TempValue := (TempValue and $FFEF);
  if cbHoldingsBit5.Checked  then TempValue := (TempValue or $0020) else TempValue := (TempValue and $FFDF);
  if cbHoldingsBit6.Checked  then TempValue := (TempValue or $0040) else TempValue := (TempValue and $FFBF);
  if cbHoldingsBit7.Checked  then TempValue := (TempValue or $0080) else TempValue := (TempValue and $FF7F);
  if cbHoldingsBit8.Checked  then TempValue := (TempValue or $0100) else TempValue := (TempValue and $FEFF);
  if cbHoldingsBit9.Checked  then TempValue := (TempValue or $0200) else TempValue := (TempValue and $FDFF);
  if cbHoldingsBit10.Checked then TempValue := (TempValue or $0400) else TempValue := (TempValue and $FBFF);
  if cbHoldingsBit11.Checked then TempValue := (TempValue or $0800) else TempValue := (TempValue and $F7FF);
  if cbHoldingsBit12.Checked then TempValue := (TempValue or $1000) else TempValue := (TempValue and $EFFF);
  if cbHoldingsBit13.Checked then TempValue := (TempValue or $2000) else TempValue := (TempValue and $DFFF);
  if cbHoldingsBit14.Checked then TempValue := (TempValue or $4000) else TempValue := (TempValue and $BFFF);
  if cbHoldingsBit15.Checked then TempValue := (TempValue or $8000) else TempValue := (TempValue and $7FFF);

  speHoldingsValue.Value := TempValue;
  edHoldingsValHex.Text  := IntToHex(TempValue,4);
end;

procedure TfrmDeviceView.UpdateHoldingHexAndBits;
begin
  try
   FIsChange := True;
   try
    edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
    if (speHoldingsValue.Value and $0001) = $0001 then cbHoldingsBit0.Checked  := True else cbHoldingsBit0.Checked := False;
    if (speHoldingsValue.Value and $0002) = $0002 then cbHoldingsBit1.Checked  := True else cbHoldingsBit1.Checked := False;
    if (speHoldingsValue.Value and $0004) = $0004 then cbHoldingsBit2.Checked  := True else cbHoldingsBit2.Checked := False;
    if (speHoldingsValue.Value and $0008) = $0008 then cbHoldingsBit3.Checked  := True else cbHoldingsBit3.Checked := False;
    if (speHoldingsValue.Value and $0010) = $0010 then cbHoldingsBit4.Checked  := True else cbHoldingsBit4.Checked := False;
    if (speHoldingsValue.Value and $0020) = $0020 then cbHoldingsBit5.Checked  := True else cbHoldingsBit5.Checked := False;
    if (speHoldingsValue.Value and $0040) = $0040 then cbHoldingsBit6.Checked  := True else cbHoldingsBit6.Checked := False;
    if (speHoldingsValue.Value and $0080) = $0080 then cbHoldingsBit7.Checked  := True else cbHoldingsBit7.Checked := False;
    if (speHoldingsValue.Value and $0100) = $0100 then cbHoldingsBit8.Checked  := True else cbHoldingsBit8.Checked := False;
    if (speHoldingsValue.Value and $0200) = $0200 then cbHoldingsBit9.Checked  := True else cbHoldingsBit9.Checked := False;
    if (speHoldingsValue.Value and $0400) = $0400 then cbHoldingsBit10.Checked := True else cbHoldingsBit10.Checked := False;
    if (speHoldingsValue.Value and $0800) = $0800 then cbHoldingsBit11.Checked := True else cbHoldingsBit11.Checked := False;
    if (speHoldingsValue.Value and $1000) = $1000 then cbHoldingsBit12.Checked := True else cbHoldingsBit12.Checked := False;
    if (speHoldingsValue.Value and $2000) = $2000 then cbHoldingsBit13.Checked := True else cbHoldingsBit13.Checked := False;
    if (speHoldingsValue.Value and $4000) = $4000 then cbHoldingsBit14.Checked := True else cbHoldingsBit14.Checked := False;
    if (speHoldingsValue.Value and $8000) = $8000 then cbHoldingsBit15.Checked := True else cbHoldingsBit15.Checked := False;
   finally
    FIsChange := False;
	 end;
	except
   edHoldingsValHex.Text   := '0000';
   cbHoldingsBit0.Checked  := False;
   cbHoldingsBit1.Checked  := False;
   cbHoldingsBit2.Checked  := False;
   cbHoldingsBit3.Checked  := False;
   cbHoldingsBit4.Checked  := False;
   cbHoldingsBit5.Checked  := False;
   cbHoldingsBit6.Checked  := False;
   cbHoldingsBit7.Checked  := False;
   cbHoldingsBit8.Checked  := False;
   cbHoldingsBit9.Checked  := False;
   cbHoldingsBit10.Checked := False;
   cbHoldingsBit11.Checked := False;
   cbHoldingsBit12.Checked := False;
   cbHoldingsBit13.Checked := False;
   cbHoldingsBit14.Checked := False;
   cbHoldingsBit15.Checked := False;
  end;
end;

procedure TfrmDeviceView.UpdateHoldingNumAndBits;
begin
  try
   FIsChange := True;
   try
    speHoldingsValue.Value := StrToInt(Format('$%s',[edHoldingsValHex.Text]));
    if (speHoldingsValue.Value and $0001) = $0001 then cbHoldingsBit0.Checked  := True else cbHoldingsBit0.Checked  := False;
    if (speHoldingsValue.Value and $0002) = $0002 then cbHoldingsBit1.Checked  := True else cbHoldingsBit1.Checked  := False;
    if (speHoldingsValue.Value and $0004) = $0004 then cbHoldingsBit2.Checked  := True else cbHoldingsBit2.Checked  := False;
    if (speHoldingsValue.Value and $0008) = $0008 then cbHoldingsBit3.Checked  := True else cbHoldingsBit3.Checked  := False;
    if (speHoldingsValue.Value and $0010) = $0010 then cbHoldingsBit4.Checked  := True else cbHoldingsBit4.Checked  := False;
    if (speHoldingsValue.Value and $0020) = $0020 then cbHoldingsBit5.Checked  := True else cbHoldingsBit5.Checked  := False;
    if (speHoldingsValue.Value and $0040) = $0040 then cbHoldingsBit6.Checked  := True else cbHoldingsBit6.Checked  := False;
    if (speHoldingsValue.Value and $0080) = $0080 then cbHoldingsBit7.Checked  := True else cbHoldingsBit7.Checked  := False;
    if (speHoldingsValue.Value and $0100) = $0100 then cbHoldingsBit8.Checked  := True else cbHoldingsBit8.Checked  := False;
    if (speHoldingsValue.Value and $0200) = $0200 then cbHoldingsBit9.Checked  := True else cbHoldingsBit9.Checked  := False;
    if (speHoldingsValue.Value and $0400) = $0400 then cbHoldingsBit10.Checked := True else cbHoldingsBit10.Checked := False;
    if (speHoldingsValue.Value and $0800) = $0800 then cbHoldingsBit11.Checked := True else cbHoldingsBit11.Checked := False;
    if (speHoldingsValue.Value and $1000) = $1000 then cbHoldingsBit12.Checked := True else cbHoldingsBit12.Checked := False;
    if (speHoldingsValue.Value and $2000) = $2000 then cbHoldingsBit13.Checked := True else cbHoldingsBit13.Checked := False;
    if (speHoldingsValue.Value and $4000) = $4000 then cbHoldingsBit14.Checked := True else cbHoldingsBit14.Checked := False;
    if (speHoldingsValue.Value and $8000) = $8000 then cbHoldingsBit15.Checked := True else cbHoldingsBit15.Checked := False;
   finally
    FIsChange := False;
	 end;
  except
   speHoldingsValue.Value  := 0;
   cbHoldingsBit0.Checked  := False;
   cbHoldingsBit1.Checked  := False;
   cbHoldingsBit2.Checked  := False;
   cbHoldingsBit3.Checked  := False;
   cbHoldingsBit4.Checked  := False;
   cbHoldingsBit5.Checked  := False;
   cbHoldingsBit6.Checked  := False;
   cbHoldingsBit7.Checked  := False;
   cbHoldingsBit8.Checked  := False;
   cbHoldingsBit9.Checked  := False;
   cbHoldingsBit10.Checked := False;
   cbHoldingsBit11.Checked := False;
   cbHoldingsBit12.Checked := False;
   cbHoldingsBit13.Checked := False;
   cbHoldingsBit14.Checked := False;
   cbHoldingsBit15.Checked := False;
  end;
end;

procedure TfrmDeviceView.UpdateInputBits;
var TempValue : Word;
begin
  if FIsChange then Exit;

  TempValue := 0;

  if cbInputsBit0.Checked  then TempValue := (TempValue or $0001) else TempValue := (TempValue and $FFFE);
  if cbInputsBit1.Checked  then TempValue := (TempValue or $0002) else TempValue := (TempValue and $FFFD);
  if cbInputsBit2.Checked  then TempValue := (TempValue or $0004) else TempValue := (TempValue and $FFFB);
  if cbInputsBit3.Checked  then TempValue := (TempValue or $0008) else TempValue := (TempValue and $FFF7);
  if cbInputsBit4.Checked  then TempValue := (TempValue or $0010) else TempValue := (TempValue and $FFEF);
  if cbInputsBit5.Checked  then TempValue := (TempValue or $0020) else TempValue := (TempValue and $FFDF);
  if cbInputsBit6.Checked  then TempValue := (TempValue or $0040) else TempValue := (TempValue and $FFBF);
  if cbInputsBit7.Checked  then TempValue := (TempValue or $0080) else TempValue := (TempValue and $FF7F);
  if cbInputsBit8.Checked  then TempValue := (TempValue or $0100) else TempValue := (TempValue and $FEFF);
  if cbInputsBit9.Checked  then TempValue := (TempValue or $0200) else TempValue := (TempValue and $FDFF);
  if cbInputsBit10.Checked then TempValue := (TempValue or $0400) else TempValue := (TempValue and $FBFF);
  if cbInputsBit11.Checked then TempValue := (TempValue or $0800) else TempValue := (TempValue and $F7FF);
  if cbInputsBit12.Checked then TempValue := (TempValue or $1000) else TempValue := (TempValue and $EFFF);
  if cbInputsBit13.Checked then TempValue := (TempValue or $2000) else TempValue := (TempValue and $DFFF);
  if cbInputsBit14.Checked then TempValue := (TempValue or $4000) else TempValue := (TempValue and $BFFF);
  if cbInputsBit15.Checked then TempValue := (TempValue or $8000) else TempValue := (TempValue and $7FFF);

  speInputsValue.Value := TempValue;
  edInputsValHex.Text  := IntToHex(TempValue,4);
end;

procedure TfrmDeviceView.UpdateInputHexAndBits;
begin
  try
   FIsChange := True;
   try
    edInputsValHex.Text := IntToHex(speInputsValue.Value,4);
    if (speInputsValue.Value and $0001) = $0001 then cbInputsBit0.Checked  := True  else cbInputsBit0.Checked := False;
    if (speInputsValue.Value and $0002) = $0002 then cbInputsBit1.Checked  := True  else cbInputsBit1.Checked := False;
    if (speInputsValue.Value and $0004) = $0004 then cbInputsBit2.Checked  := True  else cbInputsBit2.Checked := False;
    if (speInputsValue.Value and $0008) = $0008 then cbInputsBit3.Checked  := True  else cbInputsBit3.Checked := False;
    if (speInputsValue.Value and $0010) = $0010 then cbInputsBit4.Checked  := True  else cbInputsBit4.Checked := False;
    if (speInputsValue.Value and $0020) = $0020 then cbInputsBit5.Checked  := True  else cbInputsBit5.Checked := False;
    if (speInputsValue.Value and $0040) = $0040 then cbInputsBit6.Checked  := True  else cbInputsBit6.Checked := False;
    if (speInputsValue.Value and $0080) = $0080 then cbInputsBit7.Checked  := True  else cbInputsBit7.Checked := False;
    if (speInputsValue.Value and $0100) = $0100 then cbInputsBit8.Checked  := True  else cbInputsBit8.Checked := False;
    if (speInputsValue.Value and $0200) = $0200 then cbInputsBit9.Checked  := True  else cbInputsBit9.Checked := False;
    if (speInputsValue.Value and $0400) = $0400 then cbInputsBit10.Checked := True else cbInputsBit10.Checked := False;
    if (speInputsValue.Value and $0800) = $0800 then cbInputsBit11.Checked := True else cbInputsBit11.Checked := False;
    if (speInputsValue.Value and $1000) = $1000 then cbInputsBit12.Checked := True else cbInputsBit12.Checked := False;
    if (speInputsValue.Value and $2000) = $2000 then cbInputsBit13.Checked := True else cbInputsBit13.Checked := False;
    if (speInputsValue.Value and $4000) = $4000 then cbInputsBit14.Checked := True else cbInputsBit14.Checked := False;
    if (speInputsValue.Value and $8000) = $8000 then cbInputsBit15.Checked := True else cbInputsBit15.Checked := False;
	 finally
    FIsChange := False;
	 end;
  except
   edInputsValHex.Text   := '0000';
   cbInputsBit0.Checked  := False;
   cbInputsBit1.Checked  := False;
   cbInputsBit2.Checked  := False;
   cbInputsBit3.Checked  := False;
   cbInputsBit4.Checked  := False;
   cbInputsBit5.Checked  := False;
   cbInputsBit6.Checked  := False;
   cbInputsBit7.Checked  := False;
   cbInputsBit8.Checked  := False;
   cbInputsBit9.Checked  := False;
   cbInputsBit10.Checked := False;
   cbInputsBit11.Checked := False;
   cbInputsBit12.Checked := False;
   cbInputsBit13.Checked := False;
   cbInputsBit14.Checked := False;
   cbInputsBit15.Checked := False;
  end;
end;

procedure TfrmDeviceView.UpdateInputNumAndBits;
begin
  try
   FIsChange := True;
   try
    speInputsValue.Value := StrToInt(Format('$%s',[edInputsValHex.Text]));
    if (speInputsValue.Value and $0001) = $0001 then cbInputsBit0.Checked  := True else cbInputsBit0.Checked := False;
    if (speInputsValue.Value and $0002) = $0002 then cbInputsBit1.Checked  := True else cbInputsBit1.Checked := False;
    if (speInputsValue.Value and $0004) = $0004 then cbInputsBit2.Checked  := True else cbInputsBit2.Checked := False;
    if (speInputsValue.Value and $0008) = $0008 then cbInputsBit3.Checked  := True else cbInputsBit3.Checked := False;
    if (speInputsValue.Value and $0010) = $0010 then cbInputsBit4.Checked  := True else cbInputsBit4.Checked := False;
    if (speInputsValue.Value and $0020) = $0020 then cbInputsBit5.Checked  := True else cbInputsBit5.Checked := False;
    if (speInputsValue.Value and $0040) = $0040 then cbInputsBit6.Checked  := True else cbInputsBit6.Checked := False;
    if (speInputsValue.Value and $0080) = $0080 then cbInputsBit7.Checked  := True else cbInputsBit7.Checked := False;
    if (speInputsValue.Value and $0100) = $0100 then cbInputsBit8.Checked  := True else cbInputsBit8.Checked := False;
    if (speInputsValue.Value and $0200) = $0200 then cbInputsBit9.Checked  := True else cbInputsBit9.Checked := False;
    if (speInputsValue.Value and $0400) = $0400 then cbInputsBit10.Checked := True else cbInputsBit10.Checked := False;
    if (speInputsValue.Value and $0800) = $0800 then cbInputsBit11.Checked := True else cbInputsBit11.Checked := False;
    if (speInputsValue.Value and $1000) = $1000 then cbInputsBit12.Checked := True else cbInputsBit12.Checked := False;
    if (speInputsValue.Value and $2000) = $2000 then cbInputsBit13.Checked := True else cbInputsBit13.Checked := False;
    if (speInputsValue.Value and $4000) = $4000 then cbInputsBit14.Checked := True else cbInputsBit14.Checked := False;
    if (speInputsValue.Value and $8000) = $8000 then cbInputsBit15.Checked := True else cbInputsBit15.Checked := False;
	 finally
    FIsChange := False;
	 end;
	except
   speInputsValue.Value  := 0;
   cbInputsBit0.Checked  := False;
   cbInputsBit1.Checked  := False;
   cbInputsBit2.Checked  := False;
   cbInputsBit3.Checked  := False;
   cbInputsBit4.Checked  := False;
   cbInputsBit5.Checked  := False;
   cbInputsBit6.Checked  := False;
   cbInputsBit7.Checked  := False;
   cbInputsBit8.Checked  := False;
   cbInputsBit9.Checked  := False;
   cbInputsBit10.Checked := False;
   cbInputsBit11.Checked := False;
   cbInputsBit12.Checked := False;
   cbInputsBit13.Checked := False;
   cbInputsBit14.Checked := False;
   cbInputsBit15.Checked := False;
  end;
end;

procedure TfrmDeviceView.OnDevChangeProc;
begin
  if Assigned(FOnDevChange) then FOnDevChange(FDevice);
end;

procedure TfrmDeviceView.OnCoilsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
var i,Count : Integer;
    TempReg : TMBBitRegister;
begin
  Count := Length(ChangedRegs)-1;
  Lock;
  try
   Logger.debug(rsDevView7,Format(rsDevView8,[Count+1]));
   for i := 0 to Count do
    begin
     TempReg := ChangedRegs[i];
     sgCoils.Cells[1,TempReg.RegNumber+1] := BoolToStr(TempReg.Value,True);
     sgCoils.Cells[2,TempReg.RegNumber+1] := TempReg.Description;
    end;
  finally
   UnLock;
  end;
  OnDevChangeProc;
end;

procedure TfrmDeviceView.OnDiscretsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
var i,Count : Integer;
    TempReg : TMBBitRegister;
begin
  Count := Length(ChangedRegs)-1;
  Lock;
  try
   Logger.debug(rsDevView5,Format(rsDevView6,[Count+1]));
   for i := 0 to Count do
    begin
     TempReg := ChangedRegs[i];
     sgDiscrets.Cells[1,TempReg.RegNumber+1] := BoolToStr(TempReg.Value,True);
     sgDiscrets.Cells[2,TempReg.RegNumber+1] := TempReg.Description;
    end;
  finally
   UnLock;
  end;
  OnDevChangeProc;
end;

procedure TfrmDeviceView.OnHoldingsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
var i,Count : Integer;
    TempReg : TMBWordRegister;
begin
  Count := Length(ChangedRegs)-1;
  Lock;
  try
   Logger.debug(rsDevView3,Format(rsDevView4,[Count+1]));
   for i := 0 to Count do
    begin
     TempReg := ChangedRegs[i];
     sgHoldings.Cells[1,TempReg.RegNumber+1] := IntToStr(TempReg.Value);
     sgHoldings.Cells[2,TempReg.RegNumber+1] := IntToHex(TempReg.Value,4);
     sgHoldings.Cells[3,TempReg.RegNumber+1] := TempReg.Description;
    end;
  finally
   UnLock;
  end;
  OnDevChangeProc;
end;

procedure TfrmDeviceView.OnInputsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
var i,Count : Integer;
    TempReg : TMBWordRegister;
begin
  Count := Length(ChangedRegs)-1;
  Lock;
  try
   Logger.debug(rsDevView1,Format(rsDevView2,[Count+1]));
   for i := 0 to Count do
    begin
     TempReg := ChangedRegs[i];
     sgInputs.Cells[1,TempReg.RegNumber+1] := IntToStr(TempReg.Value);
     sgInputs.Cells[2,TempReg.RegNumber+1] := IntToHex(TempReg.Value,4);
     sgInputs.Cells[3,TempReg.RegNumber+1] := TempReg.Description;
    end;
  finally
   UnLock;
  end;
  OnDevChangeProc;
end;

end.

