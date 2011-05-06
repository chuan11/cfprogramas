object Form1: TForm1
  Left = 364
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar N'#250'mero de CPF'
  ClientHeight = 67
  ClientWidth = 196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 119
    Top = 39
    Width = 75
    Height = 25
    Caption = '&Gerar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object FlatEdit1: TFlatEdit
    Left = 3
    Top = 2
    Width = 190
    Height = 29
    ColorFocused = clInfoBk
    ColorFlat = clBtnFace
    ParentColor = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'FlatEdit1'
    OnEnter = FlatEdit1Enter
  end
end
