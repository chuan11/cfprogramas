object Form2: TForm2
  Left = 249
  Top = -1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Digita'#231#227'o dos selos '
  ClientHeight = 532
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 129
    Top = 10
    Width = 48
    Height = 13
    Caption = 'Selo inicio'
  end
  object Label2: TLabel
    Left = 6
    Top = 10
    Width = 50
    Height = 13
    Caption = 'Nota fiscal'
  end
  object Label3: TLabel
    Left = 198
    Top = 62
    Width = 35
    Height = 25
    AutoSize = False
    Caption = 'Ok'
    Color = clInfoBk
    ParentColor = False
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 131
    Top = 62
    Width = 55
    Height = 25
    AutoSize = False
    Caption = 'Num Selo'
    Color = clInfoBk
    ParentColor = False
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 61
    Top = 62
    Width = 67
    Height = 25
    AutoSize = False
    Caption = 'Numero Nota'
    Color = clInfoBk
    ParentColor = False
    OnClick = Label5Click
  end
  object SEdit1: TSpinEdit
    Left = 6
    Top = 27
    Width = 121
    Height = 29
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxValue = 0
    MinValue = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Value = 0
    OnKeyDown = SEdit1KeyDown
    OnKeyUp = SEdit1KeyUp
  end
  object SEdit2: TSpinEdit
    Left = 129
    Top = 27
    Width = 118
    Height = 29
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxValue = 999999999
    MinValue = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    Value = 0
    OnKeyDown = SEdit2KeyDown
  end
  object lb1: TListBox
    Left = 5
    Top = 94
    Width = 267
    Height = 350
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 17
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    OnClick = lb1Click
    OnDblClick = lb1DblClick
  end
  object BitBtn2: TBitBtn
    Left = 196
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
  end
  object BitBtn1: TBitBtn
    Left = 112
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00550000000005
      555555777777777FF5555500000000805555557777777777FF555550BBBBB008
      05555557F5FFF7777FF55550B000B030805555F7F777F7F777F550000000B033
      005557777777F7F5775550BBBBB00033055557F5FFF777F57F5550B000B08033
      055557F77757F7F57F5550BBBBB08033055557F55557F7F57F5550BBBBB00033
      055557FFFFF777F57F5550000000703305555777777757F57F555550FFF77033
      05555557FFFFF7FF7F55550000000003055555777777777F7F55550777777700
      05555575FF5555777F55555003B3B3B00555555775FF55577FF55555500B3B3B
      005555555775FFFF77F555555570000000555555555777777755}
    NumGlyphs = 2
  end
end
