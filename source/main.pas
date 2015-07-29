unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ActnList, StdCtrls, ExtCtrls, syncobjs,
  DeviceView,
  MBDeviceClasses;

type

  { TfrmMain }

  TfrmMain = class(TForm)
     actFileLoadConf   : TAction;
     actFileSaveConf   : TAction;
     actExit           : TAction;
     actDevAdd         : TAction;
     actDevDel         : TAction;
     actDevClearList   : TAction;
     actDevView        : TAction;
     actChannelAdd     : TAction;
     actChannelDel     : TAction;
     actChannelClose   : TAction;
     actChannelOpen    : TAction;
     actChannelDelAll  : TAction;
     actChannelCloseAll: TAction;
     actChannelOpenAll : TAction;
     actLogSave        : TAction;
     actLogClear       : TAction;
     actlMain          : TActionList;
     btLogClear        : TButton;
     btLogSave         : TButton;
     btChannelAdd      : TButton;
     btChannelClerList : TButton;
     btChanelStartAll  : TButton;
     btChannelCloseAll : TButton;
     btChennelDel      : TButton;
     cbLogDebug        : TCheckBox;
     cbLogInfo         : TCheckBox;
     cbLogWarn         : TCheckBox;
     cbLogError        : TCheckBox;
     cmbLogLineCount   : TComboBox;
     lbChennelList     : TLabel;
     lbDeviceList      : TListBox;
     libChennelList    : TListBox;
     memLog            : TMemo;
     mmChannelDel      : TMenuItem;
     mmChannelOpen     : TMenuItem;
     mmChannelClose    : TMenuItem;
     mmChannelOpenAll  : TMenuItem;
     mmChannelStopAll  : TMenuItem;
     mmChannelDelAll   : TMenuItem;
     mmChannelAdd      : TMenuItem;
     mmChannels        : TMenuItem;
     mmLogSave         : TMenuItem;
     mmLogClear        : TMenuItem;
     mmLog             : TMenuItem;
     mmDevView         : TMenuItem;
     mmDevClearDevList : TMenuItem;
     mmDevDelDev       : TMenuItem;
     mmDevAddDev       : TMenuItem;
     mmExit            : TMenuItem;
     mmFileSaveConf    : TMenuItem;
     mmFileLoadConf    : TMenuItem;
     mmDevices         : TMenuItem;
     mmFiles           : TMenuItem;
     mMenu             : TMainMenu;
     odConf            : TOpenDialog;
     scrbChennelParams : TScrollBox;
     sdConf            : TSaveDialog;
     sdLog             : TSaveDialog;
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
     tbSplitter2       : TToolButton;
     tbLogSave         : TToolButton;
     tbLogClear        : TToolButton;
     tbSplitter3       : TToolButton;
     tbChannelAdd      : TToolButton;
     tbChamnnelDel     : TToolButton;
     tbChannelClose    : TToolButton;
     tbChannelOpen     : TToolButton;
     tbChannelDelAll   : TToolButton;
     tbChannelCloseAll : TToolButton;
     tbChannelOpenAll  : TToolButton;
     procedure actChannelAddExecute(Sender: TObject);
     procedure actChannelCloseAllExecute(Sender: TObject);
     procedure actChannelCloseExecute(Sender: TObject);
     procedure actChannelDelAllExecute(Sender: TObject);
     procedure actChannelDelExecute(Sender: TObject);
     procedure actChannelOpenAllExecute(Sender: TObject);
     procedure actChannelOpenExecute(Sender: TObject);
     procedure actDevAddExecute(Sender : TObject);
     procedure actDevClearListExecute(Sender : TObject);
     procedure actDevDelExecute(Sender : TObject);
     procedure actDevViewExecute(Sender : TObject);
     procedure actExitExecute(Sender : TObject);
     procedure actFileLoadConfExecute(Sender : TObject);
     procedure actFileSaveConfExecute(Sender : TObject);
     procedure actLogClearExecute(Sender: TObject);
     procedure actLogSaveExecute(Sender: TObject);
     procedure cbLogDebugChange(Sender: TObject);
     procedure cbLogErrorChange(Sender: TObject);
     procedure cbLogInfoChange(Sender: TObject);
     procedure cbLogWarnChange(Sender: TObject);
     procedure cmbLogLineCountChange(Sender: TObject);
     procedure FormClose(Sender : TObject; var CloseAction : TCloseAction);
     procedure FormCreate(Sender: TObject);
     procedure FormShow(Sender: TObject);
     procedure lbDeviceListDblClick(Sender : TObject);
     procedure memLogChange(Sender: TObject);
   private
     FDevArray     : TDeviceArray;
     FIsConfModify : Boolean;
     FDevView      : TfrmDeviceView;
     FCSection     : TCriticalSection;

     procedure ClearDevices;
     procedure Lock;
     procedure UnLock;
   public
  end;

