program filelogtest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
   {$IFDEF UseCThreads}
    cthreads,
   {$ENDIF}
  {$ENDIF}
  Interfaces,
  Forms, main;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

