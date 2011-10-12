object fmResumoCaixa: TfmResumoCaixa
  Left = 330
  Top = 219
  Width = 889
  Height = 574
  Caption = 'fmResumoCaixa'
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
  OnCreate = FormCreate
  DesignSize = (
    873
    536)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 873
    Height = 89
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 179
      Top = 7
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Panel2: TPanel
      Left = 292
      Top = 7
      Width = 495
      Height = 41
      BevelInner = bvLowered
      Caption = 'Panel2'
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 2
        Top = 2
        Width = 491
        Height = 35
        ButtonHeight = 31
        ButtonWidth = 33
        Caption = 'ToolBar1'
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 2
          Width = 8
          ImageIndex = 0
          Style = tbsSeparator
        end
        object ToolButton2: TToolButton
          Left = 8
          Top = 2
          Caption = 'ToolButton2'
          ImageIndex = 1
        end
      end
    end
    object cbLojas: TadLabelComboBox
      Left = 5
      Top = 21
      Width = 159
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Color = clInfoBk
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object dt: TfsDateTimePicker
      Left = 177
      Top = 21
      Width = 95
      Height = 22
      Date = 39906.649664583330000000
      Time = 39906.649664583330000000
      TabOrder = 2
    end
  end
  object grid: TSoftDBGrid
    Left = 0
    Top = 96
    Width = 858
    Height = 282
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clHighlightText
  end
  object tb: TADOTable
    Connection = fmMain.Conexao
    Left = 136
    Top = 160
  end
  object DataSource1: TDataSource
    Left = 104
    Top = 160
  end
end
