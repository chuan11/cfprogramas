object fmRemRegTEF: TfmRemRegTEF
  Left = 477
  Top = 259
  Width = 800
  Height = 480
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Liberar cart'#227'o para cancelamento'
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
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    784
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 193
    Top = 6
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 22
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
    TabOrder = 0
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object grid: TSoftDBGrid
    Left = 5
    Top = 81
    Width = 647
    Height = 282
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clHighlightText
  end
  object btConsulta: TFlatButton
    Left = 298
    Top = 18
    Width = 43
    Height = 25
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
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btConsultaClick
  end
  object dt: TfsDateTimePicker
    Left = 193
    Top = 20
    Width = 95
    Height = 22
    Date = 39906.649664583330000000
    Time = 39906.649664583330000000
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 368
    Top = 7
    Width = 409
    Height = 60
    Caption = ' Filtros '
    TabOrder = 4
    object cbModalidade: TadLabelComboBox
      Left = 144
      Top = 32
      Width = 129
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 0
      OnChange = cbCaixasChange
      LabelDefs.Width = 58
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Modalidade:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbCaixas: TadLabelComboBox
      Left = 5
      Top = 32
      Width = 129
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
      OnChange = cbCaixasChange
      LabelDefs.Width = 29
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Caixa:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edBusca: TadLabelNumericEdit
      Left = 283
      Top = 32
      Width = 81
      Height = 19
      LabelDefs.Width = 30
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor: '
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      OnKeyDown = edBuscaKeyDown
      TabOrder = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 136
    Top = 208
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 174
    Top = 208
    object tbcodLoja: TIntegerField
      FieldName = 'codLoja'
    end
    object tbdescEstacao: TStringField
      FieldName = 'descEstacao'
    end
    object tbcd_mve: TIntegerField
      FieldName = 'cd_mve'
    end
    object tbds_mve: TStringField
      FieldName = 'ds_mve'
      Size = 30
    end
    object tbdataSessaoCaixa: TDateTimeField
      FieldName = 'dataSessaoCaixa'
    end
    object tbseqtransacaoCaixa: TIntegerField
      FieldName = 'seqtransacaoCaixa'
    end
    object tbseqModPagtoPorTransCaixa: TIntegerField
      FieldName = 'seqModPagtoPorTransCaixa'
    end
    object tbValor: TBCDField
      FieldName = 'Valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbnumParcelas: TStringField
      FieldName = 'numParcelas'
      Size = 3
    end
    object tbtefMagnetico: TStringField
      FieldName = 'tefMagnetico'
      Size = 1
    end
    object tbseqTefTransCaixa: TIntegerField
      FieldName = 'seqTefTransCaixa'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 215
    Top = 209
    object Alteramodalidadedepagamento1: TMenuItem
      Caption = 'Altera modalidade de pagamento'
      OnClick = Alteramodalidadedepagamento1Click
    end
    object Inseremodalidadepagamento1: TMenuItem
      Caption = 'Insere modalidade pagamento'
      OnClick = chamaInsereModalidadePagamento1Click
    end
    object RemoveregistrodeTEF1: TMenuItem
      Caption = 'Remove registro de TEF'
      OnClick = chamaRemoveRegistroDeTEF1Click
    end
    object RemoveModalidaDedePagamento1: TMenuItem
      Caption = 'Remove modalidade de pagamento'
      OnClick = RemoveModalidaDedePagamento1Click
    end
  end
end
