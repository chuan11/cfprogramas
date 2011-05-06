object Form1: TForm1
  Left = 192
  Top = 107
  Width = 586
  Height = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TadLabelEdit
    Left = 8
    Top = 24
    Width = 464
    Height = 19
    LabelDefs.Width = 254
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Arquivo com a rela'#231#227'o geral dos produtos - uma query'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = 'Duplo clique para abrir'
    OnClick = Edit1Click
    OnDblClick = Edit1DblClick
  end
  object Edit2: TadLabelEdit
    Left = 8
    Top = 70
    Width = 464
    Height = 19
    LabelDefs.Width = 192
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Arquivo com a lista dos produtos do cd - '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = 'Duplo clique para abrir'
    OnClick = Edit2Click
    OnDblClick = Edit2DblClick
  end
  object FlatButton1: TFlatButton
    Left = 388
    Top = 95
    Width = 81
    Height = 25
    Caption = 'Processar'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object Memo1: TFlatMemo
    Left = 8
    Top = 130
    Width = 464
    Height = 135
    ColorFlat = clBtnFace
    ParentColor = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object SB1: TStatusBar
    Left = 0
    Top = 275
    Width = 570
    Height = 19
    Panels = <>
  end
end
