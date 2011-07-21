object fmForn: TfmForn
  Left = 501
  Top = 280
  Width = 526
  Height = 341
  Caption = 'Fornecedores'
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
  object fnGrid: TSoftDBGrid
    Left = 7
    Top = 48
    Width = 500
    Height = 225
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = fnGridDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWhite
  end
  object edit1: TadLabelEdit
    Left = 7
    Top = 19
    Width = 258
    Height = 26
    LabelDefs.Width = 199
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Digite o nome do fornecedor para busrcar:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnChange = edit1Change
  end
  object BitBtn2: TFlatButton
    Left = 352
    Top = 274
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
    ModalResult = 1
  end
  object BitBtn3: TFlatButton
    Left = 432
    Top = 274
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
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object fsBuscaNumero: TfsCheckBox
    Left = 270
    Top = 23
    Width = 126
    Height = 17
    Caption = 'Procurar pelo n'#250'mero'
    TabOrder = 4
    OnClick = fsBuscaNumeroClick
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object FlatButton1: TFlatButton
    Left = 408
    Top = 16
    Width = 97
    Height = 29
    Caption = '&Procurar'
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 5
    OnClick = FlatButton1Click
  end
  object DataSource1: TDataSource
    DataSet = qrCredores
    Left = 104
    Top = 88
  end
  object qrCredores: TADOQuery
    Connection = fmMain.Conexao
    Parameters = <>
    Left = 104
    Top = 120
  end
end
