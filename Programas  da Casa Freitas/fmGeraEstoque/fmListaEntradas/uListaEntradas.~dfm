object fmListaEntradas: TfmListaEntradas
  Left = 334
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Notas de entrada'
  ClientHeight = 413
  ClientWidth = 595
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
  DesignSize = (
    595
    413)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 68
    Top = 6
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 48
    Width = 595
    Height = 365
    Align = alBottom
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
    OnTitleClick = SoftDBGrid1TitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 592
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object lbDescicao: TLabel
      Left = 7
      Top = 5
      Width = 64
      Height = 13
      Caption = 'lbDescicao'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbQtNotas: TLabel
      Left = 7
      Top = 23
      Width = 57
      Height = 13
      Caption = 'lbQtNotas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DataSource1: TDataSource
    DataSet = qrEnt
    Left = 88
    Top = 112
  end
  object qrEnt: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 56
    Top = 112
  end
end
