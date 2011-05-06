object fmMain: TfmMain
  Left = 590
  Top = 288
  Width = 295
  Height = 304
  BorderIcons = [biSystemMenu]
  Caption = 'Coletor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    279
    246)
  PixelsPerInch = 96
  TextHeight = 13
  object lbEanRecebido: TLabel
    Left = 64
    Top = 2
    Width = 73
    Height = 13
    Caption = 'lbEanRecebido'
    Visible = False
  end
  object edDescricao: TEdit
    Left = 3
    Top = 43
    Width = 275
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 20
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnEnter = edEanExit
  end
  object lbItens: TadLabelListBox
    Left = 2
    Top = 67
    Width = 275
    Height = 176
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnDblClick = lbItensDblClick
    LabelDefs.Width = 88
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Itens coletados'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = [fsBold]
    LabelDefs.ParentFont = False
    LabelSpacing = 5
    Colors.WhenEnterFocus.BackColor = clWindow
  end
  object edEan: TadLabelEdit
    Left = 3
    Top = 19
    Width = 148
    Height = 22
    LabelDefs.Width = 22
    LabelDefs.Height = 13
    LabelDefs.Caption = 'EAN'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 13
    ParentFont = False
    TabOrder = 2
    OnExit = edEanExit
    OnKeyDown = edEanKeyDown
    OnKeyPress = edEanKeyPress
  end
  object edQuant: TadLabelNumericEdit
    Left = 160
    Top = 19
    Width = 117
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    LabelDefs.Width = 55
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Quantidade'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Decimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 5
    OnKeyDown = edQuantKeyDown
    ParentFont = False
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 56
    Top = 104
    object VerItens1: TMenuItem
      Caption = 'File'
      object NovaCaptura1: TMenuItem
        Caption = 'Conf Captura'
        OnClick = NovaCaptura1Click
      end
      object N1: TMenuItem
        AutoLineReduction = maAutomatic
        Caption = '     '
      end
      object NovaCaptura2: TMenuItem
        Caption = 'Ver itens'
        OnClick = NovaCaptura2Click
      end
      object Mudarlote1: TMenuItem
        Caption = 'Mudar lote'
        OnClick = Mudarlote1Click
      end
      object mnTotais: TMenuItem
        Caption = 'Valores totais'
        OnClick = mnTotaisClick
      end
      object DeletarLote1: TMenuItem
        Caption = 'Apagar Lote'
        OnClick = DeletarLote1Click
      end
    end
  end
end
