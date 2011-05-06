object fmConReqDep: TfmConReqDep
  Left = 326
  Top = 181
  Width = 795
  Height = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    779
    478)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 422
    Top = 3
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label3: TLabel
    Left = 5
    Top = 200
    Width = 29
    Height = 13
    Caption = 'Itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 5
    Top = 43
    Width = 74
    Height = 13
    Caption = 'Requisi'#231#245'es '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 83
    Top = 43
    Width = 180
    Height = 13
    Caption = '( Duplo clique para visualizer os itens )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 548
    Top = 3
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object grid: TSoftDBGrid
    Left = 4
    Top = 59
    Width = 774
    Height = 134
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridDblClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object cbLojas: TadLabelComboBox
    Left = 3
    Top = 18
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
    Left = 216
    Top = 18
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
  object dti: TfsDateTimePicker
    Left = 420
    Top = 18
    Width = 105
    Height = 21
    CalColors.BackColor = clInfoBk
    Date = 39689.000000000000000000
    Time = 39689.000000000000000000
    TabOrder = 3
  end
  object pdGrid: TSoftDBGrid
    Left = 3
    Top = 216
    Width = 774
    Height = 214
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource2
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object dtf: TfsDateTimePicker
    Left = 543
    Top = 18
    Width = 105
    Height = 21
    CalColors.BackColor = clInfoBk
    Date = 39689.000000000000000000
    Time = 39689.000000000000000000
    TabOrder = 5
  end
  object fsBitBtn1: TfsBitBtn
    Left = 664
    Top = 9
    Width = 104
    Height = 43
    Caption = '&Consultar'
    TabOrder = 6
    OnClick = fsBitBtn1Click
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 40
    Top = 83
  end
  object DataSource2: TDataSource
    DataSet = qrProd
    Left = 112
    Top = 347
  end
  object qrProd: TADOQuery
    Connection = fmMain.Conexao
    CommandTimeout = 0
    Parameters = <>
    Left = 200
    Top = 338
  end
  object Query: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 128
    Top = 88
  end
end
