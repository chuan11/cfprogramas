object fmTabela: TfmTabela
  Left = 303
  Top = 222
  Width = 809
  Height = 551
  Caption = '(12) Tabela de Pre'#231'os com estoque.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  WindowMenu = fmMain.abeladePreos1
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    793
    513)
  PixelsPerInch = 96
  TextHeight = 13
  object edCodigo: TadLabelEdit
    Left = 5
    Top = 16
    Width = 113
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
  object cbPreco01: TadLabelComboBox
    Left = 126
    Top = 16
    Width = 150
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
    Left = 447
    Top = 16
    Width = 170
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
    Left = 3
    Top = 123
    Width = 787
    Height = 341
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
    OnCellClick = dbgridCellClick
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
    Left = 628
    Top = 16
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
    Top = 465
    Width = 793
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    object Label1: TLabel
      Left = 639
      Top = 5
      Width = 42
      Height = 13
      Caption = 'Total 01:'
      Visible = False
    end
    object Label2: TLabel
      Left = 639
      Top = 29
      Width = 42
      Height = 13
      Caption = 'Total 02:'
      Visible = False
    end
    object lbTotal1: TLabel
      Left = 685
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
    object lbTotal2: TLabel
      Left = 684
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
    object btImprime: TFlatButton
      Left = 2
      Top = 4
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
      Width = 121
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      TabStop = False
      OnChange = cbTpImpChange
      Items.Strings = (
        'Impressora'
        'Porta')
      LabelDefs.Width = 89
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Enviar a impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object FlatButton3: TFlatButton
      Left = 551
      Top = 4
      Width = 81
      Height = 40
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
      Left = 247
      Top = 18
      Width = 172
      Height = 19
      LabelDefs.Width = 90
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Porta de impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object tpPapel: TadLabelComboBox
      Left = 431
      Top = 17
      Width = 115
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      TabStop = False
      OnChange = cbTpImpChange
      Items.Strings = (
        'Formul'#225'rio Continuo'
        'A4')
      LabelDefs.Width = 89
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Tamanho do papel'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object cbPreco02: TadLabelComboBox
    Left = 281
    Top = 16
    Width = 150
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
  object RgOrdem: TRadioGroup
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
  object cbTotaliza: TFlatCheckBox
    Left = 471
    Top = 106
    Width = 134
    Height = 14
    Caption = 'Totaliza os valores'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 13
    TabStop = True
    Visible = False
    OnClick = cbTotalizaClick
  end
  object FlatButton2: TFlatButton
    Left = 8
    Top = 416
    Width = 25
    Height = 25
    TabOrder = 14
    Visible = False
  end
  object Query: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec Z_CF_Tabela_Estoque '#39'002000'#39', '#39#39', 10033586, 101, 101, 0, 0,' +
        ' 0, 0')
    Left = 363
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
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 400
    Top = 176
  end
end
