object fmDialogMov: TfmDialogMov
  Left = 668
  Top = 556
  Width = 321
  Height = 145
  Caption = 'Dados do Movimento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 191
    Top = 14
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object Label1: TLabel
    Left = 13
    Top = 12
    Width = 20
    Height = 13
    Caption = 'Loja'
  end
  object fsDateTimePicker1: TfsDateTimePicker
    Left = 189
    Top = 28
    Width = 108
    Height = 21
    CalColors.BackColor = clInfoBk
    CalColors.TitleTextColor = clInfoBk
    Date = 40395.467315000000000000
    Time = 40395.467315000000000000
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object cbLoja: TfsComboBox
    Left = 12
    Top = 30
    Width = 154
    Height = 21
    Style = csDropDownList
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
  end
  object btOk: TfsBitBtn
    Left = 134
    Top = 69
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object fsBitBtn2: TfsBitBtn
    Left = 220
    Top = 69
    Width = 74
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    Kind = bkCancel
  end
end
