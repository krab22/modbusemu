unit COMPortParamsFrame;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls,
     MBRTUMasterDispatcherTypes, COMPortParamTypes;

type

  { TTframParamsPort }

  TTframParamsPort = class(TFrame)
    btnAply        : TButton;
    btnCancel      : TButton;
    cbPortBaudRate : TComboBox;
    cbPortDataBits : TComboBox;
    cbPortParity   : TComboBox;
    cbPortStopBits : TComboBox;
    gbPort         : TGroupBox;
    gbPortParams   : TGroupBox;
    lbPortBaudRate : TLabel;
    lbPortDataBits : TLabel;
    lbPortName     : TLabel;
    lbPort         : TLabel;
    lbPortParity   : TLabel;
    lbPortStopBits : TLabel;
    procedure btnAplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbPortBaudRateChange(Sender: TObject);
    procedure cbPortDataBitsChange(Sender: TObject);
    procedure cbPortParityChange(Sender: TObject);
    procedure cbPortStopBitsChange(Sender: TObject);
  private
    FIsCancelVisible : Boolean;

    FPortParams      : TMBDispPortParam;

    FOnAplyParams    : TNotifyEvent;
    FOnCancelParams  : TNotifyEvent;

    procedure SetIsCancelVisible(AValue: Boolean);
    procedure SetPortParams(AValue: TMBDispPortParam);

    procedure SetParamData;
  public
   constructor Create(AOwner : TComponent); override;
   destructor  Destroy; override;

   property IsCancelVisible : Boolean read FIsCancelVisible write SetIsCancelVisible;
   property Params          : TMBDispPortParam read FPortParams write SetPortParams;

   property OnAplyParams    : TNotifyEvent read FOnAplyParams write FOnAplyParams;
   property OnCancelParams  : TNotifyEvent read FOnCancelParams write FOnCancelParams;
  end;

implementation

{$R *.frm}

uses Localize;

{ TTframParamsPort }

constructor TTframParamsPort.Create(AOwner: TComponent);
var i, TempLen : Integer;
begin
  inherited Create(AOwner);

  TranslateAppObject(Self);

  FillByte(FPortParams,SizeOf(FPortParams),0);

  TempLen := Length(ComPortBaudRateNames) - 2;
  for i := 0 to TempLen do cbPortBaudRate.AddItem(ComPortBaudRateNames[TComPortBaudRate(i)],nil);
  cbPortBaudRate.ItemIndex := Integer(br9600);

  TempLen := Length(ComPortDataBitsNames) - 2;
  for i := 0 to TempLen do cbPortDataBits.AddItem(ComPortDataBitsNames[TComPortDataBits(i)],nil);
  cbPortDataBits.ItemIndex := Integer(db8BITS);

  TempLen := Length(ComPortStopBitsNames) - 2;
  for i := 0 to TempLen do cbPortStopBits.AddItem(ComPortStopBitsNames[TComPortStopBits(i)],nil);
  cbPortStopBits.ItemIndex := Integer(sb1BITS);

  TempLen := Length(ComPortParityEngNames) - 2;
  for i := 0 to TempLen do cbPortParity.AddItem(ComPortParityEngNames[TComPortParity(i)],nil);
  cbPortParity.ItemIndex := Integer(ptEVEN);

  FPortParams.PortNum := 0;

  FPortParams.BaudRate := br9600;
  FPortParams.DataBits := db8BITS;
  FPortParams.StopBits := sb1BITS;
  FPortParams.Parity   := ptEVEN;

  SetIsCancelVisible(False);
end;

destructor TTframParamsPort.Destroy;
begin
  inherited Destroy;
end;

procedure TTframParamsPort.cbPortBaudRateChange(Sender: TObject);
begin
  FPortParams.BaudRate := TComPortBaudRate(cbPortBaudRate.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TTframParamsPort.cbPortDataBitsChange(Sender: TObject);
begin
  FPortParams.DataBits := TComPortDataBits(cbPortDataBits.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TTframParamsPort.cbPortParityChange(Sender: TObject);
begin
  FPortParams.Parity := TComPortParity(cbPortParity.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TTframParamsPort.cbPortStopBitsChange(Sender: TObject);
begin
  FPortParams.StopBits := TComPortStopBits(cbPortStopBits.ItemIndex);
  btnAply.Enabled := True;
end;

procedure TTframParamsPort.btnCancelClick(Sender: TObject);
begin
  if Assigned(FOnCancelParams) then FOnCancelParams(Self);
end;

procedure TTframParamsPort.btnAplyClick(Sender: TObject);
begin
  if Assigned(FOnAplyParams) then FOnAplyParams(Self);
  btnAply.Enabled := False;
end;

procedure TTframParamsPort.SetPortParams(AValue: TMBDispPortParam);
var TempName : String;
begin
  TempName := Format('%s%d',[AValue.PortPrefix,AValue.PortNum]);
  lbPortName.Caption := TempName;
  FPortParams := AValue;

  cbPortBaudRate.ItemIndex := Integer(FPortParams.BaudRate);
  cbPortDataBits.ItemIndex := Integer(FPortParams.DataBits);
  cbPortStopBits.ItemIndex := Integer(FPortParams.StopBits);
  cbPortParity.ItemIndex   := Integer(FPortParams.Parity);
end;

procedure TTframParamsPort.SetIsCancelVisible(AValue: Boolean);
begin
  if FIsCancelVisible=AValue then Exit;
  FIsCancelVisible := AValue;
  btnCancel.Visible:= FIsCancelVisible;
end;

procedure TTframParamsPort.SetParamData;
begin
  FPortParams.BaudRate := TComPortBaudRate(cbPortBaudRate.ItemIndex);
  FPortParams.DataBits := TComPortDataBits(cbPortDataBits.ItemIndex);
  FPortParams.StopBits := TComPortStopBits(cbPortStopBits.ItemIndex);
  FPortParams.Parity   := TComPortParity(cbPortParity.ItemIndex);
end;

end.

