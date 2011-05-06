object frmClose: TfrmClose
  Left = 830
  Top = 221
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Finalizando...'
  ClientHeight = 84
  ClientWidth = 134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 32
    Width = 21
    Height = 48
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 119
    Height = 13
    Caption = 'Sistema sendo Finalizado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 96
    Top = 32
  end
  object Timer2: TTimer
    Interval = 250
    OnTimer = Timer2Timer
    Left = 8
    Top = 32
  end
end
