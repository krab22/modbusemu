unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ActnList, StdCtrls, ExtCtrls,
  DeviceView,
  MBDeviceClasses;

type
  TfrmMain = class(TForm)
     actFileLoadConf   : TAction;
     actFileSaveConf   : TAction;
     actExit           : TAction;
     actDevAdd         : TAction;
     actDevDel         : TAction;
     actDevClearList   : TAction;
     actDevView : TAction;
     actlMain          : TActionList;
     lbDeviceList      : TListBox;
     mmDevView : TMenuItem;
     mmDevClearDevList : TMenuItem;
     mmDevDelDev       : TMenuItem;
     mmDevAddDev       : TMenuItem;
     mmExit            : TMenuItem;
     mmFileSaveConf    : TMenuItem;
     mmFileLoadConf    : TMenuItem;
     mmDevices         : TMenuItem;
     mmFiles           : TMenuItem;
     mMenu             : TMainMenu;
     sbMainClientSpace : TScrollBox;
     Splitter1         : TSplitter;
     StatusBar1        : TStatusBar;
     tbMain            : TToolBar;
     tbFileLoadConf    : TToolButton;
     tbFileSaveConf    : TToolButton;
     tbFileExit        : TToolButton;
     tbSepor1          : TToolButton;
     tbDevAddDev       : TToolButton;
     tbDevDelDev       : TToolButton;
     tbDevClearDevList : TToolButton;
     procedure actDevAddExecute(Sender : TObject);
     procedure actDevClearListExecute(Sender : TObject);
     procedure actDevDelExecute(Sender : TObject);
     procedure actDevViewExecute(Sender : TObject);
     procedure actExitExecute(Sender : TObject);
     procedure actFileLoadConfExecute(Sender : TObject);
     procedure actFileSaveConfExecute(Sender : TObject);
     procedure FormClose(Sender : TObject; var CloseAction : TCloseAction);
     procedure lbDeviceListDblClick(Sender : TObject);
   private
     FDevArray     : TDeviceArray;
     FIsConfModify : Boolean;
     FDevView      : TfrmDeviceView;

     procedure ClearDevices;
   public
  end;

var frmMain: TfrmMain;

implementation

{$R *.lfm}

uses DeviceAdd;

{ TfrmMain }

procedure TfrmMain.actFileLoadConfExecute(Sender : TObject);
begin

end;

procedure TfrmMain.actFileSaveConfExecute(Sender : TObject);
begin

end;

procedure TfrmMain.actDevAddExecute(Sender : TObject);
var TempAddForm : TfrmAddDevice;
    TempDevNum  : Integer;
begin
  TempAddForm := TfrmAddDevice.Create(nil);
  try
   if TempAddForm.ShowModal <> mrOK then Exit;

   try
    TempDevNum := StrToInt(TempAddForm.edDevNumber.Text);
   except
    on E : Exception do
     begin
      raise Exception.CreateFmt('Ошибка ввода номера устройства. Вами введен некорректный номер устройства - %s'#10'Номер должен быть числом от 1 до 255' ,[TempAddForm.edDevNumber.Text]);
     end;
   end;

   if (TempDevNum < 1) or (TempDevNum > 255) then raise Exception.CreateFmt('Ошибка ввода номера устройства. Вами введен некорректный номер устройства - %s'#10'Номер должен быть числом от 1 до 255' ,[TempAddForm.edDevNumber.Text]);

   if Assigned(FDevArray[TempDevNum]) then Exit;

   FDevArray[TempDevNum] := TMBDevice.Create(nil);
   FDevArray[TempDevNum].DeviceNum := TempDevNum;

   TempDevNum := lbDeviceList.Items.AddObject(Format('Устройство №%d',[TempDevNum]),FDevArray[TempDevNum]);
   lbDeviceList.ItemIndex := TempDevNum;

   FIsConfModify := True;
  finally
    FreeAndNil(TempAddForm);
  end;
end;

procedure TfrmMain.actDevDelExecute(Sender : TObject);
var TempDev : TMBDevice;
begin
  if lbDeviceList.ItemIndex = -1 then Exit;
  TempDev := TMBDevice(lbDeviceList.Items.Objects[lbDeviceList.ItemIndex]);
  if Assigned(FDevView) then
   if FDevView.Device = TempDev then
    begin
     if FDevView.IsVisible then FDevView.Close;
     FDevView.Device := nil;
    end;
  lbDeviceList.Items.Objects[lbDeviceList.ItemIndex] := nil;
  lbDeviceList.Items.Delete(lbDeviceList.ItemIndex);
  if lbDeviceList.Items.Count > 0 then lbDeviceList.ItemIndex := 0;
  FDevArray[TempDev.DeviceNum] := nil;
  FreeAndNil(TempDev);
  FIsConfModify := True;
end;

procedure TfrmMain.actDevViewExecute(Sender : TObject);
begin
  if lbDeviceList.ItemIndex = -1 then Exit;
  if not Assigned(FDevView) then
   begin
    FDevView := TfrmDeviceView.Create(nil);
   end;
  FDevView.Device := TMBDevice(lbDeviceList.Items.Objects[lbDeviceList.ItemIndex]);
  FDevView.Show;
end;

procedure TfrmMain.actDevClearListExecute(Sender : TObject);
begin
  lbDeviceList.Clear;
  ClearDevices;
  FIsConfModify := True;
end;

procedure TfrmMain.ClearDevices;
var i : Integer;
begin
  for i := 0 to 255 do
   begin
    if Assigned(FDevArray[i]) then
     begin
      FDevArray[i].Free;
      FDevArray[i] := nil;
     end;
   end;
end;

procedure TfrmMain.actExitExecute(Sender : TObject);
begin
  Close;
end;

procedure TfrmMain.FormClose(Sender : TObject; var CloseAction : TCloseAction);
begin
  if Assigned(FDevView) then
   begin
    FDevView.Device := nil;
    FDevView.Free;
   end;
  ClearDevices;
  CloseAction := caFree;
end;

procedure TfrmMain.lbDeviceListDblClick(Sender : TObject);
begin
  actDevViewExecute(Self);
end;

end.

