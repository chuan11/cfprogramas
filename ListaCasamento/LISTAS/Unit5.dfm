object Form5: TForm5
  Left = 249
  Top = 107
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Digite o codigo do produto ou digite  o nome do item'
  ClientHeight = 98
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 8
    Width = 45
    Height = 15
    Caption = 'Codigo :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 154
    Top = 8
    Width = 255
    Height = 18
    AutoSize = False
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label1: TLabel
    Left = 9
    Top = 73
    Width = 91
    Height = 15
    Caption = 'Tipo do produto:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 433
    Top = 0
    Width = 65
    Height = 30
    DataSource = DataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Visible = True
      end>
  end
  object BitBtn1: TBitBtn
    Left = 343
    Top = 64
    Width = 75
    Height = 33
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 423
    Top = 64
    Width = 75
    Height = 33
    Cancel = True
    Caption = '&Fechar'
    TabOrder = 2
    OnClick = BitBtn2Click
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
  object Edit1: TEdit1ColorFocus
    Left = 6
    Top = 32
    Width = 493
    Height = 30
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxLength = 40
    ParentFont = False
    TabOrder = 3
    CorAoEntrar = clInfoBk
    CorAoSair = clBtnHighlight
  end
  object maskedit1: tMeditColor
    Left = 53
    Top = 0
    Width = 97
    Height = 30
    EditMask = '!9999999;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxLength = 7
    ParentFont = False
    TabOrder = 4
    Text = '       '
    OnExit = maskedit1Exit
    CorAoEntrar = clInfoBk
    CorAoSair = clBtnHighlight
  end
  object Cbox1: TComboBoxColor
    Left = 106
    Top = 69
    Width = 202
    Height = 23
    Style = csDropDownList
    Color = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 15
    ParentFont = False
    TabOrder = 5
    Items.Strings = (
      '01 - INOX'
      '02 - CRISTAIS/VIDRO'
      '03 - PORCELANA/LOUCAS '
      '04 - PLASTICOS'
      '05 - OUTROS  ')
    CorAoEntrar = clInfoBk
    CorAoSair = clBtnHighlight
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 72
    Top = 48
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=ZTESTE;Data Source=125.4.4.200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 48
  end
  object Query1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 8
    Top = 48
  end
end
