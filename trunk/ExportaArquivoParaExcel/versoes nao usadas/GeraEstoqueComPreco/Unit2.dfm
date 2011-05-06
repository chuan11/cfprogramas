object Form2: TForm2
  Left = 378
  Top = 292
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Detalhes da Entrada'
  ClientHeight = 205
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 49
    Height = 13
    Caption = 'Produto:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 68
    Top = 6
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 5
    Top = 28
    Width = 466
    Height = 174
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Query: TADOQuery
    Active = True
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '   select  dmovi.dt_movi, dmovi.qt_mov,  tbuo.ds_uo from dmovi '
      '   inner join toper on dmovi.is_oper = toper.is_oper'
      '   inner join tbuo on dmovi.is_estoque = tbuo.Is_uo'
      '   where dmovi.is_ref = 30 and  toper.sq_opf  = 10000005'
      '   order by  dmovi.dt_movi')
    Left = 56
    Top = 112
    object Querydt_movi: TDateTimeField
      DisplayLabel = 'Data Entrada'
      FieldName = 'dt_movi'
    end
    object Queryqt_mov: TBCDField
      DisplayLabel = 'Quatidade '
      FieldName = 'qt_mov'
      Precision = 19
    end
    object Queryds_uo: TStringField
      DisplayLabel = 'Loja'
      FieldName = 'ds_uo'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 88
    Top = 112
  end
end
