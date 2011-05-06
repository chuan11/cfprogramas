object Form8: TForm8
  Left = 491
  Top = 213
  Width = 800
  Height = 394
  Caption = 'Valores vendidos de cada lista por data'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cbLojas: TadLabelComboBox
    Left = 6
    Top = 23
    Width = 100
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object BitBtn2: TFlatButton
    Left = 586
    Top = 16
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
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object grid: TSoftDBGrid
    Left = 0
    Top = 56
    Width = 784
    Height = 261
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 317
    Width = 784
    Height = 39
    Align = alBottom
    TabOrder = 4
    object GroupBox1: TGroupBox
      Left = 494
      Top = -1
      Width = 134
      Height = 35
      Caption = ' Total de itens '
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 96
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '--'
      end
    end
    object GroupBox2: TGroupBox
      Left = 633
      Top = -1
      Width = 134
      Height = 35
      Caption = 'Valor Total'
      TabOrder = 1
      object Label2: TLabel
        Left = 16
        Top = 15
        Width = 99
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '--'
      end
    end
    object btGeraCredito: TFlatButton
      Left = 2
      Top = 4
      Width = 184
      Height = 29
      Caption = '&Gerar cr'#233'dito de cliente'
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
      TabOrder = 2
      Visible = False
      OnClick = btGeraCreditoClick
    end
  end
  object cbTpListas: TadLabelComboBox
    Left = 402
    Top = 23
    Width = 141
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    LabelDefs.Width = 57
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo de lista'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object GroupBox3: TGroupBox
    Left = 128
    Top = 3
    Width = 257
    Height = 52
    Caption = 'Per'#237'odo do vencimento das listas'
    TabOrder = 0
    object Label1: TLabel
      Left = 112
      Top = 23
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object dt1: TDateTimePicker
      Left = 7
      Top = 20
      Width = 100
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvRaised
      Date = 39283.440834780090000000
      Time = 39283.440834780090000000
      TabOrder = 0
    end
    object dt2: TDateTimePicker
      Left = 140
      Top = 19
      Width = 100
      Height = 21
      Date = 39283.440834780090000000
      Time = 39283.440834780090000000
      TabOrder = 1
    end
  end
  object Query: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'exec stoListaValoresComprasPorListas '#39'2009-07-01'#39' , '#39'2009-07-15'#39 +
        ' , '#39#39', '#39#39)
    Left = 136
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = Query
    Left = 64
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    Top = 112
    object Gerarorecibodobonus1: TMenuItem
      Caption = 'Gerar o recibo de bonus'
      OnClick = Gerarorecibodobonus1Click
    end
  end
end
