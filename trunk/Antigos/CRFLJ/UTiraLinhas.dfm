object Form1: TForm1
  Left = 224
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 301
  ClientWidth = 520
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
  object Label2: TLabel
    Left = 13
    Top = 31
    Width = 50
    Height = 13
    Caption = 'Salvar em:'
  end
  object Label1: TLabel
    Left = 16
    Top = 216
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 71
    Top = 3
    Width = 322
    Height = 21
    BorderStyle = bsNone
    Color = clInfoBk
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 71
    Top = 29
    Width = 322
    Height = 21
    BorderStyle = bsNone
    Color = clInfoBk
    TabOrder = 1
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 425
    Top = 2
    Width = 60
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
  end
  object ListBox1: TListBox
    Left = 0
    Top = 54
    Width = 297
    Height = 140
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 277
    Width = 520
    Height = 24
    Panels = <>
    SimplePanel = False
  end
  object BitBtn5: TBitBtn
    Left = 226
    Top = 196
    Width = 169
    Height = 47
    Caption = 'ReMontar CRFLJ '
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BitBtn5Click
  end
  object CheckBox1: TCheckBox
    Left = 400
    Top = 32
    Width = 97
    Height = 17
    Caption = 'Carregar arquivo'
    TabOrder = 6
  end
  object Memo1: TMemo
    Left = 302
    Top = 54
    Width = 89
    Height = 139
    Color = clInfoBk
    Lines.Strings = (
      '01'
      '02'
      '03'
      '05'
      '06'
      '10'
      '11'
      '12'
      '17')
    TabOrder = 7
  end
  object Button1: TButton
    Left = 392
    Top = 144
    Width = 123
    Height = 25
    Caption = 'edit3.text->edit4.text'
    TabOrder = 8
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 392
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 9
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 392
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'Edit4'
  end
  object StatusBar2: TStatusBar
    Left = 0
    Top = 248
    Width = 520
    Height = 29
    Panels = <>
    SimplePanel = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de texto|*.TMP;*.TXT;*.PRN'
    Left = 488
  end
end
