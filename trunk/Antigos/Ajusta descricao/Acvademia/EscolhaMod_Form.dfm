object frmEscolha: TfrmEscolha
  Left = 454
  Top = 431
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Modalidades'
  ClientHeight = 99
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 8
    Width = 180
    Height = 16
    Caption = 'Escolha 1 (uma) modalidade:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object dblcEscolheMod: TDBLookupComboBox
    Left = 8
    Top = 32
    Width = 204
    Height = 21
    KeyField = 'COD_MOD'
    ListField = 'Modalidade'
    ListSource = dsEscolha
    TabOrder = 0
    OnKeyDown = dblcEscolheModKeyDown
  end
  object btnOK: TBitBtn
    Left = 24
    Top = 64
    Width = 75
    Height = 25
    Hint = 'Exibe tela para alterar a modalidade escolida'
    Caption = '&OK'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancela: TBitBtn
    Left = 112
    Top = 64
    Width = 75
    Height = 25
    Hint = 'Cancela operação'
    Caption = '&Cancela'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnCancelaClick
  end
  object qryEscolha: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select COD_MOD, Modalidade'
      'From Modalidade'
      'order By Modalidade')
    Left = 104
    Top = 27
  end
  object dsEscolha: TDataSource
    AutoEdit = False
    DataSet = qryEscolha
    Left = 152
    Top = 27
  end
end
