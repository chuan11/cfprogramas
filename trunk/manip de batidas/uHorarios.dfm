object fmHorarios: TfmHorarios
  Left = 485
  Top = 275
  Width = 572
  Height = 510
  Caption = 'fmHorarios'
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 8
    Top = 8
    Width = 537
    Height = 197
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    OnTitleClick = gridTitleClick
    AlternateColor = False
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 8
    Top = 235
    Width = 537
    Height = 189
    TabOrder = 1
    Visible = False
    object GroupBox1: TGroupBox
      Left = 6
      Top = 7
      Width = 523
      Height = 150
      Caption = ' Segunda  '
      TabOrder = 0
      object Label1: TLabel
        Left = 67
        Top = 17
        Width = 43
        Height = 13
        Caption = 'Segunda'
      end
      object Label2: TLabel
        Left = 132
        Top = 15
        Width = 28
        Height = 13
        Caption = 'Ter'#231'a'
      end
      object Label3: TLabel
        Left = 196
        Top = 15
        Width = 32
        Height = 13
        Caption = 'Quarta'
      end
      object Label4: TLabel
        Left = 260
        Top = 15
        Width = 31
        Height = 13
        Caption = 'Quinta'
      end
      object Label5: TLabel
        Left = 318
        Top = 15
        Width = 27
        Height = 13
        Caption = 'Sexta'
      end
      object Label6: TLabel
        Left = 380
        Top = 15
        Width = 37
        Height = 13
        Caption = 'Sabado'
      end
      object Label8: TLabel
        Left = 19
        Top = 33
        Width = 40
        Height = 13
        Caption = 'Entrada:'
      end
      object Label9: TLabel
        Left = 17
        Top = 59
        Width = 42
        Height = 13
        Caption = 'Inicio int:'
      end
      object Label10: TLabel
        Left = 15
        Top = 84
        Width = 44
        Height = 13
        Caption = 'Inicio fim:'
      end
      object Label11: TLabel
        Left = 32
        Top = 108
        Width = 30
        Height = 13
        Caption = 'Saida:'
      end
      object Label12: TLabel
        Left = 7
        Top = 133
        Width = 42
        Height = 13
        Caption = 'Total : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbTotHoras: TLabel
        Left = 41
        Top = 133
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edSegEnt: TMaskEdit
        Left = 65
        Top = 32
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 0
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSegIntIni: TMaskEdit
        Left = 65
        Top = 57
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 1
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSegIntFim: TMaskEdit
        Left = 65
        Top = 82
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 2
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSegSai: TMaskEdit
        Left = 65
        Top = 107
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 3
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edTerEnt: TMaskEdit
        Left = 130
        Top = 31
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 4
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edTerIntIni: TMaskEdit
        Left = 130
        Top = 56
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 5
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edTerIntFim: TMaskEdit
        Left = 130
        Top = 81
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 6
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edTerSai: TMaskEdit
        Left = 130
        Top = 106
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 7
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuaEnt: TMaskEdit
        Left = 194
        Top = 31
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 8
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuaIntIni: TMaskEdit
        Left = 194
        Top = 56
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 9
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuaIntFim: TMaskEdit
        Left = 194
        Top = 81
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 10
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuaSai: TMaskEdit
        Left = 194
        Top = 106
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 11
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSabSai: TMaskEdit
        Left = 375
        Top = 104
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 23
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSabIntFim: TMaskEdit
        Left = 375
        Top = 78
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 22
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSabIntIni: TMaskEdit
        Left = 375
        Top = 54
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 21
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSabEnt: TMaskEdit
        Left = 375
        Top = 30
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 20
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSexEnt: TMaskEdit
        Left = 310
        Top = 30
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 16
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSexIntIni: TMaskEdit
        Left = 310
        Top = 55
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 17
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSexIntFim: TMaskEdit
        Left = 310
        Top = 81
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 18
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edSexSai: TMaskEdit
        Left = 310
        Top = 104
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 19
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuiSai: TMaskEdit
        Left = 254
        Top = 104
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 15
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuiIntFim: TMaskEdit
        Left = 254
        Top = 81
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 14
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuiIntIni: TMaskEdit
        Left = 254
        Top = 55
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 13
        Text = '  :  '
        OnExit = edSegEntExit
      end
      object edQuiEnt: TMaskEdit
        Left = 252
        Top = 30
        Width = 45
        Height = 19
        AutoSize = False
        Ctl3D = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 12
        Text = '  :  '
        OnExit = edSegEntExit
      end
    end
    object fsBitBtn4: TfsBitBtn
      Left = 135
      Top = 133
      Width = 46
      Height = 21
      Caption = 'Repete'
      TabOrder = 1
      OnClick = fsBitBtn4Click
      NumGlyphs = 2
    end
    object fsBitBtn5: TfsBitBtn
      Left = 199
      Top = 133
      Width = 46
      Height = 21
      Caption = 'Repete'
      TabOrder = 2
      OnClick = fsBitBtn5Click
      NumGlyphs = 2
    end
    object fsBitBtn6: TfsBitBtn
      Left = 260
      Top = 133
      Width = 46
      Height = 21
      Caption = 'Repete'
      TabOrder = 3
      OnClick = fsBitBtn6Click
      NumGlyphs = 2
    end
    object fsBitBtn7: TfsBitBtn
      Left = 316
      Top = 133
      Width = 46
      Height = 21
      Caption = 'Repete'
      TabOrder = 4
      OnClick = fsBitBtn7Click
      NumGlyphs = 2
    end
    object fsBitBtn8: TfsBitBtn
      Left = 380
      Top = 133
      Width = 46
      Height = 21
      Caption = 'Repete'
      TabOrder = 5
      OnClick = fsBitBtn8Click
      NumGlyphs = 2
    end
    object Panel2: TPanel
      Left = 428
      Top = 158
      Width = 101
      Height = 29
      TabOrder = 6
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
  end
  object btCarregaHorario: TfsBitBtn
    Left = 457
    Top = 207
    Width = 35
    Height = 25
    TabOrder = 2
    OnClick = btCarregaHorarioClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
  end
  object btDeleta: TfsBitBtn
    Left = 510
    Top = 207
    Width = 35
    Height = 25
    TabOrder = 3
    OnClick = btDeletaClick
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
  object DataSource1: TDataSource
    DataSet = tbHor
    Left = 96
    Top = 16
  end
  object tbHor: TADOTable
    Connection = Form2.conexaoWell
    BeforeDelete = tbHorBeforeDelete
    Left = 128
    Top = 16
  end
end
