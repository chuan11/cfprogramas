object fmExportaTable: TfmExportaTable
  Left = 999
  Top = 322
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
    ModalResult = 1
    TabOrder = 1
  end
end
