unit DeviceView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, syncobjs,
  MBDeviceClasses;

type

  { TfrmDeviceView }

  TfrmDeviceView = class(TForm)
    lbDeviceNumber : TLabel;
    lbDevNum : TLabel;
   private
    FDevice   : TMBDevice;
    FCSection : TCriticalSection;
    procedure SetDevice(AValue : TMBDevice);
    procedure ClearForm;
    procedure Lock;
    procedure UnLock;
   public
    property Device   : TMBDevice read FDevice write SetDevice;
    property CSection : TCriticalSection read FCSection write FCSection;
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

  Lock;
  try
   lbDeviceNumber.Caption := IntToStr(FDevice.DeviceNum);
  finally
    UnLock;
  end;
end;

procedure TfrmDeviceView.ClearForm;
begin
  lbDeviceNumber.Caption := '';
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

