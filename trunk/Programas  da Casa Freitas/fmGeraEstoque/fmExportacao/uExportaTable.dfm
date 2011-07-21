object fmExportaTable: TfmExportaTable
  Left = 705
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Destino'
  ClientHeight = 62
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 6
    Top = 6
    Width = 113
    Height = 46
    Caption = ' Exportar para '
    ItemIndex = 0
    Items.Strings = (
      ' - Planilha excel'
      ' - Email')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 125
    Top = 17
    Width = 75
    Height = 29
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
end
