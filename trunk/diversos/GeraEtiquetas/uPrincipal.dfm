object Form1: TForm1
  Left = 365
  Top = 210
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '(02) Gera'#231#227'o de C'#243'digos de Barras'
  ClientHeight = 471
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 206
    Width = 112
    Height = 13
    Caption = 'Itens a serem impressos'
  end
  object Label2: TLabel
    Left = 8
    Top = 87
    Width = 157
    Height = 13
    Caption = 'C'#243'digos de barras para o produto'
  end
  object Label3: TLabel
    Left = 267
    Top = 159
    Width = 58
    Height = 13
    Caption = 'Quantidade:'
    Visible = False
  end
  object EdCodigo: TadLabelEdit
    Left = 178
    Top = 16
    Width = 134
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 13
    ParentFont = False
    TabOrder = 0
    OnExit = EdCodigoExit
    OnKeyPress = EdCodigoKeyPress
  end
  object DBGrid: TSoftDBGrid
    Left = 7
    Top = 109
    Width = 746
    Height = 95
    TabStop = False
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = AdicionaProdutoParaImpressao
    OnKeyDown = DBGridKeyDown
    AlternateColor = False
    ColorLow = clInfoBk
    ColorHigh = 15790322
  end
  object LBItens: TListBox
    Left = 4
    Top = 225
    Width = 750
    Height = 180
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    OnDblClick = LBItensDblClick
  end
  object FlatButton1: TFlatButton
    Left = 4
    Top = 414
    Width = 128
    Height = 25
    Caption = '&Imprimir'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF40
      4040606060606060FFFFFF404040202020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF202020606060202020505050303030202020606060AFAFAF5F5F
      5F202020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF202020404040AFAFAF40404060
      60606060606060609F9F9FEFEFEFEFEFEF5F5F5F202020FFFFFFFFFFFFFFFFFF
      202020404040808080DFDFDF404040AFAFAF6F6F6F606060DFDFDFEFEFEFEFEF
      EFEFEFEF5F5F5FFFFFFFFFFFFF2020204040408080808080809F9F9F7F7F7F7F
      7F7FBFBFBF9F9F9FDFDFDFEFEFEFEFEFEFCFCFCFFFFFFF000000FFFFFF000000
      8080808080809090909F9F9F000000BFBFBF808080DFDFDFBFBFBFDFDFDFCFCF
      CFFFFFFF3F3F3FFFFFFFFFFFFF000000808080808080CFCFCFB0B0B070707000
      0000202020BFBFBFDFDFDFBFBFBFDFDFDF5F5F5F404040FFFFFFFFFFFF000000
      808080BFBFBFEFEFEFAFAFAFA0A0A0707070000000202020A0A0A0BFBFBF3F3F
      3F7F7F7F404040202020FFFFFF000000808080EFEFEFDFDFDFDFDFDFAFAFAFA0
      A0A0707070000000202020202020AFAFAF505050202020FFFFFFFFFFFFFFFFFF
      4040409FBFBFDFDFDFDFDFDFDFDFDFAFAFAFA0A0A0707070000000AFAFAF5050
      50202020FFFFFFFFFFFFFFFFFFFFFFFF2020207090909FBFBFDFDFDFDFDFDFDF
      DFDFAFAFAFA0A0A0505050606060000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF3030307090909FBFBFDFDFDFDFDFDFDFDFDFAFAFAF6060607070700000
      00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3030307090909FBFBFDF
      DFDFDFDFDFDFDFDF7F7F7F303030FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF3030307090909FBFBFDFDFDFDFDFDF303030FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF20202020
      20208F8F8F303030FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphLeft
    TabOrder = 3
    OnClick = FlatButton1Click
  end
  object FlatButton3: TFlatButton
    Left = 320
    Top = 90
    Width = 38
    Height = 25
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
    TabOrder = 4
    Visible = False
    OnClick = FlatButton3Click
  end
  object EdLocalImp: TadLabelEdit
    Left = 432
    Top = 421
    Width = 323
    Height = 19
    LabelDefs.Width = 153
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Local para impress'#227'o do arquivo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Colors.WhenExitFocus.BackColor = clMenu
    Ctl3D = False
    ParentCtl3D = False
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object cbPrecos: TadLabelComboBox
    Left = 7
    Top = 59
    Width = 141
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 6
    LabelDefs.Width = 70
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o principal'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 18
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 7
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object chpesqPreco: TfsCheckBox
    Left = 327
    Top = 70
    Width = 94
    Height = 17
    Caption = 'Pesquisa pre'#231'o'
    Checked = True
    State = cbChecked
    TabOrder = 8
    Visible = False
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object edQuant: TSpinEdit
    Left = 363
    Top = 94
    Width = 70
    Height = 22
    Ctl3D = False
    MaxValue = 14
    MinValue = 1
    ParentCtl3D = False
    TabOrder = 9
    Value = 1
    Visible = False
  end
  object cbSegPreco: TadLabelComboBox
    Left = 177
    Top = 60
    Width = 134
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 10
    LabelDefs.Width = 73
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Segundo pre'#231'o'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Button1: TButton
    Left = 328
    Top = 10
    Width = 137
    Height = 35
    Caption = '&Adicionar item'
    TabOrder = 11
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
  object edMensagem: TadLabelEdit
    Left = 477
    Top = 21
    Width = 278
    Height = 19
    LabelDefs.Width = 104
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Texto rodape etiqueta'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Colors.WhenExitFocus.BackColor = clMenu
    Ctl3D = False
    ParentCtl3D = False
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 30
    ParentFont = False
    TabOrder = 12
  end
  object Connection: TADOConnection
    ConnectionTimeout = 45
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnWillExecute = ConnectionWillExecute
    Left = 344
    Top = 38
  end
  object Query: TADOQuery
    Connection = Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'exec Z_CF_getInformacoesProduto '#39'-1'#39', 10033586, -1 ')
    Left = 376
    Top = 38
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 408
    Top = 38
  end
end
