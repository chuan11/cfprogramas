object Form3: TForm3
  Left = 342
  Top = 305
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Agendadores'
  ClientHeight = 225
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 4
    Top = 6
    Width = 235
    Height = 177
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 4
    Top = 194
    Width = 234
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = Form1.ADOTable2
    Left = 32
    Top = 128
  end
end
