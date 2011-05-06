object Form1: TForm1
  Left = 392
  Top = 115
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 2
  Caption = 'Gerenciador das listas - 1.20'
  ClientHeight = 73
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GGauge1: TGradientGauge
    Left = 29
    Top = 47
    Width = 204
    Height = 17
    AutoText = True
    AutoTextStyle = atsPercent
    ColorBack = clMenu
    ColorStart = clBtnText
    ColorEnd = clNavy
    Flat = True
    Min = 0
    Max = 100
    Position = 0
    Text = '0 %'
    ShowBorder = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
  end
  object Memo1: TMemo
    Left = 0
    Top = 78
    Width = 337
    Height = 49
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    Visible = False
  end
  object Memo2: TMemo
    Left = -1
    Top = 131
    Width = 337
    Height = 49
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 270
    Height = 41
    Align = alTop
    Color = clInfoBk
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 3
      Width = 253
      Height = 14
      Alignment = taCenter
      Anchors = []
      AutoSize = False
      Caption = 'Aguarde enquanto o programa é iniciado....'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 18
      Width = 254
      Height = 15
      Alignment = taCenter
      Anchors = []
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object NMFTP1: TNMFTP
    Port = 21
    ReportLevel = 0
    OnPacketRecvd = NMFTP1PacketRecvd
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Top = 40
  end
end
