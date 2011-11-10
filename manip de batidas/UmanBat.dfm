object Form2: TForm2
  Left = 383
  Top = 70
  Width = 988
  Height = 690
  BorderIcons = [biSystemMenu, biMinimize]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000001510000000000000000000
    00000000111881100008FF800000000000000001918119100088887800000000
    000000111899991000F8FF8F000000000000001189999990F088FF8F00000000
    000011189999991000888FF80000000000001981999999088008FF8000000000
    00199899999911088800000000000000001189999999170F8880000000000000
    1118999999117870F88800000000000011899999911F08700F80800000000001
    1819999911000F80F0F80F00000000118189899110000087000F808000000008
    99989910000000F80000F888000000019989F1000000000870000F8880000001
    999910000000000F8000007F80000701999900000000000087000070000000F0
    1911888888880000F80000000000000700000000000000000870000000000000
    00000000000000000F80000000000000000000000000000000F0000000000000
    000000F00000000000000000000000000000000F000000000000000000000000
    00000000F00000000000000000000000000000000F0000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 960
    Height = 661
    ActivePage = TabSheet4
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = False
    Visible = False
    object TabSheet4: TTabSheet
      Caption = 'Rel Espelho'
      ImageIndex = 3
      OnEnter = TabSheet4Enter
      OnExit = TabSheet4Exit
      object Label14: TLabel
        Left = 2
        Top = 7
        Width = 57
        Height = 20
        Caption = 'Arquivo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 61
        Top = 7
        Width = 210
        Height = 20
        Cursor = crHandPoint
        AutoSize = False
        BiDiMode = bdRightToLeftNoAlign
        Caption = 'C:\Espelho.txt'
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        OnDblClick = Label1DblClick
      end
      object Label12: TLabel
        Left = 1
        Top = 405
        Width = 136
        Height = 13
        Caption = 'Manter as justificativas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 507
        Top = 7
        Width = 175
        Height = 13
        Caption = 'Ctrl+F - Localizar    F6 - Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BitBtn9: TBitBtn
        Left = 275
        Top = 1
        Width = 105
        Height = 34
        Caption = 'Ajustar Espelho'
        TabOrder = 0
        OnClick = BitBtn9Click
        Kind = bkOK
        Style = bsNew
      end
      object BitBtn3: TBitBtn
        Left = 387
        Top = 1
        Width = 105
        Height = 34
        Caption = 'Ajustes Finos'
        ModalResult = 5
        TabOrder = 1
        OnClick = BitBtn3Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
          FFFF33333333333FFFFF3FFFFFFFFF00000F333333333377777F33FFFFFFFF09
          990F33333333337F337F333FFFFFFF09990F33333333337F337F3333FFFFFF09
          990F33333333337FFF7F33333FFFFF00000F3333333333777773333333FFFFFF
          FFFF3FFFFF3333333F330000033FFFFF0FFF77777F3333337FF30EEE0333FFF0
          00FF7F337FFF333777FF0EEE00033F00000F7F33777F3777777F0EEE0E033000
          00007FFF7F7FF777777700000E00033000FF777773777F3777F3330EEE0E0330
          00FF337FFF7F7F3777F33300000E033000FF337777737F37773333330EEE0300
          03FF33337FFF77777333333300000333333F3333777773333333}
        NumGlyphs = 2
      end
      object Button3: TButton
        Left = 575
        Top = 420
        Width = 99
        Height = 40
        Caption = 'Dia &Normal'
        TabOrder = 2
        Visible = False
        OnClick = Button3Click
      end
      object Button5: TButton
        Left = 783
        Top = 420
        Width = 99
        Height = 40
        Caption = 'F&alta + Mensagem'
        TabOrder = 3
        Visible = False
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 679
        Top = 420
        Width = 99
        Height = 40
        Caption = '&Falta'
        TabOrder = 4
        Visible = False
        OnClick = Button6Click
      end
      object Edit1: TEdit
        Left = 678
        Top = 465
        Width = 145
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 5
        Text = 'ATESTADO MEDICO'
        Visible = False
      end
      object Button7: TButton
        Left = 472
        Top = 420
        Width = 99
        Height = 40
        Caption = 'Folg&a'
        TabOrder = 6
        Visible = False
        OnClick = Button7Click
      end
      object Memo2: TMemo
        Left = -1
        Top = 40
        Width = 779
        Height = 365
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 7
        Visible = False
        OnKeyPress = Memo2KeyPress
      end
      object CLBox1: TCheckListBox
        Left = 0
        Top = 418
        Width = 148
        Height = 75
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 8
      end
      object sedit1: TadLabelSpinEdit
        Left = 624
        Top = 463
        Width = 46
        Height = 23
        Cursor = crDefault
        LabelDefs.Width = 137
        LabelDefs.Height = 14
        LabelDefs.Caption = 'Dia anterior como referencia'
        LabelPosition = adLeft
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Decimals = 0
        MaxValue = 31.000000000000000000
        MinValue = -31.000000000000000000
        TabOrder = 9
        Visible = False
        Increment = 1.000000000000000000
        RoundValues = False
        Wrap = False
      end
      object Edit6: TEdit
        Left = 154
        Top = 419
        Width = 129
        Height = 20
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 10
      end
      object Button9: TButton
        Left = 154
        Top = 442
        Width = 78
        Height = 25
        Caption = 'Pegar horario'
        TabOrder = 11
        OnClick = Button9Click
      end
      object Button11: TButton
        Left = 239
        Top = 441
        Width = 144
        Height = 25
        Caption = 'Dia normal com esse horario'
        TabOrder = 12
        OnClick = Button11Click
      end
      object Button1: TButton
        Left = 154
        Top = 497
        Width = 144
        Height = 25
        Caption = 'Dia normal '
        TabOrder = 13
        OnClick = Button1Click
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 609
    Width = 972
    Height = 23
    Panels = <
      item
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 50
      end>
  end
  object DataSource5: TDataSource
    Left = 488
    Top = 163
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Arquivos das Batidas        (*.txt)|*.txt'
    InitialDir = 'C:\Arquivos de programas\Fluxus\Organizadas'
    Left = 625
    Top = 245
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de batidas             *0*.txt|*0*.txt'
    InitialDir = 'C:\Arquivos de programas\Fluxus\Organizadas'
    Left = 592
    Top = 245
  end
  object dsListaHorarios: TDataSource
    DataSet = qrListaHorarios
    Left = 136
    Top = 389
  end
  object FindDialog1: TFindDialog
    Options = [frHideMatchCase, frHideWholeWord, frHideUpDown]
    OnFind = FindDialog1Find
    Left = 660
    Top = 281
  end
  object Conexao: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = conexaoWellExecuteComplete
    OnWillExecute = ConexaoWillExecute
    Left = 20
    Top = 505
  end
  object qrListaHorarios: TADOQuery
    Connection = Conexao
    Parameters = <>
    Left = 137
    Top = 313
  end
  object conexaoWell: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = conexaoWellExecuteComplete
    OnWillExecute = ConexaoWillExecute
    Left = 452
    Top = 521
  end
  object tbEmpWell: TADOTable
    Connection = conexaoWell
    Left = 580
    Top = 473
  end
  object MainMenu1: TMainMenu
    Left = 572
    Top = 337
    object Horarios1: TMenuItem
      Caption = ' Cadastro'
      object Cadastrodeempregados2: TMenuItem
        Caption = 'Empregados'
        OnClick = Cadastrodeempregados2Click
      end
      object Cadastrodehorarios1: TMenuItem
        Caption = 'Hor'#225'rios'
        OnClick = Cadastrodehorarios1Click
      end
    end
    object Funcoes1: TMenuItem
      Caption = 'Fun'#231#245'es'
      object CadastrodeEmpregados1: TMenuItem
        Caption = 'Importa'#231#227'o do cadastro de empregados'
        OnClick = CadastrodeEmpregados1Click
      end
    end
    object N1: TMenuItem
      Caption = '...'
      OnClick = N1Click
    end
  end
end
