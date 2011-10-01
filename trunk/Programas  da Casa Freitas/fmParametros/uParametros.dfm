object fmParametros: TfmParametros
  Left = 346
  Top = 278
  Width = 921
  Height = 481
  Caption = 'Par'#226'metros da do programa'
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
  DesignSize = (
    905
    443)
  PixelsPerInch = 96
  TextHeight = 13
  object gdParam: TSoftDBGrid
    Left = 3
    Top = 56
    Width = 654
    Height = 307
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gdParamDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = 15790322
  end
  object cbParametros: TadLabelComboBox
    Left = 3
    Top = 25
    Width = 526
    Height = 24
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
    OnChange = cbParametrosChange
    Items.Strings = (
      '<Todos >')
    LabelDefs.Width = 46
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Filtrar por:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btIncluiXML: TfsBitBtn
    Left = 538
    Top = 27
    Width = 28
    Height = 20
    Default = True
    TabOrder = 2
    OnClick = btIncluiXMLClick
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
  object tbParam: TADOTable
    Connection = fmMain.Conexao
    Left = 56
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = tbParam
    Left = 96
    Top = 96
  end
end
