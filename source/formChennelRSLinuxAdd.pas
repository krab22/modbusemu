unit formChennelRSLinuxAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, MBDeviceClasses, LoggerItf;

type

  { TfrmChennelRSAdd }

  TfrmChennelRSAdd = class(TForm)
    btCancel      : TButton;
    btOk          : TButton;
    cmbPrefix     : TComboBox;
    cmbBaudRate   : TComboBox;
    cmbByteSize   : TComboBox;
    cmbParitet    : TComboBox;
    cmbStopBits   : TComboBox;
    edChennalName : TEdit;
    edPrefixOther : TEdit;
    lbName        : TLabel;
    lbStopBits    : TLabel;
    lbParitet     : TLabel;
    lbByteSize    : TLabel;
    lbBaudRate    : TLabel;
    lbPortNum     : TLabel;
    lbPrefix      : TLabel;
    spePortNum    : TSpinEdit;

    procedure btOkClick(Sender : TObject);
    procedure cmbPrefixChange(Sender : TObject);
   private
    FChennelList : TStrings;
    FDevArray    : TDeviceArray;
    FLogger      : IDLogger;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
    property DevArray    : TDeviceArray read FDevArray write FDevArray;
    property Logger      : IDLogger read FLogger write FLogger;
  end;

var frmChennelRSAdd : TfrmChennelRSAdd;

implementation

uses ChennelRSClasses,
     COMPortParamTypes;

{$R *.lfm}

{ TfrmChennelRSAdd }

procedure TfrmChennelRSAdd.btOkClick(Sender : TObject);
var TempChen : TChennelRS;
begin
  TempChen := TChennelRS.Create;
  TempChen.Logger      := FLogger;
  TempChen.DeviceArray := FDevArray;

  if cmbPrefix.ItemIndex = 0 then TempChen.PortPrefix := pptLinux else TempChen.PortPrefix := pptOther;
  if TempChen.PortPrefix = pptOther then TempChen.PortPrefixOther := edPrefixOther.Text;

  TempChen.PortNum  := spePortNum.Value;
  TempChen.BaudRate := TComPortBaudRate(cmbBaudRate.ItemIndex+1);
  TempChen.ByteSize := TComPortDataBits(cmbByteSize.ItemIndex);
  TempChen.Parity   := TComPortParity(cmbParitet.ItemIndex);
  TempChen.StopBits := TComPortStopBits(cmbStopBits.ItemIndex);
  TempChen.Name     := edChennalName.Text;

  Tag := FChennelList.AddObject(TempChen.Name,TempChen);

  FLogger.info('Добавление канала', Format('Добавили канал: ',[edChennalName.Text]));
end;

procedure TfrmChennelRSAdd.cmbPrefixChange(Sender : TObject);
begin
  if cmbPrefix.ItemIndex = 1 then
   begin
    edPrefixOther.ReadOnly := False;
    edPrefixOther.Text := '/dev/tty';
   end
  else
   begin
    edPrefixOther.Text := '';
    edPrefixOther.ReadOnly := True;
   end;
end;

end.

