inherited fmItensSemMov: TfmItensSemMov
  Left = 241
  Top = 224
  Width = 783
  Caption = 'Produtos Sem Movimenta'#231#227'o'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 767
    Height = 107
    inherited cbDetAvaForn: TfsCheckBox
      Left = 452
      Width = 197
      Caption = 'Data de entrada por transfer'#234'ncia'
    end
    object edCodigo: TadLabelEdit
      Left = 4
      Top = 65
      Width = 145
      Height = 19
      LabelDefs.Width = 75
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Faixa de c'#243'digo'
      Colors.WhenEnterFocus.BackColor = clWindow
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
    end
    object spedit: TadLabelSpinEdit
      Left = 374
      Top = 63
      Width = 42
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 181
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Produtos sem movimentado a mais de '
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      MaxValue = 999.000000000000000000
      MinValue = 1.000000000000000000
      Format = nfStandard
      TabOrder = 6
      Value = 30.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
  end
  object grid: TSoftDBGrid [1]
    Left = 0
    Top = 107
    Width = 767
    Height = 192
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  inherited tbValoresAvarias: TADOTable
    Left = 704
    Top = 199
  end
  inherited tbValoresAvarias_Total: TADOTable
    Left = 705
    Top = 240
  end
  inherited tbPreviaDeCaixa: TADOTable
    Left = 480
    Top = 112
  end
  inherited tbOperadores: TADOTable
    Left = 520
    Top = 112
  end
  inherited tbTotRec: TADOTable
    Left = 560
    Top = 112
  end
  inherited tbSangrias: TADOTable
    Left = 600
    Top = 112
  end
  inherited tbVendasCartao: TADOTable
    Left = 648
    Top = 112
  end
  inherited qr: TADOQuery
    Left = 704
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = tbOperadores
    Left = 152
    Top = 184
  end
end
