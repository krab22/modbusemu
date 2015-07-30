unit framChennelRSClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls,
     ChennelClasses,ChennelRSClasses;

type
  TframeChennelRS = class(TFrame)
    lbChennelCapt : TLabel;
    private
     FChennel : TChannelBase;
     procedure SetChennel(AValue : TChannelBase);
     procedure UpdateChenInfo;
     procedure ClearInfo;
    public
     property Chennel : TChannelBase read FChennel write SetChennel;
  end;

implementation

uses LoggerLazarusGtkApplication;

{$R *.lfm}

{ TframeChennelRS }

procedure TframeChennelRS.SetChennel(AValue : TChannelBase);
begin
  if FChennel = AValue then Exit;
  FChennel := AValue;
  if Assigned(FChennel) then UpdateChenInfo
   else ClearInfo;
end;

procedure TframeChennelRS.UpdateChenInfo;
begin

end;

procedure TframeChennelRS.ClearInfo;
begin

end;

end.

