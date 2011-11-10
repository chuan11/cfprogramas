object fmAjustaNumNF: TfmAjustaNumNF
  Left = 646
  Top = 312
  Width = 544
  Height = 308
  Caption = 'Ajuste de numera'#231#227'o de notas.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 6
    Top = 5
    Width = 23
    Height = 13
    Caption = 'Loja:'
  end
  object Label4: TLabel
    Left = 35
    Top = 5
    Width = 23
    Height = 13
    Caption = 'Loja:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 47
    Width = 512
    Height = 128
    Caption = 'Dados para alterar a nota:'
    TabOrder = 0
    object cbLoja: TadLabelComboBox
      Left = 8
      Top = 40
      Width = 124
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Color = clHighlightText
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        ' - Gerencial.'
        ' - Fiscal.')
      LabelDefs.Width = 54
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nova s'#233'rie:'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object adLabelComboBox1: TadLabelComboBox
      Left = 144
      Top = 40
      Width = 172
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Color = clHighlightText
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Items.Strings = (
        ' - A pr'#243'xima da sequ'#234'ncia.'
        ' - Informada.')
      LabelDefs.Width = 82
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nova numera'#231#227'o'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object edSerie: TadLabelEdit
      Left = 327
      Top = 39
      Width = 43
      Height = 22
      LabelDefs.Width = 24
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Serie'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Color = clHighlightText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
    end
    object adLabelSpinEdit1: TadLabelSpinEdit
      Left = 376
      Top = 40
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 40
      LabelDefs.Height = 13
      LabelDefs.Caption = 'N'#250'mero:'
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 3
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object adLabelSpinEdit2: TadLabelSpinEdit
      Left = 376
      Top = 82
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 110
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Ajusta o contador para:'
      LabelPosition = adLeft
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 4
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 183
    Width = 512
    Height = 65
    Caption = ' Dados para alterar a numera'#231#227'o antiga: '
    TabOrder = 1
    object adLabelSpinEdit4: TadLabelSpinEdit
      Left = 240
      Top = 24
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 3
      LabelDefs.Height = 13
      LabelPosition = adLeft
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 0
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object fsCheckBox1: TfsCheckBox
      Left = 7
      Top = 27
      Width = 232
      Height = 17
      Caption = 'Altere o contado da numera'#231#227'o antiga para:'
      TabOrder = 1
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object Panel1: TPanel
    Left = 5
    Top = 3
    Width = 396
    Height = 41
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 23
      Height = 13
      Caption = 'Loja:'
    end
    object lbLoja: TLabel
      Left = 35
      Top = 5
      Width = 28
      Height = 13
      Caption = 'lbLoja'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label5: TLabel
      Left = 5
      Top = 20
      Width = 26
      Height = 13
      Caption = 'Nota:'
    end
    object lbNota: TLabel
      Left = 36
      Top = 20
      Width = 41
      Height = 13
      Caption = '000/000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbIsNota: TLabel
      Left = 243
      Top = 13
      Width = 28
      Height = 13
      Caption = 'lbLoja'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object FlatButton1: TFlatButton
    Left = 430
    Top = 13
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Nova'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = FlatButton1Click
  end
end
