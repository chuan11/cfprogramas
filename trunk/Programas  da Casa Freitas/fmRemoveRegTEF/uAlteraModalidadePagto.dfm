object fmAlteraModPagto: TfmAlteraModPagto
  Left = 619
  Top = 415
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Valores da nova modalidade de pagamento'
  ClientHeight = 98
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edValor: TadLabelNumericEdit
    Left = 8
    Top = 23
    Width = 107
    Height = 19
    LabelDefs.Width = 24
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Valor'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Decimals = -1
    Format = nfStandard
    TabOrder = 0
  end
  object cbModalidades: TadLabelComboBox
    Left = 129
    Top = 22
    Width = 162
    Height = 21
    AutoDropDown = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    LabelDefs.Width = 84
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nova Modalidade'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edNumParcelas: TadLabelSpinEdit
    Left = 306
    Top = 21
    Width = 57
    Height = 22
    Cursor = crDefault
    LabelDefs.Width = 41
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Parcelas'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Decimals = 0
    TabOrder = 2
    Increment = 1.000000000000000000
    RoundValues = False
    Wrap = False
  end
  object btOk: TFlatButton
    Left = 296
    Top = 62
    Width = 66
    Height = 26
    Caption = '&OK'
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
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btOkClick
  end
end
