object fmExportaEmp: TfmExportaEmp
  Left = 247
  Top = 136
  Width = 1118
  Height = 598
  Caption = 'fmExportaEm'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 26
    Top = 128
    Width = 120
    Height = 13
    Caption = 'Empregados exportados. '
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 24
    Width = 249
    Height = 99
    Caption = ' Importar empregados  '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 26
      Width = 100
      Height = 13
      Caption = 'Registrados partir de:'
    end
    object cbDemitidos: TfsCheckBox
      Left = 5
      Top = 80
      Width = 127
      Height = 17
      Caption = 'Incluir os demitidos'
      TabOrder = 0
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object dtAdmissao: TDateTimePicker
      Left = 115
      Top = 24
      Width = 119
      Height = 21
      Date = 40464.434384629630000000
      Time = 40464.434384629630000000
      TabOrder = 1
    end
    object cbDataAdmissao: TfsCheckBox
      Left = 5
      Top = 51
      Width = 188
      Height = 15
      Caption = 'Admitidos em qualquer data'
      Enabled = False
      TabOrder = 2
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object Memo1: TMemo
    Left = 24
    Top = 144
    Width = 473
    Height = 393
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 279
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
