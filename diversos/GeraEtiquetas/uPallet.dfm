object Pallet: TPallet
  Left = 302
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pallet / Endereco'
  ClientHeight = 105
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ednPallete: TadLabelEdit
    Left = 107
    Top = 25
    Width = 154
    Height = 19
    LabelDefs.Width = 87
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do Pallete'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 12
    TabOrder = 0
  end
  object fsBitBtn1: TfsBitBtn
    Left = 186
    Top = 49
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
  end
  object Rg: TfsRadioGroup
    Left = 3
    Top = 9
    Width = 89
    Height = 55
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
    Caption = 'Imprimir '
    ItemIndex = 0
    Items.Strings = (
      'P&allete'
      'E&ndereco')
    TabOrder = 2
    OnClick = RgClick
  end
end
