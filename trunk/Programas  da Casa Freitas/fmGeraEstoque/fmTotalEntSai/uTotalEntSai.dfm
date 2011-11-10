object fmTotalEntSai: TfmTotalEntSai
  Left = 454
  Top = 204
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Total de entradas e sa'#237'das'
  ClientHeight = 171
  ClientWidth = 496
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 10
    Top = 52
    Width = 75
    Height = 13
    Caption = 'Data 1'#186' entrada'
  end
  object lbPrimEnt: TLabel
    Left = 107
    Top = 52
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 98
    Width = 89
    Height = 13
    Caption = 'Total de Compras :'
  end
  object lbTotEnt: TLabel
    Left = 107
    Top = 98
    Width = 137
    Height = 13
    AutoSize = False
    Caption = '0000000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 10
    Top = 121
    Width = 83
    Height = 13
    Caption = 'Total de vendas: '
  end
  object lbTotVenda: TLabel
    Left = 107
    Top = 121
    Width = 71
    Height = 13
    Caption = '0000000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 105
    Top = 159
    Width = 389
    Height = 2
  end
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 488
    Height = 41
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 7
      Width = 49
      Height = 13
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 58
      Top = 6
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDados: TLabel
      Left = 58
      Top = 7
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
