object fmPermissoes: TfmPermissoes
  Left = 480
  Top = 135
  Width = 686
  Height = 555
  Caption = 'Controle de permiss'#245'es'
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
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    670
    517)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 79
    Height = 13
    Caption = 'Telas do sistema'
  end
  object Label2: TLabel
    Left = 313
    Top = 10
    Width = 34
    Height = 13
    Caption = 'Grupos'
  end
  object grid: TSoftDBGrid
    Left = 312
    Top = 26
    Width = 290
    Height = 322
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = gridDrawColumnCell
    OnDblClick = gridDblClick
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object Tree: TTreeView
    Left = 6
    Top = 26
    Width = 290
    Height = 268
    Ctl3D = False
    Indent = 19
    ParentCtl3D = False
    TabOrder = 1
    OnClick = TreeClick
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 301
    Width = 290
    Height = 76
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Consultar o grupo '
    TabOrder = 2
    DesignSize = (
      290
      76)
    object edUser: TadLabelEdit
      Left = 8
      Top = 30
      Width = 154
      Height = 19
      LabelDefs.Width = 80
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nome do usu'#225'rio'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object btIncluiXML: TfsBitBtn
      Left = 169
      Top = 29
      Width = 26
      Height = 20
      Default = True
      TabOrder = 1
      OnClick = btIncluiXMLClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object SoftDBGrid1: TSoftDBGrid
      Left = 9
      Top = 56
      Width = 266
      Height = 17
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = dsuser
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = gridDrawColumnCell
      OnDblClick = gridDblClick
      AlternateColor = True
      ColorLow = clInfoBk
      ColorHigh = 15790322
    end
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 112
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 152
    Top = 72
  end
  object dsuser: TDataSource
    Left = 215
    Top = 325
  end
end
