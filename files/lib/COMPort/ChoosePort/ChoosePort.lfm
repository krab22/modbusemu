object fmChoosePort: TfmChoosePort
  Left = 617
  Height = 360
  Top = 267
  Width = 567
  BorderStyle = bsDialog
  Caption = 'Параметры соединения с ДКУ'
  ClientHeight = 360
  ClientWidth = 567
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  KeyPreview = True
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  Position = poMainFormCenter
  LCLVersion = '5.9'
  object btnOk: TButton
    Left = 399
    Height = 25
    Top = 331
    Width = 75
    Anchors = [akRight, akBottom]
    Caption = 'Применить'
    Default = True
    Enabled = False
    OnClick = btnOkClick
    TabOrder = 0
  end
  object Button2: TButton
    Left = 485
    Height = 25
    Top = 331
    Width = 75
    Anchors = [akRight, akBottom]
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 3
    Height = 308
    Top = 4
    Width = 340
    Caption = ' СОМ-порт '
    ClientHeight = 294
    ClientWidth = 338
    TabOrder = 2
    object Label3: TLabel
      Left = 210
      Height = 13
      Top = 52
      Width = 58
      Caption = 'Скорость:'
      ParentColor = False
    end
    object Label4: TLabel
      Left = 210
      Height = 13
      Top = 94
      Width = 116
      Caption = 'Кол-во бит данных:'
      ParentColor = False
    end
    object Label5: TLabel
      Left = 210
      Height = 13
      Top = 136
      Width = 126
      Caption = 'Кол-во стоповых бит:'
      ParentColor = False
    end
    object Label6: TLabel
      Left = 210
      Height = 13
      Top = 179
      Width = 52
      Caption = 'Паритет:'
      ParentColor = False
    end
    object Label2: TLabel
      Left = 210
      Height = 13
      Top = 223
      Width = 91
      Caption = 'Разрыв пакета:'
      ParentColor = False
    end
    object lbPorts: TCheckListBox
      Left = 5
      Height = 258
      Top = 5
      Width = 197
      ItemHeight = 0
      OnClickCheck = lbPortsClickCheck
      TabOrder = 0
      TopIndex = -1
    end
    object btnUpdate: TBitBtn
      Left = 210
      Height = 24
      Hint = 'Проверить доступность портов'
      Top = 6
      Width = 33
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000
      }
      Layout = blGlyphTop
      NumGlyphs = 2
      OnClick = btnUpdateClick
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbBaud: TComboBox
      Left = 210
      Height = 36
      Top = 68
      Width = 120
      ItemHeight = 0
      Items.Strings = (
        '75'
        '110'
        '150'
        '300'
        '600'
        '1200'
        '1800'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '28800'
        '38400'
        '57600'
        '115200'
      )
      OnChange = DataChange
      Style = csDropDownList
      TabOrder = 2
    end
    object cbDataBits: TComboBox
      Left = 210
      Height = 36
      Top = 110
      Width = 120
      ItemHeight = 0
      Items.Strings = (
        '5'
        '6'
        '7'
        '8'
      )
      OnChange = DataChange
      Style = csDropDownList
      TabOrder = 3
    end
    object cbStopBits: TComboBox
      Left = 210
      Height = 36
      Top = 152
      Width = 120
      ItemHeight = 0
      Items.Strings = (
        '1'
        '1.5'
        '2'
      )
      OnChange = DataChange
      Style = csDropDownList
      TabOrder = 4
    end
    object cbParity: TComboBox
      Left = 210
      Height = 36
      Top = 196
      Width = 120
      ItemHeight = 0
      Items.Strings = (
        'NONE'
        'ODD'
        'EVEN'
        'MARK'
        'SPACE'
      )
      OnChange = DataChange
      Style = csDropDownList
      TabOrder = 5
    end
    object seRespondTimeOut: TSpinEdit
      Tag = 60
      Left = 210
      Height = 30
      Top = 241
      Width = 120
      MinValue = 10
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 6
      Value = 30
    end
  end
  object GroupBox2: TGroupBox
    Left = 346
    Height = 308
    Top = 4
    Width = 217
    Caption = ' Соединение с устройствами '
    ClientHeight = 294
    ClientWidth = 215
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Height = 13
      Top = 59
      Width = 60
      Caption = 'Основной:'
      ParentColor = False
    end
    object Label7: TLabel
      Left = 12
      Height = 13
      Top = 104
      Width = 88
      Caption = 'Дублирующий:'
      ParentColor = False
    end
    object Bevel2: TBevel
      Left = 7
      Height = 15
      Top = 163
      Width = 198
      Shape = bsTopLine
    end
    object Label8: TLabel
      Left = 12
      Height = 13
      Top = 185
      Width = 60
      Caption = 'Основной:'
      ParentColor = False
    end
    object Label9: TLabel
      Left = 12
      Height = 13
      Top = 227
      Width = 88
      Caption = 'Дублирующий:'
      ParentColor = False
    end
    object Label10: TLabel
      Left = 12
      Height = 13
      Top = 166
      Width = 143
      Caption = 'Универсальный адрес'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label11: TLabel
      Left = 12
      Height = 13
      Top = 42
      Width = 155
      Caption = 'Индивидуальный адрес'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 7
      Height = 15
      Top = 39
      Width = 198
      Shape = bsTopLine
    end
    object Label12: TLabel
      Left = 8
      Height = 13
      Top = 16
      Width = 135
      Caption = 'Количество регистров:'
      ParentColor = False
    end
    object seDeviceNumM: TSpinEdit
      Tag = 1
      Left = 12
      Height = 30
      Top = 75
      Width = 120
      MaxValue = 119
      MinValue = 1
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 1
      Value = 1
    end
    object seDeviceNumD: TSpinEdit
      Tag = 129
      Left = 12
      Height = 30
      Top = 135
      Width = 120
      MaxValue = 247
      MinValue = 129
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 3
      Value = 129
    end
    object cbAutoCreateDevNum: TCheckBox
      Left = 12
      Height = 24
      Top = 118
      Width = 219
      Caption = 'Формировать автоматически'
      OnClick = cbAutoCreateDevNumClick
      TabOrder = 2
    end
    object seDeviceMasterNumM: TSpinEdit
      Tag = 1
      Left = 12
      Height = 30
      Top = 201
      Width = 120
      MaxValue = 247
      MinValue = 1
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 4
      Value = 1
    end
    object seDeviceMasterNumD: TSpinEdit
      Tag = 129
      Left = 12
      Height = 30
      Top = 242
      Width = 120
      MaxValue = 247
      MinValue = 1
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 5
      Value = 129
    end
    object seRegsCount: TSpinEdit
      Tag = 28
      Left = 130
      Height = 30
      Top = 12
      Width = 74
      MaxValue = 255
      MinValue = 10
      OnChange = SpinEditChange
      OnExit = SpinEditExit
      TabOrder = 0
      Value = 28
    end
  end
end
