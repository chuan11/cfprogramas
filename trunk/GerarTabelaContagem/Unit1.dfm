object Form1: TForm1
  Left = 297
  Top = 114
  Width = 529
  Height = 533
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Consolida'#231#227'o dos arquivos de invent'#225'rios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 440
    Width = 447
    Height = 13
    Caption = 
      'No Well desmarca a opcao  codigo interno e marca a opcao de cons' +
      'ulltar pelo cod secundario'
  end
  object Edit1: TadLabelEdit
    Left = 5
    Top = 19
    Width = 499
    Height = 19
    LabelDefs.Width = 324
    LabelDefs.Height = 13
    LabelDefs.Caption = 
      'Arquivo com a contagem ( Layout no arquivo ConsolidaInventario.i' +
      'ni)'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = 'C:\CONTAGEM_A.TXT'
    OnDblClick = Edit1DblClick
  end
  object FlatButton1: TFlatButton
    Left = 4
    Top = 404
    Width = 162
    Height = 25
    Hint = 'Inclui os itens do arquivo n tabela zcontloja'
    Caption = 'Capturar arquivo de contagem'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object Memo1: TMemo
    Left = 3
    Top = 108
    Width = 500
    Height = 89
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 3
    Top = 207
    Width = 500
    Height = 89
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 3
    Top = 310
    Width = 500
    Height = 89
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
  end
  object edit2: TadLabelEdit
    Left = 5
    Top = 56
    Width = 65
    Height = 19
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 4
    TabOrder = 5
    Text = 'X'
  end
  object Rg1: TRadioGroup
    Left = 88
    Top = 47
    Width = 249
    Height = 52
    Caption = 'Itens repetidos'
    ItemIndex = 0
    Items.Strings = (
      'Adiciona  (leva em conta o sinal da contagem)'
      'Diminui')
    TabOrder = 6
  end
  object FlatButton2: TFlatButton
    Left = 340
    Top = 45
    Width = 147
    Height = 25
    Caption = 'Verifica codigos invalidos'
    TabOrder = 7
    OnClick = FlatButton2Click
  end
  object CheckBox1: TCheckBox
    Left = 339
    Top = 70
    Width = 164
    Height = 17
    Caption = 'Exclua do arq itens invalidos'
    TabOrder = 8
  end
  object FlatButton3: TFlatButton
    Left = 352
    Top = 403
    Width = 152
    Height = 25
    Caption = 'Preparar para Well'
    TabOrder = 9
    OnClick = FlatButton3Click
  end
  object SB1: TStatusBar
    Left = 0
    Top = 476
    Width = 513
    Height = 19
    Panels = <>
  end
  object FlatButton4: TFlatButton
    Left = 333
    Top = 0
    Width = 38
    Height = 18
    Caption = 'Ver'
    TabOrder = 11
    OnClick = FlatButton4Click
  end
  object connection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 144
  end
  object q1: TADOQuery
    Connection = connection
    Parameters = <>
    Left = 112
    Top = 144
  end
  object q2: TADOQuery
    Connection = connection
    Parameters = <>
    Left = 144
    Top = 144
  end
end
