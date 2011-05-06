object Fmpallete: TFmpallete
  Left = 405
  Top = 256
  Width = 187
  Height = 101
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Fmpallete'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ednPallete: TadLabelEdit
    Left = 3
    Top = 16
    Width = 174
    Height = 19
    LabelDefs.Width = 87
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do Pallete'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 5
    TabOrder = 0
  end
  object fsBitBtn1: TfsBitBtn
    Left = 102
    Top = 40
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
  end
end
