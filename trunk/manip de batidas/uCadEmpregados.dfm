object fmCadEmpregados: TfmCadEmpregados
  Left = 379
  Top = 197
  Width = 645
  Height = 541
  Caption = 'Cadastro de empregados.'
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
  DesignSize = (
    629
    503)
  PixelsPerInch = 96
  TextHeight = 13
  object gpListaEmp: TGroupBox
    Left = 0
    Top = 216
    Width = 629
    Height = 122
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Empregados '
    TabOrder = 0
    DesignSize = (
      629
      122)
    object gridEmp: TSoftDBGrid
      Left = 2
      Top = 40
      Width = 623
      Height = 78
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = gridEmpDblClick
      OnTitleClick = gridEmpTitleClick
      AlternateColor = True
      ColorLow = clWindow
      ColorHigh = clInfoBk
    end
    object edLocEmp: TadLabelEdit
      Left = 2
      Top = 15
      Width = 431
      Height = 19
      LabelDefs.Width = 51
      LabelDefs.Height = 13
      LabelDefs.Caption = 'edLocEmp'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyDown = edLocEmpKeyDown
    end
    object cbLojas: TComboBox
      Left = 447
      Top = 14
      Width = 178
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkSoft
      BevelOuter = bvRaised
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      Ctl3D = False
      ItemHeight = 13
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 2
      OnChange = cbLojasChange
    end
  end
  object gpEmp: TGroupBox
    Left = 8
    Top = 11
    Width = 617
    Height = 193
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Dados dos empregados '
    TabOrder = 1
    Visible = False
    object lbHorario: TLabel
      Left = 308
      Top = 124
      Width = 42
      Height = 13
      Caption = 'lbHorario'
      Visible = False
    end
    object lbLocalizacao: TLabel
      Left = 309
      Top = 99
      Width = 65
      Height = 13
      Caption = 'lbLocalizacao'
      Visible = False
    end
    object lbDataAdmissao: TLabel
      Left = 421
      Top = 107
      Width = 76
      Height = 13
      Caption = 'lbDataAdmissao'
      Visible = False
    end
    object lbEmpresa: TLabel
      Left = 422
      Top = 122
      Width = 49
      Height = 13
      Caption = 'lbEmpresa'
      Visible = False
    end
    object edHorario: TadLabelEdit
      Left = 67
      Top = 122
      Width = 202
      Height = 19
      LabelDefs.Width = 37
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Hor'#225'rio:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
      Text = 'edNome'
    end
    object edNome: TadLabelEdit
      Left = 37
      Top = 70
      Width = 345
      Height = 19
      LabelDefs.Width = 28
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nome'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edNome'
    end
    object edMatricula: TadLabelEdit
      Left = 55
      Top = 21
      Width = 76
      Height = 19
      LabelDefs.Width = 46
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Matricula:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
      Text = 'adLabelEdit1'
    end
    object edCartaoPonto: TadLabelEdit
      Left = 275
      Top = 20
      Width = 105
      Height = 19
      LabelDefs.Width = 79
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Cart'#227'o de ponto:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 2
      Text = 'adLabelEdit1'
    end
    object rgHoraFlexivel: TRadioGroup
      Left = 429
      Top = 64
      Width = 140
      Height = 33
      Caption = 'Hor'#225'rio flex'#237'vel'
      Columns = 2
      Items.Strings = (
        'N'#227'o'
        'Sim ')
      TabOrder = 3
    end
    object edFuncao: TadLabelEdit
      Left = 46
      Top = 46
      Width = 203
      Height = 19
      LabelDefs.Width = 39
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Fun'#231#227'o:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      Text = 'adLabelEdit1'
    end
    object edLocalizacao: TadLabelEdit
      Left = 67
      Top = 96
      Width = 202
      Height = 19
      LabelDefs.Width = 57
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Localiza'#231#227'o'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
      Text = 'edNome'
    end
    object btCarregaHorario: TfsBitBtn
      Left = 272
      Top = 119
      Width = 29
      Height = 25
      Caption = '...'
      TabOrder = 7
      OnClick = btCarregaHorarioClick
      NumGlyphs = 2
    end
    object fsBitBtn1: TfsBitBtn
      Left = 273
      Top = 92
      Width = 29
      Height = 25
      Caption = '...'
      TabOrder = 8
      OnClick = fsBitBtn1Click
      NumGlyphs = 2
    end
    object Panel2: TPanel
      Left = 492
      Top = 160
      Width = 99
      Height = 29
      BevelOuter = bvNone
      TabOrder = 9
      object fsBitBtn2: TfsBitBtn
        Left = 51
        Top = 2
        Width = 46
        Height = 25
        ModalResult = 2
        TabOrder = 0
        OnClick = fsBitBtn2Click
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
        NumGlyphs = 2
      end
      object fsBitBtn3: TfsBitBtn
        Left = 3
        Top = 2
        Width = 46
        Height = 25
        ModalResult = 1
        TabOrder = 1
        OnClick = fsBitBtn3Click
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
        NumGlyphs = 2
      end
    end
    object cbBatePonto: TFlatCheckBox
      Left = 400
      Top = 21
      Width = 121
      Height = 17
      Caption = 'Bate Ponto'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 10
      TabStop = True
    end
  end
  object DataSource1: TDataSource
    DataSet = qr
    Left = 56
    Top = 306
  end
  object qr: TADOQuery
    Parameters = <>
    Left = 56
    Top = 346
  end
  object PopupMenu1: TPopupMenu
    Left = 152
    Top = 288
    object RemoveEmpregadodocadastro1: TMenuItem
      Caption = 'Remove Empregado do  cadastro.'
      OnClick = RemoveEmpregadodocadastro1Click
    end
  end
end
