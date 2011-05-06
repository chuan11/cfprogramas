object Form1: TForm1
  Left = 254
  Top = 146
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 410
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 179
    Width = 790
    Height = 212
    TabStop = False
    Align = alBottom
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 13
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'DTAGEND'
        Title.Caption = 'Data'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANPORTADOR'
        Title.Caption = 'Transportador'
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORN'
        Title.Caption = 'Fornecedor'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTA'
        Title.Caption = 'NF'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMVOLUMES'
        Title.Caption = 'N Vol'
        Width = 33
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTATO'
        Title.Caption = 'Contato'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PREVCHEGADA'
        Title.Caption = 'DT Chegada'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGENDADOR'
        Title.Caption = 'Agendador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RECEBIDA'
        Visible = True
      end>
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 391
    Width = 790
    Height = 19
    Panels = <
      item
        Width = 550
      end
      item
        Width = 50
      end>
  end
  object DBEdit2: TadLabelDBEdit
    Left = 3
    Top = 59
    Width = 300
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataField = 'TRANPORTADOR'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 2
    LabelDefs.Width = 80
    LabelDefs.Height = 14
    LabelDefs.Caption = 'Transportador'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object BitBtn1: TBitBtn
    Left = 636
    Top = 152
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 8
    Visible = False
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 713
    Top = 0
    Width = 75
    Height = 25
    Caption = '&Incluir'
    TabOrder = 10
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 713
    Top = 29
    Width = 75
    Height = 25
    Caption = '&Alterar'
    TabOrder = 11
    OnClick = BitBtn3Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object BitBtn4: TBitBtn
    Left = 713
    Top = 58
    Width = 75
    Height = 25
    Caption = '&Deletar'
    TabOrder = 12
    OnClick = BitBtn4Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      300033FFFFFF3333377739999993333333333777777F3333333F399999933333
      3300377777733333337733333333333333003333333333333377333333333333
      3333333333333333333F333333333333330033333F33333333773333C3333333
      330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
      333333377F33333333FF3333C333333330003333733333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn5: TBitBtn
    Left = 713
    Top = 152
    Width = 75
    Height = 25
    Caption = '&Cancela'
    TabOrder = 9
    Visible = False
    OnClick = BitBtn5Click
    Kind = bkCancel
  end
  object DBEdit3: TadLabelDBEdit
    Left = 308
    Top = 59
    Width = 300
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataField = 'FORN'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 3
    LabelDefs.Width = 64
    LabelDefs.Height = 14
    LabelDefs.Caption = 'Fornecedor'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object MaskEdit1: TadLabelMaskEdit
    Left = 3
    Top = 22
    Width = 88
    Height = 19
    Ctl3D = False
    Enabled = False
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    ParentCtl3D = False
    TabOrder = 0
    Text = '  /  /    '
    OnChange = MaskEdit1Change
    LabelDefs.Width = 104
    LabelDefs.Height = 14
    LabelDefs.Caption = 'Data Agendamento'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object dbedit1: TadLabelDBEdit
    Left = 108
    Top = 23
    Width = 49
    Height = 19
    Ctl3D = False
    DataField = 'DTAGEND'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 1
    Visible = False
    OnChange = DBEdit1Change
    LabelDefs.Width = 41
    LabelDefs.Height = 14
    LabelDefs.Caption = 'dbedit1'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
  end
  object DBEdit4: TadLabelDBEdit
    Left = 3
    Top = 99
    Width = 139
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataField = 'NOTA'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 4
    LabelDefs.Width = 52
    LabelDefs.Height = 14
    LabelDefs.Caption = 'Num nota'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object DBEdit5: TadLabelDBEdit
    Left = 148
    Top = 99
    Width = 139
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataField = 'NUMVOLUMES'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 5
    LabelDefs.Width = 77
    LabelDefs.Height = 14
    LabelDefs.Caption = 'NUMVOLUMES'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object DBEdit6: TadLabelDBEdit
    Left = 309
    Top = 99
    Width = 300
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataField = 'CONTATO'
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 6
    LabelDefs.Width = 43
    LabelDefs.Height = 14
    LabelDefs.Caption = 'Contato'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object LookupCB1: TadLabelDBLookupComboBox
    Left = 148
    Top = 139
    Width = 159
    Height = 19
    Ctl3D = False
    DataField = 'AGENDADOR'
    DataSource = DataSource1
    Enabled = False
    KeyField = 'Nome'
    ListField = 'Nome'
    ListSource = DataSource2
    ParentCtl3D = False
    TabOrder = 7
    LabelDefs.Width = 66
    LabelDefs.Height = 14
    LabelDefs.Caption = 'AGENDADOR'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Arial'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = 14811135
  end
  object dtchegada: TadLabelDBDateTimePicker
    Left = 4
    Top = 138
    Width = 137
    Height = 21
    Date = 39920.390865659720000000
    Time = 39920.390865659720000000
    Enabled = False
    TabOrder = 15
    DataField = 'PREVCHEGADA'
    DataSource = DataSource1
    LabelDefs.Width = 81
    LabelDefs.Height = 13
    LabelDefs.Caption = 'PREVCHEGADA'
  end
  object DataSource2: TDataSource
    DataSet = ADOTable2
    Left = 308
    Top = 138
  end
  object MainMenu1: TMainMenu
    Left = 468
    Top = 3
    object Relatorios1: TMenuItem
      Caption = 'Verificar Chegadas/Baixar'
      OnClick = Relatorios1Click
    end
    object Agendadores1: TMenuItem
      Caption = 'Agendadores'
      OnClick = Agendadores1Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 246
    Top = 3
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 370
    Top = 2
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 312
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'zcf_AgendaRecNotas'
    Left = 336
  end
  object ADOTable2: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'zcf_AgendadoresRecNotas'
    Left = 336
    Top = 136
  end
end
