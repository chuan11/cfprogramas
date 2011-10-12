object fmGeraEstoque: TfmGeraEstoque
  Left = 0
  Top = 31
  Width = 1280
  Height = 739
  Caption = 'Gera Estoque'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 137
    Width = 1264
    Height = 532
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    OnDblClick = gridDblClick
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object pbRodape: TPanel
    Left = 0
    Top = 669
    Width = 1264
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 157
      Top = 5
      Width = 30
      Height = 13
      Caption = 'meses'
    end
    object Label3: TLabel
      Left = 0
      Top = 17
      Width = 97
      Height = 13
      Caption = ' a venda dos ultimos'
    end
    object spedit: TadLabelSpinEdit
      Left = 113
      Top = 1
      Width = 42
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 108
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Itens sem entrada, liste'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      MaxValue = 999.000000000000000000
      MinValue = 1.000000000000000000
      Format = nfStandard
      OnChange = speditChange
      TabOrder = 0
      Value = 3.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object FlatButton2: TFlatButton
      Left = 742
      Top = 2
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
    object rgTpBusca: TadLabelComboBox
      Left = 484
      Top = 1
      Width = 101
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 2
      Text = 'Codigo'
      OnChange = rgTpBuscaClick
      Items.Strings = (
        'Codigo'
        'Ped Forn'
        'Fornecedor')
      LabelDefs.Width = 65
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Consultar por:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object FlatButton3: TFlatButton
      Left = 650
      Top = 2
      Width = 79
      Height = 22
      Caption = 'exportar'
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
      TabOrder = 3
      OnClick = FlatButton3Click
    end
    object cbCalculaEntSaiTotal: TfsCheckBox
      Left = 198
      Top = 5
      Width = 179
      Height = 16
      Caption = 'Entradas/sa'#237'das totais'
      Checked = True
      State = cbChecked
      TabOrder = 4
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object pnTitulo: TPanel
    Left = 0
    Top = 0
    Width = 1264
    Height = 137
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object FlatButton1: TFlatButton
      Left = 208
      Top = 44
      Width = 83
      Height = 54
      Caption = '&Gerar Estoque'
      TabOrder = 0
      OnClick = FlatButton1Click
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
      TabOrder = 1
      OnChange = cbLojaChange
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbPrecos: TadLabelComboBox
      Left = 459
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
      TabOrder = 2
      LabelDefs.Width = 68
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Mostrar pre'#231'o '
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbEstoque: TadLabelComboBox
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
      TabOrder = 3
      Text = 'Que t'#234'm estoque'
      Items.Strings = (
        'Que t'#234'm estoque'
        'Tudo')
      LabelDefs.Width = 77
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Tipo de estoque'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object Bt_Saidas: TFlatButton
      Left = 117
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
      TabOrder = 4
      OnClick = Bt_SaidasClick
    end
    object Bt_Entradas: TFlatButton
      Left = 1
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
      TabOrder = 5
      OnClick = Bt_EntradasClick
    end
    object CheckBox2: TCheckBox
      Left = 9
      Top = 60
      Width = 131
      Height = 17
      Caption = 'Mostre estoque do CD'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
      Visible = False
    end
    object FlatButton5: TFlatButton
      Left = 353
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
      TabOrder = 7
      OnClick = FlatButton5Click
    end
    object edit1: TadLabelEdit
      Left = 5
      Top = 58
      Width = 156
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
      TabOrder = 8
    end
    object FlatButton4: TFlatButton
      Left = 474
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
      TabOrder = 9
      OnClick = FlatButton4Click
    end
    object FlatButton6: TFlatButton
      Left = 223
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
      TabOrder = 10
      OnClick = FlatButton6Click
    end
    object cbProdAtivos: TfsCheckBox
      Left = 310
      Top = 60
      Width = 97
      Height = 16
      Caption = 'Somente ativos'
      TabOrder = 11
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object Panel1: TPanel
      Left = 633
      Top = 3
      Width = 187
      Height = 76
      BevelOuter = bvNone
      TabOrder = 12
      object lbNivel: TLabel
        Left = 146
        Top = 4
        Width = 6
        Height = 13
        Caption = '0'
        Visible = False
      end
      object lbVlCat: TLabel
        Left = 157
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
        Left = 1
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
        Left = 17
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
    object cbSoEntrada: TfsCheckBox
      Left = 310
      Top = 43
      Width = 133
      Height = 16
      Caption = 'Somente com entrada'
      TabOrder = 13
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbCalEmp: TfsCheckBox
      Left = 40
      Top = 0
      Width = 117
      Height = 16
      Caption = 'Calcula na empresa'
      Checked = True
      State = cbChecked
      TabOrder = 14
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object pnForn: TPanel
      Left = 83
      Top = 143
      Width = 199
      Height = 49
      TabOrder = 15
      Visible = False
      object btAddForn: TFlatButton
        Left = 180
        Top = 5
        Width = 17
        Height = 16
        Hint = 'Buscar um fornecedor'
        Caption = '+'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btAddFornClick
      end
      object btRemoveForn: TFlatButton
        Left = 180
        Top = 28
        Width = 17
        Height = 16
        Hint = 'Buscar um fornecedor'
        Caption = '-'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btRemoveFornClick
      end
      object lbForn: TadLabelListBox
        Left = 3
        Top = 2
        Width = 176
        Height = 45
        Ctl3D = False
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 2
        LabelDefs.Width = 29
        LabelDefs.Height = 13
        LabelDefs.Caption = 'lbForn'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
    end
    object pnImage: TPanel
      Left = 824
      Top = 0
      Width = 150
      Height = 120
      TabOrder = 16
      object Image: TImage
        Left = 1
        Top = 1
        Width = 148
        Height = 118
        Align = alClient
        Stretch = True
      end
    end
    object cbCarregaImg: TfsCheckBox
      Left = 825
      Top = 121
      Width = 148
      Height = 16
      Caption = 'Sempre carrege a imagem'
      TabOrder = 17
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = tbGE
    Left = 376
    Top = 141
  end
  object tbGE: TADOTable
    Connection = fmMain.Conexao
    Left = 338
    Top = 141
  end
  object PopupMenu1: TPopupMenu
    Left = 418
    Top = 141
    object VerdetalhesdaCMU1: TMenuItem
      Caption = 'Ver detalhes da CRUC  '
      OnClick = VerdetalhesdaCMU1Click
    end
    object Pedidosdecompra1: TMenuItem
      Caption = 'Pedidos de compra'
      OnClick = Pedidosdecompra1Click
    end
    object Vermovimentodoestoque1: TMenuItem
      Caption = 'Ver movimento do estoque'
      OnClick = Vermovimentodoestoque1Click
    end
  end
end
