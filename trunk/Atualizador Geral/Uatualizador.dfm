object Form1: TForm1
  Left = 354
  Top = 290
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Atualizador de arquivos  1.02'
  ClientHeight = 129
  ClientWidth = 356
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
  object Gauge1: TFlatGauge
    Left = 54
    Top = 84
    Width = 248
    Height = 19
    AdvColorBorder = 0
    ColorBorder = 8623776
    Progress = 0
    Visible = False
  end
  object Label3: TLabel
    Left = 54
    Top = 112
    Width = 248
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 356
    Height = 73
    Align = alTop
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 354
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Atualizando os arquivos do '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 3
      Top = 29
      Width = 348
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = ' '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object FlatButton1: TFlatButton
    Left = 306
    Top = 77
    Width = 46
    Height = 34
    Caption = 'Atualizar'
    TabOrder = 1
    Visible = False
    OnClick = FlatButton1Click
  end
  object FTP: TIdFTP
    OnWork = FTPWork
    OnWorkEnd = FTPWorkEnd
    AutoLogin = True
    Host = '125.4.4.200'
    Password = 'ponto'
    Username = 'ponto'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ReadTimeout = 0
    Left = 40
    Top = 34
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 8
    Top = 34
  end
  object dt: TIdDayTime
    Host = '125.4.4.200'
    Left = 72
    Top = 34
  end
end
