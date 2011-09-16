object fmetqClientes: TfmetqClientes
  Left = 543
  Top = 190
  Width = 790
  Height = 623
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Impress'#227'o de etiquetas para correspond'#234'ncia'
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
  OnShow = FormShow
  DesignSize = (
    774
    585)
  PixelsPerInch = 96
  TextHeight = 13
  object pnInicial: TPanel
    Left = 3
    Top = 1
    Width = 214
    Height = 112
    TabOrder = 0
    object rgTpPesquisa: TRadioGroup
      Left = 8
      Top = 8
      Width = 193
      Height = 89
      Caption = '  Selecione  o tipo de listagem   '
      ItemIndex = 0
      Items.Strings = (
        'Etiqueta avulsa (Clientes Well)'
        'Compras por valor no periodo'
        'Aniversariantes'
        'Listas, por data de evento'
        'Clientes categoria maison')
      TabOrder = 0
      OnClick = rgTpPesquisaClick
    end
  end
  object pnPesquisaAvulsa: TPanel
    Left = 221
    Top = 6
    Width = 404
    Height = 92
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 147
      Height = 13
      Caption = 'Pesquisar pelo nome do cliente'
    end
    object edNmCliente: TfsEdit
      Left = 8
      Top = 22
      Width = 291
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object rgTpPesqCliente: TRadioGroup
      Left = 306
      Top = 1
      Width = 97
      Height = 55
      Caption = ' Pesquisar por: '
      Items.Strings = (
        'Nome'
        'Codigo')
      TabOrder = 1
    end
  end
  object pnImpressao: TPanel
    Left = 0
    Top = 537
    Width = 774
    Height = 48
    Align = alBottom
    TabOrder = 2
    object edLinha: TadLabelSpinEdit
      Left = 614
      Top = 4
      Width = 52
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 125
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Comece a imprimir na linha'
      LabelPosition = adLeft
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 0
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object edColuna: TadLabelSpinEdit
      Left = 715
      Top = 4
      Width = 52
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 36
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Coluna:'
      LabelPosition = adLeft
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 1
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object fsBitBtn1: TfsBitBtn
      Left = 8
      Top = 3
      Width = 87
      Height = 34
      Caption = 'Imprimir'
      TabOrder = 2
      OnClick = FlatButton6Click
      Glyph.Data = {
        56080000424D560800000000000036000000280000001A0000001A0000000100
        18000000000020080000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000012C2C359494990000000E0E
        00353500FFFF007E7E00000000E1E1E70000000000009D9DA4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA00
        00154C4C00383800030300515100FFFF00FFFF00EFEF00FFFF008A8A00000000
        A0A000CACA0000000094949AFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEEEEEE07071F4A4A00FFFF00F9F900CCCC00FFFF00E5E5
        00B3B3006B6B00D9D900FFFF00A1A100C4C400949400CDCD0000000098989AFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000A474700FF
        FF00E0E000E7E700B9B900000000C9C900090900000000888800DADA00D7D700
        35353565656BA3A300E3E30000000098989BFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFF0000004A4A00FFFF00D7D70002020BC5C5005A5A008383971515
        1B14141A95959800000097970004040DE1E1E8FFFFFF3B3B56A6A600E2E20000
        0000939399FFFFFF0000FFFFFFFFFFFFE8E8E800000A4A4A00FFFF00C2C2000F
        0F00FFFFFF00000F252531CCCCCC121213101010E9E9E953535400000DFFFFFF
        C8C8C83F3F3FFFFFFF3B3B55A4A400CCCC00000000DCDCE30000FFFFFFFFFFFF
        47475F404000FFFF00C2C2002F2F1562626DFFFFFF9C9C9C1F1F1FC3C3C30202
        020F0F0FDEDEDE3F3F3F9F9F9F7D7D7DFFFFFFACACACDFDFDFFFFFFF5050539B
        9B00ABAB00EFEFE80000FFFFFFFFFFFFD0D06CFFFF00D9D9001B1B0D6F6F7A77
        7777FFFFFF8F8F8F151515D7D7D7D1D1D1000000FFFFFF2D2D2DBFBFBF868686
        515151FFFFFF676767353535FFFFFF555557ADAD00FFFFE30000FFFFFFFFFFFF
        FFFF6CE5E500000000808089838383747474FFFFFF8F8F8F5E5E5EFFFFFF0D0D
        0DECECECA6A6A6404040F9F9F9FFFFFFF2F2F2FFFFFFFFFFFF000000343434FF
        FFFFFFFFF9FFFFFF0000FFFFFFFFFFFFCBCB690D0D0089899182828280808084
        84841D1D1D787878404040393939EAEAEAAEAEAE424242D8D8D8090909D4D4D4
        CACACA000000828282FFFFFF464646FFFFFFC0C0C8FFFFFF0000FFFFFFFFFFFF
        5656605E5E638484848080807D7D7D898989FFFFFF040404000000AEAEAEB8B8
        B8313131E2E2E27777776F6F6F797979DCDCDCCECECE000000F3F3F3FFFFFF6D
        6D3F0000007878810000FFFFFFFFFFFF6060605A5A5A848484808080747474C5
        C5C5D7D7D79494941B1B1B3A3A3A000000434343B6B6B6F5F5F5DADADA717171
        7E7E7EDBDBDBC0C0C0FFFFFF3D3D28C9C900E8E8000000000000FFFFFFFFFFFF
        6060605A5A5A8383837878788D8D8DF4F4F4C6C6C69D9D9D8686861212120000
        00000000393939C3C3C3CFCFCFD3D3D36D6D6D7D7D7DEEEEEE2626275353565A
        5A00FFFF00E9E9000000FFFFFFFFFFFF5959595656567E7E7E969696F2F2F2FF
        FFFF8C8C8C9999999E9E9E9999992020200000000000002D2D2DB2B2B2C0C0C0
        D8D8D87878780000001414146B6B783A3A00C5C500FDFDFF0000FFFFFFFFFFFF
        9B9B9B7272729A9A9AF0F0F0FFFFFFCBCBCBF9F9F99A9A9A9595959B9B9B9999
        991A1A1A0000000000003535358A8A8AB0B0B0272727252525FFFFFF2D2D2A79
        7907FEFEDBFFFFFF0000FFFFFFFFFFFFFFFFFF505050CBCCCCFCFFFFE3E2E2E0
        E0E0DFDFDFEDEDEDA3A3A39595959E9E9E878787252525000000000000393939
        0F0F0F2E2E2EFBFBFC4545567B7B00FFFFD7FFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFF0202028A8888E4D8D8E4E3E3E0E0E0DFDFDFE2E2E2EDEDED9A9A9A9A9A
        9A9D9D9D8585851F1F1F000000000000222222FFFFFF3F3F5C787800FFFFF0FF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF73828219BABAD8D0D0E6
        E2E2E0E0E0DFDFDFDFDFDFFBFBFB9191919C9C9C9D9D9D9292921A1A1A090909
        FFFFFF3F3F4C767600FFFFFBFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF6F939331B2B2CDD1D1E6E2E2E0E0E0DFDFDFDDDDDDFFFF
        FF9292929696969B9B9BA4A4A4000000626262101010D4D4E1FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F56F9F9F31
        B1B1D8D0D0E5E4E4E0E0E0E0E0E0DEDEDEF1F1F1A0A0A0A7A7A75D5D5D494949
        797979CBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF6F67093931ABABAEDD0D0E4E4E4E0E0E0DFDF
        DFE1E1E1EBEBEBB4B4B4000000CDCDCDB4B4B4F2F2F2FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF72818115BFBFE2D0D0E5E2E2E0E0E0DFDFDFE1E1E1F6F6F6949494030303
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF708A8A25AFAFC9D2D2E3E1
        E1E0E0E0E1E1E1CBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF94C9C9C3F7F7F0EBEBE1E1E1DFDFDFFDFDFDFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF948E8E7D78789999
        99E5E5E5EDEDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
    end
    object Edit1: TEdit
      Left = 136
      Top = 8
      Width = 65
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object Edit2: TEdit
      Left = 216
      Top = 8
      Width = 65
      Height = 21
      TabOrder = 4
      Text = '0'
    end
  end
  object pnDados: TPanel
    Left = 1
    Top = 147
    Width = 772
    Height = 390
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 3
    DesignSize = (
      768
      386)
    object Label3: TLabel
      Left = 4
      Top = 193
      Width = 91
      Height = 13
      Caption = 'Clientes Escolhidos'
    end
    object Label4: TLabel
      Left = 3
      Top = 0
      Width = 53
      Height = 13
      Caption = 'Resultados'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 186
      Width = 768
      Height = 3
    end
    object gRidResult: TSoftDBGrid
      Left = 2
      Top = 15
      Width = 755
      Height = 135
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      DataSource = dsResult
      ParentCtl3D = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = gRidResultTitleClick
      AlternateColor = True
      ColorLow = clWindow
      ColorHigh = clInfoBk
    end
    object gridClientes: TSoftDBGrid
      Left = 2
      Top = 208
      Width = 752
      Height = 178
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      DataSource = dsClientes
      ParentCtl3D = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = gridClientesTitleClick
      AlternateColor = True
      ColorLow = clWindow
      ColorHigh = clInfoBk
    end
    object btAddCliente: TfsBitBtn
      Left = 51
      Top = 153
      Width = 100
      Height = 30
      Caption = 'Adicionar Cliente'
      TabOrder = 2
      OnClick = btAddClienteClick
    end
    object bdAddAll: TfsBitBtn
      Left = 160
      Top = 153
      Width = 100
      Height = 30
      Caption = 'Adicionar Todos'
      TabOrder = 3
      OnClick = bdAddAllClick
    end
    object btRmCliente: TfsBitBtn
      Left = 615
      Top = 153
      Width = 100
      Height = 30
      Caption = 'Remover Todos'
      TabOrder = 4
      OnClick = btRmClienteClick
    end
    object btRmAllCliente: TfsBitBtn
      Left = 503
      Top = 155
      Width = 100
      Height = 30
      Caption = 'Remover escolhido'
      TabOrder = 5
      OnClick = btRmAllClienteClick
    end
  end
  object btPesquisa: TfsBitBtn
    Left = 656
    Top = 24
    Width = 81
    Height = 57
    Caption = 'Pesquisar'
    TabOrder = 4
    OnClick = btPesquisaClick
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      BDBDBDC6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C8C8C8B7B6B7949194FF
      FFFFFFFFFF3D3C3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000502
      05000000000000FFFFFFFFFFFFA0A0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF5657562222223E3E3EFFFFFFFFFFFF979797FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFEDEFEE3E413F443D41695F5F000000FFFFFFFFFFFF979797
      FFFFFFB1AEB3A96593AA6C96B37AA1B37AA1AE739BB37AA1B37AA1AA6C96ECD4
      E4655D68CECED0615663F6DEEE8E4B792C1A232906184F5064D3F4FF63697DFF
      FFFFFFFFFF979797FFFFFFFFFFFFFFFFFFFFFFFFB37AA1B37AA1F0E4ECC28CB1
      C58DB3FCEAF6BF82ACC588B1B3729EF6DEEE904D7B32242A1F0B154F5368F8FF
      FF000F393A3531FFFFFFFFFFFF979797FFFFFFA96593E9D3E2AC6C97BA82A8FF
      EFF9B1719D4A1B3D31162329292D3A3633A2A8A5ECF0EEF4F7F5444B46474142
      4D4E65F0FFFF445783928F86343134FFFFFFFFFFFF979797FFFFFF8C738B8E74
      8CE3DBE2A991A82911261D191A8B968FBBB3BAA38F99A5ADA93C413D4345444F
      5250443C3E494961F0FFFF344773FFFFFF767676343134FFFFFFFFFFFF979797
      FFFFFFAE6C98B67BA3C98CB5471B385E4B558C6F846B2A576629527B4474C07F
      AAD19FC396858E1B000D525671F3FFFF344773FFFFFFFFFFFF767676343134FF
      FFFFFFFFFF979797FFFFFFFFFFFFFFFFFF9FA7A2210E22252826040700050B02
      060D02181C1F3E4540532F4A480E38000000C0BDB9213054FFFFFFFFFFFFFFFF
      FF767676343134FFFFFFFFFFFF979797FFFFFFA86799AA6E9B1D1D1900000081
      8081D2D1D3EEEBEFD2D1D37C7B7C2A292A000000000501B0ADB03D423E464642
      FFFFFFFFFFFFFFFFFF767676343134FFFFFFFFFFFF979797FFFFFFC88EB52600
      182E1D2AF3F5F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7776771617170D
      120EDCA7CA2B322A9A6185A96794E5C5DB7A7D7B343134FFFFFFFFFFFF979797
      FFFFFF8B5776130911FFFFFFFFFFFFFFFFFFC29EB4D969B29B004DFFFFFFA000
      48FFFFFFA48C9E000100414345A77A96ACB9B1FFFFFFFFFFFF767676343134FF
      FFFFFFFFFF979797FFFFFF00000041333DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      A70056FFFFFFA60054FFFFFFFFFFFF1B1B1C28222335202C694259DCBBD2FFFF
      FF767676343134FFFFFFFFFFFF9E9F9ED8D7D80A100C50404C676062FFFFFFEB
      BCDCFFFFFFFFFFFFA6005FCA81B1A30069FFFFFFFFFFFFE0E1E1000000464E47
      E3E9E7FFFFFFFFFFFF767676343134FFFFFFFFFFFFA7A7A77879784F4A50331C
      29747372C495B6A50064B9278BFFFFFF9C004DFFFFFFFFFFFFFFFFFFFFFFFFD8
      BBCE1B201D2B1F27A36C8ED7B7CDFFFFFF767676343134FFFFFFFFFFFFA7A7A7
      7F7F7F5052507D6F7A6B6567B1B8B5D9A9C6F8C7E4FFFFFFDD73BBFFFFFFFFFF
      FFFFFFFFF4FFF6582E490F0D0B464949F5DCEDFFFFFFFFFFFF767676343134FF
      FFFFFFFFFFA7A7A77D7D7D444845D9ACC99A9897AFABAFB7BABA392331614955
      7B5E769C8B937451623C22332C14223B2632110F0E5E4955B979A5A66491E5C5
      DB7A7D7B343134FFFFFFFFFFFFA4A4A49797972223239B8993FAD4ECBDBEBFB2
      AEB23D303A37242F3B293239263138242F41413E494E4B9EA4A7000000F6FFF9
      FFFFFFFFFFFFFFFFFF767676343134FFFFFFFFFFFF9A9A9AFFFFFF000000635A
      5FDFA8C9FFFFFFFAFBFB7C64716A4C60382B3527101C4F4055907A8CC9B5BCC7
      8FB1281E26B973A2D5B5CBFFFFFFFFFFFF767676343134FFFFFFFFFFFF979797
      FFFFFF504E503B4242F1F5F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF181D1AECEDECFFFFFFFFFFFFFFFFFFFFFFFF7676762F2C2FFF
      FFFFFFFFFF979797FFFFFFFFFFFF161410333A3AD1C9D1FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFF3F3F2000000D7D7D7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF6B6C6B575457FFFFFFFFFFFF969696969696999A9AB4ADAE2E2D2E1D171D45
      46465759546E6256637067605D574145410000009D9D9DA1A1A1969696969696
      9696969696969696969C9C9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF9596955654511A1315242527171612646565787778FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphTop
  end
  object pnCompras: TPanel
    Left = 325
    Top = 206
    Width = 404
    Height = 92
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object Label2: TLabel
      Left = 176
      Top = 12
      Width = 38
      Height = 13
      Caption = 'Per'#237'odo'
    end
    object cbLojas: TadLabelComboBox
      Left = 16
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      LabelDefs.Width = 20
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object datai: TfsDateTimePicker
      Left = 173
      Top = 31
      Width = 105
      Height = 21
      Date = 40290.641664976850000000
      Time = 40290.641664976850000000
      TabOrder = 1
    end
    object dataf: TfsDateTimePicker
      Left = 293
      Top = 31
      Width = 105
      Height = 21
      Date = 40290.641664976850000000
      Time = 40290.641664976850000000
      TabOrder = 2
    end
    object edVlVenda: TadLabelNumericEdit
      Left = 164
      Top = 64
      Width = 145
      Height = 19
      LabelDefs.Width = 152
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Clientes com compras acima de:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object pnNascimento: TPanel
    Left = 357
    Top = 94
    Width = 404
    Height = 92
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object cbMeses: TadLabelComboBox
      Left = 16
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Janeiro'
      Items.Strings = (
        'Janeiro'
        'Fevereiro'
        'Mar'#231'o'
        'Abril'
        'Maio'
        'Junho'
        'Julho'
        'Agosto'
        'Setembro'
        'Outubro'
        'Novembro'
        'Dezembro')
      LabelDefs.Width = 20
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Mes'
      Colors.WhenEnterFocus.BackColor = clHighlightText
    end
    object cbLojaAniversarios: TadLabelComboBox
      Left = 183
      Top = 35
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      LabelDefs.Width = 20
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja'
      Colors.WhenEnterFocus.BackColor = clHighlightText
    end
  end
  object pnListas: TPanel
    Left = 261
    Top = 174
    Width = 404
    Height = 92
    BevelOuter = bvNone
    TabOrder = 7
    Visible = False
    object Label5: TLabel
      Left = 175
      Top = 11
      Width = 116
      Height = 13
      Caption = 'Listas com evento entre:'
    end
    object cbListas: TadLabelComboBox
      Left = 16
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '01'
        '03'
        '05'
        '06'
        '07'
        '08'
        '09'
        '10'
        '11'
        '12'
        '17'
        '18')
      LabelDefs.Width = 20
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja'
      Colors.WhenEnterFocus.BackColor = clHighlightText
    end
    object dtl01: TfsDateTimePicker
      Left = 173
      Top = 31
      Width = 105
      Height = 21
      Date = 40290.641664976850000000
      Time = 40290.641664976850000000
      TabOrder = 1
    end
    object dtl02: TfsDateTimePicker
      Left = 293
      Top = 31
      Width = 105
      Height = 21
      Date = 40290.641664976850000000
      Time = 40290.641664976850000000
      TabOrder = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = tbEtq
    Left = 600
    Top = 48
  end
  object tbEtq: TADOTable
    Connection = fmMain.Conexao
    CursorType = ctStatic
    AfterPost = tbEtqAfterPost
    AfterDelete = tbEtqAfterPost
    TableName = 'zcf_etiquetas'
    Left = 64
    Top = 408
    object tbEtqNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object tbEtqEndereco: TStringField
      FieldName = 'Endereco'
      Size = 50
    end
    object tbEtqnumero: TStringField
      FieldName = 'numero'
      FixedChar = True
      Size = 5
    end
    object tbEtqcompEndereco: TStringField
      FieldName = 'compEndereco'
      Size = 50
    end
    object tbEtqBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object tbEtqCidade: TStringField
      FieldName = 'Cidade'
      Size = 30
    end
    object tbEtqCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object tbEtqnum: TIntegerField
      FieldName = 'num'
      Visible = False
    end
    object tbEtqSEQ: TAutoIncField
      FieldName = 'SEQ'
      ReadOnly = True
    end
  end
  object dsResult: TDataSource
    DataSet = qr
    Left = 24
    Top = 202
  end
  object dsClientes: TDataSource
    DataSet = tbEtq
    Left = 24
    Top = 410
  end
  object qr: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 56
    Top = 202
  end
  object conexaoL: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    OnExecuteComplete = conexaoWExecuteComplete
    OnWillExecute = conexaoWWillExecute
    Left = 456
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    Left = 33
    Top = 251
    object Exportarlista1: TMenuItem
      Caption = 'Exportar lista'
      OnClick = Exportarlista1Click
    end
  end
end
