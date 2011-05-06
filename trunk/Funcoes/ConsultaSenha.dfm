object FmSenha: TFmSenha
  Left = 654
  Top = 359
  Width = 236
  Height = 250
  BorderIcons = [biSystemMenu]
  Caption = 'Autoriza'#231#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbMsg: TLabel
    Left = 4
    Top = 5
    Width = 214
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'lbMsg'
    Visible = False
  end
  object lbMsgTelaSimples: TLabel
    Left = 13
    Top = 44
    Width = 9
    Height = 13
    Caption = '-- '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object FlatButton1: TFlatButton
    Left = 51
    Top = 178
    Width = 75
    Height = 25
    Caption = '&Ok'
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
    TabStop = True
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 131
    Top = 178
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabStop = True
    TabOrder = 5
    ModalResult = 2
    OnClick = FlatButton2Click
  end
  object edit: TadLabelEdit
    Left = 11
    Top = 102
    Width = 194
    Height = 19
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Senha'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 2
    OnKeyDown = editKeyDown
  end
  object cbUsuarios: TadLabelComboBox
    Left = 11
    Top = 61
    Width = 194
    Height = 21
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 1
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Usu'#225'rio'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbLoja: TadLabelComboBox
    Left = 11
    Top = 21
    Width = 194
    Height = 21
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
    OnChange = cbLojaChange
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbJustificativa: TadLabelComboBox
    Left = 10
    Top = 140
    Width = 196
    Height = 21
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 3
    LabelDefs.Width = 55
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Justificativa'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Conexao: TADOConnection
    LoginPrompt = False
    Left = 16
    Top = 176
  end
end
