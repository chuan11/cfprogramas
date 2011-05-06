object fmAjustaSPED: TfmAjustaSPED
  Left = 402
  Top = 343
  Width = 843
  Height = 426
  Caption = 'fmAjustaSPED'
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object edArq: TadLabelEdit
    Left = 7
    Top = 21
    Width = 441
    Height = 22
    LabelDefs.Width = 74
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Arquivo  SPED:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Duplo clique para selecionar o arquivo'
    OnDblClick = edArqDblClick
  end
  object fsBitBtn1: TfsBitBtn
    Left = 466
    Top = 12
    Width = 75
    Height = 40
    Caption = 'Processar'
    TabOrder = 1
    OnClick = fsBitBtn1Click
  end
  object memo: TfsMemo
    Left = 7
    Top = 123
    Width = 801
    Height = 214
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btOcoProduto: TButton
    Left = 706
    Top = 4
    Width = 114
    Height = 27
    Caption = 'Ocorr'#234'ncias produto'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btOcoProdutoClick
  end
  object edRef: TEdit
    Left = 653
    Top = 7
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 655
    Top = 40
    Width = 99
    Height = 22
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btOcoProdutoClick
  end
end
