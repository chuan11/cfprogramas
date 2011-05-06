object Form1: TForm1
  Left = 387
  Top = 182
  Width = 1056
  Height = 702
  ActiveControl = FlatCheckBox1
  Caption = 'Exporta'#231#227'o de consultas'
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
  DesignSize = (
    1040
    664)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 825
    Height = 96
    TabOrder = 0
    object edServer: TadLabelEdit
      Left = 8
      Top = 15
      Width = 145
      Height = 19
      LabelDefs.Width = 39
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Servidor'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object edUser: TadLabelEdit
      Left = 163
      Top = 15
      Width = 105
      Height = 19
      LabelDefs.Width = 36
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Usuario'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
    end
    object edPassword: TadLabelEdit
      Left = 275
      Top = 15
      Width = 105
      Height = 19
      LabelDefs.Width = 46
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Password'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
    end
    object cbDds: TadLabelComboBox
      Left = 386
      Top = 15
      Width = 161
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      Style = csDropDownList
      Ctl3D = True
      DropDownCount = 10
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 3
      OnDropDown = cbDdsDropDown
      LabelDefs.Width = 51
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Databases'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object btConfirma: TFlatButton
      Left = 595
      Top = 13
      Width = 117
      Height = 25
      Caption = 'Executar'
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333330000003333333333333333330000003333344333333333330000003333
        4224333333333300000033342222433333333300000033422222243333333300
        000034222A2222433333330000003222A3A222433333330000003A2A333A2224
        33333300000033A33333A222433333000000333333333A222433330000003333
        333333A222433300000033333333333A222433000000333333333333A2224300
        00003333333333333A224300000033333333333333A223000000333333333333
        333A33000000333333333333333333000000}
      Layout = blGlyphLeft
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btConfirmaClick
    end
    object FlatButton1: TFlatButton
      Left = 595
      Top = 45
      Width = 117
      Height = 25
      Hint = 'Exporta consulta'
      Caption = 'Exec e Exportar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F0000FFFFFF0000000000000000000000
        00000000000000000000FFFFFFFF0000BF003F7F0000BF003F7F0000BF003FFF
        0000BF0000000000000000000000000000000000000000000000FFFFFF7F0000
        7F00003F00007F00003F00007F0000BF00003F0000000000000000000000BFBF
        BFBFBFBF000000000000FFFFFFBF003FFF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000BFBFBFBFBFBF000000000000FFFFFF7F0000
        7F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
        00000000000000000000FFFFFFBF003FFF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000FF0000FF00007F0000000000003F3F3FFFFFFF7F0000
        7F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
        00000000000000000000FFFFFFBF003FFF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F0000
        7F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF00000060606060606060606060606060606060606060
        6060606060606060606060606060303030FFFFFFFFFFFFFFFFFF000000A0A0A0
        6060DF8080BFA0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0B0B0B06060
        60FFFFFFFFFFFFFFFFFF0000008080804040BF60609F80808080808080808080
        8080808080808080808080A0A0A0606060FFFFFFFFFFFFFFFFFF000000808080
        404040404040404040404040404040404040404040404040404040A0A0A06060
        60FFFFFFFFFFFFFFFFFF00000080808040404040404040404040404040404040
        4040404040404040404040A0A0A0606060FFFFFFFFFFFFFFFFFF000000BFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF6F6F
        6FFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
        0000000000000000000000000000000000FFFFFFFFFFFFFFFFFF}
      Layout = blGlyphLeft
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = FlatButton1Click
    end
    object FlatButton3: TFlatButton
      Left = 549
      Top = 13
      Width = 26
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
        0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
        B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
        FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
        FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
        FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
        0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
        0555555555777777755555555555555555555555555555555555}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = FlatButton3Click
    end
    object edMail: TadLabelEdit
      Left = 47
      Top = 70
      Width = 526
      Height = 22
      LabelDefs.Width = 31
      LabelDefs.Height = 13
      LabelDefs.Caption = 'E- mail'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecLowerCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = 'casafreitas@casafreitas.com.br'
    end
    object FlatCheckBox1: TFlatCheckBox
      Left = 595
      Top = 75
      Width = 121
      Height = 17
      Caption = 'Enviar para o email'
      Checked = True
      TabOrder = 8
      TabStop = True
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 645
    Width = 1040
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object cb1: TComboBox
    Left = 47
    Top = 42
    Width = 528
    Height = 24
    Style = csDropDownList
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    MaxLength = 10
    ParentFont = False
    TabOrder = 2
    OnChange = cb1Change
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 96
    Width = 1037
    Height = 548
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = '               Consultas                       '
      OnEnter = TabSheet1Enter
      object Splitter1: TSplitter
        Left = 0
        Top = 41
        Width = 1029
        Height = 10
        Cursor = crVSplit
        Align = alTop
        Beveled = True
        Color = clBtnFace
        ParentColor = False
      end
      object memo: TFlatMemo
        Left = 0
        Top = 0
        Width = 1029
        Height = 41
        ColorFocused = clInfoBk
        ColorBorder = clInfoBk
        ColorFlat = clInfoBk
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 51
        Width = 1029
        Height = 469
        Align = alClient
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = DBGrid1TitleClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = '                    Tabelas                         '
      ImageIndex = 1
      OnEnter = TabSheet2Enter
      DesignSize = (
        1029
        520)
      object cbTabelas: TadLabelComboBox
        Left = 1
        Top = 15
        Width = 318
        Height = 24
        BevelInner = bvNone
        BevelKind = bkSoft
        Style = csDropDownList
        Ctl3D = True
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnDropDown = cbTabelasDropDown
        LabelDefs.Width = 51
        LabelDefs.Height = 13
        LabelDefs.Caption = '&Databases'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
      object SoftDBGrid1: TSoftDBGrid
        Left = 2
        Top = 45
        Width = 1025
        Height = 470
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = False
        DataSource = DataSource2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = SoftDBGrid1TitleClick
        AlternateColor = True
        ColorLow = clInfoBk
        ColorHigh = clWindow
      end
      object edFiltro: TadLabelEdit
        Left = 335
        Top = 15
        Width = 353
        Height = 22
        LabelDefs.Width = 22
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Filtro'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edNumLihas: TadLabelSpinEdit
        Left = 706
        Top = 15
        Width = 124
        Height = 26
        Cursor = crDefault
        LabelDefs.Width = 126
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Numero m'#225'ximo de linhas: '
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Decimals = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxValue = 9999.000000000000000000
        MinValue = -1.000000000000000000
        ParentFont = False
        TabOrder = 3
        Increment = 1.000000000000000000
        RoundValues = False
        Wrap = False
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Qr
    Left = 32
    Top = 256
  end
  object Qr: TADOQuery
    Connection = conexao
    CommandTimeout = 0
    Parameters = <>
    Left = 32
    Top = 320
  end
  object mxDataSetExport1: TmxDataSetExport
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'hh:mm'
    DateTimeFormat = 'hh:mm dd/MM/yyyy'
    ExportType = xtExcel
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsFile
    FileName = 'C:\TESTE'
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
    EXCEL.ColumnWidth = 20
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
    DataSet = Qr
    Left = 40
    Top = 376
  end
  object conexao: TADOConnection
    OnWillExecute = conexaoWillExecute
    Left = 784
    Top = 24
  end
  object tb: TADOTable
    Connection = conexao
    Left = 628
    Top = 248
  end
  object DataSource2: TDataSource
    DataSet = tb
    Left = 628
    Top = 304
  end
end
