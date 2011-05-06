object FmOcorrencia: TFmOcorrencia
  Left = 241
  Top = 89
  ActiveControl = Flatbatidas
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Visualizador de ocorr'#234'ncias.'
  ClientHeight = 502
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 508
    Top = 472
    Width = 84
    Height = 24
    Caption = 'Imprime'
    TabOrder = 9
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
      FFF07F3FF3FF3FFF3FF70F00F00F000F00F07F773773777377370FFFFFFFFFFF
      FFF07F3FF3FF33FFFFF70F00F00FF00000F07F773773377777F70FEEEEEFF0F9
      FCF07F33333337F7F7F70FFFFFFFF0F9FCF07F3FFFF337F737F70F0000FFF0FF
      FCF07F7777F337F337370F0000FFF0FFFFF07F777733373333370FFFFFFFFFFF
      FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
      C880733777777777733700000000000000007777777777777777333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 2
    Top = 8
    Width = 381
    Height = 65
    Caption = ' Escolha o empregado '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Edit1: TEdit
      Left = 6
      Top = 14
      Width = 215
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      Color = clInfoBk
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnChange = Edit1Change
    end
    object cb1: TComboBox
      Left = 6
      Top = 38
      Width = 348
      Height = 22
      BevelInner = bvNone
      BevelKind = bkSoft
      Style = csDropDownList
      Color = clInfoBk
      Ctl3D = False
      DropDownCount = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      MaxLength = 99
      ParentCtl3D = False
      ParentFont = False
      Sorted = True
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 413
    Top = 8
    Width = 184
    Height = 65
    Caption = ' Por loja '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object cbLojas: TComboBox
      Left = 10
      Top = 24
      Width = 165
      Height = 22
      BevelInner = bvNone
      BevelKind = bkSoft
      Style = csDropDownList
      Color = clInfoBk
      Ctl3D = False
      DropDownCount = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      MaxLength = 99
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnChange = cbLojasChange
      Items.Strings = (
        #160
        '01 -Matriz   '
        '02 -Escritorio   '
        '03 -Edgar Edgar   '
        '04 -Br 116   '
        '05 -Pedro Borges  '
        '06 -Dom Luis   '
        '07 -Maison'
        '10 -Mesejana   '
        '11 -Montese   '
        '12 -Washington  '
        '13 -CD'
        '17 -Liberato')
    end
  end
  object sg1: TStringGrid
    Left = 503
    Top = 161
    Width = 382
    Height = 273
    Color = clInfoBk
    ColCount = 7
    DefaultColWidth = 42
    DefaultRowHeight = 13
    FixedColor = clActiveBorder
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Options = [goFixedVertLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 2
    Visible = False
    ColWidths = (
      112
      51
      51
      50
      43
      19
      42)
  end
  object BitBtn2: TBitBtn
    Left = 505
    Top = 110
    Width = 84
    Height = 34
    Caption = 'C&alcular'
    TabOrder = 3
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
      FFF07F3FF3FF3FFF3FF70F00F00F000F00F07F773773777377370FFFFFFFFFFF
      FFF07F3FF3FF33FFFFF70F00F00FF00000F07F773773377777F70FEEEEEFF0F9
      FCF07F33333337F7F7F70FFFFFFFF0F9FCF07F3FFFF337F737F70F0000FFF0FF
      FCF07F7777F337F337370F0000FFF0FFFFF07F777733373333370FFFFFFFFFFF
      FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
      C880733777777777733700000000000000007777777777777777333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object GroupBox3: TGroupBox
    Left = 2
    Top = 80
    Width = 252
    Height = 65
    Caption = ' Per'#237'odo '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 117
      Top = 30
      Width = 19
      Height = 13
      Caption = 'at'#233
    end
    object dtf: TDateTimePicker
      Left = 142
      Top = 25
      Width = 101
      Height = 21
      Date = 39395.000000000000000000
      Format = 'dd/MM/yyyy'
      Time = 39395.000000000000000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dti: TDateTimePicker
      Left = 9
      Top = 25
      Width = 101
      Height = 21
      CalColors.BackColor = clInfoBk
      CalColors.MonthBackColor = clInfoBk
      Date = 39395.000000000000000000
      Format = 'dd/MM/yyyy'
      Time = 39395.000000000000000000
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    Left = 1
    Top = 158
    Width = 592
    Height = 309
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 5
    OnClick = Memo1Click
  end
  object GroupBox4: TGroupBox
    Left = 264
    Top = 80
    Width = 143
    Height = 65
    Caption = ' Verificar ocorr'#234'ncias '
    TabOrder = 6
    object Flatbatidas: TFlatCheckBox
      Left = 5
      Top = 15
      Width = 121
      Height = 17
      Caption = 'Batidas incompat'#237'veis'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = FlatbatidasClick
    end
    object FlatFaltas: TFlatCheckBox
      Left = 5
      Top = 30
      Width = 121
      Height = 17
      Caption = 'Falta'
      TabOrder = 1
      TabStop = True
      OnClick = FlatbatidasClick
    end
    object FlatAtrasos: TFlatCheckBox
      Left = 5
      Top = 45
      Width = 121
      Height = 17
      Caption = 'Atraso na entrada'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = FlatbatidasClick
    end
  end
  object chBox: TFlatCheckBox
    Left = 414
    Top = 86
    Width = 180
    Height = 17
    Caption = 'Mostre as ocorr'#234'ncias justificadas'
    TabOrder = 7
    TabStop = True
  end
  object Panel1: TPanel
    Left = 3
    Top = 471
    Width = 501
    Height = 26
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'Manipulador de batidas'
    Color = clInfoBk
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 8
    Visible = False
    object Label2: TLabel
      Left = 5
      Top = 8
      Width = 39
      Height = 13
      Caption = 'Label2'
      Color = clInfoBk
      ParentColor = False
    end
  end
  object Connection: TADOConnection
    CommandTimeout = 0
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Data' +
      ' Source=125.4.4.200'
    ConnectionTimeout = 5
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 560
    Top = 8
  end
  object qJustificativa: TADOQuery
    Connection = Connection
    CommandTimeout = 15
    Parameters = <>
    Left = 384
    Top = 8
  end
end
