object fmClassificaProd: TfmClassificaProd
  Left = 2
  Top = 23
  Width = 798
  Height = 547
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Classifica'#231#227'o em massa de produtos.     '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 276
    Width = 131
    Height = 13
    AutoSize = False
    Caption = 'Classifica'#231#227'o atual'
  end
  object Label1: TLabel
    Left = 238
    Top = 3
    Width = 192
    Height = 13
    AutoSize = False
    Caption = 'Classifica'#231#227'o'
  end
  object Barra: TFlatGauge
    Left = 6
    Top = 539
    Width = 209
    Height = 25
    AdvColorBorder = 0
    ColorBorder = 8623776
    Progress = 25
    Visible = False
  end
  object FlatButton1: TFlatButton
    Left = 110
    Top = 15
    Width = 77
    Height = 26
    Caption = '&Listar'
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object edit1: TadLabelEdit
    Left = 5
    Top = 15
    Width = 102
    Height = 26
    LabelDefs.Width = 76
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Faixa de C'#243'digo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnKeyDown = edit1KeyDown
  end
  object DBGrid2: TDBGrid
    Left = 7
    Top = 291
    Width = 209
    Height = 204
    Ctl3D = False
    DataSource = DataSource2
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_campo'
        Title.Caption = 'Nivel'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 137
        Visible = True
      end>
  end
  object DBGrid3: TSoftDBGrid
    Left = 235
    Top = 275
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource3
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid3CellClick
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
  object DBGrid4: TSoftDBGrid
    Left = 420
    Top = 275
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource4
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid4CellClick
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
  object DBGrid5: TSoftDBGrid
    Left = 605
    Top = 275
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource5
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
  object clb1: TadLabelCheckListBox
    Left = 5
    Top = 57
    Width = 780
    Height = 215
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
    OnClick = clb1Click
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Itens'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton2: TFlatButton
    Left = 599
    Top = 2
    Width = 186
    Height = 43
    Caption = 'Reclassificar itens selecionados'
    TabOrder = 7
    OnClick = FlatButton2Click
  end
  object cbListaClassificado: TfsComboBox
    Left = 239
    Top = 20
    Width = 165
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
    Text = 'Nao classificados'
    Items.Strings = (
      'Nao classificados'
      'Classificados'
      'Todos')
  end
  object FlatButton3: TFlatButton
    Left = 7
    Top = 497
    Width = 120
    Height = 37
    Caption = '&Manter Classifica'#231#227'o'
    TabOrder = 9
    OnClick = FlatButton3Click
  end
  object cbDiversos: TfsCheckBox
    Left = 413
    Top = 21
    Width = 177
    Height = 17
    Caption = 'Somente categoria  "Diversos"'
    TabOrder = 10
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object Query1: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select is_ref,cd_ref,ds_ref from crefe where cd_ref like '#39'001%'#39' ' +
        'order by ds_ref')
    Left = 88
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 120
    Top = 80
  end
  object DataSource2: TDataSource
    DataSet = Query2
    Left = 48
    Top = 376
  end
  object Query2: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select c.cd_campo, D.ds_vcampo from tvcom D, cccom C where  c.cd' +
        '_vcampo = d.cd_vcampo and d.cd_campo=c.cd_campo and c.cd_chave =' +
        ' 162')
    Left = 24
    Top = 368
  end
  object Query3: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =1 order' +
        ' by ds_vcampo')
    Left = 320
    Top = 400
  end
  object DataSource3: TDataSource
    AutoEdit = False
    DataSet = Query3
    Left = 320
    Top = 368
  end
  object DataSource4: TDataSource
    DataSet = Query4
    Left = 536
    Top = 344
  end
  object Query4: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    Left = 536
    Top = 376
  end
  object DataSource5: TDataSource
    DataSet = Query5
    Left = 733
    Top = 336
  end
  object Query5: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    Left = 736
    Top = 368
  end
  object Query6: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 528
    Top = 120
  end
end
