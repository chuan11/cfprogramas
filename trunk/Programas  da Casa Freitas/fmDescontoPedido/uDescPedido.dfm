object fmDescPed: TfmDescPed
  Left = 554
  Top = 196
  Width = 759
  Height = 590
  Caption = '(04) Inserir desconto em Pedido'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    743
    552)
  PixelsPerInch = 96
  TextHeight = 13
  object lbParcelas: TLabel
    Left = 8
    Top = 365
    Width = 114
    Height = 13
    Caption = 'Total das parcelas: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 331
    Top = 259
    Width = 95
    Height = 13
    Caption = 'Valor da entrada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 475
    Top = 259
    Width = 103
    Height = 13
    Caption = 'Valor dasParcelas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbItens: TLabel
    Left = 8
    Top = 381
    Width = 80
    Height = 13
    Caption = 'Total pedido: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 5
    Top = 43
    Width = 97
    Height = 13
    Caption = 'Dados do pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 5
    Top = 115
    Width = 89
    Height = 13
    Caption = 'Itens do pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 5
    Top = 57
    Width = 635
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object tpDesconto: TRadioGroup
    Left = 4
    Top = 277
    Width = 150
    Height = 66
    Caption = ' Tipo de Desconto  '
    ItemIndex = 0
    Items.Strings = (
      'Valor'
      'Percentual'
      'Ajusta para o valor')
    TabOrder = 1
    OnClick = tpDescontoClick
  end
  object nmPed: TadLabelEdit
    Left = 3
    Top = 16
    Width = 118
    Height = 19
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pedido'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    OnKeyDown = nmPedKeyDown
  end
  object btConsultaPed: TFlatButton
    Left = 125
    Top = 16
    Width = 95
    Height = 19
    Caption = 'Consulta'
    TabOrder = 3
    OnClick = btConsultaPedClick
  end
  object gridParcelas: TSoftDBGrid
    Left = 478
    Top = 273
    Width = 158
    Height = 82
    Ctl3D = False
    DataSource = DataSource2
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnExit = gridEntradaExit
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object gridEntrada: TSoftDBGrid
    Left = 332
    Top = 274
    Width = 134
    Height = 81
    Ctl3D = False
    DataSource = dtsEnt
    ParentCtl3D = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnExit = gridEntradaExit
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object gridItens: TSoftDBGrid
    Left = 5
    Top = 131
    Width = 633
    Height = 119
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = False
    DataSource = dsItens
    ParentCtl3D = False
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridItensCellClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 404
    Width = 147
    Height = 104
    Caption = 'Desconto no pedido  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object FlatButton3: TFlatButton
      Left = 8
      Top = 78
      Width = 130
      Height = 21
      Caption = 'Autoriza desconto'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = FlatButton3Click
    end
    object FlatButton4: TFlatButton
      Left = 8
      Top = 56
      Width = 130
      Height = 19
      Caption = 'Confere valores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = FlatButton4Click
    end
    object edValor: TadLabelNumericEdit
      Left = 8
      Top = 32
      Width = 130
      Height = 19
      LabelDefs.Width = 44
      LabelDefs.Height = 13
      LabelDefs.Caption = 'edValor'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object gbDescCusto: TGroupBox
    Left = 160
    Top = 277
    Width = 165
    Height = 79
    Caption = 'Aplicar pre'#231'o de custo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object FlatButton2: TFlatButton
      Left = 10
      Top = 51
      Width = 144
      Height = 21
      Caption = 'Aplicar pre'#231'o de custo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = FlatButton2Click
    end
    object btConfirmaCusto: TFlatButton
      Left = 10
      Top = 19
      Width = 144
      Height = 21
      Caption = 'Confirma pre'#231'o de custo'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btConfirmaCustoClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 160
    Top = 379
    Width = 474
    Height = 158
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Registros de avarias  dos itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    DesignSize = (
      474
      158)
    object gridAvarias: TSoftDBGrid
      Left = 5
      Top = 17
      Width = 460
      Height = 135
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = dsAvaItem
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnKeyDown = gridAvariasKeyDown
      AlternateColor = True
      ColorLow = clInfoBk
      ColorHigh = clWindow
    end
  end
  object FlatButton5: TFlatButton
    Left = 354
    Top = 373
    Width = 130
    Height = 21
    Caption = 'Calcule o desconto.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = FlatButton5Click
  end
  object Query: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        ' select pedidoCliente.numPedido as [Pedido], tbuo.ds_uo as [Loja' +
        '], pedidoCliente.DataPedido as [Data],  dspes.nm_pes as [Cliente' +
        '] , pedidocliente.situacaoPedido as  [St],  pedidoCliente.ValorT' +
        'otal as [Vl Produtos], pedidoCliente.ValorNota as [Vl Pedido],  ' +
        'pedidoCliente.ValorDesconto as [Vl Desconto], pedidoCliente.Perc' +
        'entualDesconto as [% Desconto],  dsusu.nm_usu as [Autorizador]  ' +
        'from pedidocliente   inner join tbuo  on pedidocliente.seqfilial' +
        ' = tbuo.is_uo  left join dspes on pedidoCliente.cd_pes = dspes.c' +
        'd_pes  left join dsusu on  pedidoCliente.codUsuarioAutorizacao =' +
        ' dsusu.CD_USU  where pedidoCliente.numpedido = 2310346')
    Left = 184
    Top = 64
    object QueryPedido: TIntegerField
      FieldName = 'Pedido'
    end
    object QueryLoja: TStringField
      FieldName = 'Loja'
      Size = 50
    end
    object QueryData: TDateTimeField
      FieldName = 'Data'
    end
    object QueryCliente: TStringField
      FieldName = 'Cliente'
      Size = 60
    end
    object QuerySt: TStringField
      FieldName = 'St'
      FixedChar = True
      Size = 1
    end
    object QueryVlProdutos: TBCDField
      FieldName = 'Vl Produtos'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryVlPedido: TBCDField
      FieldName = 'Vl Pedido'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryVlDesconto: TBCDField
      FieldName = 'Vl Desconto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryDesconto: TBCDField
      FieldName = '% Desconto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object QueryAutorizador: TStringField
      FieldName = 'Autorizador'
      Size = 30
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 224
    Top = 64
  end
  object DataSource2: TDataSource
    DataSet = tbParc
    Left = 564
    Top = 332
  end
  object dtsEnt: TDataSource
    DataSet = tbEnt
    Left = 348
    Top = 319
  end
  object tbEnt: TADOTable
    Connection = fmMain.Conexao
    Left = 316
    Top = 319
    object tbEntN: TIntegerField
      FieldName = 'N'
    end
    object tbEntValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#,###,###0.00'
    end
  end
  object tbParc: TADOTable
    Connection = fmMain.Conexao
    Left = 532
    Top = 332
    object tbParcN: TIntegerField
      FieldName = 'N'
    end
    object tbParcVenc: TDateTimeField
      FieldName = 'Venc'
    end
    object tbParcValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#,###,###0.00'
    end
  end
  object dsItens: TDataSource
    DataSet = tbItens
    Left = 152
    Top = 149
  end
  object tbItens: TADOTable
    Connection = fmMain.Conexao
    Left = 120
    Top = 149
  end
  object dsAvaItem: TDataSource
    DataSet = tbAvarias
    Left = 340
    Top = 423
  end
  object tbAvarias: TADOTable
    Connection = fmMain.Conexao
    BeforePost = tbAvariasBeforePost
    Left = 375
    Top = 422
  end
end
