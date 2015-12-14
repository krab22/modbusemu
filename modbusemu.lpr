program modbusemu;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces,
  Forms, main, ModbusEmuResStr, ExceptionsResStrings, DeviceAdd,
  DeviceView,formChennelAdd,
  {$IFDEF UNIX}formChennelRSLinuxAdd,{$ELSE}formChennelRSWindowsAdd,{$ENDIF}
  formChennelTCPAdd,
  framChennelRSClasses,framChennelTCPClasses, TestDeviceView, formRahgeEdit;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TformTestDevView, formTestDevView);
  Application.CreateForm(TfrmRangeEdit, frmRangeEdit);
  Application.Run;
end.

