object Form1: TForm1
  Left = 795
  Top = 150
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '(08) Impressora Pedidos/Relat'#243'rio'
  ClientHeight = 230
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 4
    Width = 53
    Height = 13
    Caption = 'Terminal:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 2
    Top = 27
    Width = 66
    Height = 13
    Caption = 'Impressora:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 146
    Width = 285
    Height = 75
    Caption = '  N'#227'o configurar as impressoras   '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    object CheckRel: TCheckBox
      Left = 5
      Top = 18
      Width = 136
      Height = 17
      Caption = 'Impressora de relat'#243'rios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = CheckRelClick
    end
    object CheckCont: TCheckBox
      Left = 5
      Top = 54
      Width = 139
      Height = 17
      Caption = 'Impressora de Contratos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = CheckContClick
    end
    object CheckPed: TCheckBox
      Left = 5
      Top = 36
      Width = 130
      Height = 17
      Caption = 'Impressora de pedidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = CheckPedClick
    end
    object cbBoleto: TCheckBox
      Left = 154
      Top = 54
      Width = 121
      Height = 17
      Caption = 'Impressora de boletos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = cbBoletoClick
    end
    object cbNotas: TCheckBox
      Left = 154
      Top = 36
      Width = 119
      Height = 17
      Caption = 'Impressora de notas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = cbNotasClick
    end
    object cbCarne: TCheckBox
      Left = 154
      Top = 18
      Width = 124
      Height = 17
      Caption = 'Impressora de carnes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = cbCarneClick
    end
  end
  object Button1: TButton
    Left = 214
    Top = 74
    Width = 75
    Height = 25
    Caption = '&Executar'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 69
    Top = 25
    Width = 222
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 69
    Top = 2
    Width = 222
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 2
  end
  object checkNaoConfigurar: TCheckBox
    Left = 5
    Top = 104
    Width = 192
    Height = 17
    Caption = 'N'#227'o configure nenhuma impressora '
    TabOrder = 4
    Visible = False
    OnClick = checkNaoConfigurarClick
  end
  object CbThin: TCheckBox
    Left = 5
    Top = 120
    Width = 192
    Height = 13
    Caption = 'Configura Generica no Thin Client'
    TabOrder = 5
    Visible = False
    OnClick = CbThinClick
  end
  object cBox: TfsComboBox
    Left = 69
    Top = 49
    Width = 222
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 6
    Visible = False
    OnChange = cBoxChange
    Items.Strings = (
      ' < Nenhuma >')
  end
  object Query: TADOQuery
    Connection = Connection
    Parameters = <>
    Left = 44
    Top = 72
  end
  object Connection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 14
    Top = 73
  end
  object query2: TADOQuery
    Connection = Connection
    Parameters = <>
    Left = 76
    Top = 71
  end
end
