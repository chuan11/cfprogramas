object fmOsDeposito: TfmOsDeposito
  Left = 476
  Top = 196
  Width = 645
  Height = 417
  Caption = 'Requisi'#231#245'es para  dep'#243'sito'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 45
    Width = 629
    Height = 334
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColExit = gridColExit
    OnDblClick = gridDblClick
    OnKeyDown = gridKeyDown
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 45
    Align = alTop
    TabOrder = 1
    object btNova: TFlatButton
      Left = 3
      Top = 16
      Width = 70
      Height = 25
      Caption = '&Nova'
      TabOrder = 0
      OnClick = btNovaClick
    end
    object FlatButton2: TFlatButton
      Left = 432
      Top = 16
      Width = 68
      Height = 25
      Caption = '&Salvar'
      TabOrder = 1
      OnClick = FlatButton2Click
    end
    object cbCritica: TfsCheckBox
      Left = 99
      Top = 24
      Width = 121
      Height = 17
      Caption = 'N'#227'o criticar por caixa.'
      Enabled = False
      TabOrder = 2
      OnClick = cbCriticaClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbLojas: TadLabelComboBox
      Left = 232
      Top = 20
      Width = 178
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      Visible = False
      OnClick = cbLojasClick
      LabelDefs.Width = 158
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Requisi'#231#245'es feitas a partir da loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    BeforePost = tbBeforePost
    AfterPost = tbAfterPost
    AfterCancel = tbAfterCancel
    OnPostError = tbPostError
    Left = 48
    Top = 309
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 88
    Top = 309
  end
  object Query: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 20
    Top = 311
  end
end
