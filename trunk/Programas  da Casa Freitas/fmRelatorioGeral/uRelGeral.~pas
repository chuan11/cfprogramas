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
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    tb: TADOTable;

    procedure btOkClick(Sender: TObject);
    procedure setPerfil(p:integer);
    procedure gerarVendaAvarias();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


    procedure calCulaValoresAvarias();
    procedure ajustaTelaParaAvarias();
    procedure calCulaTotalAvariasPorLoja();
    procedure calCulaTotalAvariasPorFornecedor();
    function getParametrosRelatorioAvarias():TstringList;

    procedure dtiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ajustaTelaParaRelCartoes();
    procedure cbLojasClick(Sender: TObject);
    procedure getDescCaixas();
    procedure listaVendasEmCartao();
    procedure ajustaTelaParaCargaConciliacao();
    procedure cargaDadosConciliacao();


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

   fmMain.impressaoRaveQr2(tbValoresAvarias, tbValoresAvarias_Total, 'rpValoresAvariasPorForn', params )
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
      fmMain.impressaoRaveQr2( tbValoresAvarias, tbValoresAvarias_Total, 'rpValoresAvarias', params )
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
   dtf.Visible := false;
   label1.Visible := false;
   cbDetAvaForn.Visible := false;
   GroupBox1.Width := dti.Width + 50;

   IS_GRUPO_PERMITIDO_CARTAO := uCF.isGrupoPermitido('relPagCartao.grSemRestricao');

   if (IS_GRUPO_PERMITIDO_CARTAO = false) then
      dti.MinDate :=  funcSQL.getDateBd(fmMain.Conexao)-2;

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
   fmRelGeral.Caption := 'Carga de vendas para conciliação';
   fmRelGeral.WindowState := wsNormal;
end;

procedure TfmRelGeral.cbLojasClick(Sender: TObject);
begin
   if (perfil = 3) then
     getDescCaixas();
end;


procedure TfmRelGeral.cargaDadosConciliacao;
begin
   msgTela('',' Se já houver alguma carga já feita ela será excluída.',0);
   uCF.cargaDadosConciliacao(tb, dti);
end;

procedure TfmRelGeral.listaVendasEmCartao;
var
   totais,param:Tstringlist;
   ds:TdataSet;
   i:integer;
begin
   uCF.listaRecebimentosCaixa( tb, funcoes.getCodUO(cbLojas), funcoes.getCodCaixa(cbCaixas), dti, true, true );
   if (tb.IsEmpty = false) then
   begin
      ds:= uCF.getOperadoresPorCaixa(qr, funcoes.getCodUO(cbLojas), funcoes.getCodCaixa(cbCaixas), dti );

      param := TStringlist.Create();
      param.add( funcoes.getNomeUO(cbLojas));
      param.add( funcoes.getNomeCX(cbCaixas));
      param.add( dateToStr(dti.date));
      param.add( fmMain.getNomeUsuario() );

      totais := uCF.getTotalCartaoPorModo(tb);
      for i:=0 to Totais.Count-1 do
         param.Add(totais[i]);

      fmMain.impressaoRaveQr2( tb, ds, 'rpVendasEmCartao',param);
      ds.Free;
      totais.Free();
      param.Free();
   end
   else
      funcoes.msgTela('', MSG_SEM_DADOS, mb_ok + MB_ICONERROR);
end;

procedure TfmRelGeral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.salvaCampos(fmRelGeral);
   action := CaFree;
   fmRelGeral := nil;
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
       3:listaVendasEmCartao();
       4:cargaDadosConciliacao
    end;
  end
  else
  begin
     erro := MSG_ERRO_TIT +  erro;
     msgTela('', erro, MB_OK + MB_ICONERROR);
  end;
end;

procedure TfmRelGeral.setPerfil(P: integer);
begin
   perfil := P;
   case perfil of
      2:ajustaTelaParaAvarias();
      3:ajustaTelaParaRelCartoes();
      4:ajustaTelaParaCargaConciliacao();
   end;
end;


end.
