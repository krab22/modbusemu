unit main;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnOpenPort    : TButton;
    btnClosePort   : TButton;
    btnSendRequest : TButton;
    btnGetDCB: TButton;
    memLog         : TMemo;
    procedure btnClosePortClick(Sender: TObject);
    procedure btnGetDCBClick(Sender: TObject);
    procedure btnOpenPortClick(Sender: TObject);
    procedure btnSendRequestClick(Sender: TObject);
  private
    FPortHandle   : THandle;
    FDCB          : TDCB;
    FPortProperty : TCOMMPROP;
    FPortTimeouts : TCommTimeouts;
    FEventMask    : DWORD;
    procedure DcbToLog(ADCB : TDCB);
    procedure TimeoutsToLog(ATimeouts : TCommTimeouts);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const

  dcbFlag_Binary              = $00000001;
  dcbFlag_ParityCheck         = $00000002;
  dcbFlag_OutxCtsFlow         = $00000004;
  dcbFlag_OutxDsrFlow         = $00000008;
  dcbFlag_DtrControlDisable   = $00000000;
  dcbFlag_DtrControlEnable    = $00000010;
  dcbFlag_DtrControlHandshake = $00000020;
  dcbFlag_DtrControlMask      = $00000030;
  dcbFlag_DsrSensitvity       = $00000040;
  dcbFlag_TXContinueOnXoff    = $00000080;
  dcbFlag_OutX                = $00000100;
  dcbFlag_InX                 = $00000200;
  dcbFlag_ErrorChar           = $00000400;
  dcbFlag_NullStrip           = $00000800;
//  dcbFlag_RtsControlMask      = $00003000;
  dcbFlag_RtsControlDisable   = $00000000;
  dcbFlag_RtsControlEnable    = $00001000;
  dcbFlag_RtsControlHandshake = $00002000;
  dcbFlag_RtsControlToggle    = $00003000;
  dcbFlag_AbortOnError        = $00004000;
  dcbFlag_Reserveds           = $FFFF8000;

{ TForm1 }

procedure TForm1.btnOpenPortClick(Sender: TObject);
var TempDCB : TDCB;
    TempTimeouts: TCommTimeouts;
