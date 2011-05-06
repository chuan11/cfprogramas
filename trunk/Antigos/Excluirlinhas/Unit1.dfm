object Form1: TForm1
  Left = 192
  Top = 103
  Width = 283
  Height = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LB1: TListBox
    Left = 6
    Top = 78
    Width = 259
    Height = 57
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 49
    Width = 91
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 103
    Top = 49
    Width = 91
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    OnKeyDown = Edit2KeyDown
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 167
    Width = 275
    Height = 19
    Panels = <>
  end
  object FlatButton1: TFlatButton
    Left = 199
    Top = 140
    Width = 65
    Height = 25
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object Edit3: TEdit
    Left = 8
    Top = 8
    Width = 258
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    OnDblClick = Edit3DblClick
  end
end
