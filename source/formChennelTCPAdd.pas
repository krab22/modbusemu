unit formChennelTCPAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TfrmChennelTCPAdd = class(TForm)
    btOk     : TButton;
    btCancel : TButton;
    procedure btOkClick(Sender : TObject);
   private
    FChennelList : TStrings;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
  end;

var frmChennelTCPAdd : TfrmChennelTCPAdd;

implementation

uses LoggerLazarusGtkApplication,
     ChennelTCPClasses;

{$R *.lfm}

{ TfrmChennelTCPAdd }

procedure TfrmChennelTCPAdd.btOkClick(Sender : TObject);
begin
  LoggerObj.info('TfrmChennelTCPAdd', 'Добавили сетевой канал');
  Tag := FChennelList.AddObject('TCP канал',TChennelTCP.Create);
end;

end.

