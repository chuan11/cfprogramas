unit uRelGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ComCtrls, StdCtrls, TFlatButtonUnit, adLabelComboBox,
  Grids, DBGrids, fCtrls;

type
  TfmRelGeral = class(TForm)
    cbLojas: TadLabelComboBox;
    btOk: TFlatButton;
    GroupBox1: TGroupBox;
    dti: TDateTimePicker;
    dtf: TDateTimePicker; qr: TADOQuery;
    Label1: TLabel;
    qris_uo: TIntegerField;
    qrds_uo: TStringField;
    qrcd_ref: TStringField;
    qrds_ref: TStringField;
    qrpedido: TIntegerField;
    qrqt: TIntegerField;
    qrund: TBCDField;
    qrtVenda: TBCDField;
    qrpcVarejo: TBCDField;
    qrtVarejo: TBCDField;
    qrcmu: TBCDField;
    qrtCMU: TBCDField;
    qrDifCMU: TBCDField;
    qrDifVenda: TBCDField;
    qrprejuizo: TBCDField;
    tbValoresAvarias: TADOTable;
    tbValoresAvariasis_uo: TStringField;
    tbValoresAvariasds_uo: TStringField;
    tbValoresAvariasTipoAvaria: TStringField;
    tbValoresAvariasqtItens: TIntegerField;
    tbValoresAvariasvalorTotalCusto: TBCDField;
    tbValoresAvariasvalorTotalPcVarejo: TBCDField;
    tbValoresAvariasTotalVendido: TBCDField;
    tbValoresAvarias_Total: TADOTable;
    tbValoresAvarias_TotaltipoAvaria: TStringField;
    tbValoresAvarias_TotalqtItens: TIntegerField;
    tbValoresAvarias_TotalvalorTotalCusto: TBCDField;
    tbValoresAvarias_TotalvalorTotalVenda: TBCDField;
    cbDetAvaForn: TfsCheckBox;
    tbValoresAvariasFornecedor: TStringField;
    tbValoresAvarias_Totalfornecedor: TStringField;
    cbCaixas: TadLabelComboBox;
    tbPreviaDeCaixa: TADOTable;
    tbPreviaDeCaixacodLoja: TIntegerField;
    tbPreviaDeCaixadescEstacao: TStringField;
    tbPreviaDeCaixacd_mve: TIntegerField;
    tbPreviaDeCaixads_mve: TStringField;
    tbPreviaDeCaixadataSessaoCaixa: TDateTimeField;
    tbPreviaDeCaixaseqtransacaoCaixa: TIntegerField;
    tbPreviaDeCaixaseqModPagtoPorTransCaixa: TIntegerField;
    tbPreviaDeCaixaValor: TBCDField;
    tbPreviaDeCaixanumParcelas: TStringField;
    tbPreviaDeCaixatefMagnetico: TStringField;
    tbPreviaDeCaixaseqTefTransCaixa: TIntegerField;
    tbPreviaDeCaixacd_tpm: TStringField;
    tbOperadores: TADOTable;
    tbTotRec: TADOTable;
    tbSangrias: TADOTable;
    tbPreviaDeCaixatp_mve: TStringField;
    tbTotReccd_mve: TStringField;
    tbTotRecvalor: TBCDField;
    tbSangriascd_mve: TStringField;
    tbSangriasvalor: TBCDField;
    tbVendasCartao: TADOTable;
    tbVendasCartaocodLoja: TIntegerField;
    tbVendasCartaocd_mve: TIntegerField;
    tbVendasCartaods_mve: TStringField;
    tbVendasCartaoseqTransacaoCaixa: TIntegerField;
    tbVendasCartaovalor: TBCDField;
    tbVendasCartaonumparcelas: TIntegerField;
    tbVendasCartaotp_mve: TStringField;
    tbVendasCartaotefMagnetico: TStringField;

    function getParametrosRelatorioAvarias():TstringList;
    procedure ajustaTelaParaAvarias();
    procedure ajustaTelaParaCargaConciliacao();
    procedure produtosTransferidosAjustaTela();
    procedure produtosTransferidosGeraLista();    
    procedure ajustaTelaParaRelCartoes();
    procedure btOkClick(Sender: TObject);
    procedure calCulaTotalAvariasPorFornecedor();
    procedure calCulaTotalAvariasPorLoja();
    procedure calCulaValoresAvarias();
    procedure cargaDadosConciliacao();
    procedure cbLojasClick(Sender: TObject);
    procedure dtiChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure gerarVendaAvarias();
    procedure getDescCaixas();
    procedure listaVendasEmCartao();
    procedure setPerfil(p:integer);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelGeral: TfmRelGeral;
  PERFIL:integer;
  IS_GRUPO_PERMITIDO_CARTAO:boolean;
  
