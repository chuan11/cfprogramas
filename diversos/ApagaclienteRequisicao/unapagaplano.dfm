object Form1: TForm1
  Left = 192
  Top = 103
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Retirar cod loja '
  ClientHeight = 94
  ClientWidth = 302
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
  object edPedido: TadLabelEdit
    Left = 9
    Top = 24
    Width = 284
    Height = 19
    LabelDefs.Width = 103
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero da requisi'#231#227'o'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 216
    Top = 51
    Width = 76
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Connection: TADOConnection
    LoginPrompt = False
    Left = 128
    Top = 48
  end
end
