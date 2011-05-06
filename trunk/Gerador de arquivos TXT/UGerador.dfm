object Form1: TForm1
  Left = 205
  Top = 42
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro dos layouts de importacao'
  ClientHeight = 531
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 741
    Height = 233
    Align = alTop
    BorderStyle = bsSingle
    Caption = 'Panel1'
    TabOrder = 4
    object Label1: TLabel
      Left = 3
      Top = 15
      Width = 78
      Height = 13
      Caption = 'Nome do campo'
    end
    object Label3: TLabel
      Left = 3
      Top = 39
      Width = 67
      Height = 13
      Caption = 'Posicao inicial'
    end
    object Label2: TLabel
      Left = 3
      Top = 63
      Width = 45
      Height = 13
      Caption = 'Tamanho'
    end
    object Label4: TLabel
      Left = 91
      Top = 158
      Width = 6
      Height = 13
      Caption = #224
    end
    object b1: TButton
      Left = 87
      Top = 202
      Width = 71
      Height = 25
      Caption = 'b1'
      TabOrder = 5
      OnClick = b1Click
    end
    object ch1: TCheckBox
      Left = 3
      Top = 89
      Width = 142
      Height = 17
      Caption = 'Preencha o intevalo com:'
      TabOrder = 3
      OnClick = ch1Click
    end
    object Edit4: TEdit
      Left = 147
      Top = 87
      Width = 29
      Height = 21
      MaxLength = 1
      TabOrder = 4
      Text = '0'
      Visible = False
    end
    object Edit3: TEdit
      Left = 84
      Top = 59
      Width = 153
      Height = 21
      MaxLength = 3
      TabOrder = 2
      Text = 'Edit3'
    end
    object Edit2: TEdit
      Left = 84
      Top = 35
      Width = 153
      Height = 21
      MaxLength = 3
      TabOrder = 1
      Text = 'Edit2'
    end
    object Edit1: TEdit
      Left = 84
      Top = 11
      Width = 153
      Height = 21
      MaxLength = 20
      TabOrder = 0
      Text = 'Edit1'
    end
    object sg1: TStringGrid
      Left = 242
      Top = 11
      Width = 543
      Height = 188
      ColCount = 8
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
      TabOrder = 7
      OnDblClick = sg1DblClick
      OnSelectCell = sg1SelectCell
      ColWidths = (
        64
        108
        85
        97
        65
        64
        64
        64)
    end
    object bit1: TBitBtn
      Left = 635
      Top = 201
      Width = 47
      Height = 25
      TabOrder = 8
      OnClick = bit1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
        0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
        B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
        FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
        FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
        FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
        0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
        0555555555777777755555555555555555555555555555555555}
      NumGlyphs = 2
    end
    object bit2: TBitBtn
      Left = 685
      Top = 201
      Width = 47
      Height = 25
      TabOrder = 9
      OnClick = bit2Click
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
      Style = bsNew
    end
    object b2: TButton
      Left = 163
      Top = 202
      Width = 75
      Height = 25
      Caption = 'b2'
      TabOrder = 6
    end
    object ch2: TCheckBox
      Left = 3
      Top = 111
      Width = 231
      Height = 17
      Caption = 'Retirar caracteres n'#227'o alfanumericos'
      TabOrder = 10
    end
    object ch3: TCheckBox
      Left = 3
      Top = 131
      Width = 194
      Height = 17
      Caption = 'Se houver espa'#231'os preencha com:'
      TabOrder = 11
    end
    object cbox1: TComboBox
      Left = 20
      Top = 154
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 12
      Items.Strings = (
        '"0"'
        '" "')
    end
    object cbox2: TComboBox
      Left = 108
      Top = 154
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 13
      Items.Strings = (
        'DIR'
        'ESQ')
    end
  end
  object Edit5: TEdit
    Left = 2
    Top = 272
    Width = 377
    Height = 21
    Cursor = crHandPoint
    TabOrder = 0
    OnClick = Edit5Click
  end
  object BitBtn1: TBitBtn
    Left = 392
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Gerar!'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 512
    Width = 741
    Height = 19
    Panels = <>
  end
  object Memo1: TMemo
    Left = 1
    Top = 296
    Width = 736
    Height = 211
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object open2: TOpenDialog
    Filter = 'Arquivios de texto|*.tmp;*.txt'
    InitialDir = 'c:\'
    Title = 'Selecionar o arquivo de origem'
    Left = 32
    Top = 270
  end
  object Save1: TSaveDialog
    Filter = 'Arquivos de Layout|*.lai'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 272
    Top = 131
  end
  object Open1: TOpenDialog
    Filter = 'Arquivos de Layout|*.lai'
    InitialDir = 'C:\Projetos\Gerado~1'
    Title = 'Selecione o arquivo de Layout , *.lai'
    Left = 304
    Top = 131
  end
end