implementation
uses uMain, uCF, funcoes, funcsql;

{$R *.dfm}


procedure TfmRelGeral.ajustaTelaParaAvarias;
begin
   fmMain.getListaLojas( cbLojas, true, false, fmMain.getCdPesLogado() );
   fmRelGeral.caption := 'Valores totais de avarias.';
   cbDetAvaForn.visible := true;
   cbCaixas.visible := false;
end;

function TfmRelGeral.getParametrosRelatorioAvarias: TstringList;
var
  params:TstringList;
begin
   params := TStringList.Create();
   params.Add( dateToStr(dti.date));
   params.Add( dateToStr(dtf.date));
   params.Add( fmMain.getNomeLojaLogada() );
   params.Add( fmMain.getNomeUsuario() );
   result := params;
end;


procedure TfmRelGeral.calCulaTotalAvariasPorFornecedor();
var
   params:TStringList;
begin
// Lista as avarias
   uCF.calculaTotaisAvariasPorFornecedor( tbValoresAvarias, cbLojas, dti.date, dtf.date);

// carrega os partametros
   params := getParametrosRelatorioAvarias();

// calcular o total de avarias por fornecedor
   uCF.getTotaisAvariasPorFornecedor(tbValoresAvarias_Total,  tbValoresAvarias.TableName);

// calcular o percentual de cada fornecedor
   calCulaPercentualDoFornecedor(tbValoresAvarias_Total);

   fmMain.impressaoRaveQr4(tbValoresAvarias, tbValoresAvarias_Total, nil, nil, 'rpValoresAvariasPorForn', params )
end;

procedure TfmRelGeral.calCulaTotalAvariasPorLoja();
var
   params:TStringList;
begin
// calcular os totais por loja
   uCF.calculaTotaisAvariasPorLoja(tbValoresAvarias, cbLojas, dti.date, dtf.date);

   params :=  getParametrosRelatorioAvarias();

// pegar o total de venda
   params.Add( uCF.getTotaisVendaAvaria(cbLojas, dti.Date, dtf.Date, tbValoresAvarias.TableName) );

//  pegar os totais por tipo para colocar no resumo
   uCF.getTotaIsPorTipoDeAvaria( tbValoresAvarias_Total,  tbValoresAvarias.TableName);

   if( tbValoresAvarias.RecordCount > 0) then
      fmMain.impressaoRaveQr4( tbValoresAvarias, tbValoresAvarias_Total, nil, nil, 'rpValoresAvarias', params )
   else
      msgTela('','Sem valores para consulta.', MB_ICONERROR+MB_OK);
end;

procedure TfmRelGeral.calCulaValoresAvarias;
begin
  if (cbDetAvaForn.Checked = false ) then
     calCulaTotalAvariasPorLoja()
  else
    calCulaTotalAvariasPorFornecedor();
end;

procedure TfmRelGeral.gerarVendaAvarias();
var
  cmd:String;
  params: TStringlist;
