object fmConReqProduto: TfmConReqProduto
  Left = 366
  Top = 246
  Width = 780
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta requisi'#231#245'es por produto.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    764
    412)
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 3
    Top = 55
    Width = 758
    Height = 344
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 52
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 361
      Top = 4
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 467
      Top = 4
      Width = 45
      Height = 13
      Caption = 'Data final'
    end
    object edCodigo: TadLabelEdit
      Left = 5
      Top = 19
      Width = 152
      Height = 19
      LabelDefs.Width = 73
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Codigo ou EAN'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object cbLojas: TadLabelComboBox
      Left = 170
      Top = 19
      Width = 156
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      LabelDefs.Width = 158
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Requisi'#231#245'es feitas a partir da loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object dti: TfsDateTimePicker
      Left = 358
      Top = 19
      Width = 105
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 2
    end
    object dtf: TfsDateTimePicker
      Left = 467
      Top = 19
      Width = 105
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 3
    end
    object btConsultar: TFlatButton
      Left = 578
      Top = 7
      Width = 70
      Height = 35
      Caption = '&Consultar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btConsultarClick
    end
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 40
    Top = 83
  end
  object Query: TADOQuery
    Connection = fmMain.Conexao
    CommandTimeout = 0
    Parameters = <>
    Left = 80
    Top = 83
  end
end
