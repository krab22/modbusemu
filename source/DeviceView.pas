unit DeviceView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MBDeviceClasses;

type

  TfrmDeviceView = class(TForm)
     edDevNum : TEdit;
     lbDevNum : TLabel;
   private
     FDevice : TMBDevice;
     procedure SetDevice(AValue : TMBDevice);
     procedure ClearForm;
   public
     property Device : TMBDevice read FDevice write SetDevice;
  end;

var frmDeviceView : TfrmDeviceView;

implementation

{$R *.lfm}

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

  edDevNum.Text := IntToStr(FDevice.DeviceNum);
end;

procedure TfrmDeviceView.ClearForm;
begin
  edDevNum.Text := '';
end;

end.

