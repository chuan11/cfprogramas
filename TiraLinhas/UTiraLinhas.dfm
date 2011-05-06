object Form1: TForm1
  Left = 224
  Top = 130
  Width = 751
  Height = 495
  Caption = 'Filtro de Linhas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 1
    Top = 349
    Width = 123
    Height = 13
    Caption = 'Tamanho da coincidencia'
  end
  object Label2: TLabel
    Left = 7
    Top = 29
    Width = 47
    Height = 13
    Caption = 'Salvar em'
  end
  object Label3: TLabel
    Left = 12
    Top = 325
    Width = 112
    Height = 13
    Caption = 'Pos inicial  compara'#231#227'o'
  end
  object Label4: TLabel
    Left = 12
    Top = 5
    Width = 42
    Height = 13
    Caption = 'Arquvivo'
  end
  object Label5: TLabel
    Left = 177
    Top = 324
    Width = 107
    Height = 13
    Caption = 'Linhas para processar:'
  end
  object Label6: TLabel
    Left = 481
    Top = 6
    Width = 43
    Height = 13
    Caption = 'Carregue'
  end
  object BitBtn2: TBitBtn
    Left = 445
    Top = 190
    Width = 130
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 0
    OnClick = BitBtn2Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333393333
      33333333333973333333333333C943333333333333C94733333333333CC94433
      333333333CC9447333333333CCC9444333333333CCC944473333333CCCC94444
      3333333CCCC94444733333CCCCC94444433333CCCCC9444447333CCCCC393444
      44333CCC333933744473CCC3333933334443C333333933333743}
  end
  object ListBox1: TListBox
    Left = 0
    Top = 54
    Width = 575
    Height = 135
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnDblClick = ListBox1DblClick
  end
  object ListBox2: TListBox
    Left = 0
    Top = 216
    Width = 575
    Height = 101
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    OnDblClick = ListBox2DblClick
  end
  object BitBtn3: TBitBtn
    Left = 440
    Top = 318
    Width = 135
    Height = 25
    Caption = 'Processa'
    TabOrder = 3
    OnClick = BitBtn3Click
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
    NumGlyphs = 2
  end
  object Button1: TButton
    Left = 2
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 85
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Salva '
    TabOrder = 5
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 528
    Top = 2
    Width = 103
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    TabOrder = 6
    Text = '100 Linhas'
    Items.Strings = (
      '100 Linhas'
      '500 Linhas'
      '1000 Linhas'
      'Tudo')
  end
  object ComboBox2: TComboBox
    Left = 287
    Top = 321
    Width = 103
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 3
    ParentCtl3D = False
    TabOrder = 7
    Text = 'Tudo'
    Items.Strings = (
      '100 Linhas'
      '500 Linhas'
      '1000 Linhas'
      'Tudo')
  end
  object CheckBox2: TCheckBox
    Left = 178
    Top = 349
    Width = 181
    Height = 17
    Caption = 'Apos processar, mostre o arquivo'
    TabOrder = 8
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 438
    Width = 735
    Height = 19
    Panels = <>
  end
  object Edit1: TEdit
    Left = 60
    Top = 3
    Width = 398
    Height = 19
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 10
    OnDblClick = Edit1DblClick
  end
  object Edit2: TEdit
    Left = 60
    Top = 28
    Width = 398
    Height = 19
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 11
  end
  object MaskEdit2: TMaskEdit
    Left = 130
    Top = 324
    Width = 30
    Height = 19
    Ctl3D = False
    EditMask = '00;1;_'
    MaxLength = 2
    ParentCtl3D = False
    TabOrder = 12
    Text = '10'
  end
  object MaskEdit1: TMaskEdit
    Left = 130
    Top = 347
    Width = 30
    Height = 19
    Ctl3D = False
    EditMask = '00;1;_'
    MaxLength = 2
    ParentCtl3D = False
    TabOrder = 13
    Text = '50'
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de texto *.TMP;*.TXT;*.PRN|*.TMP;*.TXT;*.PRN'
    InitialDir = 'c:\'
    Left = 376
  end
  object OpenDialog2: TOpenDialog
    Filter = 'layout de arquivo *.lay|*.lay'
    Left = 165
    Top = 189
  end
  object SaveDialog1: TSaveDialog
    Left = 193
    Top = 189
  end
end
