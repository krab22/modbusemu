unit ChennelRSClasses;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,
     ChennelClasses;

type
  TChennelRSThread = class(TChannelBaseThread)
   protected
    procedure Execute; override;
    procedure InitThread;
    procedure CloseThread;
   public
  end;

  TChennelRS = class(TChannelBase)
   protected
    procedure SetActiveTrue; override;
   public
  end;

implementation

uses LoggerItf;

{ TChennelRS }

procedure TChennelRS.SetActiveTrue;
begin
  if Active then Exit;
  FChannelThread := TChennelRSThread.Create(True);
  FChannelThread.Logger := Logger;

  FChannelThread.Start;
end;

{ TChennelRSThread }

procedure TChennelRSThread.Execute;
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

procedure TChennelRSThread.InitThread;
begin
  try

  except
   on E : Exception do
    begin
     SendLogMessage(llError,'Поток RS канала',Format('Инициализация. Ошибка: %s',[E.Message]));
    end;
  end;
end;

procedure TChennelRSThread.CloseThread;
begin
  try

  except
   on E : Exception do
    begin
     SendLogMessage(llError,'Поток RS канала',Format('Финализация. Ошибка: %s',[E.Message]));
    end;
  end;
end;

end.

