unit uDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PrinterMatrix, ExtCtrls, Spin, ComCtrls ;

type
  TForm1 = class(TForm)
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    seLinhas: TSpinEdit;
    cbPapel: TComboBox;
    cbPorta: TComboBox;
    edtTexto: TEdit;
    cbAlinhar: TComboBox;
    seColuna: TSpinEdit;
    cbTipoLetra: TComboBox;
    cbNegrito: TComboBox;
    edtTitulo: TEdit;
    edtSubtitulo: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    edtNome: TEdit;
    edtEndereco: TEdit;
    edtCidade: TEdit;
    edtCnpj: TEdit;
    edtIe: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    PrinterBobbin1: TPrinterBobbin;
    PrinterMatrix1: TPrinterMatrix;
    Label19: TLabel;
    Bevel3: TBevel;
    btOnLine: TButton;
    btStart: TButton;
    btPrint: TButton;
    btEject: TButton;
    btTerminate: TButton;
    Bevel4: TBevel;
    procedure btStartClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btTerminateClick(Sender: TObject);
    procedure PrinterMatrix1Terminate(Sender: TObject);
    procedure PrinterMatrix1Error(Sender: TObject; MessageError: String);
    procedure PrinterMatrix1Started(Sender: TObject; Port: String);
    procedure FormCreate(Sender: TObject);
    procedure btOnLineClick(Sender: TObject);
    procedure cbAlinharChange(Sender: TObject);
    procedure btEjectClick(Sender: TObject);
    procedure seLinhasChange(Sender: TObject);
    procedure cbNegritoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.btStartClick(Sender: TObject);
begin
	with PrinterMatrix1 do begin
		Paper := TPaper( cbPapel.ItemIndex );
     Port  := TPorts( cbPorta.ItemIndex );
		Start;
  end;
end;

procedure TForm1.btPrintClick(Sender: TObject);
begin
	with PrinterMatrix1 do begin
     Alignment    := TAlignment( cbAlinhar.ItemIndex );
		FontType     := TFontType( cbTipoLetra.ItemIndex );
		Bold			 := cbNegrito.ItemIndex=0;

     Print(edtTexto.Text, seColuna.Value);
  end;
end;

procedure TForm1.btTerminateClick(Sender: TObject);
begin
	PrinterMatrix1.Terminate;
end;

procedure TForm1.PrinterMatrix1Terminate(Sender: TObject);
begin
	ShowMessage( 'Terminou a impressão' );
end;

procedure TForm1.PrinterMatrix1Error(Sender: TObject;
  MessageError: String);
begin
	ShowMessage('HOUVE UM ERRO: '+MessageError);
end;

procedure TForm1.PrinterMatrix1Started(Sender: TObject; Port: String);
begin
	ShowMessage('A impressora foi iniciada na Porta:'+Port);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	PageControl1.ActivePage := TabSheet1;
  
	cbPorta.ItemIndex := 0;
  cbPapel.ItemIndex := 0;
  cbTipoLetra.ItemIndex := 0;
  cbAlinhar.ItemIndex := 0;
  cbNegrito.ItemIndex := 1;
  edtTexto.Text := 'Uma linha com um Texto qualquer';
end;

procedure TForm1.btOnLineClick(Sender: TObject);
begin
	if PrinterMatrix1.PrinterOnLine( TPorts(cbPorta.ItemIndex) ) then
  	ShowMessage('A Porta '+cbPorta.Text+' esta OK')
  else
  	ShowMessage('A Porta '+cbPorta.Text+' não está respondendo.');
end;

procedure TForm1.cbAlinharChange(Sender: TObject);
begin
	// se nao for à Esquerda, TPrinterMatrix não levará em conta a coluna
  // que você enviar
	seColuna.Enabled := cbAlinhar.ItemIndex=0;
end;           

procedure TForm1.btEjectClick(Sender: TObject);
begin
	// Não faz muito sentido você enviar um 'Eject' caso esteja usando 'Bobinas'
	PrinterMatrix1.Eject;
end;

procedure TForm1.seLinhasChange(Sender: TObject);
begin
	PrinterMatrix1.AdvanceLines := seLinhas.Value;
end;

procedure TForm1.cbNegritoChange(Sender: TObject);
begin
	PrinterMatrix1.Bold := cbNegrito.ItemIndex=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
	D: TEmpresa;
  R: TRodape;
begin
	{ **** ajustes iniciais **** }
  with PrinterBobbin1 do begin
  	AdvanceLines := seLinhas.value;
     Paper := paBobbin75; // largura da bobina 75mm
     Port  := TPorts( cbPorta.ItemIndex );
  end;

	{ Dados para a impressão do TOP da bobina }
	D.Nome 			 := edtNome.Text;
  D.Endereco 		 := edtEndereco.Text;
  D.Cidade_UF_Cep := edtCidade.Text;
  D.Cnpj 			 := edtCnpj.Text;
  D.Ie 				 := edtIe.Text;
  D.email 			 := edtEmail.Text;
  D.Telefone 		 := edtTelefone.Text;

  { Dados para a impressão do BOTTOM da bobina }
  R.Autor := 'jnolasco@com4.com.br';
  R.Mensagem[1] := 'Aqui você pode colocar';
  R.Mensagem[2] := 'qualquer tipo de mensagem';
  R.Mensagem[3] := '';
  R.Mensagem[4] := 'Exemplos:';
  R.Mensagem[5] := 'Feliz Aniversário';
  R.Mensagem[6] := 'Feliz Ano Novo';
  R.Mensagem[7] := 'Obrigado e Volte Sempre';
  R.Mensagem[8] := '';
  R.Mensagem[9] := 'Confira nossas ofertas';
  R.Mensagem[10] := 'etc';


	{ a Impressão... }
	with PrinterBobbin1 do begin
  	PrintTop(D,edtTitulo.Text,edtSubtitulo.Text);

     Alignment := taLeft;
     FontType := ftCondensed;

     Print('   nr venda   dt venda   valor unit');
     Print('   ========  ==========  ==========');

     //==== 1a. venda
     Print('09923',5,false);
     Print('12/01/2001',13,false);
     Print(   format('%10.2m',[12.22])   ,25,true);

     //==== 2a. venda
     Print('12333',5,false);
     Print('15/01/2001',13,false);
     Print(   format('%10.2m',[122.10])  ,25, true);

     // e assim por diante...

     PrintBottom(R); // já encerra o boleto e avança as linhas "caso tenha"
	end;
end;

end.
                   



