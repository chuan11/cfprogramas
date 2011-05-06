object Form1: TForm1
  Left = 336
  Top = 86
  Width = 700
  Height = 572
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Utilitario para ajustar a descri'#231#227'o dos produtos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btLista: TFlatButton
    Left = 134
    Top = 18
    Width = 46
    Height = 25
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F88F88F773
      3333373337F3373F3333078FF8F8870333337F33F7FFF37F333307F87F8FF703
      33337F377777337F3333078F87F88703333373F337F33373333377F7F8F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object DBGrid1: TDBGrid
    Left = 1
    Top = 96
    Width = 688
    Height = 371
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CD_REF'
        Title.Caption = 'CODIGO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_REF'
        Title.Caption = 'DESCRICAO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 388
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_RESU'
        Title.Caption = 'DESC RESUMIDA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 186
        Visible = True
      end>
  end
  object edLocaliza: TadLabelEdit
    Left = 2
    Top = 62
    Width = 247
    Height = 26
    LabelDefs.Width = 42
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Localizar'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edDestino: TadLabelEdit
    Left = 282
    Top = 62
    Width = 255
    Height = 26
    LabelDefs.Width = 64
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Substituir por:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edCodigo: TadLabelEdit
    Left = 3
    Top = 18
    Width = 127
    Height = 26
    LabelDefs.Width = 42
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Localizar'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnKeyDown = edCodigoKeyDown
  end
  object FlatButton2: TFlatButton
    Left = 549
    Top = 62
    Width = 77
    Height = 26
    Caption = '&Alterar'
    Layout = blGlyphRight
    NumGlyphs = 2
    TabOrder = 5
    OnClick = FlatButton2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=ADM;Init' +
      'ial Catalog=WellCfreitas;Data Source=125.4.4.200;Use Procedure f' +
      'or Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID' +
      '=CPD01;Use Encryption for Data=False;Tag with column collation w' +
      'hen possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 112
    Top = 160
  end
  object Query1: TADOQuery
    Connection = ADOConnection1
    BeforePost = Query1BeforePost
    Parameters = <>
    Left = 48
    Top = 160
  end
end
