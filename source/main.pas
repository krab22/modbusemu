unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ActnList, StdCtrls, ExtCtrls, syncobjs,
  DeviceView,
  framChennelRSClasses,framChennelTCPClasses,
  ChennelClasses,
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
     mppiOpenChennal   : TMenuItem;
     mppiCloseChennal  : TMenuItem;
     mppiDelChennal    : TMenuItem;
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
     ppmChennalOperations : TPopupMenu;
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
     procedure libChennelListSelectionChange(Sender : TObject; User : boolean);
     procedure memLogChange(Sender: TObject);
   private
     FDevArray     : TDeviceArray;
     FIsConfModify : Boolean;
     FDevView      : TfrmDeviceView;
     FCSection     : TCriticalSection;
     FChenRSFrame  : TframeChennelRS;
     FChenTCPFrame : TframeChennelTCP;

     procedure ClearDevices;
     procedure ClearFrames;
     procedure ClearChennals;
     procedure Lock;
     procedure UnLock;
     procedure SetChennelFrame(AChennel : TChennelBase);
   public
  end;

var frmMain: TfrmMain;

implementation

{$R *.lfm}

uses DeviceAdd,
     ChennelRSClasses, ChennelTCPClasses,
     formChennelAdd, ModbusEmuResStr,
     LoggerLazarusGtkApplication,
     LoggerItf;

{ TfrmMain }

procedure TfrmMain.actFileLoadConfExecute(Sender : TObject);
begin
  if not odConf.Execute then Exit;

end;

procedure TfrmMain.actFileSaveConfExecute(Sender : TObject);
begin
  if not sdConf.Execute then Exit;

end;

procedure TfrmMain.actChannelAddExecute(Sender: TObject);
var TempFrm : TformChenAdd;
    TempIndex : Integer;
    TempChenName : String;
    TempRes  : TModalResult;
begin
  TempFrm := TformChenAdd.Create(Self);
  try
    TempFrm.Logger := LoggerObj as IDLogger;
    TempFrm.ChennelList := libChennelList.Items;
    TempFrm.DevArray := FDevArray;
    TempRes := TempFrm.ShowModal;
    TempIndex := TempFrm.Tag;
  finally
   FreeAndNil(TempFrm);
  end;
  if TempRes <> mrOK then Exit;
  if TempIndex = -1 then Exit;
  libChennelList.ItemIndex := TempIndex;
  TempChenName := libChennelList.Items.Strings[TempIndex];
  LoggerObj.info(rsAddChennel,Format(rsAddChennel1,[TempChenName]));
  FIsConfModify := True;
end;

procedure TfrmMain.actChannelDelExecute(Sender: TObject);
var TempChen : TObject;
    TempChenName : String;
begin
  if libChennelList.ItemIndex = -1 then
   begin
    libChennelList.SetFocus;
    raise Exception.Create(rsDelChannel1);
   end;
  TempChen := libChennelList.Items.Objects[libChennelList.ItemIndex];
  TempChenName := libChennelList.Items.Strings[libChennelList.ItemIndex];;
  if not Assigned(TempChen) then Exit;
  libChennelList.Items.Objects[libChennelList.ItemIndex] := nil;
  libChennelList.Items.Delete(libChennelList.ItemIndex);
  FreeAndNil(TempChen);
  if libChennelList.Items.Count > 0 then libChennelList.ItemIndex := 0
   else libChennelList.ItemIndex := -1;
  LoggerObj.info(rsDelChannel2,Format(rsDelChannel3,[TempChenName]));
  FIsConfModify := True;
end;

procedure TfrmMain.actChannelOpenExecute(Sender: TObject);
var TempChen  : TChennelBase;
    TempChenName : String;
begin
  if libChennelList.ItemIndex = -1 then
   begin
    libChennelList.SetFocus;
    raise Exception.Create(rsOpenChennel1);
   end;
  TempChen := TChennelBase(libChennelList.Items.Objects[libChennelList.ItemIndex]);
  if not Assigned(TempChen) then Exit;
  TempChen.Active := True;
  TempChenName :=libChennelList.Items.Strings[libChennelList.ItemIndex];
  if TempChen.Active then LoggerObj.info(rsOpenChennel2,Format(rsOpenChennel3,[TempChenName]))
   else LoggerObj.info(rsOpenChennel2,Format(rsOpenChennel4,[TempChenName]));
end;

procedure TfrmMain.actChannelCloseExecute(Sender: TObject);
var TempChen  : TChennelBase;
    TempChenName : String;
begin
  if libChennelList.ItemIndex = -1 then
   begin
    libChennelList.SetFocus;
    raise Exception.Create(rsCloseChennel1);
   end;
  TempChen := TChennelBase(libChennelList.Items.Objects[libChennelList.ItemIndex]);
  if not Assigned(TempChen) then Exit;
  TempChen.Active := False;
  TempChenName :=libChennelList.Items.Strings[libChennelList.ItemIndex];
  if TempChen.Active then LoggerObj.info(rsCloseChennel2,Format(rsCloseChennel3,[TempChenName]))
   else LoggerObj.info(rsCloseChennel2,Format(rsCloseChennel4,[TempChenName]));
