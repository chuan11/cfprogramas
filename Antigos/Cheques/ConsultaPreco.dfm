object FmConsulta: TFmConsulta
  Left = 192
  Top = 106
  Width = 550
  Height = 314
  Caption = 'FmConsulta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 1
    Top = 9
    Width = 540
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object DBGrid1: TDBGrid
    Left = 1
    Top = 33
    Width = 540
    Height = 249
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
  end
  object Query1: TQuery
    Left = 88
    Top = 40
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 120
    Top = 40
  end
end
