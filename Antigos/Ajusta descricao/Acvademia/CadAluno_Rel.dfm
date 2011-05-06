object frmRelCadAlu: TfrmRelCadAlu
  Left = 209
  Top = 200
  Width = 696
  Height = 480
  Caption = 'frmRelCadAlu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = qryAlu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100
      2970
      100
      2100
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object QRBand1: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333
        1899.70833333333)
      BandType = rbTitle
      object QRLabel9: TQRLabel
        Left = 179
        Top = 16
        Width = 359
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          473.604166666667
          42.3333333333333
          949.854166666667)
        Alignment = taCenter
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'Confirmação de Cadastro de Aluno no Sistema:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic, fsUnderline]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 12
      end
    end
    object QRBand2: TQRBand
      Left = 38
      Top = 78
      Width = 718
      Height = 155
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        410.104166666667
        1899.70833333333)
      BandType = rbDetail
      object QRDBText1: TQRDBText
        Left = 96
        Top = 8
        Width = 39
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          21.1666666666667
          103.1875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText2: TQRDBText
        Left = 96
        Top = 32
        Width = 71
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          84.6666666666667
          187.854166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'ENDERECO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Left = 96
        Top = 56
        Width = 51
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          148.166666666667
          134.9375)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'BAIRRO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 96
        Top = 80
        Width = 49
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          211.666666666667
          129.645833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'CIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 96
        Top = 104
        Width = 54
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          275.166666666667
          142.875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'ESTADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText6: TQRDBText
        Left = 96
        Top = 128
        Width = 79
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          254
          338.666666666667
          209.020833333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = qryAlu
        DataField = 'DATA_NASC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel1: TQRLabel
        Left = 16
        Top = 8
        Width = 39
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          21.1666666666667
          103.1875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Nome:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 16
        Top = 32
        Width = 60
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          84.6666666666667
          158.75)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Endereço:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 16
        Top = 56
        Width = 39
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          148.166666666667
          103.1875)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Bairro:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 16
        Top = 80
        Width = 45
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          211.666666666667
          119.0625)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Cidade:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 16
        Top = 104
        Width = 46
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          275.166666666667
          121.708333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Estado:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 16
        Top = 128
        Width = 74
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          42.3333333333333
          338.666666666667
          195.791666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Nascimento:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object qryAlu: TQuery
    DatabaseName = 'Banco de Dados Academia'
    DataSource = frmCadAluno.dsAlu
    SQL.Strings = (
      'SELECT *'
      'FROM ALUNO'
      'WHERE COD_ALU = :COD_ALU')
    Left = 8
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COD_ALU'
        ParamType = ptUnknown
      end>
    object qryAluCOD_ALU: TIntegerField
      FieldName = 'COD_ALU'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_ALU'
    end
    object qryAluNOME: TStringField
      FieldName = 'NOME'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.NOME'
      FixedChar = True
      Size = 70
    end
    object qryAluENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.ENDERECO'
      FixedChar = True
      Size = 70
    end
    object qryAluBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.BAIRRO'
      FixedChar = True
    end
    object qryAluCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CIDADE'
      FixedChar = True
    end
    object qryAluESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.ESTADO'
      FixedChar = True
      Size = 2
    end
    object qryAluTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.TELEFONE'
      FixedChar = True
      Size = 15
    end
    object qryAluCEP: TStringField
      FieldName = 'CEP'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CEP'
      FixedChar = True
      Size = 10
    end
    object qryAluRG: TStringField
      FieldName = 'RG'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.RG'
      FixedChar = True
      Size = 15
    end
    object qryAluCPF: TStringField
      FieldName = 'CPF'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CPF'
      FixedChar = True
      Size = 15
    end
    object qryAluDATA_NASC: TDateTimeField
      FieldName = 'DATA_NASC'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_NASC'
    end
    object qryAluDATA_CAD: TDateTimeField
      FieldName = 'DATA_CAD'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_CAD'
    end
    object qryAluOBS: TMemoField
      FieldName = 'OBS'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.OBS'
      BlobType = ftMemo
    end
    object qryAluCOD_MOD1: TIntegerField
      FieldName = 'COD_MOD1'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD1'
    end
    object qryAluCOD_MOD2: TIntegerField
      FieldName = 'COD_MOD2'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD2'
    end
    object qryAluCOD_MOD3: TIntegerField
      FieldName = 'COD_MOD3'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD3'
    end
    object qryAluCOD_MOD4: TIntegerField
      FieldName = 'COD_MOD4'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD4'
    end
    object qryAluCOD_MOD5: TIntegerField
      FieldName = 'COD_MOD5'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD5'
    end
    object qryAluCOD_MOD6: TIntegerField
      FieldName = 'COD_MOD6'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_MOD6'
    end
    object qryAluDATA_VENC: TDateTimeField
      FieldName = 'DATA_VENC'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.DATA_VENC'
    end
    object qryAluVLR_DEVIDO: TFloatField
      FieldName = 'VLR_DEVIDO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.VLR_DEVIDO'
    end
  end
end
