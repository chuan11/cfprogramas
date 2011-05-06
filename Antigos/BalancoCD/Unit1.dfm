object Form1: TForm1
  Left = 197
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 56
    Width = 281
    Height = 25
    Caption = 'Buscar Codigo pelo Ean'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 30
    Top = 232
    Width = 433
    Height = 172
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 328
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 88
    Width = 625
    Height = 120
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codprod'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ean'
        Width = 200
        Visible = True
      end>
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 'FILE NAME=C:\Projetos\BalancoCD\Conexao.udl'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 8
    Top = 8
  end
  object QPesquisa: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 40
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 8
    Top = 128
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select codprod, ean from zcoletor')
    Left = 8
    Top = 96
  end
end
