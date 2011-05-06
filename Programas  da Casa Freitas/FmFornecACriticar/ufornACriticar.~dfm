object fmFornACriticar: TfmFornACriticar
  Left = 320
  Top = 269
  Width = 794
  Height = 654
  Caption = 'Fornecedores  que criticam quant de caixa requisi'#231#245'es'
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
  OnActivate = FormActivate
  OnClose = FormClose
  DesignSize = (
    778
    616)
  PixelsPerInch = 96
  TextHeight = 13
  object fsBitBtn1: TfsBitBtn
    Left = 416
    Top = 9
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Adicionar'
    TabOrder = 0
    OnClick = fsBitBtn1Click
  end
  object fsBitBtn2: TfsBitBtn
    Left = 416
    Top = 41
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Remover'
    TabOrder = 1
    OnClick = fsBitBtn2Click
  end
  object Grid: TDBGrid
    Left = 7
    Top = 1
    Width = 330
    Height = 287
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridTitleClick
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 96
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 128
    Top = 64
  end
end
