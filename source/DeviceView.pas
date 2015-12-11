unit DeviceView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Grids, syncobjs,
  MBDeviceClasses, MBRegistersCalsses,
  LoggerItf;

type

  { TfrmDeviceView }

  TfrmDeviceView = class(TForm)
     btTestDevView : TButton;
    lbDeviceNumber    : TLabel;
    lbDevNum          : TLabel;
    pcDeviceRegisters : TPageControl;
    sgCoils           : TStringGrid;
    sgDiscrets        : TStringGrid;
    sgHoldings        : TStringGrid;
    sgInputs          : TStringGrid;
    tsInputs          : TTabSheet;
    tsHoldings        : TTabSheet;
    tsDiscrets        : TTabSheet;
    tsCoils           : TTabSheet;
    procedure btTestDevViewClick(Sender : TObject);
    procedure FormClose(Sender : TObject; var CloseAction : TCloseAction);
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

uses MBDefine,TestDeviceView;

{ TfrmDeviceView }

procedure TfrmDeviceView.FormClose(Sender : TObject; var CloseAction : TCloseAction);
begin
  CloseAction := caHide;
end;

procedure TfrmDeviceView.btTestDevViewClick(Sender : TObject);
var TempForm : TformTestDevView;
begin
  TempForm := TformTestDevView.Create(nil);
  TempForm.Device := FDevice;
  TempForm.Show;
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

