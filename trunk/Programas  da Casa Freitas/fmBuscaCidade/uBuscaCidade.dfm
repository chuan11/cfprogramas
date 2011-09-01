inherited fmBuscaDiversas: TfmBuscaDiversas
  Caption = 'fmBuscaDiversas'
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited fnGrid: TSoftDBGrid
    OnDblClick = fnGridDblClick
  end
  object edFiltro: TEdit [3]
    Left = 342
    Top = 22
    Width = 161
    Height = 19
    Color = clBtnFace
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 5
    Text = 'edFiltro'
  end
end
