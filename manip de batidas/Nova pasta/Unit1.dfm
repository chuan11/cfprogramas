object Form1: TForm1
  Left = 378
  Top = 220
  Width = 890
  Height = 425
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object listFile: TFileListBox
    Left = 32
    Top = 56
    Width = 217
    Height = 201
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 168
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 296
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
end
