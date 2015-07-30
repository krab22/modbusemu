unit formChennelRSLinuxAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TfrmChennelRSAdd = class(TForm)
    btCancel : TButton;
    btOk     : TButton;
    procedure btOkClick(Sender : TObject);
   private
    FChennelList : TStrings;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
  end;

var frmChennelRSAdd : TfrmChennelRSAdd;

implementation

uses LoggerLazarusGtkApplication,
     ChennelRSClasses;

{$R *.lfm}

{ TfrmChennelRSAdd }

procedure TfrmChennelRSAdd.btOkClick(Sender : TObject);
begin
  LoggerObj.info('TfrmChennelRSAdd', 'Добавили последовательный канал');
  Tag := FChennelList.AddObject('RS канал',TChennelRS.Create);
end;

end.

