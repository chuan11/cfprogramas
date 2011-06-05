object fmCad: TfmCad
  Left = 842
  Top = 224
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de digitais'
  ClientHeight = 538
  ClientWidth = 370
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
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    370
    538)
  PixelsPerInch = 96
  TextHeight = 13
  object memoLog: TMemo
    Left = 5
    Top = 431
    Width = 363
    Height = 105
    Anchors = [akTop, akRight]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btVerify: TButton
    Left = 194
    Top = 507
    Width = 81
    Height = 25
    Caption = 'Verify'
    Enabled = False
    TabOrder = 1
    Visible = False
    OnClick = btVerifyClick
  end
  object btIdentify: TButton
    Left = 100
    Top = 506
    Width = 81
    Height = 25
    Caption = 'Identify'
    Enabled = False
    TabOrder = 2
    Visible = False
    OnClick = btIdentifyClick
  end
  object btClearDB: TButton
    Left = 4
    Top = 474
    Width = 81
    Height = 25
    Caption = 'Clear database'
    TabOrder = 4
    Visible = False
    OnClick = btClearDBClick
  end
  object btClearLog: TButton
    Left = 100
    Top = 474
    Width = 81
    Height = 25
    Caption = 'Clear log'
    TabOrder = 5
    Visible = False
    OnClick = btClearLogClick
  end
  object ckAutoExtract: TCheckBox
    Left = 308
    Top = 482
    Width = 81
    Height = 17
    Caption = 'Auto Extract'
    Checked = True
    State = cbChecked
    TabOrder = 6
    Visible = False
  end
  object btExtract: TButton
    Left = 4
    Top = 506
    Width = 81
    Height = 25
    Caption = 'Extract template'
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = btExtractClick
  end
  object grFinger: TGrFingerXCtrl
    Left = 13
    Top = 435
    Width = 32
    Height = 32
    OnSensorPlug = grFingerSensorPlug
    OnSensorUnplug = grFingerSensorUnplug
    OnFingerUp = grFingerFingerUp
    OnFingerDown = grFingerFingerDown
    OnImageAcquired = grFingerImageAcquired
    ControlData = {000800004F0300004F030000}
  end
  object cbEmp: TComboBox
    Left = 5
    Top = 34
    Width = 300
    Height = 21
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    DropDownCount = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    MaxLength = 99
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 8
  end
  object pnDetCadastro: TPanel
    Left = 5
    Top = 58
    Width = 363
    Height = 59
    TabOrder = 9
    object Label1: TLabel
      Left = 7
      Top = 6
      Width = 39
      Height = 13
      Caption = 'Dig esq:'
    end
    object Label2: TLabel
      Left = 8
      Top = 37
      Width = 33
      Height = 13
      Caption = 'Dig dir:'
    end
    object lbEsq: TLabel
      Left = 52
      Top = 7
      Width = 13
      Height = 13
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDir: TLabel
      Left = 53
      Top = 37
      Width = 13
      Height = 13
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbUser: TLabel
      Left = 324
      Top = 7
      Width = 13
      Height = 13
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Bevel2: TBevel
      Left = 6
      Top = 29
      Width = 340
      Height = 2
    end
    object btIncEsq: TfsBitBtn
      Left = 149
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      Visible = False
      OnClick = btIncEsqClick
    end
    object btRemEsq: TfsBitBtn
      Left = 232
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Remover'
      TabOrder = 1
      Visible = False
      OnClick = btRemEsqClick
    end
    object btIncDir: TfsBitBtn
      Left = 149
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 2
      Visible = False
      OnClick = btIncDirClick
    end
    object btRemDir: TfsBitBtn
      Left = 232
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Remover'
      TabOrder = 3
      Visible = False
      OnClick = btRemDirClick
    end
  end
  object Edit1: TEdit
    Left = 5
    Top = 9
    Width = 299
    Height = 22
    AutoSize = False
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 10
    OnChange = Edit1Change
  end
  object btVerificaCadastro: TBitBtn
    Left = 308
    Top = 8
    Width = 59
    Height = 46
    Caption = '&Consultar'
    TabOrder = 11
    OnClick = verificaCadastro
    NumGlyphs = 2
  end
  object Panel2: TPanel
    Left = 5
    Top = 124
    Width = 363
    Height = 299
    TabOrder = 12
    Visible = False
    object image: TImage
      Left = 12
      Top = 33
      Width = 203
      Height = 259
      Stretch = True
    end
    object Bevel1: TBevel
      Left = 7
      Top = 28
      Width = 213
      Height = 268
    end
    object Label3: TLabel
      Left = 7
      Top = 6
      Width = 70
      Height = 13
      Caption = 'Lado a Incluir: '
    end
    object lbLadoAIncluir: TLabel
      Left = 79
      Top = 7
      Width = 13
      Height = 13
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btEnroll: TButton
      Left = 235
      Top = 267
      Width = 58
      Height = 25
      Caption = '&Salvar'
      TabOrder = 0
      OnClick = btEnrollClick
    end
    object Button1: TButton
      Left = 299
      Top = 267
      Width = 58
      Height = 25
      Caption = '&Cancela'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
