object Form1: TForm1
  Left = 238
  Top = 157
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 296
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 510
    Top = 251
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object DBGrid1: TDBGrid
    Left = 1
    Top = 42
    Width = 770
    Height = 198
    DataSource = DataSource1
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object Memo1: TMemo
    Left = 396
    Top = 43
    Width = 225
    Height = 57
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 277
    Width = 772
    Height = 19
    Panels = <>
  end
  object Cbox1: TadLabelComboBox
    Left = 2
    Top = 16
    Width = 102
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    DropDownCount = 15
    ItemHeight = 13
    TabOrder = 0
    OnClick = Cbox1Click
    LabelDefs.Width = 28
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clNavy
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Verdana'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object UpDown1: TUpDown
    Left = 189
    Top = 12
    Width = 24
    Height = 29
    Max = 99
    Position = 20
    TabOrder = 1
    OnClick = UpDown1Click
  end
  object maskedit1: TadLabelMaskEdit
    Left = 117
    Top = 16
    Width = 70
    Height = 21
    EditMask = '!99/9999;0;_'
    MaxLength = 7
    TabOrder = 2
    OnChange = Cbox1Click
    LabelDefs.Width = 70
    LabelDefs.Height = 13
    LabelDefs.Caption = 'A partir de'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clNavy
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Verdana'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Cbox2: TadLabelComboBox
    Left = 218
    Top = 18
    Width = 120
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    DropDownCount = 15
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    OnClick = Cbox1Click
    Items.Strings = (
      '')
    LabelDefs.Width = 100
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Organizado por'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clNavy
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Verdana'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object BitBtn1: TBitBtn
    Left = 3
    Top = 245
    Width = 75
    Height = 27
    Caption = '&Incluir'
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
      8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
      0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
      0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
      05555555575FF777755555555500055555555555557775555555}
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 64
    Top = 66
    Width = 545
    Height = 177
    TabOrder = 5
    Visible = False
    object Label2: TLabel
      Left = 298
      Top = 58
      Width = 34
      Height = 13
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 389
      Top = 57
      Width = 62
      Height = 13
      Caption = 'Por conta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edit1: TadLabelEdit
      Left = 6
      Top = 38
      Width = 379
      Height = 21
      LabelDefs.Width = 37
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nome'
      LabelDefs.Font.Charset = ANSI_CHARSET
      LabelDefs.Font.Color = clNavy
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'Verdana'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = True
      ParentCtl3D = False
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
    end
    object edit2: TadLabelEdit
      Left = 6
      Top = 75
      Width = 125
      Height = 21
      LabelDefs.Width = 81
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Num Cheque'
      LabelDefs.Font.Charset = ANSI_CHARSET
      LabelDefs.Font.Color = clNavy
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'Verdana'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = True
      ParentCtl3D = False
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 2
    end
    object medit1: TadLabelMaskEdit
      Left = 161
      Top = 73
      Width = 115
      Height = 21
      Ctl3D = True
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentCtl3D = False
      TabOrder = 3
      Text = '  /  /    '
      LabelDefs.Width = 76
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Vencimento'
      LabelDefs.Font.Charset = ANSI_CHARSET
      LabelDefs.Font.Color = clNavy
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'Verdana'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object BitBtn2: TBitBtn
      Left = 385
      Top = 142
      Width = 75
      Height = 25
      Caption = '&OK'
      TabOrder = 7
      OnClick = BitBtn2Click
      Kind = bkOK
    end
    object BitBtn3: TBitBtn
      Left = 464
      Top = 142
      Width = 75
      Height = 25
      Caption = '&Cancel'
      TabOrder = 8
      OnClick = BitBtn3Click
      OnExit = BitBtn3Exit
      Kind = bkCancel
    end
    object StaticText1: TStaticText
      Left = 1
      Top = 1
      Width = 543
      Height = 17
      Align = alTop
      AutoSize = False
      Caption = 'StaticText1'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 9
    end
    object cbox3: TadLabelComboBox
      Left = 431
      Top = 38
      Width = 102
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      Style = csDropDownList
      Ctl3D = False
      DropDownCount = 15
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 1
      LabelDefs.Width = 28
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja'
      LabelDefs.Font.Charset = ANSI_CHARSET
      LabelDefs.Font.Color = clNavy
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'Verdana'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edit3: TLabeledEdit
      Left = 5
      Top = 113
      Width = 532
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 77
      EditLabel.Height = 13
      EditLabel.Caption = 'Observa'#231#227'o'
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clNavy
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Verdana'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      MaxLength = 50
      TabOrder = 6
    end
    object MEdit2: TMaskEdit
      Left = 297
      Top = 72
      Width = 71
      Height = 21
      EditMask = '!99999,!99;1;_'
      MaxLength = 8
      TabOrder = 4
      Text = '    0,  '
      OnKeyPress = MEdit2KeyPress
    end
    object MEdit3: TMaskEdit
      Left = 387
      Top = 72
      Width = 71
      Height = 21
      EditMask = '!99999,!99;1;_'
      MaxLength = 8
      TabOrder = 5
      Text = '    0,  '
      OnKeyPress = MEdit3KeyPress
    end
  end
  object BitBtn4: TBitBtn
    Left = 694
    Top = 246
    Width = 75
    Height = 25
    Caption = 'Expande'
    TabOrder = 7
    OnClick = BitBtn4Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00550000000005
      555555777777777FF5555500000000805555557777777777FF555550BBBBB008
      05555557F5FFF7777FF55550B000B030805555F7F777F7F777F550000000B033
      005557777777F7F5775550BBBBB00033055557F5FFF777F57F5550B000B08033
      055557F77757F7F57F5550BBBBB08033055557F55557F7F57F5550BBBBB00033
      055557FFFFF777F57F5550000000703305555777777757F57F555550FFF77033
      05555557FFFFF7FF7F55550000000003055555777777777F7F55550777777700
      05555575FF5555777F55555003B3B3B00555555775FF55577FF55555500B3B3B
      005555555775FFFF77F555555570000000555555555777777755}
    NumGlyphs = 2
  end
  object BitBtn5: TBitBtn
    Left = 86
    Top = 245
    Width = 75
    Height = 27
    Caption = '&Alterar'
    TabOrder = 8
    OnClick = BitBtn5Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
      300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
      330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
      333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
      339977FF777777773377000BFB03333333337773FF733333333F333000333333
      3300333777333333337733333333333333003333333333333377333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn6: TBitBtn
    Left = 168
    Top = 245
    Width = 75
    Height = 27
    Caption = '&Deletar'
    TabOrder = 9
    OnClick = BitBtn6Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      300033FFFFFF3333377739999993333333333777777F3333333F399999933333
      3300377777733333337733333333333333003333333333333377333333333333
      3333333333333333333F333333333333330033333F33333333773333C3333333
      330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
      333333377F33333333FF3333C333333330003333733333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 8
    Top = 139
  end
  object Database1: TDatabase
    LoginPrompt = False
    SessionName = 'Default'
    Left = 384
  end
  object Query1: TQuery
    DatabaseName = 'cheques'
    SQL.Strings = (
      
        'Select Ref, loja, cliente, Numcheque, Vencimento, Valor, porcont' +
        'a, Observacao, lancamento from cheques')
    Left = 8
    Top = 104
    object Query1Ref: TAutoIncField
      FieldName = 'Ref'
    end
    object Query1loja: TStringField
      FieldName = 'loja'
      FixedChar = True
    end
    object Query1cliente: TStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 50
    end
    object Query1Numcheque: TStringField
      FieldName = 'Numcheque'
      FixedChar = True
      Size = 10
    end
    object Query1Vencimento: TDateTimeField
      FieldName = 'Vencimento'
    end
    object Query1Valor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#,###,###0.00'
    end
    object Query1porconta: TFloatField
      FieldName = 'porconta'
      DisplayFormat = '#,###,###0.00'
    end
    object Query1Observacao: TStringField
      FieldName = 'Observacao'
      FixedChar = True
      Size = 50
    end
    object Query1lancamento: TDateTimeField
      FieldName = 'lancamento'
    end
  end
  object Query2: TQuery
    Left = 70
    Top = 204
  end
  object Export1: TmxDBGridExport
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'hh:mm'
    DateTimeFormat = 'hh:mm dd/MM/yyyy'
    ExportType = xtTXT
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsFile
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
    Messages.Caption = 'Exporting DBGrid'
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
    Options = [xoExportInvisibles, xoRowNumbers, xoUseAlignments]
    Version = '2.37'
    DBGrid = DBGrid1
    Left = 528
    Top = 152
  end
  object MainMenu1: TMainMenu
    Left = 416
    object Imprimir1: TMenuItem
      Caption = 'Impress'#227'o'
      object osdestatela1: TMenuItem
        Caption = 'Impressao por data de lan'#231'amento'
        OnClick = osdestatela1Click
      end
      object ImpressaoPordatadelancamento1: TMenuItem
        Caption = 'Imp por data de lancamento'
        OnClick = ImpressaoPordatadelancamento1Click
      end
    end
  end
end
