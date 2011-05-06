object Form1: TForm1
  Left = 249
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 122
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 2
    Top = 6
    Width = 228
    Height = 18
    AutoSize = False
    BiDiMode = bdRightToLeftNoAlign
    Caption = 'Clique aqui p/ escolher o arquivo.....'
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 3
    Top = 35
    Width = 106
    Height = 15
    AutoSize = False
    BiDiMode = bdRightToLeftNoAlign
    Caption = 'Retirar ate a data :'
    Color = clMenu
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
  end
  object MaskEdit1: TMaskEdit
    Left = 107
    Top = 34
    Width = 99
    Height = 19
    BorderStyle = bsNone
    Color = clInfoBk
    EditMask = '!99/99/0000;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 0
    Text = '  /  /    '
    OnDblClick = MaskEdit1DblClick
    OnKeyPress = MaskEdit1KeyPress
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 103
    Width = 241
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object NMFTP1: TNMFTP
    Port = 21
    ReportLevel = 0
    OnPacketSent = NMFTP1PacketSent
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 208
    Top = 32
  end
end
