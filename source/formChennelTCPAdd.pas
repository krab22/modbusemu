unit formChennelTCPAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
     MBDeviceClasses, LoggerItf;

type

  { TfrmChennelTCPAdd }

  TfrmChennelTCPAdd = class(TForm)
    btOk      : TButton;
    btCancel  : TButton;
    edAddress : TEdit;
    edPort    : TEdit;
    edName    : TEdit;
    lbPort    : TLabel;
    lbAddress : TLabel;
    lbName    : TLabel;
    procedure btOkClick(Sender : TObject);
   private
    FChennelList : TStrings;
    FDevArray    : TDeviceArray;
    FLogger      : IDLogger;
    function IsChannelExist : Boolean;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
    property DevArray    : TDeviceArray read FDevArray write FDevArray;
    property Logger      : IDLogger read FLogger write FLogger;
  end;

var frmChennelTCPAdd : TfrmChennelTCPAdd;

implementation

uses ChennelTCPClasses, SocketMisc,
     ModbusEmuResStr;

{$R *.lfm}

{ TfrmChennelTCPAdd }

procedure TfrmChennelTCPAdd.btOkClick(Sender : TObject);
var TempChen : TChennelTCP;
    TempAddr : Cardinal;
    TempPort : Word;
begin
  Tag := -1;
  if (edName.Text = '') or (edAddress.Text = '') or (edPort.Text = '') then raise Exception.Create(rsFrmAddTCPChannel2);
  try
   TempAddr := GetIPFromStr(edAddress.Text);
  except
   on E : Exception do
    begin
     FLogger.debug(rsFrmAddTCPChannel1,Format(rsFrmAddTCPChannel3,[edAddress.Text]));
     raise Exception.CreateFmt(rsFrmAddTCPChannel4,[edAddress.Text]);
    end;
  end;
  try
   TempPort := StrToInt(edPort.Text);
  except
   on E : Exception do
    begin
     FLogger.debug(rsFrmAddTCPChannel1,Format(rsFrmAddTCPChannel5,[edPort.Text]));
     raise Exception.CreateFmt(rsFrmAddTCPChannel6,[edPort.Text]);
    end;
  end;
  try

   if IsChannelExist then raise Exception.CreateFmt(rsFrmAddTCPChannel7,[edName.Text,edAddress.Text,edPort.Text]);

   TempChen := TChennelTCP.Create;
   TempChen.Logger      := FLogger;
   TempChen.DeviceArray := FDevArray;
   TempChen.BindAddress := edAddress.Text;
   TempChen.Port        := TempPort;
   TempChen.Name        := edName.Text;

   Tag := FChennelList.AddObject(edName.Text,TempChen);

   FLogger.info(rsFrmAddTCPChannel1,Format(rsFrmAddTCPChannel8,[edName.Text,edAddress.Text,TempPort]));

  except
    on E : Exception do
     begin
      FLogger.error(rsFrmAddTCPChannel1,Format(rsFrmAddTCPChannel9,[E.Message]));
      Exit;
     end;
  end;

end;

function TfrmChennelTCPAdd.IsChannelExist : Boolean;
var i,Count : Integer;
    TempChen : TChennelTCP;
    TempID,NewID : String;
begin
  Result := False;
  NewID  := Format('%s:%s',[edAddress.Text,edPort.Text]);
  Count := FChennelList.Count-1;
  for i := 0 to Count do
   begin
    if FChennelList.Objects[i].ClassType <> TChennelTCP then Continue;
    TempChen := TChennelTCP(FChennelList.Objects[i]);
    TempID := Format('%s:%d',[TempChen.BindAddress,TempChen.Port]);
    if SameText(TempID,NewID) then
     begin
      Result := True;
      Break;
     end;
   end;
end;

end.

