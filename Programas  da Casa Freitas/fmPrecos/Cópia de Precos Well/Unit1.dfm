object PasswordDlg: TPasswordDlg
  Left = 435
  Top = 224
  BorderStyle = bsSingle
  Caption = 'Senha Administrador'
  ClientHeight = 81
  ClientWidth = 183
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 79
    Height = 13
    Caption = 'Informe a senha '
  end
  object Password: TEdit
    Left = 8
    Top = 24
    Width = 171
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 63
    Top = 50
    Width = 54
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 124
    Top = 50
    Width = 54
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
end
