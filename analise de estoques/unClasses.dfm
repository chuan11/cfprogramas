object FmClasses: TFmClasses
  Left = 343
  Top = 190
  BorderStyle = bsToolWindow
  Caption = 'Valores das Categorias'
  ClientHeight = 334
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 312
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object grClasse1: TSoftDBGrid
    Left = 3
    Top = 4
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DsClasse1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse1CellClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Classe 01'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object grClasse2: TSoftDBGrid
    Left = 188
    Top = 4
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = dsClasse2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse2CellClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Classe 02'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object grClasse3: TSoftDBGrid
    Left = 373
    Top = 5
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = dsClasse3
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse3CellClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Classe 03'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object fsBitBtn1: TfsBitBtn
    Left = 478
    Top = 302
    Width = 75
    Height = 28
    Caption = 'OK'
    ModalResult = 2
    TabOrder = 3
    OnClick = fsBitBtn1Click
  end
  object qrClasse1: TADOQuery
    Connection = Form1.Conexao
    Parameters = <>
    Left = 40
    Top = 72
  end
  object qrClasse2: TADOQuery
    Connection = Form1.Conexao
    Parameters = <>
    Left = 256
    Top = 72
  end
  object qrClasse3: TADOQuery
    Connection = Form1.Conexao
    Parameters = <>
    Left = 400
    Top = 80
  end
  object DsClasse1: TDataSource
    DataSet = qrClasse1
    Left = 40
    Top = 104
  end
  object dsClasse2: TDataSource
    DataSet = qrClasse2
    Left = 256
    Top = 104
  end
  object dsClasse3: TDataSource
    DataSet = qrClasse3
    Left = 400
    Top = 112
  end
end
