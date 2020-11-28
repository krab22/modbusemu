object frmMain: TfrmMain
  Left = 2046
  Height = 207
  Top = 153
  Width = 886
  Caption = 'frmMain'
  ClientHeight = 207
  ClientWidth = 886
  LCLVersion = '5.7'
  object lbLogPath: TLabel
    Left = 8
    Height = 20
    Top = 8
    Width = 137
    Caption = 'Путь к файлам лога:'
    ParentColor = False
  end
  object edLogFilePath: TEdit
    Left = 152
    Height = 37
    Top = 8
    Width = 720
    TabOrder = 0
  end
  object lbMessage: TLabel
    Left = 8
    Height = 20
    Top = 56
    Width = 82
    Caption = 'Сообщение:'
    ParentColor = False
  end
  object edMessage: TEdit
    Left = 152
    Height = 37
    Top = 64
    Width = 720
    TabOrder = 1
    Text = 'Тестовое сообщение'
  end
  object btSendMsg: TButton
    Left = 144
    Height = 25
    Top = 160
    Width = 160
    Caption = 'Послать в лог'
    OnClick = btSendMsgClick
    TabOrder = 2
  end
  object btTestThread: TButton
    Left = 376
    Height = 25
    Top = 160
    Width = 240
    Caption = 'Тетсовый поток'
    OnClick = btTestThreadClick
    TabOrder = 3
  end
  object lbThreadState: TLabel
    Left = 8
    Height = 20
    Top = 112
    Width = 121
    Caption = 'Поток не запущен'
    ParentColor = False
  end
end
