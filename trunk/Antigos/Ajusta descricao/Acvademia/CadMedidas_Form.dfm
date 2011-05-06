object frmCadMedidas: TfrmCadMedidas
  Left = 90
  Top = 176
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Medidas'
  ClientHeight = 394
  ClientWidth = 944
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 943
    Height = 260
    DataSource = dsMedida
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_MED'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_MED'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 287
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PESO'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABDOMEM'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COXA_D'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COXA_E'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BICEPS_D'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BICEPS_E'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TORAX'
        Width = 67
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 264
    Width = 777
    Height = 129
    Caption = 'Dados para Filtragem:'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 33
      Width = 63
      Height = 13
      Caption = 'Código entre:'
    end
    object Label2: TLabel
      Left = 160
      Top = 33
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label3: TLabel
      Left = 8
      Top = 65
      Width = 53
      Height = 13
      Caption = 'Data entre:'
    end
    object Label4: TLabel
      Left = 224
      Top = 65
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label5: TLabel
      Left = 8
      Top = 97
      Width = 76
      Height = 13
      Caption = 'Nome do Aluno:'
    end
    object dblcNome: TDBLookupComboBox
      Left = 88
      Top = 90
      Width = 281
      Height = 21
      KeyField = 'COD_ALU'
      ListField = 'NOME'
      ListSource = dsNome
      TabOrder = 5
      OnCloseUp = dblcNomeCloseUp
    end
    object dtpData1: TDateTimePicker
      Left = 88
      Top = 58
      Width = 129
      Height = 21
      CalAlignment = dtaLeft
      Date = 36526
      Time = 36526
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object edCod2: TEdit
      Left = 176
      Top = 26
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '100000'
      OnExit = edCod2Exit
      OnKeyPress = edCod1KeyPress
    end
    object edCod1: TEdit
      Left = 88
      Top = 26
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '1'
      OnExit = edCod1Exit
      OnKeyPress = edCod1KeyPress
    end
    object edNome: TEdit
      Left = 88
      Top = 90
      Width = 264
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object dtpData2: TDateTimePicker
      Left = 240
      Top = 57
      Width = 129
      Height = 21
      CalAlignment = dtaLeft
      Date = 36526
      Time = 36526
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 3
    end
    object GroupBox2: TGroupBox
      Left = 661
      Top = 89
      Width = 112
      Height = 37
      TabOrder = 7
      object btnFiltra: TBitBtn
        Left = 3
        Top = 8
        Width = 105
        Height = 25
        Caption = '&FILTRAR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnFiltraClick
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333330033003300300003333
          3333300330033003000033303333333333333333000033000333333333333333
          000030F000333333333333330000330F000333333333333300003330F0000000
          73333333000033330F0078887033333300003333300788FF8703333300003333
          30788888F877333300003333308888888F80333300003333307888888F803333
          000033333078FF8888803333000033333777FF88887733330000333333077888
          8703333300003333333077777033333300003333333370007333333300003333
          33333333333333330000}
      end
    end
    object GroupBox3: TGroupBox
      Left = 661
      Top = 57
      Width = 112
      Height = 37
      TabOrder = 6
      object btnRestaura: TBitBtn
        Left = 3
        Top = 8
        Width = 105
        Height = 25
        Caption = '&RESTAURAR'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnRestauraClick
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333300333300003333333333333333333300003333
          3333333333003333000033033333333333003333000030003333333333300333
          00000F000333333330330033000030F000333333300330030000330F00000007
          3300003300003330F0078887033333330000333300788FF87033333300003333
          0788888F877333330000333308888888F80333330000333307888888F8033333
          00003333078FF8888803333300003333777FF888877333330000333330778888
          7033333300003333330777770333333300003333333700073333333300003333
          33333333333333330000}
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 777
    Top = 264
    Width = 167
    Height = 129
    Caption = 'Controle de Medidas:'
    TabOrder = 2
    object btnNovaMed: TBitBtn
      Left = 32
      Top = 24
      Width = 105
      Height = 25
      Caption = '&Nova Medição'
      TabOrder = 0
      OnClick = btnNovaMedClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    object btnAlteraMed: TBitBtn
      Left = 32
      Top = 56
      Width = 105
      Height = 25
      Caption = '&Altera Medições'
      TabOrder = 1
      OnClick = btnAlteraMedClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object btnExcluiMed: TBitBtn
      Left = 32
      Top = 88
      Width = 105
      Height = 25
      Caption = '&Exclui Medição'
      TabOrder = 2
      OnClick = btnExcluiMedClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333FF3333333333333003333333333333377F33333333333307
        733333FFF333337773333C003333307733333777FF333777FFFFC0CC03330770
        000077777FF377777777C033C03077FFFFF077FF77F777FFFFF7CC00000F7777
        777077777777777777773CCCCC00000000003777777777777777333330030FFF
        FFF03333F77F7F3FF3F7333C0C030F00F0F03337777F7F77373733C03C030FFF
        FFF03377F77F7F3F333733C03C030F0FFFF03377F7737F733FF733C000330FFF
        0000337777F37F3F7777333CCC330F0F0FF0333777337F737F37333333330FFF
        0F03333333337FFF7F7333333333000000333333333377777733}
      NumGlyphs = 2
    end
  end
  object qryMedida: TQuery
    CachedUpdates = True
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'SELECT M.COD_MED,'
      '               M.DATA_MED,'
      '               A.NOME,'
      '               M.PESO,'
      '               M.ABDOMEM,'
      '               M.COXA_D,'
      '               M.COXA_E,'
      '               M.BICEPS_D,'
      '               M.BICEPS_E,'
      '               M.TORAX'
      'FROM '
      '     MEDIDAS M, ALUNO A'
      'WHERE'
      '     M.COD_ALU = A.COD_ALU AND'
      '     M.COD_MED BETWEEN :Cod1 AND :Cod2 AND'
      '     M.DATA_MED BETWEEN :Data1 AND :Data2 AND'
      '     UPPER( A.NOME) LIKE :Nome'
      'ORDER BY DATA_MED, COD_MED')
    UpdateObject = upsMedida
    Left = 384
    Top = 288
    ParamData = <
      item
        DataType = ftInteger
        Name = 'Cod1'
        ParamType = ptUnknown
        Value = '1'
      end
      item
        DataType = ftInteger
        Name = 'Cod2'
        ParamType = ptUnknown
        Value = '100000'
      end
      item
        DataType = ftDateTime
        Name = 'Data1'
        ParamType = ptUnknown
        Value = '01/01/2000'
      end
      item
        DataType = ftDateTime
        Name = 'Data2'
        ParamType = ptUnknown
        Value = '1/1/2030'
      end
      item
        DataType = ftString
        Name = 'Nome'
        ParamType = ptUnknown
        Value = '%'
      end>
    object qryMedidaCOD_MED: TIntegerField
      DisplayLabel = 'Código:'
      DisplayWidth = 8
      FieldName = 'COD_MED'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.COD_MED'
    end
    object qryMedidaDATA_MED: TDateTimeField
      DisplayLabel = 'Dt. Medição:'
      DisplayWidth = 13
      FieldName = 'DATA_MED'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.DATA_MED'
    end
    object qryMedidaNOME: TStringField
      DisplayLabel = 'Aluno:'
      DisplayWidth = 37
      FieldName = 'NOME'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.NOME'
      FixedChar = True
      Size = 70
    end
    object qryMedidaPESO: TStringField
      DisplayLabel = 'Peso:'
      DisplayWidth = 9
      FieldName = 'PESO'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.PESO'
      FixedChar = True
      Size = 10
    end
    object qryMedidaABDOMEM: TStringField
      DisplayLabel = 'Abdomen:'
      DisplayWidth = 12
      FieldName = 'ABDOMEM'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.ABDOMEM'
      FixedChar = True
      Size = 10
    end
    object qryMedidaCOXA_D: TStringField
      DisplayLabel = 'Coxa Direita:'
      DisplayWidth = 13
      FieldName = 'COXA_D'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.COXA_D'
      FixedChar = True
      Size = 10
    end
    object qryMedidaCOXA_E: TStringField
      DisplayLabel = 'Coxa Esquerda:'
      DisplayWidth = 16
      FieldName = 'COXA_E'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.COXA_E'
      FixedChar = True
      Size = 10
    end
    object qryMedidaBICEPS_D: TStringField
      DisplayLabel = 'Biceps Direito:'
      DisplayWidth = 14
      FieldName = 'BICEPS_D'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.BICEPS_D'
      FixedChar = True
      Size = 10
    end
    object qryMedidaBICEPS_E: TStringField
      DisplayLabel = 'Biceps Esquerdo:'
      DisplayWidth = 17
      FieldName = 'BICEPS_E'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.BICEPS_E'
      FixedChar = True
      Size = 10
    end
    object qryMedidaTORAX: TStringField
      DisplayLabel = 'Tórax:'
      DisplayWidth = 11
      FieldName = 'TORAX'
      Origin = 'BANCO DE DADOS ACADEMIA.Medidas.TORAX'
      FixedChar = True
      Size = 10
    end
  end
  object dsMedida: TDataSource
    AutoEdit = False
    DataSet = qryMedida
    Left = 440
    Top = 288
  end
  object PopupMenu1: TPopupMenu
    Images = imgLista
    Left = 568
    Top = 296
    object NovaMedio1: TMenuItem
      Caption = '&Nova Medição'
      ImageIndex = 0
      ShortCut = 16462
      OnClick = NovaMedio1Click
    end
    object AlteraMedidas1: TMenuItem
      Caption = '&Altera Medições'
      ImageIndex = 1
      ShortCut = 16449
      OnClick = AlteraMedidas1Click
    end
    object ExcluiMedio1: TMenuItem
      Caption = '&Exclui Medição'
      ImageIndex = 2
      ShortCut = 16453
      OnClick = ExcluiMedio1Click
    end
  end
  object imgLista: TImageList
    Left = 568
    Top = 344
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      0000E07F000000000000000000000000E07F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000EF3DEF3DEF3D
      E07FE07FEF3DEF3DEF3DEF3DE07FE07F00000000000000000000000000000000
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      000000000000000000000000E07F000000000000000000000000000000000000
      0000FF7FFF7F0000FF7F00000000FF7F00000000000000000000000000000000
      0000000000000000EF3DEF3D0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000EF3D00000000FF0300000000E07FFF7FE07FFF7F
      E07F0000FF7FFF7FFF7FFF7FFF7FFF7F000000001F0000000000000000000000
      000000000000EF3DEF3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000EF3D00000000FF030000E07FFF7FE07FFF7F0000
      00000000FF7FFF7FFF7FFF7F0000FF7F00001F0000001F001F00000000000000
      00000000EF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000EF3D00000000FF030000FF7FE07FFF7FE07FFF7F
      E07FFF7F0000FF7F00000000FF7FFF7F00001F000000000000001F0000000000
      0000EF3DEF3DFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000EF3D00000000FF030000E07FFF7FE07FFF7F0000
      0000000000000000E07F0000FF7FFF7F00001F001F0000000000000000000000
      FF7FEF3DEF3DEF3DEF3DEF3DEF3DEF3D00000000000000000000000000000000
      000000000000000000000000000000000000E07FE07FE07F0000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000E07FE07F0000FF030000FF7FE07FFF7FE07FFF7F
      E07FFF7FE07FFF7F0000FF7FFF7FFF7F000000001F001F001F001F001F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000E07FE07FE07FFF030000E07FFF7F000000000000
      0000000000000000FF7FFF7FFF7FFF7F00000000000000000000000000000000
      00000000FF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7F00000000000000000000000000000000000000000000E07FFF7FE07F0000
      0000E07F0000FF7FFF7F00000000FF7F00000000000000001F0000001F000000
      00000000FF7F00000000FF7F0000FF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7F0000FF7FFF7F000000000000000000000000000000000000000000000000
      E07F0000FF7FFF7FFF7FFF7FFF7FFF7F0000000000001F00000000001F000000
      00000000FF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7F0000FF7F0000E07F0000000000000000000000000000000000000000E07F
      0000FF7FFF7FFF7FFF7F0000000000000000000000001F00000000001F000000
      00000000FF7F0000FF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7F000000000000E07FE07F00000000000000000000000000000000E07F0000
      FF7FFF7F00000000FF7F0000FF7FFF7F0000000000001F000000000000000000
      00000000FF7FFF7FFF7F00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E07F0000000000000000
      00000000000000000000E07FE07F000000000000000000000000E07F00000000
      FF7FFF7FFF7FFF7FFF7F0000FF7F000000000000000000001F001F001F000000
      00000000FF7F0000FF7F0000FF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000E07FE07F0000000000000000
      E07FE07F0000000000000000E07FE07F0000000000000000007C000000000000
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      00000000FF7FFF7FFF7F0000FF7F000000000000000000000000000000000000
      000000000000000000000000000000000000E07F000000000000000000000000
      E07F0000000000000000000000000000E07F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF7EFC00FFFF00009001FC00FFE70000
      C0032000FFC70000E00300008F8F0000E003000007000000E003000032000000
      E003000000000000000100008000000080000000F9000000E0070000E1000000
      E00FE000C9000000E00FF800C9000000E027F000C3000000C073E001E3000000
      9E79C403FF0100007EFEEC07FF03000000000000000000000000000000000000
      000000000000}
  end
  object qryNome: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'SELECT *'
      'FROM ALUNO'
      'ORDER BY NOME')
    Left = 384
    Top = 344
  end
  object dsNome: TDataSource
    AutoEdit = False
    DataSet = qryNome
    Left = 440
    Top = 344
  end
  object upsMedida: TUpdateSQL
    ModifySQL.Strings = (
      'update MEDIDAS'
      'set'
      '  COD_MED = :COD_MED,'
      '  DATA_MED = :DATA_MED,'
      '  PESO = :PESO,'
      '  ABDOMEM = :ABDOMEM,'
      '  COXA_D = :COXA_D,'
      '  COXA_E = :COXA_E,'
      '  BICEPS_D = :BICEPS_D,'
      '  BICEPS_E = :BICEPS_E,'
      '  TORAX = :TORAX'
      'where'
      '  COD_MED = :OLD_COD_MED')
    InsertSQL.Strings = (
      'insert into MEDIDAS'
      
        '  (COD_MED, DATA_MED, PESO, ABDOMEM, COXA_D, COXA_E, BICEPS_D, B' +
        'ICEPS_E, '
      '   TORAX)'
      'values'
      
        '  (:COD_MED, :DATA_MED, :PESO, :ABDOMEM, :COXA_D, :COXA_E, :BICE' +
        'PS_D, :BICEPS_E, '
      '   :TORAX)')
    DeleteSQL.Strings = (
      'delete from MEDIDAS'
      'where'
      '  COD_MED = :OLD_COD_MED')
    Left = 496
    Top = 288
  end
end
