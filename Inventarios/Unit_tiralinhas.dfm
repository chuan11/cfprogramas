object Form1: TForm1
  Left = 331
  Top = 82
  Width = 717
  Height = 433
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 3
    Top = 10
    Width = 37
    Height = 13
    Caption = 'Entrada'
  end
  object Label2: TLabel
    Left = 4
    Top = 27
    Width = 27
    Height = 13
    Caption = 'Saida'
  end
  object Label3: TLabel
    Left = 271
    Top = 125
    Width = 294
    Height = 13
    Caption = 'Gera Arquivo de impressao  a partir de um prn salvo pelo excel'
  end
  object Label4: TLabel
    Left = 271
    Top = 140
    Width = 273
    Height = 13
    Caption = '    Campos:Descricao(40);quantidade(12);und(12);total(12)'
  end
  object Bevel1: TBevel
    Left = 2
    Top = 120
    Width = 254
    Height = 89
  end
  object Label5: TLabel
    Left = 9
    Top = 140
    Width = 3
    Height = 13
  end
  object Bevel2: TBevel
    Left = 264
    Top = 120
    Width = 321
    Height = 89
  end
  object Label6: TLabel
    Left = 41
    Top = 125
    Width = 152
    Height = 13
    Caption = 'Capturar os itens de um RPGER'
  end
  object Label7: TLabel
    Left = 41
    Top = 165
    Width = 144
    Height = 13
    Caption = 'Capturar os itens de um RLVFI'
  end
  object Edit1: TEdit
    Left = 44
    Top = 5
    Width = 345
    Height = 19
    Cursor = crHandPoint
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = 'Edit1'
    OnClick = Edit1Click
  end
  object Edit2: TEdit
    Left = 44
    Top = 26
    Width = 345
    Height = 19
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = 'C:\Documents and Settings\usuario\Desktop\Estoque.prn'
  end
  object Button2: TButton
    Left = 298
    Top = 166
    Width = 124
    Height = 25
    Caption = 'ok'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 10
    Top = 139
    Width = 235
    Height = 25
    Caption = 'ok'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 6
    Top = 48
    Width = 382
    Height = 69
    Color = clInfoBk
    Ctl3D = False
    Lines.Strings = (
      '01.740.627/000'
      'PFM COMERCIAL LTDA'
      '2003')
    ParentCtl3D = False
    TabOrder = 4
  end
  object Memo2: TMemo
    Left = 9
    Top = 214
    Width = 579
    Height = 177
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo2')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 5
    Visible = False
  end
  object Button1: TButton
    Left = 504
    Top = 88
    Width = 75
    Height = 25
    Caption = 'CARREGA'
    TabOrder = 6
    OnClick = Button1Click
  end
  object spinedit: TadLabelSpinEdit
    Left = 512
    Top = 167
    Width = 51
    Height = 22
    Cursor = crDefault
    HelpType = htKeyword
    LabelDefs.Width = 70
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Itens por folha:'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clBlack
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = []
    LabelDefs.ParentFont = False
    About = 'Version 1.2'
    LabelPosition = adLeft
    LabelSpacing = 0
    Ctl3D = False
    ParentCtl3D = False
    Decimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 2
    MaxValue = 53.000000000000000000
    ParentFont = False
    TabOrder = 7
    Increment = 1.000000000000000000
    RoundValues = False
    Wrap = False
  end
  object Button4: TButton
    Left = 10
    Top = 179
    Width = 235
    Height = 25
    Caption = 'ok'
    TabOrder = 8
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de texto|*.txt;*.prn;*.tmp'
    InitialDir = 'c:\'
    Left = 400
    Top = 44
  end
end
