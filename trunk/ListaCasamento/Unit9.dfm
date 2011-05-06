object Form9: TForm9
  Left = 534
  Top = 167
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Rela'#231#227'o de produtos comprados por per'#237'odo.'
  ClientHeight = 131
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 125
    Top = 8
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label2: TLabel
    Left = 260
    Top = 8
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object cbLojas: TadLabelComboBox
    Left = 6
    Top = 23
    Width = 100
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    ItemHeight = 13
    TabOrder = 0
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object BitBtn2: TFlatButton
    Left = 226
    Top = 64
    Width = 75
    Height = 29
    Caption = '&OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object BitBtn3: TFlatButton
    Left = 306
    Top = 64
    Width = 75
    Height = 29
    Caption = '&Cancelar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn3Click
  end
  object dt1: TDateTimePicker
    Left = 125
    Top = 23
    Width = 122
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvRaised
    Date = 39283.440834780090000000
    Time = 39283.440834780090000000
    TabOrder = 3
  end
  object dt2: TDateTimePicker
    Left = 260
    Top = 23
    Width = 122
    Height = 21
    Date = 39283.440834780090000000
    Time = 39283.440834780090000000
    TabOrder = 4
  end
  object RvDataSetConnection3: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = q1
    Left = 56
    Top = 64
  end
  object q2: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec ListasComItensCompPorData_corpo 99, '#39'12/17/2007'#39', '#39'12/17/20' +
        '07'#39)
    Left = 8
    Top = 96
    object q2numlista: TIntegerField
      FieldName = 'numlista'
    end
    object q2ljBaixa: TWideStringField
      FieldName = 'ljBaixa'
      Size = 10
    end
    object q2Codigo: TStringField
      FieldName = 'Codigo'
      Size = 7
    end
    object q2NomeProduto: TStringField
      FieldName = 'NomeProduto'
      Size = 40
    end
    object q2convidado: TStringField
      FieldName = 'convidado'
      Size = 40
    end
    object q2ObsItem: TStringField
      FieldName = 'ObsItem'
      Size = 30
    end
    object q2dtCompra: TDateTimeField
      FieldName = 'dtCompra'
    end
    object q2valor: TBCDField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 10
    end
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\Listas\EspelhoLista.rav'
    Left = 120
    Top = 64
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Op'#231#245'es de relat'#243'rio'
    TitleStatus = 'Progesso do relat'#243'rio'
    TitlePreview = 'Impress'#227'o de relat'#243'rio'
    SystemSetups = [ssAllowSetup, ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowPrinterSetup, ssAllowPreviewSetup]
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 88
    Top = 64
  end
  object RvDataSetConnection4: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = q2
    Left = 56
    Top = 96
  end
  object q1: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'exec ListasComItensCompPorData_cabeca 99, '#39'12/17/2007'#39', '#39'12/17/2' +
        '007'#39)
    Left = 8
    Top = 64
  end
end
