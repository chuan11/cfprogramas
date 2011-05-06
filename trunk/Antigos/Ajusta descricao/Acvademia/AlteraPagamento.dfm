object frmAlteraPagamento: TfrmAlteraPagamento
  Left = 282
  Top = 349
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Alterando pagamento de mensalidade'
  ClientHeight = 127
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    000B3B3B3B33330000BB3B3000000000B3B3B3B3333333030BB3303300000003
    3330000000000030BB0B3B3330000003333B8B8383333033BBBB333330000000
    3333333333330B3B3BB33B3B3B0000000B3B3B3333330B3B33B3BBB3330000B3
    B3B3B3B333330B3B333BBB333B0003333000000000000B3B33BBBBB3B3000300
    000B3B3B33330B3B333BB0B33B000030B3B3B3B3B3330B3B333BBBB3B3000303
    3333333333330B33333BBB3B3B000003000B888383830BB33333333BB0000000
    33330000000000B33B3333BB300000033000B3B3B3B3B0BB33330BBB00000000
    0B3B3B3B3B3B3B0BB33B3BB00000000033333333333333300B33330000000000
    3000BBB838383830003000000000000003333380000000000000000000000000
    3338000B3B3B3B3B3B000000000000000330B3B3B3B3B3B3B3B3300000000000
    0003333FFFFFF33333333300000000000003088BBBB3B3B3B300030000000000
    000033333BBBBB3B3B33300000000000000333B3B3BBBBB3B3B3330000000000
    0000333B3BBBBBBB333330000000000000000003B3B3BFFFFB00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFE003C1FF000000FE0000007C0000003C0000003C0000001C00000018000
    00010000000100000001000000010000000180000003C0000003C0000007E000
    000FE000001FE00000FFE00000FFE000007FF000003FF800001FFC00001FFC00
    001FFC00001FFE00003FFF00007FFFE003FFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 208
    Top = 72
    Width = 71
    Height = 13
    Caption = 'Vencimento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 208
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Pagamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 67
    Height = 13
    Caption = 'Valor Pago:'
    FocusControl = DBEdit1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 48
    Width = 59
    Height = 13
    Caption = 'Desconto:'
    FocusControl = DBEdit2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 76
    Height = 13
    Caption = 'Mensalidade:'
    FocusControl = DBEdit3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnConfirma: TBitBtn
    Left = 400
    Top = 32
    Width = 75
    Height = 25
    Caption = '&Confirma'
    TabOrder = 0
    OnClick = btnConfirmaClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancela: TBitBtn
    Left = 400
    Top = 64
    Width = 75
    Height = 25
    Caption = '&Cancela'
    TabOrder = 1
    OnClick = btnCancelaClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333333333333333333FFF33FF333FFF339993370733
      999333777FF37FF377733339993000399933333777F777F77733333399970799
      93333333777F7377733333333999399933333333377737773333333333990993
      3333333333737F73333333333331013333333333333777FF3333333333910193
      333333333337773FF3333333399000993333333337377737FF33333399900099
      93333333773777377FF333399930003999333337773777F777FF339993370733
      9993337773337333777333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object dtpVenc: TDateTimePicker
    Left = 208
    Top = 96
    Width = 89
    Height = 21
    CalAlignment = dtaLeft
    Date = 36944
    Time = 36944
    DateFormat = dfShort
    DateMode = dmComboBox
    Enabled = False
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object dtpPagto: TDateTimePicker
    Left = 208
    Top = 32
    Width = 89
    Height = 21
    CalAlignment = dtaLeft
    Date = 36944
    Time = 36944
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 104
    Width = 113
    Height = 21
    DataField = 'VLR_TOTAL'
    DataSource = dsPagtos
    Enabled = False
    TabOrder = 4
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 64
    Width = 97
    Height = 21
    Color = clSilver
    DataField = 'DESCONTO'
    DataSource = dsPagtos
    Enabled = False
    TabOrder = 5
    OnExit = DBEdit2Exit
    OnKeyPress = DBEdit2KeyPress
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 24
    Width = 113
    Height = 21
    DataField = 'MENSALIDADE'
    DataSource = dsPagtos
    Enabled = False
    TabOrder = 6
  end
  object btnDesconto: TButton
    Left = 104
    Top = 64
    Width = 21
    Height = 19
    Caption = '...'
    TabOrder = 7
    OnClick = btnDescontoClick
  end
  object qryPagtos: TQuery
    CachedUpdates = True
    DatabaseName = 'Banco de Dados Academia'
    DataSource = frmPagamento.dsPagtos
    SQL.Strings = (
      'SELECT *'
      'FROM'
      ' PAGAMENTO'
      'WHERE'
      '  COD_PAG = :COD_PAG')
    UpdateObject = upsPagtos
    Left = 312
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'COD_PAG'
        ParamType = ptUnknown
      end>
    object qryPagtosCOD_PAG: TIntegerField
      FieldName = 'COD_PAG'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.COD_PAG'
    end
    object qryPagtosCOD_ALU: TIntegerField
      FieldName = 'COD_ALU'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.COD_ALU'
    end
    object qryPagtosDATA_PAG: TDateTimeField
      FieldName = 'DATA_PAG'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DATA_PAG'
    end
    object qryPagtosDATA_VENC: TDateTimeField
      FieldName = 'DATA_VENC'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DATA_VENC'
    end
    object qryPagtosDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.DESCONTO'
      DisplayFormat = 'R$ #,##0.00'
    end
    object qryPagtosVLR_TOTAL: TFloatField
      FieldName = 'VLR_TOTAL'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.VLR_TOTAL'
      DisplayFormat = 'R$ #,##0.00'
    end
    object qryPagtosMENSALIDADE: TFloatField
      FieldName = 'MENSALIDADE'
      Origin = 'BANCO DE DADOS ACADEMIA.Pagamento.Mensalidade'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dsPagtos: TDataSource
    AutoEdit = False
    DataSet = qryPagtos
    Left = 360
    Top = 8
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
      
        '  (COD_PAG, DATA_PAG, COD_ALU, DATA_VENC, VLR_TOTAL, DESCONTO, M' +
        'ENSALIDADE)'
      'values'
      
        '  (:COD_PAG, :DATA_PAG, :COD_ALU, :DATA_VENC, :VLR_TOTAL, :DESCO' +
        'NTO, :MENSALIDADE)')
    DeleteSQL.Strings = (
      'delete from PAGAMENTO'
      'where'
      '  COD_PAG = :OLD_COD_PAG')
    Left = 336
    Top = 56
  end
end
