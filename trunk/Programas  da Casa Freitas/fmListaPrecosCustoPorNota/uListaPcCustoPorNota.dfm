object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 585
  Height = 240
  TabOrder = 0
  object SoftDBGrid1: TSoftDBGrid
    Left = 5
    Top = 58
    Width = 577
    Height = 177
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object Edit1: TadLabelEdit
    Left = 6
    Top = 26
    Width = 157
    Height = 22
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pedido'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    AutoSize = False
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object btCalc: TfsBitBtn
    Left = 169
    Top = 25
    Width = 52
    Height = 25
    TabOrder = 2
    OnClick = btCalcClick
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
  object tb: TADOTable
    Left = 96
    Top = 64
  end
end