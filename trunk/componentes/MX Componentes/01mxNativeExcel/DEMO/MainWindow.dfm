object frm_MainWindow: Tfrm_MainWindow
  Left = 490
  Top = 176
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Native Excel Demo'
  ClientHeight = 128
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 280
    Height = 13
    Caption = 'Component'#39's website: www.geocities.com/maxcomponents'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 216
    Height = 13
    Caption = 'Component'#39's author email: wmax@freemail.hu'
  end
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 415
    Height = 13
    Caption = 
      'This demo creates a small Excel BIFF file into this application'#39 +
      's directory.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object btn_Start: TButton
    Left = 128
    Top = 80
    Width = 75
    Height = 25
    Caption = '&Generate'
    TabOrder = 0
    OnClick = btn_StartClick
  end
  object btn_Close: TButton
    Left = 216
    Top = 80
    Width = 75
    Height = 25
    Caption = '&Close'
    ModalResult = 1
    TabOrder = 1
    OnClick = btn_CloseClick
  end
  object mxNativeExcel1: TmxNativeExcel
    ActiveFont = 0
    Borders = []
    Shading = False
    Version = '1.21'
    Left = 304
    Top = 80
  end
end
