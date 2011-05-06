object fmPrecoCustos: TfmPrecoCustos
  Left = 72
  Top = 0
  ActiveControl = cbCustoMedioUnico
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lancamento de preco de custo'
  ClientHeight = 526
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 225
    Top = 377
    Width = 127
    Height = 13
    Caption = 'Produtos para lancar custo'
    OnClick = Label1Click
    OnDblClick = Label1DblClick
  end
  object Label2: TLabel
    Left = 394
    Top = 377
    Width = 48
    Height = 13
    Caption = 'Resultado'
    OnClick = Label2Click
  end
  object edCodigo: TadLabelEdit
    Left = 5
    Top = 17
    Width = 164
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'C'#243'digo'
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
    OnKeyDown = edCodigoKeyDown
  end
  object Grid: TSoftDBGrid
    Left = 5
    Top = 72
    Width = 627
    Height = 303
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clMenu
  end
  object edPcNovo: TadLabelNumericEdit
    Left = 406
    Top = 15
    Width = 120
    Height = 24
    LabelDefs.Width = 56
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Novo pre'#231'o'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    AutoSize = False
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object btAjustaPreco: TFlatButton
    Left = 553
    Top = 15
    Width = 59
    Height = 25
    Caption = '&Ajustar'
    TabOrder = 3
    OnClick = btAjustaPrecoClick
  end
  object btConsultaProduto: TFlatButton
    Left = 175
    Top = 17
    Width = 25
    Height = 26
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000000000000000000000000000000000005050503F3F3F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF6F6F6FDFDFDF3F3F3F202020FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5FCFCFCF
      DFDFDF9F9F9F6060600000000000000000000000000000000000000000000000
      00000000000000000000404040909090A0A0A0AFAFAF9F9F9F8F8F8F30707000
      4040004040004040004040004040004040004040004040002020FFFFFFFFFFFF
      000000808080DFDFDFDFDFDF6F6F6FAFAFAF7FBFBF7F7F7F404040BFBFBF7FBF
      BFBFBFBF404040004040FFFFFFFFFFFFFFFFFF606060A0A0A0BFBFBFDFDFDF5F
      5F5F5F5F5F4040402020203F3F3FBFFFFFBFFFFF404040004040FFFFFFFFFFFF
      FFFFFF206060A0A0A0BFBFBF2020207F7F7F2020202020202020202020203F3F
      3FBFFFFF404040004040FFFFFFFFFFFFFFFFFF30AFAF505050AFAFAF50505000
      0000606060202020909090C0C0C03030306F6F6F404040004040FFFFFFFFFFFF
      FFFFFF30AFAF505050404040707070000000000000909090C0C0C0C0C0C0C0C0
      C03F3F3F404040004040FFFFFFFFFFFFFFFFFF30AFAF606060BFFFFFBFFFFF7F
      BFBF000000909090C0C0C0C0C0C06F6F6FBFFFFF404040004040FFFFFFFFFFFF
      FFFFFF30AFAF606060BFFFFFBFFFFFBFFFFF7FBFBF0000009090906F6F6FBFFF
      FFBFFFFF404040004040FFFFFFFFFFFFFFFFFF30AFAF606060BFFFFFBFFFFFBF
      FFFFBFFFFF7FBFBF3F3F3FBFFFFFBFFFFFBFFFFF404040004040FFFFFFFFFFFF
      FFFFFF30AFAF606060BFFFFFBFFFFFBFFFFFBFFFFFBFFFFF7FBFBF3F7F7F9F9F
      9FBFFFFF404040004040FFFFFFFFFFFFFFFFFF30AFAF606060BFFFFFBFFFFFBF
      FFFFBFFFFFBFFFFF5F9F9F00007F303070BFFFFF404040004040FFFFFFFFFFFF
      FFFFFF30AFAF3030306060606060606060606060606060605050500000406060
      60606060303030004040FFFFFFFFFFFFFFFFFF30707030AFAF30AFAF30AFAF30
      AFAF30AFAF30AFAF30AFAF30AFAF30AFAF30AFAF30AFAF004040}
    TabOrder = 4
    OnClick = btConsultaProdutoClick
  end
  object cbCustoFiscal: TFlatCheckBox
    Left = 6
    Top = 386
    Width = 99
    Height = 18
    Caption = 'Custo Fiscal'
    Checked = True
    TabOrder = 5
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbCustoMedio: TFlatCheckBox
    Left = 6
    Top = 401
    Width = 108
    Height = 18
    Caption = 'Custo Medio'
    TabOrder = 6
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbCustoMedioUnico: TFlatCheckBox
    Left = 6
    Top = 415
    Width = 108
    Height = 18
    Caption = 'Custo Medio unico'
    TabOrder = 7
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbajustaTodos: TFlatCheckBox
    Left = 7
    Top = 430
    Width = 108
    Height = 18
    Caption = 'Ajusta todos'
    Checked = True
    TabOrder = 8
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbLoja: TadLabelComboBox
    Left = 226
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
    TabOrder = 9
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object memoItens: TMemo
    Left = 224
    Top = 391
    Width = 164
    Height = 160
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 10
  end
  object Button1: TButton
    Left = 120
    Top = 392
    Width = 79
    Height = 27
    Caption = 'Ajustar itens'
    TabOrder = 11
    OnClick = Button1Click
  end
  object mmResult: TMemo
    Left = 393
    Top = 391
    Width = 239
    Height = 160
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 12
  end
  object edNome: TadLabelEdit
    Left = 5
    Top = 45
    Width = 627
    Height = 26
    LabelDefs.Width = 40
    LabelDefs.Height = 13
    LabelDefs.Caption = 'edNome'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnKeyDown = edCodigoKeyDown
  end
  object cbLancaEstoque: TCheckBox
    Left = 120
    Top = 420
    Width = 97
    Height = 17
    Caption = 'Ajusta Estoque'
    TabOrder = 14
  end
  object Button2: TButton
    Left = 8
    Top = 457
    Width = 161
    Height = 25
    Caption = 'Lancar custo de uma nota'
    TabOrder = 15
    OnClick = Button2Click
  end
  object btRecalculaCMUItensNota: TButton
    Left = 8
    Top = 497
    Width = 161
    Height = 25
    Caption = 'Recalcula CMU de itens da nota'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = btRecalculaCMUItensNotaClick
  end
  object query: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 136
    Top = 147
  end
  object DataSource1: TDataSource
    DataSet = query
    Left = 80
    Top = 147
  end
end
