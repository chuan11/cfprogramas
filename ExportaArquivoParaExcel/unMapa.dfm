object FmMapa: TFmMapa
  Left = 354
  Top = 191
  Width = 800
  Height = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TSoftDBGrid
    Left = 0
    Top = 35
    Width = 792
    Height = 371
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridDrawColumnCell
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 406
    Width = 792
    Height = 19
    Panels = <>
  end
  object DataSource1: TDataSource
    DataSet = table
    Left = 48
    Top = 200
  end
  object table: TADOTable
    Left = 48
    Top = 160
  end
end
