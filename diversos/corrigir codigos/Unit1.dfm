object Form1: TForm1
  Left = 421
  Top = 157
  Width = 1142
  Height = 656
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 1089
    Height = 361
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object Button1: TButton
    Left = 968
    Top = 392
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 968
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 392
    Width = 833
    Height = 209
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '          select c.is_ref,  ds_ref, c.cd_ref, '#39#39' as cd_ref2 '
      '          from crefe c  '
      '          where  len(c.cd_ref) = 8  '
      '          and cd_ref not like ('#39'922%'#39')  '
      '          and cd_ref not like ('#39'922%'#39')  '
      '          order by cd_ref')
    ParentFont = False
    TabOrder = 3
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;' +
      'User ID=secrel;Initial Catalog=wellCfreitas;Data Source=125.0.0.' +
      '200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnWillExecute = ADOConnection1WillExecute
    Left = 48
    Top = 48
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    Left = 816
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 48
    Top = 112
  end
end
