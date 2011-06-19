object fmRelInventario: TfmRelInventario
  Left = 661
  Top = 300
  Width = 673
  Height = 480
  Caption = 'fmRelInventario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object fsBitBtn1: TfsBitBtn
    Left = 288
    Top = 48
    Width = 75
    Height = 25
    Caption = 'fsBitBtn1'
    TabOrder = 0
    OnClick = fsBitBtn1Click
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 160
    Top = 184
  end
end
