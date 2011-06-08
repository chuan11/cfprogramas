object Form1: TForm1
  Left = 261
  Top = 236
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '(02) Relat'#243'rio e pre'#231'os alterados por data.'
  ClientHeight = 129
  ClientWidth = 517
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
    Left = 385
    Top = 3
    Width = 71
    Height = 13
    Caption = 'Data Altera'#231#227'o'
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 19
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
    TabOrder = 0
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb1: TadLabelComboBox
    Left = 180
    Top = 19
    Width = 193
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 1
    LabelDefs.Width = 83
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o a consultar'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton1: TFlatButton
    Left = 407
    Top = 48
    Width = 105
    Height = 31
    Caption = '&Gerar'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object dp1: TfsDateTimePicker
    Left = 386
    Top = 19
    Width = 129
    Height = 21
    Date = 39637.445514861110000000
    Time = 39637.445514861110000000
    TabOrder = 3
  end
  object cbexporta: TCheckBox
    Left = 8
    Top = 80
    Width = 137
    Height = 17
    Caption = 'Exportar para arquivo'
    TabOrder = 4
    OnClick = cbexportaClick
  end
  object stbar: TStatusBar
    Left = 0
    Top = 110
    Width = 517
    Height = 19
    Panels = <>
  end
  object Connection: TADOConnection
    LoginPrompt = False
    Provider = 'C:\ProgramasDiversos\ConexaoAoWell.udl'
    Left = 8
    Top = 40
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Relat'#243'rio de pre'#231'os'
    TitleStatus = 'Gerando relat'#243'rio'
    TitlePreview = 'Relat'#243'rio de pre'#231'os por periodo'
    SystemSetups = [ssAllowSetup, ssAllowDestPreview, ssAllowDestPrinter, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemOptions = [soUseFiler, soShowStatus, soAllowPrintFromPreview, soPreviewModal]
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Impressao relat'#243'rio'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 80
    Top = 40
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query
    Left = 112
    Top = 40
  end
  object RvProject: TRvProject
    Engine = RvSystem1
    ProjectFile = 'RPVALWELL.rav'
    Left = 144
    Top = 40
  end
  object Query: TADOQuery
    Connection = Connection
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        ' Exec stoListarPrecosAlteradosPeriodo '#39'10/04/2007'#39', '#39'10/04/2007'#39 +
        ', 10033586, 101, '#39#39', '#39#39', 10032378')
    Left = 40
    Top = 40
    object QueryCD_PES: TIntegerField
      FieldName = 'CD_PES'
    end
    object QueryIS_REF: TIntegerField
      FieldName = 'IS_REF'
    end
    object QueryCD_REF: TStringField
      FieldName = 'CD_REF'
    end
    object QueryDS_REF: TStringField
      FieldName = 'DS_REF'
      Size = 50
    end
    object QueryNM_PES: TStringField
      FieldName = 'NM_PES'
      Size = 60
    end
    object QueryDT_ALTPV: TDateTimeField
      FieldName = 'DT_ALTPV'
    end
    object QueryVL_PRECO: TBCDField
      FieldName = 'VL_PRECO'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryTP_PRECO: TIntegerField
      FieldName = 'TP_PRECO'
    end
    object QueryIS_UO: TIntegerField
      FieldName = 'IS_UO'
    end
    object QueryIS_ALP: TIntegerField
      FieldName = 'IS_ALP'
    end
    object QueryVL_PRECO2: TBCDField
      FieldName = 'VL_PRECO2'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryDT_ALTPV2: TDateTimeField
      FieldName = 'DT_ALTPV2'
      ReadOnly = True
    end
    object QueryTP_PRECO2: TIntegerField
      FieldName = 'TP_PRECO2'
      ReadOnly = True
    end
    object QueryNM_USU: TStringField
      FieldName = 'NM_USU'
      Size = 60
    end
  end
end
