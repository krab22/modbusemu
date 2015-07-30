unit formChennelAdd;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TformChenAdd = class(TForm)
    btAddRSChennel  : TButton;
    btAddTCPChennel : TButton;
    btCancel        : TButton;
    procedure btAddRSChennelClick(Sender : TObject);
    procedure btAddTCPChennelClick(Sender : TObject);
   private
    FChennelList : TStrings;
   public
    property ChennelList : TStrings read FChennelList write FChennelList;
  end;

var formChenAdd : TformChenAdd;

implementation

uses {$IFDEF UNIX}formChennelRSLinuxAdd{$ELSE}formChennelRSWindowsAdd{$ENDIF}, formChennelTCPAdd,
     LoggerLazarusGtkApplication;

{$R *.lfm}

{ TformChenAdd }

procedure TformChenAdd.btAddRSChennelClick(Sender : TObject);
var TempForm : TfrmChennelRSAdd;
    TempRes  : TModalResult;
begin
  TempRes := mrCancel;
  TempForm := TfrmChennelRSAdd.Create(Self);
  try
   TempForm.ChennelList := FChennelList;
   TempForm.ShowModal;
   TempRes := TempForm.ModalResult;
   Tag := TempForm.Tag;
  finally
   FreeAndNil(TempForm);
  end;
  ModalResult := TempRes;
end;

procedure TformChenAdd.btAddTCPChennelClick(Sender : TObject);
var TempForm : TfrmChennelTCPAdd;
    TempRes  : TModalResult;
begin
  TempRes := mrCancel;
  TempForm := TfrmChennelTCPAdd.Create(Self);
  try
   TempForm.ChennelList := FChennelList;
   TempForm.ShowModal;
   TempRes := TempForm.ModalResult;
   Tag := TempForm.Tag;
  finally
   FreeAndNil(TempForm);
  end;
  ModalResult := TempRes;
end;

end.

