unit DeviceAdd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TfrmAddDevice = class(TForm)
    btOk        : TButton;
    btCancel    : TButton;
    edDevNumber : TEdit;
    lbDevNumber : TLabel;
   private
   public
  end;

var
  frmAddDevice : TfrmAddDevice;

implementation

{$R *.lfm}

end.

