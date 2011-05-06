object fmCriarAvaria: TfmCriarAvaria
  Left = 648
  Top = 210
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Selecione o tipo'
  ClientHeight = 159
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Loja:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLoja: TLabel
    Left = 50
    Top = 9
    Width = 57
    Height = 13
    Caption = '00000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbData: TadLabelEdit
    Left = 13
    Top = 48
    Width = 145
    Height = 19
    LabelDefs.Width = 28
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Data'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenDisabled.BackColor = clInfoBk
    Colors.WhenDisabled.TextColor = clWindowText
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Enabled = False
    TabOrder = 0
    Text = 'lbData'
  end
  object cbTipo: TadLabelComboBox
    Left = 13
    Top = 88
    Width = 145
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkSoft
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    TabOrder = 1
    Text = 'Parcial'
    Items.Strings = (
      'Parcial'
      'Total'
      'Dev Fornecedor'
      'Assitencia Tec')
    LabelDefs.Width = 30
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo '
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btOk: TFlatButton
    Left = 102
    Top = 127
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btOkClick
  end
  object btClose: TFlatButton
    Left = 174
    Top = 127
    Width = 65
    Height = 25
    Caption = 'Cancela'
    TabOrder = 3
    OnClick = btCloseClick
  end
end
