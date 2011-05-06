object frmCadAluno: TfrmCadAluno
  Left = 254
  Top = 50
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Alunos'
  ClientHeight = 533
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 1
    Top = 102
    Width = 857
    Height = 429
    Caption = 'Dados do Aluno:'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 5
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 31
      Height = 13
      Caption = 'Nome:'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 8
      Top = 112
      Width = 49
      Height = 13
      Caption = 'Endere'#231'o:'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 8
      Top = 160
      Width = 30
      Height = 13
      Caption = 'Bairro:'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 8
      Top = 256
      Width = 36
      Height = 13
      Caption = 'Estado:'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 56
      Top = 256
      Width = 33
      Height = 13
      Caption = 'C.E.P.:'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 8
      Top = 208
      Width = 36
      Height = 13
      Caption = 'Cidade:'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 203
      Top = 255
      Width = 25
      Height = 14
      Caption = 'R.G.:'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 8
      Top = 303
      Width = 45
      Height = 13
      Caption = 'Telefone:'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 200
      Top = 303
      Width = 76
      Height = 13
      Caption = 'Dt. Nascimento:'
      FocusControl = DBEdit10
    end
    object Label11: TLabel
      Left = 364
      Top = 303
      Width = 62
      Height = 13
      Caption = 'Dt. Cadastro:'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 8
      Top = 345
      Width = 25
      Height = 13
      Caption = 'Obs.:'
      FocusControl = DBMemo1
    end
    object Label13: TLabel
      Left = 580
      Top = 56
      Width = 64
      Height = 13
      Caption = 'Modalidade1:'
      FocusControl = DBEdit12
    end
    object Label14: TLabel
      Left = 580
      Top = 104
      Width = 64
      Height = 13
      Caption = 'Modalidade2:'
      FocusControl = DBEdit13
    end
    object Label15: TLabel
      Left = 580
      Top = 147
      Width = 64
      Height = 13
      Caption = 'Modalidade3:'
      FocusControl = DBEdit14
    end
    object Label16: TLabel
      Left = 580
      Top = 192
      Width = 64
      Height = 13
      Caption = 'Modalidade4:'
      FocusControl = DBEdit15
    end
    object Label17: TLabel
      Left = 580
      Top = 240
      Width = 64
      Height = 13
      Caption = 'Modalidade5:'
      FocusControl = DBEdit16
    end
    object Label18: TLabel
      Left = 580
      Top = 280
      Width = 64
      Height = 13
      Caption = 'Modalidade6:'
      FocusControl = DBEdit17
    end
    object Label19: TLabel
      Left = 364
      Top = 254
      Width = 32
      Height = 14
      Caption = 'C.P.F.:'
      FocusControl = DBEdit18
    end
    object DBEdit1: TDBEdit
      Left = 8
      Top = 32
      Width = 41
      Height = 21
      DataField = 'COD_ALU'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 8
      Top = 80
      Width = 481
      Height = 21
      CharCase = ecUpperCase
      DataField = 'NOME'
      DataSource = dsAlu
      MaxLength = 70
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 8
      Top = 128
      Width = 481
      Height = 21
      CharCase = ecUpperCase
      DataField = 'ENDERECO'
      DataSource = dsAlu
      MaxLength = 70
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 8
      Top = 176
      Width = 241
      Height = 21
      CharCase = ecUpperCase
      DataField = 'BAIRRO'
      DataSource = dsAlu
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 8
      Top = 272
      Width = 33
      Height = 21
      CharCase = ecUpperCase
      DataField = 'ESTADO'
      DataSource = dsAlu
      TabOrder = 5
    end
    object DBEdit6: TDBEdit
      Left = 56
      Top = 272
      Width = 145
      Height = 21
      DataField = 'CEP'
      DataSource = dsAlu
      TabOrder = 6
    end
    object DBEdit7: TDBEdit
      Left = 8
      Top = 224
      Width = 201
      Height = 21
      CharCase = ecUpperCase
      DataField = 'CIDADE'
      DataSource = dsAlu
      TabOrder = 4
    end
    object DBEdit8: TDBEdit
      Left = 203
      Top = 271
      Width = 153
      Height = 22
      DataField = 'RG'
      DataSource = dsAlu
      TabOrder = 9
    end
    object DBEdit9: TDBEdit
      Left = 8
      Top = 319
      Width = 137
      Height = 21
      DataField = 'TELEFONE'
      DataSource = dsAlu
      TabOrder = 7
    end
    object DBEdit10: TDBEdit
      Left = 200
      Top = 319
      Width = 121
      Height = 21
      DataField = 'DATA_NASC'
      DataSource = dsAlu
      TabOrder = 8
    end
    object DBEdit11: TDBEdit
      Left = 364
      Top = 319
      Width = 121
      Height = 21
      DataField = 'DATA_CAD'
      DataSource = dsAlu
      TabOrder = 11
    end
    object DBMemo1: TDBMemo
      Left = 7
      Top = 360
      Width = 798
      Height = 59
      DataField = 'OBS'
      DataSource = dsAlu
      TabOrder = 12
    end
    object DBEdit12: TDBEdit
      Left = 580
      Top = 72
      Width = 28
      Height = 21
      DataField = 'COD_MOD1'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 13
    end
    object DBEdit13: TDBEdit
      Left = 580
      Top = 120
      Width = 28
      Height = 21
      DataField = 'COD_MOD2'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 15
    end
    object DBEdit14: TDBEdit
      Left = 580
      Top = 163
      Width = 28
      Height = 21
      DataField = 'COD_MOD3'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 17
    end
    object DBEdit15: TDBEdit
      Left = 580
      Top = 208
      Width = 28
      Height = 21
      DataField = 'COD_MOD4'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 19
    end
    object DBEdit16: TDBEdit
      Left = 580
      Top = 256
      Width = 28
      Height = 21
      DataField = 'COD_MOD5'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 21
    end
    object DBEdit17: TDBEdit
      Left = 580
      Top = 296
      Width = 28
      Height = 21
      DataField = 'COD_MOD6'
      DataSource = dsAlu
      Enabled = False
      TabOrder = 23
    end
    object dblcMod1: TDBLookupComboBox
      Left = 610
      Top = 72
      Width = 196
      Height = 21
      DataField = 'COD_MOD1'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 14
      OnClick = dblcMod1Click
      OnExit = dblcMod1Exit
      OnKeyDown = dblcMod1KeyDown
    end
    object dblcMod2: TDBLookupComboBox
      Left = 610
      Top = 120
      Width = 196
      Height = 21
      DataField = 'COD_MOD2'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 16
      OnClick = dblcMod2Click
      OnExit = dblcMod2Exit
      OnKeyDown = dblcMod2KeyDown
    end
    object dblcMod3: TDBLookupComboBox
      Left = 610
      Top = 163
      Width = 196
      Height = 21
      DataField = 'COD_MOD3'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 18
      OnClick = dblcMod3Click
      OnExit = dblcMod3Exit
      OnKeyDown = dblcMod3KeyDown
    end
    object dblcMod4: TDBLookupComboBox
      Left = 610
      Top = 208
      Width = 196
      Height = 21
      DataField = 'COD_MOD4'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 20
      OnClick = dblcMod4Click
      OnExit = dblcMod4Exit
      OnKeyDown = dblcMod4KeyDown
    end
    object dblcMod5: TDBLookupComboBox
      Left = 610
      Top = 256
      Width = 196
      Height = 21
      DataField = 'COD_MOD5'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 22
      OnClick = dblcMod5Click
      OnExit = dblcMod5Exit
      OnKeyDown = dblcMod5KeyDown
    end
    object dblcMod6: TDBLookupComboBox
      Left = 610
      Top = 296
      Width = 196
      Height = 21
      DataField = 'COD_MOD6'
      DataSource = dsAlu
      Enabled = False
      KeyField = 'COD_MOD'
      ListField = 'MODALIDADE'
      ListSource = dsMod
      TabOrder = 24
      OnClick = dblcMod6Click
      OnExit = dblcMod6Exit
      OnKeyDown = dblcMod6KeyDown
    end
    object DBEdit18: TDBEdit
      Left = 364
      Top = 270
      Width = 153
      Height = 22
      DataField = 'CPF'
      DataSource = dsAlu
      MaxLength = 12
      TabOrder = 10
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 51
    Width = 857
    Height = 49
    Caption = 'Localiza Aluno por Nome:'
    TabOrder = 4
    object dblcNomeAlu: TDBLookupComboBox
      Left = 262
      Top = 16
      Width = 333
      Height = 21
      KeyField = 'NOME'
      ListField = 'NOME'
      ListSource = dsNomeAlu
      TabOrder = 0
      OnClick = dblcNomeAluClick
      OnKeyDown = dblcNomeAluKeyDown
    end
  end
  object btnNovoAlu: TBitBtn
    Left = 757
    Top = 3
    Width = 99
    Height = 25
    Hint = 'Inclui novo cliente'
    Caption = 'Novo Aluno'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnNovoAluClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
      333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
      0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
      0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
      33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
      B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
      3BB33773333773333773B333333B3333333B7333333733333337}
    NumGlyphs = 2
  end
  object btnAltera: TBitBtn
    Left = 757
    Top = 30
    Width = 99
    Height = 25
    Hint = 'Altera dados do cliente'
    Caption = '&Alterar Aluno'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnAlteraClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 354
    Top = 9
    Width = 161
    Height = 32
    BorderStyle = bsSingle
    TabOrder = 1
    Visible = False
    object btnGrava: TBitBtn
      Left = 3
      Top = 2
      Width = 75
      Height = 25
      Hint = 'Grava os novos dados'
      Caption = '&Gravar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnGravaClick
      Glyph.Data = {
        42030000424D42030000000000003600000028000000110000000F0000000100
        1800000000000C030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F0000FFFFFFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBF7F00007F00007F0000FFFFFFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00007F00007F0000
        7F0000FFFFFFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBF00000000000000
        00000000000000007F00007F00007F0000FFFFFF7F00007F0000FFFFFFBFBFBF
        BFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFFFF7F00007F00007F
        0000FFFFFF000000BFBFBF7F00007F0000FFFFFFBFBFBFBFBFBFBFBFBF00BFBF
        BF000000FFFFFF7F7F7F7F7F7F7F7F7F7F0000FFFFFFFFFFFF000000BFBFBFBF
        BFBF7F0000FFFFFFBFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBFBFBFBF7F0000FFFFFFBF
        BFBFBFBFBF00BFBFBF000000FFFFFF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFF
        FF000000BFBFBFBFBFBFBFBFBFBFBFBF7F0000FFFFFFBFBFBF00BFBFBF000000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF7F0000FFFFFF00BFBFBF000000FFFFFF7F7F7F7F7F7FBFBFBF
        BFBFBFBFBFBFFFFFFF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00
        0000BFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFF7F
        7F7F7F7F7FBFBFBF000000BFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBF
        BF000000000000000000000000000000000000BFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBF00}
    end
    object btnCancela: TBitBtn
      Left = 81
      Top = 2
      Width = 75
      Height = 25
      Hint = 'Cancela os novos dados'
      Caption = '&Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCancelaClick
      Glyph.Data = {
        36030000424D360300000000000036000000280000000F000000100000000100
        18000000000000030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF
        0000FF0000FF0000FFBFBFBF7F7F7F0000007F7F7FBFBFBF0000FF0000FF0000
        FFBFBFBFBFBFBF000000BFBFBF0000FF0000FF0000FFBFBFBFBFBFBF00000000
        0000000000BFBFBFBFBFBF0000FF0000FF0000FFBFBFBF000000BFBFBF0000FF
        0000FFBFBFBFBFBFBFBFBFBF7F7F7F0000007F7F7FBFBFBFBFBFBFBFBFBF0000
        FF0000FFBFBFBF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000FF0000FF0000000000FF0000FF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF0000FF0000FF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F00
        00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000000000FF0000FF
        BFBFBFBFBFBFBFBFBFBFBFBF00007F00000000007FBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBF00000000
        0000000000BFBFBF0000FF0000FF0000FF0000FF0000FF000000BFBFBF0000FF
        0000FFBFBFBFBFBFBFBFBFBF000000000000000000BFBFBFBFBFBF0000FF0000
        FF0000FF0000FF000000BFBFBF0000FF0000FF0000FFBFBFBFBFBFBF00000000
        0000000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF000000BFBFBFBFBFBF
        0000FF0000FF0000FFBFBFBF7F7F7F0000007F7F7FBFBFBF0000FF0000FF0000
        FF0000FF0000FF000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FFBFBFBFBFBFBF0000FF000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000}
    end
  end
  object Panel2: TPanel
    Left = 1
    Top = 10
    Width = 153
    Height = 31
    BorderStyle = bsSingle
    TabOrder = 0
    object btnPrimeiro: TBitBtn
      Left = 2
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Primeiro registro'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnPrimeiroClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        333333777777777F33333330B00000003333337F7777777F3333333000000000
        333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
        333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
        03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
        03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
        3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
        333333333377F7F33333333333330F03333333333337F7F33333333333330B03
        3333333333373733333333333333303333333333333373333333}
      NumGlyphs = 2
    end
    object btnAnterior: TBitBtn
      Left = 26
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Registro anterior'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAnteriorClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333333333333333333333333333333333FF333333333333
        3000333333FFFFF3F77733333000003000B033333777773777F733330BFBFB00
        E00033337FFF3377F7773333000FBFB0E000333377733337F7773330FBFBFBF0
        E00033F7FFFF3337F7773000000FBFB0E000377777733337F7770BFBFBFBFBF0
        E00073FFFFFFFF37F777300000000FB0E000377777777337F7773333330BFB00
        000033333373FF77777733333330003333333333333777333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btnProximo: TBitBtn
      Left = 50
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Pr'#243'ximo registro'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnProximoClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btnUltimo: TBitBtn
      Left = 74
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Ultimo registro'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnUltimoClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        33333333373F33333333333330B03333333333337F7F33333333333330F03333
        333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
        333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
        333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
        3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
        33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
        33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
        03333337777777F7F33333330000000003333337777777773333}
      NumGlyphs = 2
    end
    object btnLocCod: TBitBtn
      Left = 98
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Localiza Aluno por C'#243'digo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnLocCodClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888800000888880000080F000888880F00080F000888880F
        0008000000080000000800F000000F00000800F000800F00000800F000800F00
        00088000000000000088880F00080F0008888800000800000888888000888000
        88888880F08880F0888888800088800088888888888888888888}
    end
    object btnExclui: TBitBtn
      Left = 122
      Top = 1
      Width = 25
      Height = 25
      Hint = 'Exclui registro atual'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnExcluiClick
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC000000CE0E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777000000077788777777777777000000077D55877777D87777000000077D5
        558777D558777000000077D555587D55558770000000777D5555855555877000
        00007777D555555558777000000077777D555555877770000000777777555558
        777770000000777777D5555877777000000077777D5555587777700000007777
        D5558555877770000000777D55587D55587770000000777D558777D555877000
        00007777D577777D555770000000777777777777D5D770000000777777777777
        777770000000}
    end
  end
  object qryAlu: TQuery
    CachedUpdates = True
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select * '
      'From Aluno'
      'Order by COD_ALU')
    UpdateObject = upsAlu
    Left = 456
    Top = 144
    object qryAluCOD_ALU: TIntegerField
      FieldName = 'COD_ALU'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.COD_ALU'
    end
    object qryAluNOME: TStringField
      FieldName = 'NOME'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.NOME'
      FixedChar = True
      Size = 40
    end
    object qryAluENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.ENDERECO'
      FixedChar = True
      Size = 40
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
      EditMask = '(9XX99)9999-9999;0;_'
      FixedChar = True
      Size = 15
    end
    object qryAluCEP: TStringField
      FieldName = 'CEP'
      Origin = 'BANCO DE DADOS ACADEMIA.Aluno.CEP'
      EditMask = '99999-999;0;_'
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
  end
  object dsAlu: TDataSource
    AutoEdit = False
    DataSet = qryAlu
    Left = 488
    Top = 144
  end
  object upsAlu: TUpdateSQL
    ModifySQL.Strings = (
      'update Aluno'
      'set'
      '  COD_ALU = :COD_ALU,'
      '  NOME = :NOME,'
      '  ENDERECO = :ENDERECO,'
      '  BAIRRO = :BAIRRO,'
      '  CIDADE = :CIDADE,'
      '  ESTADO = :ESTADO,'
      '  TELEFONE = :TELEFONE,'
      '  CEP = :CEP,'
      '  RG = :RG,'
      '  CPF = :CPF,'
      '  DATA_NASC = :DATA_NASC,'
      '  DATA_CAD = :DATA_CAD,'
      '  OBS = :OBS,'
      '  COD_MOD1 = :COD_MOD1,'
      '  COD_MOD2 = :COD_MOD2,'
      '  COD_MOD3 = :COD_MOD3,'
      '  COD_MOD4 = :COD_MOD4,'
      '  COD_MOD5 = :COD_MOD5,'
      '  COD_MOD6 = :COD_MOD6'
      'where'
      '  COD_ALU = :OLD_COD_ALU')
    InsertSQL.Strings = (
      'insert into Aluno'
      
        '  (COD_ALU, NOME, ENDERECO, BAIRRO, CIDADE, ESTADO, TELEFONE, CE' +
        'P, '
      'RG, '
      '   CPF, DATA_NASC, DATA_CAD, OBS, COD_MOD1, COD_MOD2, COD_MOD3, '
      'COD_MOD4, '
      '   COD_MOD5, COD_MOD6)'
      'values'
      
        '  (:COD_ALU, :NOME, :ENDERECO, :BAIRRO, :CIDADE, :ESTADO, :TELEF' +
        'ONE, '
      ':CEP, '
      
        '   :RG, :CPF, :DATA_NASC, :DATA_CAD, :OBS, :COD_MOD1, :COD_MOD2,' +
        ' '
      ':COD_MOD3, '
      '   :COD_MOD4, :COD_MOD5, :COD_MOD6)')
    DeleteSQL.Strings = (
      'delete from Aluno'
      'where'
      '  COD_ALU = :OLD_COD_ALU')
    Left = 525
    Top = 144
  end
  object qryMod: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select * From Modalidade Order By Modalidade')
    Left = 631
    Top = 344
  end
  object dsMod: TDataSource
    AutoEdit = False
    DataSet = qryMod
    Left = 679
    Top = 344
  end
  object dsNomeAlu: TDataSource
    AutoEdit = False
    DataSet = qryNomeAlu
    Left = 304
    Top = 120
  end
  object qryNomeAlu: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select  NOME from Aluno Order By NOME')
    Left = 240
    Top = 120
  end
end
