object Form1: TForm1
  Left = 198
  Top = 85
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '(14) Importa'#231#227'o de registros para escrita'
  ClientHeight = 372
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 0
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object Label2: TLabel
    Left = 171
    Top = 347
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 272
    Top = 0
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 15
    Width = 167
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 0
    OnChange = cb2Change
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dp1: TDateTimePicker
    Left = 176
    Top = 14
    Width = 91
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvRaised
    BevelKind = bkSoft
    Date = 39290.610618668980000000
    Time = 39290.610618668980000000
    TabOrder = 1
    OnChange = dp1Change
  end
  object DBGrid: TSoftDBGrid
    Left = 0
    Top = 75
    Width = 792
    Height = 266
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object FlatButton3: TFlatButton
    Left = 372
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Gerar &LVSAI'
    TabOrder = 3
    OnClick = FlatButton3Click
  end
  object Edit1: TadLabelEdit
    Left = 75
    Top = 343
    Width = 77
    Height = 19
    LabelDefs.Width = 66
    LabelDefs.Height = 13
    LabelDefs.Caption = 'N'#186' loja no SIC'
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Enabled = False
    TabOrder = 4
  end
  object FlatButton4: TFlatButton
    Left = 451
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Gerar &LVENT'
    TabOrder = 5
    OnClick = FlatButton4Click
  end
  object dp2: TDateTimePicker
    Left = 272
    Top = 14
    Width = 91
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvRaised
    BevelKind = bkSoft
    Date = 39290.610618668980000000
    Time = 39290.610618668980000000
    TabOrder = 6
  end
  object FlatButton6: TFlatButton
    Left = 531
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Gerar &Redu'#231#227'o'
    TabOrder = 7
    OnClick = FlatButton6Click
  end
  object FlatButton8: TFlatButton
    Left = 613
    Top = 344
    Width = 75
    Height = 24
    Caption = 'Notas Fornc'
    TabOrder = 8
    OnClick = FlatButton8Click
  end
  object rg1: TfsRadioGroup
    Left = 368
    Top = 4
    Width = 280
    Height = 69
    HelpType = htKeyword
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
    BiDiMode = bdRightToLeft
    Caption = ' Gerar  Rela'#231#227'o  '
    Columns = 2
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      'Lista Sa'#237'das'
      'Lista Entradas'
      'Lista Redu'#231#227'o'
      'Notas Fornecedor'
      'Rela'#231#227'o Transfer'#234'ncias')
    ParentBiDiMode = False
    ParentCtl3D = False
    TabOrder = 9
  end
  object fsBitBtn1: TfsBitBtn
    Left = 658
    Top = 8
    Width = 94
    Height = 65
    Caption = '&Gerar'
    TabOrder = 10
    OnClick = fsBitBtn1Click
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
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnExecuteComplete = ADOConnection1ExecuteComplete
    OnWillExecute = ADOConnection1WillExecute
    Left = 96
    Top = 56
  end
  object query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    Left = 361
    Top = 89
  end
  object DataSource1: TDataSource
    DataSet = query
    Left = 168
    Top = 56
  end
  object qrReducao: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec Z_CF_StoListaReducaoParaLVSAI 10033586, '#39'08/25/2007'#39', '#39'08/2' +
        '5/2007'#39'  ')
    Left = 400
    Top = 89
    object qrReducaoIS_NOTA: TIntegerField
      FieldName = 'IS_NOTA'
      ReadOnly = True
    end
    object qrReducaoNOTA: TIntegerField
      FieldName = 'NOTA'
    end
    object qrReducaoSERIE: TWordField
      FieldName = 'SERIE'
    end
    object qrReducaoCFO: TStringField
      FieldName = 'CFO'
      ReadOnly = True
      Size = 4
    end
    object qrReducaoDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object qrReducaoTIPO: TIntegerField
      FieldName = 'TIPO'
      ReadOnly = True
    end
    object qrReducaoDESTINO: TStringField
      FieldName = 'DESTINO'
      ReadOnly = True
      Size = 2
    end
    object qrReducaoUF: TIntegerField
      FieldName = 'UF'
      ReadOnly = True
    end
    object qrReducaoVALOR: TBCDField
      FieldName = 'VALOR'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoVALORBASEICMS: TBCDField
      FieldName = 'VALORBASEICMS'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoPERCICMS: TStringField
      FieldName = 'PERCICMS'
      ReadOnly = True
      Size = 2
    end
    object qrReducaoVALORICMS: TBCDField
      FieldName = 'VALORICMS'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoVL_MOVIMENTO: TBCDField
      FieldName = 'VL_MOVIMENTO'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoVL_CANCEL: TBCDField
      FieldName = 'VL_CANCEL'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoVL_DESC: TBCDField
      FieldName = 'VL_DESC'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoVlIsentas: TBCDField
      FieldName = 'VlIsentas'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoGT_ANT: TBCDField
      FieldName = 'GT_ANT'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoGT_ATUAL: TBCDField
      FieldName = 'GT_ATUAL'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrReducaoCOO_ATUAL: TIntegerField
      FieldName = 'COO_ATUAL'
    end
    object qrReducaoCOO_INICIAL: TIntegerField
      FieldName = 'COO_INICIAL'
    end
  end
  object Query3: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    BeforePost = Query3BeforePost
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec dbo.Z_CF_StoListarEntradasParaLVENT 10033593, '#39'08/01/2007'#39',' +
        ' '#39'08/01/2007'#39)
    Left = 440
    Top = 89
    object Query3is_nota: TIntegerField
      FieldName = 'is_nota'
      Visible = False
    end
    object Query3nota: TIntegerField
      FieldName = 'nota'
    end
    object Query3serie: TStringField
      FieldName = 'serie'
      Size = 3
    end
    object Query3cfo: TIntegerField
      FieldName = 'cfo'
    end
    object Query3data: TDateTimeField
      FieldName = 'data'
    end
    object Query3dataE: TDateTimeField
      FieldName = 'dataE'
    end
    object Query3tipo: TStringField
      FieldName = 'tipo'
      Visible = False
      Size = 3
    end
    object Query3destino: TStringField
      FieldName = 'destino'
      Visible = False
      Size = 2
    end
    object Query3uf: TStringField
      FieldName = 'uf'
      Visible = False
      Size = 2
    end
    object Query3valor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
    end
    object Query3valorBaseIcms: TFloatField
      FieldName = 'valorBaseIcms'
      DisplayFormat = '#,###,###0.00'
    end
    object Query3percicms: TFloatField
      FieldName = 'percicms'
      DisplayFormat = '#,###,###0.00'
    end
    object Query3ValorICMS: TFloatField
      FieldName = 'ValorICMS'
      DisplayFormat = '#,###,###0.00'
    end
    object Query3a: TStringField
      FieldName = 'a'
      Visible = False
      Size = 9
    end
    object Query3b: TStringField
      FieldName = 'b'
      Visible = False
      Size = 9
    end
    object Query3c: TStringField
      FieldName = 'c'
      Visible = False
      Size = 9
    end
    object Query3nr_cpfcgc: TIntegerField
      FieldName = 'nr_cpfcgc'
      Visible = False
    end
    object Query3nr_filcgc: TIntegerField
      FieldName = 'nr_filcgc'
      Visible = False
    end
    object Query3dg_cpfcgc: TIntegerField
      FieldName = 'dg_cpfcgc'
      Visible = False
    end
    object Query3codForn: TStringField
      FieldName = 'codForn'
      Size = 4
    end
    object Query3EhCadastrado: TStringField
      FieldName = 'EhCadastrado'
      Size = 1
    end
    object Query3nm_Pes: TStringField
      FieldName = 'nm_Pes'
      Size = 50
    end
  end
end
