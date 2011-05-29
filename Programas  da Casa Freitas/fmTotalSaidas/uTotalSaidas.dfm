object fmTotalSaidas: TfmTotalSaidas
  Left = 380
  Top = 272
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Venda total no per'#237'odo'
  ClientHeight = 116
  ClientWidth = 323
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
    Left = 115
    Top = 52
    Width = 15
    Height = 13
    Caption = 'at'#233
  end
  object lbDados: TLabel
    Left = 5
    Top = 5
    Width = 313
    Height = 15
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 85
    Width = 51
    Height = 20
    Caption = 'Total :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTotal: TLabel
    Left = 66
    Top = 86
    Width = 11
    Height = 20
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dt01: TDateTimePicker
    Left = 5
    Top = 46
    Width = 109
    Height = 28
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dt02: TDateTimePicker
    Left = 133
    Top = 46
    Width = 109
    Height = 28
    Date = 39288.669176423610000000
    Time = 39288.669176423610000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object FlatButton1: TFlatButton
    Left = 247
    Top = 46
    Width = 72
    Height = 27
    Caption = '&Recalcula'
    TabOrder = 2
    OnClick = FlatButton1Click
  end
end
