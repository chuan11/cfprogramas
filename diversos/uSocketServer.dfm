object Form1: TForm1
  Left = 847
  Top = 370
  Width = 523
  Height = 301
  Caption = 'Exportador de XML'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 507
    Height = 225
    Align = alTop
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 244
    Width = 507
    Height = 19
    Panels = <>
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 3437
    ServerType = stNonBlocking
    OnAccept = ServerSocketAccept
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientWrite = ServerSocketClientWrite
    OnClientError = ServerSocketClientError
    Left = 40
    Top = 40
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 72
    Top = 40
  end
end
