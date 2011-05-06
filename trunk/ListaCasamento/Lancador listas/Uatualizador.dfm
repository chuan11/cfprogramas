object Form1: TForm1
  Left = 354
  Top = 290
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '10.11.01 - Atualizador'
  ClientHeight = 106
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 9
    Top = 51
    Width = 272
    Height = 52
    Active = True
    AutoSize = False
    CommonAVI = aviCopyFile
    StopFrame = 1
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 290
    Height = 45
    Align = alTop
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 288
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Listas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
    Left = 96
    Top = 46
    Width = 113
    Height = 24
    Caption = 'Atualizar'
    TabOrder = 1
    Visible = False
    OnClick = FlatButton1Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 8
    Top = 34
  end
  object dt: TIdDayTime
    MaxLineAction = maException
    ReadTimeout = 0
    Left = 8
    Top = 10
  end
end
