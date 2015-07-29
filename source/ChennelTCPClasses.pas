unit ChennelTCPClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     ChennelClasses;

type
  TChennelTCPThread = class(TChannelBaseThread)
   protected
    procedure Execute; override;
    procedure InitThread;
    procedure CloseThread;
   public
  end;

  TChennelTCP = class(TChannelBase)
   protected
    procedure SetActiveTrue; override;
   public
  end;

implementation

{ TChennelTCP }

procedure TChennelTCP.SetActiveTrue;
begin
  if Active then Exit;
  FChannelThread := TChennelTCPThread.Create(True);
  FChannelThread.Logger := Logger;

  FChannelThread.Start;
end;

{ TChennelTCPThread }

procedure TChennelTCPThread.Execute;
begin
  InitThread;
  try
   while Terminated do
    begin

    end;
  finally
   CloseThread;
  end;
end;

procedure TChennelTCPThread.InitThread;
begin
  try

  except
   on E : Exception do
    begin
     SendLogMessage(llError,'Поток TCP канала',Format('Инициализация. Ошибка: %s',[E.Message]));
    end;
  end;
end;

procedure TChennelTCPThread.CloseThread;
begin
  try

  except
   on E : Exception do
    begin
     SendLogMessage(llError,'Поток TCP канала',Format('Финализация. Ошибка: %s',[E.Message]));
    end;
  end;
end;

end.

