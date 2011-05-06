object Form3: TForm3
  Left = 271
  Top = 156
  Width = 338
  Height = 122
  Caption = 'Cheques por data de emissao'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 238
    Top = 22
    Width = 75
    Height = 27
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object medit1: TadLabelMaskEdit
    Left = 119
    Top = 23
    Width = 101
    Height = 21
    Ctl3D = True
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    ParentCtl3D = False
    TabOrder = 1
    Text = '  /  /    '
    LabelDefs.Width = 110
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Data lancamento'
    LabelDefs.Font.Charset = ANSI_CHARSET
    LabelDefs.Font.Color = clNavy
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'Verdana'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\Projetos\Cheques\Relatorio\ChPorDataEmissao.rav'
    Left = 104
    Top = 53
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query1
    Left = 192
    Top = 53
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Rela'#231#227'o de Cheques Devolvidos Por Data de lancamento'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormHeight = 100
    SystemPreview.ZoomFactor = 80.000000000000000000
    SystemPrinter.Orientation = poLandScape
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 144
    Top = 53
  end
  object Query1: TQuery
    DatabaseName = 'CONT_CHEQUES'
    SQL.Strings = (
      
        'select lancamento, loja, cliente, NumCheque, vencimento, valor, ' +
        'porconta, observacao'
      'from cheques '
      'where lancamento > '#39'01/01/2002'#39
      'order by cliente')
    Left = 64
    Top = 53
    object Query1lancamento: TDateTimeField
      FieldName = 'lancamento'
    end
    object Query1loja: TStringField
      FieldName = 'loja'
      FixedChar = True
    end
    object Query1cliente: TStringField
      FieldName = 'cliente'
      FixedChar = True
      Size = 50
    end
    object Query1NumCheque: TStringField
      FieldName = 'NumCheque'
      FixedChar = True
      Size = 10
    end
    object Query1vencimento: TDateTimeField
      FieldName = 'vencimento'
    end
    object Query1valor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
    end
    object Query1porconta: TFloatField
      FieldName = 'porconta'
      DisplayFormat = '#,###,###0.00'
    end
    object Query1observacao: TStringField
      FieldName = 'observacao'
      FixedChar = True
      Size = 50
    end
  end
end
