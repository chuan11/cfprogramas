object Pallet: TPallet
  Left = 746
  Top = 269
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pallet / Endereco'
  ClientHeight = 89
  ClientWidth = 322
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
    Left = 103
    Top = 25
    Width = 97
    Height = 19
    LabelDefs.Width = 87
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do Pallete'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 12
    TabOrder = 0
    OnChange = ednPalleteChange
    OnKeyDown = ednPalleteKeyDown
  end
  object fsBitBtn1: TfsBitBtn
    Left = 236
    Top = 54
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 2
    OnClick = fsBitBtn1Click
  end
  object Rg: TRadioGroup
    Left = 6
    Top = 6
    Width = 86
    Height = 50
    Caption = 'Tipo'
    ItemIndex = 0
    Items.Strings = (
      'Pallet'
      'Endere'#231'o')
    TabOrder = 3
    OnClick = RgClick
  end
  object ednPalleteFim: TadLabelEdit
    Left = 217
    Top = 25
    Width = 97
    Height = 19
    LabelDefs.Width = 9
    LabelDefs.Height = 13
    LabelDefs.Caption = 'a '
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 12
    TabOrder = 1
    OnKeyDown = ednPalleteKeyDown
  end
end
