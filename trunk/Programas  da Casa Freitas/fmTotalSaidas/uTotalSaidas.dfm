object fmTotalSaidas: TfmTotalSaidas
  Left = 398
  Top = 149
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Venda total no per'#237'odo'
  ClientHeight = 442
  ClientWidth = 579
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
    Left = 6
    Top = 79
    Width = 38
    Height = 13
    Caption = 'Per'#237'odo'
  end
  object Label2: TLabel
    Left = 115
    Top = 105
    Width = 15
    Height = 13
    Caption = 'at'#233
  end
  object Label3: TLabel
    Left = 398
    Top = 100
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
    Left = 458
    Top = 101
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
    Top = 73
    Width = 569
    Height = 2
  end
  object dt01: TDateTimePicker
    Left = 5
    Top = 98
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
    Top = 98
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
    Top = 98
    Width = 72
    Height = 27
    Caption = '&Recalcula'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object cbLoja: TadLabelComboBox
    Left = 26
    Top = 44
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
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 575
    Height = 41
    TabOrder = 4
    object Label4: TLabel
      Left = 6
      Top = 6
      Width = 49
      Height = 13
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDados: TLabel
      Left = 63
      Top = 6
      Width = 33
      Height = 13
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object grid: TSoftDBGrid
    Left = 0
    Top = 132
    Width = 579
    Height = 310
    Align = alBottom
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object DataSource1: TDataSource
    Left = 80
    Top = 136
  end
end
