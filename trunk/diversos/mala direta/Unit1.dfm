object Form1: TForm1
  Left = 379
  Top = 219
  Width = 361
  Height = 194
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FlatButton1: TFlatButton
    Left = 32
    Top = 8
    Width = 105
    Height = 65
    Caption = 'Listar Clientes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 'FILE NAME=C:\ProgramasDiversos\ConexaoAoWell.udl'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 152
    Top = 16
  end
  object Query: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/*'
      'select  top 22'
      '   C.CD_PES, c.NM_PES, c.tp_lograd, c.ds_end, C.nr_end,'
      '   c.ds_bai, '
      '   CID.nm_cid,'
      
        '   SUBSTRING (CAST(C.NR_CEP AS VARCHAR),01,05)+ '#39'-'#39' + SUBSTRING ' +
        '(CAST(C.NR_CEP AS VARCHAR),06,03),  '
      '   C.CD_UF  '
      ''
      'from dspes c , tcid cid'
      'where'
      'c.CD_CID = cid.cd_cid   '
      'and'
      'cd_lojcad in ( select is_uo from tbuo)'
      'order by'
      '   c.nm_fantasi, c.CD_CID '
      ''
      '*/'
      'select  '
      '   C.CD_PES, c.NM_PES, c.tp_lograd, c.ds_end, C.nr_end,'
      '   c.ds_bai AS BAIRRO, CID.nm_cid, c.nr_cep, C.CD_UF '
      'from dspes c , tcid cid'
      'where'
      'c.CD_CID = cid.cd_cid   '
      'and'
      'cd_lojcad in ( select is_uo from tbuo)'
      'order by'
      '   c.nm_fantasi, c.CD_CID '
      '')
    Left = 184
    Top = 16
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query
    Left = 24
    Top = 88
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    Left = 56
    Top = 88
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 88
    Top = 88
  end
end
