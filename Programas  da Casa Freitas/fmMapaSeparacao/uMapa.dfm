object fmMapa: TfmMapa
  Left = 214
  Top = 222
  Width = 790
  Height = 519
  Caption = 'fmMapa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 90
    Width = 774
    Height = 371
    Align = alClient
    BiDiMode = bdLeftToRight
    Ctl3D = False
    DataSource = DataSource1
    ParentBiDiMode = False
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = gridColEnter
    OnColExit = gridColExit
    OnDblClick = gridDblClick
    OnKeyDown = gridKeyDown
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object pnTitulo: TFlatPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 90
    ParentColor = True
    Align = alTop
    TabOrder = 1
    DesignSize = (
      774
      90)
    object lbNumMp: TLabel
      Left = 65
      Top = 1
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 141
      Top = 1
      Width = 32
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDtAvaria: TLabel
      Left = 175
      Top = 1
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 5
      Top = 14
      Width = 37
      Height = 13
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNome: TLabel
      Left = 57
      Top = 14
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 363
      Top = 3
      Width = 65
      Height = 13
      Caption = 'Mensagem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 59
      Width = 41
      Height = 13
      Caption = 'Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbStatus: TLabel
      Left = 53
      Top = 58
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 1
      Width = 52
      Height = 13
      Caption = 'N'#250'mero: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 29
      Width = 45
      Height = 13
      Caption = 'Criador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 6
      Top = 44
      Width = 63
      Height = 13
      Caption = 'Aprovador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbAprovador: TLabel
      Left = 74
      Top = 46
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCriador: TLabel
      Left = 65
      Top = 29
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 367
      Top = 73
      Width = 224
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Clique com o bot'#227'o direito para o menu de itens'
    end
    object lbCodCriador: TLabel
      Left = 143
      Top = 28
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object mmObs: TfsMemo
      Left = 362
      Top = 17
      Width = 251
      Height = 53
      Anchors = [akLeft, akTop, akRight]
      Color = clInfoBk
      TabOrder = 0
    end
    object cbCriticaQuant: TfsCheckBox
      Left = 444
      Top = 34
      Width = 92
      Height = 17
      Caption = 'Critica estoque'
      TabOrder = 1
      Visible = False
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 112
    Top = 184
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    AfterOpen = tbAfterOpen
    BeforePost = tbBeforePost
    Left = 80
    Top = 184
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 184
    object Nova1: TMenuItem
      Caption = 'Nova'
      OnClick = Nova1Click
    end
    object Abrir1: TMenuItem
      Caption = 'Abrir'
      OnClick = Abrir1Click
    end
    object Salvar1: TMenuItem
      Caption = 'Salvar'
      OnClick = Salvar1Click
    end
    object Aprovar1: TMenuItem
      Caption = 'Aprovar'
      OnClick = Aprovar1Click
    end
    object Imprimir1: TMenuItem
      Caption = 'Imprimir'
      OnClick = Imprimir1Click
    end
    object Inserir1: TMenuItem
      Caption = 'Inserir produto'
      Enabled = False
      OnClick = Inserir1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 184
    object Listarentradasdoproduto1: TMenuItem
      Caption = 'Entradas / compras'
      OnClick = Listarentradasdoproduto1Click
    end
    object Resumodeestoquedaslojas1: TMenuItem
      Caption = 'Estoque nas lojas'
      OnClick = Resumodeestoquedaslojas1Click
    end
    object Vendasnoperiodo1: TMenuItem
      Caption = 'Saidas'
      OnClick = Vendasnoperiodo1Click
    end
    object Resumoentradassaidas1: TMenuItem
      Caption = 'Resumo ent/sai'
    end
    object Verrequisicoes1: TMenuItem
      Caption = 'Ver requisi'#231#245'es'
      OnClick = Verrequisicoes1Click
    end
  end
end
