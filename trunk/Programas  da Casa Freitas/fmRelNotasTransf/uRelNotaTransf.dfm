object fmRelNotaTransf: TfmRelNotaTransf
  Left = 375
  Top = 228
  Width = 741
  Height = 573
  Caption = 'fmRelNotaTransf'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbInicio: TLabel
    Left = 207
    Top = 6
    Width = 50
    Height = 13
    Caption = 'Data inicio'
  end
  object Label1: TLabel
    Left = 313
    Top = 6
    Width = 39
    Height = 13
    Caption = 'Data fim'
  end
  object cbPreco: TadLabelComboBox
    Left = 6
    Top = 23
    Width = 179
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 0
    LabelDefs.Width = 72
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja de destino'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object data: TfsDateTimePicker
    Left = 207
    Top = 23
    Width = 90
    Height = 21
    Date = 39723.536439884260000000
    Time = 39723.536439884260000000
    TabOrder = 1
  end
  object fsDateTimePicker1: TfsDateTimePicker
    Left = 313
    Top = 23
    Width = 90
    Height = 21
    Date = 39723.536439884260000000
    Time = 39723.536439884260000000
    TabOrder = 2
  end
  object adLabelComboBox1: TadLabelComboBox
    Left = 431
    Top = 23
    Width = 98
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 3
    Text = '<Todas>'
    Items.Strings = (
      '<Todas>'
      'Confirmada'
      'N'#227'o confirmadas')
    LabelDefs.Width = 65
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Notas a Listar'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btDadosCliente: TFlatButton
    Left = 566
    Top = 24
    Width = 55
    Height = 19
    Hint = 'Obter Dados do Cliente'
    Caption = 'Gerar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object FlatButton1: TFlatButton
    Left = 654
    Top = 24
    Width = 55
    Height = 19
    Hint = 'Obter Dados do Cliente'
    Caption = 'Imprimir'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
end
