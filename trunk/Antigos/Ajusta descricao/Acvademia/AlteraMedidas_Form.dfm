object frmAlteraMedidas: TfrmAlteraMedidas
  Left = 207
  Top = 237
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Altera medidas dos Alunos'
  ClientHeight = 225
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 40
    Height = 13
    Caption = 'Número:'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 72
    Top = 8
    Width = 85
    Height = 13
    Caption = 'Data da Medição:'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 30
    Height = 13
    Caption = 'Aluno:'
    FocusControl = DBEdit3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 57
    Height = 21
    DataField = 'COD_MED'
    DataSource = dsMedidas
    Enabled = False
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 72
    Top = 24
    Width = 121
    Height = 21
    DataField = 'DATA_MED'
    DataSource = dsMedidas
    TabOrder = 6
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 64
    Width = 41
    Height = 21
    DataField = 'COD_ALU'
    DataSource = dsMedidas
    Enabled = False
    TabOrder = 1
  end
  object dblcNomeAlu: TDBLookupComboBox
    Left = 48
    Top = 64
    Width = 273
    Height = 21
    DataField = 'COD_ALU'
    DataSource = dsMedidas
    Enabled = False
    KeyField = 'COD_ALU'
    ListField = 'NOME'
    ListSource = dsNome
    TabOrder = 2
  end
  object btnGrava: TBitBtn
    Left = 432
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 4
    OnClick = btnGravaClick
    Glyph.Data = {
      42030000424D42030000000000003600000028000000110000000F0000000100
      1800000000000C030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F0000FFFFFFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBF7F00007F00007F0000FFFFFFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BF00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00007F00007F0000
      7F0000FFFFFFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBF00000000000000
      00000000000000007F00007F00007F0000FFFFFF7F00007F0000FFFFFFBFBFBF
      BFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFFFF7F00007F00007F
      0000FFFFFF000000BFBFBF7F00007F0000FFFFFFBFBFBFBFBFBFBFBFBF00BFBF
      BF000000FFFFFF7F7F7F7F7F7F7F7F7F7F0000FFFFFFFFFFFF000000BFBFBFBF
      BFBF7F0000FFFFFFBFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBFBFBFBF7F0000FFFFFFBF
      BFBFBFBFBF00BFBFBF000000FFFFFF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFF
      FF000000BFBFBFBFBFBFBFBFBFBFBFBF7F0000FFFFFFBFBFBF00BFBFBF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBF7F0000FFFFFF00BFBFBF000000FFFFFF7F7F7F7F7F7FBFBFBF
      BFBFBFBFBFBFFFFFFF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F00
      0000BFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFF7F
      7F7F7F7F7FBFBFBF000000BFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF00BFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBF
      BF000000000000000000000000000000000000BFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00BFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBF00}
  end
  object btnCancela: TBitBtn
    Left = 432
    Top = 32
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 5
    OnClick = btnCancelaClick
    Glyph.Data = {
      36030000424D360300000000000036000000280000000F000000100000000100
      18000000000000030000C30E0000C30E00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBF
      0000FF0000FF0000FFBFBFBF7F7F7F0000007F7F7FBFBFBF0000FF0000FF0000
      FFBFBFBFBFBFBF000000BFBFBF0000FF0000FF0000FFBFBFBFBFBFBF00000000
      0000000000BFBFBFBFBFBF0000FF0000FF0000FFBFBFBF000000BFBFBF0000FF
      0000FFBFBFBFBFBFBFBFBFBF7F7F7F0000007F7F7FBFBFBFBFBFBFBFBFBF0000
      FF0000FFBFBFBF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000FF0000FF0000000000FF0000FF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BF0000FF0000FF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F00
      00007F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000000000FF0000FF
      BFBFBFBFBFBFBFBFBFBFBFBF00007F00000000007FBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBF0000000000FF0000FFBFBFBFBFBFBFBFBFBFBFBFBF00000000
      0000000000BFBFBF0000FF0000FF0000FF0000FF0000FF000000BFBFBF0000FF
      0000FFBFBFBFBFBFBFBFBFBF000000000000000000BFBFBFBFBFBF0000FF0000
      FF0000FF0000FF000000BFBFBF0000FF0000FF0000FFBFBFBFBFBFBF00000000
      0000000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF000000BFBFBFBFBFBF
      0000FF0000FF0000FFBFBFBF7F7F7F0000007F7F7FBFBFBF0000FF0000FF0000
      FF0000FF0000FF000000BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FFBFBFBFBFBFBF0000FF000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBF0000FF0000FF0000FF0000FF0000FFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000}
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 96
    Width = 497
    Height = 129
    Caption = 'Medidas do(a) Aluno(a):'
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Peso:'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 8
      Top = 72
      Width = 48
      Height = 13
      Caption = 'Abdomen:'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 128
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Coxa Direita:'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 128
      Top = 72
      Width = 75
      Height = 13
      Caption = 'Coxa Esquerda:'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 248
      Top = 24
      Width = 68
      Height = 13
      Caption = 'Biceps Direito:'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 248
      Top = 72
      Width = 83
      Height = 13
      Caption = 'Biceps Esquerdo:'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 368
      Top = 24
      Width = 30
      Height = 13
      Caption = 'Tórax:'
      FocusControl = DBEdit10
    end
    object DBEdit4: TDBEdit
      Left = 8
      Top = 40
      Width = 105
      Height = 21
      DataField = 'PESO'
      DataSource = dsMedidas
      TabOrder = 0
      OnExit = DBEdit4Exit
      OnKeyPress = DBEdit4KeyPress
    end
    object DBEdit5: TDBEdit
      Left = 8
      Top = 88
      Width = 105
      Height = 21
      DataField = 'ABDOMEM'
      DataSource = dsMedidas
      TabOrder = 1
      OnExit = DBEdit5Exit
      OnKeyPress = DBEdit5KeyPress
    end
    object DBEdit6: TDBEdit
      Left = 128
      Top = 40
      Width = 105
      Height = 21
      DataField = 'COXA_D'
      DataSource = dsMedidas
      TabOrder = 2
      OnExit = DBEdit6Exit
      OnKeyPress = DBEdit6KeyPress
    end
    object DBEdit7: TDBEdit
      Left = 128
      Top = 88
      Width = 105
      Height = 21
      DataField = 'COXA_E'
      DataSource = dsMedidas
      TabOrder = 3
      OnExit = DBEdit7Exit
      OnKeyPress = DBEdit7KeyPress
    end
    object DBEdit8: TDBEdit
      Left = 248
      Top = 40
      Width = 105
      Height = 21
      DataField = 'BICEPS_D'
      DataSource = dsMedidas
      TabOrder = 4
      OnExit = DBEdit8Exit
      OnKeyPress = DBEdit8KeyPress
    end
    object DBEdit9: TDBEdit
      Left = 248
      Top = 88
      Width = 105
      Height = 21
      DataField = 'BICEPS_E'
      DataSource = dsMedidas
      TabOrder = 5
      OnExit = DBEdit9Exit
      OnKeyPress = DBEdit9KeyPress
    end
    object DBEdit10: TDBEdit
      Left = 368
      Top = 40
      Width = 105
      Height = 21
      DataField = 'TORAX'
      DataSource = dsMedidas
      TabOrder = 6
      OnExit = DBEdit10Exit
      OnKeyPress = DBEdit10KeyPress
    end
  end
  object qryMedidas: TQuery
    CachedUpdates = True
    DatabaseName = 'Banco de Dados Academia'
    DataSource = frmCadMedidas.dsMedida
    SQL.Strings = (
      'Select * '
      'From Medidas'
      'Where COD_MED = :COD_MED')
    UpdateObject = upsMedidas
    Left = 368
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'COD_MED'
        ParamType = ptUnknown
      end>
  end
  object dsMedidas: TDataSource
    AutoEdit = False
    DataSet = qryMedidas
    Left = 416
    Top = 160
  end
  object upsMedidas: TUpdateSQL
    ModifySQL.Strings = (
      'update Medidas'
      'set'
      '  COD_MED = :COD_MED,'
      '  COD_ALU = :COD_ALU,'
      '  DATA_MED = :DATA_MED,'
      '  PESO = :PESO,'
      '  ABDOMEM = :ABDOMEM,'
      '  COXA_D = :COXA_D,'
      '  COXA_E = :COXA_E,'
      '  BICEPS_D = :BICEPS_D,'
      '  BICEPS_E = :BICEPS_E,'
      '  TORAX = :TORAX'
      'where'
      '  COD_MED = :OLD_COD_MED')
    InsertSQL.Strings = (
      'insert into Medidas'
      
        '  (COD_MED, COD_ALU, DATA_MED, PESO, ABDOMEM, COXA_D, COXA_E, BI' +
        'CEPS_D, '
      '   BICEPS_E, TORAX)'
      'values'
      
        '  (:COD_MED, :COD_ALU, :DATA_MED, :PESO, :ABDOMEM, :COXA_D, :COX' +
        'A_E, :BICEPS_D, '
      '   :BICEPS_E, :TORAX)')
    DeleteSQL.Strings = (
      'delete from Medidas'
      'where'
      '  COD_MED = :OLD_COD_MED')
    Left = 464
    Top = 160
  end
  object qryNome: TQuery
    DatabaseName = 'Banco de Dados Academia'
    SQL.Strings = (
      'Select COD_ALU, NOME '
      'From Aluno'
      'Order By Nome')
    Left = 240
    Top = 8
  end
  object dsNome: TDataSource
    AutoEdit = False
    DataSet = qryNome
    Left = 288
    Top = 8
  end
end
