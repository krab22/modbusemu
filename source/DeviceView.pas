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

    procedure btCoilAplyAllClick(Sender : TObject);
    procedure btCoilAplyClick(Sender : TObject);
    procedure btCoilAplyForClick(Sender : TObject);
    procedure btDiscretsAplyAllClick(Sender : TObject);
    procedure btDiscretsAplyClick(Sender : TObject);
    procedure btDiscretsAplyForClick(Sender : TObject);
    procedure btHoldingsAplyAllClick(Sender : TObject);
    procedure btHoldingsAplyClick(Sender : TObject);
    procedure btHoldingsAplyForClick(Sender : TObject);
    procedure cbHoldingsBit0Change(Sender : TObject);
    procedure cbHoldingsBit10Change(Sender : TObject);
    procedure cbHoldingsBit11Change(Sender : TObject);
    procedure cbHoldingsBit12Change(Sender : TObject);
    procedure cbHoldingsBit13Change(Sender : TObject);
    procedure cbHoldingsBit14Change(Sender : TObject);
    procedure cbHoldingsBit15Change(Sender : TObject);
    procedure cbHoldingsBit1Change(Sender : TObject);
    procedure cbHoldingsBit2Change(Sender : TObject);
    procedure cbHoldingsBit3Change(Sender : TObject);
    procedure cbHoldingsBit4Change(Sender : TObject);
    procedure cbHoldingsBit5Change(Sender : TObject);
    procedure cbHoldingsBit6Change(Sender : TObject);
    procedure cbHoldingsBit7Change(Sender : TObject);
    procedure cbHoldingsBit8Change(Sender : TObject);
    procedure cbHoldingsBit9Change(Sender : TObject);
    procedure edHoldingsValHexChange(Sender : TObject);
    procedure edHoldingsValHexKeyPress(Sender : TObject; var Key : char);
    procedure FormClose(Sender : TObject; var CloseAction : TCloseAction);
    procedure sgCoilsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
    procedure sgDiscretsSelectCell(Sender : TObject; aCol, aRow : Integer; var CanSelect : Boolean);
   private
    FDevice   : TMBDevice;
    FCSection : TCriticalSection;
    FLogger   : IDLogger;
    procedure SetDevice(AValue : TMBDevice);
    procedure ClearForm;
    procedure UpdateCoils;
    procedure UpdateDiscrets;
    procedure UpdateHoldings;
    procedure UpdateInputs;
    procedure Lock;
    procedure UnLock;

    procedure OnCoilsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
    procedure OnDiscretsChangeProc(Sender : TObject; ChangedRegs : TMBBitRegsArray);
    procedure OnHoldingsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
    procedure OnInputsChangeProc(Sender : TObject; ChangedRegs : TMBWordRegsArray);
   public
    property Device   : TMBDevice read FDevice write SetDevice;
    property CSection : TCriticalSection read FCSection write FCSection;
    property Logger   : IDLogger read FLogger write FLogger;
  end;

  TDevFormArray = array [0..255] of TfrmDeviceView;

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
       TempReg.Description := TempDesc;
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
      TempReg.Description := TempDesc;
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

    Logger.debug(rsDevView11,Format(rsDevView10,[Count+1]));

     for i := 0 to Count do
      begin
       TempReg := FDevice.Discrets[i];
       TempReg.ServerSideSetValue(TempVal);
       TempReg.Description := TempDesc;
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
      TempReg.Description := TempDesc;
     end;
   finally
    FDevice.EndPacketUpdate;
   end;
  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.btHoldingsAplyClick(Sender : TObject);
begin

end;

procedure TfrmDeviceView.btHoldingsAplyAllClick(Sender : TObject);
begin

end;

procedure TfrmDeviceView.btHoldingsAplyForClick(Sender : TObject);
begin

end;

procedure TfrmDeviceView.cbHoldingsBit0Change(Sender : TObject);
begin
  if cbHoldingsBit0.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0001
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0001;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit1Change(Sender : TObject);
begin
  if cbHoldingsBit1.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0002
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0002;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit2Change(Sender : TObject);
begin
  if cbHoldingsBit2.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0004
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0004;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit3Change(Sender : TObject);
begin
  if cbHoldingsBit3.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0008
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0008;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit4Change(Sender : TObject);
begin
  if cbHoldingsBit4.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0010
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0010;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit5Change(Sender : TObject);
begin
  if cbHoldingsBit5.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0020
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0020;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit6Change(Sender : TObject);
begin
  if cbHoldingsBit6.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0040
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0040;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit7Change(Sender : TObject);
begin
  if cbHoldingsBit7.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0080
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0080;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit8Change(Sender : TObject);
begin
  if cbHoldingsBit8.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0100
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0100;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit9Change(Sender : TObject);
begin
  if cbHoldingsBit9.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0200
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0200;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.edHoldingsValHexChange(Sender : TObject);
begin
  try
   speHoldingsValue.Value := StrToInt(Format('$%s',[edHoldingsValHex.Text]));
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

procedure TfrmDeviceView.cbHoldingsBit10Change(Sender : TObject);
begin
  if cbHoldingsBit10.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0400
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0400;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit11Change(Sender : TObject);
begin
  if cbHoldingsBit11.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $0800
   else speHoldingsValue.Value := speHoldingsValue.Value xor $0800;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit12Change(Sender : TObject);
begin
  if cbHoldingsBit12.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $1000
   else speHoldingsValue.Value := speHoldingsValue.Value xor $1000;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit13Change(Sender : TObject);
begin
  if cbHoldingsBit13.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $2000
   else speHoldingsValue.Value := speHoldingsValue.Value xor $2000;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit14Change(Sender : TObject);
begin
  if cbHoldingsBit14.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $4000
   else speHoldingsValue.Value := speHoldingsValue.Value xor $4000;
  edHoldingsValHex.Text := IntToHex(speHoldingsValue.Value,4);
end;

procedure TfrmDeviceView.cbHoldingsBit15Change(Sender : TObject);
begin
  if cbHoldingsBit15.Checked then speHoldingsValue.Value := speHoldingsValue.Value or $8000
   else speHoldingsValue.Value := speHoldingsValue.Value xor $8000;
  edHoldingsValHex.Text := IntToHex(Word(speHoldingsValue.Value),4);
end;

procedure TfrmDeviceView.edHoldingsValHexKeyPress(Sender : TObject; var Key : char);
const TempKey : set of char = ['0'..'9','a'..'f','A'..'F'];
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
end;

end.

