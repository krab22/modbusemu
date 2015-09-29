unit formChennelTCPAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
     MBDeviceClasses;

type
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
    function IsChannelExist : Boolean;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
    property DevArray    : TDeviceArray read FDevArray write FDevArray;
  end;

var frmChennelTCPAdd : TfrmChennelTCPAdd;

implementation

uses LoggerLazarusGtkApplication,
     ChennelTCPClasses, SocketMisc,
     ModbusEmuResStr;

{$R *.lfm}

{ TfrmChennelTCPAdd }

procedure TfrmChennelTCPAdd.btOkClick(Sender : TObject);
var TempChen : TChennelTCP;
    TempAddr : Cardinal;
    TempPort : Word;
begin
  Tag := -1;
  if (edName.Text = '') or (edAddress.Text = '') or (edPort.Text = '') then raise Exception.Create('Все поля должны быть заполнены.');
  try
   TempAddr := GetIPFromStr(edAddress.Text);
  except
   on E : Exception do
    begin
     LoggerObj.debug('Добавление сетевого канала',Format('Ошибка во введенном адресе: %s',[edAddress.Text]));
     raise Exception.CreateFmt('Вы совершили ошибку при вводе адреса канала: %s. Должен быть введен корректный IP-адрес.',[edAddress.Text]);
    end;
  end;
  try
   TempPort := StrToInt(edPort.Text);
  except
   on E : Exception do
    begin
     LoggerObj.debug('Добавление сетевого канала',Format('Ошибка во введенном номере порта: %s',[edPort.Text]));
     raise Exception.CreateFmt('Вы совершили ошибку при вводе номере порта канала: %s. Должен быть введен корректный номер порта в диапазоне от 1 до 65535.',[edPort.Text]);
    end;
  end;
  try

   if IsChannelExist then raise Exception.CreateFmt('Канал с указанными параметрами (%s:%s:%s) уже существует.',[edName.Text,edAddress.Text,edPort.Text]);

   TempChen := TChennelTCP.Create;
   TempChen.DeviceArray := FDevArray;
   TempChen.BindAddress := edAddress.Text;
   TempChen.Port        := TempPort;
   TempChen.Name        := edName.Text;

   Tag := FChennelList.AddObject(edName.Text,TempChen);

   LoggerObj.info('TfrmChennelTCPAdd',Format('Добавили сетевой канал: %s:%s:%d',[edName.Text,edAddress.Text,TempPort]));

  except
    on E : Exception do
     begin
      LoggerObj.error(rsAddChennel,Format('При добавлении канала произошла ошибка: %s',[E.Message]));
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

