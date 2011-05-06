object Form8: TForm8
  Left = 261
  Top = 99
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = '10.12.01 Configurador do programa listas.'
  ClientHeight = 348
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 1
    Top = 5
    Width = 377
    Height = 309
    ActivePage = TabSheet1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Configura'#231#227'o do programa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object Bevel2: TBevel
        Left = 2
        Top = 15
        Width = 367
        Height = 264
      end
      object Edit1: TadLabelEdit
        Left = 6
        Top = 33
        Width = 139
        Height = 19
        LabelDefs.Width = 71
        LabelDefs.Height = 13
        LabelDefs.Caption = 'N'#250'mero da loja'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        MaxLength = 2
        TabOrder = 0
        OnChange = Edit1Change
      end
      object Edit2: TadLabelEdit
        Left = 6
        Top = 70
        Width = 139
        Height = 19
        LabelDefs.Width = 137
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Porta da impressora  matricial'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        OnChange = Edit1Change
      end
      object Edit3: TadLabelEdit
        Left = 6
        Top = 106
        Width = 139
        Height = 19
        LabelDefs.Width = 95
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Vers'#227'o do programa'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Enabled = False
        TabOrder = 2
        OnChange = Edit1Change
      end
      object edit4: TadLabelEdit
        Left = 6
        Top = 142
        Width = 358
        Height = 19
        LabelDefs.Width = 147
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Descricao da loja na impress'#227'o'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        OnClick = Edit1Change
      end
      object CB2: TadLabelComboBox
        Left = 6
        Top = 180
        Width = 200
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkSoft
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Sim'
        OnClick = Edit1Change
        Items.Strings = (
          'Sim'
          'N'#227'o')
        LabelDefs.Width = 129
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Mostra erros de execu'#231#227'o?'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
      object CB3: TadLabelComboBox
        Left = 6
        Top = 219
        Width = 200
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkSoft
        ItemHeight = 13
        TabOrder = 5
        Text = 'Matricial'
        OnClick = Edit1Change
        Items.Strings = (
          'Matricial'
          'DeskJet'
          'Usa PrFil32.exe')
        LabelDefs.Width = 122
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Tipo de impress'#227'o da lista'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
      object EDIT8: TadLabelEdit
        Left = 6
        Top = 256
        Width = 255
        Height = 19
        LabelDefs.Width = 108
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Arquivo do logo da loja'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        OnClick = Edit1Change
        OnDblClick = EDIT8DblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Atualiza'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object Bevel1: TBevel
        Left = 1
        Top = 15
        Width = 344
        Height = 135
      end
      object edit5: TadLabelEdit
        Left = 8
        Top = 37
        Width = 321
        Height = 19
        LabelDefs.Width = 92
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Local dos arquivos '
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        OnClick = Edit1Change
      end
      object Edit6: TadLabelEdit
        Left = 8
        Top = 76
        Width = 145
        Height = 19
        LabelDefs.Width = 36
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Usu'#225'rio'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        OnClick = Edit1Change
      end
      object edit7: TadLabelEdit
        Left = 8
        Top = 115
        Width = 145
        Height = 19
        LabelDefs.Width = 34
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Senha '
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        PasswordChar = '*'
        TabOrder = 2
        OnClick = Edit1Change
      end
      object CheckBox3: TCheckBox
        Left = 159
        Top = 117
        Width = 79
        Height = 17
        Caption = 'Sem Senha'
        TabOrder = 3
        OnClick = CheckBox3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Banco de Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      object Bevel3: TBevel
        Left = 1
        Top = 26
        Width = 368
        Height = 83
      end
      object Bevel4: TBevel
        Left = 1
        Top = 134
        Width = 368
        Height = 147
      end
      object Label1: TLabel
        Left = 8
        Top = 119
        Width = 97
        Height = 13
        Caption = 'Conex'#227'o ao Well'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 10
        Width = 107
        Height = 13
        Caption = 'Conex'#227'o ao banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edit12: TadLabelEdit
        Left = 139
        Top = 81
        Width = 120
        Height = 19
        LabelDefs.Width = 46
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Password'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        PasswordChar = '*'
        TabOrder = 3
        OnClick = Edit1Change
      end
      object edit9: TadLabelEdit
        Left = 8
        Top = 45
        Width = 123
        Height = 19
        LabelDefs.Width = 52
        LabelDefs.Height = 13
        LabelDefs.Caption = 'IP Servidor'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        OnClick = Edit1Change
      end
      object edit11: TadLabelEdit
        Left = 8
        Top = 81
        Width = 123
        Height = 19
        LabelDefs.Width = 39
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Usu'#225'rio '
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        OnClick = Edit1Change
      end
      object edit13: TadLabelEdit
        Left = 6
        Top = 152
        Width = 123
        Height = 19
        LabelDefs.Width = 52
        LabelDefs.Height = 13
        LabelDefs.Caption = 'IP Servidor'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        OnClick = Edit1Change
      end
      object edit15: TadLabelEdit
        Left = 6
        Top = 187
        Width = 123
        Height = 19
        LabelDefs.Width = 39
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Usu'#225'rio '
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        OnClick = Edit1Change
      end
      object edit16: TadLabelEdit
        Left = 139
        Top = 188
        Width = 120
        Height = 19
        LabelDefs.Width = 46
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Password'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        PasswordChar = '*'
        TabOrder = 7
        OnClick = Edit1Change
      end
      object Edit10: TadLabelEdit
        Left = 139
        Top = 45
        Width = 120
        Height = 19
        LabelDefs.Width = 123
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Nome do banco de dados'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        OnClick = Edit1Change
      end
      object Edit14: TadLabelEdit
        Left = 139
        Top = 151
        Width = 120
        Height = 19
        LabelDefs.Width = 123
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Nome do banco de dados'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        OnClick = Edit1Change
      end
      object CheckBox1: TCheckBox
        Left = 263
        Top = 82
        Width = 79
        Height = 17
        Caption = 'Sem Senha'
        TabOrder = 8
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 263
        Top = 189
        Width = 79
        Height = 17
        Caption = 'Sem Senha'
        TabOrder = 9
        OnClick = CheckBox2Click
      end
      object edit17: TadLabelEdit
        Left = 6
        Top = 223
        Width = 123
        Height = 19
        LabelDefs.Width = 109
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Loja base para o preco'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 10
        OnClick = Edit1Change
      end
      object edit18: TadLabelEdit
        Left = 139
        Top = 223
        Width = 123
        Height = 19
        LabelDefs.Width = 118
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Codigo preco a consultar'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 11
        OnClick = Edit1Change
      end
      object edit19: TadLabelEdit
        Left = 6
        Top = 258
        Width = 123
        Height = 19
        LabelDefs.Width = 76
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Codigo empresa'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 12
        OnClick = Edit1Change
      end
    end
  end
  object FlatButton1: TFlatButton
    Left = 216
    Top = 319
    Width = 73
    Height = 24
    Caption = '&OK'
    Enabled = False
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 296
    Top = 319
    Width = 73
    Height = 24
    Caption = '&Cancelar'
    TabOrder = 1
    OnClick = FlatButton2Click
  end
end
