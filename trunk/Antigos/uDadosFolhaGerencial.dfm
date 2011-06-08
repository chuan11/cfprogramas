object Form1: TForm1
  Left = 245
  Top = 104
  Width = 638
  Height = 412
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Gera'#231#227'o de relat'#243'rio folha por localiza'#231#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 45
    Top = 0
    Width = 62
    Height = 13
    Caption = 'Compet'#234'ncia'
  end
  object Label2: TLabel
    Left = 153
    Top = 0
    Width = 20
    Height = 13
    Caption = 'Loja'
  end
  object ComboBox1: TComboBox
    Left = 153
    Top = 15
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      '01 - Matriz'
      '02 - Escrit'#243'rio'
      '03 - Edgar Borges'
      '04 - Br 116'
      '05 - Pedro Borges'
      '06 - Dom Luis'
      '07 - Maison'
      '09 - Senador Teodoro'
      '10 - Messejana'
      '11 - Montese'
      '12 - Iguatemi'
      '13 - CD'
      '16 - Paissandu'
      '17 - Liberato Barroso')
  end
  object FlatButton1: TFlatButton
    Left = 330
    Top = 14
    Width = 78
    Height = 25
    Caption = '&Calcular'
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 57
    Width = 625
    Height = 320
    DataSource = DataSource3
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object DP1: TDateTimePicker
    Left = 45
    Top = 16
    Width = 90
    Height = 21
    Date = 39353.718082500010000000
    Format = 'MM/yyyy'
    Time = 39353.718082500010000000
    TabOrder = 3
  end
  object Button1: TButton
    Left = 544
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    Visible = False
  end
  object Connection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Init' +
      'ial Catalog=FLUXUS001;Data Source=125.4.4.200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 440
    Top = 8
  end
  object Query1: TADOQuery
    Connection = Connection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 464
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 504
    Top = 8
  end
  object Connection2: TADOConnection
    LoginPrompt = False
    Left = 8
    Top = 216
  end
  object Query2: TADOQuery
    Connection = Connection2
    Parameters = <>
    Left = 40
    Top = 216
  end
  object DataSource2: TDataSource
    DataSet = Query2
    Left = 72
    Top = 216
  end
  object Connection3: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=True;User ID=adm;Initi' +
      'al Catalog=FLUXUS001;Data Source=125.4.4.200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 120
  end
  object Query3: TADOQuery
    Active = True
    Connection = Connection3
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from DadosFolha')
    Left = 64
    Top = 120
    object Query3emp_nome: TStringField
      DisplayWidth = 53
      FieldName = 'emp_nome'
      FixedChar = True
      Size = 60
    end
    object Query3Salario: TFloatField
      DisplayWidth = 15
      FieldName = 'Salario'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3SalarioFamilia: TFloatField
      DisplayWidth = 16
      FieldName = 'SalarioFamilia'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3QuebraDeCaixa: TFloatField
      DisplayWidth = 18
      FieldName = 'QuebraDeCaixa'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3SalarioMaternidade: TFloatField
      DisplayWidth = 22
      FieldName = 'SalarioMaternidade'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3Unimed: TFloatField
      DisplayWidth = 15
      FieldName = 'Unimed'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3Faltas: TFloatField
      DisplayWidth = 15
      FieldName = 'Faltas'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3INSS: TFloatField
      DisplayWidth = 15
      FieldName = 'INSS'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3ValeTransporte: TFloatField
      DisplayWidth = 18
      FieldName = 'ValeTransporte'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3OdontoSystem: TFloatField
      DisplayWidth = 17
      FieldName = 'OdontoSystem'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3MensalidadeSindical: TFloatField
      DisplayWidth = 24
      FieldName = 'MensalidadeSindical'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3DentalMaster: TFloatField
      DisplayWidth = 16
      FieldName = 'DentalMaster'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3ContribuicaoSindical: TFloatField
      DisplayWidth = 23
      FieldName = 'ContribuicaoSindical'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3PensaoAlimenticia: TFloatField
      DisplayWidth = 21
      FieldName = 'PensaoAlimenticia'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3Adiantamento: TFloatField
      DisplayWidth = 16
      FieldName = 'Adiantamento'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3ValesECompras: TFloatField
      DisplayWidth = 18
      FieldName = 'ValesECompras'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3HapVida: TFloatField
      DisplayWidth = 15
      FieldName = 'HapVida'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3AdicionalNoturno: TFloatField
      DisplayWidth = 19
      FieldName = 'AdicionalNoturno'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
    end
    object Query3Vtloja: TFloatField
      FieldName = 'Vtloja'
      DisplayFormat = '#,###,###0.00'
    end
  end
  object DataSource3: TDataSource
    DataSet = Query3
    Left = 96
    Top = 120
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\Projetos\diversos\FolhaGerencial.rav'
    Left = 256
    Top = 128
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query3
    Left = 296
    Top = 128
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 224
    Top = 128
  end
end
