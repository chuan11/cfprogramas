object Form1: TForm1
  Left = 237
  Top = 55
  Width = 854
  Height = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TadLabelEdit
    Left = 5
    Top = 20
    Width = 123
    Height = 22
    LabelDefs.Width = 100
    LabelDefs.Height = 13
    LabelDefs.Caption = '&C'#243'digo loja ou Barras'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object edit2: TadLabelEdit
    Left = 131
    Top = 20
    Width = 511
    Height = 22
    LabelDefs.Width = 37
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pr&oduto'
    LabelDefs.Color = clBtnFace
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = []
    LabelDefs.ParentColor = False
    LabelDefs.ParentFont = False
    LabelDefs.ParentShowHint = False
    LabelDefs.ShowHint = False
    LabelDefs.Transparent = True
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object edit3: TadLabelNumericEdit
    Left = 6
    Top = 63
    Width = 120
    Height = 22
    LabelDefs.Width = 6
    LabelDefs.Height = 13
    LabelDefs.Caption = ' -'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    OnKeyDown = edit3KeyDown
    ParentFont = False
    TabOrder = 2
  end
  object sg: TStringGrid
    Left = 6
    Top = 94
    Width = 827
    Height = 162
    Color = clInfoBk
    ColCount = 9
    Ctl3D = False
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    OnDblClick = sgDblClick
    OnSelectCell = sgSelectCell
    ColWidths = (
      64
      107
      163
      165
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24)
  end
  object CB1: TadLabelComboBox
    Left = 130
    Top = 63
    Width = 111
    Height = 24
    AutoCloseUp = True
    BevelInner = bvNone
    BevelKind = bkFlat
    Color = clInfoBk
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    ItemIndex = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    Text = 'Varejo'
    Items.Strings = (
      'Varejo'
      'Atacado')
    LabelDefs.Width = 67
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Tipo de Preco'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
  end
  object Edit4: TadLabelEdit
    Left = 254
    Top = 64
    Width = 62
    Height = 22
    LabelDefs.Width = 9
    LabelDefs.Height = 13
    LabelDefs.Caption = ' - '
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object EDIT5: TadLabelEdit
    Left = 331
    Top = 64
    Width = 62
    Height = 22
    LabelDefs.Width = 6
    LabelDefs.Height = 13
    LabelDefs.Caption = '--'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object FlatButton2: TFlatButton
    Left = 410
    Top = 55
    Width = 56
    Height = 33
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 7
    OnClick = FlatButton2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 262
    Width = 647
    Height = 156
    BevelOuter = bvNone
    TabOrder = 8
    object Gauge: TFlatGauge
      Left = 419
      Top = 101
      Width = 207
      Height = 20
      AdvColorBorder = 0
      ColorBorder = 8623776
      Progress = 0
      Visible = False
    end
    object Label1: TLabel
      Left = 418
      Top = 28
      Width = 89
      Height = 13
      Caption = 'Pre'#231'os a partir de :'
    end
    object clb1: TadLabelCheckListBox
      Left = 8
      Top = 23
      Width = 125
      Height = 130
      Color = clInfoBk
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnClick = clb1Click
      LabelDefs.Width = 109
      LabelDefs.Height = 13
      LabelDefs.Caption = 'adLabelCheckListBox1'
      Colors.WhenEnterFocus.BackColor = clWhite
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object clb2: TadLabelCheckListBox
      Left = 140
      Top = 23
      Width = 125
      Height = 130
      Color = clInfoBk
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 1
      OnClick = clb1Click
      LabelDefs.Width = 109
      LabelDefs.Height = 13
      LabelDefs.Caption = 'adLabelCheckListBox1'
      Colors.WhenEnterFocus.BackColor = clWhite
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object clb3: TadLabelCheckListBox
      Left = 272
      Top = 23
      Width = 125
      Height = 130
      Color = clInfoBk
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 2
      OnClick = clb1Click
      LabelDefs.Width = 109
      LabelDefs.Height = 13
      LabelDefs.Caption = 'adLabelCheckListBox1'
      Colors.WhenEnterFocus.BackColor = clWhite
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object Date1: TfsDateTimePicker
      Left = 418
      Top = 52
      Width = 121
      Height = 21
      Date = 39576.647811585650000000
      Time = 39576.647811585650000000
      TabOrder = 3
    end
    object FlatButton1: TFlatButton
      Left = 548
      Top = 25
      Width = 78
      Height = 47
      Caption = 'Gravar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
        FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
        FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
        007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
        7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
        99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = FlatButton1Click
    end
  end
  object Connection: TADOConnection
    LoginPrompt = False
    Provider = 'C:\ProgramasDiversos\ConexaoAoWell.udl'
    Left = 280
    Top = 65535
  end
  object Query: TADOQuery
    Connection = Connection
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'Declare @codigo as integer'
      'set @codigo  = ')
    Left = 219
    Top = 65535
  end
  object MainMenu1: TMainMenu
    Left = 312
    Top = 65534
    object Gerardeumpedido1: TMenuItem
      Caption = 'Gerar de um pedido'
      OnClick = Gerardeumpedido1Click
    end
    object Parametros1: TMenuItem
      Caption = 'Parametros'
      OnClick = Parametros1Click
    end
  end
end
