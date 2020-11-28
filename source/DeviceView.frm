object frmDeviceView: TfrmDeviceView
  Left = 2114
  Height = 754
  Top = 175
  Width = 681
  Caption = 'Просмотр устройства'
  ClientHeight = 754
  ClientWidth = 681
  Constraints.MinHeight = 754
  Constraints.MinWidth = 681
  OnClose = FormClose
  Position = poMainFormCenter
  LCLVersion = '1.5'
  object lbDevNum: TLabel
    Left = 8
    Height = 20
    Top = 8
    Width = 122
    Caption = 'Адрес устройства:'
    ParentColor = False
  end
  object lbDeviceNumber: TLabel
    Left = 136
    Height = 20
    Top = 8
    Width = 107
    Caption = 'lbDeviceNumber'
    Font.Color = clRed
    ParentColor = False
    ParentFont = False
  end
  object pcDeviceRegisters: TPageControl
    Left = 8
    Height = 705
    Top = 40
    Width = 664
    ActivePage = tsCoils
    Anchors = [akTop, akLeft, akRight, akBottom]
    TabIndex = 0
    TabOrder = 0
    object tsCoils: TTabSheet
      Caption = 'Coils'
      ClientHeight = 671
      ClientWidth = 654
      object sgCoils: TStringGrid
        Left = 1
        Height = 532
        Top = 136
        Width = 653
        Anchors = [akTop, akLeft, akRight, akBottom]
        ColCount = 3
        DefaultRowHeight = 25
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goSmoothScroll]
        RowCount = 1
        TabOrder = 0
        TitleStyle = tsNative
        OnSelectCell = sgCoilsSelectCell
        ColWidths = (
          61
          119
          471
        )
        Cells = (
          3
          0
          0
          'Адрес'
          1
          0
          'Значение'
          2
          0
          'Коментарий'
        )
      end
      object gbCoilEditReg: TGroupBox
        Left = 5
        Height = 124
        Top = 3
        Width = 570
        Caption = 'Изменение регистра'
        ClientHeight = 103
        ClientWidth = 568
        TabOrder = 1
        object speCoilRegNum: TSpinEdit
          Left = 128
          Height = 32
          Top = 4
          Width = 90
          MaxValue = 65534
          OnChange = speCoilRegNumChange
          TabOrder = 0
        end
        object lbCoilRegNum: TLabel
          Left = 8
          Height = 20
          Top = 4
          Width = 112
          Caption = 'Номер регистра:'
          ParentColor = False
        end
        object gbCoilValue: TGroupBox
          Left = 225
          Height = 64
          Top = -7
          Width = 160
          Caption = 'Значение'
          ClientHeight = 43
          ClientWidth = 158
          TabOrder = 1
          object rbCoilTrue: TRadioButton
            Left = 8
            Height = 24
            Top = 8
            Width = 55
            Caption = 'True'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object rbCoilFalse: TRadioButton
            Left = 80
            Height = 24
            Top = 8
            Width = 60
            Caption = 'False'
            TabOrder = 1
          end
        end
        object btCoilAply: TButton
          Left = 400
          Height = 25
          Top = 4
          Width = 160
          Caption = 'Применить'
          OnClick = btCoilAplyClick
          TabOrder = 3
        end
        object btCoilAplyAll: TButton
          Left = 400
          Height = 25
          Top = 36
          Width = 160
          Caption = 'Применить ко всем'
          OnClick = btCoilAplyAllClick
          TabOrder = 4
        end
        object btCoilAplyFor: TButton
          Left = 400
          Height = 25
          Top = 69
          Width = 160
          Caption = 'Применить к ...'
          OnClick = btCoilAplyForClick
          TabOrder = 5
        end
        object lbCoilComment: TLabel
          Left = 8
          Height = 20
          Top = 61
          Width = 85
          Caption = 'Коментарий:'
          ParentColor = False
        end
        object edCoilRegDescription: TEdit
          Left = 96
          Height = 32
          Top = 63
          Width = 289
          OnEditingDone = edCoilRegDescriptionEditingDone
          TabOrder = 2
        end
      end
    end
    object tsDiscrets: TTabSheet
      Caption = 'Discrets'
      ClientHeight = 671
      ClientWidth = 654
      object sgDiscrets: TStringGrid
        Left = 1
        Height = 532
        Top = 136
        Width = 653
        Anchors = [akTop, akLeft, akRight, akBottom]
        ColCount = 3
        Columns = <        
          item
            Title.Caption = 'Значение'
            Width = 125
          end        
          item
            Title.Caption = 'Коментарий'
            Width = 464
          end>
        DefaultRowHeight = 25
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goSmoothScroll]
        RangeSelectMode = rsmMulti
        RowCount = 1
        TabOrder = 0
        TitleStyle = tsNative
        OnSelectCell = sgDiscretsSelectCell
        ColWidths = (
          61
          125
          464
        )
        Cells = (
          2
          0
          0
          'Адрес'
          1
          0
          'Значение'
        )
      end
      object gbDiscretsEditReg: TGroupBox
        Left = 5
        Height = 124
        Top = 3
        Width = 570
        Caption = 'Изменение регистра'
        ClientHeight = 103
        ClientWidth = 568
        TabOrder = 1
        object speDiscretsRegNum: TSpinEdit
          Left = 128
          Height = 32
          Top = 4
          Width = 90
          MaxValue = 65534
          OnChange = speDiscretsRegNumChange
          TabOrder = 0
        end
        object lbDiscretsRegNum: TLabel
          Left = 8
          Height = 20
          Top = 4
          Width = 112
          Caption = 'Номер регистра:'
          ParentColor = False
        end
        object gbDiscretsValue: TGroupBox
          Left = 225
          Height = 64
          Top = -7
          Width = 160
          Caption = 'Значение'
          ClientHeight = 43
          ClientWidth = 158
          TabOrder = 1
          object rbDiscretsTrue: TRadioButton
            Left = 8
            Height = 24
            Top = 8
            Width = 55
            Caption = 'True'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object rbDiscretsFalse: TRadioButton
            Left = 80
            Height = 24
            Top = 8
            Width = 60
            Caption = 'False'
            TabOrder = 1
          end
        end
        object btDiscretsAply: TButton
          Left = 400
          Height = 25
          Top = 4
          Width = 160
          Caption = 'Применить'
          OnClick = btDiscretsAplyClick
          TabOrder = 3
        end
        object btDiscretsAplyAll: TButton
          Left = 400
          Height = 25
          Top = 36
          Width = 160
          Caption = 'Применить ко всем'
          OnClick = btDiscretsAplyAllClick
          TabOrder = 4
        end
        object btDiscretsAplyFor: TButton
          Left = 400
          Height = 25
          Top = 69
          Width = 160
          Caption = 'Применить к ...'
          OnClick = btDiscretsAplyForClick
          TabOrder = 5
        end
        object lbDiscretsComment: TLabel
          Left = 8
          Height = 20
          Top = 61
          Width = 85
          Caption = 'Коментарий:'
          ParentColor = False
        end
        object edDiscretsRegDescription: TEdit
          Left = 96
          Height = 32
          Top = 63
          Width = 289
          OnEditingDone = edDiscretsRegDescriptionEditingDone
          TabOrder = 2
        end
      end
    end
    object tsHoldings: TTabSheet
      Caption = 'Holdings'
      ClientHeight = 671
      ClientWidth = 654
      object sgHoldings: TStringGrid
        Left = 1
        Height = 456
        Top = 211
        Width = 653
        Anchors = [akTop, akLeft, akRight, akBottom]
        ColCount = 4
        DefaultRowHeight = 25
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goSmoothScroll]
        RangeSelectMode = rsmMulti
        RowCount = 1
        TabOrder = 0
        TitleStyle = tsNative
        OnSelectCell = sgHoldingsSelectCell
        ColWidths = (
          61
          119
          104
          366
        )
        Cells = (
          4
          0
          0
          'Адрес'
          1
          0
          'Значение'
          2
          0
          'Hex'
          3
          0
          'Коментарий'
        )
      end
      object gbHoldingsEditReg: TGroupBox
        Left = 5
        Height = 205
        Top = 3
        Width = 644
        Caption = 'Изменение регистра'
        ClientHeight = 184
        ClientWidth = 642
        TabOrder = 1
        object speHoldingsRegNum: TSpinEdit
          Left = 128
          Height = 32
          Top = 4
          Width = 90
          MaxValue = 65534
          OnChange = speHoldingsRegNumChange
          TabOrder = 0
        end
        object lbHoldingsRegNum: TLabel
          Left = 8
          Height = 20
          Top = 4
          Width = 112
          Caption = 'Номер регистра:'
          ParentColor = False
        end
        object btHoldingsAply: TButton
          Left = 490
          Height = 25
          Top = 4
          Width = 147
          Caption = 'Применить'
          OnClick = btHoldingsAplyClick
          TabOrder = 2
        end
        object btHoldingsAplyAll: TButton
          Left = 490
          Height = 25
          Top = 36
          Width = 147
          Caption = 'Применить ко всем'
          OnClick = btHoldingsAplyAllClick
          TabOrder = 3
        end
        object btHoldingsAplyFor: TButton
          Left = 490
          Height = 25
          Top = 69
          Width = 147
          Caption = 'Применить к ...'
          OnClick = btHoldingsAplyForClick
          TabOrder = 4
        end
        object lbHoldingsComment: TLabel
          Left = 8
          Height = 20
          Top = 144
          Width = 85
          Caption = 'Коментарий:'
          ParentColor = False
        end
        object edHoldingsRegDescription: TEdit
          Left = 96
          Height = 32
          Top = 146
          Width = 392
          OnEditingDone = edHoldingsRegDescriptionEditingDone
          TabOrder = 1
        end
        object gbHoldingsValue: TGroupBox
          Left = 8
          Height = 105
          Top = 35
          Width = 480
          Caption = 'Значение'
          ClientHeight = 84
          ClientWidth = 478
          TabOrder = 5
          object speHoldingsValue: TSpinEdit
            Left = 8
            Height = 32
            Hint = 'Для подтверждения ввода нажмите Enter'
            Top = 8
            Width = 96
            MaxValue = 65535
            OnEditingDone = speHoldingsValueEditingDone
            OnKeyUp = speHoldingsValueKeyUp
            OnMouseUp = speHoldingsValueMouseUp
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object gbHoldingsBits: TGroupBox
            Left = 107
            Height = 90
            Top = -8
            Width = 369
            Caption = 'Биты'
            ClientHeight = 69
            ClientWidth = 367
            TabOrder = 1
            object cbHoldingsBit0: TCheckBox
              Left = 3
              Height = 24
              Top = 0
              Width = 35
              Caption = '0'
              OnChange = cbHoldingsBit0Change
              TabOrder = 0
            end
            object cbHoldingsBit1: TCheckBox
              Left = 42
              Height = 24
              Top = 0
              Width = 35
              Caption = '1'
              OnChange = cbHoldingsBit1Change
              TabOrder = 1
            end
            object cbHoldingsBit2: TCheckBox
              Left = 83
              Height = 24
              Top = 0
              Width = 35
              Caption = '2'
              OnChange = cbHoldingsBit2Change
              TabOrder = 2
            end
            object cbHoldingsBit3: TCheckBox
              Left = 130
              Height = 24
              Top = 0
              Width = 35
              Caption = '3'
              OnChange = cbHoldingsBit3Change
              TabOrder = 3
            end
            object cbHoldingsBit4: TCheckBox
              Left = 179
              Height = 24
              Top = 0
              Width = 35
              Caption = '4'
              OnChange = cbHoldingsBit4Change
              TabOrder = 4
            end
            object cbHoldingsBit5: TCheckBox
              Left = 226
              Height = 24
              Top = 0
              Width = 35
              Caption = '5'
              OnChange = cbHoldingsBit5Change
              TabOrder = 5
            end
            object cbHoldingsBit6: TCheckBox
              Left = 273
              Height = 24
              Top = 0
              Width = 35
              Caption = '6'
              OnChange = cbHoldingsBit6Change
              TabOrder = 6
            end
            object cbHoldingsBit7: TCheckBox
              Left = 322
              Height = 24
              Top = 0
              Width = 35
              Caption = '7'
              OnChange = cbHoldingsBit7Change
              TabOrder = 7
            end
            object cbHoldingsBit8: TCheckBox
              Left = 3
              Height = 24
              Top = 36
              Width = 35
              Caption = '8'
              OnChange = cbHoldingsBit8Change
              TabOrder = 8
            end
            object cbHoldingsBit9: TCheckBox
              Left = 42
              Height = 24
              Top = 36
              Width = 35
              Caption = '9'
              OnChange = cbHoldingsBit9Change
              TabOrder = 9
            end
            object cbHoldingsBit10: TCheckBox
              Left = 83
              Height = 24
              Top = 36
              Width = 44
              Caption = '10'
              OnChange = cbHoldingsBit10Change
              TabOrder = 10
            end
            object cbHoldingsBit11: TCheckBox
              Left = 130
              Height = 24
              Top = 36
              Width = 44
              Caption = '11'
              OnChange = cbHoldingsBit11Change
              TabOrder = 11
            end
            object cbHoldingsBit12: TCheckBox
              Left = 179
              Height = 24
              Top = 36
              Width = 44
              Caption = '12'
              OnChange = cbHoldingsBit12Change
              TabOrder = 12
            end
            object cbHoldingsBit13: TCheckBox
              Left = 226
              Height = 24
              Top = 36
              Width = 44
              Caption = '13'
              OnChange = cbHoldingsBit13Change
              TabOrder = 13
            end
            object cbHoldingsBit14: TCheckBox
              Left = 273
              Height = 24
              Top = 36
              Width = 44
              Caption = '14'
              OnChange = cbHoldingsBit14Change
              TabOrder = 14
            end
            object cbHoldingsBit15: TCheckBox
              Left = 322
              Height = 24
              Top = 36
              Width = 44
              Caption = '15'
              OnChange = cbHoldingsBit15Change
              TabOrder = 15
            end
          end
          object edHoldingsValHex: TEdit
            Left = 8
            Height = 32
            Hint = 'Для подтверждения ввода нажмите Enter'
            Top = 46
            Width = 96
            MaxLength = 4
            OnEditingDone = edHoldingsValHexEditingDone
            OnKeyPress = edHoldingsValHexKeyPress
            OnKeyUp = edHoldingsValHexKeyUp
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0000'
          end
        end
      end
    end
    object tsInputs: TTabSheet
      Caption = 'Inputs'
      ClientHeight = 671
      ClientWidth = 654
      object sgInputs: TStringGrid
        Left = 1
        Height = 453
        Top = 211
        Width = 653
        Anchors = [akTop, akLeft, akRight, akBottom]
        ColCount = 4
        DefaultRowHeight = 25
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goSmoothScroll]
        RangeSelectMode = rsmMulti
        RowCount = 1
        TabOrder = 0
        TitleStyle = tsNative
        OnSelectCell = sgInputsSelectCell
        ColWidths = (
          61
          119
          104
          366
        )
        Cells = (
          4
          0
          0
          'Адрес'
          1
          0
          'Значение'
          2
          0
          'Hex'
          3
          0
          'Коментарий'
        )
      end
      object gbInputsEditReg: TGroupBox
        Left = 5
        Height = 205
        Top = 3
        Width = 644
        Caption = 'Изменение регистра'
        ClientHeight = 184
        ClientWidth = 642
        TabOrder = 1
        object speInputsRegNum: TSpinEdit
          Left = 128
          Height = 32
          Top = 4
          Width = 90
          MaxValue = 65534
          OnChange = speInputsRegNumChange
          TabOrder = 0
        end
        object lbInputsRegNum: TLabel
          Left = 8
          Height = 20
          Top = 4
          Width = 112
          Caption = 'Номер регистра:'
          ParentColor = False
        end
        object btInputsAply: TButton
          Left = 490
          Height = 25
          Top = 4
          Width = 147
          Caption = 'Применить'
          OnClick = btInputsAplyClick
          TabOrder = 2
        end
        object btInputsAplyAll: TButton
          Left = 490
          Height = 25
          Top = 36
          Width = 147
          Caption = 'Применить ко всем'
          OnClick = btInputsAplyAllClick
          TabOrder = 3
        end
        object btInputsAplyFor: TButton
          Left = 490
          Height = 25
          Top = 69
          Width = 147
          Caption = 'Применить к ...'
          OnClick = btInputsAplyForClick
          TabOrder = 4
        end
        object lbInputsComment: TLabel
          Left = 8
          Height = 20
          Top = 144
          Width = 85
          Caption = 'Коментарий:'
          ParentColor = False
        end
        object edInputsRegDescription: TEdit
          Left = 96
          Height = 32
          Top = 146
          Width = 392
          OnEditingDone = edInputsRegDescriptionEditingDone
          TabOrder = 1
        end
        object gbInputsValue: TGroupBox
          Left = 8
          Height = 105
          Top = 35
          Width = 480
          Caption = 'Значение'
          ClientHeight = 84
          ClientWidth = 478
          TabOrder = 5
          object speInputsValue: TSpinEdit
            Left = 8
            Height = 32
            Hint = 'Для подтверждения ввода нажмите Enter'
            Top = 8
            Width = 96
            MaxValue = 65535
            OnEditingDone = speInputsValueEditingDone
            OnKeyUp = speInputsValueKeyUp
            OnMouseUp = speInputsValueMouseUp
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object gbInputsBits: TGroupBox
            Left = 107
            Height = 90
            Top = -8
            Width = 369
            Caption = 'Биты'
            ClientHeight = 69
            ClientWidth = 367
            TabOrder = 1
            object cbInputsBit0: TCheckBox
              Left = 3
              Height = 24
              Top = 0
              Width = 35
              Caption = '0'
              OnChange = cbInputsBit0Change
              TabOrder = 0
            end
            object cbInputsBit1: TCheckBox
              Left = 42
              Height = 24
              Top = 0
              Width = 35
              Caption = '1'
              OnChange = cbInputsBit1Change
              TabOrder = 1
            end
            object cbInputsBit2: TCheckBox
              Left = 83
              Height = 24
              Top = 0
              Width = 35
              Caption = '2'
              OnChange = cbInputsBit2Change
              TabOrder = 2
            end
            object cbInputsBit3: TCheckBox
              Left = 130
              Height = 24
              Top = 0
              Width = 35
              Caption = '3'
              OnChange = cbInputsBit3Change
              TabOrder = 3
            end
            object cbInputsBit4: TCheckBox
              Left = 179
              Height = 24
              Top = 0
              Width = 35
              Caption = '4'
              OnChange = cbInputsBit4Change
              TabOrder = 4
            end
            object cbInputsBit5: TCheckBox
              Left = 226
              Height = 24
              Top = 0
              Width = 35
              Caption = '5'
              OnChange = cbInputsBit5Change
              TabOrder = 5
            end
            object cbInputsBit6: TCheckBox
              Left = 273
              Height = 24
              Top = 0
              Width = 35
              Caption = '6'
              OnChange = cbInputsBit6Change
              TabOrder = 6
            end
            object cbInputsBit7: TCheckBox
              Left = 322
              Height = 24
              Top = 0
              Width = 35
              Caption = '7'
              OnChange = cbInputsBit7Change
              TabOrder = 7
            end
            object cbInputsBit8: TCheckBox
              Left = 3
              Height = 24
              Top = 36
              Width = 35
              Caption = '8'
              OnChange = cbInputsBit8Change
              TabOrder = 8
            end
            object cbInputsBit9: TCheckBox
              Left = 42
              Height = 24
              Top = 36
              Width = 35
              Caption = '9'
              OnChange = cbInputsBit9Change
              TabOrder = 9
            end
            object cbInputsBit10: TCheckBox
              Left = 83
              Height = 24
              Top = 36
              Width = 44
              Caption = '10'
              OnChange = cbInputsBit10Change
              TabOrder = 10
            end
            object cbInputsBit11: TCheckBox
              Left = 130
              Height = 24
              Top = 36
              Width = 44
              Caption = '11'
              OnChange = cbInputsBit11Change
              TabOrder = 11
            end
            object cbInputsBit12: TCheckBox
              Left = 179
              Height = 24
              Top = 36
              Width = 44
              Caption = '12'
              OnChange = cbInputsBit12Change
              TabOrder = 12
            end
            object cbInputsBit13: TCheckBox
              Left = 226
              Height = 24
              Top = 36
              Width = 44
              Caption = '13'
              OnChange = cbInputsBit13Change
              TabOrder = 13
            end
            object cbInputsBit14: TCheckBox
              Left = 273
              Height = 24
              Top = 36
              Width = 44
              Caption = '14'
              OnChange = cbInputsBit14Change
              TabOrder = 14
            end
            object cbInputsBit15: TCheckBox
              Left = 322
              Height = 24
              Top = 36
              Width = 44
              Caption = '15'
              OnChange = cbInputsBit15Change
              TabOrder = 15
            end
          end
          object edInputsValHex: TEdit
            Left = 8
            Height = 32
            Hint = 'Для подтверждения ввода нажмите Enter'
            Top = 46
            Width = 96
            MaxLength = 4
            OnEditingDone = edInputsValHexEditingDone
            OnKeyPress = edHoldingsValHexKeyPress
            OnKeyUp = edInputsValHexKeyUp
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0000'
          end
        end
      end
    end
  end
end
