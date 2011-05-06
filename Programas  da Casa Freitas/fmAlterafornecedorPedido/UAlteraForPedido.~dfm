object fmAlteraPedForn: TfmAlteraPedForn
  Left = 407
  Top = 302
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsNone
  Caption = 'Altera loja do pedido de compra'
  ClientHeight = 199
  ClientWidth = 716
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
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FlatButton1: TFlatButton
    Left = 155
    Top = 16
    Width = 95
    Height = 21
    Caption = '&Localizar'
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object Edit1: TadLabelEdit
    Left = 4
    Top = 17
    Width = 145
    Height = 19
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pedido:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object DBGrid: TSoftDBGrid
    Left = 4
    Top = 41
    Width = 693
    Height = 56
    Ctl3D = False
    DataSource = DataSource1
    Enabled = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 116
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    Enabled = False
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 3
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton2: TFlatButton
    Left = 492
    Top = 118
    Width = 95
    Height = 21
    Caption = '&Alterar'
    TabOrder = 4
    OnClick = FlatButton2Click
  end
  object Query1: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      'tbuo.ds_uo, dspes.nm_pes, dspdf.vl_total from dspdf'
      'inner join tbuo  on dspdf.is_uoCompra = tbuo.is_uo'
      'inner join dspes on dspdf.cd_pes = dspes.cd_pes'
      'where dspdf.is_pedf = 000')
    Left = 216
    Top = 48
    object Query1ds_uo: TStringField
      DisplayLabel = 'Loja'
      DisplayWidth = 34
      FieldName = 'ds_uo'
      Size = 50
    end
    object Query1nm_pes: TStringField
      DisplayLabel = 'Fornecedor'
      DisplayWidth = 34
      FieldName = 'nm_pes'
      Size = 60
    end
    object Query1vl_total: TBCDField
      DisplayLabel = 'Total'
      DisplayWidth = 23
      FieldName = 'vl_total'
      DisplayFormat = '#,###,###0.00'
      Precision = 12
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 273
    Top = 56
  end
end
