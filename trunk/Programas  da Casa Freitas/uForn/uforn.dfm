object fmForn: TfmForn
  Left = 323
  Top = 173
  Width = 526
  Height = 350
  Caption = 'Fornecedores'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    510
    312)
  PixelsPerInch = 96
  TextHeight = 13
  object fnGrid: TSoftDBGrid
    Left = 7
    Top = 48
    Width = 500
    Height = 225
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWhite
  end
  object edit1: TadLabelEdit
    Left = 7
    Top = 19
    Width = 258
    Height = 26
    Anchors = [akTop]
    LabelDefs.Width = 199
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Digite o nome do fornecedor para busrcar:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object fsBuscaNumero: TfsCheckBox
    Left = 270
    Top = 23
    Width = 126
    Height = 17
    Caption = 'Procurar pelo n'#250'mero'
    TabOrder = 2
    OnClick = fsBuscaNumeroClick
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = qrCredores
    Left = 104
    Top = 88
  end
  object qrCredores: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 104
    Top = 120
  end
end
