object Form1: TForm1
  Left = 198
  Top = 132
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 
    'Relógio de Ponto.                                               ' +
    '         Versão  2.0.3'
  ClientHeight = 331
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clMaroon
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF009999
    9999999999999999999999999999999999999999999999999999999999999999
    99999999999999999999999999999999BBBBBBBBBBBBBBBBBBBBBBBB9999999B
    BBBBBBBBBBBBBBBBBBBBBBBBB99999BBBBBBBBBBBBBBBBBBBBBBBBBBBB9999BB
    BBBBBBBBBBBBBBBBBBBBBBBBBB9999BBBBBBBBBBBBBBBBBBBBBBBBBBBB9999BB
    BBBBBBBBBBBBBBBBBBBBBBBBBB9999BBBBBBBBBBBBBBBBBBBBBBBBBBBB9999BB
    BBBB99999BBBBB999BBBBBBBBB9999BBBB999999999BBB999BBBBBBBBB9999BB
    B9999999999BBB999BBBBBBBBB9999BBB999BBBB9999BB999BBBBBBBBB9999BB
    999BBBBBB99BBB999BBBBBBBBB9999BB999BBBBBBBBBBB999BBBBBBBBB9999BB
    999BBBBBBBBBBB999999999BBB9999BB999BBBBBBBBBBB999999999BBB9999BB
    999BBBBBBBBBBB999999999BBB9999BB999BBBBBBBBBBB999BBBBBBBBB9999BB
    B999BBBBBBBBBB999BBBBBBBBB9999BBB99999999999999999999999BB9999BB
    BB9999999999999999999999BB9999BBBBBB99999999999999999999BB9999BB
    BBBBBBBBBBBBBBBBBBBBBBBBBB9999BBBBBBBBBBBBBBBBBBBBBBBBBBBB9999BB
    BBBBBBBBBBBBBBBBBBBBBBBBBB9999BBBBBBBBBBBBBBBBBBBBBBBBBBBB99999B
    BBBBBBBBBBBBBBBBBBBBBBBBB9999999BBBBBBBBBBBBBBBBBBBBBBBB99999999
    9999999999999999999999999999999999999999999999999999999999990000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 22
    Top = 140
    Width = 48
    Height = 13
    Caption = 'Batida 01:'
  end
  object Label8: TLabel
    Left = 85
    Top = 134
    Width = 66
    Height = 24
    Caption = 'Label11'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 30
    Top = 148
    Width = 48
    Height = 13
    Caption = 'Batida 01:'
  end
  object Label10: TLabel
    Left = 93
    Top = 142
    Width = 66
    Height = 24
    Caption = 'Label11'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 22
    Top = 172
    Width = 48
    Height = 13
    Caption = 'Batida 01:'
  end
  object Label13: TLabel
    Left = 85
    Top = 166
    Width = 66
    Height = 24
    Caption = 'Label11'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 465
    Height = 313
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Captura dos Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnShow = MaskEdit1Click
      object Label1: TLabel
        Left = 30
        Top = 226
        Width = 49
        Height = 22
        Caption = 'Data:'
        Color = clMenu
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 232
        Top = 223
        Width = 64
        Height = 29
        Caption = 'Hora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 89
        Top = 223
        Width = 80
        Height = 29
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 305
        Top = 223
        Width = 80
        Height = 29
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 30
        Top = 26
        Width = 80
        Height = 24
        Caption = 'Matricula:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 25
        Top = 58
        Width = 252
        Height = 111
      end
      object Label35: TLabel
        Left = 312
        Top = 136
        Width = 3
        Height = 13
      end
      object MaskEdit1: TMaskEdit
        Left = 36
        Top = 80
        Width = 226
        Height = 63
        EditMask = '99999999;0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -48
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnClick = MaskEdit1Click
      end
      object BitBtn3: TBitBtn
        Left = 307
        Top = 8
        Width = 142
        Height = 77
        Caption = '&Sair'
        TabOrder = 1
        OnClick = BitBtn3Click
        Kind = bkCancel
      end
      object Panel1: TPanel
        Left = 16
        Top = 256
        Width = 425
        Height = 246
        BorderWidth = 50
        BorderStyle = bsSingle
        Color = clMenu
        TabOrder = 2
        object Label25: TLabel
          Left = 106
          Top = 3
          Width = 211
          Height = 29
          Alignment = taCenter
          Caption = 'Ponto Registrado!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Left = 11
          Top = 59
          Width = 80
          Height = 24
          Caption = 'Matricula:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 11
          Top = 104
          Width = 109
          Height = 24
          Caption = 'Data e Hora :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 150
          Top = 60
          Width = 106
          Height = 24
          Alignment = taCenter
          Caption = 'Confirmação'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 150
          Top = 103
          Width = 106
          Height = 24
          Alignment = taCenter
          Caption = 'Confirmação'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object BitBtn4: TBitBtn
          Left = 110
          Top = 170
          Width = 204
          Height = 55
          Caption = '&OK'
          TabOrder = 0
          OnClick = BitBtn4Click
          Kind = bkOK
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta Batidas'
      ImageIndex = 1
      object Label6: TLabel
        Left = 22
        Top = 172
        Width = 48
        Height = 13
        Caption = 'Batida 01:'
      end
      object Label11: TLabel
        Left = 82
        Top = 166
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 21
        Top = 200
        Width = 48
        Height = 13
        Caption = 'Batida 02:'
      end
      object Label15: TLabel
        Left = 82
        Top = 195
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 20
        Top = 229
        Width = 48
        Height = 13
        Caption = 'Batida 03:'
      end
      object Label17: TLabel
        Left = 247
        Top = 168
        Width = 48
        Height = 13
        Caption = 'Batida 04:'
      end
      object Label18: TLabel
        Left = 248
        Top = 200
        Width = 48
        Height = 13
        Caption = 'Batida 05:'
      end
      object Label19: TLabel
        Left = 248
        Top = 232
        Width = 48
        Height = 13
        Caption = 'Batida 06:'
      end
      object Label20: TLabel
        Left = 82
        Top = 225
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 320
        Top = 166
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 320
        Top = 227
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 320
        Top = 195
        Width = 66
        Height = 24
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 77
        Top = 125
        Width = 276
        Height = 24
        Caption = 'Não existem batidas no período !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 8
        Top = 157
        Width = 414
        Height = 101
      end
      object Label30: TLabel
        Left = 30
        Top = 26
        Width = 80
        Height = 24
        Caption = 'Matricula:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label31: TLabel
        Left = 179
        Top = 26
        Width = 42
        Height = 24
        Caption = 'Data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MaskEdit2: TMaskEdit
        Left = 169
        Top = 56
        Width = 137
        Height = 35
        EditMask = '99/99/9999;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '01/01/2003'
      end
      object MaskEdit3: TMaskEdit
        Left = 22
        Top = 56
        Width = 121
        Height = 35
        EditMask = '99999999;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        Text = '        '
        OnClick = MaskEdit3Click
      end
      object BitBtn1: TBitBtn
        Left = 323
        Top = 56
        Width = 129
        Height = 36
        Caption = '&Ok !'
        TabOrder = 2
        OnClick = BitBtn1Click
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 323
        Top = 17
        Width = 129
        Height = 36
        Caption = '&Nova Consulta'
        TabOrder = 3
        OnClick = BitBtn2Click
        Kind = bkRetry
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Parametros'
      ImageIndex = 2
      object Label32: TLabel
        Left = 15
        Top = 27
        Width = 119
        Height = 16
        Caption = 'Aquivo das batidas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label33: TLabel
        Left = 15
        Top = 55
        Width = 88
        Height = 16
        Caption = 'Hora da Cópia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label34: TLabel
        Left = 15
        Top = 85
        Width = 95
        Height = 16
        Caption = 'Numero da loja:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 141
        Top = 22
        Width = 304
        Height = 22
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'C:\_Ponto\batidas.txt'
      end
      object MaskEdit4: TMaskEdit
        Left = 141
        Top = 53
        Width = 56
        Height = 22
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        EditMask = '!90:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 1
        Text = '18:00'
      end
      object MaskEdit5: TMaskEdit
        Left = 141
        Top = 82
        Width = 26
        Height = 22
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        EditMask = '99;0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 2
        Text = '99'
      end
      object BitBtn5: TBitBtn
        Left = 312
        Top = 53
        Width = 136
        Height = 37
        Caption = '&Execute Agora'
        TabOrder = 3
        OnClick = BitBtn5Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
          00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
          00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
          00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
          0003737FFFFFFFFF7F7330099999999900333777777777777733}
        NumGlyphs = 2
      end
      object BitBtn6: TBitBtn
        Left = 310
        Top = 93
        Width = 136
        Height = 37
        Caption = '&Alterar'
        TabOrder = 4
        OnClick = BitBtn6Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5000555555555555577755555555555550B0555555555555F7F7555555555550
          00B05555555555577757555555555550B3B05555555555F7F557555555555000
          3B0555555555577755755555555500B3B0555555555577555755555555550B3B
          055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
          555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
          55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
          555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
          55555575FFFF7755555555570000755555555557777775555555}
        NumGlyphs = 2
      end
      object CheckBox1: TCheckBox
        Left = 14
        Top = 120
        Width = 155
        Height = 17
        Alignment = taLeftJustify
        Caption = 'RedeLocal  M.image'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 418
    Top = 65534
  end
  object Timer2: TTimer
    Interval = 300
    OnTimer = Timer2Timer
    Left = 448
    Top = 65534
  end
  object NMFTP1: TNMFTP
    Port = 21
    ReportLevel = 0
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 388
  end
end
