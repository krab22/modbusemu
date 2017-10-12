unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LoggerItf,
  LoggerFile;

type

  { TLogTestThread }

  TLogTestThread = class(TThreadLogged)
   protected
     procedure Execute; override;
  end;

  { TfrmMain }

  TfrmMain = class(TForm)
    lbLogPath     : TLabel;
    edLogFilePath : TEdit;
    lbMessage     : TLabel;
    edMessage     : TEdit;
    btSendMsg     : TButton;
    btTestThread: TButton;
    lbThreadState: TLabel;
    procedure btSendMsgClick(Sender: TObject);
    procedure btTestThreadClick(Sender: TObject);
  private
    FTestThread : TLogTestThread;
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TLogTestThread }

procedure TLogTestThread.Execute;
var i : Integer;
begin
  WriteLn(StdOut,'тестовый поток стартовал');
  i := 0;
  while not Terminated do
   begin
     SendLogMessage(llDebug,'LogTestThread',Format('Message: %d',[i]));
     inc(i);
     Sleep(200);
   end;
  WriteLn(StdOut,'тестовый поток остановлен');
end;

{ TfrmMain }

procedure TfrmMain.btSendMsgClick(Sender: TObject);
begin
   if not LoggerObj.LogEnable then
    begin
     LoggerObj.OwnerName   := 'test';
     LoggerObj.LogFilePath := edLogFilePath.Text;
     LoggerObj.LogLayerSet := LoggerObj.LogLayerSet + [lmtDebug];
     LoggerObj.FileMaxSize := 1024;
     LoggerObj.LogEnable   := True;
    end;
   LoggerObj.info('Начало',edMessage.Text);
   LoggerObj.info('Тестовое приложение1',edMessage.Text);
   LoggerObj.info('Тестовое приложение2',edMessage.Text);
   LoggerObj.info('Тестовое приложение3',edMessage.Text);
   LoggerObj.info('Тестовое приложение4',edMessage.Text);
   LoggerObj.info('Тестовое приложение5',edMessage.Text);
   LoggerObj.info('Тестовое приложение6',edMessage.Text);
   LoggerObj.info('Тестовое приложение7',edMessage.Text);
   LoggerObj.info('Тестовое приложение8',edMessage.Text);
   LoggerObj.info('Тестовое приложение9',edMessage.Text);
   LoggerObj.warn('Тестовое приложение10',edMessage.Text);
   LoggerObj.error('Тестовое приложение11',edMessage.Text);
   LoggerObj.debug('Тестовое приложение12',edMessage.Text);
   LoggerObj.info('Конец',edMessage.Text);
end;

procedure TfrmMain.btTestThreadClick(Sender: TObject);
begin
  if not LoggerObj.LogEnable then
    begin
     LoggerObj.OwnerName   := 'test';
     LoggerObj.LogFilePath := edLogFilePath.Text;
     LoggerObj.LogLayerSet := LoggerObj.LogLayerSet + [lmtDebug];
     LoggerObj.FileMaxSize := 1024;
     LoggerObj.LogEnable   := True;
    end;

  if FTestThread = nil then
   begin
    FTestThread := TLogTestThread.Create(True,65535);
    FTestThread.Logger := LoggerObj as IDLogger;
    FTestThread.Start;
   end
  else
   begin
    FTestThread.Terminate;
    FTestThread.WaitFor;
    FreeAndNil(FTestThread);
   end;
end;

end.