var frmMain: TfrmMain;

implementation

{$R *.lfm}

uses DeviceAdd,
     framChennelRSClasses,framChennelTCPClasses,
     formChennelRSAdd,formChennelTCPAdd,
     LoggerLazarusGtkApplication,
     LoggerItf;

{ TfrmMain }

procedure TfrmMain.actChannelAddExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelDelExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelOpenExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelCloseExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelOpenAllExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelCloseAllExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actChannelDelAllExecute(Sender: TObject);
begin

end;

procedure TfrmMain.actFileLoadConfExecute(Sender : TObject);
begin
  if not odConf.Execute then Exit;

end;

procedure TfrmMain.actFileSaveConfExecute(Sender : TObject);
begin
  if not sdConf.Execute then Exit;

end;

procedure TfrmMain.actLogClearExecute(Sender: TObject);
begin
  memLog.Lines.Clear;
end;

procedure TfrmMain.actLogSaveExecute(Sender: TObject);
begin
  if not sdLog.Execute then Exit;
  memLog.Lines.SaveToFile(sdLog.FileName);
end;

procedure TfrmMain.cbLogDebugChange(Sender: TObject);
begin
  LoggerObj.EnableDebug := cbLogDebug.Checked;
end;

procedure TfrmMain.cbLogErrorChange(Sender: TObject);
begin
  LoggerObj.EnableError := cbLogError.Checked;
end;

procedure TfrmMain.cbLogInfoChange(Sender: TObject);
begin
  LoggerObj.EnableInfo := cbLogInfo.Checked;
end;

procedure TfrmMain.cbLogWarnChange(Sender: TObject);
begin
  LoggerObj.EnableWarn := cbLogWarn.Checked;
end;

procedure TfrmMain.cmbLogLineCountChange(Sender: TObject);
begin
  FIsConfModify := True;
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

   Lock;
   try
    FDevArray[TempDevNum] := TMBDevice.Create(nil);
    FDevArray[TempDevNum].DeviceNum := TempDevNum;
   finally
    UnLock;
   end;

   TempDevNum := lbDeviceList.Items.AddObject(Format('Устройство: %d',[TempDevNum]),FDevArray[TempDevNum]);
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
  Lock;
  try
   FDevArray[TempDev.DeviceNum] := nil;
   FreeAndNil(TempDev);
  finally
   UnLock;
  end;
  FIsConfModify := True;
end;

procedure TfrmMain.actDevViewExecute(Sender : TObject);
begin
  if lbDeviceList.ItemIndex = -1 then Exit;
  if not Assigned(FDevView) then
   begin
    FDevView := TfrmDeviceView.Create(nil);
    FDevView.CSection := FCSection;
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
 Lock;
 try
  for i := 0 to 255 do
   begin
    if Assigned(FDevArray[i]) then
     begin
      FDevArray[i].Free;
      FDevArray[i] := nil;
     end;
   end;
 finally
  UnLock;
 end;
end;

procedure TfrmMain.Lock;
begin
  FCSection.Enter;
end;

procedure TfrmMain.UnLock;
begin
  FCSection.Leave;
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
  FreeAndNil(FCSection);
  CloseAction := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCSection := TCriticalSection.Create;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoggerObj.LoggerStrings := memLog.Lines;
  LoggerObj.EnableInfo    := cbLogInfo.Checked;
  LoggerObj.EnableWarn    := cbLogWarn.Checked;
  LoggerObj.EnableError   := cbLogError.Checked;
  LoggerObj.EnableDebug   := cbLogDebug.Checked;
end;

procedure TfrmMain.lbDeviceListDblClick(Sender : TObject);
begin
  actDevViewExecute(Self);
end;

procedure TfrmMain.memLogChange(Sender: TObject);
begin
  if memLog.Lines.Count <= StrToInt(cmbLogLineCount.Items[cmbLogLineCount.ItemIndex]) then Exit;
  memLog.Lines.Delete(0);
end;

end.

