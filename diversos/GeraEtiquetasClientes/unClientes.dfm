object Form1: TForm1
  Left = 694
  Top = 82
  Width = 798
  Height = 623
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Impress'#227'o de etiquetas para correspond'#234'ncia'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    782
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
        'Clientes Maison')
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
      Left = 6
      Top = 22
      Width = 379
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  object TPanel
    Left = 0
    Top = 537
    Width = 782
    Height = 48
    Align = alBottom
    TabOrder = 2
    object sb: TStatusBar
      Left = 1
      Top = 28
      Width = 780
      Height = 19
      Panels = <
        item
          Width = 200
        end
        item
          Width = 50
        end>
    end
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
      TabOrder = 1
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
      TabOrder = 2
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
  end
  object TPanel
    Left = 8
    Top = 146
    Width = 772
    Height = 390
    Anchors = [akLeft, akTop, akRight]
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
      Width = 765
      Height = 135
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = dsResult
      ParentCtl3D = False
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
      Width = 762
      Height = 178
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
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
    Left = 349
    Top = 102
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
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object pnNascimento: TPanel
    Left = 221
    Top = 110
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
      LabelDefs.Width = 95
      LabelDefs.Height = 13
      LabelDefs.Caption = 'adLabelComboBox1'
    end
  end
  object pnListas: TPanel
    Left = 309
    Top = 110
    Width = 404
    Height = 92
    BevelOuter = bvNone
    TabOrder = 7
    Visible = False
    object cbListas: TadLabelComboBox
      Left = 16
      Top = 32
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'cbLojas'
      LabelDefs.Width = 95
      LabelDefs.Height = 13
      LabelDefs.Caption = 'adLabelComboBox1'
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
  object conexaoW: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    OnExecuteComplete = conexaoWExecuteComplete
    OnWillExecute = conexaoWWillExecute
    Left = 224
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = tbEtq
    Left = 600
    Top = 48
  end
  object tbEtq: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=wellCfreitas;Data Source=125.4.4.200'
    CursorType = ctStatic
    AfterPost = tbEtqAfterPost
    TableName = 'zcf_etiquetas'
    Left = 24
    Top = 376
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
  object RvProject: TRvProject
    Engine = RvSystem1
    Left = 288
    Top = 486
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 384
    Top = 478
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = tbEtq
    Left = 336
    Top = 486
  end
  object qr: TADOQuery
    Parameters = <>
    Left = 80
    Top = 218
  end
  object conexaoL: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    OnExecuteComplete = conexaoWExecuteComplete
    OnWillExecute = conexaoWWillExecute
    Left = 456
    Top = 48
  end
end
