object fmCompFornecedor: TfmCompFornecedor
  Left = 536
  Top = 357
  Width = 744
  Height = 365
  Caption = 'fmCompFornecedor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCred: TLabel
    Left = 465
    Top = 63
    Width = 3
    Height = 13
    Caption = '-'
  end
  object FlatButton1: TFlatButton
    Left = 556
    Top = 33
    Width = 32
    Height = 25
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333330000003333333333333333330000003333344333333333330000003333
      4224333333333300000033342222433333333300000033422222243333333300
      000034222A2222433333330000003222A3A222433333330000003A2A333A2224
      33333300000033A33333A222433333000000333333333A222433330000003333
      333333A222433300000033333333333A222433000000333333333333A2224300
      00003333333333333A224300000033333333333333A223000000333333333333
      333A33000000333333333333333333000000}
    TabOrder = 0
    OnClick = FlatButton1Click
  end
  object DBGrid2: TDBGrid
    Left = 56
    Top = 120
    Width = 625
    Height = 120
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object cbEmpresa: TadLabelComboBox
    Left = 16
    Top = 32
    Width = 89
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    LabelDefs.Width = 44
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Empresa:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbTpRel: TadLabelComboBox
    Left = 351
    Top = 34
    Width = 98
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'Fiscal'
      'Gerencial')
    LabelDefs.Width = 102
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Compromissos do tipo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object GroupBox1: TGroupBox
    Left = 119
    Top = 15
    Width = 225
    Height = 53
    Caption = ' Per'#237'odo '
    TabOrder = 4
    object Label1: TLabel
      Left = 102
      Top = 23
      Width = 18
      Height = 13
      Caption = 'at'#233' '
    end
    object dti: TfsDateTimePicker
      Left = 5
      Top = 20
      Width = 95
      Height = 22
      Date = 40238.649664583330000000
      Time = 40238.649664583330000000
      TabOrder = 0
    end
    object dtf: TfsDateTimePicker
      Left = 123
      Top = 20
      Width = 95
      Height = 22
      Date = 40238.649664583330000000
      Time = 40238.649664583330000000
      TabOrder = 1
    end
  end
  object edCodForn: TadLabelEdit
    Left = 464
    Top = 36
    Width = 73
    Height = 19
    LabelDefs.Width = 54
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Fornecedor'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 5
    Text = 'edCodForn'
    OnDblClick = edCodFornDblClick
  end
  object qrCredores: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* select dspar.credor, dspar.numDoc, dspar.numPar, dbo.dateIntT' +
        'odate(dspar.datven) as datven , dspar.valPar,  case dspag.datpag' +
        ' when 0 then '#39#39' else dbo.dateIntTodate(dspag.datpag) end as datP' +
        'ag ,  case dspar.sitPar when '#39#39' then '#39'A'#39' else dspar.sitPar end a' +
        's sitPar,  dspag.valpag, dsdct.serie, dsdct.docume, dsdct.cd_loj' +
        'a  from  dspar (nolock)  inner join dsdct on dspar.numDoc = dsdc' +
        't.numDoc  left join dspag (nolock) on dspag.numdoc = dspar.numdo' +
        'c and dspar.numpar  = dspag.numpar  where dspar.numDoc in(select' +
        ' numDoc from  dsdct (nolock) where cd_loja in (05, 06, 10, 09, 1' +
        '1, 12, 17, 13, 07, 18) and cod_categ = '#39'0023'#39' and data_lanc betw' +
        'een 20090522 and  20090601 and serie <> '#39'PF'#39'  ) and  dspag.datpa' +
        'g <> dspar.datven order by dspar.numDoc, dspar.numPar '
      '*/')
    Left = 112
    Top = 168
  end
  object DataSource2: TDataSource
    DataSet = tbFichas
    Left = 224
    Top = 200
  end
  object tbFichas: TADOTable
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Left = 176
    Top = 152
    object tbFichasdt_entsai: TDateTimeField
      FieldName = 'dt_entsai'
    end
    object tbFichascd_cred: TStringField
      FieldName = 'cd_cred'
      Size = 5
    end
    object tbFichasnm_razsoc: TStringField
      FieldName = 'nm_razsoc'
      Size = 60
    end
    object tbFichasserie: TStringField
      FieldName = 'serie'
      Size = 3
    end
    object tbFichasnumNota: TStringField
      FieldName = 'numNota'
      Size = 8
    end
    object tbFichasficha: TIntegerField
      FieldName = 'ficha'
    end
    object tbFichascd_loja: TStringField
      FieldName = 'cd_loja'
      Size = 2
    end
    object tbFichasnumPar: TStringField
      FieldName = 'numPar'
      Size = 1
    end
    object tbFichasdataVencimento: TDateTimeField
      FieldName = 'dataVencimento'
    end
    object tbFichasvalPar: TBCDField
      FieldName = 'valPar'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbFichassitPar: TStringField
      FieldName = 'sitPar'
      Size = 1
    end
    object tbFichasdatPag: TDateTimeField
      FieldName = 'datPag'
    end
    object tbFichasvalpag: TBCDField
      FieldName = 'valpag'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
end
