object Form1: TForm1
  Left = 556
  Top = 225
  Width = 800
  Height = 616
  Caption = '(11) Tabela de Pre'#231'os com estoque.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    784
    578)
  PixelsPerInch = 96
  TextHeight = 13
  object edCodigo: TadLabelEdit
    Left = 5
    Top = 16
    Width = 167
    Height = 26
    LabelDefs.Width = 104
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Fornecedor ou &codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edCodigoKeyDown
  end
  object CBPRECO01: TadLabelComboBox
    Left = 179
    Top = 15
    Width = 140
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    TabStop = False
    LabelDefs.Width = 43
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Preco 01'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edDescricao: TadLabelEdit
    Left = 127
    Top = 61
    Width = 327
    Height = 20
    LabelDefs.Width = 48
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Descricao'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    AutoSize = False
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    TabOrder = 1
    Visible = False
  end
  object FlatButton1: TFlatButton
    Left = 634
    Top = 49
    Width = 102
    Height = 57
    Caption = 'Pesquisar ( F7 )'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFF0000000000000000000000000000004000008000008000008000
      00800000800000800000FFFFFFFFFFFFFFFFFF20000080404080404080404080
      4040804040802020800000800000800000800000800000800000FFFFFFFFFFFF
      2000008040408040408040408040408040408040408020208000008000008000
      00800000800000800000FFFFFF20000080404080404080404080404080404080
      4040804040802020703030AF3030AF3030400000400000400000200000804040
      804040804040804040804040804040804040804040503030DF6060DF6060DF60
      60000000FFFFFFFFFFFF000000000000007F7F007F7F007F7F007F7F007F7F3F
      7F7F3F7F7F3FBFBFDF6060DF6060DF6060000000FFFFFFFFFFFFFFFFFFFFFFFF
      003F3F00BFBF00FFFFBFFFFF3FFFFF3FFFFF00FFFF00FFFF9F9F9FDF6060DF60
      60000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00BFBF00FFFF3FFFFF3F
      FFFF3FFFFF3FFFFF00FFFF003F3F000000000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF007F7F00FFFF3FFFFF3FFFFF3FFFFF209F9F4040200000
      00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003F3F00
      BFBF3FFFFF407F7F707050A0A060606040000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF205F5FAFAFAFAFAFAF9090707070
      30202000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000909090EFEFEF8F8F8F808060505050000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000006060609F9F9F7F7F
      5F707050707070000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000000000006F6F30BFBFBF909050707070FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      003F3F7FBFBFBF909050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003F6F6F50BFBFBF}
    TabOrder = 3
    OnClick = FlatButton1Click
  end
  object cbLoja: TadLabelComboBox
    Left = 480
    Top = 15
    Width = 152
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    TabStop = False
    LabelDefs.Width = 118
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja para listar o estoque'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dbgrid: TSoftDBGrid
    Left = -3
    Top = 120
    Width = 778
    Height = 380
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbgridTitleClick
    OnTitleClick = dbgridTitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object cbItens: TRadioGroup
    Left = 5
    Top = 49
    Width = 111
    Height = 60
    Caption = '  Com os itens    '
    Ctl3D = False
    ItemIndex = 0
    Items.Strings = (
      '&Todos'
      'Que comec&am'
      '&Que contem')
    ParentCtl3D = False
    TabOrder = 6
    OnClick = cbItensClick
  end
  object rgTpestoque: TadLabelComboBox
    Left = 644
    Top = 15
    Width = 109
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
    TabStop = False
    Text = 'Todos'
    Items.Strings = (
      'Todos'
      'Que t'#234'm estoque'
      'Maior que zero'
      'Menor que zero')
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Listar o estoque'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Animate: TAnimate
    Left = 645
    Top = 55
    Width = 78
    Height = 45
    AutoSize = False
    CommonAVI = aviFindFile
    StopFrame = 8
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 511
    Width = 784
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    object Label2: TLabel
      Left = 561
      Top = 29
      Width = 42
      Height = 13
      Caption = 'Total 02:'
      Visible = False
    end
    object lbTotal2: TLabel
      Left = 606
      Top = 29
      Width = 26
      Height = 13
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbTotal1: TLabel
      Left = 607
      Top = 5
      Width = 26
      Height = 13
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label1: TLabel
      Left = 562
      Top = 6
      Width = 42
      Height = 13
      Caption = 'Total 01:'
      Visible = False
    end
    object btImprime: TFlatButton
      Left = 4
      Top = 2
      Width = 102
      Height = 40
      Caption = '&Imprimir'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDD7777777777DDDDD0000DDDD
        000000000007DDDD0000DDD07878787870707DDD0000DD0000000000000707DD
        0000DD0F8F8F8AAA8F0007DD0000DD08F8F8F999F80707DD0000DD0000000000
        0008707D0000DD08F8F8F8F8F080807D0000DDD0000000000F08007D0000DDDD
        0BFFFBFFF0F080DD0000DDDDD0F00000F0000DDD0000DDDDD0FBFFFBFF0DDDDD
        0000DDDDDD0F00000F0DDDDD0000DDDDDD0FFBFFFBF0DDDD0000DDDDDDD00000
        0000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
      Layout = blGlyphLeft
      TabOrder = 0
      OnClick = btImprimeClick
    end
    object cbTpImp: TadLabelComboBox
      Left = 114
      Top = 17
      Width = 193
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      TabStop = False
      OnChange = cbTpImpChange
      Items.Strings = (
        'Impress'#227'o modo Laser'
        'Impress'#227'o em modo texto'
        'Impress'#227'o com imagens')
      LabelDefs.Width = 89
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Enviar a impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object FlatButton3: TFlatButton
      Left = 694
      Top = 12
      Width = 81
      Height = 29
      Caption = 'Exportar'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD00000DD00000000006660DD08888880E00
        000DD000000000EEE080DD07778E0EEE0080DDD078E0EEE07700DDDD0E0EEE00
        0000DDD0E0EEE080DDDDDD0E0EEE07080DDDD0E0EEE0777080DD0E0EEE0D0777
        080D00EEE0DDD077700D00000DDDDD00000DDDDDDDDDDDDDDDDD}
      Layout = blGlyphLeft
      TabOrder = 2
      OnClick = FlatButton3Click
    end
    object EdLocalImp: TadLabelEdit
      Left = 322
      Top = 18
      Width = 190
      Height = 19
      LabelDefs.Width = 90
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Porta de impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object CBpRECO02: TadLabelComboBox
    Left = 327
    Top = 15
    Width = 140
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 11
    TabStop = False
    LabelDefs.Width = 43
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Preco 02'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object RgOrdem1: TRadioGroup
    Left = 472
    Top = 45
    Width = 144
    Height = 47
    Caption = '   Ordenacao   '
    Columns = 2
    Ctl3D = False
    ItemIndex = 0
    Items.Strings = (
      '&Descri'#231'ao         '
      '&Codigo              '
      '&Preco           '
      '&Cadastro')
    ParentCtl3D = False
    TabOrder = 7
    OnClick = cbItensClick
  end
  object cbOrder: TFlatCheckBox
    Left = 471
    Top = 92
    Width = 134
    Height = 14
    Caption = 'Ordena por fornecedor'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 12
    TabStop = True
  end
  object stbar: TStatusBar
    Left = 0
    Top = 559
    Width = 784
    Height = 19
    Panels = <>
  end
  object cbTotaliza: TFlatCheckBox
    Left = 471
    Top = 106
    Width = 134
    Height = 14
    Caption = 'Totaliza os valores'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 14
    TabStop = True
    Visible = False
    OnClick = cbTotalizaClick
  end
  object DBGrid1: TDBGrid
    Left = 112
    Top = 352
    Width = 649
    Height = 120
    DataSource = DataSource2
    TabOrder = 15
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ADOConnection1: TADOConnection
    CommandTimeout = 60
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=WellCfreitas;Data Source=125.4.4.200;Use Procedure f' +
      'or Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID' +
      '=WALTERPC;Use Encryption for Data=False;Tag with column collatio' +
      'n when possible=False'
    ConnectionTimeout = 30
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnWillExecute = ADOConnection1WillExecute
    Left = 83
    Top = 216
  end
  object Query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec Z_CF_Tabela_Estoque '#39'002000'#39', '#39#39', 10033586, 101, 101, 0, 0,' +
        ' 0, 0')
    Left = 339
    Top = 176
    object Querycodigo: TStringField
      DisplayWidth = 9
      FieldName = 'Codigo'
    end
    object Querydescricao: TStringField
      DisplayWidth = 40
      FieldName = 'Descricao'
      Size = 50
    end
    object QueryestoqueAtual: TIntegerField
      DisplayLabel = 'Estoque Atual'
      DisplayWidth = 9
      FieldName = 'estoqueAtual'
      ReadOnly = True
    end
    object Queryqt_emb: TBCDField
      DisplayLabel = 'Caixa'
      DisplayWidth = 5
      FieldName = 'qt_emb'
      Precision = 19
    end
    object QueryPreco01: TFloatField
      DisplayWidth = 12
      FieldName = 'Preco 01'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object QueryPreco02: TFloatField
      DisplayWidth = 13
      FieldName = 'Preco 02'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Querycd_pes: TIntegerField
      FieldName = 'cd_pes'
      Visible = False
    end
    object Queryis_ref: TIntegerField
      FieldName = 'is_ref'
      Visible = False
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 432
    Top = 176
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 384
    Top = 239
  end
  object Export1: TmxDataSetExport
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'hh:mm'
    DateTimeFormat = 'hh:mm dd/MM/yyyy'
    ExportType = xtExcel
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsView
    FileName = 'teste'
    HTML.CustomColors.Background = clWhite
    HTML.CustomColors.DefaultLink = clRed
    HTML.CustomColors.DefaultFontFace = 'Arial,Helvetica'
    HTML.CustomColors.VisitedLink = clAqua
    HTML.CustomColors.ActiveLink = clBlue
    HTML.CustomColors.DefaultText = clBlack
    HTML.CustomColors.TableFontColor = clBlack
    HTML.CustomColors.TableFontFace = 'Arial,Helvetica'
    HTML.CustomColors.TableBackground = 16777167
    HTML.CustomColors.TableOddBackground = clWhite
    HTML.CustomColors.HeaderBackground = 3368601
    HTML.CustomColors.HeadersFontColor = clWhite
    HTML.Options = [hoShowGridLines, hoBoldHeaders, hoAutoLink, hoOddRowColoring, hoDisplayTitle]
    HTML.Template = ctStandard
    Messages.Caption = 'Exporting DataSet'
    Messages.CopiedToClipboard = 'Data was copied to clipboard!'
    Messages.CancelCaption = '&Cancel'
    Messages.CreatedText = 'Created:'
    Messages.DocumentFilter.HTML = 'HTML Documents'
    Messages.DocumentFilter.Excel = 'Excel Files'
    Messages.DocumentFilter.Word = 'Word Documents'
    Messages.DocumentFilter.Text = 'Text Files'
    Messages.DocumentFilter.Comma = 'CSV (Comma delimited)'
    Messages.DocumentFilter.Tab = 'Text (Tab delimited)'
    Messages.DocumentFilter.RTF = 'Rich Text Format'
    Messages.DocumentFilter.DIF = 'Data Interchange Format'
    Messages.DocumentFilter.SYLK = 'SYLK Files'
    Messages.ExportCaption = '&Export'
    Messages.ExportToFile = 'Export &to file'
    Messages.FalseText = 'False'
    Messages.Height = 80
    Messages.SaveTitle = 'Save document'
    Messages.SelectFormat = 'E&xport formats:'
    Messages.Text = 'Processing...'
    Messages.TrueText = 'True'
    Messages.Width = 300
    Messages.ViewOnly = '&View only'
    TruncateSymbol = '...'
    RowNumberFormat = '%d'
    DOC_RTF.Template = rtStandard
    DOC_RTF.Options = [roShowGridLines, roOddRowColoring]
    DOC_RTF.CustomSettings.TableBackground = 16777167
    DOC_RTF.CustomSettings.TableOddBackground = clWhite
    DOC_RTF.CustomSettings.HeaderBackground = 3368601
    DOC_RTF.CustomSettings.DefaultFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.DefaultFont.Color = clWindowText
    DOC_RTF.CustomSettings.DefaultFont.Height = -11
    DOC_RTF.CustomSettings.DefaultFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.DefaultFont.Style = []
    DOC_RTF.CustomSettings.HeaderFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.HeaderFont.Color = clWindowText
    DOC_RTF.CustomSettings.HeaderFont.Height = -11
    DOC_RTF.CustomSettings.HeaderFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.HeaderFont.Style = [fsBold]
    DOC_RTF.CustomSettings.TableFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.TableFont.Color = clWindowText
    DOC_RTF.CustomSettings.TableFont.Height = -11
    DOC_RTF.CustomSettings.TableFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.TableFont.Style = []
    DOC_RTF.CellWidth = 1400
    DOC_RTF.TopMargin = 101
    DOC_RTF.BottomMargin = 101
    DOC_RTF.LeftMargin = 461
    DOC_RTF.RightMargin = 562
    EXCEL.Options = [reSetMargins, reUseBorders]
    EXCEL.ColumnWidth = 150
    EXCEL.Protected = False
    EXCEL.Footer = '&P'
    EXCEL.DefaultFont.Charset = DEFAULT_CHARSET
    EXCEL.DefaultFont.Color = clWindowText
    EXCEL.DefaultFont.Height = -11
    EXCEL.DefaultFont.Name = 'MS Sans Serif'
    EXCEL.DefaultFont.Style = []
    EXCEL.HeaderFont.Charset = DEFAULT_CHARSET
    EXCEL.HeaderFont.Color = clWindowText
    EXCEL.HeaderFont.Height = -11
    EXCEL.HeaderFont.Name = 'MS Sans Serif'
    EXCEL.HeaderFont.Style = [fsBold]
    EXCEL.TableFont.Charset = DEFAULT_CHARSET
    EXCEL.TableFont.Color = clWindowText
    EXCEL.TableFont.Height = -11
    EXCEL.TableFont.Name = 'MS Sans Serif'
    EXCEL.TableFont.Style = []
    EXCEL.TopMargin = 0.300000000000000000
    EXCEL.BottomMargin = 0.300000000000000000
    EXCEL.LeftMargin = 0.300000000000000000
    EXCEL.RightMargin = 0.300000000000000000
    Options = [xoClipboardMessage, xoFooterLine, xoHeaderLine, xoShowExportDate, xoShowHeader, xoShowProgress, xoUseAlignments]
    Version = '2.37'
    DataSet = Query
    Left = 352
    Top = 240
  end
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 416
    Top = 240
  end
  object mxOneInstance1: TmxOneInstance
    SwitchToPrevious = True
    Terminate = True
    Version = '1.2'
    OnInstanceExists = mxOneInstance1InstanceExists
    Left = 88
    Top = 160
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = tb
    Left = 216
    Top = 296
  end
  object RvProject: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\ProgramasDiversos\TabelaPrecos2.rav'
    Left = 256
    Top = 288
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 296
    Top = 288
  end
  object DataSource2: TDataSource
    DataSet = tb
    Left = 56
    Top = 368
  end
  object tb: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'zcf_crefe_imagens'
    Left = 64
    Top = 432
    object tbis_ref: TIntegerField
      FieldName = 'is_ref'
    end
    object tbpath: TStringField
      FieldName = 'path'
      Size = 100
    end
  end
end
