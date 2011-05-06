object fmProposta: TfmProposta
  Left = 276
  Top = 192
  Width = 815
  Height = 564
  Caption = '(01) Gerador de propostas da Loja.'
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  DesignSize = (
    799
    526)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 121
    Width = 100
    Height = 13
    Caption = 'Itens da proposta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grid: TSoftDBGrid
    Left = 5
    Top = 141
    Width = 781
    Height = 292
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColExit = gridColExit
    OnDblClick = gridDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object gb1: TGroupBox
    Left = 4
    Top = 5
    Width = 637
    Height = 113
    Caption = '  Dados do Cliente  '
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object edNmCli: TadLabelEdit
      Left = 58
      Top = 44
      Width = 330
      Height = 19
      LabelDefs.Width = 34
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nome: '
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btDadosCliente: TFlatButton
      Left = 234
      Top = 19
      Width = 28
      Height = 19
      Hint = 'Obter Dados do Cliente'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btDadosClienteClick
    end
    object edEnd: TadLabelEdit
      Left = 58
      Top = 66
      Width = 330
      Height = 19
      LabelDefs.Width = 46
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Endere'#231'o'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edMsg: TadLabelEdit
      Left = 58
      Top = 89
      Width = 330
      Height = 19
      LabelDefs.Width = 52
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Mensagem'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edCidade: TadLabelEdit
      Left = 431
      Top = 66
      Width = 197
      Height = 19
      LabelDefs.Width = 36
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Cidade '
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object EdNrCGC: TadLabelEdit
      Left = 58
      Top = 19
      Width = 93
      Height = 19
      LabelDefs.Width = 42
      LabelDefs.Height = 13
      LabelDefs.Caption = 'CPFCGC'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 5
    end
    object edFilCPFCGC: TadLabelEdit
      Left = 154
      Top = 19
      Width = 41
      Height = 19
      LabelDefs.Width = 64
      LabelDefs.Height = 13
      LabelDefs.Caption = 'edFilCPFCGC'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 6
    end
    object edDgCGC: TadLabelEdit
      Left = 200
      Top = 19
      Width = 23
      Height = 19
      LabelDefs.Width = 6
      LabelDefs.Height = 13
      LabelDefs.Caption = '  '
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 7
    end
  end
  object sbar: TStatusBar
    Left = 0
    Top = 507
    Width = 799
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 448
    Width = 799
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 404
      Top = 10
      Width = 82
      Height = 13
      Caption = 'Data da proposta'
    end
    object edFmPag: TadLabelEdit
      Left = 105
      Top = 8
      Width = 287
      Height = 19
      LabelDefs.Width = 100
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Forma de pagamento'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edVendedor: TadLabelEdit
      Left = 105
      Top = 30
      Width = 287
      Height = 19
      LabelDefs.Width = 46
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Vendedor'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object dtProposta: TfsDateTimePicker
      Left = 400
      Top = 27
      Width = 90
      Height = 21
      Date = 39723.536439884260000000
      Time = 39723.536439884260000000
      TabOrder = 2
    end
    object edValidade: TadLabelSpinEdit
      Left = 512
      Top = 26
      Width = 101
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 142
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Validade da proposta em dias:'
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 3
      Value = 5.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
  end
  object FlatButton1: TFlatButton
    Left = 692
    Top = 6
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Nova'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object btImp: TFlatButton
    Left = 692
    Top = 43
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Imprimir'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btImpClick
  end
  object FlatButton3: TFlatButton
    Left = 692
    Top = 82
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Enviar p/ e-mail'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = FlatButton3Click
  end
  object Table: TADOTable
    Connection = fmMain.Conexao
    AfterPost = TableAfterPost
    Left = 184
    Top = 168
    object Tablecodigo: TStringField
      FieldName = 'Codigo'
      Size = 13
    end
    object TableDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object TableQuant: TIntegerField
      FieldName = 'Quant'
    end
    object Tableund: TBCDField
      FieldName = 'und'
      DisplayFormat = '#,###,###0.00'
    end
    object Tabletotal: TBCDField
      FieldName = 'total'
      DisplayFormat = '#,###,###0.00'
      Size = 0
    end
  end
  object DataSource1: TDataSource
    DataSet = Table
    Left = 136
    Top = 168
  end
end
