object Form1: TForm1
  Left = 202
  Top = 104
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 415
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 3
    Top = 74
    Width = 92
    Height = 14
    Caption = 'Data do reajuste:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 134
    Top = 245
    Width = 86
    Height = 14
    Caption = 'Repetir (max 450)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 4
    Top = 285
    Width = 165
    Height = 14
    Caption = 'Lojas para lan'#231'ar o Pre'#231'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Memo2: TMemo
    Left = 169
    Top = 70
    Width = 63
    Height = 20
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 6
    Visible = False
    OnClick = Memo1Click
  end
  object Memo1: TMemo
    Left = 2
    Top = 95
    Width = 463
    Height = 141
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnClick = Memo1Click
  end
  object BitBtn1: TBitBtn
    Left = 3
    Top = 243
    Width = 113
    Height = 39
    Caption = '&Copiar Pre'#231'os'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 393
    Width = 630
    Height = 22
    Panels = <>
  end
  object MaskEdit1: TMaskEdit
    Left = 99
    Top = 70
    Width = 66
    Height = 19
    Ctl3D = False
    EditMask = '!99/99/00;1;_'
    MaxLength = 8
    ParentCtl3D = False
    TabOrder = 2
    Text = '  /  /  '
  end
  object SEdit1: TSpinEdit
    Left = 227
    Top = 241
    Width = 51
    Height = 24
    AutoSize = False
    Ctl3D = False
    MaxValue = 15
    MinValue = 1
    ParentCtl3D = False
    TabOrder = 3
    Value = 1
  end
  object RG1: TRadioGroup
    Left = 292
    Top = 236
    Width = 155
    Height = 44
    Caption = 'Tipo de pre'#231'o'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Venda'
      'Promocao')
    TabOrder = 4
  end
  object CheckBox16: TCheckBox
    Left = 134
    Top = 265
    Width = 139
    Height = 15
    Caption = 'Lan'#231'ar 01 item por vez'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 7
    OnClick = CheckBox16Click
  end
  object DT: TDateTimePicker
    Left = 1
    Top = 3
    Width = 102
    Height = 21
    BevelInner = bvSpace
    BevelOuter = bvRaised
    BevelKind = bkSoft
    Date = 38924.618052476850000000
    Time = 38924.618052476850000000
    TabOrder = 8
  end
  object cb1: TComboBox
    Left = 105
    Top = 3
    Width = 176
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvRaised
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 9
    Text = 'CE VAREJO'
    Items.Strings = (
      'CE VAREJO'
      'CE ATACADO'
      'PI VAREJO'
      'PI ATACADO'
      'MA VAREJO'
      'MA ATACADO')
  end
  object Button1: TButton
    Left = 287
    Top = 3
    Width = 68
    Height = 21
    Caption = '&Gerar'
    TabOrder = 10
    OnClick = Button1Click
  end
  object Clb1: TCheckListBox
    Left = 2
    Top = 299
    Width = 176
    Height = 90
    Color = clInfoBk
    Columns = 5
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 11
  end
  object export1: TmxDataSetExport
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'hh:mm'
    DateTimeFormat = 'hh:mm dd/MM/yyyy'
    ExportType = xtTXT
    ExportTypes = [xtExcel, xtTXT]
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
    Options = [xoShowProgress, xoUseAlignments]
    Version = '2.37'
    DataSet = Query1
    Left = 256
    Top = 64
  end
  object Query1: TADOQuery
    ConnectionString = 'FILE NAME=C:\LancaPrecosWell\LancaPrecosWell.udl'
    Parameters = <>
    Left = 288
    Top = 64
  end
  object ADOConnection1: TADOConnection
    Left = 352
    Top = 64
  end
end
