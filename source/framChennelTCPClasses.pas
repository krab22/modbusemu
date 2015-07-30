unit framChennelTCPClasses;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls,
  ChennelClasses,ChennelTCPClasses;

type
  TframeChennelTCP = class(TFrame)
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

{ TframeChennelTCP }

procedure TframeChennelTCP.SetChennel(AValue : TChannelBase);
begin
  if FChennel = AValue then Exit;
  FChennel := AValue;
  if Assigned(FChennel) then UpdateChenInfo
   else ClearInfo;
end;

procedure TframeChennelTCP.UpdateChenInfo;
begin

end;

procedure TframeChennelTCP.ClearInfo;
begin

end;

end.

