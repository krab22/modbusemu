unit formChennelRSWindowsAdd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MBDeviceClasses;

type
  TTfrmChennelRSAdd = class(TForm)
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

var TfrmChennelRSAdd : TTfrmChennelRSAdd;

implementation

uses LoggerLazarusGtkApplication;

{$R *.lfm}

{ TTfrmChennelRSAdd }

procedure TTfrmChennelRSAdd.btOkClick(Sender : TObject);
var TempChen : TChennelRS;
begin
  LoggerObj.info('TfrmChennelRSAdd', 'Добавили последовательный канал');
  TempChen := TChennelRS.Create;
  TempChen.DeviceArray := FDevArray;
  Tag := FChennelList.AddObject('RS канал',TempChen);
end;

end.

