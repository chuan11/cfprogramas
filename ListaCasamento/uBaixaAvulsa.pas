unit uBaixaAvulsa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcsql,
  Dialogs, ExtCtrls, Grids, DBGrids, SoftDBGrid, adLabelNumericEdit,  funcoes,
  adLabelDBNumericEdit, Mask, DBCtrls, adLabelDBEdit, db,
  adLabelDBLookupComboBox, StdCtrls, adLabelEdit, TFlatButtonUnit,
  adLabelComboBox, ComCtrls, fCtrls, adLabelSpinEdit;

type
  TfmBaixaAvulsa = class(TForm)
    gpProdutos: TGroupBox;
    edCodProd: TadLabelEdit;
    edDesc: TadLabelEdit;
    edValor: TadLabelNumericEdit;
    gb: TGroupBox;
    edEndereco: TadLabelEdit;
    edBairro: TadLabelEdit;
    edReferencia: TadLabelEdit;
    edFone: TadLabelEdit;
    edObservacao: TadLabelEdit;
    btOk: TFlatButton;
    btClose: TFlatButton;
    cbTipo: TadLabelComboBox;
    edNome: TadLabelEdit;
    edConvidado: TadLabelEdit;
    dtEvento: TfsDateTimePicker;
    Label1: TLabel;
    cbIsPromocao: TfsCheckBox;
    edDesconto: TadLabelSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCodProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure cbIsPromocaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBaixaAvulsa: TfmBaixaAvulsa;

implementation

uses Unit3,unit1;

{$R *.dfm}

procedure TfmBaixaAvulsa.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
    fmBaixaAvulsa := nil;
    action := CaFree;
end;

procedure TfmBaixaAvulsa.edCodProdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ds:TdataSet;
begin
   if key = VK_RETURN THEN
   begin
      ds := form3.obterDadosDoProduto(nil, edCodProd.Text);
      if ds <> nil then
      begin
         edCodProd.Text:= ds.fieldByname('codigo').asString;
         edDesc.text := ds.fieldByname('descricao').asString;
         edValor.Value := ds.fieldByname('PRECO').asfLOAT;
         ds.Destroy();
      end;
   end;
end;

procedure TfmBaixaAvulsa.btCloseClick(Sender: TObject);
begin
   fmBaixaAvulsa.Close();
end;

procedure TfmBaixaAvulsa.FormCreate(Sender: TObject);
begin
   cbTipo.Items := funcsql.getListagem(  'select * from tipoProdutos', form1.ADOConnection1);
   cbTipo.ItemIndex := 0;
   dtEvento.Date := now;
end;

procedure TfmBaixaAvulsa.btOkClick(Sender: TObject);
var
  isDesconto, seq,nLista,erro:String;
begin
   erro := '';
   if edCodProd.Text = '' then
      erro := erro + ' - Falta o código do produto.' +#13;

   if edDesc.Text = '' then
      erro := erro + ' - Falta a descrição do produto.' +#13;

   if edValor.Value = 0 then
      erro := erro + ' - Falta o preço do produto.' +#13;

   if length(edNome.Text) < 5 then
      erro := erro + ' - Falta o nome do ganhador do presente.' +#13;

   if length(edConvidado.Text) < 5 then
      erro := erro + ' - Falta o nome do convidado.' +#13;

   if length(edEndereco.Text) < 5 then
      erro := erro + ' - Falta o endereço de entrega.' +#13;

   if length(edBairro.Text) < 5 then
      erro := erro + ' - Falta o bairro de entrega.' +#13;

   if length(edReferencia.Text) < 5 then
      erro := erro + ' - Falta o ponto de referência da entrega.' +#13;

   if length(edFone.Text) < 5 then
      erro := erro + ' - Falta o ponto de referência da entrega.' +#13;

   if (cbIsPromocao.Checked = true) and ( edDesconto.Text =  '0'  ) then
      erro := erro + ' - Informe o percentual de desconto. ' +#13;

   if (erro <> '') then
      msgTela('', ' Corrija antes esses erros: ' +  erro ,  MB_OK + MB_ICONERROR)
   else
   begin
      if (cbIsPromocao.Checked = true) then
        isDesconto := '1'
      else
        isDesconto := '0';

      nLista := form1.GetParamBD('NumeroDaListaAvulsa', '');
      execSQL('insert produtos (numlista,codigo,nomeProduto,tipo,ljbaixa, valor,dtCompra,convidado, obsItem, isPromocao, desconto) values( ' +
                                      nLista +' ,  '+
                                      quotedStr(edCodProd.Text) +' ,  '+
                                      quotedStr(copy(edDesc.Text,01,40)) +' ,  '+
                                      quotedStr(cbTipo.Items[cbTipo.ItemIndex]) +' ,  '+
                                      quotedStr(form1.RParReg('Loja')) +' ,  '+
                                      valorSql(edValor.Text)        +' ,  '+
                                      DateTimeToSqlDateTime(now,'') + ' , ' +
                                      quotedstr(edConvidado.Text)   +' , ' +
                                      quotedStr(edObservacao.Text)  +' , ' +
                                      quotedStr(isDesconto)         +' , ' +
                                      quotedStr(edDesconto.Text) +
                                      ' )'

       , Form1.adoConnection1   );

   seq :=  funcsql.openSQL(' select IDENT_CURRENT(''produtos'') as valor ', 'valor',  form1.ADOConnection1);
   execSql('insert entregas(seqProduto, EndEntrega,bairro, endReferencia, fone, noiva, dataCasamento )  values( '
                                     + seq + ' , '
                                     + quotedstr(edEndereco.Text) + ' , '
                                     + quotedstr(edBairro.Text)   + ' , '
                                     + quotedstr(edReferencia.Text) + ' , '
                                     + quotedstr(edFone.Text) +' , '
                                     + quotedstr(edNome.Text) +' , '
                                     + funcoes.DateTimeToSqlDateTime(dtEvento.date,'') +
                                      ' ) ' ,Form1.ADOConnection1);
      form3.preparaParaBaixaAvulsa(nil);
      btCloseClick(nil);
   end;
end;

procedure TfmBaixaAvulsa.cbIsPromocaoClick(Sender: TObject);
begin
   if (cbIsPromocao.Checked = true) then
      edDesconto.Visible := true
   else
      edDesconto.Visible := false;
end;

end.
