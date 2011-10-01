object Form1: TForm1
  Left = 409
  Top = 271
  Width = 806
  Height = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 422
    Top = 53
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label2: TLabel
    Left = 548
    Top = 53
    Width = 45
    Height = 13
    Caption = 'Data final'
  end
  object grid: TSoftDBGrid
    Left = 4
    Top = 98
    Width = 785
    Height = 311
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object cbLojas: TadLabelComboBox
    Left = 3
    Top = 71
    Width = 178
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    LabelDefs.Width = 158
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Requisi'#231#245'es feitas a partir da loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbLojaEstoque: TadLabelComboBox
    Left = 201
    Top = 71
    Width = 181
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    LabelDefs.Width = 56
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Para a loja: '
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btConsultar: TFlatButton
    Left = 680
    Top = 57
    Width = 70
    Height = 35
    Caption = '&Consultar'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
      33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
      8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
      F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
      F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
      0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
      3333333777333777333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btConsultarClick
  end
  object dti: TfsDateTimePicker
    Left = 420
    Top = 71
    Width = 105
    Height = 21
    CalColors.BackColor = clInfoBk
    Date = 39689.000000000000000000
    Time = 39689.000000000000000000
    TabOrder = 4
  end
  object dtf: TfsDateTimePicker
    Left = 547
    Top = 71
    Width = 105
    Height = 21
    CalColors.BackColor = clInfoBk
    Date = 39689.000000000000000000
    Time = 39689.000000000000000000
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 50
    Align = alTop
    BorderStyle = bsSingle
    TabOrder = 6
    object lbCodigo: TLabel
      Left = 72
      Top = 17
      Width = 50
      Height = 13
      Caption = 'lbCodigo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDesc: TLabel
      Left = 133
      Top = 18
      Width = 50
      Height = 13
      Caption = 'lbCodigo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 40
    Top = 83
  end
  object Connection: TADOConnection
    LoginPrompt = False
    OnWillExecute = ConnectionWillExecute
    Left = 120
    Top = 83
  end
  object Query: TADOQuery
    Connection = Connection
    CommandTimeout = 0
    Parameters = <>
    Left = 80
    Top = 83
  end
end
