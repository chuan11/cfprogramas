object fmMain: TfmMain
  Left = 390
  Top = 221
  Width = 800
  Height = 532
  Caption = 'Rela'#231#227'o de produtos..'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    784
    474)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 3
    Top = 136
    Width = 777
    Height = 337
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Itens '
    TabOrder = 0
    DesignSize = (
      777
      337)
    object grid: TSoftDBGrid
      Left = 5
      Top = 14
      Width = 766
      Height = 321
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsItens
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnColExit = gridColExit
      OnDblClick = gridDblClick
      OnTitleClick = gridTitleClick
      AlternateColor = True
      ColorLow = clInfoBk
      ColorHigh = clInfoBk
    end
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 5
    Width = 777
    Height = 128
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Lista de promo'#231#227'o '
    TabOrder = 1
    DesignSize = (
      777
      128)
    object gridC: TSoftDBGrid
      Left = 5
      Top = 13
      Width = 766
      Height = 109
      Anchors = [akLeft, akTop, akRight]
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnColExit = gridColExit
      OnDblClick = gridCDblClick
      AlternateColor = True
      ColorLow = clInfoBk
      ColorHigh = clInfoBk
    end
  end
  object conn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnWillExecute = connWillExecute
    Left = 168
    Top = 168
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 168
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      OnClick = Cadastro1Click
    end
    object Imprimir1: TMenuItem
      Caption = 'Imprimir'
      OnClick = Imprimir1Click
    end
    object Importardeumpedido1: TMenuItem
      Caption = 'Importar de um pedido'
      OnClick = Importardeumpedido1Click
    end
  end
  object tbItens: TADOTable
    Connection = conn
    CursorType = ctStatic
    AfterPost = tbItensAfterPost
    OnNewRecord = tbItensNewRecord
    TableName = 'zcf_itensPromocao'
    Left = 31
    Top = 232
    object tbItensis_ref: TIntegerField
      DisplayWidth = 15
      FieldName = 'is_ref'
    end
    object tbItenscd_ref: TStringField
      DisplayWidth = 12
      FieldName = 'cd_ref'
      Size = 8
    end
    object tbItensds_ref: TStringField
      DisplayWidth = 16
      FieldName = 'ds_ref'
      Size = 50
    end
    object tbItensean: TStringField
      DisplayWidth = 19
      FieldName = 'ean'
      Size = 13
    end
    object tbItensqt_emb: TIntegerField
      FieldName = 'qt_emb'
    end
    object tbItensobs: TStringField
      DisplayWidth = 10
      FieldName = 'obs'
      Size = 50
    end
    object tbItenspreco: TBCDField
      DisplayWidth = 9
      FieldName = 'preco'
      DisplayFormat = '###,###0.00'
      Precision = 19
    end
    object tbItensnum: TIntegerField
      FieldName = 'num'
    end
    object tbItensseq2: TAutoIncField
      FieldName = 'seq'
      ReadOnly = True
    end
    object tbItensseq22: TStringField
      FieldName = 'seq2'
      Size = 8
    end
  end
  object dsItens: TDataSource
    DataSet = tbItens
    Left = 33
    Top = 200
  end
  object qr: TADOQuery
    Connection = conn
    CursorType = ctStatic
    Parameters = <>
    Left = 32
    Top = 296
    object qrseq: TAutoIncField
      FieldName = 'seq2'
      ReadOnly = True
    end
    object qris_ref: TIntegerField
      FieldName = 'is_ref'
    end
    object qrcd_ref: TStringField
      FieldName = 'cd_ref'
      Size = 8
    end
    object qrds_ref: TStringField
      FieldName = 'ds_ref'
      Size = 50
    end
    object qrean: TStringField
      FieldName = 'ean'
      Size = 13
    end
    object qrqt_emb: TIntegerField
      FieldName = 'qt_emb'
    end
    object qrobs: TStringField
      FieldName = 'obs'
      Size = 50
    end
    object qrpreco: TBCDField
      FieldName = 'preco'
      DisplayFormat = '###,###0.00'
      Precision = 19
    end
    object qrnum: TIntegerField
      FieldName = 'num'
    end
    object qrimagem: TBlobField
      FieldName = 'imagem'
    end
  end
  object rvcImagens: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = qr
    Left = 328
    Top = 160
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\ProgramasDiversos\RelatoriosPCF.rav'
    Left = 360
    Top = 160
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 392
    Top = 160
  end
  object tbPromocao: TADOTable
    Connection = conn
    CursorType = ctStatic
    TableName = 'zcf_itenspromocaoC'
    Left = 95
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = tbPromocao
    Left = 137
    Top = 24
  end
  object rcvPromocao: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = tbPromocao
    Left = 328
    Top = 192
  end
end