end;

procedure TfrmMain.actChannelOpenAllExecute(Sender: TObject);
var TempChen  : TChennelBase;
    i, Count  : Integer;
begin
  Count := libChennelList.Items.Count-1;
  for i := 0 to Count do
   begin
    TempChen := TChennelBase(libChennelList.Items.Objects[i]);
    if not Assigned(TempChen) then Continue;
    TempChen.Active := True;
   end;
  LoggerObj.info(rsOpenChennelAll1,rsOpenChennelAll2);
end;

procedure TfrmMain.actChannelCloseAllExecute(Sender: TObject);
var TempChen  : TChennelBase;
    i, Count  : Integer;
begin
  Count := libChennelList.Items.Count-1;
  for i := 0 to Count do
   begin
    TempChen := TChennelBase(libChennelList.Items.Objects[i]);
    if not Assigned(TempChen) then Continue;
    TempChen.Active := False;
   end;
  LoggerObj.info(rsCloseChennelAll1,rsCloseChennelAll2);
end;

procedure TfrmMain.actChannelDelAllExecute(Sender: TObject);
var i, Count : Integer;
begin
  if Assigned(FChenRSFrame) then FChenRSFrame.Parent := nil;
  if Assigned(FChenTCPFrame) then FChenTCPFrame.Parent := nil;
  Count := libChennelList.Items.Count-1;
  if Count = -1 then Exit;
  for i := Count downto 0 do if Assigned(libChennelList.Items.Objects[i]) then libChennelList.Items.Objects[i].Free;
  libChennelList.ItemIndex := -1;
  libChennelList.Items.Clear;
  LoggerObj.info(rsDelChennelAll1,rsDelChennelAll2);
  FIsConfModify := True;
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

procedure TfrmMain.libChennelListSelectionChange(Sender : TObject; User : boolean);
var TempChen  : TChennelBase;
    TempIndex : Integer;
begin
  TempIndex := libChennelList.ItemIndex;
  if TempIndex = -1 then
   begin
    if Assigned(FChenRSFrame) then FChenRSFrame.Parent := nil;
    if Assigned(FChenTCPFrame) then FChenTCPFrame.Parent := nil;
    Exit;
   end;
  TempChen := TChennelBase(libChennelList.Items.Objects[TempIndex]);
  if not Assigned(TempChen) then Exit;
  SetChennelFrame(TempChen);
end;

procedure TfrmMain.SetChennelFrame(AChennel : TChennelBase);
begin
  if AChennel.ClassType = TChennelRS then
   begin
    if not Assigned(FChenRSFrame) then FChenRSFrame := TframeChennelRS.Create(Self);
    if Assigned(FChenTCPFrame) then FChenTCPFrame.Parent := nil;
    FChenRSFrame.Chennel := AChennel;
    FChenRSFrame.Parent  := scrbChennelParams;
   end;

  if AChennel.ClassType = TChennelTCP then
   begin
    if not Assigned(FChenTCPFrame) then FChenTCPFrame := TframeChennelTCP.Create(Self);
    if Assigned(FChenRSFrame) then FChenRSFrame.Parent := nil;
    FChenTCPFrame.Chennel := AChennel;
    FChenTCPFrame.Parent  := scrbChennelParams;
   end;
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
      raise Exception.CreateFmt(rsDevAdd1 ,[TempAddForm.edDevNumber.Text]);
     end;
   end;
   if (TempDevNum < 1) or (TempDevNum > 255) then raise Exception.CreateFmt(rsDevAdd1 ,[TempAddForm.edDevNumber.Text]);
   if Assigned(FDevArray[TempDevNum]) then Exit;
   Lock;
   try
    FDevArray[TempDevNum] := TMBDevice.Create(nil);
    FDevArray[TempDevNum].DeviceNum := TempDevNum;
   finally
    UnLock;
   end;
   TempDevNum := lbDeviceList.Items.AddObject(Format(rsDevAdd2,[TempDevNum]),FDevArray[TempDevNum]);
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

procedure TfrmMain.ClearFrames;
begin
  if Assigned(FChenTCPFrame) then
   begin
    FChenTCPFrame.Chennel := nil;
    FChenTCPFrame.Parent := nil;
    FreeAndNil(FChenTCPFrame);
   end;
  if Assigned(FChenRSFrame) then
   begin
    FChenRSFrame.Chennel := nil;
    FChenRSFrame.Parent := nil;
    FreeAndNil(FChenRSFrame);
   end;
end;

procedure TfrmMain.ClearChennals;
begin
  actChannelDelAll.Execute;
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
  ClearChennals;
  ClearFrames;
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

