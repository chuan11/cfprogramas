object Form1: TForm1
  Left = 195
  Top = 120
  Width = 870
  Height = 450
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    854
    414)
  PixelsPerInch = 96
  TextHeight = 13
  object SoftDBGrid1: TSoftDBGrid
    Left = 4
    Top = 72
    Width = 833
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object ed: TEdit
    Left = 24
    Top = 200
    Width = 257
    Height = 21
    TabOrder = 1
    Text = '76568, 76565'
  end
  object Button1: TButton
    Left = 344
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = ADOConnection1ExecuteComplete
    OnWillExecute = ADOConnection1WillExecute
    Left = 24
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 176
    Top = 136
  end
  object tb: TADOTable
    Connection = ADOConnection1
    Left = 112
    Top = 16
  end
  object qr: TADOQuery
    Connection = ADOConnection1
    CommandTimeout = 0
    Parameters = <>
    Left = 264
    Top = 16
  end
end
