object Form1: TForm1
  Left = 265
  Top = 129
  Width = 800
  Height = 456
  Anchors = [akTop, akRight]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    784
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object sb: TStatusBar
    Left = 0
    Top = 379
    Width = 784
    Height = 19
    Anchors = [akBottom]
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 537
    Top = 2
    Width = 243
    Height = 116
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      243
      116)
    object GroupBox1: TGroupBox
      Left = 5
      Top = 43
      Width = 238
      Height = 68
      Anchors = [akTop, akRight]
      Caption = 'Listas que vencem :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 103
        Top = 35
        Width = 27
        Height = 13
        Caption = ' at'#233' '
      end
      object dp1: TDateTimePicker
        Left = 4
        Top = 30
        Width = 97
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvRaised
        BevelKind = bkSoft
        Date = 39290.610618668980000000
        Time = 39290.610618668980000000
        TabOrder = 0
        OnChange = dp1Change
      end
      object dp2: TDateTimePicker
        Left = 136
        Top = 30
        Width = 97
        Height = 22
        Date = 39290.610618668980000000
        Time = 39290.610618668980000000
        TabOrder = 1
        OnChange = dp2Change
      end
    end
    object cb1: TadLabelComboBox
      Left = 99
      Top = 15
      Width = 142
      Height = 21
      BevelKind = bkFlat
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
      OnChange = cb1Change
      Items.Strings = (
        '- Todas'
        '- Per'#237'odo')
      LabelDefs.Width = 78
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Mostrar as listas:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 56
    Top = 16
    object CadastrodeListas1: TMenuItem
      Caption = '&Cadastro de Listas'
      OnClick = CadastrodeListas1Click
    end
    object ProdutosnNasListas1: TMenuItem
      Caption = '&Produtos Das Listas'
      OnClick = ProdutosnNasListas1Click
    end
    object Cadastrodetipos1: TMenuItem
      Caption = 'C&adastro de tipos'
      object iposdelistas1: TMenuItem
        Caption = 'Tipos de &listas'
        OnClick = iposdelistas1Click
      end
      object iposdeProdutos1: TMenuItem
        Caption = '&Tipos de Produtos'
        OnClick = iposdeProdutos1Click
      end
      object sugestodeProdutos1: TMenuItem
        Caption = '&Sugest'#227'o de Produtos'
        OnClick = sugestodeProdutos1Click
      end
      object Configurao1: TMenuItem
        Caption = 'Configura'#231#227'o'
        OnClick = Configurao1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object ProdutosCompradosporpeodo1: TMenuItem
        Caption = 'Produtos baixados por per'#237'odo'
        OnClick = ProdutosCompradosporpeodo1Click
      end
      object VendasTotaisporlista1: TMenuItem
        Caption = 'Produtos comprados na lista por periodo'
        OnClick = VendasTotaisporlista1Click
      end
    end
    object Geracaodecrdito1: TMenuItem
      Caption = 'Geracao de cr'#233'dito'
      OnClick = Geracaodecrdito1Click
    end
    object N1: TMenuItem
      Caption = '   '
      OnClick = N1Click
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    OnExecuteComplete = ADOConnection1ExecuteComplete
    OnWillExecute = ADOConnection1WillExecute
    Left = 261
    Top = 16
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 97
    Top = 16
  end
  object mxOneInstance1: TmxOneInstance
    SwitchToPrevious = True
    Terminate = True
    Version = '1.2'
    OnInstanceExists = mxOneInstance1InstanceExists
    Left = 29
    Top = 16
  end
  object Query1: TADOQuery
    Connection = ADOConnection1
    AfterOpen = Query1AfterOpen
    OnDeleteError = Query1DeleteError
    Parameters = <>
    Left = 143
    Top = 16
  end
  object table1: TADOTable
    Connection = ADOConnection1
    Left = 200
    Top = 16
  end
  object RvProject1: TRvProject
    Engine = RvSystem
    ProjectFile = 'C:\Listas\EspelhoLista.rav'
    Left = 32
    Top = 256
  end
  object RvDSConn: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 64
    Top = 256
  end
  object RvSystem: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 104
    Top = 256
  end
  object ConexaoWell: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=wellCfreitas;Data Source=125.4.4.200'
    ConnectionTimeout = 0
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnWillExecute = ConexaoWellWillExecute
    Left = 40
    Top = 312
  end
end
