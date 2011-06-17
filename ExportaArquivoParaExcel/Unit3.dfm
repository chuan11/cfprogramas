object Form3: TForm3
  Left = 192
  Top = 106
  Width = 947
  Height = 464
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '(06) An'#225'lise de distribui'#231#227'o de mercadorias. '
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
  PixelsPerInch = 96
  TextHeight = 13
  object edit1: TadLabelEdit
    Left = 3
    Top = 21
    Width = 151
    Height = 26
    LabelDefs.Width = 91
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Faixa de c'#243'digo'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object FlatButton1: TFlatButton
    Left = 39
    Top = 59
    Width = 115
    Height = 38
    Caption = 'G&erar '
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object cb3: TadLabelComboBox
    Left = 452
    Top = 24
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
    TabOrder = 2
    Text = 'Que t'#234'm estoque'
    Items.Strings = (
      'Que t'#234'm estoque'
      'Tudo')
    LabelDefs.Width = 93
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo de estoque'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb4: TadLabelComboBox
    Left = 604
    Top = 24
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
    TabOrder = 3
    Text = 'C'#243'digo'
    Items.Strings = (
      'C'#243'digo'
      'Descri'#231#227'o')
    LabelDefs.Width = 72
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Ordenar por:'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object GroupBox1: TGroupBox
    Left = 168
    Top = 7
    Width = 266
    Height = 55
    Caption = ' Per'#237'odo da consulta '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 123
      Top = 25
      Width = 19
      Height = 13
      Caption = 'at'#233
    end
  end
  object dti: TfsDateTimePicker
    Left = 176
    Top = 29
    Width = 101
    Height = 21
    Date = 39664.669554756950000000
    Time = 39664.669554756950000000
    TabOrder = 5
  end
  object dtf: TfsDateTimePicker
    Left = 322
    Top = 28
    Width = 101
    Height = 21
    Date = 39664.669554756950000000
    Time = 39664.669554756950000000
    TabOrder = 6
  end
  object CheckBox3: TfsCheckBox
    Left = 454
    Top = 56
    Width = 154
    Height = 17
    Caption = 'Estoque dispon'#237'vel'
    Checked = True
    State = cbChecked
    TabOrder = 7
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object rvProject1: TRvProject
    Engine = RvSystem1
    Left = 96
    Top = 104
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Escolha o destino do relat'#243'rio'
    TitleStatus = 'Destino do relat'#243'rio'
    TitlePreview = 'Escolha o destino do relat'#243'rio'
    SystemSetups = [ssAllowSetup, ssAllowCopies, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 130.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    OnBeforePrint = RvSystem1BeforePrint
    Left = 32
    Top = 104
  end
  object RvDsAnaliseD: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = QAnalize
    Left = 64
    Top = 104
  end
  object QAnalize: TADOQuery
    Connection = Connection
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec Z_CF_analiseDistribuicaototalizada @EhExecutar ='#39'1'#39', @forn=' +
        #39'0070771'#39', @Ordem='#39'1'#39', @di='#39'10/01/2007'#39', @df='#39'10/31/2007'#39', @disp' +
        'onivel='#39'1'#39', @sohComEstoque='#39'0'#39','
      
        '   @01=1, @03=1, @04=1, @05=1, @06=1, @07=0, @08=1, @09=1, @10=1' +
        ', @11=1, @12=1, @16=1, @17=1 ')
    Left = 168
    Top = 104
  end
  object RvRenderPDF1: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    UseCompression = True
    EmbedFonts = False
    ImageQuality = 60
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Author = 'Walter Carvalho'
    DocInfo.Creator = 'Feito com RaveReport'
    DocInfo.Producer = 'Gerado Por Walter carvalho'
    Left = 200
    Top = 104
  end
  object Connection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 136
    Top = 104
  end
end
