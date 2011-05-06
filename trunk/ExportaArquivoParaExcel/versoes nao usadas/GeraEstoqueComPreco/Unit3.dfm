object Form3: TForm3
  Left = 192
  Top = 106
  Width = 740
  Height = 167
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '(02) An'#225'lise de distribui'#231#227'o de mercadorias. '
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
    Height = 19
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
    TabOrder = 0
  end
  object FlatButton1: TFlatButton
    Left = 39
    Top = 50
    Width = 115
    Height = 25
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
  object CheckBox3: TCheckBox
    Left = 453
    Top = 50
    Width = 148
    Height = 17
    Caption = 'Apenas estoque dipon'#237'vel'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
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
    TabOrder = 4
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
    Height = 61
    Caption = ' Per'#237'odo da consulta '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Label2: TLabel
      Left = 123
      Top = 25
      Width = 19
      Height = 13
      Caption = 'at'#233
    end
    object dtf: TDateTimePicker
      Left = 152
      Top = 20
      Width = 106
      Height = 21
      Date = 39391.478393182870000000
      Time = 39391.478393182870000000
      TabOrder = 0
    end
    object dti: TDateTimePicker
      Left = 7
      Top = 20
      Width = 106
      Height = 21
      Date = 39391.478393182870000000
      Time = 39391.478393182870000000
      TabOrder = 1
    end
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
    ConnectionString = 'FILE NAME=ConexaoAoWell.udl'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 136
    Top = 104
  end
end
