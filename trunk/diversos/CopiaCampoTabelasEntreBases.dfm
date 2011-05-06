object Form1: TForm1
  Left = 192
  Top = 103
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 128
    Top = 16
    Width = 553
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 120
    Top = 176
    Width = 553
    Height = 120
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 192
    Top = 360
    Width = 75
    Height = 25
    Caption = '&Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=ADM;Init' +
      'ial Catalog=WellTreinamento;Data Source=125.4.4.200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT CD_REF, DS_REF FROM CREFE WHERE CD_REF LIKE '#39'231%'#39)
    Left = 80
    Top = 16
  end
  object ADOConnection2: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=ADM;Init' +
      'ial Catalog=WellCfreitas;Data Source=125.4.4.200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 168
  end
  object ADOQuery2: TADOQuery
    Active = True
    Connection = ADOConnection2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT CD_REF, DS_REF FROM CREFE WHERE CD_REF LIKE '#39'231%'#39)
    Left = 80
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 48
    Top = 48
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 40
    Top = 200
  end
end
