object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
  Height = 450
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 83
    Top = 32
    Width = 20
    Height = 13
    Caption = 'Loja'
  end
  object Label2: TLabel
    Left = 78
    Top = 88
    Width = 104
    Height = 13
    Caption = 'Quantidade de Fichas'
  end
  object edLoja: TfsEdit
    Left = 80
    Top = 48
    Width = 321
    Height = 21
    MaxLength = 30
    TabOrder = 0
    Text = 'GENERAL BEZERRIL'
  end
  object edTotal: TfsEdit
    Left = 80
    Top = 104
    Width = 313
    Height = 21
    TabOrder = 1
  end
  object FlatButton1: TFlatButton
    Left = 72
    Top = 232
    Width = 81
    Height = 25
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object rgContagem: TRadioGroup
    Left = 80
    Top = 136
    Width = 185
    Height = 65
    Caption = 'rgContagem'
    ItemIndex = 0
    Items.Strings = (
      '01 contagem'
      '02 contagem')
    TabOrder = 3
  end
end
