object fmLogin: TfmLogin
  Left = 768
  Top = 522
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 179
  ClientWidth = 449
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbErroDeLogin: TLabel
    Left = 259
    Top = 132
    Width = 67
    Height = 13
    Caption = 'lbErroDeLogin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Image1: TImage
    Left = 1
    Top = 2
    Width = 255
    Height = 175
    Stretch = True
    Transparent = True
  end
  object btOk: TfsBitBtn
    Left = 282
    Top = 149
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btOkClick
    Kind = bkOK
  end
  object fsBitBtn2: TfsBitBtn
    Left = 368
    Top = 149
    Width = 74
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = fsBitBtn2Click
    Kind = bkCancel
  end
  object cbLoja: TadLabelComboBox
    Left = 268
    Top = 22
    Width = 173
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Color = clInfoBk
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 2
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbUser: TadLabelComboBox
    Left = 268
    Top = 63
    Width = 174
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Color = clInfoBk
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 3
    OnEnter = cbUserEnter
    LabelDefs.Width = 39
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Usu'#225'rio:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edSenha: TadLabelEdit
    Left = 268
    Top = 104
    Width = 174
    Height = 19
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Senha'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    Color = clInfoBk
    MaxLength = 6
    TabOrder = 4
  end
end
