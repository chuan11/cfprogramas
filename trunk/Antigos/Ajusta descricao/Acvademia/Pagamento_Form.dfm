object frmPagamento: TfrmPagamento
  Left = 210
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Pagamentos de Mensalidades'
  ClientHeight = 330
  ClientWidth = 626
  Color = clSilver
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
    Top = 65
    Width = 626
    Height = 265
    Align = alBottom
    DataSource = dsPagtos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_VENC'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PAG'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 288
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MENSALIDADE'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLR_TOTAL'
        Width = 75
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 7
    Width = 473
    Height = 49
    Caption = 'Selecione o Aluno desejado :'
    Color = clSilver
    ParentColor = False
    TabOrder = 1
    object DBEdit1: TDBEdit
      Left = 8
      Top = 16
      Width = 41
      Height = 21
      DataField = 'COD_ALU'
      DataSource = dsAlunos
      Enabled = False
      TabOrder = 0
    end
    object dblcAluno: TDBLookupComboBox
      Left = 48
      Top = 16
      Width = 417
      Height = 21
      KeyField = 'COD_ALU'
      ListField = 'NOME'
      ListSource = dsAlunos
      TabOrder = 1
      OnKeyDown = dblcAlunoKeyDown
    end
  end
  object GroupBox2: TGroupBox
    Left = 471
    Top = 7
    Width = 155
    Height = 49
    TabOrder = 2
    object btnNovoPagto: TBitBtn
      Left = 19
      Top = 15
      Width = 121
      Height = 25
      Caption = '&Novo Pagamento'
      TabOrder = 0
      OnClick = btnNovoPagtoClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object qryPagtos: TQuery
    CachedUpdates = True
    DatabaseName = 'Banco de Dados Academia'
    DataSource = dsAlunos
    SQL.Strings = (
      'SELECT P.* ,'
      '               A.NOME'
      'FROM PAGAMENTO P,  ALUNO A'
      'WHERE'
      ' P.COD_ALU = :COD_ALU AND'
      ' P.COD_ALU = A.COD_ALU')
    UpdateObject = upsPagtos
    Left = 448
    Top = 184
    ParamData = <
      item
        DataType = ftInteger
        Name = 'COD_ALU'
        ParamType = ptUnknown
      end>
    object qryPagtosCOD_PAG: TIntegerField
      DisplayLabel = 'Pagamento:'
      DisplayWidth = 11
      FieldName = 'COD_PAG'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.COD_PAG'
    end
    object qryPagtosDATA_VENC: TDateTimeField
      DisplayLabel = 'Vencimento:'
      DisplayWidth = 13
      FieldName = 'DATA_VENC'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DATA_VENC'
    end
    object qryPagtosDATA_PAG: TDateTimeField
      DisplayLabel = 'Pago em:'
      DisplayWidth = 13
      FieldName = 'DATA_PAG'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DATA_PAG'
    end
    object qryPagtosNOME: TStringField
      DisplayLabel = 'Nome:'
      DisplayWidth = 64
      FieldName = 'NOME'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.NOME'
      FixedChar = True
      Size = 70
    end
    object qryPagtosDESCONTO: TFloatField
      DisplayLabel = 'Desconto:'
      DisplayWidth = 15
      FieldName = 'DESCONTO'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DESCONTO'
      DisplayFormat = 'R$ #,##0.00'
    end
    object qryPagtosVLR_TOTAL: TFloatField
      DisplayLabel = 'Total Pago:'
      DisplayWidth = 16
      FieldName = 'VLR_TOTAL'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.VLR_TOTAL'
      DisplayFormat = 'R$ #,##0.00'
    end
    object qryPagtosMENSALIDADE: TFloatField
      DisplayLabel = 'Mensalidade:'
      FieldName = 'MENSALIDADE'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.Mensalidade'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dsPagtos: TDataSource
    AutoEdit = False
    DataSet = qryPagtos
    Left = 512
    Top = 184
  end
  object qryAlunos: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select * '
      'from Aluno'
      'Order By Nome')
    Left = 448
    Top = 136
    object qryAlunosCOD_ALU: TIntegerField
      DisplayLabel = 'Aluno:'
      FieldName = 'COD_ALU'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_ALU'
    end
    object qryAlunosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.NOME'
      FixedChar = True
      Size = 70
    end
    object qryAlunosENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.ENDERECO'
      FixedChar = True
      Size = 70
    end
    object qryAlunosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.BAIRRO'
      FixedChar = True
    end
    object qryAlunosCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CIDADE'
      FixedChar = True
    end
    object qryAlunosESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.ESTADO'
      FixedChar = True
      Size = 2
    end
    object qryAlunosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.TELEFONE'
      FixedChar = True
      Size = 15
    end
    object qryAlunosCEP: TStringField
      FieldName = 'CEP'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CEP'
      FixedChar = True
      Size = 10
    end
    object qryAlunosRG: TStringField
      FieldName = 'RG'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.RG'
      FixedChar = True
      Size = 15
    end
    object qryAlunosCPF: TStringField
      FieldName = 'CPF'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CPF'
      FixedChar = True
      Size = 15
    end
    object qryAlunosDATA_NASC: TDateTimeField
      FieldName = 'DATA_NASC'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_NASC'
    end
    object qryAlunosDATA_CAD: TDateTimeField
      FieldName = 'DATA_CAD'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_CAD'
    end
    object qryAlunosOBS: TMemoField
      FieldName = 'OBS'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.OBS'
      BlobType = ftMemo
    end
    object qryAlunosCOD_MOD1: TIntegerField
      FieldName = 'COD_MOD1'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD1'
    end
    object qryAlunosCOD_MOD2: TIntegerField
      FieldName = 'COD_MOD2'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD2'
    end
    object qryAlunosCOD_MOD3: TIntegerField
      FieldName = 'COD_MOD3'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD3'
    end
    object qryAlunosCOD_MOD4: TIntegerField
      FieldName = 'COD_MOD4'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD4'
    end
    object qryAlunosCOD_MOD5: TIntegerField
      FieldName = 'COD_MOD5'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD5'
    end
    object qryAlunosCOD_MOD6: TIntegerField
      FieldName = 'COD_MOD6'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD6'
    end
    object qryAlunosDATA_VENC: TDateTimeField
      FieldName = 'DATA_VENC'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_VENC'
    end
  end
  object dsAlunos: TDataSource
    AutoEdit = False
    DataSet = qryAlunos
    Left = 512
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    Images = imgLista
    Left = 168
    Top = 192
    object AlteraPagamento1: TMenuItem
      Caption = '&Altera Pagamento'
      ImageIndex = 1
      ShortCut = 16449
      OnClick = AlteraPagamento1Click
    end
    object ExcluiPagamento1: TMenuItem
      Caption = '&Exclui Pagamento'
      ImageIndex = 0
      ShortCut = 16453
      OnClick = ExcluiPagamento1Click
    end
  end
  object imgLista: TImageList
    Left = 232
    Top = 192
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000EF3DEF3D0000000000000000000000000000000000000000
      0000FF7FFF7F0000FF7F00000000FF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F0000000000000000000000
      000000000000EF3DEF3D0000000000000000FF0300000000E07FFF7FE07FFF7F
      E07F0000FF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F0000001F001F00000000000000
      00000000EF3DEF3D00000000000000000000FF030000E07FFF7FE07FFF7F0000
      00000000FF7FFF7FFF7FFF7F0000FF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F000000000000001F0000000000
      0000EF3DEF3DFF7FFF7FFF7FFF7FFF7F0000FF030000FF7FE07FFF7FE07FFF7F
      E07FFF7F0000FF7F00000000FF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F001F0000000000000000000000
      FF7FEF3DEF3DEF3DEF3DEF3DEF3DEF3D0000FF030000E07FFF7FE07FFF7F0000
      0000000000000000E07F0000FF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F001F001F001F001F000000
      000000000000000000000000000000000000FF030000FF7FE07FFF7FE07FFF7F
      E07FFF7FE07FFF7F0000FF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF7FFF7FFF7FFF7FFF7FFF7F0000FF030000E07FFF7F000000000000
      0000000000000000FF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F0000001F000000
      00000000FF7F00000000FF7F0000FF7F0000000000000000E07FFF7FE07F0000
      0000E07F0000FF7FFF7F00000000FF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F00000000001F000000
      00000000FF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      E07F0000FF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F00000000001F000000
      00000000FF7F0000FF7FFF7FFF7FFF7F0000000000000000000000000000E07F
      0000FF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F000000000000000000
      00000000FF7FFF7FFF7F000000000000000000000000000000000000E07F0000
      FF7FFF7F00000000FF7F0000FF7FFF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F001F001F000000
      00000000FF7F0000FF7F0000FF7FFF7F00000000000000000000E07F00000000
      FF7FFF7FFF7FFF7FFF7F0000FF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF7FFF7FFF7F0000FF7F00000000000000000000007C000000000000
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFC0000000000FFE7FC0000000000
      FFC72000000000008F8F00000000000007000000000000003200000000000000
      00000000000000008000000000000000F900000000000000E100000000000000
      C900E00000000000C900F80000000000C300F00000000000E300E00100000000
      FF01C40300000000FF03EC070000000000000000000000000000000000000000
      000000000000}
  end
  object upsPagtos: TUpdateSQL
    ModifySQL.Strings = (
      'update PAGAMENTO'
      'set'
      '  COD_PAG = :COD_PAG,'
      '  DATA_PAG = :DATA_PAG,'
      '  COD_ALU = :COD_ALU,'
      '  DATA_VENC = :DATA_VENC,'
      '  VLR_TOTAL = :VLR_TOTAL,'
      '  DESCONTO = :DESCONTO,'
      '  MENSALIDADE = :MENSALIDADE'
      'where'
      '  COD_PAG = :OLD_COD_PAG')
    InsertSQL.Strings = (
      'insert into PAGAMENTO'
      '  (COD_PAG, DATA_PAG, COD_ALU, DATA_VENC, VLR_TOTAL, DESCONTO, '
      'MENSALIDADE)'
      'values'
      
        '  (:COD_PAG, :DATA_PAG, :COD_ALU, :DATA_VENC, :VLR_TOTAL, :DESCO' +
        'NTO, '
      ':MENSALIDADE)')
    DeleteSQL.Strings = (
      'delete from PAGAMENTO'
      'where'
      '  COD_PAG = :OLD_COD_PAG')
    Left = 576
    Top = 184
  end
end
