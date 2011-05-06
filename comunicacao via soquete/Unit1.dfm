object Form1: TForm1
  Left = 419
  Top = 189
  Width = 1142
  Height = 656
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
  object Button1: TButton
    Left = 288
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object so: TClientSocket
    Active = False
    Address = '125.0.1.250'
    ClientType = ctNonBlocking
    Host = '125.0.1.250'
    Port = 3436
    Left = 184
    Top = 144
  end
end
