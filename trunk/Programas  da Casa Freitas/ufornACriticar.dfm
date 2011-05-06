object fmFornACriticar: TfmFornACriticar
  Left = 320
  Top = 269
  Width = 571
  Height = 405
  Caption = 'Fornecedores  que criticam quant de caixa requisi'#231#245'es'
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
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 0
    Width = 465
    Height = 367
    Align = alLeft
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clInfoBk
  end
  object fsBitBtn1: TfsBitBtn
    Left = 472
    Top = 9
    Width = 75
    Height = 25
    Caption = '&Adicionar'
    TabOrder = 1
    OnClick = fsBitBtn1Click
  end
  object fsBitBtn2: TfsBitBtn
    Left = 472
    Top = 41
    Width = 75
    Height = 25
    Caption = '&Remover'
    TabOrder = 2
    OnClick = fsBitBtn2Click
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 96
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 128
    Top = 64
  end
end
