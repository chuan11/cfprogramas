object fmDestEmail: TfmDestEmail
  Left = 455
  Top = 225
  Width = 519
  Height = 374
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Informar o email de destino'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbEmail: TLabel
    Left = 12
    Top = 319
    Width = 27
    Height = 13
    Caption = 'email '
    Visible = False
  end
  object rg: TRadioGroup
    Left = 8
    Top = 8
    Width = 489
    Height = 81
    Caption = ' Selecione o destino: '
    ItemIndex = 0
    Items.Strings = (
      'E-mail de uma loja:'
      'Outro e-mail:')
    TabOrder = 0
    OnClick = rgClick
  end
  object cbLoja: TadLabelComboBox
    Left = 140
    Top = 27
    Width = 179
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
    LabelDefs.Width = 244
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Escolha o pre'#231'o base dos produtos para a proposta'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edMail: TadLabelEdit
    Left = 140
    Top = 58
    Width = 347
    Height = 19
    LabelDefs.Width = 34
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nome: '
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = []
    LabelDefs.ParentFont = False
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecLowerCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object pnConfirma: TPanel
    Left = 329
    Top = 299
    Width = 169
    Height = 29
    BevelOuter = bvNone
    TabOrder = 3
    object btOk: TFlatButton
      Left = 19
      Top = 1
      Width = 71
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
      TabOrder = 0
      ModalResult = 1
      OnClick = btOkClick
    end
    object FlatButton1: TFlatButton
      Left = 96
      Top = 1
      Width = 71
      Height = 26
      Caption = 'Cancela'
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
      TabOrder = 1
      ModalResult = 2
    end
  end
  object mmCorpoEmail: TadLabelMemo
    Left = 9
    Top = 114
    Width = 485
    Height = 176
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    LabelDefs.Width = 97
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Mensagem do email:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
end
