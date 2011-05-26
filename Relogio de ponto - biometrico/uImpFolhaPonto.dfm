object fmImpFolhaPonto: TfmImpFolhaPonto
  Left = 194
  Top = 139
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Impress'#227'o de folhas de ponto em branco'
  ClientHeight = 145
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 5
    Top = 3
    Width = 620
    Height = 93
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 4
      Width = 318
      Height = 82
      Caption = 'Pesquisar por funcion'#225'rio '
      TabOrder = 0
      object edEmp: TEdit
        Left = 3
        Top = 19
        Width = 300
        Height = 19
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
        OnChange = edEmpChange
      end
      object cbEmp: TadLabelComboBox
        Left = 3
        Top = 42
        Width = 300
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkTile
        Style = csDropDownList
        Ctl3D = False
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 1
        OnChange = cbEmpChange
        LabelDefs.Width = 33
        LabelDefs.Height = 13
        LabelDefs.Caption = 'cbEmp'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
    end
    object GroupBox2: TGroupBox
      Left = 329
      Top = 4
      Width = 169
      Height = 82
      Caption = 'Pesquisar por loja'
      TabOrder = 1
      object cbLojas: TadLabelComboBox
        Left = 6
        Top = 31
        Width = 155
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkTile
        Style = csDropDownList
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnChange = cbLojasChange
        LabelDefs.Width = 37
        LabelDefs.Height = 13
        LabelDefs.Caption = 'cbLojas'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
    end
    object GroupBox3: TGroupBox
      Left = 505
      Top = 4
      Width = 112
      Height = 82
      Caption = ' Mes '
      TabOrder = 2
      object edMesAno: TMaskEdit
        Left = 7
        Top = 32
        Width = 65
        Height = 22
        Ctl3D = False
        EditMask = '!99/0000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = '01/2009'
      end
      object SpinButton1: TSpinButton
        Left = 75
        Top = 23
        Width = 27
        Height = 37
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
        TabOrder = 1
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
  object BitBtn1: TBitBtn
    Left = 632
    Top = 28
    Width = 86
    Height = 35
    Caption = 'OK'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object qrEmp: TADOQuery
    Parameters = <>
    Left = 43
    Top = 112
  end
  object tbDias: TADOTable
    Left = 8
    Top = 112
  end
  object tbBatidas: TADOTable
    Left = 152
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = tbBatidas
    Left = 192
    Top = 112
  end
end
