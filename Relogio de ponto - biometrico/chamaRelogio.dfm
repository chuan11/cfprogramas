object Form1: TForm1
  Left = 272
  Top = 270
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 90
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object gGauge1: TFlatGauge
    Left = 40
    Top = 61
    Width = 230
    Height = 25
    AdvColorBorder = 0
    ColorBorder = 8623776
    Progress = 0
  end
  object Memo1: TMemo
    Left = 2
    Top = 89
    Width = 206
    Height = 19
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    Visible = False
  end
  object Memo2: TMemo
    Left = 3
    Top = 111
    Width = 206
    Height = 210
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 299
    Height = 58
    Align = alTop
    Color = clInfoBk
    TabOrder = 0
    object Label1: TLabel
      Left = 49
      Top = 3
      Width = 196
      Height = 16
      Alignment = taCenter
      Caption = 'Iniciando o sistema, aguarde...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 22
      Width = 288
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object dtime1: TNMDayTime
    Host = '125.4.4.200'
    Port = 13
    TimeOut = 500
    ReportLevel = 0
    Left = 248
    Top = 72
  end
  object ftp1: TNMFTP
    Port = 21
    TimeOut = 4000
    ReportLevel = 0
    OnPacketRecvd = ftp1PacketRecvd
    UserID = 'ponto'
    Password = 'ponto'
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 220
    Top = 72
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 192
    Top = 72
  end
end
