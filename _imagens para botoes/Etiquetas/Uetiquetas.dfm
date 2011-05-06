object Form1: TForm1
  Left = 192
  Top = 107
  Width = 425
  Height = 183
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 69
    Width = 66
    Height = 13
    Caption = 'Nome da Loja'
  end
  object Label2: TLabel
    Left = 10
    Top = 10
    Width = 36
    Height = 13
    Caption = 'Arquivo'
  end
  object Label3: TLabel
    Left = 32
    Top = 128
    Width = 310
    Height = 13
    Caption = 'PEGAR O RELATORIO DE NOME E FUNCAO NO FX PESSOAL'
  end
  object Edit1: TEdit
    Left = 10
    Top = 25
    Width = 397
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Abrir'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 336
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object Button1: TButton
    Left = 336
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    Visible = False
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 10
    Top = 86
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object OpenDialog1: TOpenDialog
    Left = 112
    Top = 56
  end
end
