object fmReqLojas: TfmReqLojas
  Left = 578
  Top = 281
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Simples requisi'#231#227'o de mercadorias entre lojas.'
  ClientHeight = 457
  ClientWidth = 579
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object fsLabel3: TfsLabel
    Left = 7
    Top = 146
    Width = 89
    Height = 13
    Caption = 'Itens da requisi'#231#227'o'
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object Panel1: TPanel
    Left = 424
    Top = 371
    Width = 145
    Height = 27
    BevelOuter = bvNone
    TabOrder = 5
  end
  object dbGrid: TSoftDBGrid
    Left = 5
    Top = 163
    Width = 564
    Height = 200
    Ctl3D = False
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbGridDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object fsGroupBox1: TfsGroupBox
    Left = 4
    Top = 44
    Width = 565
    Height = 100
    Caption = '  Itens da requisi'#231#227'o    '
    TabOrder = 1
    object edCodigo: TadLabelEdit
      Left = 8
      Top = 31
      Width = 145
      Height = 19
      LabelDefs.Width = 37
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Produto'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Enabled = False
      TabOrder = 0
      OnKeyDown = edCodigoKeyDown
    end
    object edDescricao: TadLabelEdit
      Left = 170
      Top = 32
      Width = 337
      Height = 19
      LabelDefs.Width = 37
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Produto'
      Colors.WhenDisabled.TextColor = clBlack
      Colors.WhenEnterFocus.BackColor = clBtnFace
      Colors.WhenExitFocus.BackColor = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnEnter = edDescricaoEnter
    end
    object edSaldo: TadLabelEdit
      Left = 388
      Top = 73
      Width = 119
      Height = 19
      LabelDefs.Width = 119
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Disponivel na loja Origem'
      Colors.WhenDisabled.TextColor = clBlack
      Colors.WhenEnterFocus.BackColor = clBtnFace
      Colors.WhenExitFocus.BackColor = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnEnter = edDescricaoEnter
    end
    object edQuant: TadLabelMaskEdit
      Left = 9
      Top = 72
      Width = 142
      Height = 19
      Ctl3D = False
      Enabled = False
      EditMask = '!9999999999;1;_'
      MaxLength = 10
      ParentCtl3D = False
      TabOrder = 3
      Text = '          '
      OnKeyDown = edQuantKeyDown
      LabelDefs.Width = 55
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Quantidade'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object cbOrigem: TadLabelComboBox
    Left = 6
    Top = 20
    Width = 170
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 2
    OnChange = cbOrigemChange
    LabelDefs.Width = 79
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja Requisitada'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btImprime: TFlatButton
    Left = 438
    Top = 372
    Width = 132
    Height = 26
    Caption = '&Enviar para a loja'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000707070606060
      6060606060606060606060606060606060606060606060606060606060606060
      60606060606060303030BFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF606060BFBFBFFFFFFF
      7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF606060BFBFBFFFFFFFBFBFBF7F7F007F7F7FFFFFFFDFDFDFBF
      BFBFBFBFBFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF606060BFBFBFFFFFFF
      FFFFFF9F9F9F7F00DF3F3F5FDFDFDFFFFFFFFFFFFFEFEFEFBFBFBFDFDFDFFFFF
      FFFFFFFFFFFFFF606060BFBFBFFFFFFFFFFFFFBFBFBF7F7FBF3F009F7F7F3FFF
      FFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFDFDFDFFFFFFF606060BFBFBFBFBFBF
      BFBFBFFFFFFFFFFFFFBFBF7F7F00DF3F3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFDFDFDFBFBFBF505050808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF60609F7F
      00DF3F3F5FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF909090FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF40407F7F00DF000020FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF40407F7F00DF3F3F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F403F009F000020FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00000040407F7F00DF000020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3F7F7FBF7F00
      DF000020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF3F3F3F7F7FBF7F00DF000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F
      3F202020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphLeft
    TabOrder = 3
    OnClick = btImprimeClick
  end
  object FlatButton1: TFlatButton
    Left = 468
    Top = 3
    Width = 102
    Height = 26
    Caption = '&Nova'
    Glyph.Data = {
      16020000424D160200000000000076000000280000001A0000001A0000000100
      040000000000A001000000000000000000001000000000000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      777777777777770A000477777777777777777777777777000000777777777777
      7777777777777700000077777788888888888888777777000000777777888888
      8888888877777700000077777444444444444488777777000000777774BFBFBF
      BFBFB488777777000000777774FBFBFBFBFBF488777777000000777774BFBFBF
      BFBFB488777777070707777774FBFBFBFBFBF488777777000000777774BFBFBF
      BFBFB488777777070707777774FBFBFBFBFBF488777777000000777774BFBFBF
      BFBFB488777777070707777774FBFBFBFBFBF488777777000000777774BFBFBF
      BFBFB488777777070707777774FBFBFBFBFBF488777777000000777774BFBFBF
      B444447777777707070777F77FFBFBFBF4FB4777777777000000777F7FBFBFBF
      B4B477777777770404047777FFFBFBFBF447777777777700000077FFFFFFF444
      44777777777777FFFBFF7777FFF7777777777777777777000000777F7F7F7777
      77777777777777FBFFFB77777F77F77777777777777777000000777777777777
      77777777777777FFFBFF77777777777777777777777777000000}
    Layout = blGlyphLeft
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object edObs: TadLabelEdit
    Left = 7
    Top = 379
    Width = 413
    Height = 19
    LabelDefs.Width = 58
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Observa'#231#227'o'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 6
    OnKeyDown = edCodigoKeyDown
  end
  object DataSource1: TDataSource
    DataSet = Table
    Left = 320
    Top = 280
  end
  object Table: TADOTable
    Connection = fmMain.Conexao
    Left = 352
    Top = 280
  end
end
