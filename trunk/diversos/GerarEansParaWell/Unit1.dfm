object Form1: TForm1
  Left = 192
  Top = 107
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
  object Label1: TLabel
    Left = 16
    Top = 216
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 16
    Top = 240
    Width = 161
    Height = 13
    Caption = 'Label1'
  end
  object FlatButton1: TFlatButton
    Left = 200
    Top = 48
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object Memo: TFlatMemo
    Left = 32
    Top = 288
    Width = 393
    Height = 121
    ColorFlat = clBtnFace
    ParentColor = True
    TabOrder = 1
    Lines.Strings = (
      'Memo')
  end
  object Edit1: TFlatEdit
    Left = 16
    Top = 48
    Width = 121
    Height = 26
    ColorFlat = clBtnFace
    ParentColor = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'Edit1'
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 88
    Width = 641
    Height = 120
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object FlatButton2: TFlatButton
    Left = 192
    Top = 224
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = FlatButton2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 'FILE NAME=C:\ProgramasDiversos\ConexaoAoWell.udl'
    LoginPrompt = False
    Provider = 'C:\ProgramasDiversos\ConexaoAoWell.udl'
    Left = 344
    Top = 16
  end
  object Q1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 384
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = Q1
    Left = 120
    Top = 96
  end
  object q2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 440
    Top = 16
  end
end
