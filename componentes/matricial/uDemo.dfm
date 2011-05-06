object Form1: TForm1
  Left = 270
  Top = 119
  Width = 539
  Height = 355
  Caption = 'Exemplo de uso do componente TPrinterMatrix'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 392
    Top = 293
    Width = 103
    Height = 13
    Caption = 'por: Jeferson Nolasco'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12550411
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 408
    Top = 309
    Width = 111
    Height = 13
    Caption = 'jnolasco@com4.com.br'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12550411
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 14
    Top = 292
    Width = 308
    Height = 27
    AutoSize = False
    Caption = 
      'eu entrego o código fonte deste componente gratuitamente, leia o' +
      ' arquivo ReadMe.htm para maiores informações.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8487246
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object PageControl1: TPageControl
    Left = 10
    Top = 8
    Width = 512
    Height = 285
    ActivePage = TabSheet2
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'componente TPrinterMatrix'
      object Bevel2: TBevel
        Left = 8
        Top = 72
        Width = 393
        Height = 177
        Shape = bsFrame
      end
      object Bevel1: TBevel
        Left = 8
        Top = 8
        Width = 393
        Height = 61
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 17
        Top = 79
        Width = 166
        Height = 28
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Ao Término da impressão, Avançar quantas Linhas ?'
        WordWrap = True
      end
      object Label2: TLabel
        Left = 17
        Top = 42
        Width = 192
        Height = 13
        Caption = 'Em qual Tipo de Papel você irá Imprimir?'
      end
      object Label3: TLabel
        Left = 17
        Top = 18
        Width = 182
        Height = 13
        Caption = 'A impressora está conectada na porta:'
      end
      object Label4: TLabel
        Left = 16
        Top = 208
        Width = 112
        Height = 13
        Caption = 'Texto para imprimir:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 106
        Top = 114
        Width = 77
        Height = 13
        Caption = 'Alinhar o Texto?'
      end
      object Label6: TLabel
        Left = 104
        Top = 179
        Width = 79
        Height = 13
        Caption = 'Em qual coluna?'
      end
      object Label7: TLabel
        Left = 117
        Top = 157
        Width = 66
        Height = 13
        Caption = 'Tipo da Letra:'
      end
      object Label10: TLabel
        Left = 87
        Top = 135
        Width = 96
        Height = 13
        Caption = 'Imprime em Negrito?'
      end
      object Bevel4: TBevel
        Left = 0
        Top = 0
        Width = 504
        Height = 254
        Align = alClient
        Shape = bsFrame
      end
      object seLinhas: TSpinEdit
        Left = 193
        Top = 88
        Width = 145
        Height = 22
        Color = 14342850
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = seLinhasChange
      end
      object cbPapel: TComboBox
        Left = 217
        Top = 38
        Width = 174
        Height = 21
        Style = csDropDownList
        Color = 14342850
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'Tipo Bobina 75mm'
          'Tipo Bobina 89mm'
          'Tipo Carta (formulário contínuo)')
      end
      object cbPorta: TComboBox
        Left = 217
        Top = 14
        Width = 89
        Height = 21
        Style = csDropDownList
        Color = 14342850
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'LPT1'
          'LPT2'
          'LPT3'
          'LPT4'
          'LPT5')
      end
      object edtTexto: TEdit
        Left = 16
        Top = 220
        Width = 373
        Height = 21
        Color = 14342850
        TabOrder = 3
        Text = 'edtTexto'
      end
      object cbAlinhar: TComboBox
        Left = 193
        Top = 110
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = 14342850
        ItemHeight = 13
        TabOrder = 4
        OnChange = cbAlinharChange
        Items.Strings = (
          'à Esquerda'
          'Centralizar'
          'à Direita')
      end
      object seColuna: TSpinEdit
        Left = 193
        Top = 174
        Width = 145
        Height = 22
        Color = 14342850
        MaxValue = 0
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object cbTipoLetra: TComboBox
        Left = 193
        Top = 153
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = 14342850
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          'Condensada'
          'Simples (Normal)'
          'Média (exp + cond)'
          'Expandida')
      end
      object cbNegrito: TComboBox
        Left = 193
        Top = 131
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = 14342850
        ItemHeight = 13
        TabOrder = 7
        OnChange = cbNegritoChange
        Items.Strings = (
          'Sim'
          'Não')
      end
      object btOnLine: TButton
        Left = 414
        Top = 48
        Width = 75
        Height = 25
        Hint = 'verifica se a porta está respondendo'
        Caption = 'On Line ?'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = btOnLineClick
      end
      object btStart: TButton
        Left = 414
        Top = 87
        Width = 75
        Height = 25
        Hint = 'Inicia "abre" a porta'
        Caption = 'Start'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = btStartClick
      end
      object btPrint: TButton
        Left = 414
        Top = 126
        Width = 75
        Height = 25
        Hint = 'imprime uma linha de texto'
        Caption = 'Print'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = btPrintClick
      end
      object btEject: TButton
        Left = 414
        Top = 164
        Width = 75
        Height = 25
        Hint = 'só faz sentido se for Papel=Letter'
        Caption = 'Eject'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnClick = btEjectClick
      end
      object btTerminate: TButton
        Left = 414
        Top = 203
        Width = 75
        Height = 25
        Hint = 'termina a impressão e "fecha" a porta'
        Caption = 'Terminate'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = btTerminateClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'componente TPrinterBobbin'
      ImageIndex = 1
      object Bevel3: TBevel
        Left = 0
        Top = 0
        Width = 504
        Height = 254
        Align = alClient
        Shape = bsFrame
      end
      object Label19: TLabel
        Left = 14
        Top = 10
        Width = 475
        Height = 31
        AutoSize = False
        Caption = 
          'o componente TPrinterBobbin é descendente do TPrinterMatrix, sen' +
          'do assim, herda todas as propriedades e funções de seu descenden' +
          'te.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtTitulo: TEdit
        Left = 28
        Top = 222
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Título'
      end
      object edtSubtitulo: TEdit
        Left = 164
        Top = 222
        Width = 201
        Height = 21
        TabOrder = 1
        Text = 'Subtítulo'
      end
      object Button1: TButton
        Left = 28
        Top = 186
        Width = 337
        Height = 25
        Caption = 'imprime Bobina 75 mm'
        TabOrder = 2
        OnClick = Button1Click
      end
      object GroupBox1: TGroupBox
        Left = 15
        Top = 62
        Width = 370
        Height = 109
        Caption = 'Dados da Empresa'
        TabOrder = 3
        object Label12: TLabel
          Left = 53
          Top = 18
          Width = 31
          Height = 13
          Caption = 'Nome:'
        end
        object Label13: TLabel
          Left = 35
          Top = 32
          Width = 49
          Height = 13
          Caption = 'Endereço:'
        end
        object Label14: TLabel
          Left = 8
          Top = 46
          Width = 76
          Height = 13
          Caption = 'Cidade/Uf/Cep:'
        end
        object Label15: TLabel
          Left = 60
          Top = 60
          Width = 24
          Height = 13
          Caption = 'Cnpj:'
        end
        object Label16: TLabel
          Left = 216
          Top = 60
          Width = 19
          Height = 13
          Caption = 'I.E.:'
        end
        object Label17: TLabel
          Left = 54
          Top = 74
          Width = 30
          Height = 13
          Caption = 'e-mail:'
        end
        object Label18: TLabel
          Left = 42
          Top = 88
          Width = 42
          Height = 13
          Caption = 'Telefone'
        end
        object edtNome: TEdit
          Left = 88
          Top = 18
          Width = 273
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 0
          Text = 'ROLOS & TRAMBIQUES LTDA'
        end
        object edtEndereco: TEdit
          Left = 88
          Top = 32
          Width = 273
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 1
          Text = 'Rua Cel. Xavier de Toledo, 1092'
        end
        object edtCidade: TEdit
          Left = 88
          Top = 46
          Width = 273
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 2
          Text = 'São Paulo / SP / 03.309-093'
        end
        object edtCnpj: TEdit
          Left = 88
          Top = 60
          Width = 121
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 3
          Text = '032.098.001/0001-09'
        end
        object edtIe: TEdit
          Left = 240
          Top = 60
          Width = 121
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 4
          Text = '209.099.001-09me'
        end
        object edtEmail: TEdit
          Left = 88
          Top = 74
          Width = 273
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 5
          Text = 'jnolasco@com4.com.br'
        end
        object edtTelefone: TEdit
          Left = 88
          Top = 88
          Width = 273
          Height = 13
          BorderStyle = bsNone
          Color = 14020093
          TabOrder = 6
          Text = '(0xx11) 2209-0911'
        end
      end
    end
  end
  object PrinterBobbin1: TPrinterBobbin
    Port = LPT1
    FontType = ftCondensed
    Alignment = taLeft
    Paper = paBobbin75
    Bold = False
    Left = 228
    Top = 128
  end
  object PrinterMatrix1: TPrinterMatrix
    Port = LPT1
    FontType = ftCondensed
    Alignment = taLeft
    Paper = paBobbin75
    Bold = False
    OnTerminate = PrinterMatrix1Terminate
    OnStarted = PrinterMatrix1Started
    OnError = PrinterMatrix1Error
    Left = 200
    Top = 128
  end
end