begin
  FPortHandle := CreateFile('\\.\COM11',
                            GENERIC_READ or GENERIC_WRITE,
                            0,
                            nil,
                            OPEN_EXISTING,
                            FILE_FLAG_OVERLAPPED,
                            0);
  if (FPortHandle = INVALID_HANDLE_VALUE) then
   begin
     memLog.Lines.add(Format('Open port COM11 - %s',['Не удалось открыть файл']));
     Exit;
   end;

  FPortProperty.dwProvSpec1   := COMMPROP_INITIALIZED;
  FPortProperty.wPacketLength := SizeOf(FPortProperty);
  if not GetCommProperties(FPortHandle,FPortProperty) then
   begin
    memLog.Lines.Add(Format('GetCommProperties - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  if not GetCommState(FPortHandle,FDCB)then
   begin
    memLog.Lines.Add(Format('GetCommState - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add('Исходная DCB в устройстве:');
  DcbToLog(FDCB);

  FDCB.DCBlength:=sizeof(TDCB);
  FDCB.BaudRate  := 19200;
  FDCB.Flags     := dcbFlag_Binary or dcbFlag_ParityCheck;
  FDCB.XonLim    := 2048;
  FDCB.XoffLim   := 512;
  FDCB.ByteSize  := 8; // - 8 bit
  FDCB.Parity    := 2; // - even
  FDCB.StopBits  := 0; // - 1 bit
  FDCB.XonChar   := #17;
  FDCB.XoffChar  := #19;
  FDCB.ErrorChar := #0;
  FDCB.EofChar   := #0;
  FDCB.EvtChar   := #0;

  memLog.Lines.Add('Устанавливаемая DCB :');
  DcbToLog(FDCB);

  if not SetCommState(FPortHandle,FDCB)then
   begin
    memLog.Lines.Add(Format('SetCommState DCB - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  if not GetCommState(FPortHandle,TempDCB)then
   begin
    memLog.Lines.Add(Format('GetCommState - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add('Установленная DCB :');
  DcbToLog(TempDCB);

  if not GetCommTimeouts(FPortHandle,FPortTimeouts)then
   begin
    memLog.Lines.Add(Format('GetCommTimeouts - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add('Исходные таймауты :');
  TimeoutsToLog(FPortTimeouts);

  FPortTimeouts.ReadIntervalTimeout        := 50;
  FPortTimeouts.ReadTotalTimeoutConstant   := 0;
  FPortTimeouts.ReadTotalTimeoutMultiplier := 0;
  FPortTimeouts.WriteTotalTimeoutConstant  := 0;
  FPortTimeouts.WriteTotalTimeoutMultiplier:= 0;

  if not SetCommTimeouts(FPortHandle,FPortTimeouts)then
   begin
    memLog.Lines.Add(Format('SetCommTimeouts - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  if not GetCommTimeouts(FPortHandle,TempTimeouts)then
   begin
    memLog.Lines.Add(Format('GetCommTimeouts - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add('Установленные таймауты :');
  TimeoutsToLog(FPortTimeouts);

  if not SetupComm(FPortHandle,8048,8048)then
   begin
    memLog.Lines.Add(Format('SetupComm - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  if not GetCommMask(FPortHandle, FEventMask)then
   begin
    memLog.Lines.Add(Format('SetupComm - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add(Format('Исходная маска = %d',[FEventMask]));

  FEventMask := FEventMask or EV_RXCHAR or EV_TXEMPTY or EV_BREAK or EV_ERR;

  if not SetCommMask(FPortHandle,FEventMask)then
   begin
    memLog.Lines.Add(Format('SetupComm - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  if not GetCommMask(FPortHandle, FEventMask)then
   begin
    memLog.Lines.Add(Format('SetupComm - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  memLog.Lines.Add(Format('Установленная маска = %d',[FEventMask]));


  btnOpenPort.Enabled    := False;
  btnClosePort.Enabled   := True;
  btnSendRequest.Enabled := True;

  memLog.Lines.Add('Порт открыт');
  memLog.Lines.Add('');
end;

procedure TForm1.btnSendRequestClick(Sender: TObject);
var TempBuffOut     : TByteArray;
    TempBuffIn      : TByteArray;
    TempOverRes     : TOVERLAPPED;
    TempEventHandle : THANDLE;
    TempRes         : Boolean;
    TempBytes       : DWORD;
    LastErr         : Cardinal;
    TempMask        : Cardinal;
    TempCOMStat     : TCOMSTAT;
    TempIncBytes    : Cardinal;
    Ticks           : Cardinal;
begin
  // Запрос: 01 03 00 00 00 7D 85 EB - чтение по 3-й функции 125-и Holding регистров
  FillChar(TempBuffOut,sizeof(TByteArray),0);
  FillChar(TempBuffIn,sizeof(TByteArray),0);

  Ticks := GetTickCount;

  TempBuffOut[0] := $01;
  TempBuffOut[1] := $03;
  TempBuffOut[2] := $00;
  TempBuffOut[3] := $00;
  TempBuffOut[4] := $00;
  TempBuffOut[5] := $7D;
  TempBuffOut[6] := $85;
  TempBuffOut[7] := $EB;

// Запись запроса в порт
  FillChar(TempOverRes,sizeof(TOVERLAPPED),0);
  TempEventHandle := CreateEvent(nil,True,False,nil);
  TempOverRes.hEvent := TempEventHandle;
  try
   TempRes := WriteFile(FPortHandle,TempBuffOut,8,TempBytes,@TempOverRes);
   if not TempRes then
    begin
     LastErr := GetLastError;
     if LastErr <> ERROR_IO_PENDING then
      begin
       memLog.Lines.Add(Format('Write error - %d - %s',[LastErr,SysErrorMessage(LastErr)]));
       Exit;
      end;
     LastErr := WaitForSingleObject(TempEventHandle,1000);
     case LastErr of
      WAIT_OBJECT_0 : begin
                       if not GetOverlappedResult(TempEventHandle,TempOverRes,TempBytes,True) then
                        begin
                         LastErr := GetLastError;
                         memLog.Lines.Add(Format('Write. Waite error - %d - %s',[LastErr,SysErrorMessage(LastErr)]));
                         Exit;
                        end;
                       memLog.Lines.Add(Format('Write ok. Writed %d bytes',[TempBytes]));
                      end;
      WAIT_TIMEOUT : begin
                      memLog.Lines.Add('Write. Waite timeout');
                      Exit;
                     end;
      WAIT_FAILED : begin
                     LastErr := GetLastError;
                     memLog.Lines.Add(Format('Write. Waite error - %d - %s',[LastErr,SysErrorMessage(LastErr)]));
                     Exit;
                    end;
     else
       memLog.Lines.Add(Format('Write. Waite other - %d',[LastErr]));
       Exit;
     end;
    end;

  finally
    CloseHandle(TempEventHandle);
    TempEventHandle := 0;
  end;
// окончание записи запроса

// ожидание ответа
  if not GetCommMask(FPortHandle,TempMask)then
   begin
    memLog.Lines.Add(Format('GetCommMask - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  TempMask := TempMask or EV_RXCHAR;

  if not SetCommMask(FPortHandle,TempMask)then
   begin
    memLog.Lines.Add(Format('SetCommMask - %s',[SysErrorMessage(GetLastError)]));
    btnClosePortClick(Self);
    Exit;
   end;

  FillChar(TempOverRes,sizeof(TOVERLAPPED),0);
  TempEventHandle := CreateEvent(nil,True,False,nil);
  TempOverRes.hEvent := TempEventHandle;
  try
    TempMask := 0;
    TempRes := WaitCommEvent(FPortHandle,TempMask,@TempOverRes);
    if not TempRes then
     begin
      LastErr := GetLastError;
      if LastErr <> ERROR_IO_PENDING then
       begin
         memLog.Lines.Add(Format('WaitCommEvent - %s',[SysErrorMessage(LastErr)]));
         btnClosePortClick(Self);
         Exit;
       end;
      while WaitForSingleObject(TempEventHandle,1000) = WAIT_TIMEOUT do Sleep(10);
      if (TempMask and EV_RXCHAR) = EV_RXCHAR then
       begin
         memLog.Lines.Add('WaitCommEvent, Пришли данные ');
       end
      else
       begin
        memLog.Lines.Add('WaitCommEvent, Не дождались данных ');
        Exit;
       end;
     end;
  finally
    CloseHandle(TempEventHandle);
    TempEventHandle := 0;
  end;
// окончание ожидания ответа

// ожидание прихода все данных
  LastErr := 0 ;
  TempIncBytes := 1;
  FillChar(TempCOMStat,sizeof(TCOMSTAT),0);
  while (TempIncBytes<>TempCOMStat.cbInQue)do
   begin
    Sleep(5);
    TempIncBytes := TempCOMStat.cbInQue;
    TempRes := ClearCommError(FPortHandle,LastErr,@TempCOMStat);
    if not TempRes then Break;
   end;
  memLog.Lines.Add('');
// количество пришедших

// чтение ответа
  FillChar(TempOverRes,sizeof(TOVERLAPPED),0);
  TempEventHandle := CreateEvent(nil,True,False,nil);
  TempOverRes.hEvent := TempEventHandle;
  try
    TempRes := ReadFile(FPortHandle,TempBuffOut,2048,TempIncBytes,@TempOverRes);
    if not TempRes then
     begin
      LastErr := GetLastError;
      if LastErr <> ERROR_IO_PENDING then
       begin
        memLog.Lines.Add(Format('Read. ReadFile error - %d - %s',[LastErr,SysErrorMessage(LastErr)]));
        Exit;
       end;
      while WaitForSingleObject(TempOverRes.hEvent,1000)=WAIT_TIMEOUT do Sleep(5);
      if not GetOverlappedResult(TempEventHandle,TempOverRes,TempIncBytes,True) then
       begin
        LastErr := GetLastError;
        memLog.Lines.Add(Format('Read. GetOverlappedResult error - %d - %s',[LastErr,SysErrorMessage(LastErr)]));
        Exit;
       end;
      memLog.Lines.Add(Format('Read. Пришло %d байт',[TempIncBytes]));
     end;
  finally
    CloseHandle(TempEventHandle);
  end;

  PurgeComm(FPortHandle,PURGE_RXCLEAR);
  memLog.Lines.Add(Format('Read. Прошло %d мс',[GetTickCount - Ticks]));
  memLog.Lines.Add('');
// окончание чтения ответа
end;

procedure TForm1.btnClosePortClick(Sender: TObject);
begin
  CloseHandle(FPortHandle);
  FPortHandle := INVALID_HANDLE_VALUE;
  memLog.Lines.Add('Порт закрыт');

  btnOpenPort.Enabled    := True;
  btnClosePort.Enabled   := False;
  btnSendRequest.Enabled := False;
end;

procedure TForm1.btnGetDCBClick(Sender: TObject);
var TempHandl : THANDLE;
    TempDCB   : TDCB;
begin
  TempHandl := CreateFile('\\.\COM11',
                            GENERIC_READ,
                            0,
                            nil,
                            OPEN_EXISTING,
                            FILE_FLAG_OVERLAPPED,
                            0);
  if (TempHandl = INVALID_HANDLE_VALUE) then
   begin
     memLog.Lines.add(Format('Get DCB: Open port COM11 - %s',[SysErrorMessage(GetLastError)]));
     Exit;
   end;

  if not GetCommState(TempHandl,TempDCB)then
   begin
    memLog.Lines.Add(Format('Get DCB: GetCommState - %s',[SysErrorMessage(GetLastError)]));
    CloseHandle(TempHandl);
    Exit;
   end;

  memLog.Lines.Add('Get DCB: DCB в устройстве:');
  DcbToLog(TempDCB);

  CloseHandle(TempHandl);
end;

procedure TForm1.DcbToLog(ADCB: TDCB);
begin
  memLog.Lines.Add(Format('FDCB.DCBlength = %d',[ADCB.DCBlength]));
  memLog.Lines.Add(Format('FDCB.BaudRate  = %d',[ADCB.BaudRate]));
  memLog.Lines.Add(Format('FDCB.Flags     = %d',[ADCB.Flags]));
  memLog.Lines.Add(Format('FDCB.XonLim    = %d',[FDCB.XonLim]));
  memLog.Lines.Add(Format('FDCB.XoffLim   = %d',[FDCB.XoffLim]));
  memLog.Lines.Add(Format('FDCB.ByteSize  = %d',[FDCB.ByteSize]));
  memLog.Lines.Add(Format('FDCB.Parity    = %d',[FDCB.Parity]));
  memLog.Lines.Add(Format('FDCB.StopBits  = %d',[FDCB.StopBits]));
  memLog.Lines.Add(Format('FDCB.XonChar   = %d',[ord(FDCB.XonChar)]));
  memLog.Lines.Add(Format('FDCB.XoffChar  = %d',[ord(FDCB.XoffChar)]));
  memLog.Lines.Add(Format('FDCB.ErrorChar = %d',[ord(FDCB.ErrorChar)]));
  memLog.Lines.Add(Format('FDCB.EofChar   = %d',[ord(FDCB.EofChar)]));
  memLog.Lines.Add(Format('FDCB.EvtChar   = %d',[ord(FDCB.EvtChar)]));
  memLog.Lines.Add('');
end;

procedure TForm1.TimeoutsToLog(ATimeouts: TCommTimeouts);
begin
  memLog.Lines.Add(Format('ATimeouts.ReadIntervalTimeout = %d',[ATimeouts.ReadIntervalTimeout]));
  memLog.Lines.Add(Format('ATimeouts.ReadTotalTimeoutMultiplier = %d',[ATimeouts.ReadTotalTimeoutMultiplier]));
  memLog.Lines.Add(Format('ATimeouts.ReadTotalTimeoutConstant = %d',[ATimeouts.ReadTotalTimeoutConstant]));
  memLog.Lines.Add(Format('ATimeouts.WriteTotalTimeoutConstant = %d',[ATimeouts.WriteTotalTimeoutConstant]));
  memLog.Lines.Add(Format('ATimeouts.WriteTotalTimeoutMultiplier = %d',[ATimeouts.WriteTotalTimeoutMultiplier]));
  memLog.Lines.Add('');
end;

end.

