object Form1: TForm1
  Left = 191
  Top = 106
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 273
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 231
    Width = 108
    Height = 13
    Caption = 'Data altera'#231#227'o no SIC:'
  end
  object Label2: TLabel
    Left = 371
    Top = 1
    Width = 73
    Height = 13
    Caption = 'Data altera'#231#227'o:'
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 5
    Top = 44
    Width = 588
    Height = 185
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 15
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
    TabOrder = 1
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cb1: TadLabelComboBox
    Left = 184
    Top = 15
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
    LabelDefs.Width = 34
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o :'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dp1: TDateTimePicker
    Left = 369
    Top = 15
    Width = 121
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvSpace
    BevelKind = bkSoft
    Date = 39326.527443576390000000
    Time = 39326.527443576390000000
    TabOrder = 3
  end
  object FlatButton1: TFlatButton
    Left = 512
    Top = 13
    Width = 79
    Height = 25
    Caption = '&Obter'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
      0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
      00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
      00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
      F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
      F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
      FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
      0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
      00337777FFFF77FF7733EEEE0000000003337777777777777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object dt2: TDateTimePicker
    Left = 6
    Top = 246
    Width = 121
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvSpace
    BevelKind = bkSoft
    Date = 39326.527443576390000000
    Time = 39326.527443576390000000
    TabOrder = 5
  end
  object cbox3: TadLabelComboBox
    Left = 148
    Top = 245
    Width = 155
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 6
    Text = 'V - Varejo'
    Items.Strings = (
      'V - Varejo'
      'A - Atacado')
    LabelDefs.Width = 51
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pre'#231'o SIC:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton2: TFlatButton
    Left = 455
    Top = 234
    Width = 137
    Height = 33
    Caption = '&Copiar Para o SIC'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3333337F337F333333333307B70FFFFF33333373FF733F333333333000FF
      0FFF3333333777337FF3333333333FF000FF33FFFFF3333777FF300000333300
      000F377777F33377777F30EEE0333000000037F337F33777777730EEE0333330
      00FF37F337F3333777F330EEE033333000FF37FFF7F3333777F3300000333330
      00FF3777773333F77733333333333000033F3333333337777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 7
    OnClick = FlatButton2Click
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 'FILE NAME=C:\LancaPrecosWell\LancaPrecosWell.udl'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 120
    Top = 144
  end
  object Query: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        ' select crefe.cd_ref as [Codigo], crefe.ds_ref as [Descricao], d' +
        'salp.vl_preco as [Preco] from dsalp  inner join crefe on dsalp.i' +
        's_ref = crefe.is_ref  where  dsalp.tp_preco = '#39'101'#39' and dsalp.dt' +
        '_altpv = '#39'08/14/2007'#39' and dsalp.is_uo = 10033586')
    Left = 152
    Top = 144
    object QueryCodigo: TStringField
      DisplayWidth = 15
      FieldName = 'Codigo'
    end
    object QueryDescricao: TStringField
      DisplayWidth = 58
      FieldName = 'Descricao'
      Size = 50
    end
    object QueryPreco: TBCDField
      DisplayWidth = 29
      FieldName = 'Preco'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 200
    Top = 144
  end
end
