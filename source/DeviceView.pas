unit DeviceView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Grids, syncobjs, MBDeviceClasses;

type

  { TfrmDeviceView }

  TfrmDeviceView = class(TForm)
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
   private
    FDevice   : TMBDevice;
    FCSection : TCriticalSection;
    procedure SetDevice(AValue : TMBDevice);
    procedure ClearForm;
    procedure UpdateCoils;
    procedure UpdateDiscrets;
    procedure UpdateHoldings;
    procedure UpdateInputs;
    procedure Lock;
    procedure UnLock;
   public
    property Device   : TMBDevice read FDevice write SetDevice;
    property CSection : TCriticalSection read FCSection write FCSection;
  end;

var frmDeviceView : TfrmDeviceView;

implementation

{$R *.lfm}

uses MBDefine;

{ TfrmDeviceView }

procedure TfrmDeviceView.SetDevice(AValue : TMBDevice);
begin
  if FDevice = AValue then Exit;
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
end;

procedure TfrmDeviceView.UpdateCoils;
begin
  Lock;
  try

  finally
   UnLock;
  end;
end;

procedure TfrmDeviceView.UpdateDiscrets;
begin
  Lock;
  try

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
begin
  Lock;
  try

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

end.

