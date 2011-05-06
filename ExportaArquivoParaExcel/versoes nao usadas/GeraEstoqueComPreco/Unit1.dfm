object Form1: TForm1
  Left = 211
  Top = 88
  Width = 967
  Height = 488
  Caption = '(09) Rela'#231#227'o de estoque por fornecedor.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edit1: TadLabelEdit
    Left = 5
    Top = 56
    Width = 151
    Height = 19
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Faixa de c'#243'digo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object FlatButton1: TFlatButton
    Left = 167
    Top = 44
    Width = 115
    Height = 43
    Caption = '&Gerar Estoque'
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 3
    Top = 124
    Width = 950
    Height = 298
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object CheckBox1: TCheckBox
    Left = 5
    Top = 101
    Width = 112
    Height = 17
    Caption = 'Exporta Para Excel'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    Visible = False
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 15
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
    TabOrder = 4
    OnChange = cb2Change
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb1: TadLabelComboBox
    Left = 184
    Top = 15
    Width = 170
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 5
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb3: TadLabelComboBox
    Left = 372
    Top = 15
    Width = 127
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 13
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 6
    Text = 'Que t'#234'm estoque'
    Items.Strings = (
      'Que t'#234'm estoque'
      'Tudo')
    LabelDefs.Width = 77
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo de estoque'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb4: TadLabelComboBox
    Left = 529
    Top = 15
    Width = 127
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 13
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 7
    Text = 'C'#243'digo'
    Items.Strings = (
      'C'#243'digo'
      'Descri'#231#227'o')
    LabelDefs.Width = 59
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Ordenar por:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton2: TFlatButton
    Left = 742
    Top = 97
    Width = 130
    Height = 25
    Caption = '&Imprimir'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 8
    OnClick = FlatButton2Click
  end
  object Bt_Saidas: TFlatButton
    Left = 334
    Top = 96
    Width = 115
    Height = 25
    Caption = 'F7 - Listar &Saidas'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
      333333333333337FF3333333333333903333333333333377FF33333333333399
      03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
      99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
      99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
      03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
      33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
      33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
      3333777777333333333333333333333333333333333333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 9
    OnClick = Bt_SaidasClick
  end
  object Bt_Entradas: TFlatButton
    Left = 167
    Top = 96
    Width = 152
    Height = 25
    Caption = ' F6 - Listar todas &Entradas'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
      FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
      00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
      F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
      00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
      F033777777777337F73309999990FFF0033377777777FFF77333099999000000
      3333777777777777333333399033333333333337773333333333333903333333
      3333333773333333333333303333333333333337333333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 10
    OnClick = Bt_EntradasClick
  end
  object Panel2: TPanel
    Left = 6
    Top = 427
    Width = 299
    Height = 23
    BevelOuter = bvNone
    TabOrder = 11
    object Label1: TLabel
      Left = 258
      Top = 5
      Width = 30
      Height = 13
      Caption = 'meses'
    end
    object spedit: TadLabelSpinEdit
      Left = 201
      Top = 1
      Width = 52
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 199
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Itens sem entrada, liste a venda ds ultimos'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      Format = nfStandard
      OnChange = speditChange
      TabOrder = 0
      Value = 3.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
  end
  object FlatButton3: TFlatButton
    Left = 462
    Top = 96
    Width = 128
    Height = 25
    Caption = 'F8 - Mapa separa'#231#227'o'
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
    TabOrder = 12
    OnClick = FlatButton3Click
  end
  object CheckBox2: TCheckBox
    Left = 5
    Top = 81
    Width = 131
    Height = 17
    Caption = 'Mostre estoque do CD'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 13
    Visible = False
  end
  object CheckBox3: TCheckBox
    Left = 372
    Top = 37
    Width = 148
    Height = 17
    Caption = 'Apenas estoque dipon'#237'vel'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 14
  end
  object FlatButton4: TFlatButton
    Left = 605
    Top = 96
    Width = 128
    Height = 25
    Caption = 'Estoque nas lojas'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000002020004040
      004040004040004040004040004040004040004040004040002020000000C0C0
      C0C0C0C0C0C0C0C0C0C000404000808000808000808000808000808000808000
      8080008080008080004040002020C0C0C0C0C0C0C0C0C0C0C0C0004040004040
      0000400040400000400020400020400040400020200080800040400080800020
      20C0C0C0C0C0C0C0C0C000404000404000008000808000008000408000408000
      8080004040008080004040008080006060000000C0C0C0C0C0C0004040004040
      0020400020400020400020400020400040400020200080800040400060600080
      80006060000000C0C0C000404000404000608000008000608000408000408000
      0080002040008080004040004040004040008080002020C0C0C0004040004040
      0020800060800000800040800040800040800000400080800040400040400080
      8000404000808000202000404000404000004000404000004000204000204000
      2040000020008080004040004040004040008080004040004040004040004040
      0000800080800000800040800040800000800020400080800040400040400080
      8000404000404000404000404000606000404000404000404000404000404000
      4040004040008080004040004040004040008080002020004040004040008080
      0080800080800080800080800080800080800080800080800040400060600060
      6000404000404000404000000000404000404000404000404000404000404000
      4040004040004040004040008080006060006060002020004040C0C0C0000000
      0040400080800000000040400020200040400020200040400060600040400060
      60006060002020004040C0C0C0C0C0C0C0C0C000202000606000404000404000
      4040004040004040006060006060006060006060006060004040C0C0C0C0C0C0
      C0C0C0C0C0C00000000020200060600040400020200040400020200020200020
      20006060004040004040C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
      4040004040004040004040004040004040004040004040000000}
    Layout = blGlyphLeft
    TabOrder = 15
    OnClick = FlatButton4Click
  end
  object Animate: TAnimate
    Left = 793
    Top = 7
    Width = 80
    Height = 50
    Active = True
    CommonAVI = aviFindFolder
    StopFrame = 29
    Visible = False
  end
  object Query1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec DBO.Z_CF_ListaEstoqueFornLoja 10033586 , '#39'xx'#39', 0, 0, 101,  ' +
        #39'04/01/2007'#39' , 10033674 , 0')
    Left = 66
    Top = 177
    object Query1Cdigo: TStringField
      FieldName = 'C'#243'digo'
    end
    object Query1Descrio: TStringField
      FieldName = 'Descri'#231#227'o'
      Size = 50
    end
    object Query1DataUltimaEnt: TDateTimeField
      FieldName = 'Data Ultima Ent'
      ReadOnly = True
    end
    object Query1QuantUltimaEnt: TIntegerField
      FieldName = 'Quant Ultima Ent'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object Query1TotalVenda: TIntegerField
      FieldName = 'Total Venda'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object Query1Estoque: TIntegerField
      FieldName = 'Estoque'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object Query1EstoqueCD: TIntegerField
      FieldName = 'EstoqueCD'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object Query1is_ref: TIntegerField
      FieldName = 'is_ref'
      Visible = False
    end
    object Query1PV: TFloatField
      FieldName = 'PV'
      ReadOnly = True
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=WellCfreitas;Data Source=125.4.4.200;Use Procedure f' +
      'or Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID' +
      '=CPD01;Use Encryption for Data=False;Tag with column collation w' +
      'hen possible=False'
    ConnectionTimeout = 0
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnExecuteComplete = ADOConnection1ExecuteComplete
    OnWillExecute = ADOConnection1WillExecute
    Left = 32
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 32
    Top = 216
  end
  object Export1: TmxDataSetExport
    ColumnWidths.Strings = (
      '10'
      '50'
      '100'
      '200'
      '')
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'hh:mm'
    DateTimeFormat = 'hh:mm dd/MM/yyyy'
    ExportType = xtExcel
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsFile
    FileName = 'c:\Planilha.xls'
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
    EXCEL.Options = [reSetMargins]
    EXCEL.ColumnWidth = 100
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
    DataSet = Query1
    Left = 64
    Top = 216
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query1
    Left = 96
    Top = 256
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Posicao de estoque  por fornecedor'
    TitleStatus = 'Posicao de estoque  por fornecedor'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowSetup, ssAllowCopies, ssAllowDestPreview, ssAllowDestPrinter, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormWidth = 900
    SystemPreview.FormHeight = 900
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 32
    Top = 256
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    Left = 56
    Top = 256
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 112
    Top = 176
  end
end
