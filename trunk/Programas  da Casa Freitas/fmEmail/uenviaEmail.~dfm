object fmEnviaEmail: TfmEnviaEmail
  Left = 684
  Top = 325
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Envio de e-mail'
  ClientHeight = 247
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 2
    Top = 40
    Width = 425
    Height = 171
    Color = clMenu
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 427
    Height = 35
    Caption = ' - '
    TabOrder = 1
    object Bevel1: TBevel
      Left = 2
      Top = 1
      Width = 423
      Height = 31
    end
  end
  object IdSMTP: TIdSMTP
    OnStatus = IdSMTPStatus
    IOHandler = socket
    MaxLineAction = maException
    ReadTimeout = 0
    Host = 'smtp.gmail.com'
    Port = 465
    AuthenticationType = atLogin
    MailAgent = 'pop.gmail.com'
    Left = 104
    Top = 104
  end
  object socket: TIdSSLIOHandlerSocket
    OnStatus = socketStatus
    UseNagle = False
    SSLOptions.Method = sslvSSLv23
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 64
    Top = 104
  end
  object msg: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 24
    Top = 104
  end
end
