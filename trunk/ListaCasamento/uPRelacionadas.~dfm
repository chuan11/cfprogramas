object fmPRelacionadas: TfmPRelacionadas
  Left = 509
  Top = 470
  Width = 433
  Height = 294
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pessoas Relacionadas com a lista.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 0
    Width = 412
    Height = 223
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
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object btBusca: TfsBitBtn
    Left = 229
    Top = 226
    Width = 83
    Height = 28
    Caption = 'Adicionar'
    TabOrder = 1
    OnClick = btBuscaClick
    NumGlyphs = 2
  end
  object fsBitBtn1: TfsBitBtn
    Left = 325
    Top = 226
    Width = 83
    Height = 28
    Caption = 'Remover'
    TabOrder = 2
    OnClick = fsBitBtn1Click
    NumGlyphs = 2
  end
  object tb: TADOTable
    Connection = Form1.ADOConnection1
    BeforePost = tbBeforePost
    Left = 64
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 64
    Top = 104
  end
end
