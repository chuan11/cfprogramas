object Form4: TForm4
  Left = 401
  Top = 220
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Venda total no per'#237'odo'
  ClientHeight = 181
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 28
    Width = 38
    Height = 13
    Caption = 'Per'#237'odo'
  end
  object Label2: TLabel
    Left = 103
    Top = 49
    Width = 15
    Height = 13
    Caption = 'at'#233
  end
  object Label4: TLabel
    Left = 5
    Top = 4
    Width = 317
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 6
    Top = 72
    Width = 283
    Height = 105
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dt01: TDateTimePicker
    Left = 5
    Top = 46
    Width = 94
    Height = 21
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    TabOrder = 1
  end
  object dt02: TDateTimePicker
    Left = 128
    Top = 46
    Width = 94
    Height = 21
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    TabOrder = 2
  end
  object FlatButton1: TFlatButton
    Left = 232
    Top = 43
    Width = 56
    Height = 25
    Caption = '&Recalcula'
    TabOrder = 3
    OnClick = FlatButton1Click
  end
  object Query: TADOQuery
    Connection = Form1.ADOConnection1
    Parameters = <>
    Left = 160
    Top = 93
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 120
    Top = 93
  end
end
