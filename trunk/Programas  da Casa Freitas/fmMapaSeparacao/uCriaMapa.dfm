object fmCriarMapa: TfmCriarMapa
  Left = 666
  Top = 352
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Selecione os itens do mapa de separa'#231#227'o'
  ClientHeight = 322
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbIsNota: TLabel
    Left = 356
    Top = 8
    Width = 39
    Height = 13
    Caption = 'lbIsNota'
  end
  object rg: TRadioGroup
    Left = 4
    Top = 11
    Width = 132
    Height = 77
    Caption = 'Criar a partir de :  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Pedido de compra'
      'Codigo          '
      'Nota de entrada')
    ParentFont = False
    TabOrder = 0
    OnClick = rgClick
  end
  object cbPreco: TadLabelComboBox
    Left = 325
    Top = 65
    Width = 188
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
    LabelDefs.Width = 68
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Mostrar pre'#231'o '
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbLoja: TadLabelComboBox
    Left = 149
    Top = 65
    Width = 164
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
    TabOrder = 2
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edCod: TadLabelEdit
    Left = 150
    Top = 22
    Width = 115
    Height = 22
    LabelDefs.Width = 88
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do Pedido'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object clb1: TadLabelCheckListBox
    Left = 4
    Top = 146
    Width = 574
    Height = 135
    Columns = 2
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 4
    LabelDefs.Width = 77
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja para incluir:'
    Colors.WhenEnterFocus.BackColor = clWhite
    Colors.WhenExitFocus.BackColor = clInfoBk
  end
  object fsCheckBox1: TfsCheckBox
    Left = 114
    Top = 131
    Width = 111
    Height = 15
    Caption = 'Seleciona todas'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = fsCheckBox1Click
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object edNome: TadLabelEdit
    Left = 103
    Top = 100
    Width = 476
    Height = 22
    LabelDefs.Width = 96
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nome da separa'#231#227'o'
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object cbEstoque: TfsCheckBox
    Left = 7
    Top = 290
    Width = 230
    Height = 15
    Caption = 'Selecione at'#233' os itens que n'#227'o t'#234'm estoque.'
    TabOrder = 7
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object btForn: TBitBtn
    Left = 542
    Top = 19
    Width = 24
    Height = 25
    Caption = '...'
    TabOrder = 8
    OnClick = btFornClick
  end
  object btOk: TBitBtn
    Left = 434
    Top = 287
    Width = 71
    Height = 27
    Caption = '&Ok'
    TabOrder = 9
    OnClick = btOkClick
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
    NumGlyphs = 2
  end
  object bitBtn3: TBitBtn
    Left = 509
    Top = 287
    Width = 70
    Height = 27
    Caption = '&Cancela'
    ModalResult = 2
    TabOrder = 10
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
    NumGlyphs = 2
  end
  object edIsNota: TadLabelEdit
    Left = 293
    Top = 22
    Width = 248
    Height = 22
    LabelDefs.Width = 53
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nota Fiscal'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnEnter = edIsNotaEnter
  end
end
