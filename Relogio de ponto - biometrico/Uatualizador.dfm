object Form1: TForm1
  Left = 357
  Top = 291
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Atualizador'
  ClientHeight = 101
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pBar: TGauge
    Left = 28
    Top = 46
    Width = 237
    Height = 17
    Progress = 0
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 45
    Align = alTop
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 286
      Height = 15
      Align = alTop
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 258
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = ' '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object FlatButton1: TFlatButton
    Left = 47
    Top = 68
    Width = 96
    Height = 15
    Caption = 'Atualizar'
    TabOrder = 1
    Visible = False
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 146
    Top = 68
    Width = 96
    Height = 15
    Caption = 'Configura'#231#245'es'
    TabOrder = 2
    Visible = False
    OnClick = FlatButton2Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Top = 66
  end
  object dt: TIdDayTime
    MaxLineAction = maException
    ReadTimeout = 0
    Host = '125.4.4.200'
    Left = 24
    Top = 66
  end
end
