object fmCalcExNota: TfmCalcExNota
  Left = 314
  Top = 237
  Width = 824
  Height = 524
  Caption = 'Calculo de extra nota'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object lbForn: TLabel
    Left = 458
    Top = 8
    Width = 29
    Height = 13
    Caption = 'lbForn'
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 28
    Width = 157
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
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object EdCodigo: TadLabelEdit
    Left = 170
    Top = 26
    Width = 58
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 13
    ParentFont = False
    TabOrder = 1
  end
  object adLabelEdit1: TadLabelEdit
    Left = 238
    Top = 26
    Width = 135
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 13
    ParentFont = False
    TabOrder = 2
  end
  object edForn: TadLabelEdit
    Left = 383
    Top = 25
    Width = 285
    Height = 22
    LabelDefs.Width = 54
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Fornecedor'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object btForn: TfsBitBtn
    Left = 671
    Top = 26
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = btFornClick
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 8
    Top = 70
    Width = 790
    Height = 400
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object tb: TADOTable
    Left = 40
    Top = 96
  end
  object DataSource1: TDataSource
    Left = 80
    Top = 96
  end
end
