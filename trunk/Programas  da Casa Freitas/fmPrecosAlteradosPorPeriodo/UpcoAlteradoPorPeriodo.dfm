object fmPrecosAlterados: TfmPrecosAlterados
  Left = 567
  Top = 404
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '(02) Relat'#243'rio e pre'#231'os alterados por data.'
  ClientHeight = 129
  ClientWidth = 517
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
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 385
    Top = 3
    Width = 71
    Height = 13
    Caption = 'Data Altera'#231#227'o'
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 19
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
  object cbPreco: TadLabelComboBox
    Left = 180
    Top = 19
    Width = 193
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
    LabelDefs.Width = 83
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o a consultar'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton1: TFlatButton
    Left = 407
    Top = 48
    Width = 105
    Height = 31
    Caption = '&Gerar'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object dp1: TfsDateTimePicker
    Left = 386
    Top = 19
    Width = 129
    Height = 21
    Date = 39637.445514861110000000
    Time = 39637.445514861110000000
    TabOrder = 3
  end
  object qr: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        ' Exec stoListarPrecosAlteradosPeriodo '#39'10/04/2007'#39', '#39'10/04/2007'#39 +
        ', 10033586, 101, '#39#39', '#39#39', 10032378')
    Left = 16
    Top = 56
  end
end
