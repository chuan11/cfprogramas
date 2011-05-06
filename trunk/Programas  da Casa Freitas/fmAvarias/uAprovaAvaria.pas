unit uAprovaAvaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, TFlatButtonUnit, adLabelEdit, funcsql,funcoes,
  DBCtrls, adLabelDBMemo, adLabelMemo,ADODB;

type
  TfmAprovaAv = class(TForm)
    Label1: TLabel;
    lbNumAvaria: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    BitBtn1: TFlatButton;
    chAprova: TfsCheckBox;
    lbUo: TLabel;
    mmObs: TfsMemo;
    Label6: TLabel;
    lbUsAprovador: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAprovaAv: TfmAprovaAv;

implementation

uses uAvarias, uMain;

{$R *.dfm}

procedure TfmAprovaAv.FormCreate(Sender: TObject);
begin
   lbNumAvaria.Caption := fmCadAvarias.lbNumAvaria.Caption;
   lbLoja.caption := fmCadAvarias.lbLoja.caption;
   lbuo.Caption := fmCadAvarias.lbuo.Caption;

   mmObs.Lines.add( funcSQL.GetValorWell('O','Select observacao from zcf_avarias where numAvaria = ' + lbNumAvaria.Caption +' and loja = '+ lbuo.Caption , 'observacao',fmMain.conexao )
                  );

   if funcSQL.GetValorWell('O','Select ehAprovada from zcf_avarias where numAvaria = ' + lbNumAvaria.Caption +' and loja = '+ lbuo.Caption, 'ehAprovada', fmMain.conexao ) = '1' then
      chAprova.Checked := true;


end;

procedure TfmAprovaAv.BitBtn1Click(Sender: TObject);
var
  Aprovar:String;
  dtAprovacao:string;
  msg:string;
  i:integer;
begin
   for i:= 0 to mmObs.Lines.Count -1 do
      msg := msg + mmObs.Lines[i] + '      ';

   aprovar := '0';
   dtAprovacao := 'null';

   if chAprova.Checked = true then
   begin
      aprovar := '1';
      dtAprovacao := funcoes.StrToSqlDate(DaTeToStr(now));

      if lbUo.Caption <> '10033674' then
      begin
         if msgTela(application.Title, 'Deseja fazer o acerto dos estoques para os valores que estão listados nesta avaria?'+#13+ ' Só serão acertados os valores com estoque na loja menor que a quantidade da avaria.', mb_yesNo + mb_iconquestion) = mrYes then
            AcertaQuantidadeItens(lbUo.Caption, {cd_pes walter } lbUsAprovador.Caption , fmCadAvarias.QrItens, fmMain.conexao )
      end
      else
         msgTela('','Não faço acertos de estoque dentro da loja cd', mb_iconError+Mb_Ok);

   end;

   GetValorWell( 'E', 'Update zcf_avarias set Ehaprovada = '+ aprovar + ' , DataAprovacao = '+ dtAprovacao + ' , Observacao = '+  QuotedStr(msg) + ' where  numAvaria = ' + lbNumAvaria.Caption  + ' and loja = ' +fmCadAvarias.lbuo.Caption  , '@@error', fmMain.conexao);

   fmCadAvarias.CarregarCabecalhoAvarias(sender, lbNumAvaria.Caption, lbUo.Caption );
   fmCadAvarias.CarregaItensAvarias(sender,lbNumAvaria.Caption, lbUo.Caption );
   fmCadAvarias.QrItens.First;
   fmAprovaAv.Close;
end;

procedure TfmAprovaAv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmCadAvarias.CarregarCabecalhoAvarias(sender, lbNumAvaria.Caption, lbUo.Caption );
   fmCadAvarias.CarregaItensAvarias(Sender, lbNumAvaria.Caption, lbUo.Caption );
end;


end.
