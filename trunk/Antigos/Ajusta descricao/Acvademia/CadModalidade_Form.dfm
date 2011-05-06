object frmCadMod: TfrmCadMod
  Left = 378
  Top = 277
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Modalidades'
  ClientHeight = 298
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 49
    Top = 3
    Width = 159
    Height = 16
    Caption = 'Modalidades cadastradas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 19
    Width = 243
    Height = 214
    DataSource = dsMod
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Modalidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Mensalidade'
        Width = 85
        Visible = True
      end>
  end
  object btnNova: TBitBtn
    Left = 68
    Top = 240
    Width = 121
    Height = 25
    Caption = '&Nova Modalidade'
    TabOrder = 1
    OnClick = btnNovaClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
      300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
      330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
      333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
      339977FF777777773377000BFB03333333337773FF733333333F333000333333
      3300333777333333337733333333333333003333333333333377333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object btnAltera: TBitBtn
    Left = 68
    Top = 268
    Width = 121
    Height = 25
    Caption = '&Altera Modalidade'
    TabOrder = 2
    OnClick = btnAlteraClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object qryMod: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select Modalidade, Mensalidade '
      'From Modalidade '
      'Order By Modalidade')
    Left = 64
    Top = 80
    object qryModModalidade: TStringField
      DisplayLabel = 'Modalidade:'
      FieldName = 'Modalidade'
      FixedChar = True
    end
    object qryModMensalidade: TFloatField
      DisplayLabel = 'Mensalidade:'
      FieldName = 'Mensalidade'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dsMod: TDataSource
    AutoEdit = False
    DataSet = qryMod
    Left = 144
    Top = 80
  end
end
