object formMain: TformMain
  Left = 420
  Top = 54
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'GrFingerX - Sample application - Delphi'
  ClientHeight = 571
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000200101010000000000028010000260000002020100000000000E802
    00004E0100002800000010000000200000000100040000000000800000000000
    0000000000001000000010000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00444444444444444448888888888888844800
    00FFFFFFFF844800FFFFFFFFFF844888888888888884488888888888888448F0
    FF00F0F87784480FF0FF0F08778448FF0F00F0F8888448F0F0F0F0F87784480F
    F00F0F08888448FF0FF0F0F8888448F0FF0F0FF8888448888888888888844444
    444444444444444444444444C494000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000280000002000000040000000010004000000
    0000000200000000000000000000100000001000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0044444444444444444444
    4444444444444888888888888888888888888888888448F0000000FFFFFFFFFF
    FFFFFFFF778448FFFFFFFFFFFFFFFFFFFFFFFFFF778448F00000000FFFFFFFFF
    FFFFFFFF778448FFFFFFFFFFFFFFFFFFFFFFFFFF778448F00000FFFFFFFFFFFF
    FFFFFFFF778448FFFFFFFFFFFFFFFFFFFFFFFFFF778448888888888888888888
    88888888888448777777777777777777778F80000084487FF0FF00FF0F00FFF0
    F7888888888448700FF0FFF0FF0FFF0FF78777777784487FFF0FFF0FF0F0F00F
    F78777777784487FF0FFF0FF0FF0F0FFF7888888888448700FFF0FF00F0FF0FF
    F78777777784487F0FF0FF0F0F0FF0FF078777777784487F0FF0FF000F0FF0F0
    F78888888884487FF0FF0FF0FF0F0FF0F787777777844870F0FFF0FFF0FF0F00
    F787777777844870FF0FF0FF0FF0FF0FF78888888884487F0FF0FF00FFF0F0FF
    078888888884487F0FFF00FFFF0FF0F0F78888888884487FF0FFFF0000FF0FF0
    F78888888884487FFF0FFFFFFFF0FF0FF788888888844870FFF00000000FFF0F
    078888888884487F0FFFFFFFFFFF00FF07888888888448777777777777777777
    7788888888844888888888888888888888888888888444444444444444444444
    44444444444444F44F4F4F4444444444444CC4CC49944FFFF4F4F44444444444
    444CC4CC49944444444444444444444444444444444400000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000}
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 90
    Width = 351
    Height = 346
  end
  object image: TImage
    Left = 10
    Top = 92
    Width = 346
    Height = 342
    Stretch = True
  end
  object memoLog: TMemo
    Left = 7
    Top = 442
    Width = 498
    Height = 117
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btEnroll: TButton
    Left = 424
    Top = 152
    Width = 81
    Height = 25
    Caption = 'Gravar'
    Enabled = False
    TabOrder = 1
    OnClick = btEnrollClick
  end
  object btVerify: TButton
    Left = 23
    Top = 328
    Width = 81
    Height = 25
    Caption = 'Verify'
    Enabled = False
    TabOrder = 2
    Visible = False
    OnClick = btVerifyClick
  end
  object btIdentify: TButton
    Left = 423
    Top = 189
    Width = 81
    Height = 25
    Caption = 'Identificar'
    Enabled = False
    TabOrder = 3
    OnClick = btIdentifyClick
  end
  object btClearDB: TButton
    Left = 23
    Top = 272
    Width = 81
    Height = 25
    Caption = 'Clear database'
    Enabled = False
    TabOrder = 5
    Visible = False
    OnClick = btClearDBClick
  end
  object btClearLog: TButton
    Left = 425
    Top = 274
    Width = 81
    Height = 25
    Caption = 'Clear log'
    TabOrder = 6
    OnClick = btClearLogClick
  end
  object ckBoxAutoIdentify: TCheckBox
    Left = 424
    Top = 332
    Width = 81
    Height = 17
    Caption = 'Auto identify'
    Enabled = False
    TabOrder = 7
    Visible = False
  end
  object ckAutoExtract: TCheckBox
    Left = 423
    Top = 356
    Width = 81
    Height = 17
    Caption = 'Auto Extract'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object btExtract: TButton
    Left = 23
    Top = 296
    Width = 81
    Height = 25
    Caption = 'Extract template'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = btExtractClick
  end
  object grFinger: TGrFingerXCtrl
    Left = 152
    Top = 120
    Width = 32
    Height = 32
    OnSensorPlug = grFingerSensorPlug
    OnSensorUnplug = grFingerSensorUnplug
    OnFingerUp = grFingerFingerUp
    OnFingerDown = grFingerFingerDown
    OnImageAcquired = grFingerImageAcquired
    ControlData = {000800004F0300004F030000}
  end
  object RadioGroup1: TRadioGroup
    Left = 424
    Top = 80
    Width = 81
    Height = 56
    Caption = ' Lado '
    ItemIndex = 0
    Items.Strings = (
      'Direito'
      'Esquerdo')
    TabOrder = 10
  end
  object cbEmpregados: TComboBox
    Left = 10
    Top = 34
    Width = 348
    Height = 22
    BevelEdges = []
    Style = csDropDownList
    Color = clInfoBk
    Ctl3D = False
    DropDownCount = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    MaxLength = 99
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 11
  end
  object Panel1: TPanel
    Left = 46
    Top = 59
    Width = 310
    Height = 26
    TabOrder = 12
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 36
      Height = 13
      Caption = 'Direito: '
    end
    object Label2: TLabel
      Left = 158
      Top = 5
      Width = 48
      Height = 13
      Caption = 'Esquerdo:'
    end
    object lbEsq: TLabel
      Left = 215
      Top = 5
      Width = 13
      Height = 13
      Caption = ' - '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbDir: TLabel
      Left = 52
      Top = 5
      Width = 13
      Height = 13
      Caption = ' - '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object BitBtn1: TBitBtn
    Left = 11
    Top = 59
    Width = 30
    Height = 25
    TabOrder = 13
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
  end
  object Edit2: TEdit
    Left = 8
    Top = 6
    Width = 349
    Height = 21
    CharCase = ecUpperCase
    Color = clInfoBk
    TabOrder = 14
    OnChange = Edit2Change
  end
  object btDelete: TButton
    Left = 424
    Top = 227
    Width = 81
    Height = 25
    Caption = 'Apagar digital'
    Enabled = False
    TabOrder = 15
    OnClick = btDeleteClick
  end
  object MainMenu: TMainMenu
    Left = 232
    Top = 180
    object mnImage: TMenuItem
      Caption = '&Image'
      Visible = False
      object mnImageSave: TMenuItem
        Caption = '&Save...'
        ShortCut = 16467
        OnClick = mnImageSaveClick
      end
      object mnImageLoad: TMenuItem
        Caption = '&Load...'
        ShortCut = 16460
        OnClick = mnImageLoadClick
      end
    end
    object mnOptions: TMenuItem
      Caption = '&Options...'
      ShortCut = 16463
      Visible = False
      OnClick = mnOptionsClick
    end
    object mnVersion: TMenuItem
      Caption = '&Version'
      Visible = False
      OnClick = mnVersionClick
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 192
    Top = 180
  end
  object SavePictureDialog: TSavePictureDialog
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 120
    Top = 120
  end
end
