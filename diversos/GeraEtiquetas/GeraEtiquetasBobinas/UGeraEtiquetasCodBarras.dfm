object Form1: TForm1
  Left = 290
  Top = 108
  Width = 771
  Height = 427
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '(04) Gera'#231#227'o de etiquetas Codigo de Barras'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 127
    Width = 112
    Height = 13
    Caption = 'Itens a serem impressos'
  end
  object Label2: TLabel
    Left = 311
    Top = -1
    Width = 157
    Height = 13
    Caption = 'C'#243'digos de barras para o produto'
  end
  object Label3: TLabel
    Left = 11
    Top = 363
    Width = 112
    Height = 13
    Caption = '(Ctrl + Enter)  Reimprimir'
  end
  object EdCodigo: TadLabelEdit
    Left = 170
    Top = 16
    Width = 135
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
    OnKeyPress = EdCodigoKeyPress
  end
  object edQuant: TadLabelEdit
    Left = 171
    Top = 79
    Width = 134
    Height = 26
    LabelDefs.Width = 55
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Quantidade'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 2
    ParentFont = False
    TabOrder = 2
    Text = '03'
    OnKeyDown = edQuantKeyDown
  end
  object DBGrid: TSoftDBGrid
    Left = 311
    Top = 16
    Width = 442
    Height = 120
    TabStop = False
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = clInfoBk
    ColorHigh = 15790322
  end
  object LBItens: TListBox
    Left = 4
    Top = 150
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
    TabOrder = 5
    OnDblClick = LBItensDblClick
  end
  object FlatButton1: TFlatButton
    Left = 4
    Top = 338
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
    TabOrder = 6
    OnClick = FlatButton1Click
  end
  object FlatButton3: TFlatButton
    Left = 265
    Top = 45
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
    TabOrder = 1
    OnClick = FlatButton3Click
  end
  object FlatButton4: TFlatButton
    Left = 263
    Top = 109
    Width = 43
    Height = 27
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = FlatButton4Click
  end
  object EdLocalImp: TadLabelEdit
    Left = 505
    Top = 345
    Width = 250
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
    TabOrder = 7
  end
  object rgTpImpressora: TRadioGroup
    Left = 277
    Top = 334
    Width = 217
    Height = 34
    Caption = 'Tipo de impressora'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'DynaPos'
      'Argox'
      'DeskJet')
    TabOrder = 8
    OnClick = rgTpImpressoraClick
  end
  object FlatButton2: TFlatButton
    Left = 164
    Top = 338
    Width = 49
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
    TabOrder = 9
    Visible = False
  end
  object cbPrecos: TadLabelComboBox
    Left = 7
    Top = 80
    Width = 153
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
    LabelDefs.Width = 76
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o de venda'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 18
    Width = 157
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 11
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object chPesqPreco: TCheckBox
    Left = 170
    Top = 46
    Width = 92
    Height = 17
    Caption = 'Pesquisa pre'#231'o'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 12
  end
  object Panel1: TPanel
    Left = 505
    Top = 331
    Width = 250
    Height = 40
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 13
    Visible = False
    object Label4: TLabel
      Left = 5
      Top = 15
      Width = 99
      Height = 13
      Caption = 'Comece da linha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 155
      Top = 15
      Width = 40
      Height = 13
      Caption = 'Coluna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpinEdit1: TSpinEdit
      Left = 107
      Top = 10
      Width = 42
      Height = 22
      Ctl3D = False
      MaxValue = 14
      MinValue = 1
      ParentCtl3D = False
      TabOrder = 0
      Value = 1
    end
    object SpinEdit2: TSpinEdit
      Left = 201
      Top = 10
      Width = 42
      Height = 22
      Ctl3D = False
      MaxValue = 6
      MinValue = 1
      ParentCtl3D = False
      TabOrder = 1
      Value = 1
    end
  end
  object Connection: TADOConnection
    ConnectionTimeout = 45
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
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
  object RvCustomConnection1: TRvCustomConnection
    RuntimeVisibility = rtDeveloper
    Left = 312
    Top = 214
  end
  object Raveproject: TRvProject
    Engine = RvSystem1
    Left = 280
    Top = 214
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowSetup, ssAllowCopies, ssAllowCollate, ssAllowDestPreview, ssAllowDestPrinter, ssAllowPrinterSetup]
    SystemOptions = [soShowStatus, soPreviewModal]
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 248
    Top = 214
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 209
    object Palets1: TMenuItem
      Caption = 'Palet'
      OnClick = Palets1Click
    end
  end
end
