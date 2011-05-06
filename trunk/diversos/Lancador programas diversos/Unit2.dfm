object Form2: TForm2
  Left = 299
  Top = 213
  Width = 314
  Height = 217
  Caption = 'Form2'
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
  object cbUsaSenha: TfsCheckBox
    Left = 9
    Top = 95
    Width = 287
    Height = 17
    Caption = 'Usa autoriza'#231#227'o para acessar local das atualiza'#231#245'es'
    TabOrder = 0
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object edLocal: TadLabelEdit
    Left = 8
    Top = 68
    Width = 249
    Height = 19
    Hint = 
      'Se ficar em branco, copia os arquivos para o mesmo diret'#243'rio do ' +
      'execut'#225'vel'
    LabelDefs.Width = 177
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Local dos programas (Sem "\" no fim)'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = 'edLocal'
    OnDblClick = edLocalDblClick
  end
  object edRemoto: TadLabelEdit
    Left = 8
    Top = 20
    Width = 249
    Height = 19
    Hint = 
      'Se ficar em branco, copia os arquivos para o mesmo diret'#243'rio do ' +
      'execut'#225'vel'
    LabelDefs.Width = 187
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Local das atualiza'#231#245'es (Sem "\" no fim)'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'adLabelEdit1'
    OnDblClick = edRemotoDblClick
  end
  object edUser: TadLabelEdit
    Left = 8
    Top = 139
    Width = 120
    Height = 19
    Hint = 
      'Se ficar em branco, copia os arquivos para o mesmo diret'#243'rio do ' +
      'execut'#225'vel'
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Usu'#225'rio'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = 'edLocal'
    OnDblClick = edLocalDblClick
  end
  object edSenha: TadLabelEdit
    Left = 138
    Top = 138
    Width = 120
    Height = 19
    Hint = 
      'Se ficar em branco, copia os arquivos para o mesmo diret'#243'rio do ' +
      'execut'#225'vel'
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Senha'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = 'edLocal'
    OnDblClick = edLocalDblClick
  end
end