begin
   cmd := ' Select l.is_uo,l.ds_uo, c.cd_ref,c.ds_ref, z.pedido, z.qt,' +
          ' z.und, (z.qt* z.und ) as tVenda,' +
          ' z.valorSugerido as pcVarejo , (z.qt* z.valorSugerido ) as tVarejo,' +
          ' z.cmu, (z.qt* z.cmu)as tCMU,' +
          '((z.qt* z.und ) - (z.qt* z.cmu)) as DifCMU, ' +
          '((z.qt * z.valorSugerido ) - (z.qt * z.und) ) as DifVenda,  '+
          ' case when (z.qt* z.cmu) -(z.qt* z.und ) > 0 then (z.qt* z.cmu) - (z.qt* z.und ) else 0 end as prejuizo ' +
          ' from zcf_avariasDescontos z (nolock) '+
          ' inner join crefe c (nolock) on z.is_ref = c.is_ref '+
          ' inner join zcf_tbuo l (nolock)  on z.is_uo = l.is_uo  where ' +
          ' z.data between ' + funcoes.DateTimeToSqlDateTime(dti.Date,' 00:00:00') +' and ' + funcoes.DateTimeToSqlDateTime(dtf.Date,' 23:59:00');
   if (cbLojas.ItemIndex > 0) then
      cmd := cmd + ' and z.is_uo = ' + funcoes.getNumUO(cbLojas);
   cmd := cmd + ' order by z.is_uo, z.data';

   funcsql.getQuery(fmMain.Conexao, qr , cmd);

   Params := TStringList.Create();
   params.Add( dateToStr(dti.Date ));
   params.Add( dateToStr(dtf.Date ));
   params.Add( cbLojas.Items[cbLojas.ItemIndex] );
   params.Add( fmMain.getNomeUsuario() );

   fmMain.impressaoRaveQr(qr,'rpVendaAvarias' , params );
end;

procedure TfmRelGeral.dtiChange(Sender: TObject);
begin
   dtf.Date := dti.Date;
end;

procedure TfmRelGeral.FormShow(Sender: TObject);
begin
   fmMain.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado() );
end;


procedure TfmRelGeral.getDescCaixas();
begin
   cbCaixas.Items := uCF.getDescCaixas(funcoes.getNumUO(cbLojas), IS_GRUPO_PERMITIDO_CARTAO);
   if (cbCaixas.Items.Count > 0) then
      cbCaixas.ItemIndex := 0;
end;

procedure TfmRelGeral.ajustaTelaParaRelCartoes;
begin
   label1.Visible := false;
   cbDetAvaForn.Visible := false;

   IS_GRUPO_PERMITIDO_CARTAO :=  not(fmMain.isGrupoRestrito(PERFIL));

   if (IS_GRUPO_PERMITIDO_CARTAO = false) then
   begin
      dti.MinDate :=  funcSQL.getDateBd(fmMain.Conexao)-2;
      dtf.Enabled := false;
   end;

   dti.Date := funcSQL.getDateBd( fmMain.Conexao);
   dtf.Date := dti.Date;
   getDescCaixas();
end;

procedure TfmRelGeral.ajustaTelaParaCargaConciliacao;
begin
   ajustaTelaParaRelCartoes();
   cbLojas.Visible := false;
   cbCaixas.Visible := false;
   btOk.Left := GroupBox1.Left + GroupBox1.Width + 20;
   dti.Date :=  funcSQL.getDateBd(fmMain.Conexao);
   fmRelGeral.Caption := 'Carga de vendas para concilia��o';
   fmRelGeral.WindowState := wsNormal;
end;

procedure TfmRelGeral.cbLojasClick(Sender: TObject);
begin
   if (perfil = fmMain.PagamentosEmCarto1.Tag ) then
      getDescCaixas();
end;

procedure TfmRelGeral.cargaDadosConciliacao;
begin
   msgTela('',' Se j� houver alguma carga j� feita ela ser� exclu�da.',0);
   uCF.cargaDadosConciliacao(tbPreviaDeCaixa, dti, dtf);
end;

procedure TfmRelGeral.listaVendasEmCartao;
var
   totais, param:Tstringlist;
   i:integer;
   ds:TdataSet;
begin
   param := TStringlist.Create();

   fmMain.msgStatus('Gerando previa de caixa');
   uCF.listaRecebimentosCaixa( tbPreviaDeCaixa, funcoes.getCodUO(cbLojas), funcoes.getCodCaixa(cbCaixas), dti, dtf, false, false, true );
   if (tbPreviaDeCaixa.IsEmpty = false) then
   begin
// pegar os operadores do caixa
      fmMain.msgStatus('Listando operadores');
      ucf.getOperadoresPorCaixa(tbOperadores, funcoes.getCodUO(cbLojas), funcoes.getCodCaixa(cbCaixas), dti, fmMain.conexao);

