object Form1: TForm1
  Left = 1975
  Height = 558
  Top = 52
  Width = 788
  Caption = 'Form1'
  ClientHeight = 0
  ClientWidth = 0
  LCLVersion = '5.9'
  object btnOpenPort: TButton
    Left = 24
    Height = 25
    Top = 24
    Width = 171
    Caption = 'Открыть'
    OnClick = btnOpenPortClick
    TabOrder = 0
  end
  object btnClosePort: TButton
    Left = 216
    Height = 25
    Top = 24
    Width = 171
    Caption = 'Закрыть'
    Enabled = False
    OnClick = btnClosePortClick
    TabOrder = 1
  end
  object memLog: TMemo
    Left = 24
    Height = 362
    Top = 176
    Width = 744
    ScrollBars = ssAutoBoth
    TabOrder = 2
  end
  object btnSendRequest: TButton
    Left = 24
    Height = 25
    Top = 64
    Width = 168
    Caption = 'Послать запрос'
    Enabled = False
    OnClick = btnSendRequestClick
    TabOrder = 3
  end
  object btnGetDCB: TButton
    Left = 512
    Height = 25
    Top = 24
    Width = 216
    Caption = 'Получить ДСБ Порта'
    OnClick = btnGetDCBClick
    TabOrder = 4
  end
end
