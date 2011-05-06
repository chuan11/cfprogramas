object fmCadDigitais: TfmCadDigitais
  Left = 472
  Top = 334
  Width = 522
  Height = 445
  Caption = 'fmCadDigitais'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 72
    Top = 56
    Width = 233
    Height = 273
  end
  object Bevel2: TBevel
    Left = 50
    Top = 29
    Width = 247
    Height = 281
  end
  object grFinger: TGrFingerXCtrl
    Left = 352
    Top = 97
    Width = 32
    Height = 32
    OnSensorPlug = grFingerSensorPlug
    OnImageAcquired = grFingerImageAcquired
    ControlData = {000800004F0300004F030000}
  end
end
