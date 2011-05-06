object Form1: TForm1
  Left = 363
  Top = 262
  Width = 191
  Height = 87
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Inicio do sistema'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 24
    Width = 177
    Height = 13
    Alignment = taCenter
    Caption = 'Label1'
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
        Address = 'walterfcarvalho@gmail.com'
        Name = 'Walter'
        Text = 'Walter <walterfcarvalho@gmail.com>'
        Domain = 'gmail.com'
        User = 'walterfcarvalho'
      end>
    From.Address = 'walterfcarvalho@gmail.com'
    From.Name = 'Walter'
    From.Text = 'Walter <walterfcarvalho@gmail.com>'
    From.Domain = 'gmail.com'
    From.User = 'walterfcarvalho'
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 8
    Top = 8
  end
  object IdSMTP: TIdSMTP
    Host = '125.4.4.254'
    Password = '123456'
    SASLMechanisms = <>
    Username = 'casafreitas'
    Left = 56
    Top = 8
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 96
    Top = 8
  end
end
