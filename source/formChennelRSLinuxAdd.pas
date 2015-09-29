unit formChennelRSLinuxAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
     MBDeviceClasses;

type
  TfrmChennelRSAdd = class(TForm)
    btCancel : TButton;
    btOk     : TButton;
    procedure btOkClick(Sender : TObject);
   private
    FChennelList : TStrings;
    FDevArray    : TDeviceArray;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
    property DevArray    : TDeviceArray read FDevArray write FDevArray;
  end;

var frmChennelRSAdd : TfrmChennelRSAdd;

implementation

uses LoggerLazarusGtkApplication,
     ChennelRSClasses;

{$R *.lfm}

{ TfrmChennelRSAdd }

procedure TfrmChennelRSAdd.btOkClick(Sender : TObject);
var TempChen : TChennelRS;
begin
  LoggerObj.info('TfrmChennelRSAdd', 'Добавили последовательный канал');
  TempChen := TChennelRS.Create;
  TempChen.DeviceArray := FDevArray;
  Tag := FChennelList.AddObject('RS канал',TempChen);
end;

end.

