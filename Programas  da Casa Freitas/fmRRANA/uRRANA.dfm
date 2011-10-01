inherited fmRelGeral1: TfmRelGeral1
  Caption = 'Raz'#227'o anal'#237'tico RRANA'
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited btOk: TFlatButton
    TabOrder = 5
  end
  object edCodigo: TadLabelEdit [2]
    Left = 9
    Top = 98
    Width = 156
    Height = 26
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Faixa de c'#243'digo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  inherited GroupBox1: TGroupBox
    TabOrder = 1
  end
  inherited cbDetAvaForn: TfsCheckBox
    TabOrder = 2
  end
  inherited cbCaixas: TadLabelComboBox
    TabOrder = 3
  end
  inherited qr: TADOQuery
    Top = 160
  end
  inherited tbValoresAvarias: TADOTable
    Top = 191
  end
  inherited tbValoresAvarias_Total: TADOTable
    Top = 224
  end
end
