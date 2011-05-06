object Form1: TForm1
  Left = 397
  Top = 137
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 479
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 222
    Width = 77
    Height = 15
    Caption = 'N'#186' Nota Inicial'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 126
    Top = 222
    Width = 61
    Height = 15
    Caption = 'Selo Inicial'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 126
    Top = 266
    Width = 70
    Height = 15
    Caption = 'N'#186' Nota Final'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 7
    Width = 88
    Height = 15
    Caption = 'Captura da loja:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 4
    Top = 266
    Width = 70
    Height = 15
    Caption = 'N'#186' Nota Final'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 6
    Top = 41
    Width = 74
    Height = 15
    Caption = 'Arquivo SISIF'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 5
    Top = 171
    Width = 94
    Height = 15
    Caption = 'Formulario incial'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label9: TLabel
    Left = 7
    Top = 321
    Width = 99
    Height = 15
    Caption = 'AIDF (aaaannnnn)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 2
    Top = 380
    Width = 256
    Height = 92
    Color = clMenu
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 15
  end
  object BitBtn1: TBitBtn
    Left = 20
    Top = 80
    Width = 215
    Height = 31
    Caption = '&Inserir CPF + Ajusta Redu'#231#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 20
    Top = 113
    Width = 215
    Height = 31
    Caption = 'Selagem de  NFVC '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object Edit1: TEdit
    Left = 3
    Top = 236
    Width = 108
    Height = 24
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 6
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
    OnExit = Edit1Exit
  end
  object Edit2: TEdit
    Left = 125
    Top = 236
    Width = 122
    Height = 24
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 8
  end
  object Edit3: TEdit
    Left = 3
    Top = 281
    Width = 106
    Height = 24
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 6
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 9
    OnExit = Edit3Exit
  end
  object Edit4: TEdit
    Left = 124
    Top = 281
    Width = 122
    Height = 24
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 10
  end
  object Edit5: TEdit
    Left = 5
    Top = 56
    Width = 244
    Height = 20
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnChange = Edit5Change
    OnDblClick = Edit5DblClick
  end
  object ComboBox1: TComboBox
    Left = 105
    Top = 4
    Width = 141
    Height = 23
    Style = csDropDownList
    Color = clInfoBk
    Ctl3D = False
    DropDownCount = 9
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Visible = False
    OnChange = ComboBox1Change
    Items.Strings = (
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '09'
      '10'
      '11'
      '12'
      '17')
  end
  object CheckBox1: TCheckBox
    Left = 4
    Top = 147
    Width = 201
    Height = 13
    Caption = 'Notas s'#227'o formulario continuo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object edArqSelos: TEdit
    Left = 3
    Top = 193
    Width = 245
    Height = 20
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnDblClick = edArqSelosDblClick
  end
  object Edit7: TEdit
    Left = 103
    Top = 168
    Width = 122
    Height = 21
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object Edit8: TEdit
    Left = 124
    Top = 317
    Width = 122
    Height = 24
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 9
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 11
  end
  object BitBtn3: TBitBtn
    Left = 20
    Top = 347
    Width = 215
    Height = 29
    Caption = 'Selar as &notas NF1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = BitBtn3Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
      000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
      99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
      0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
      FFFF3FFFFF7F337F333300000307B70FFFFF77777F73FF733F330EEE033000FF
      0FFF7F337FF777337FF30EEE00033FF000FF7F33777F333777FF0EEE0E033300
      000F7FFF7F7FFF77777F00000E00000000007777737773777777330EEE0E0330
      00FF337FFF7F7F3777F33300000E033000FF337777737F3777F333330EEE0330
      00FF33337FFF7FF77733333300000000033F3333777777777333}
    NumGlyphs = 2
  end
  object lsSelosForm: TListBox
    Left = 85
    Top = 384
    Width = 66
    Height = 14
    Style = lbOwnerDrawVariable
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object lb2: TListBox
    Left = 5
    Top = 440
    Width = 66
    Height = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 14
    Visible = False
  end
  object lb3: TListBox
    Left = 5
    Top = 408
    Width = 119
    Height = 35
    Style = lbOwnerDrawVariable
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 16
    Visible = False
  end
  object mmLog: TMemo
    Left = 263
    Top = 24
    Width = 440
    Height = 417
    Lines.Strings = (
      'Memo1')
    TabOrder = 17
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de texto *.txt;*.not|*.txt;*.not'
    Left = 160
    Top = 8
  end
  object MainMenu1: TMainMenu
    Left = 192
    Top = 31
    object Editarosselos1: TMenuItem
      Caption = 'Selos Formularios'
      OnClick = Editarosselos1Click
    end
    object EditarNumeracoes1: TMenuItem
      Caption = 'AIDF'#180's'
      OnClick = EditarNumeracoes1Click
    end
    object Selarporarquivo1: TMenuItem
      Caption = 'Selar por Arquivo'
      OnClick = Selarporarquivo1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 160
    Top = 39
  end
  object NMFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    TransferType = ftASCII
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 112
    Top = 32
  end
end
