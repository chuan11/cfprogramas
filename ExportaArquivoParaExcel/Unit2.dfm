object Form2: TForm2
  Left = 394
  Top = 278
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Notas de entrada'
  ClientHeight = 413
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 49
    Height = 13
    Caption = 'Produto:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 68
    Top = 6
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 23
    Width = 595
    Height = 371
    Align = alBottom
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
    OnTitleClick = SoftDBGrid1TitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 394
    Width = 595
    Height = 19
    Panels = <>
  end
  object DataSource1: TDataSource
    DataSet = Form1.qrEnt
    Left = 88
    Top = 112
  end
end
