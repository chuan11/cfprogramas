object fmResEstoque: TfmResEstoque
  Left = 958
  Top = 254
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '(2) Resumo do estoque das lojas'
  ClientHeight = 454
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 284
    Top = 436
    Width = 38
    Height = 13
    Caption = 'Total :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTotal: TLabel
    Left = 354
    Top = 436
    Width = 74
    Height = 13
    AutoSize = False
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 2
    Top = 48
    Width = 427
    Height = 381
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Panel1: TPanel
    Left = 1
    Top = 2
    Width = 428
    Height = 44
    TabOrder = 1
    object lbCod: TLabel
      Left = 7
      Top = 5
      Width = 186
      Height = 16
      AutoSize = False
      Caption = '----------------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDesc: TLabel
      Left = 6
      Top = 24
      Width = 419
      Height = 15
      AutoSize = False
      Caption = 
        '----------------------------------------------------------------' +
        '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object chsoPositivo: TCheckBox
    Left = 3
    Top = 435
    Width = 165
    Height = 17
    Caption = 'Somar somente saldo positivo'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    OnClick = chsoPositivoClick
  end
  object QrEstoque: TADOQuery
    Connection = fmMain.Conexao
    CommandTimeout = 60
    Parameters = <>
    Left = 32
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = QrEstoque
    Left = 72
    Top = 104
  end
end
