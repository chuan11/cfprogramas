object fmInternaNota: TfmInternaNota
  Left = 759
  Top = 234
  Width = 344
  Height = 750
  Caption = 'fmInternaNota'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 328
    Height = 49
    Align = alTop
    Caption = ' Nota '
    TabOrder = 0
    object lbSerie: TLabel
      Left = 45
      Top = 10
      Width = 22
      Height = 13
      Caption = '001'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbBarra: TLabel
      Left = 71
      Top = 10
      Width = 7
      Height = 13
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 83
      Top = 10
      Width = 43
      Height = 13
      Caption = '000000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbfornecedor: TLabel
      Left = 45
      Top = 26
      Width = 65
      Height = 13
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object fsBitBtn1: TfsBitBtn
      Left = 5
      Top = 15
      Width = 35
      Height = 25
      TabOrder = 0
      OnClick = fsBitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F88F88F773
        3333373337F3373F3333078FF8F8870333337F33F7FFF37F333307F87F8FF703
        33337F377777337F3333078F87F88703333373F337F33373333377F7F8F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 49
    Width = 328
    Height = 96
    Align = alTop
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 1
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
    Left = 88
    Top = 56
  end
end
