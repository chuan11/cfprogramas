object frmProgramador: TfrmProgramador
  Left = 356
  Top = 204
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informações sobre o Programador'
  ClientHeight = 336
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 152
    Top = 199
    Width = 78
    Height = 16
    Caption = 'Observação:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 96
    Top = 16
    Width = 159
    Height = 19
    Caption = 'Fernando Gonçalves'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = -3
    Top = 184
    Width = 380
    Height = 9
    Brush.Color = clTeal
    Brush.Style = bsDiagCross
  end
  object BitBtn1: TBitBtn
    Left = 311
    Top = 311
    Width = 65
    Height = 25
    Caption = '&Ok'
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
  end
  object Memo1: TMemo
    Left = 0
    Top = 220
    Width = 377
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      
        'Gostaria de dizer que estou feliz em concluir meu primeiro siste' +
        'ma, e que devo '
      'agradecer a ajuda de várias pessoa do news: '
      
        'uol.mundodigital.linguagens.delphi, que me ajudaram em muitas da' +
        's minhas '
      'dúvidas.'
      'Abrações a todos e sucessos.')
    ParentFont = False
    TabOrder = 1
    OnKeyPress = Memo1KeyPress
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 377
    Height = 137
    Caption = 'Contatos:'
    TabOrder = 2
    object Label5: TLabel
      Left = 104
      Top = 65
      Width = 170
      Height = 16
      Cursor = crHandPoint
      Hint = 'delphicompany@ieg.com.br'
      Caption = 'delphicompany@ieg.com.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Label5Click
    end
    object Label7: TLabel
      Left = 8
      Top = 17
      Width = 192
      Height = 16
      Cursor = crHandPoint
      Hint = 'fernando_goncalves@ig.com.br'
      Caption = 'fernando_goncalves@ig.com.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Label7Click
    end
    object Label1: TLabel
      Left = 176
      Top = 112
      Width = 193
      Height = 16
      Cursor = crHandPoint
      Hint = 'www.delphicompany.hpg.com.br'
      Caption = 'www.delphicompany.hpg.com.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Label1Click
    end
  end
end
