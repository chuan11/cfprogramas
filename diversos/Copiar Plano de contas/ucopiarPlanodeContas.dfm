object Form1: TForm1
  Left = 509
  Top = 319
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '(04) - Copiar plano de contas FL para PFM e CF'
  ClientHeight = 197
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FlatButton1: TFlatButton
    Left = 10
    Top = 11
    Width = 151
    Height = 57
    Caption = 'Copiar o plano de contas'
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object memo: TFlatMemo
    Left = 11
    Top = 80
    Width = 291
    Height = 113
    ColorFlat = clBtnFace
    ParentColor = True
    TabOrder = 1
  end
  object ADOconnection1: TADOConnection
    ConnectionString = 'FILE NAME=C:\ProgramasDiversos\ConexaoAoWell.udl'
    LoginPrompt = False
    Provider = 'C:\ProgramasDiversos\ConexaoAoWell.udl'
    Left = 16
    Top = 160
  end
  object Query: TADOQuery
    Connection = ADOconnection1
    Parameters = <>
    Left = 48
    Top = 160
  end
end
