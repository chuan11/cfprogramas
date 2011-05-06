object fpesquisa: Tfpesquisa
  Left = 305
  Top = 67
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'fpesquisa'
  ClientHeight = 371
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 3
    Top = 98
    Width = 488
    Height = 236
    TabStop = False
    Color = clInfoBk
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDblClick = DBGrid1DblClick
  end
  object BitBtn1: TBitBtn
    Left = 379
    Top = 66
    Width = 75
    Height = 26
    Caption = '&Buscar'
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
      333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078888888703
      33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
      333337F3333337F333333078F8F870333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
  end
  object rg1: TRadioGroup
    Left = 3
    Top = 3
    Width = 247
    Height = 39
    Caption = 'Buscar por'
    Columns = 2
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'Nome da noiva'
      'Nome do noivo')
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
  end
  object Edit1: TadLabelEdit
    Left = 3
    Top = 68
    Width = 366
    Height = 23
    LabelDefs.Width = 105
    LabelDefs.Height = 15
    LabelDefs.Caption = 'Texto a pesquisar:'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clNavy
    LabelDefs.Font.Height = -12
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Colors.WhenExitFocus.BackColor = clInfoBk
    AutoSize = False
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    TabOrder = 1
    OnKeyDown = Edit1KeyDown
  end
  object BitBtn5: TBitBtn
    Left = 340
    Top = 339
    Width = 75
    Height = 29
    Caption = '&OK'
    Enabled = False
    TabOrder = 3
    OnClick = BitBtn5Click
    Kind = bkOK
  end
  object BitBtn6: TBitBtn
    Left = 419
    Top = 339
    Width = 75
    Height = 29
    Caption = '&Cancela'
    ModalResult = 3
    TabOrder = 4
    OnClick = BitBtn6Click
    Glyph.Data = {
      96010000424D9601000000000000760000002800000018000000180000000100
      04000000000020010000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      D11DDDDDDDDDD11DDDDDDDDD1991DDDDDDDD1991DDDDDDD199991DDDDDD19999
      1DDDDDD1999991DDDD1999991DDDDDDD1999991DD1999991DDDDDDDDD1999991
      1999991DDDDDDDDDDD199999999991DDDDDDDDDDDDD1999999991DDDDDDDDDDD
      DDDD19999991DDDDDDDDDDDDDDDD19999991DDDDDDDDDDDDDDD1999999991DDD
      DDDDDDDDDD199990999991DDDDDDDDDDD19999911999991DDDDDDDDD1999991D
      D1999991DDDDDDD1999991DDDD1999991DDDDDD199991DDDDDD199991DDDDDDD
      1991DDDDDDDD1991DDDDDDDDD11DDDDDDDDDD11DDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
  end
  object query1: TADOQuery
    Connection = Form1.ADOConnetion
    Parameters = <>
    Left = 48
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = query1
    Left = 72
    Top = 168
  end
end
