object fmTotalSaidas: TfmTotalSaidas
  Left = 380
  Top = 272
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Venda total no per'#237'odo'
  ClientHeight = 160
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 65
    Width = 38
    Height = 13
    Caption = 'Per'#237'odo'
  end
  object Label2: TLabel
    Left = 115
    Top = 89
    Width = 15
    Height = 13
    Caption = 'at'#233
  end
  object lbDados: TLabel
    Left = 4
    Top = 5
    Width = 350
    Height = 15
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 122
    Width = 51
    Height = 20
    Caption = 'Total :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTotal: TLabel
    Left = 66
    Top = 123
    Width = 11
    Height = 20
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 56
    Width = 307
    Height = 2
  end
  object dt01: TDateTimePicker
    Left = 5
    Top = 83
    Width = 109
    Height = 28
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dt02: TDateTimePicker
    Left = 133
    Top = 83
    Width = 109
    Height = 28
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object FlatButton1: TFlatButton
    Left = 247
    Top = 83
    Width = 72
    Height = 27
    Caption = '&Recalcula'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object cbLoja: TadLabelComboBox
    Left = 26
    Top = 29
    Width = 153
    Height = 21
    AutoCloseUp = True
    BevelInner = bvNone
    BevelKind = bkFlat
    Style = csDropDownList
    Color = clInfoBk
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
  end
end