// listar os recebimentos do caixa
      fmMain.msgStatus('Agrupando recebimentos do caixa');
      ucf.getRecebDeCaixa(tbPreviaDeCaixa, tbTotRec);

//listar as sangrias do caixa
      fmMain.msgStatus('Listando sangrias de caixa');
      ucf.getSangriasDoCaixa(tbPreviaDeCaixa, tbSangrias);

// listar o odetalhe das vendas de cartao
      fmMain.msgStatus('Listando pagamentos em cart�o');
      ucf.getRecebimentosEmCartao(tbPreviaDeCaixa, tbVendasCartao);
      totais := uCF.getTotalCartaoPorModo(tbVendasCartao);

// listar as vendas estornadas
      ds:= uCF.getVendasEstornadas( funcoes.getCodUO(cblojas), funcoes.getCodCaixa(cbCaixas), dti.Date, dtf.Date);

      param.add( funcoes.getNomeUO(cbLojas) );
      param.add( funcoes.getNomeDoCx(cbCaixas) );
      param.add( dateToStr(dti.date) + ' a ' +  dateToStr(dtf.date) );
      param.add( fmMain.getNomeUsuario() );

      for i:=0 to Totais.Count-1 do
         param.Add(totais[i]);
      fmMain.msgStatus('');
      fmMain.impressaoRaveQr5( tbOperadores, tbTotRec, tbSangrias, tbVendasCartao, ds, 'rpPreviaCx', param);

      totais.Free;
      param.Free;

      ds.Free();
   end
   else
     funcoes.msgTela('', MSG_SEM_DADOS, mb_ok + MB_ICONERROR);
end;

procedure TfmRelGeral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (fmRelGeral <> nil) then
   begin
      funcoes.salvaCampos(fmRelGeral);
      action := CaFree;
      fmRelGeral := nil;
   end;   
end;

procedure TfmRelGeral.produtosTransferidosGeraLista;
var
   tb:TADOTable;
   cmd:String;
   params:TStringList;
begin
   cmd:= 'cd_ref varchar(08), ds_ref varchar(60), QtTransferida int';
   funcSQL.getTable( fmMain.Conexao, tb, cmd);

   uCF.getListaProdutosTransferidos(tb, funcoes.getCodUO(cbLojas), dti.date, dtf.date);

   tb.Open();
   tb.sort := 'QtTransferida DESC';

   if ( tb.IsEmpty = false) then
   begin
      params := TStringList.create();
      params.add( funcoes.getNomeUO(cbLojas) );
      params.add( dateToStr(dti.date)+' at� '+ dateToStr(dtf.date) );
      fmMain.impressaoRaveQr4(tb, nil, nil, nil, 'rpProdTransferidos', params);
   end
   else
      funcoes.msgTela('',MSG_SEM_DADOS, MB_ICONERROR);
end;


procedure TfmRelGeral.btOkClick(Sender: TObject);
var
   erro:String;
begin
   if (dtf.Date < dti.Date) then
     erro := MSG_DATA1_MAIORQ_DATA2;

   if ((dtf.Date - dti.Date) > 31) then
     erro := MSG_PER_MQ_31D;

  if (erro = '') then
  begin
    case PERFIL of
       1:gerarVendaAvarias();
       2:calCulaValoresAvarias();
       406:listaVendasEmCartao();
       407:cargaDadosConciliacao();
       112:produtosTransferidosGeraLista();
    end;
  end
  else
  begin
     erro := MSG_ERRO_TIT +  erro;
     msgTela('', erro, MB_OK + MB_ICONERROR);
  end;
end;


procedure TfmRelGeral.produtosTransferidosAjustaTela;
begin
    cbCaixas.Visible := false;
    dti.Date := funcSQL.getDateBd(fmMain.Conexao);
    dtf.Date := dti.Date;
end;

procedure TfmRelGeral.setPerfil(P: integer);
begin
   perfil := P;
   fmRelGeral.Tag := fmMain.Cargadedadosparaconciliao1.Tag;
   case perfil of
      2:ajustaTelaParaAvarias();
      406:ajustaTelaParaRelCartoes();
      407:ajustaTelaParaCargaConciliacao();
      112:produtosTransferidosAjustaTela();
   end;
end;



end.
