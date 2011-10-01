unit fmMudaSerieNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, adLabelComboBox, TFlatButtonUnit, DB;

type
  TfmAjustaSerie = class(TForm)
    cbLoja: TadLabelComboBox;
    Panel1: TPanel;
    cbTipoSerie: TadLabelComboBox;
    btOk: TFlatButton;
    FlatButton1: TFlatButton;
    procedure FormActivate(Sender: TObject);
    procedure consultaTipoEmissaoNota();
    procedure cbLojaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaSerie: TfmAjustaSerie;

implementation

uses uMain, funcoes, funcSQL, uCF;

{$R *.dfm}

procedure TfmAjustaSerie.FormActivate(Sender: TObject);
begin
   uCF.getListaLojas(cbLoja, false, false, '');
   cbLoja.ItemIndex := -1;
end;


procedure TfmAjustaSerie.cbLojaChange(Sender: TObject);
begin
   consultaTipoEmissaoNota();
end;

procedure TfmAjustaSerie.consultaTipoEmissaoNota;
var
   srNormal, srCont, cmd:String;
   ds:TDataSet;
begin
   srNormal := funcSQL.getParamBD('ServerNFE.SrNfe', funcoes.getCodUO(cbLoja), fmMain.Conexao);
   srCont := funcSQL.getParamBD('ServerNFE.SrNfeCont', funcoes.getCodUO(cbLoja), fmMain.Conexao);
   cmd :=
   ' select sr_nf from topsef  where  sq_opf in( select sq_opf  from topi where ds_res like ''nf%'') '+
   ' and  is_loja= ' + funcoes.getCodUO(cbLoja) ;
   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   ds.First();
   if (ds.FieldByName('sr_nf').AsString = srNormal) then
     cbTipoSerie.ItemIndex := 0
   else    if (ds.FieldByName('sr_nf').AsString = srCont) then
     cbTipoSerie.ItemIndex := 1
   else
     cbTipoSerie.ItemIndex := -1;
   panel1.Visible:= true;
end;



procedure TfmAjustaSerie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmAjustaSerie := nil;
end;

procedure TfmAjustaSerie.FlatButton1Click(Sender: TObject);
var
  cmd, tpEmissao:String;

begin
   if cbTipoSerie.ItemIndex = 0 then
      tpEmissao :=  funcSQL.getParamBD('ServerNFE.SrNfe', funcoes.getCodUO(cbLoja), fmMain.Conexao)
   else
      tpEmissao :=  funcSQL.getParamBD('ServerNFE.SrNfeCont', funcoes.getCodUO(cbLoja), fmMain.Conexao);

   cmd := ' update topsef set sr_nf=' + quotedStr(tpEmissao) +' where' +
          ' sq_opf in( select sq_opf  from topi where ds_res like ''nf%'') and' +
          ' is_loja= '+ funcoes.getCodUO(cbLoja);
   funcSQL.execSQL(cmd, fmMain.Conexao);


   if cbTipoSerie.ItemIndex = 0 then
      tpEmissao := 'NFe.SetFormaEmissao(1)'
   else
      tpEmissao := 'NFe.SetFormaEmissao(3)';

   fmMain.executeTelnetCmd(funcoes.getCodUO(cbLoja), tpEmissao );


   funcoes.msgTela('','Essa alteração só vai funcionar depois da estação na loja '+
              'na proxima vez que a estação que emite a nota entrar no well',
              MB_ICONWARNING + mb_ok);

  btOkClick(nil);
end;

procedure TfmAjustaSerie.btOkClick(Sender: TObject);
begin
   panel1.Visible := false;
   cbTipoSerie.ItemIndex := -1;
   cbLoja.ItemIndex := -1;
end;

end.
