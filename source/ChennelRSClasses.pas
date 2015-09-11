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

uses LoggerItf, ModbusEmuResStr;

{ TChennelRS }

procedure TChennelRS.SetActiveTrue;
begin
  if Active then Exit;
  FChannelThread := TChennelRSThread.Create(True);
  FChannelThread.Logger := Logger;
  FChannelThread.DeviceArray := DeviceArray;

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
     SendLogMessage(llError,rsChanRS1,Format(rsChanThreadIni,[E.Message]));
    end;
  end;
end;

procedure TChennelRSThread.CloseThread;
begin
  try

  except
   on E : Exception do
    begin
     SendLogMessage(llError,rsChanRS1,Format(rsChanThreadClose,[E.Message]));
    end;
  end;
end;

end.

