unit uNovaContagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, adLabelEdit, funcoes, adLabelNumericEdit,
  adLabelSpinEdit;

type
  TfmNovaContagem = class(TForm)
    cbCritQt: TfsCheckBox;
    cbContund: TfsCheckBox;
    cbLimpaDados: TfsCheckBox;
    ednColetor: TadLabelSpinEdit;
    cbConfItemSemCadastro: TfsCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure limpaContagem();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNovaContagem: TfmNovaContagem;

implementation

uses uColetaContagem;

{$R *.dfm}

procedure TfmNovaContagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.carregaParametros();
   action := CaFree;
   fmNovaContagem := nil;
end;

procedure TfmNovaContagem.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if msgTela2('','Confirma contagem com esses parametros?', MB_YESNO) = mrOk then
   begin
      funcoes.WParReg('coletor','nomeColetor', ednColetor.text);
      WParRegBolean('coletor','ACEITA_PROD_INVALIDO',cbCritQt.Checked);
      WParRegBolean('coletor','ContagemUnitaria',cbContund.Checked);
      WParRegBolean('coletor','confirmaItemNaoCadastrado',cbConfItemSemCadastro.Checked);
      ACEITA_PROD_INVALIDO := cbCritQt.Checked;
      CONTAGEM_UNITARIA := cbContund.Checked;
      if (cbLimpaDados.Checked = true )then
      begin
         ULTIMO_NUM_LOTE := '1';
         limpaContagem();
      end;
      fmMain.habilitaItens();
   end
   else
   CanClose := false;
end;

procedure TfmNovaContagem.FormActivate(Sender: TObject);
begin
   ednColetor.Text := funcoes.RParReg('coletor','nomeColetor');
   cbCritQt.Checked := RParRegBool('coletor','ACEITA_PROD_INVALIDO');
   cbContund.Checked := RParRegBool('coletor','ContagemUnitaria');
   cbConfItemSemCadastro.Checked := RParRegBool('coletor','confirmaItemNaoCadastrado');
end;

procedure TfmNovaContagem.limpaContagem;
var
  arq:TstringList;
begin
   arq := TStringList.Create();
   arq.SaveToFile(ARQ_CONTAGEM);
   arq.Destroy();
end;

end.
