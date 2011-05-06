object fmComporEstoque: TfmComporEstoque
  Left = 213
  Top = 225
  Width = 811
  Height = 513
  Caption = 'fmComporEstoque'
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
  OnCreate = FormCreate
  DesignSize = (
    795
    475)
  PixelsPerInch = 96
  TextHeight = 13
  object cbLoja: TadLabelComboBox
    Left = 5
    Top = 29
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Ctl3D = True
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    ParentCtl3D = False
    TabOrder = 0
    OnClick = cbLojaClick
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object GroupBox2: TGroupBox
    Left = 184
    Top = 14
    Width = 136
    Height = 60
    Caption = ' Per'#237'odo '
    TabOrder = 1
    object edMesAno: TMaskEdit
      Left = 22
      Top = 24
      Width = 65
      Height = 22
      Ctl3D = False
      EditMask = '!99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '01/2009'
    end
    object SpinButton1: TSpinButton
      Left = 93
      Top = 14
      Width = 34
      Height = 37
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 1
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton1DownClick
      OnUpClick = SpinButton1UpClick
    end
  end
  object FlatButton1: TFlatButton
    Left = 552
    Top = 21
    Width = 98
    Height = 44
    Caption = '&Gerar'
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
    Layout = blGlyphLeft
    TabOrder = 2
    OnClick = FlatButton1Click
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 7
    Top = 104
    Width = 250
    Height = 97
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnColEnter = SoftDBGrid1ColEnter
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object SoftDBGrid2: TSoftDBGrid
    Left = 264
    Top = 103
    Width = 250
    Height = 100
    DataSource = dsItens
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnColEnter = SoftDBGrid2ColEnter
    OnTitleClick = SoftDBGrid2TitleClick
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object SoftDBGrid3: TSoftDBGrid
    Left = 521
    Top = 104
    Width = 224
    Height = 97
    DataSource = dsREsult
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object edMesAtual: TadLabelEdit
    Left = 661
    Top = 19
    Width = 119
    Height = 19
    LabelDefs.Width = 56
    LabelDefs.Height = 13
    LabelDefs.Caption = 'edMesAtual'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 6
    Text = 'adlabeledit1'
    Visible = False
  end
  object edMesAnterior: TadLabelEdit
    Left = 660
    Top = 66
    Width = 119
    Height = 19
    LabelDefs.Width = 68
    LabelDefs.Height = 13
    LabelDefs.Caption = 'edMesAnterior'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 7
    Text = 'adlabeledit1'
    Visible = False
  end
  object sBar: TStatusBar
    Left = 0
    Top = 456
    Width = 795
    Height = 19
    Panels = <>
  end
  object Memo1: TMemo
    Left = 7
    Top = 208
    Width = 629
    Height = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 9
  end
  object gbAcoes: TGroupBox
    Left = 328
    Top = 13
    Width = 209
    Height = 60
    Caption = ' A'#231#245'es '
    TabOrder = 10
    object cbGeraEstoque: TfsCheckBox
      Left = 6
      Top = 16
      Width = 193
      Height = 14
      Caption = 'Gerar a movimenta'#231#227'o de estoque'
      TabOrder = 0
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbCalculaCusto: TfsCheckBox
      Left = 6
      Top = 36
      Width = 193
      Height = 17
      Caption = 'Calcular custos do m'#234's'
      TabOrder = 1
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object tbNotas: TADOTable
    Connection = fmMain.Conexao
    Left = 48
    Top = 150
  end
  object tbItens: TADOTable
    Left = 600
    Top = 118
  end
  object DataSource1: TDataSource
    DataSet = tbNotas
    Left = 120
    Top = 142
  end
  object dsItens: TDataSource
    DataSet = tbItens
    Left = 640
    Top = 118
  end
  object qrResult: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 377
    Top = 163
  end
  object dsREsult: TDataSource
    DataSet = qrResult
    Left = 409
    Top = 163
  end
end
