object ProdutosNaLista: TProdutosNaLista
  Left = 346
  Top = 135
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 500
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 3
    Top = 91
    Width = 262
    Height = 15
    Caption = 'Clique com o bot'#227'o direito para ver as op'#231#245'es.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 24
    Top = 46
    Width = 34
    Height = 15
    Caption = 'Noiva:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 104
    Top = 46
    Width = 3
    Height = 15
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 104
    Top = 69
    Width = 3
    Height = 15
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label10: TLabel
    Left = 24
    Top = 69
    Width = 34
    Height = 15
    Caption = 'Noivo:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = -2
    Width = 514
    Height = 42
    Align = alNone
    ButtonHeight = 36
    ButtonWidth = 54
    Caption = 'ToolBar1'
    EdgeInner = esNone
    EdgeOuter = esNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Hint = 'Clique aqui para abrir uma lista.'
      ImageIndex = 4
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 54
      Top = 2
      Width = 3
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 57
      Top = 2
      Hint = 'Imprime uma lista a ser escolhida'
      Caption = 'ToolButton3'
      ImageIndex = 5
      OnClick = ToolButton3Click
    end
  end
  object DBGrid2: TDBGrid
    Left = 1
    Top = 105
    Width = 590
    Height = 392
    Color = clInfoBk
    DataSource = DataSource3
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    ParentFont = False
    PopupMenu = Popup1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BitBtn3: TBitBtn
    Left = 511
    Top = 3
    Width = 75
    Height = 32
    Caption = '&Voltar'
    TabOrder = 0
    OnClick = BitBtn3Click
    Glyph.Data = {
      7A000000424D7A000000000000003E000000280000000F0000000F0000000100
      0100000000003C000000C40E0000C40E0000020000000000000000000000FFFF
      FF00800200000100000003000000070000000F0000001FF800003FF800007FF8
      00003FF800001FF800000F00000007000000030000000100000080020000}
  end
  object Panel1: TPanel
    Left = 117
    Top = 237
    Width = 395
    Height = 470
    BevelInner = bvLowered
    TabOrder = 2
    Visible = False
    object Label6: TLabel
      Left = 8
      Top = 6
      Width = 43
      Height = 16
      Caption = 'Label6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn2: TBitBtn
      Left = 235
      Top = 434
      Width = 75
      Height = 29
      Caption = '&OK'
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkOK
    end
    object BitBtn4: TBitBtn
      Left = 315
      Top = 434
      Width = 75
      Height = 29
      Caption = '&Cancela'
      ModalResult = 3
      TabOrder = 2
      OnClick = BitBtn4Clic
      Glyph.Data = {
        96010000424D9601000000000000760000002800000018000000180000000100
        04000000000020010000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        D11DDDDDDDDDD11DDDDDDDDD1991DDDDDDDD1991DDDDDDD199991DDDDDD19999
        1DDDDDD1999991DDDD1999991DDDDDDD1999991DD1999991DDDDDDDDD1999991
        1999991DDDDDDDDDDD199999999991DDDDDDDDDDDDD1999999991DDDDDDDDDDD
        DDDD19999991DDDDDDDDDDDDDDDD19999991DDDDDDDDDDDDDDD1999999991DDD
        DDDDDDDDDD199990999991DDDDDDDDDDD19999911999991DDDDDDDDD1999991D
        D1999991DDDDDDD1999991DDDD1999991DDDDDD199991DDDDDD199991DDDDDDD
        1991DDDDDDDD1991DDDDDDDDD11DDDDDDDDDD11DDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    end
    object DBGrid3: TDBGrid
      Left = 5
      Top = 25
      Width = 386
      Height = 403
      Color = clInfoBk
      DataSource = DataSource2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = BitBtn2Click
    end
    object BitBtn1: TBitBtn
      Left = 6
      Top = 434
      Width = 81
      Height = 29
      Caption = 'Pesquisar'
      TabOrder = 3
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
        333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078888888703
        33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
        333337F3333337F333333078F8F870333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 32
    Top = 177
    Width = 513
    Height = 142
    Alignment = taRightJustify
    BevelInner = bvLowered
    TabOrder = 3
    TabStop = True
    Visible = False
    object Label2: TLabel
      Left = 5
      Top = 29
      Width = 58
      Height = 13
      AutoSize = False
      Caption = 'Produto:'
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 6
      Top = 5
      Width = 54
      Height = 18
      AutoSize = False
      Caption = 'Codigo:'
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 6
      Top = 57
      Width = 195
      Height = 13
      AutoSize = False
      Caption = 'Nome do convidado:'
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 113
      Width = 49
      Height = 18
      AutoSize = False
      Caption = 'Tipo:'
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object BitBtn5: TBitBtn
      Left = 347
      Top = 107
      Width = 75
      Height = 29
      Caption = '&OK'
      TabOrder = 0
      OnClick = BitBtn5Click
      Kind = bkOK
    end
    object BitBtn6: TBitBtn
      Left = 427
      Top = 107
      Width = 75
      Height = 29
      Caption = '&Cancela'
      ModalResult = 3
      TabOrder = 1
      OnClick = BitBtn6Click
      OnExit = BitBtn6Exit
      Glyph.Data = {
        96010000424D9601000000000000760000002800000018000000180000000100
        04000000000020010000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        D11DDDDDDDDDD11DDDDDDDDD1991DDDDDDDD1991DDDDDDD199991DDDDDD19999
        1DDDDDD1999991DDDD1999991DDDDDDD1999991DD1999991DDDDDDDDD1999991
        1999991DDDDDDDDDDD199999999991DDDDDDDDDDDDD1999999991DDDDDDDDDDD
        DDDD19999991DDDDDDDDDDDDDDDD19999991DDDDDDDDDDDDDDD1999999991DDD
        DDDDDDDDDD199990999991DDDDDDDDDDD19999911999991DDDDDDDDD1999991D
        D1999991DDDDDDD1999991DDDD1999991DDDDDD199991DDDDDD199991DDDDDDD
        1991DDDDDDDD1991DDDDDDDDD11DDDDDDDDDD11DDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    end
  end
  object DataSource2: TDataSource
    DataSet = query2
    Left = 196
    Top = 177
  end
  object DataSource3: TDataSource
    DataSet = Query3
    Left = 8
    Top = 156
  end
  object Popup1: TPopupMenu
    AutoPopup = False
    MenuAnimation = [maLeftToRight]
    Left = 179
    Top = 6
    object InserirProdutos1: TMenuItem
      Caption = 'Inserir Produtos'
      ImageIndex = 1
      OnClick = InserirProdutos1Click
    end
    object TMenuItem
      AutoHotkeys = maAutomatic
      AutoLineReduction = maAutomatic
      Enabled = False
    end
    object InserirComprador1: TMenuItem
      Caption = 'Inserir Comprador'
      ImageIndex = 6
      OnClick = InserirComprador1Click
    end
    object InserirComprador2: TMenuItem
      Caption = 'Alterar este item'
      ImageIndex = 7
      OnClick = InserirComprador2Click
    end
    object Delete1: TMenuItem
      Caption = 'Deletar da lista'
      ImageIndex = 3
      OnClick = Delete1Click
    end
  end
  object query1: TADOQuery
    Parameters = <>
    Left = 376
    Top = 8
  end
  object query2: TADOQuery
    Parameters = <>
    Left = 166
    Top = 178
  end
  object Query3: TADOQuery
    Parameters = <>
    Left = 40
    Top = 155
  end
end
