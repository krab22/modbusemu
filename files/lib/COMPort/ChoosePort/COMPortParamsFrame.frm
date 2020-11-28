object TframParamsPort: TTframParamsPort
  Left = 0
  Height = 263
  Top = 0
  Width = 400
  ClientHeight = 263
  ClientWidth = 400
  TabOrder = 0
  DesignLeft = 3418
  DesignTop = 594
  object gbPort: TGroupBox
    Left = 4
    Height = 257
    Top = 0
    Width = 392
    Caption = 'Параметры порта'
    ClientHeight = 236
    ClientWidth = 390
    TabOrder = 0
    object lbPort: TLabel
      Left = 8
      Height = 20
      Top = 10
      Width = 41
      Caption = 'Порт: '
      ParentColor = False
    end
    object lbPortName: TLabel
      Left = 56
      Height = 1
      Top = 10
      Width = 1
      ParentColor = False
    end
    object gbPortParams: TGroupBox
      Left = 8
      Height = 154
      Top = 40
      Width = 377
      Caption = 'Параметры'
      ClientHeight = 133
      ClientWidth = 375
      TabOrder = 0
      object lbPortBaudRate: TLabel
        Left = 6
        Height = 20
        Top = 0
        Width = 114
        Caption = 'Скорость обмера'
        ParentColor = False
      end
      object cbPortBaudRate: TComboBox
        Left = 6
        Height = 36
        Top = 22
        Width = 162
        ItemHeight = 0
        OnChange = cbPortBaudRateChange
        Style = csDropDownList
        TabOrder = 0
      end
      object lbPortDataBits: TLabel
        Left = 200
        Height = 20
        Top = 0
        Width = 75
        Caption = 'Бит данных'
        ParentColor = False
      end
      object cbPortDataBits: TComboBox
        Left = 200
        Height = 36
        Top = 22
        Width = 162
        ItemHeight = 0
        OnChange = cbPortDataBitsChange
        Style = csDropDownList
        TabOrder = 1
      end
      object lbPortStopBits: TLabel
        Left = 6
        Height = 20
        Top = 66
        Width = 90
        Caption = 'Стоповых бит'
        ParentColor = False
      end
      object cbPortStopBits: TComboBox
        Left = 6
        Height = 36
        Top = 88
        Width = 162
        ItemHeight = 0
        OnChange = cbPortStopBitsChange
        Style = csDropDownList
        TabOrder = 2
      end
      object lbPortParity: TLabel
        Left = 200
        Height = 20
        Top = 66
        Width = 55
        Caption = 'Паритет'
        ParentColor = False
      end
      object cbPortParity: TComboBox
        Left = 200
        Height = 36
        Top = 88
        Width = 162
        ItemHeight = 0
        OnChange = cbPortParityChange
        Style = csDropDownList
        TabOrder = 3
      end
    end
    object btnCancel: TButton
      Left = 206
      Height = 25
      Top = 201
      Width = 87
      Caption = 'Отменить'
      OnClick = btnCancelClick
      TabOrder = 1
    end
    object btnAply: TButton
      Left = 298
      Height = 25
      Top = 201
      Width = 87
      Caption = 'Применить'
      Enabled = False
      OnClick = btnAplyClick
      TabOrder = 2
    end
  end
end
