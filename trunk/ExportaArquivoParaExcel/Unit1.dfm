object Form1: TForm1
  Left = 461
  Top = 256
  Width = 864
  Height = 539
  Caption = '11.01.02 - Gera Estoque.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    848
    501)
  PixelsPerInch = 96
  TextHeight = 13
  object FlatButton1: TFlatButton
    Left = 174
    Top = 44
    Width = 83
    Height = 54
    Caption = '&Gerar Estoque'
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 136
    Width = 848
    Height = 321
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = SoftDBGrid1CellClick
    OnTitleClick = SoftDBGrid1TitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object cbLoja: TadLabelComboBox
    Left = 5
    Top = 16
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
    TabOrder = 3
    OnChange = cbLojaChange
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb1: TadLabelComboBox
    Left = 485
    Top = 17
    Width = 142
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 4
    LabelDefs.Width = 68
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Mostrar pre'#231'o '
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb3: TadLabelComboBox
    Left = 309
    Top = 17
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
    TabOrder = 5
    Text = 'Que t'#234'm estoque'
    OnChange = cb3Change
    Items.Strings = (
      'Que t'#234'm estoque'
      'Tudo')
    LabelDefs.Width = 77
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo de estoque'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Bt_Saidas: TFlatButton
    Left = 302
    Top = 109
    Width = 97
    Height = 22
    Caption = '&Saidas'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
      333333333333337FF3333333333333903333333333333377FF33333333333399
      03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
      99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
      99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
      03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
      33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
      33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
      3333777777333333333333333333333333333333333333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 6
    OnClick = Bt_SaidasClick
  end
  object Bt_Entradas: TFlatButton
    Left = 186
    Top = 109
    Width = 111
    Height = 22
    Caption = '&Entradas/compras'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
      FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
      00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
      F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
      00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
      F033777777777337F73309999990FFF0033377777777FFF77333099999000000
      3333777777777777333333399033333333333337773333333333333903333333
      3333333773333333333333303333333333333337333333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 7
    OnClick = Bt_EntradasClick
  end
  object Panel2: TPanel
    Left = 2
    Top = 459
    Width = 819
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 8
    object Label1: TLabel
      Left = 258
      Top = 5
      Width = 30
      Height = 13
      Caption = 'meses'
    end
    object spedit: TadLabelSpinEdit
      Left = 203
      Top = 1
      Width = 52
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 199
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Itens sem entrada, liste a venda ds ultimos'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      Format = nfStandard
      OnChange = speditChange
      TabOrder = 0
      Value = 3.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object FlatButton2: TFlatButton
      Left = 512
      Top = 0
      Width = 97
      Height = 23
      Caption = '&Imprimir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 1
      OnClick = FlatButton2Click
    end
  end
  object CheckBox2: TCheckBox
    Left = 9
    Top = 60
    Width = 131
    Height = 17
    Caption = 'Mostre estoque do CD'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 9
    Visible = False
  end
  object FlatButton5: TFlatButton
    Left = 538
    Top = 109
    Width = 119
    Height = 22
    Caption = 'Estoque nas lojas'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000002020004040
      004040004040004040004040004040004040004040004040002020000000C0C0
      C0C0C0C0C0C0C0C0C0C000404000808000808000808000808000808000808000
      8080008080008080004040002020C0C0C0C0C0C0C0C0C0C0C0C0004040004040
      0000400040400000400020400020400040400020200080800040400080800020
      20C0C0C0C0C0C0C0C0C000404000404000008000808000008000408000408000
      8080004040008080004040008080006060000000C0C0C0C0C0C0004040004040
      0020400020400020400020400020400040400020200080800040400060600080
      80006060000000C0C0C000404000404000608000008000608000408000408000
      0080002040008080004040004040004040008080002020C0C0C0004040004040
      0020800060800000800040800040800040800000400080800040400040400080
      8000404000808000202000404000404000004000404000004000204000204000
      2040000020008080004040004040004040008080004040004040004040004040
      0000800080800000800040800040800000800020400080800040400040400080
      8000404000404000404000404000606000404000404000404000404000404000
      4040004040008080004040004040004040008080002020004040004040008080
      0080800080800080800080800080800080800080800080800040400060600060
      6000404000404000404000000000404000404000404000404000404000404000
      4040004040004040004040008080006060006060002020004040C0C0C0000000
      0040400080800000000040400020200040400020200040400060600040400060
      60006060002020004040C0C0C0C0C0C0C0C0C000202000606000404000404000
      4040004040004040006060006060006060006060006060004040C0C0C0C0C0C0
      C0C0C0C0C0C00000000020200060600040400020200040400020200020200020
      20006060004040004040C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
      4040004040004040004040004040004040004040004040000000}
    Layout = blGlyphLeft
    TabOrder = 10
    OnClick = FlatButton5Click
  end
  object edit1: TadLabelEdit
    Left = 5
    Top = 58
    Width = 131
    Height = 26
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Faixa de c'#243'digo'
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
  object CheckBox3: TfsCheckBox
    Left = 309
    Top = 50
    Width = 148
    Height = 17
    Caption = 'Apenas estoque dipon'#237'vel'
    TabOrder = 11
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object FlatButton4: TFlatButton
    Left = 659
    Top = 109
    Width = 101
    Height = 22
    Caption = 'Requisi'#231#245'es'
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
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 12
    OnClick = FlatButton4Click
  end
  object stBar: TStatusBar
    Left = 0
    Top = 482
    Width = 848
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object FlatButton6: TFlatButton
    Left = 408
    Top = 109
    Width = 123
    Height = 22
    Caption = 'Resumo Ent/Sai '
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF400020800040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF400020800040800040800040FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF400020
      8000408000408000408000408000404000204000204000204000204000204000
      20400020FFFFFFFFFFFF80004080004080004080004080004080004080004080
      0040800040800040800040800040800040800040FFFFFFFFFFFFA06080800040
      8000408000408000408000408000408000408000408000408000408000408000
      40800040FFFFFFFFFFFF7F0000DF6060A06080800040800040800040AF3050DF
      6060DF6060DF6060DF6060DF6060DF6060AF3050FFFFFFFFFFFFFFFFFFFFFFFF
      7F0000DF6060A06080800040800040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F0000DF6060A06080FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF7F0000FFFFFFFFFFFF800040400020FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF800040800040800040400020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      4000204000204000204000204000204000204000208000408000408000408000
      40800040400020FFFFFFFFFFFFFFFFFF80004080004080004080004080004080
      0040800040800040800040800040800040800040800040800040FFFFFFFFFFFF
      8000408000408000408000408000408000408000408000408000408000408000
      40800040800040A06080FFFFFFFFFFFFAF3050DF6060DF6060DF6060DF6060DF
      6060DF6060AF3050800040800040800040A06080DF60607F0000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800040800040A06080DF60
      607F0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFA06080DF60607F0000FFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphLeft
    TabOrder = 14
    OnClick = FlatButton6Click
  end
  object fsCheckBox1: TfsCheckBox
    Left = 457
    Top = 51
    Width = 97
    Height = 16
    Caption = 'Somente ativos'
    Checked = True
    State = cbChecked
    TabOrder = 15
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object Panel1: TPanel
    Left = 655
    Top = 3
    Width = 187
    Height = 76
    BevelOuter = bvNone
    TabOrder = 16
    object lbNivel: TLabel
      Left = 102
      Top = 4
      Width = 6
      Height = 13
      Caption = '0'
      Visible = False
    end
    object lbCodigo: TLabel
      Left = 124
      Top = 4
      Width = 24
      Height = 13
      Caption = '0000'
      Visible = False
    end
    object lbClasse1: TLabel
      Left = 46
      Top = 30
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse2: TLabel
      Left = 60
      Top = 44
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse3: TLabel
      Left = 71
      Top = 58
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 18
      Width = 184
      Height = 55
    end
    object Label5: TLabel
      Left = 3
      Top = 28
      Width = 26
      Height = 13
      Caption = 'Dep: '
    end
    object Label6: TLabel
      Left = 6
      Top = 43
      Width = 43
      Height = 13
      Caption = 'Secc'#227'o: '
    end
    object Label2: TLabel
      Left = 8
      Top = 57
      Width = 48
      Height = 13
      Caption = 'Categoria:'
    end
    object FlatButton7: TFlatButton
      Left = 16
      Top = 2
      Width = 91
      Height = 21
      Caption = 'Categorias    '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4A4A4A4FFFFFFFFFFFFFFFF
        FFFFA400A4A4A4A4FFFFFFFFFFFFFFFFFFFFA408080008A4FFFFFFFFFFFFFFFF
        FFFFA40808A4A4A4FFFFFFFFFFFF0000A4A4000008A4A4A4FFFFFFFFFFFF00FF
        0808FF000800FFA4FFFFFFFFA400A4A4A4A4A400A4A4A4A4FFFFFFFFA40808FF
        00A4A400A4A4A4A4FFFFFFFFA408000000A4A400FFFFFFFFFFFFFF0000080000
        00A4A400FFFFFFFFFFFFFFFF0808000808A40000FFFFFFFFFFFFFFFFA408FFFF
        00A4A4A4FFFFFFFFFFFFFFFF0000A4A400A400FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphLeft
      ParentFont = False
      TabOrder = 0
      OnClick = FlatButton7Click
    end
  end
  object btBuscaFornecedor: TFlatButton
    Left = 139
    Top = 60
    Width = 24
    Height = 22
    Hint = 'Buscar um fornecedor'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = btBuscaFornecedorClick
  end
  object rgTpBusca: TadLabelComboBox
    Left = 70
    Top = 109
    Width = 101
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 18
    OnChange = rgTpBuscaClick
    Items.Strings = (
      'Codigo'
      'Fornecedor'
      'Ped Forn')
    LabelDefs.Width = 65
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Consultar por:'
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object lbSoEntrada: TfsCheckBox
    Left = 309
    Top = 69
    Width = 133
    Height = 16
    Caption = 'Somente com entrada'
    TabOrder = 19
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object FlatButton3: TFlatButton
    Left = 6
    Top = 87
    Width = 115
    Height = 15
    Caption = 'excel'
    TabOrder = 20
    OnClick = FlatButton3Click
  end
  object ADOConnection1: TADOConnection
    CommandTimeout = 0
    ConnectionTimeout = 10
    LoginPrompt = False
    Provider = 'C:\ProgramasDiversos\ConexaoAoWell.udl'
    OnExecuteComplete = ADOConnection1ExecuteComplete
    OnWillExecute = ADOConnection1WillExecute
    Left = 88
    Top = 232
  end
  object DataSource1: TDataSource
    DataSet = Table
    Left = 32
    Top = 216
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Table
    Left = 112
    Top = 296
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Posicao de estoque  por fornecedor'
    TitleStatus = 'Posicao de estoque  por fornecedor'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowSetup, ssAllowCopies, ssAllowDestPreview, ssAllowDestPrinter, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormWidth = 900
    SystemPreview.FormHeight = 900
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 24
    Top = 296
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    Left = 62
    Top = 296
  end
  object Query2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec DBO.Z_CF_ListaEstoqueFornLoja2 10033586 , '#39'xxxxx'#39', 0, 0, '#39'0' +
        '4/01/2007'#39' , 10033674 , 0')
    Left = 106
    Top = 177
    object StringField1: TStringField
      FieldName = 'C'#243'digo'
    end
    object StringField2: TStringField
      FieldName = 'Descri'#231#227'o'
      Size = 50
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'Data Ultima Ent'
      ReadOnly = True
    end
    object IntegerField1: TIntegerField
      FieldName = 'Quant Ultima Ent'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object IntegerField2: TIntegerField
      FieldName = 'Total Venda'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object IntegerField3: TIntegerField
      FieldName = 'Estoque'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object IntegerField4: TIntegerField
      FieldName = 'EstoqueCD'
      ReadOnly = True
      DisplayFormat = '#,###,###0'
    end
    object FloatField1: TFloatField
      FieldName = 'Vd Med Diaria'
      ReadOnly = True
      DisplayFormat = '#,###,###0.0000'
    end
    object IntegerField5: TIntegerField
      FieldName = 'is_ref'
      Visible = False
    end
    object FloatField2: TFloatField
      FieldName = 'DEstoque'
      ReadOnly = True
      Visible = False
      DisplayFormat = '#,###,###0.0000'
    end
    object StringField3: TStringField
      FieldName = 'Duracao do Estoque'
      Size = 50
    end
  end
  object Table: TADOTable
    Connection = ADOConnection1
    Left = 634
    Top = 141
  end
  object qrEnt: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        ' Exec dbo.Z_CF_ListaEstoqueFornLoja 10033587, '#39'11111'#39', 1, 1, 100' +
        ' , '#39'02/01/2008'#39' , 10033674 , 1')
    Left = 34
    Top = 409
  end
  object qrTVenda: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 409
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 192
    object VerdetalhesdaCMU1: TMenuItem
      Caption = 'Ver detalhes da CRUC  '
      OnClick = VerdetalhesdaCMU1Click
    end
    object Pedidosdecompra1: TMenuItem
      Caption = 'Pedidos de compra'
      OnClick = Pedidosdecompra1Click
    end
    object Verdetalhes1: TMenuItem
      Caption = 'Ver detalhes '
    end
    object VerdetalhesdaCRUCbaseadonanota1: TMenuItem
      Caption = 'Ver detalhes da CRUC  (baseado na nota)'
      OnClick = VerdetalhesdaCRUCbaseadonanota1Click
    end
  end
  object QrCredores: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 128
    Top = 409
  end
end
