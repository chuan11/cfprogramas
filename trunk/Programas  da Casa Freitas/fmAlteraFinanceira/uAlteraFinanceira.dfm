object fmAlteraFiananceira: TfmAlteraFiananceira
  Left = 285
  Top = 305
  Width = 820
  Height = 394
  Caption = 'fmAlteraFiananceira'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 60
    Width = 52
    Height = 13
    Caption = 'Financeira:'
  end
  object lbFinanceira: TLabel
    Left = 74
    Top = 62
    Width = 9
    Height = 13
    Caption = ' - '
  end
  object edCodigo: TadLabelEdit
    Left = 5
    Top = 27
    Width = 153
    Height = 19
    LabelDefs.Width = 108
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do documento'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    OnKeyDown = edCodigoKeyDown
  end
  object cbOrigem: TadLabelComboBox
    Left = 196
    Top = 27
    Width = 170
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
    TabOrder = 1
    Text = '4 - BNB PFM '
    Items.Strings = (
      '4 - BNB PFM '
      '5 - BNB CF')
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nova financeira'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton1: TFlatButton
    Left = 389
    Top = 26
    Width = 32
    Height = 25
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333330000003333333333333333330000003333344333333333330000003333
      4224333333333300000033342222433333333300000033422222243333333300
      000034222A2222433333330000003222A3A222433333330000003A2A333A2224
      33333300000033A33333A222433333000000333333333A222433330000003333
      333333A222433300000033333333333A222433000000333333333333A2224300
      00003333333333333A224300000033333333333333A223000000333333333333
      333A33000000333333333333333333000000}
    TabOrder = 2
    OnClick = FlatButton1Click
  end
end
