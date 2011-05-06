object Form1: TForm1
  Left = 461
  Top = 147
  Width = 605
  Height = 515
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 40
    Top = 16
    Width = 489
    Height = 225
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 64
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 144
    Top = 272
    Width = 409
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Host = '125.0.1.250'
    Port = 3437
    OnConnect = ClientSocket1Connect
    OnRead = ClientSocket1Read
    Left = 232
    Top = 240
  end
end
