object Form5: TForm5
  Left = 1964
  Top = 357
  Width = 856
  Height = 134
  Caption = 'Memoria de calculo do CRUC.'
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
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 0
    Width = 840
    Height = 96
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object qrDetalhes: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    Left = 8
    Top = 40
  end
  object DataSource1: TDataSource
    Left = 48
    Top = 40
  end
  object qrCustoPorNota: TADOQuery
    Connection = Form1.ADOConnection1
    Parameters = <>
    Left = 136
    Top = 48
  end
end
