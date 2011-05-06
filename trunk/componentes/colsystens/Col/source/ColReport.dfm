object FColSelFields: TFColSelFields
  Left = 235
  Top = 139
  Width = 236
  Height = 390
  Caption = 'Fields Edit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 235
    Width = 34
    Height = 13
    Caption = 'Display'
  end
  object Label2: TLabel
    Left = 169
    Top = 235
    Width = 20
    Height = 13
    Caption = 'Size'
  end
  object Label3: TLabel
    Left = 9
    Top = 274
    Width = 23
    Height = 13
    Caption = 'Align'
  end
  object Edit1: TEdit
    Left = 9
    Top = 251
    Width = 144
    Height = 21
    TabOrder = 0
    OnExit = Edit1Exit
  end
  object Edit2: TEdit
    Left = 169
    Top = 251
    Width = 56
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnExit = Edit1Exit
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 320
    Width = 97
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 288
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnExit = Edit1Exit
    Items.Strings = (
      'LeftJustify'
      'RightJustify'
      'Center')
  end
  object BitBtn2: TBitBtn
    Left = 128
    Top = 320
    Width = 97
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
  object CheckFields: TCheckBox
    Left = 168
    Top = 288
    Width = 57
    Height = 17
    Caption = 'Visible'
    TabOrder = 5
    OnExit = Edit1Exit
  end
  object ListFields: TListBox
    Left = 0
    Top = 0
    Width = 209
    Height = 225
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 6
    OnClick = ListFieldsClick
  end
  object SpinButton1: TSpinButton
    Left = 208
    Top = 0
    Width = 20
    Height = 225
    Ctl3D = False
    DownGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000000000000080800000808000008080000080
      8000008080000080800000808000000000000000000000000000008080000080
      8000008080000080800000808000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    ParentCtl3D = False
    TabOrder = 7
    UpGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000080
      8000008080000080800000808000008080000000000000000000000000000080
      8000008080000080800000808000008080000080800000808000000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    OnDownClick = SpinButton1DownClick
    OnUpClick = SpinButton1UpClick
  end
end
