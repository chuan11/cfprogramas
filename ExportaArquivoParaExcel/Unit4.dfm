object Form4: TForm4
  Left = 2114
  Top = 391
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Venda total no per'#237'odo'
  ClientHeight = 157
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 28
    Width = 38
    Height = 13
    Caption = 'Per'#237'odo'
  end
  object Label2: TLabel
    Left = 131
    Top = 52
    Width = 15
    Height = 13
    Caption = 'at'#233
  end
  object Label4: TLabel
    Left = 3
    Top = 5
    Width = 341
    Height = 15
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dt01: TDateTimePicker
    Left = 2
    Top = 46
    Width = 128
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
    Left = 151
    Top = 46
    Width = 128
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
    Left = 288
    Top = 46
    Width = 52
    Height = 27
    Caption = '&Recalcula'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object cbDetalhaPorLoja: TfsCheckBox
    Left = 3
    Top = 77
    Width = 101
    Height = 17
    Caption = 'Detalhar por loja'
    TabOrder = 3
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 138
    Width = 346
    Height = 19
    Panels = <>
  end
  object gridVenda: TSoftDBGrid
    Left = 0
    Top = 94
    Width = 346
    Height = 44
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    DataSet = Form1.qrTVenda
    Left = 96
    Top = 101
  end
end
