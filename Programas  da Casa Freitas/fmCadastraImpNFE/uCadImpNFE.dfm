object fmCadImpNFE: TfmCadImpNFE
  Left = 356
  Top = 230
  Width = 646
  Height = 202
  Caption = 'uCadImpNFE'
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 609
    Height = 145
    Caption = ' Impressoras de NFE '
    TabOrder = 0
    object gridImpressoras: TSoftDBGrid
      Left = 6
      Top = 15
      Width = 597
      Height = 124
      Ctl3D = False
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = gridImpressorasDblClick
      AlternateColor = True
      ColorLow = clInfoBk
      ColorHigh = clWhite
    end
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    AfterPost = tbAfterPost
    Left = 112
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 176
    Top = 80
  end
end
