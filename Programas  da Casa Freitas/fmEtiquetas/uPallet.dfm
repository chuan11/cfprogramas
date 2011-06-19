object Pallet: TPallet
  Left = 333
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pallet / Endereco'
  ClientHeight = 89
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ednPallete: TadLabelEdit
    Left = 115
    Top = 25
    Width = 126
    Height = 19
    LabelDefs.Width = 87
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do Pallete'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 12
    TabOrder = 0
    OnKeyDown = ednPalleteKeyDown
  end
  object fsBitBtn1: TfsBitBtn
    Left = 167
    Top = 54
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = fsBitBtn1Click
  end
  object Rg: TRadioGroup
    Left = 6
    Top = 6
    Width = 86
    Height = 50
    Caption = 'Tipo'
    Items.Strings = (
      'Pallet'
      'Endere'#231'o')
    TabOrder = 2
  end
end
