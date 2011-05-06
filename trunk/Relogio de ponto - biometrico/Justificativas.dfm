object Justificativa: TJustificativa
  Left = 406
  Top = 252
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Justificativas'
  ClientHeight = 340
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 1
    Top = 0
    Width = 792
    Height = 334
    ActivePage = TabSheet1
    TabOrder = 2
    TabStop = False
    OnChange = edBuscaChange
    object TabSheet1: TTabSheet
      Caption = 'G&erar Justificativas'
      object Label3: TLabel
        Left = 106
        Top = 65
        Width = 15
        Height = 13
        Caption = 'at'#233
      end
      object Label4: TLabel
        Left = 615
        Top = 68
        Width = 15
        Height = 13
        Caption = 'at'#233
        Visible = False
      end
      object Label5: TLabel
        Left = 2
        Top = 86
        Width = 55
        Height = 13
        Caption = 'Justificativa'
      end
      object Label6: TLabel
        Left = 247
        Top = 49
        Width = 55
        Height = 13
        Caption = 'Ocorrencia:'
      end
      object Label7: TLabel
        Left = 2
        Top = 44
        Width = 38
        Height = 13
        Caption = 'Per'#237'odo'
      end
      object Label8: TLabel
        Left = 554
        Top = 49
        Width = 37
        Height = 13
        Caption = 'Horario:'
        Visible = False
      end
      object Label1: TLabel
        Left = 2
        Top = 3
        Width = 139
        Height = 13
        Caption = 'Empregado (busca por nome)'
      end
      object Label2: TLabel
        Left = 2
        Top = 251
        Width = 278
        Height = 13
        Caption = 'Para excluir uma linha, d'#234' um duplo clique sobre  a mesma.'
      end
      object Label10: TLabel
        Left = 249
        Top = 87
        Width = 58
        Height = 13
        Caption = 'Observa'#231#227'o'
      end
      object Label12: TLabel
        Left = 590
        Top = 2
        Width = 67
        Height = 13
        Caption = 'Todos da loja:'
      end
      object lbRefFolga: TLabel
        Left = 557
        Top = 86
        Width = 100
        Height = 13
        Caption = 'Folga refente ao dia: '
        Visible = False
      end
      object BitBtn2: TBitBtn
        Left = 694
        Top = 96
        Width = 88
        Height = 30
        Caption = '&Adicionar'
        TabOrder = 0
        OnClick = BitBtn2Click
        Glyph.Data = {
          26050000424D260500000000000036040000280000000F0000000F0000000100
          080000000000F00000000000000000000000000100000000000067010100C0C0
          C000A800000077F6D500FFFFFF000036FF002E00350000670000660069000000
          00000000000000000000000100000000000000000000000000000001E600001B
          00000000000000000000D25CBC00F9A87700E80012000012F800D25CF1000556
          7700C80002000012F8001400000017E600002477F50000000000140D48000000
          0000B80014000015260012F8A0005CBC0000E877D2000012FA00F7900500D5F0
          7700FF77F600FFFFFF00F517E60017787700B277F50077F51700000000000000
          0000A800000000487300000046005DB00000000018000000000012F9C4000000
          00009000000077F5160016F35800164E00007877F50000140700F5166A00F380
          7700600016000016F3001867AC00017800009800140000186700000000000178
          00007800140000140100D2589D00058E770046000100000000000000000058B1
          00009077D20000186700185DB000201300001C77F50077F52000186788000024
          0000100002000014650012FA3000000000009000000077F5160012FA3C000000
          00009000000077F5160018679000164E0000D877F50000140700F5166A0067AC
          770098001800001867000000000073A800000500480000000000000028000000
          000000000000000000000000B20068F00000000001000014000012F908000168
          0000F00014000012F900F7900500D5C87700FF77F600FFFFFF00F5166A00268E
          7700A977F50077F52600FC30E000269C77008077F5000016F30016F3600067AC
          0000000018007FFDE00012F9D80000B20000340000000012FA00F7900500D680
          7700FF77F600FFFFFF00F5269C00263177000777F50000000000000038006798
          0000000018000000000016F3400031280000000001000014000012F980000000
          0000800000000012FA00F7900500D5C87700FF77F600FFFFFF00F5166A00EF21
          77000077E6000014000000000000EF2D00001477E60077D27900000000000005
          00000000000000000000FDE0000000B27F000000B400000000000000000000FC
          0000980000000018670012FA5000FA5C0000B00012000012FF00E84809001098
          7700FF77E800FFFFFF00E6EF2D004DDC77009800430000186700D27914000000
          77002000000000000000791FC6009726D4000A01C100EB9A1600C4E6C5004300
          010024F70D00000000000001200000480000A800000077F6D500FFFFFF000000
          FF0069000000000066001526B80000000000D40014000012F80012FB0400FB34
          00000500120077F79000F6D5E000FFFF7700B2FFFF0077F51700E6A6D4000000
          77000800140000140000E6A6E500791477000077D20000000000000000000000
          0000000000000000000044C0C400270E00007C0015000016E200152712007402
          0000FF004800FFFFFF001526B800C12E00000E00440000152700010000000000
          0000000000000000010000000000000000010000000000000000000000000000
          0101010000000000000000000000000101010101000000000000000000000101
          0101010101000000000000000001010101010101010100000000000001010101
          0101010101010100000000010101010101010101010101010000000000000001
          0101010100000000000000000000000101010101000000000000000000000001
          0101010100000000000000000000000101010101000000000000000000000001
          0101010100000000000000000000000000000000000000000000010000000000
          00000000000000000100}
      end
      object edHoraFim: TMaskEdit
        Left = 638
        Top = 65
        Width = 55
        Height = 19
        Ctl3D = False
        EditMask = '!90:00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        Text = '  :  '
        Visible = False
      end
      object edHoraInicio: TMaskEdit
        Left = 554
        Top = 64
        Width = 55
        Height = 19
        Ctl3D = False
        EditMask = '!90:00;1;'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = '  :  '
        Visible = False
      end
      object cbOcorrencia: TComboBox
        Left = 247
        Top = 63
        Width = 290
        Height = 22
        BevelKind = bkSoft
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 1
        OnChange = cbOcorrenciaChange
        Items.Strings = (
          'E01 - Quantidade de Batidas incompativeis'
          'A01 - Falta'
          'A02 - Atraso na entrada'
          'A07 - Antecipacao de Saida')
      end
      object cbJust: TComboBox
        Left = 2
        Top = 103
        Width = 231
        Height = 20
        BevelKind = bkSoft
        Style = csOwnerDrawVariable
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 4
        OnClick = cbJustClick
        Items.Strings = (
          'E01-Quantidade de Batidas incompativeis'
          'A01-Falta'
          'A02-Atraso na entrada'
          'A07-Antecipacao de Saida')
      end
      object btGerajustificativa: TBitBtn
        Left = 658
        Top = 260
        Width = 121
        Height = 42
        Caption = '&Gerar Justificativa'
        Default = True
        ModalResult = 1
        TabOrder = 5
        OnClick = btGerajustificativaClick
        Glyph.Data = {
          4E010000424D4E01000000000000760000002800000012000000120000000100
          040000000000D800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333330000003333333333333333330000003333344333333333330000003333
          4224333333333300000033342222433333333300000033422222243333333300
          000034222A2222433333330000003222A3A222433333330000003A2A333A2224
          33333300000033A33333A222433333000000333333333A222433330000003333
          333333A222433300000033333333333A222433000000333333333333A2224300
          00003333333333333A224300000033333333333333A223000000333333333333
          333A33000000333333333333333333000000}
      end
      object btCancela: TBitBtn
        Left = 535
        Top = 260
        Width = 121
        Height = 42
        Cancel = True
        Caption = '&Cancelar'
        ModalResult = 2
        TabOrder = 6
        OnClick = btCancelaClick
        Glyph.Data = {
          4E010000424D4E01000000000000760000002800000012000000120000000100
          040000000000D800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333330000003333883333333333330000003339118333339833330000003339
          1118333911833300000033391111839111183300000033339111181111183300
          0000333339111111118333000000333333911111183333000000333333311111
          8333330000003333333911118333330000003333339111118333330000003333
          3911181118333300000033339111839111833300000033339118333911183300
          0000333339133333911133000000333333333333391933000000333333333333
          333333000000333333333333333333000000}
      end
      object dtp2: TDateTimePicker
        Left = 128
        Top = 62
        Width = 100
        Height = 21
        Date = 38715.715588287040000000
        Time = 38715.715588287040000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxDate = 39063.000000000000000000
        MinDate = 38687.000000000000000000
        ParentFont = False
        TabOrder = 7
      end
      object DTP1: TDateTimePicker
        Left = 2
        Top = 61
        Width = 100
        Height = 21
        CalColors.BackColor = clInfoBk
        CalColors.TitleTextColor = clInfoBk
        Date = 38715.715588287040000000
        Time = 38715.715588287040000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxDate = 39063.000000000000000000
        MinDate = 38687.000000000000000000
        ParentFont = False
        TabOrder = 8
        OnChange = DTP1Change
      end
      object sg1: TStringGrid
        Left = 2
        Top = 131
        Width = 782
        Height = 120
        ColCount = 14
        Ctl3D = False
        FixedCols = 0
        RowCount = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 9
        OnDblClick = sg1DblClick
        OnSelectCell = sg1SelectCell
      end
      object Edit2: TEdit
        Left = 245
        Top = 103
        Width = 304
        Height = 19
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 60
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 10
        OnChange = edBuscaChange
        OnEnter = edBuscaEnter
        OnExit = edBuscaChange
      end
      object cbLojas: TComboBox
        Left = 590
        Top = 19
        Width = 123
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        MaxLength = 99
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 11
        OnClick = cbLojasClick
      end
      object dtRefFolga: TDateTimePicker
        Left = 557
        Top = 102
        Width = 96
        Height = 21
        Date = 40190.715588287040000000
        Time = 40190.715588287040000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxDate = 55134.000000000000000000
        MinDate = 40190.000000000000000000
        ParentFont = False
        TabOrder = 12
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'C&onsultar Justificativas'
      ImageIndex = 1
      object Label9: TLabel
        Left = 3
        Top = 1
        Width = 59
        Height = 13
        Caption = 'Empregados'
      end
      object Label11: TLabel
        Left = 575
        Top = 5
        Width = 76
        Height = 13
        Caption = 'A partir do mes :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBGrid1: TDBGrid
        Left = 2
        Top = 47
        Width = 780
        Height = 210
        Ctl3D = False
        DataSource = dsJustificativas
        Enabled = False
        FixedColor = clMenu
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGrid1CellClick
      end
      object BitBtn7: TBitBtn
        Left = 658
        Top = 260
        Width = 121
        Height = 42
        Caption = '&Consultar'
        TabOrder = 1
        OnClick = BitBtn7Click
        Kind = bkOK
      end
      object BitBtn9: TBitBtn
        Left = 533
        Top = 260
        Width = 121
        Height = 42
        Cancel = True
        Caption = '&Excluir'
        Enabled = False
        ModalResult = 2
        TabOrder = 2
        OnClick = BitBtn9Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
          03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
          33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
          0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
          3333333337FFF7F3333333333000003333333333377777333333}
        NumGlyphs = 2
      end
      object edMesAno: TMaskEdit
        Left = 577
        Top = 21
        Width = 65
        Height = 19
        Ctl3D = False
        EditMask = '!99/0000;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        Text = '  /    '
      end
      object SpinButton1: TSpinButton
        Left = 657
        Top = 14
        Width = 21
        Height = 28
        DownGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000008080000080
          8000008080000080800000808000000000000000000000000000000000000000
          0000008080000080800000808000000000000000000000000000000000000000
          0000000000000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        TabOrder = 4
        UpGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000000000000000000000000000000000000000000000000000000000000080
          8000008080000080800000000000000000000000000000000000000000000080
          8000008080000080800000808000008080000000000000000000000000000080
          8000008080000080800000808000008080000080800000808000000000000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        OnDownClick = SpinButton1DownClick
        OnUpClick = SpinButton1UpClick
      end
    end
  end
  object cbEmp: TComboBox
    Left = 223
    Top = 43
    Width = 345
    Height = 21
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    DropDownCount = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    MaxLength = 99
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 1
  end
  object edBusca: TEdit
    Left = 6
    Top = 43
    Width = 215
    Height = 22
    AutoSize = False
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnChange = edBuscaChange
    OnEnter = edBuscaEnter
    OnExit = edBuscaChange
  end
  object qrJustificativas: TADOQuery
    Parameters = <>
    Left = 732
    Top = 69
  end
  object dsJustificativas: TDataSource
    DataSet = qrJustificativas
    Left = 756
    Top = 69
  end
end
