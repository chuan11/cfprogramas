unit uNovaProposta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, ExtCtrls, StdCtrls, adLabelComboBox,funcSQL,funcoes,
  adLabelEdit;

type
  TfmNovaProposta = class(TForm)
    cbPreco: TadLabelComboBox;
    pnConfirma: TPanel;
    BitBtn1: TFlatButton;
    FlatButton1: TFlatButton;
    edNumPedido: TadLabelEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNovaProposta: TfmNovaProposta;
//   LOJA:STRING;
implementation
uses uPropostaLoja, umain;
{$R *.dfm}

procedure TfmNovaProposta.FormShow(Sender: TObject);
begin
   cbPreco.Items := funcSQl.getListaPrecos( fmMain.Conexao, false,false, false, fmMain.getGrupoLogado() );
end;

procedure TfmNovaProposta.BitBtn1Click(Sender: TObject);
begin
   if (cbpreco.ItemIndex > -1 ) then
   begin
      fmProposta.CriarTabelaProposta(Sender);
      preco:= funcoes.SohNumeros(copy(cbPreco.Items[cbpreco.ItemIndex],50,50));

      if edNumPedido.Text <> '' then
         fmProposta.ImportaDadosPedido(sender,edNumPedido.Text);

      fmProposta.gb1.Enabled := true;
      FlatButton1Click(Sender);
   end
   else
   msgTela('', ' Escolha o Preço para inciar a proposta. ', mb_IconError +mb_ok);
end;

procedure TfmNovaProposta.FlatButton1Click(Sender: TObject);
begin
   fmNovaProposta.Close;
end;

procedure TfmNovaProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := CaFree;
end;

end.
