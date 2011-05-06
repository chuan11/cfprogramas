object Form1: TForm1
  Left = 209
  Top = 99
  Width = 1034
  Height = 592
  Caption = '(02) Mapa de estoque'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 90
    Width = 998
    Height = 438
    Ctl3D = False
    DataSource = DataSource1
    DefaultDrawing = False
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = gridDrawColumnCell
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object fsGroupBox1: TfsGroupBox
    Left = 2
    Top = 0
    Width = 990
    Height = 86
    Caption = '   Dados da Consulta    '
    TabOrder = 1
    object Label1: TLabel
      Left = 188
      Top = 29
      Width = 35
      Height = 13
      Caption = 'Depart:'
    end
    object Label2: TLabel
      Left = 199
      Top = 45
      Width = 40
      Height = 13
      Caption = 'Sec'#231#227'o:'
    end
    object Label3: TLabel
      Left = 210
      Top = 61
      Width = 48
      Height = 13
      Caption = 'Categoria:'
    end
    object Bevel1: TBevel
      Left = 182
      Top = 23
      Width = 236
      Height = 53
    end
    object lbClasse1: TLabel
      Left = 248
      Top = 29
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse2: TLabel
      Left = 256
      Top = 45
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse3: TLabel
      Left = 266
      Top = 61
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 180
      Top = 8
      Width = 50
      Height = 13
      Caption = 'Categorias'
    end
    object lbNivel: TLabel
      Left = 244
      Top = 8
      Width = 6
      Height = 13
      Caption = '0'
      Visible = False
    end
    object lbCodigo: TLabel
      Left = 300
      Top = 8
      Width = 24
      Height = 13
      Caption = '0000'
      Visible = False
    end
    object gauge: TFlatGauge
      Left = 807
      Top = 71
      Width = 181
      Height = 15
      AdvColorBorder = 0
      ColorBorder = 8623776
      Progress = 0
      Visible = False
    end
    object edCodigo: TadLabelEdit
      Left = 5
      Top = 29
      Width = 167
      Height = 26
      LabelDefs.Width = 33
      LabelDefs.Height = 13
      LabelDefs.Caption = 'C'#243'digo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = edCodigoKeyDown
    end
    object fsBitBtn1: TfsBitBtn
      Left = 418
      Top = 33
      Width = 31
      Height = 32
      Hint = 'Valores das categorias'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = fsBitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4A4A4A4FFFFFFFFFFFFFFFF
        FFFFA400A4A4A4A4FFFFFFFFFFFFFFFFFFFFA408080008A4FFFFFFFFFFFFFFFF
        FFFFA40808A4A4A4FFFFFFFFFFFF0000A4A4000008A4A4A4FFFFFFFFFFFF00FF
        0808FF000800FFA4FFFFFFFFA400A4A4A4A4A400A4A4A4A4FFFFFFFFA40808FF
        00A4A400A4A4A4A4FFFFFFFFA408000000A4A400FFFFFFFFFFFFFF0000080000
        00A4A400FFFFFFFFFFFFFFFF0808000808A40000FFFFFFFFFFFFFFFFA408FFFF
        00A4A4A4FFFFFFFFFFFFFFFF0000A4A400A400FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object fsBitBtn2: TfsBitBtn
      Left = 835
      Top = 14
      Width = 69
      Height = 54
      Caption = '&Gerar'
      TabOrder = 2
      OnClick = fsBitBtn2Click
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF7F7F7F0040400040407F7F7FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF00404000
        4040004040004040BFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFBFBFBF004040004040004040004040BFBFBFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF00606000
        8080008080006060BFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF3F3F3F5050505050503F3F3FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFA0
        A0A0A0A0A0FFFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF7F7F7FFFFFFFA0A0A0A0A0A0FFFFFF7F7F7FFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFF7FBFBF40
        7F7F407F7F7FBFBFFFFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF7F7F7F7FFFFF3FFFFF007F7F007F7F7FFFFFBFFFFF7F7F7FFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FBFFFFF3FFFFF007F7F00
        FFFF00FFFF007F7F7FFFFFBFFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7F7F7F7FFFFF3FFFFF007F9F00BFFF00BFFF003F9F3FFFFF7FFFFF7F7F
        7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7FFFFF7FFFFF00FFFF00
        FFFF00FFFF00FFFF3FFFFF7FFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7F7F7FBFFFFF7FFFFF7FFFFF3FFFFF3FFFFF3FFFFF7FFFFF7FFFFF7F7F
        7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFBFBFBFBFFFFF7FFFFF7F
        FFFF7FFFFF7FFFFFBFFFFFBFBFBFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF7F7F7FFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF7F7F7F7F
        7F7F7F7F7F7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
    end
    object cbOrdem: TadLabelComboBox
      Left = 618
      Top = 17
      Width = 165
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 13
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 3
      Text = 'C'#243'digo'
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
      LabelDefs.Width = 59
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Ordenar por:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object chDisponivel: TfsCheckBox
      Left = 9
      Top = 59
      Width = 115
      Height = 17
      Caption = 'Estoque dispon'#237'vel'
      Checked = True
      State = cbChecked
      TabOrder = 4
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbTpEstoque: TadLabelComboBox
      Left = 450
      Top = 56
      Width = 127
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 13
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 5
      Text = 'Que t'#234'm estoque'
      Items.Strings = (
        'Que t'#234'm estoque'
        'Tudo')
      LabelDefs.Width = 77
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Tipo de estoque'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cb2: TadLabelComboBox
      Left = 449
      Top = 17
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
      TabOrder = 6
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object fsBitBtn3: TfsBitBtn
      Left = 906
      Top = 13
      Width = 77
      Height = 41
      Caption = '&Mapa Estoque'
      TabOrder = 7
      OnClick = fsBitBtn3Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD00000DD00000000006660DD08888880E00
        000DD000000000EEE080DD07778E0EEE0080DDD078E0EEE07700DDDD0E0EEE00
        0000DDD0E0EEE080DDDDDD0E0EEE07080DDDD0E0EEE0777080DD0E0EEE0D0777
        080D00EEE0DDD077700D00000DDDDD00000DDDDDDDDDDDDDDDDD}
      Layout = blGlyphTop
    end
    object cbPrecos: TadLabelComboBox
      Left = 618
      Top = 57
      Width = 165
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 8
      LabelDefs.Width = 31
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Pre'#231'o:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object Connection: TADOConnection
    CommandTimeout = 0
    LoginPrompt = False
    Left = 48
    Top = 232
  end
  object DataSource1: TDataSource
    DataSet = Table
    Left = 48
    Top = 184
  end
  object Table: TADOTable
    Connection = Connection
    Left = 48
    Top = 280
  end
end
