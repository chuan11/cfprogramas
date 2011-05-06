object fmVisbatidas: TfmVisbatidas
  Left = 563
  Top = 285
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Visualizar somente batidas'
  ClientHeight = 222
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 88
    Width = 26
    Height = 13
    Caption = 'Label'
    Visible = False
  end
  object GroupBox3: TGroupBox
    Left = 5
    Top = 1
    Width = 116
    Height = 65
    Caption = 'Dia: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object dti: TfsDateTimePicker
      Left = 6
      Top = 25
      Width = 97
      Height = 21
      Date = 39927.505193171300000000
      Time = 39927.505193171300000000
      TabOrder = 0
    end
  end
  object BitBtn7: TBitBtn
    Left = 128
    Top = 7
    Width = 94
    Height = 60
    Caption = '&Consultar'
    TabOrder = 1
    OnClick = BitBtn7Click
    Kind = bkOK
  end
  object ListBox: TListBox
    Left = 5
    Top = 70
    Width = 219
    Height = 147
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 2
  end
end
