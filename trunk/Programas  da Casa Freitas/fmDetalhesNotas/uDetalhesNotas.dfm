object fmDetalhesNota: TfmDetalhesNota
  Left = 577
  Top = 232
  Width = 653
  Height = 524
  Caption = 'Detalhes da Nota fiscal'
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
    637
    486)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 93
    Width = 618
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Label5: TLabel
    Left = 7
    Top = 46
    Width = 51
    Height = 13
    Caption = 'Emiss'#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 87
    Top = 46
    Width = 36
    Height = 13
    Caption = '000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object grid: TSoftDBGrid
    Left = 4
    Top = 117
    Width = 628
    Height = 365
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
    OnColExit = gridColExit
    OnTitleClick = gridTitleClick
    AlternateColor = False
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = -1
    Top = 8
    Width = 632
    Height = 84
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      632
      84)
    object StaticText2: TStaticText
      Left = 5
      Top = 2
      Width = 4
      Height = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 0
      Width = 618
      Height = 78
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' Cabe'#231'alho da Nota '
      TabOrder = 1
      object lbDestEmit: TLabel
        Left = 5
        Top = 30
        Width = 58
        Height = 13
        Caption = 'Emitente: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 45
        Width = 51
        Height = 13
        Caption = 'Emiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 5
        Top = 15
        Width = 36
        Height = 13
        Caption = 'Nota: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbNota: TLabel
        Left = 85
        Top = 15
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbEmitente: TLabel
        Left = 85
        Top = 30
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbOperacao: TLabel
        Left = 214
        Top = 15
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 151
        Top = 15
        Width = 60
        Height = 13
        Caption = 'Opera'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbEmissao: TLabel
        Left = 85
        Top = 45
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 60
        Width = 58
        Height = 13
        Caption = 'Ent/sa'#237'da'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbEntSai: TLabel
        Left = 85
        Top = 60
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 500
        Top = 14
        Width = 29
        Height = 13
        Caption = 'CFO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbCFO: TLabel
        Left = 535
        Top = 14
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 472
        Top = 30
        Width = 34
        Height = 13
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbValor: TLabel
        Left = 510
        Top = 30
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 406
        Top = 49
        Width = 99
        Height = 13
        Caption = 'Despesas Extras:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDEspExtra: TLabel
        Left = 510
        Top = 49
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object StaticText1: TStaticText
    Left = 5
    Top = 99
    Width = 68
    Height = 17
    Caption = 'Itens da Nota'
    TabOrder = 2
  end
  object qr: TADOQuery
    Parameters = <>
    Left = 96
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = qr
    Left = 128
    Top = 168
  end
end
