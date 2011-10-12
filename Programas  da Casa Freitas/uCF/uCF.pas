
unit uCF;

interface

   uses ADODB, Classes, sysutils, Dialogs, forms, DBGrids,
        ComCTRLs, mxExport, adLabelComboBox, windows, QStdCtrls, DB, DBCtrls, Controls, messages, adLabelCheckListBox,
        IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient, IdTelnet, SoftDBGrid, ExtCtrls,
        uMain, funcsql, uListaFornecedores, funcDatas, funcoes, uSelecionaUo, uListaImpNFE, uListaItensPorNota;


   procedure listaTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; qr:TADOQuery);
   function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
   function alterarModPagamento(uo, seqtransacao, seqModalidade, codNovaModalidade, valor, numParcelas, seqTEFTransCaixa, dataTrans:String; pegaNSU:boolean):boolean;
   function excluirCEP(cep:String):boolean;
   function getAutorizadoresPorTela(codTela:smallInt; grupoUser:String):String;
   function getCEP(nr_CEP:String):TdataSet;
   function getCodModalidadesCartao():TStringList;
   function getCodModalidadesPagamento(mostraTodos:boolean):TStringList;
   function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
   function getDadosEntProduto(uo, isRef:String):TDataSet;
   function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
   function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery; overload;
   function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String; di, df:Tdate):TADOQuery; overload;
   function getDadosPedidoDeCompra(conexao: TADOconnection; numPedido:String):TdataSet;
   function getDadosProd(uo, cd_ref, is_ref, preco:String; mostraMsg:boolean):TdataSet;
   function getDadosUltEntItem(is_ref, uo:String):TdataSet;
   function getDataEntrada(entradas:TdataSet; primOuUlt:String):String;
   function getDescCaixas(uo:String; mostraTodos:boolean):TStrings;
   function getDetalhesCRUC(is_ref:String):TdataSet;
   function getEntradasPorItem(is_ref, uo:String):TdataSet;
   function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String;
   function getEstoqueParaRequisicao(is_ref, uo:String):integer;
   function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
   function getFmDadosPessoa(codPerfil: String):String;
   function getImagemProduto(is_ref:String):TdataSet;
   function getIsNota():String;
   function getIsrefPorFaixaCodigo(cd_ref, numNivel, codCat:String; soAtivos:boolean):TdataSet;
   function getIsUo(mostraEscritorio:boolean):String;
   function getItensDeUmaNota(isNota:String):TDataSet;
   function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
   function getLstaBairros(uf, cd_cid, nm_bai:String):TdataSet;
   function getListaCidades(UF, cidade:String):TdataSet;
   function getNomeImpressoraNFe():String;
   function getPcProd(uo, codigo, preco:String):String;
   function getPreviaGeralCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria:boolean):TDataSet;
   function getRRANAItem(is_ref, uo:String; dti, dtf:Tdate):TdataSet;
   function getTelasPrograma():TstringList;
   function getTiposLogradouro():TStringlist;
   function getTotalDeEntradasProduto(Entradas:TdataSet; isFormatado:boolean):String;
   function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
   function getTotalCartaoPorModo(tb:TADOTable):TStringlist;
   function getUFS():TdataSet;
   function getVendaProduto(is_ref, uo,  uocd :String;  datai, dataf:Tdate):String;
   function getVendaProdutoDLEST(is_ref, is_uo, uocd:String; datai, dataf:Tdate):String;
   function getVdItemDetPorLojaPeriodo(is_ref, uo, uocd:String; di, df:Tdate):TdataSet;
   function incluirCEP(CEP, cd_uf, cd_cid, cd_bai, tp_lograd, nm_log:String):boolean;
   function insereModPagamento (uo, seqTransacao, codNovaModalidade, valor, numParcelas,  dataTrans:String):boolean;
   function insereRegistroTEF(uo, seqTransacao, seqModalidade, tp_mve, valor, numParcelas, dataTrans, nsu:String):boolean;
   function recalcularCmuItem(is_ref:String):String;
   function removeModPagamento(seqModalidade, seqTEFTransCaixa:String):boolean;
   function removeRegistroTef(seqTEFTransCaixa:String):boolean;
   procedure alteraLojaPedidoCompra(uo:String; nPedido:String);
   procedure calCulaPercentualDoFornecedor(var tb:TADOTable);
   procedure calculaRRANA(tbItens, tbMov:TADOTable; is_refs:TStringlist; uo:String; dti, dtf:Tdate);
   procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure cargaDadosConciliacao(tb:TADOTable; dti, dtf: TDateTimePicker);
   procedure carregaListarUosPorPreco(var clb: TadLabelCheckListBox; TpPreco:String);
   procedure criaTabelaDosTotaisDeAvarias(var tb: TADOTable);
   procedure getCRUCBaseNota(conexao:TADOConnection; var query:TADOquery; is_ref:String);
   procedure getListaProdutosTransferidos(tb:TADOTable; uo:String; di, df:Tdate);
   procedure getModalidadesCaixa(tb, tbDestino :TADOTable; cd_tpm, tp_mve: String);
   procedure getOperadoresPorCaixa(tb:TADOTable; uo, caixa:String; dti: TDateTimePicker; conexao:TADOConnection);
   procedure getProdAvariadosParaVenda(tb:TADOTAble; grid:TSoftDBGrid; numPedido:String);
   procedure getRecebDeCaixa(tb, tbReceb:TADOTable);
   procedure getRecebimentosEmCartao(tb, tbVendasCartao :TADOTable);
   procedure getSangriasDoCaixa(tb, tbSangria :TADOTable);
   procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
   procedure getTotaIsPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
   procedure listaRecebimentosCaixa(tb:TADOTAble; uo, caixa:String; dti, dtf: TDateTimePicker; listaSoCartao, removeTrocos, listaSangria:boolean);
   function listaCuponsPorLojaData(uo, ecf:String; dti, dtf:Tdate):TdataSet;
   procedure listarPrecosAlteradosPoPeriodo(qr:TADOQuery; uo,preco:String; data:Tdate);
   procedure logAlteracoesBD(conexao:TADOConnection; tela, usuario, alteracao:String);
   procedure listaNotasVendaDia(tabela, uo:String; di, df:Tdate);
   function getVendasEstornadas(uo, caixa:String; dti, dtf:Tdate):TdataSet;
   function  getNsuTef():String;

   procedure CarregaImagem(is_ref:String; image: TImage);
   procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox);


procedure getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario: String);

implementation

function getNsuTef():String;
var
  nsuTEF:String;
begin
    nsuTEF :=  InputBox('','Informe o número da NSU TEF ( se nao informar vou assumir como zero.','0') ;
    result := nsuTEF;
end;

procedure carregaListarUosPorPreco(var clb: TadLabelCheckListBox; TpPreco:String);
var
   cmd: String;
   ds:TdataSet;
begin
   clb.Items.Clear();
   cmd := ' Select is_uo, ds_uo, p.valor from zcf_tbuo uo ' +
          ' inner join zcf_paramGerais P on uo.is_uo = p.uo and p.nm_param = '  +
          quotedStr('fmPrecos.Uos' + TpPreco) +
          ' order by uo.cd_uo';

   ds := funcSQl.getDataSetQ(cmd, fmMain.Conexao);

   ds.First();
   while (ds.Eof = false ) do
   begin
      clb.Items.Add( funcoes.preencheCampo(50, ' ', 'D', ds.fieldByname('ds_uo').AsString ) + ds.fieldByname('is_uo').AsString);
      clb.Checked[clb.Items.Count-1] :=  StrToBool( ds.fieldByname('valor').asString);
      ds.Next();
   end;
   ds.Free();
end;


function getIsref(codigo:String):String;
var
  cmd :String;
begin
      cmd :=
      ' select ' +
      ' COALESCE( (SELECT TOP 01 IS_REF FROM CREFE with(NoLock) WHERE CD_REF = ' +quotedStr(codigo)+ ' ) ' +
                 ',(SELECT top 01 IS_REF FROM DSCBR with(NoLock) WHERE CD_PESQ = ' +quotedStr(codigo)+ ' /*AND TP_CDPESQ =1 */)  ) as is_ref';
   result := funcSQL.openSQL(cmd, 'is_ref', fmMain.conexao);
end;

function getImagemProduto(is_ref:String):TdataSet;
var
   cmd:String;
begin
   cmd :=
   ' select c.is_ref, c.cd_ref, c.ds_ref , i.imagem from crefe c ' +
   ' left join zcf_crefe_imagens i  on c.is_ref = i.is_ref ' +
   ' where c.is_ref = ' + is_ref;
   result := funcSQl.getDataSetQ(cmd, fmMain.Conexao);
end;

function getDadosProd(uo, cd_ref, is_ref, preco:String; mostraMsg:boolean):TdataSet;
var
   cmd:String;
   ds:TDataSet;
begin
   ds:= TdataSet.Create(nil);
   if(cd_ref = '') and (mostraMsg =true) then
      msgTela('', 'Digite um código', MB_ICONERROR + mb_ok)
   else
   begin
      if (is_ref = '') then
        is_ref := getIsref(cd_ref);

      if (is_ref = '') then
      begin
         if (mostraMsg = true) then
            msgTela('','Produto não cadastrado ('+is_ref+' '+cd_ref + ')', MB_ICONERROR + MB_OK)
      end
      else
      begin
        if ( strToint(preco) < 0) then
           cmd := ' select top 01 crefe.cd_ref AS CODIGO,' +
                  ' dbo.Z_CF_obterEan(IS_REF)as EAN,'+
                  ' crefe.ds_ref AS DESCRICAO,'+
                  ' CREFE.IS_REF,'+
                  ' 0 AS PRECO,' +
                  ' dbo.z_cf_estoqueNaLoja('+ is_ref +', '+uo+ ', 1) as EstoqueDisponivel,'+
                  ' cd_pes as fornecedor,'+
                  ' qt_emb as Embalagem,'+
                  ' categoria= coalesce((Select top 01 cd_vcampo from cccom with(nolock)  where cd_chave = crefe.is_ref and cd_campo = 1),0 ),'+
                  ' crefe.ncm_sh'+
                  ' from crefe with(NoLock) WHERE CREFE.is_ref= '+ is_ref
         else
            cmd :=
            ' select top 01' +
            ' crefe.cd_ref AS CODIGO,'+
            ' dbo.Z_CF_obterEan(IS_REF)as EAN,'+
            ' crefe.ds_ref AS DESCRICAO,' +
            ' CREFE.IS_REF,'+
            ' dbo.Z_CF_funObterPrecoProduto_CF('+preco +', '+is_ref+' ,'+uo+', 0) AS PRECO,'+
            ' dbo.z_cf_estoqueNaLoja(' +is_ref+', '+uo +',  1 ) as EstoqueDisponivel,'+
            ' cd_pes as fornecedor,'+
            ' qt_emb as Embalagem,'+
            ' crefe.ncm_sh,'+
            ' categoria = coalesce((Select top 01 cd_vcampo from cccom with(nolock)  where cd_chave = crefe.is_ref and cd_campo = 1),0 ) '+
            ' from  crefe with(NoLock) '+
            ' WHERE CREFE.is_ref = '+ is_ref;
            ds:=  funcSQl.getDataSetQ(cmd, fmMain.Conexao);
         end;
   end;
   result := ds;
end;


function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
var
   comandos:Tstringlist;
begin
   fmMain.MsgStatus('Baixando arquivo:'+ dirRemoto);

   funcoes.gravaLog(' server: ' + server +#13+
                    '     arq:Remoto: ' + dirRemoto+arquivo+#13+
                    '     arq:Local: ' + dirLocal +'\'+arquivo );

//comandos FTP para pegar o arquivo remoto
   comandos:= TStringList.create();
   comandos.Add('');
   comandos.Add('');
   comandos.Add('binary');
   comandos.add('get ' +  dirRemoto + arquivo);
   comandos.add('quit');
   comandos.SaveToFile( ExtractFilePath(paramStr(0))+'logs\'+ 'comandosftp.txt');

// BAT que ira executar os comandos FTP
   comandos.Clear();
   comandos.add('cd\');
   comandos.add('cd ' + dirLocal );

   comandos.add('ftp -s:comandosFtp.txt ' + server  );
   comandos.SaveToFile( extractFilePath(paramStr(0))+'logs\'+ 'getArq.bat');

   winExec( pchar(extractFilePath(paramStr(0))+'logs\getArq.bat'), SW_HIDE  );
   sleep(3000);

   deleteFile( pChar(extractFilePath(paramStr(0))+'logs\'+ 'getArq.bat'));
   deleteFile( pChar(extractFilePath(paramStr(0))+'logs\'+ 'comandosftp.txt'));

   result := fileExists(dirLocal +'\'+ arquivo);
   fmMain.MsgStatus('');
end;

procedure calCulaPercentualDoFornecedor(var tb:TADOTable);
var
  vPercentual, valorTotal:Real;
begin//
   valorTotal := funcsql.somaColunaTable(tb, 'valorTotalVenda');
   tb.First();
   while (tb.Eof = false) do
   begin
      vPercentual := (tb.fieldByName('valorTotalVenda').AsFloat * 100) / valorTotal ;
      tb.Edit();
      tb.FieldByName('fornecedor').asString := funcoes.floatToDinheiro(vPercentual) + '%';
      tb.Post();
      tb.Next();
   end;
end;

procedure criaTabelaDosTotaisDeAvarias(var tb: TADOTable);
var
   cmd:String;
begin
    if (tb.Active = true) then
       tb.Close();
    cmd := 'is_uo varchar(08), ds_uo varchar(30), TipoAvaria varchar(20), qtItens int, valorTotalCusto money, valorTotalPcVarejo money,  TotalVendido money, Fornecedor varchar(60)';
    funcsql.getTable(fmMain.Conexao, tb, cmd);
end;

procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();
   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(60) ';
   getTable(fmMain.Conexao, tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select '''', sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, Fornecedor from ' + nmTabela +' group by fornecedor ';

   funcsql.execSQL(cmd, fmMain.Conexao);
   tbTotais.Close();
   tbTotais.Open();
end;


procedure getTotaisPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();

   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(30) ';
   getTable(fmMain.Conexao, tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select tipoAvaria, sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela +' group by tipoAvaria '+
      ' union '+
      ' select ''Totalização: '' , sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela ;

   funcsql.execSQL(cmd, fmMain.Conexao);
   tbTotais.Close();
   tbTotais.Open();
end;


function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
var
   uo,cmd:String;
begin
   uo := funcoes.getCodUO(lojas);
   cmd := 'Select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos  (nolock) '+
          'where data between '+funcDatas.dateToSqlDate(datai)+' and '+funcDatas.dateToSqlDate(dataf)+
          ' and is_uo in (select distinct is_uo from ' + tabela +')';

   result := funcsql.openSQL( cmd, 'valorVenda', fmMain.Conexao);
end;

procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
   uo, cmd:String;
begin
   criaTabelaDosTotaisDeAvarias(tb);

   uo := funcoes.getCodUO(lojas);
   cmd := ' insert ' + tb.TableName +
   ' select UO.is_uo, UO.ds_uo, Par.valor, ' +
   'sum(I.quant) as totalQuantItens, '+
   'sum(quant*pco) as TotalCustoItens, '+
   'sum(quant*pcoVarejo) as TotalVendaItens, '+
   '0 as totalVendido, ' +#13+
   'F.nm_fantasi ' +#13+
   'from zcf_AvariasItens I ' +#13+
   'inner join zcf_avarias A on A.loja = I.loja and I.numAvaria = A.numAvaria '+#13+
   'inner join crefe P on I.is_ref = P.is_ref '+#13+
   'inner join dspes F on P.cd_pes = F.cd_pes '+#13+
   'inner join zcf_tbuo UO on I.loja = UO.is_uo '+#13+
   'left join zcf_paramGerais Par on Par.uo = A.TipoAvaria  and par.nm_Param = ''avarias.tpOrigem''  '+#13+
   'where a.data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) +#13;

   if (uo <> '999') then
   cmd :=  cmd + ' and I.loja = ' + uo;

   cmd := cmd +   ' group by UO.is_uo, UO.ds_uo, P.cd_pes, F.nm_fantasi, A.tipoAvaria, Par.Valor ' +
                  ' order by UO.is_uo, F.nm_fantasi, PAR.valor';

    funcsql.execSQL(cmd, fmMain.Conexao);

    tb.close();
    tb.Open();
end;

procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
  uo, cmd:String;
begin
    criaTabelaDosTotaisDeAvarias(tb);

    uo := funcoes.getCodUO(lojas);

    cmd := ' insert ' + tb.TableName +
    ' select A.loja, UO.ds_uo,  P.valor as TipoAvaria, ' +#13+
    'sum(i.quant) as qtItens, ' +#13+
    'sum(i.pcoTotal) as [valorCusto Total], '+#13+
    'sum(i.quant*I.pcoVarejo) as [valorVenda Total], '+#13+
    'totalVenda = ( select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos D (nolock) where D.is_uo = A.loja and data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) + '), '+#13+
    ' '''' as fornecedor ' + #13+
    'from zcf_avariasitens I (nolock) '+#13+
    'inner join zcf_avarias A (nolock) on i.numAvaria = A.numAvaria and I.loja = A.loja and a.ehAtiva = 1 ' +#13+
    'inner join zcf_tbuo UO (nolock) on UO.is_uo = A.loja ' +#13+
    'left join zcf_paramGerais P (noLock) on P.nm_Param = ''avarias.tpOrigem'' and A.tipoAvaria = p.uo ' +#13+
    'where a.data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) +#13;

    if (uo <> '999' )then
      cmd := cmd + ' and A.Loja = ' + uo;

    cmd := cmd +
    'group by '+
    'A.loja,  A.TipoAvaria, p.valor, UO.ds_uo ' +

    'order by A.loja, P.valor ' ;

    funcsql.execSQL(cmd, fmMain.Conexao);
    tb.Close();
    tb.Open();
end;


function recalcularCmuItem(is_ref:String):String;
var
   cmd:String;
   ds:TdataSet;
begin
// Obtm a lista de todas as entradas do produto e calcula o custo do produto.
   cmd := 'select dnota.is_nota, '+
          '(( dnota.vl_dspextra * ((dmovi.vl_item * 100) /  dnota.vl_nota) /100) / dmovi.qt_mov ) as [ValorExtraPorUnidade], '+
          ' pr_tabela + (ValorIPI/qt_mov) - (valorIcms/qt_mov) +  (( dnota.vl_dspextra * ((dmovi.vl_item * 100) /  dnota.vl_nota) /100) / dmovi.qt_mov ) as [custoMaisDespaExtra] '+
          'from dmovi ' +
          'inner join dnota on dmovi.is_nota = dnota.is_nota '+
          'inner join toper on dnota.is_oper = toper.is_oper '+
          'where dmovi.is_ref = ' + is_ref +
          'and toper.codTransacao = 1 ';
   ds := funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   cmd := funcSQL.getMediaDeUmaColuna(fmMain.Conexao, ds,'custoMaisDespaExtra');

   ds.Destroy();
   result := cmd;
end;

function getItensDeUmaNota(isNota:String):TDataSet;
var
   cmd:String;
begin
   cmd := 'Select dmovi.is_ref, crefe.cd_ref, crefe.ds_ref, crefe.ncm_sh ' +#13+
          'from dmovi (nolock) '+#13+
          'inner join crefe (nolock) '+
          'on dmovi.is_Ref = crefe.is_ref ' +
          'where dmovi.is_Nota = ' + isNota;
   result := funcSql.getDataSetQ( cmd, fmMain.Conexao);
end;

function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
var
  ds:TdataSet;
begin
   ds:= getItensDeUmaNota(isNota);
   ds.First();
   while (ds.Eof = false) do
   begin
      tabela.AppendRecord([
                           ds.FieldByName('is_ref').asString,
                           ds.FieldByName('cd_ref').asString,
                           ds.FieldByName('ds_ref').asString,
                           ds.FieldByName('ncm_sh').asString
                         ]);
      ds.Next();
   end;
   ds.Destroy();
   result := true;
end;

function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
begin
   result := executeSQLint( 'update crefe set NCM_SH = ' + quotedStr(ncm_sh) + ' where is_ref = ' + isRef, fmMain.Conexao) > 0 ;
end;


function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String; di, df:Tdate):TADOQuery; overload;
var
   cmd :String;
   qr:TADOQuery;
begin
   cmd :=
   ' select case when topi.fl_entrada=1 then ''Entrada'' else ''Saida'' end as Tipo, ' +#13+
   ' case when dnota.st_nf=''C'' then ''Cancelada'' else ''Normal'' end as Situacao, ' +#13+
   ' dnota.is_nota,'+#13+
   ' dnota.sr_docf as Serie,' +#13+
   ' dnota.nr_docf Num,' + #13+
   ' dnota.cd_cfo,' +#13+
   ' dnota.dt_entsai as [Entrada/Saida],' +#13+
   ' dnota.VL_DSPEXTRA,' +#13+
   ' case ' +#13+
   ' when DNOTA.is_fildest = -1 then ( select cd_pes from dsdoc (nolock) where dnota.is_doc = dsdoc.is_doc )' +#13+
   ' when is_fildest = is_estoque then dnota.cd_pes '+#13+
   ' else dnota.is_fildest end as cd_pes, '+#13+
   ' case '+#13+   ' when DNOTA.is_fildest = -1 then ( select nm_pes from dspes (nolock) inner join dsdoc on dspes.cd_pes = dsdoc.cd_pes where dnota.is_doc = dsdoc.is_doc )'+#13+   ' when is_fildest = is_estoque then ( select nm_pes from dspes D where d.cd_pes = dnota.cd_pes)' +   ' else ( select ds_uo from zcf_tbuo D where d.is_uo = dnota.is_fildest) end as [Emissor/Destino],'  +#13+   ' vl_nota as Valor,' +#13+   ' dnota.codigo_nfe,' +#13+
   ' zcf_tbuo.ds_uo as Loja,' +#13+
   ' dnota.dt_emis,'+#13+
   ' dnota.dt_entsai, ' +#13+
   ' dnota.is_estoque,'+#13+
   ' dnota.st_nf,' +#13+
   ' dnota.observacao,' +#13+
   ' topi.sq_opf,' +#13+
   ' topi.cd_modnf,' +#13+
   ' dnota.codigo_nfe,' +#13+
   ' dnota.is_estoque, ' +#13+
   ' nf_eletronica.chave_acesso_nfe, '+#13+
   ' dsusu.nm_usu, ' +#13+
   ' toper.codTransacao ' +#13+
   ' from dnota (nolock) ' +#13+
   ' inner join toper (nolock) on dnota.is_oper = toper.is_oper ' +#13+
   ' inner join topi (nolock) on toper.sq_opf = topi.sq_opf ' +#13+
   ' inner join zcf_tbuo (nolock) on dnota.is_estoque = zcf_tbuo.is_uo ' +#13+
   ' left join dsusu (nolock) on toper.cd_usuario = dsusu.cd_pes ' +#13+
   ' left  join nf_eletronica on dnota.codigo_nfe = nf_eletronica.codigo_nfe' +#13+
   ' where ' ;

   if ( isNota <> '') then
      cmd := cmd + ' is_nota = ' + isNota
   else
   begin
      cmd := cmd + ' dnota.sr_docf = '+ quotedStr(sr_docf) + ' and nr_docf = ' + nr_docf ;

      if (is_uo <> '') then
         cmd := cmd + ' and is_estoque = ' + is_uo;

      if ( (di <> 0) or (df <> 0 ) ) then
         cmd := cmd + ' dnota.dt_entSai between '+ funcDatas.dateToSqlDate(di) + ' and = ' + funcDatas.dateToSqlDate(df) ;
   end;
   qr := TADOQuery.Create(nil);
   funcsql.getQuery(fmMain.Conexao, qr, cmd);
   result := qr;
end;

function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
begin
    result := getDadosNota(isNota, is_uo, sr_docf, nr_docf, 0, 0);
end;

function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
var
   cmd:String;
begin
   if (cd_pes = '') then
      cmd := 'Select top 50 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  nm_razsoc like ' + quotedstr( nm_pes +'%') + ' order by nome'
   else
      cmd := 'Select top 50 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  is_cred = ' +  cd_pes + ' or cd_pes = ' + cd_pes + ' order by nome';
   result := funcSQL.getDataSetQ(CMD, fmMain.Conexao);
end;

function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
var
  cmd:String;
begin
   if (cd_pes = '') then
      cmd := '/*busca pelo nome*/ select top 50 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where nm_pes like ' + quotedstr( nm_pes +'%') + 'order by nome'
   else
      cmd := '/*busca pelo cd_ref*/ select top 50 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where cd_pes= ' + quotedstr( cd_pes ) + ' order by nome';
   result := funcSQL.getDataSetQ(CMD, fmMain.Conexao);
end;


function getFmDadosPessoa(codPerfil: String):String;
var
  res:String;
begin
   Application.CreateForm(TfmListaFornecedores, fmListaFornecedores);
   fmListaFornecedores.setPerfil(codPerfil);
   fmListaFornecedores.ShowModal;

   if (fmListaFornecedores.ModalResult = mrOk) then
      res := fmListaFornecedores.dsPes.DataSet.fieldByName('codigo').asString
   else
      res := '';

   fmListaFornecedores.free();
   result := res;
end;

function getDadosPedidoDeCompra(conexao: TADOconnection; numPedido:String):TdataSet;
var
  cmd:String;
begin
   cmd :=' select prod.is_ref, Prod.cd_ref as CODIGO, Prod.ds_ref AS DESCRICAO, CAST ( item.qt_ped as int) as QUANT, item.pr_uni AS UND, item.pc_ipi AS IPI' +
         ' from crefe prod (NOLOCK), dsipe item (NOLOCK) where prod.is_ref = item.is_ref'+
         ' and item.is_pedf = '+ quotedStr(numPedido);
   funcSQL.getDataSetQ(cmd, fmMain.Conexao);
   result := funcSQL.getDataSetQ(cmd, fmMain.Conexao);
end;


procedure getCRUCBaseNota(conexao:TADOConnection; var query:TADOquery; is_ref:String);
var
   cmd:String;
begin
   cmd :=
   ' begin ' +#13+
   ' declare @is_oper int' +#13+
   ' set @is_oper = ' +
   ' isnull( (select top 01 is_oper from zcf_dsdei where is_ref = ' +is_ref+ ' and codTransacao = 1 AND DT_MOV <' + funcDatas.dateToSqlDate('01/01/2011') + ' order by dt_mov desc ), 0)' +
   ' select ' + #13+
   ' dnota.sr_docf as Serie' +#13+
   ' ,dnota.nr_docf as Nota' +#13+
   ' ,tbuo.ds_uo as Loja' +#13+
   ' , ceiling( (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot)) * 100) as [% extra nota]' +#13+
   ' ,dmovi.pr_tabela  as [Vl de Nota]'+#13+
   ' ,dmovi.PC_IPI as [% IPI]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_IPI/100)) as [(+) Vl IPI]'+#13+
   ' ,dmovi.Pc_icm as[ %ICMS]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_ICM/100)) as [(-) Vl ICMS]'+#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100))  as [Custo +IPI]' +#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100)) - (dmovi.pR_TABELA * (PC_ICM/100))  as [Custo +IPI -ICMS]' +#13+
   ' from dnota (nolock)' +#13+
   ' inner join dmovi (nolock) on dnota.is_nota = dmovi.is_nota'+#13+
   ' left join zcf_tbuo tbuo on dnota.is_estoque = tbuo.is_uo'+#13+
   ' where'+#13+
   '     dnota.is_oper = @is_oper'+#13+
   ' and dmovi.is_ref = ' + is_ref + ' end';
   funcsql.getQuery(conexao, query, cmd);
end;

procedure listarPrecosAlteradosPoPeriodo(qr:TADOQuery; uo,preco:String; data:Tdate);
var
   cmd:String;
begin
   cmd :=
   'begin ' +
   ' declare @uo int '+#13+
   ' declare @data smallDateTime ' +#13+
   ' declare @tpPreco int ' +#13+
   ' set @data = ' + funcDatas.dateToSqlDate(data)  +#13+
   ' set @uo= ' + uo +#13+
   ' set @tpPreco= ' + preco +#13+
   ' select '  +#13+
   ' crefe.cd_ref,' +#13+
   ' crefe.ds_ref,' +#13+
   '(select top 01 vl_preco' +
   ' from dsalp ant with(nolock) where'+
   ' is_uo = @uo and ant.is_ref = dsalp.is_ref'+
   ' and tp_preco = @tpPreco'+
   ' and dt_altpv < @data' +
   ' order by is_alp desc ) as pcAntigo,'+ #13+
   ' dsalp.vl_preco,' +#13+
   ' dsusu.nm_usu,' +#13+
   ' dspes.NM_FANTASI'+#13+
   ' from dsalp (nolock)' +#13+
   ' inner join dsoap (nolock) on dsalp.is_oap = dsoap.is_oap '+#13+
   ' inner join crefe (nolock) on dsalp.is_ref = crefe.is_ref '+#13+
   ' inner join dsusu (nolock) on dsoap.cd_usu = dsusu.cd_pes '+#13+
   ' inner join dspes (nolock) on crefe.cd_pes = dspes.cd_pes '+#13+
   ' where is_uo = @uo '+#13+
   ' and dsalp.tp_preco = @tpPreco ' +#13+
   ' and dsalp.dt_altpv = @data ' +#13+
   ' order by dspes.NM_FANTASI, crefe.cd_ref'+ #13
   +'end';
   funcSQL.getQuery(fmMain.Conexao, qr, cmd);
end;


procedure alteraLojaPedidoCompra(uo:String; nPedido:String);
var
   cmd:String;
begin
   cmd := ' update dsipe set is_estoque = '+uo+ 'where is_pedf = ' + nPedido;
   funcSQL.execSQL( cmd, fmMain.conexao);

   cmd := 'update DSPDF set is_estoque = ' +uo+ ' is_UOCOMPRA = is_estoque, UOPAGTO= is_estoque '+
          'where is_pedf = '  + nPedido;
   funcSQL.execSQL( cmd, fmMain.conexao);

   cmd := 'update DSEPF  set is_estoque= ' +uo+ ' where is_pedf= ' + nPedido;
   funcSQL.execSQL( cmd, fmMain.conexao);
end;

procedure logAlteracoesBD(conexao:TADOConnection; tela, usuario, alteracao:String);
var
   cmd:String;
begin
   cmd := 'insert zcf_logs values (' + getDataBd(conexao)+', '+
          quotedStr(tela) + ', '+
          quotedStr(usuario)+ ', '+
          quotedStr(alteracao)+')';
   funcSQl.ExecSQL(cmd, conexao);
end;    

function getDescCaixas(uo:String; mostraTodos:boolean):TStrings;
var
   cmd:String;
   ds:TdataSet;
   lista:Tstrings;
begin
   cmd := 'select descEstacao, codCaixa from caixas where codLoja = ' + uo +
          ' and codOperacaoRecOrcamento > 0  order by descEstacao';

   ds := getDataSetQ(cmd, fmMain.conexao);
   ds.first();

   lista := TStringlist.create();

   if (mostraTodos = true) then
      lista.add('<Todos>');
   while (ds.eof = false ) do
   begin
      lista.add( funcoes.preencheCampo(50, ' ', 'D', ds.fieldByName('descEstacao').asString) + ds.fieldByName('codCaixa').asString );
       ds.next();
   end;
   ds.free;
   result := lista;
end;

procedure getOperadoresPorCaixa(tb:TADOTable; uo, caixa:String; dti: TDateTimePicker; conexao:TADOConnection);
var
   cmd:String;
begin
   if (tb.tablename <> '') then
      tb.close;

   funcoes.gravalog('ok');

   cmd := ' descEstacao varchar(20), nm_usu varchar(50), dataSessaoCaixa smallDateTime';
   tb.tablename:= funcSQL.criaTabelaTemporaria(conexao, cmd);

   cmd :=
   ' insert ' + tb.tableName +
   ' select  c.descEstacao, dsusu.nm_usu, s.dataSessaoCaixa from sessoesdecaixa S with(nolock)' +
   ' inner join caixas C  with(nolock) on s.codLoja = c.codLoja and  s.codCaixa = c.codCaixa '+
   ' inner join dsusu with(nolock) on s.codUsuario = dsusu.cd_pes '+
   ' where'+
   ' s.dataSessaoCaixa=' + funcDatas.dateToSqlDate(dti.date);

   if (caixa <> '') then
      cmd := cmd + ' and s.codCaixa = ' + caixa;
   if (uo <> '') then
      cmd := cmd + ' and  s.codLoja = ' + uo ;
   cmd := cmd + ' Order by dataSessaoCaixa, descEstacao';

   funcSQL.execSQL(cmd, fmMain.conexao);
end;


function getTotalCartaoPorModo(tb:TADOTable):TStringlist;
var
  aux:TStringList;
  ds:TdataSet;
begin
   aux := TStringList.create();
   ds := funcSQL.getDataSetQ( 'select count(*), sum(valor) from ' + tb.tableName + ' where tefMagnetico = ''0''', fmMain.conexao);
   aux.add( ds.fields[0].asString);
   aux.add( floattostrf( ds.fields[1].asFloat , ffNumber, 18, 2));
   ds.free();
   ds := funcSQL.getDataSetQ( 'select count(*), sum(valor) from ' + tb.tableName + ' where tefMagnetico = ''1''', fmMain.conexao);
   aux.add( ds.fields[0].asString);
   aux.add( floattostrf( ds.fields[1].asFloat , ffNumber, 18, 2));
   ds.free();
   result := aux;
end;

procedure listaRecebimentosCaixa(tb:TADOTAble; uo, caixa:String; dti, dtf: TDateTimePicker; listaSoCartao, removeTrocos, listaSangria:boolean);
var
   cmd:String;
   ds:TdataSet;
begin
   screen.cursor:= crHourglass;

// criar a tabela de vendas
   if (tb.TableName <> '') then
      tb.Close();

   cmd := 'codLoja int, ' +
          'descEstacao varchar(20), '+
          'cd_mve int, '+
          'ds_mve varchar(30), '+
          'dataSessaoCaixa smallDateTime, ' +
          'seqTransacaoCaixa int, '+
          'seqModPagtoPorTransCaixa int, ' +
          'Valor money, ' +
          'numParcelas varchar(03), ' +
          'tefMagnetico varchar(1), ' +
          'seqTefTransCaixa int, ' +
          'cd_tpm varchar(01), '+
          'tp_mve varchar(01), '+
          'cd_mveReal int, '+
          'ds_mveReal varchar(30)';

   tb.tablename:= funcSQL.criaTabelaTemporaria(fmMain.conexao, cmd);

   ds := uCF.getPreviaGeralCaixa( uo, caixa, dti.date, dtf.date, true, false, listaSangria);
   ds.first();
   tb.open();
   while (ds.eof = false) do
   begin
      tb.AppendRecord([
                       ds.fieldByname('codLoja').AsString
                       ,ds.fieldByname('descEstacao').AsString
                       ,ds.fieldByname('cd_mveReal').AsString
                       ,ds.fieldByname('ds_mveReal').AsString
                       ,ds.fieldByname('dataSessaoCaixa').AsString
                       ,ds.fieldByname('seqTransacaoCaixa').AsString
                       ,ds.fieldByname('seqModPagtoPorTransCaixa').AsString
                       ,ds.fieldByname('Valor').AsString
                       ,ds.fieldByname('numParcelas').AsString
                       ,ds.fieldByname('tefMagnetico').AsString
                       ,ds.fieldByname('seqTefTransCaixa').AsString
                       ,ds.fieldByname('cd_tpm').AsString
                       ,ds.fieldByname('tp_mve').AsString
                     ]);
      ds.next();
   end;
   ds.free();

   if (removeTrocos = true) then
   begin
      tb.close;
      funcSQl.execSQL('delete from ' + tb.tableName + ' where valor < 0', fmMain.conexao);
      tb.open();
   end;
   screen.cursor:= crDefault;
end;

function getPreviaGeralCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria:boolean):TDataSet;
var
   cmd:String;
begin
  if (dataf = 0) then
     dataf := datai;

  if (caixa = '') then
     caixa := '0';

   cmd := 'exec stoListarPreviaGeralCaixa_CF2';

   if (uo <> '' )then
      cmd := cmd + ' @dsLojas = ' + Quotedstr( 'transacoesDoCaixa.codloja = '+ uo)
   else
      cmd := cmd + ' @dsLojas = ' + Quotedstr( 'transacoesDoCaixa.codloja != 0 ');

   cmd := cmd + ', @codEmpresa = ' + fmMain.getParamBD('comum.codEmpresa', '0') +
                ', @DataInicial = ' +  funcDatas.dateToSqlDate(datai) +
                ', @DataFinal = '   +  funcDatas.dateToSqlDate(dataf) +
                ', @CodCaixa = ' +caixa+
                ', @CodOperador = 0' +
                ', @listaVendaPMaracanau = ' + BoolToStr(listaVendaPMaracanau) ;

   if ( listaSomenteCartao = true) then
     cmd := cmd + ', @listaSoCartao = ' + boolToStr(listaSomenteCartao);

   if ( listaSangria = true) then
     cmd := cmd + ', @listaSangria = ' + boolToStr(listaSangria);

   result :=  funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

procedure cargaDadosConciliacao(tb:TADOTable; dti, dtf: TDateTimePicker);
var
  cmd:String;
begin
   uCF.listaRecebimentosCaixa( tb, '', '', dti, dtf, true, false, false);

   screen.cursor := crHourGlass;
   if (tb.IsEmpty = false) then
   begin
      fmMain.msgStatus('Verificando carga existente...');

      cmd := ' delete from conciliacao..vendas_erp where dataSessaoCaixa = ' + funcDatas.dateToSqlDate(dti.date);

      funcSQl.execSQl(cmd, fmMain.conexao);

      fmMain.msgStatus('Exportando dados...');
      cmd := ' insert conciliacao..vendas_erp' +
             ' select codLoja, cd_mve, ds_mve, dataSessaoCaixa, seqTransacaoCaixa, valor, numParcelas'+
             ' from ' + tb.tableName + ' where valor <> 0';

      screen.cursor :=crDefault;
      if (funcSQl.execSQl(cmd, fmMain.conexao) = false) then
         funcoes.msgTela('', 'Houve um erro ao executar a exportacao...', mb_iconError+ mb_ok)
      else
         funcoes.msgTela('', 'Exportação feita com sucesso...', mb_iconError+ mb_ok)
   end;
   tb.close();
end;

function getCodModalidadesCartao():TStringList;
var
   cmd :String;
begin
  cmd := 'select cd_mve  from dsmve where tp_mve in ( ''T'', ''B'')' +
         ' union ' +
         'select cd_mve+999  from dsmve where tp_mve in ( ''T'', ''B'')';
  result := funcSQL.getListagem(cmd, fmMain.conexao);
end;

function getCodModalidadesPagamento(mostraTodos:boolean):TStringList;
var
   aux:TStringList;
   cmd :String;
   ds:TdataSet;
begin
   aux := TStringList.Create();
   cmd := 'select ds_mve, cd_mve  from dsmve with(nolock) where fl_uso = ''S'' and tp_forpag = ''V'' order by ds_mve';
   ds := funcSQL.getDataSetQ(cmd, fmMain.conexao);
   ds.first();

   if (mostraTodos = true) then
      aux.add('< Todos >');

   while (ds.eof = false) do
   begin
      aux.add(  funcoes.preencheCampo(50, ' ', 'D', ds.fieldByName('ds_mve').asString) +
                ds.fieldByName('cd_mve').asString
              );
      ds.next();
    end;
    result := aux;
end;

function removeRegistroTef(seqTEFTransCaixa:String):boolean;
var
   cmd:String;
begin
   cmd := 'delete from tefTransCaixa where sequencial = ' + seqTEFTransCaixa;
   result := funcSQL.ExecSQL(cmd, fmMain.conexao);
end;

function removeModPagamento(seqModalidade, seqTEFTransCaixa:String):boolean;
var
   cmd:String;
begin
    removeRegistroTef(seqTEFTransCaixa);
    cmd := ' delete from ModalidadesPagtoPorTransCaixa where seqModPagtoPorTransCaixa = ' + seqModalidade;
    result := funcSQL.ExecSQL(cmd, fmMain.conexao);
end;


function insereRegistroTEF(uo, seqTransacao, seqModalidade, tp_mve, valor, numParcelas, dataTrans, nsu:String):boolean;
var
   cmd:String;
begin
   if (nsu = '' )then
     nsu := '0';

   cmd :=
   'insert tefTransCaixa( CodLoja, seqTransacaoCaixa, seqModPagtoPorTransCaixa, tp_Mve, valorTEF, numParcelas, '+
   'dataTransacao, nsu, tefMagnetico, flagMvtoProc, fl_tef) values( ' +
   uo  +', '+
   seqTransacao +', '+
   seqModalidade +', '+
   quotedStr(tp_mve) +', '+
   funcoes.valorSql(valor) +', '+
   numParcelas +', '+
   funcDatas.dateToSqlDate(dataTrans) +', '+
   nsu +', '+
   '0' +', '+
   '''P''' +', '+
   '0'
   +')';
   result := funcSQL.ExecSQL(cmd, fmMain.conexao);
end;

function insereModPagamento (uo, seqTransacao, codNovaModalidade, valor, numParcelas,  dataTrans:String):boolean;
var
   nsuTEF, cmd, seqModPagtoPorTransCaixa:String;
begin
   seqModPagtoPorTransCaixa := funcSQL.getContadorWell(fmMain.conexao, 'seqModPagtoPorTransCaixa');

   cmd :=
   'insert ModalidadesPagtoPorTransCaixa (codLoja, seqModPagtoPorTransCaixa, seqTransacaoCaixa, codEmpresa, codModalidadePagto, EntradaOuSaida, ' +
   'valorModalidade, valorRateioECF) ' + #13+ ' values (' +
    uo + ', '+
    seqModPagtoPorTransCaixa  + ', '+
    seqTransacao +', ' +
    funcSQL.getParamBD('comum.CodEmpWell','', fmMain.conexao) +', '+
    codNovaModalidade  +', '+
    '''E'', '+
    funcoes.valorSql(valor) +', '+
    '0' +') ';
    funcSQL.ExecSQL(cmd, fmMain.conexao);

    if ( funcSQL.OpenSQL(' select cd_mve from dsmve where tp_mve in (''B'', ''T'') and cd_mve = ' + codNovaModalidade, 'cd_mve', fmMain.conexao) = codNovaModalidade ) then
    begin
       nsuTEF := getNsuTef();
       insereRegistroTEF(uo, seqTransacao, seqModPagtoPorTransCaixa, codNovaModalidade, valor, numParcelas, dataTrans, nsuTEf);
    end;
    result := true;
end;


function alterarModPagamento(uo, seqTransacao, seqModalidade, codNovaModalidade, valor, numParcelas, seqTEFTransCaixa, dataTrans:String; pegaNSU:boolean):boolean;
var
   dsTEF:TdataSet;
   nsuTEF, cmd:String;
begin
   dsTEF:= getDataSetQ('Select * from dsmve where cd_mve = ' + codNovaModalidade, fmMain.conexao);
// remova o sequencial TEF antigp, se tiver
   if (seqTEFTransCaixa <> '0') then
      removeRegistroTef(seqTEFTransCaixa);

// determinar se a nova modalidade é em cartão, se sim, insere o registro TEF
   if (dsTEF.fieldByName('tp_mve').asString = 'B') or (dsTEF.fieldByName('tp_mve').asString = 'T') then
      if (pegaNSU = true) then
      begin
         nsuTEF := getNsuTef();
         insereRegistroTEF(uo, seqTransacao, seqModalidade, dsTEF.fieldByName('tp_mve').asString, valor, numParcelas, dataTrans, nsuTEF);
      end;
   dsTEF.free();

   cmd := '  update ModalidadesPagtoPorTransCaixa'+
          '  set codModalidadePagto = ' + codNovaModalidade +
          ', valorModalidade = ' + funcoes.valorSql(valor) +
          '  where SeqModPagtoPorTransCaixa = ' + seqModalidade;
   result := funcSQL.execSQL(cmd, fmMain.conexao);
end;


function getPcProd(uo, codigo, preco:String):String;
var
   ds:TdataSet;
   aux:String;
begin
   aux := '0';
   ds := getDadosProd(uo, codigo, '', preco, true);
   if (ds.isEmpty = false) then
      aux := ds.fieldbyName('preco').asString;
   ds.free();
   result := aux;
end;

procedure getProdAvariadosParaVenda(tb:TADOTAble; grid:TSoftDBGrid; numPedido:String);
var
   cmd :String;
   i:integer;
begin
   if (tb.TableName <> '') then
      tb.close();

   cmd := ' qtParaVenda int, cd_ref varchar(10), ds_ref varchar(60), Disponivel int, pcoSugerido money, is_ref int, ref int, is_alterado varchar(01)';
   funcsql.getTable( fmMain.conexao, tb, cmd);

   tb.close();

   cmd := ' insert ' + tb.tableName + #13+
          ' select  0 as qtParaVenda, C.cd_ref, C.ds_ref, (i.quant-i.qtVendido) as qtDisponivel, i.pcoSugerido, i.is_ref, i.ref, '''' as is_alterado '+#13+
          ' from zcf_avariasItens I with(nolock) ' +
          ' inner join zcf_avarias A with(nolock) on (i.numAvaria = A.numAvaria) and I.codLojaDesconto = a.codLojaDesconto and A.ehAprovada = 1  and a.tipoAvaria = 0 ' + #13+
          ' inner join crefe C with(nolock) on i.is_ref = c.is_ref '+ #13+
          ' inner join itensPedidocliente P with(nolock) on i.is_ref = P.seqProduto and I.codLojaDesconto = P.codLoja and   P.numPedido =' + numPedido + #13+
          ' where ' +
          ' i.qtVendido < i.quant order by i.is_ref ';
    funcSQL.execSQL(cmd, fmMain.conexao);
    tb.open();

   grid.columns[tb.FieldByname('is_alterado').index].visible := false;
   grid.columns[tb.FieldByname('ref').index].visible := false;
   grid.columns[tb.FieldByname('is_ref').index].visible := false;
   grid.columns[tb.FieldByname('cd_ref').index].title.caption := 'Codigo';
   grid.columns[tb.FieldByname('cd_ref').index].width := 60;
   grid.columns[tb.FieldByname('ds_ref').index].title.caption := 'Descricao';
   grid.columns[tb.FieldByname('ds_ref').index].width := 250;
   grid.columns[tb.FieldByname('qtParaVenda').index].title.caption := 'Quant';

   grid.columns[tb.FieldByname('pcoSugerido').index].title.caption := 'Preço para venda';

   for i:=0 to grid.columns.count-1 do
      grid.columns[i].readonly := true;

   grid.columns[0].readonly := false;
end;

function getIsUo(mostraEscritorio:boolean):String;
var
   aux:String;
begin
   Application.CreateForm(TfmSelecionaUo, fmSelecionaUo);

   aux := '';
   getListaLojas( fmSelecionaUo.cbLojas, false, false, '');

   if (mostraEscritorio = true) then
      fmSelecionaUo.cbLojas.Items.add(funcoes.preencheCampo(50,' ','D','Escritorio'));

   fmSelecionaUo.showModal();

   if (fmSelecionaUo.modalResult = mrOk) then
      aux:= funcoes.getCodUO(fmSelecionaUo.cbLojas);

  fmSelecionaUo := nil;
  result := aux;
end;

function getNomeImpressoraNFe():String;
var
   aux:String;
begin
   application.createForm(TfmListaImpNFE, fmListaImpNFE);
   fmListaImpNFE.showModal();

   if (fmListaImpNFE.modalResult = mrOk) then
      aux:= fmListaImpNFE.cbLojas.items[fmListaImpNFE.cbLojas.itemIndex];

   fmListaImpNFE := nil;

   if (aux <> '') then
      result := getParamBD('comum.impNFe_'+ aux, '', fmMain.conexao)
   else
      result :='';
end;

procedure getModalidadesCaixa(tb, tbDestino :TADOTable; cd_tpm, tp_mve: String);
var
   cmd:String;
begin
   cmd := 'cd_mve varchar(50), valor money';
   tbDestino.tableName:= funcSQL.criaTabelaTemporaria(fmMain.conexao, cmd);

   cmd :=
   ' insert ' + tbDestino.tableName +
   ' select ds_mve, sum(valor) from ' + tb.tableName +
   ' where cd_tpm in ('+cd_tpm+')';

   if( tp_mve <> '') then
      cmd := cmd + ' and tp_mve in (' + tp_mve+')';

   cmd := cmd + ' group by ds_mve order by ds_mve ';

   funcSQL.execSQL(cmd, fmMain.conexao);
end;

procedure getRecebDeCaixa(tb, tbReceb:TADOTable);
begin
   getModalidadesCaixa( tb, tbReceb, '5, 4', '');
end;

procedure getSangriasDoCaixa(tb, tbSangria :TADOTable);
begin
   getModalidadesCaixa( tb, tbSangria , '2', '');
end;

procedure getRecebimentosEmCartao(tb, tbVendasCartao :TADOTable);
var
   cmd:String;
begin
   cmd :=    ' codLoja int, cd_mve int, ds_mve varchar(20), seqTransacaoCaixa int, '+
             ' valor money, numparcelas int, tp_mve varchar(01), tefMagnetico varchar(1) ';
   tbVendasCartao.tableName:= funcSQL.criaTabelaTemporaria(fmMain.conexao, cmd);
   cmd :=
   ' insert ' + tbVendasCartao.tableName +
   ' select codLoja, cd_mve, ds_mve, seqTransacaoCaixa, ' +
   ' valor, numparcelas , tp_mve, tefmagnetico from ' + tb.tableName  +#13+
   ' where tp_mve in (''B'', ''T'') ' +
   ' and cd_tpm <> 2 ';
   funcSQL.execSQL(cmd, fmMain.conexao);
end;

function getVdItemDetPorLojaPeriodo(is_ref, uo, uocd:String; di, df:Tdate):TdataSet;
var
   cmd:String;
begin
   gravaLog('uCF.funcao getVdItemDetPorLojaPeriodo()');

   cmd :=
   ' Select UO.ds_uo as Loja, sum(qt_mov) as qt_mov from zcf_dsdsi V with(nolock)'+
   ' inner join zcf_tbuo UO (nolock) on V.is_estoque = UO.Is_uo'+
   ' where' +
   ' V.dt_mov between'+
   funcDatas.dateTimeToSqlDateTime(di, '00:00:00') + ' and ' +
   funcDatas.dateTimeToSqlDateTime(df, '23:59:00') +
   ' and V.is_ref =  ' + is_ref ;

   if (uo <> uocd) and (uo <> '') then
      cmd := cmd + ' and V.is_estoque = '+ uo;

   cmd := cmd + ' group by UO.ds_uo';

   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function getVendaProduto(is_ref, uo, uocd :String;  datai, dataf:Tdate):String;
var
   ds:TdataSet;
   valor:String;
begin
   ds:= getVdItemDetPorLojaPeriodo(is_ref, uo, uocd, datai, dataf);
   if ( ds.IsEmpty = true) then
      valor := '0'
   else
      valor :=  floatTostrf(  funcSQL.somaColunaTable(ds,'qt_mov') , ffgeneral, 18, 0);
   ds.free();
   result := valor;
end;

function getVendaProdutoDLEST(is_ref, is_uo, uocd:String; datai, dataf:Tdate):String;
var
   ds:TDataSet;
   cmd:String;
begin
   cmd :=
   '  select dlest.is_estoque '+#13+
   ', DLEST.is_ref '+#13+
   ', dlest.is_lanc '+#13+
   ', case  '+#13+
   '     when  toper.codTransacao in ( 09, 26, 43 ) then   ( QT_MOV * -1 ) '+#13+
   '     when  toper.codTransacao in ( 23, 24, 25, 44 , 46 ) then  ( QT_MOV ) '+#13+
   ' end as qt_mov '+#13+
   ' from dlest (nolock) '+#13+
   ' inner join toper (NOLOCK) on dlest.is_oper = toper.is_oper '+#13+
   ' where dlest.dt_mov between '+#13+
   funcDatas.dateTimeToSqlDateTime(dataI, ' 00:00:01') + ' and ' +#13+
   funcDatas.dateTimeToSqlDateTime(dataF, ' 23:59:00') +#13+
   ' and dlest.is_estoque = ' + is_uo +#13+
   ' and toper.codTransacao in ( 09, 23, 24, 25, 26, 43, 44 , 46 ) '+#13+
   ' and dlest.st_mov = '''' '+#13+
   ' and dlest.is_ref = ' + is_ref;

   ds:=  getDataSetQ(cmd, fmMain.conexao);

   if (ds.isEmpty = true )then
     result := '0'
   else
      result :=  floatTostrf(  funcSQL.somaColunaTable(ds, 'qt_mov'), ffNumber, 18, 0);
end;


function getDadosEntProduto(uo, isRef:String):TDataSet;
var
  cmd:String;
begin
   cmd := ' Select sum(qt_mov) as qt_mov, dt_mov '+
          ' from zcf_dsdei where ' +
          ' is_ref = ' + isRef +
          ' and is_estoque = '+ uo +
          ' and dt_mov in( select top 01  dt_mov ' +
          ' from zcf_DSDEI (nolock) where is_ref = ' + isRef +
          ' and is_estoque = '+ uo +
          ' order by is_lanc desc ) '+
          ' group by dt_mov ';
  result := funcSQL.getDataSetq( cmd, fmMain.conexao);
end;

function getDadosUltEntItem(is_ref, uo:String):TdataSet;
var
  cmd:String;
  ds:Tdataset;
begin
// define a data da ultima entrada
   cmd := ' select top 01 * from zcf_dsdei' +
          ' where '+
          ' is_ref= ' + is_ref +
          ' and is_estoque= '+ uo +
          ' and codTransacao=1'+
          ' order by dt_mov desc';

   ds:= funcSQL.getDataSetQ(cmd, fmMain.conexao);
   if (ds.isEmpty = false) then
   begin
      cmd := ' select dt_mov, sum(qt_mov) as qt_Mov from zcf_dsdei' +
             ' where '+
             ' is_ref= ' + is_ref +
             ' and is_estoque= '+ uo +
             ' and codTransacao=1' +
             ' and dt_mov = ' + funcDatas.DateToSqlDate(ds.fieldByName('dt_mov').asString) +
             ' group by dt_mov';
      ds:= funcSQL.getDataSetQ(cmd, fmMain.conexao);
   end;
   result := ds;
end;

function getEntradasPorItem(is_ref, uo:String):TdataSet;
var
   cmd:String;
begin
 // entradas por itens constam a apartir de  2010-06-16
   cmd :=
   'select '+
   'dnota.nr_docf as [NumNota], '+#13+
   'dnota.sr_docf [SrNota], '+#13+
   'dnota.dt_entSai as [Data], '+#13+
   'zcf_dsdei.qt_mov  as [Quant], '+#13+
   'zcf_tbuo.ds_uo  as [Loja], '+#13+
   'zcf_tbuo.is_uo  as [is_uo] '+#13+
   'from zcf_dsdei with(NoLock) '+#13+
   'inner join dnota with(NoLock) on zcf_dsdei.is_oper = dnota.is_oper '+#13+
   'inner join zcf_tbuo with(NoLock) on dnota.is_estoque = zcf_tbuo.Is_uo '+#13+
   'where zcf_dsdei.is_ref = '+ is_ref +
   'and  zcf_dsdei.codTransacao  = 1 '+#13+
   'and DNOTA.st_nf = '''' ';

   if (uo <> '') then
      cmd := cmd + ' and uo= ' + uo;

   cmd := cmd + ' order by  zcf_dsdei.dt_mov desc';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function getAutorizadoresPorTela(codTela:smallInt; grupoUser:String):String;
var
   ds:TDataSet;
   cmd:String;
begin
   cmd := 'select gruposAut from zcf_autorizadoresTelas where codTela = '+
           intToStr(codTela) +
          ' and grupoUser = ' + grupoUser;
   ds := funcSQL.getDataSetQ(cmd, fmMain.conexao);

   cmd := '';
   if (ds.isEmpty = true) then
      cmd  := '13'
   else
   begin
      ds.first();
      while (ds.eof = false) do
      begin
         cmd := cmd + ds.fieldByName('gruposAut').asString;
         if (ds.eof = false) then
            cmd := cmd + ', ';
         ds.next();
      end;
      cmd := cmd + ' 13';
   end;
   ds.free();
//   funcoes.gravaLog('getAutorizadoresPorTela():'+ cmd);
   result := cmd;
end;

procedure getListaProdutosTransferidos(tb:TADOTable; uo:String; di, df:Tdate);
var
   cmd:String;
begin
   if (tb.tableName <> '') then
      tb.close();
   cmd:=
   'insert ' + tb.TableName +
   ' select crefe.cd_ref, crefe.ds_ref, sum(dlest.qt_mov)as QtTransferida from dlest (nolock) ' +#13+
   'inner join toper (nolock) on toper.is_oper = dlest.is_oper and toper.codTransacao = 2 ' +#13+
   'inner join crefe (nolock) on dlest.is_ref = crefe.is_ref '+#13+
   'where '+#13+
   'dlest.is_estoque = '+ uo +#13+
   'and dlest.is_tpcte = 6 '  +#13+
   'and toper.dt_trab between '+ funcDatas.dateTimeToSqlDateTime(di, ' 00:00:01') + ' and ' + funcDatas.dateTimeToSqlDateTime(df, ' 23:59:00') +#13+
   'group by dlest.is_ref, crefe.cd_ref, crefe.ds_ref '+#13+
   'order by cd_ref ';
   funcSQL.execSQL(cmd, fmMain.conexao);
end;

procedure listaTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; qr:TADOQuery);
var
   cmd:String;
begin
  cmd :=
  ' Select crefe.cd_ref as codigo '+#13+
  ' ,crefe.ds_ref as descricao '+#13+
  ' ,Crefe.qt_emb '+#13+
  ' ,dbo.Z_CF_EstoqueNaLoja( is_ref, 10033674, 1 ) as estoqueAtual '+#13+
  ' ,dbo.Z_CF_FunObterPrecoProduto_CF( '+pc01+ ', is_ref, ' +uo+ ', 0 ) as [Preco 01] '+#13+
  ' ,dbo.Z_CF_FunObterPrecoProduto_CF( '+pc02+ ', is_ref, ' +uo+ ', 0 ) as [Preco 02] '+#13+
  ' ,CREFE.cd_pes '+#13+
  ' from crefe with(NoLock) ';

  if (numNivel <> '0') then
  cmd := cmd + 'inner join cccom on crefe.is_ref = cccom.cd_chave ' +#13+
               ' and cccom.cd_campo= '+ numNivel +#13+
               ' and cccom.cd_vcampo= '+ vlNivel +#13;

  cmd := cmd +  ' where crefe.cd_ref like '+ quotedStr(cd_ref + '%') +#13 ;

  if ( ds_ref <> '') then
  begin
     if (tipoPesquisa = 1) then
       cmd := cmd + ' and crefe.ds_ref like '+quotedStr(ds_ref +'%')+#13;

     if (tipoPesquisa = 2) then
       cmd := cmd + ' and crefe.ds_ref like '+quotedStr('%' + ds_ref+ '%')+#13;
  end;

  if (tpEstoque = 1) then
     cmd := cmd +  ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1) <> 0 '+#13;

  if (tpEstoque = 2) then
     cmd := cmd + ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1 ) > 0 '+#13;

  if (tpEstoque = 3) then
     cmd := cmd + ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1 ) < 0 '+#13;

  cmd := cmd +' order by  crefe.ds_ref';

  funcSQL.getQuery2(fmMain.Conexao, qr, cmd);
end;

function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String;
var
   ds:TdataSet;
   strTpSaldo, saldo, cmd:String;
begin
   { contas
     1           Pendências de fornecimento
     2           Distribuição aguardando fornecimento
     3           Reservado para distribuição
     4           A receber de distribuição e reservado no depósito
     5           A receber de distribuição Aguardando Fornecimento
     6           Estoque
     8           Reservado para venda
     9           Mercadoria avariada
    12           Em trânsito
  10000004       Auditoria da distribuição
}
   saldo := '0';
   funcoes.gravaLog('DataBD:' + dateToStr(funcSQL.getDateBd(fmMain.conexao)) );

   if (data >= funcSQL.getDateBd(fmMain.conexao) )then
   begin
      if (upperCase(tipoSaldo) = 'D') then
         strTpSaldo:= 'qtSaldoDisponivel'
      else
         strTpSaldo:= 'SaldoFisico';

      cmd := 'select ' + strTpsaldo + ' from viwestoque with(nolock) where is_ref= '+
             is_ref + ' and is_estoque=' + uo;

      ds := funcSQL.getDataSetQ(cmd, fmMain.conexao);

      if ( ds.isEmpty = false) then
        saldo := ds.fieldByName(strTpSaldo).asString;

   end
   else
      funcoes.gravaLog('DataBD dif da atual: ' + dateToStr(data) + ' ' + dateToStr(funcSQL.getDateBd(fmMain.conexao))  );

   ds.free();
   result := saldo;
end;


function getEstoqueParaRequisicao(is_ref, uo:String):integer;
begin
result := 0;
end;




function getDetalhesCRUC(is_ref:String):TdataSet;
var
   cmd:String;
begin
   cmd :=
   ' Select top 01 '+#13 +
   ' zcf_tbuo.ds_uo as [Loja], '+#13 +
   ' dnota.dt_entsai as [Data entrada], '+#13 +
   ' dnota.sr_docf as [Sr Nota], '+#13 +
   ' dnota.Nr_docf as [Nr Nota], '+#13 +
   ' dmovi.pr_tabela  as [Vl de Nota], '+#13 +
   ' dmovi.PC_IPI as [% IPI], '+#13 +
   ' (dmovi.pR_TABELA * (PC_IPI/100)) as [(+) Vl IPI], '+#13 +
   ' dmovi.Pc_icm  as[ %ICMS], '+#13 +
   ' dmovi.pR_TABELA * (PC_ICM/100) as [(-) Vl ICMS], '+#13 +
   ' (SELECT top 01 is_pedf FROM DSIPE with (nolock) WHERE IS_REF= '+is_ref+' AND qt_Ped <> qt_Pend order BY IS_MOVPF desc ) as [Ult Pedido], '+#13 +
   ' dbo.Z_CF_funObterPrecoProduto_CF ( 6 , dlest.is_ref, 0, 0) as [Pc Ultima Compra], '+#13 +
   ' dbo.Z_CF_funObterPrecoProduto_CF ( 7 , dlest.is_ref, 0, 0) as [Pc CRUC] '+#13 +
   ' from dlest (nolock) '+#13 +
   ' inner join toper (nolock) on dlest.is_oper = toper.is_oper and toper.codtransacao = 1 '+#13 +
   ' inner join dnota (noLock) on toper.is_oper = dnota.is_oper '+#13 +
   ' inner join dmovi (noLock) on dnota.is_nota = dmovi.is_nota and dmovi.is_ref = dlest.is_ref '+#13 +
   ' inner join zcf_tbuo on dlest.is_estoque= zcf_tbuo.is_uo '+#13 +
   ' and dlest.is_ref = '+is_ref+ #13 +
   ' order by dlest.is_movi desc';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;


function getRRANAItem(is_ref, uo:String; dti, dtf:Tdate):TdataSet;
var
   cmd:String;
begin
   cmd:= ' select '+#13+
         ' dlest.dt_mov '+#13+
         ' ,topi.ds_res '+#13+
         ' ,dsusu.nm_usu '+#13+
         ' ,dlest.qt_mov '+#13+
         ' ,dlest.qt_sldatu '+#13+
         ' ,case when topi.fl_entrada = 1 then ''+'' else ''-'' end as TipoMovEstoque '+#13+
         ' ,dnota.is_fildest '+#13+
         ' ,zcf_tbuo.ds_uo '+#13+
         ' ,dnota.sr_docf '+#13+
         ' ,dnota.nr_docf '+#13+         ' ,dlest.sq_dlest '+#13+         ' from dlest (nolock) '+#13+
         ' inner join toper (nolock) on dlest.is_oper = toper.is_oper '+#13+
         ' inner join topi (nolock) on toper.sq_opf = topi.sq_opf '+#13+
         ' inner join dsusu (nolock) on toper.cd_usuario = dsusu.cd_pes '+#13+
         ' left join dnota (nolock) on toper.is_oper = dnota.is_oper '+#13+
         ' left join zcf_tbuo (nolock) on dnota.is_fildest = zcf_tbuo.is_uo '+#13+
         ' where '+#13+
         ' dlest.is_estoque= ' + uo +#13+
         ' and dlest.is_ref = ' + is_ref  +#13+
         ' and dt_mov between '+
         funcDatas.dateTimeToSqlDateTime(dti, '00:00:00') + ' and ' +
         funcDatas.dateTimeToSqlDateTime(dtf, '23:59:00') +
         ' and dlest.is_tpcte= 6 ' +#13+
         ' and st_mov = '''' ' +#13+
         ' order by dlest.dt_mov ';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

procedure calculaRRANA(tbItens, tbMov:TADOTable; is_refs:TStringlist; uo:String; dti, dtf:Tdate);
var
   i:integer;
   cmd:String;
   dsItem, dsMov:TdataSet;
begin
   cmd := ' is_ref int, cd_ref varchar(08), ds_ref varchar(50), saldoAnterior varchar(08)';
   funcsql.getTable(fmMain.Conexao, tbItens, cmd);

   cmd := 'dt_mov smallDateTime, ds_res varchar(50), nm_usu varchar(50), qt_mov varchar(10), qt_sldatu varchar(10), ' +
          'TipoMovEstoque varchar(1), is_fildest varchar(08), ds_uo varchar(50), sr_docf varchar(03), nr_docf varchar(06), sq_dlest varchar(08)';
   funcsql.getTable(fmMain.Conexao, tbMov, cmd);


   for i:= 0 to is_refs.count -1 do
   begin
      dsMov:= uCF.getRRANAItem(is_refs[i], uo, dti, dtf);

      if (dsMov.isEmpty = false) then
      begin
         dsMov.first();
         cmd := ' select top 1 qt_sldatu from dlest with(index(ndxsqdlest)) where'+
                ' is_estoque= '+ uo + ' and is_ref= '+is_refs[i] +
                ' and is_tpcte= 6 and sq_dlest < ' +
                 dsMov.fieldByName('sq_dlest').asString+
                ' order by sq_dlest desc';
         cmd := funcSQL.openSQL(cmd, 'qt_sldatu',fmMain.conexao);

         if (cmd='') then
            cmd := '0'
         else
            cmd:= floatToStrf(strToFloat(cmd), ffNumber, 18, 0);

         while ( dsMov.eof = false) do
         begin
           tbMov.appendRecord([
                          dsMov.fieldByName('dt_mov').asString,
                          dsMov.fieldByName('ds_res').asString,
                          dsMov.fieldByName('nm_usu').asString,
                          floatToStrf( dsMov.fieldByName('qt_mov').asFloat, ffNumber, 18, 0),
                          floatToStrf( dsMov.fieldByName('qt_sldatu').asFloat, ffNumber, 18, 0),
                          dsMov.fieldByName('tipoMovEstoque').asString,
                          dsMov.fieldByName('is_filDest').asString,
                          dsMov.fieldByName('ds_uo').asString,
                          trim(dsMov.fieldByName('sr_docf').asString),
                          dsMov.fieldByName('nr_docf').asString
                              ]);
           dsMov.Next();
         end;
         dsMov.free();
      end;
      dsItem := uCF.getDadosProd(uo, '', is_refs[i], '101', false);
      tbItens.appendRecord([
                             dsItem.fieldByName('is_ref').asString,
                             dsItem.fieldByName('codigo').asString,
                             dsItem.fieldByName('descricao').asString,
                             cmd
                          ]);
        dsItem.free();
   end;
end;

function listaCuponsPorLojaData(uo, ecf:String; dti, dtf:Tdate):TdataSet;
var
   cmd:String;
begin
   cmd :=
   ' select ' + #13+
   ' crefe.is_ref' + #13+
   ' ,crefe.cd_ref' + #13+
   ' ,crefe.ds_ref' + #13+
   ' ,sum(qt_mov) as qt' + #13+
   ' ,sum(dmovi.vl_item) as [Valor total]' + #13+
   ' from dmovi(nolock)' + #13+
   ' inner join dnota (nolock) on dmovi.is_nota = dnota.is_nota ' + #13+
   ' inner join crefe (nolock) on dmovi.is_ref = crefe.is_ref ' + #13+
   ' where dnota.is_estoque = ' + uo + #13+
   ' and dnota.dt_emis between ' + funcDatas.dateToSqlDAte(dti) +
   ' and ' + funcDatas.dateToSqlDAte(dtf) +#13+
   ' and numeroDoECF= ' + ecf +
   ' and dnota.sr_docf in (''ECF'',''3'') '+#13+
   ' group by  '+#13+
   ' crefe.is_ref  '+#13+
   ' ,crefe.cd_ref  '+#13+
   ' ,crefe.ds_ref  ';
   result := funcSQL.getDataSetq(cmd, fmMain.conexao);
end;


procedure listaNotasVendaDia(tabela, uo:String; di, df:Tdate);
var
  cmd:String;
begin
   cmd :=
   ' insert '+ tabela +
   ' select '+
   ' '''' as especie ' +#13+
   ' ,dnota.dt_emis '+#13+
   ' ,toper.codTransacao as transacao '+#13+
   ' ,dnota.sr_docf '+#13+
   ' ,dnota.nr_docf '+#13+
   ' ,dnota.vl_tot '+#13+
   ' ,dnota.vl_nota '+#13+
   ' ,dnota.cd_cfo '+#13+
   ' ,dnota.st_nf '+#13+
   ' ,dnotc.vl_base '+#13+
   ' ,dnotc.pc_icm '+#13+
   ' ,dnotc.vl_icm '+#13+
   ' from dnota  (nolock) '+#13+
   ' inner join toper (nolock) on dnota.is_oper = toper.is_oper '+#13+
   ' left join dnotc with (nolock) on dnota.is_estoque = dnotc.is_estoque and dnota.is_nota = dnotc.is_nota and dnotc.tp_icm in (1,2,5) '+#13+
   ' where '+#13+
   ' dnota.is_estoque = ' + uo  +#13+
   ' and dt_emis between ' + funcDatas.dateToSqlDate(di) +' and ' + funcDatas.dateToSqlDate(df) +#13+
   ' and ((dnota.cd_cfo >=500  and dnota.cd_cfo <=800) or ' +#13+
   '      (dnota.cd_cfo >=5000 and dnota.cd_cfo <=8000)) ' +#13+
   ' and dnota.st_nf not in (''C'',''E'')';
   funCSQL.execSQL(cmd, fmMain.Conexao);
end;

function getIsrefPorFaixaCodigo(cd_ref, numNivel, codCat:String; soAtivos:boolean):TdataSet;
var
  cmd:String;
begin
  funcoes.gravaLog('getIsrefPorFaixaCodigo()');
   cmd := 'Select is_ref from crefe (nolock)';

   if ( numNivel <> '0') then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave ' +
      ' and cd_campo = '+ quotedstr(numNivel) +
      ' and cd_vcampo  = ' + quotedstr(codCat);

   cmd := cmd + ' where crefe.cd_ref like ' + quotedStr( cd_ref + '%');

   if (soAtivos = true) then
      cmd := cmd + ' and crefe.fl_ativo = ''1''  order by cd_ref ';

   result := funcsql.getDataSetQ(cmd, fmMain.Conexao);
end;

function getVendasEstornadas(uo, caixa:String; dti, dtf:Tdate):TdataSet;
var
   cmd:String;
begin
  cmd :=
  ' select S.dataSessaoCaixa, T.CodLoja, C.codCaixa, C.DescEstacao, dsmve.ds_mve,'+
  ' T.valorTransacao  from  sessoesdecaixa S'+
  ' inner join transacoesdocaixa T WITH(NOLOCK)'+
  ' on S.seqsessaocaixa = T.seqsessaocaixa and S.codloja = T.codloja'+
  ' inner join caixas C on s.codCaixa = C.codCaixa and S.codLoja = C.codLoja'+
  ' inner join modalidadespagtoportranscaixa M on M.seqTransacaoCaixa = T.seqtransacaoCaixa' +
  '       and m.entradaouSaida = ''S'''+
  ' inner join dsmve  on cd_mve = M.codModalidadePagto '+
  ' where' +
  ' S.dataSessaoCaixa between ' + funcDatas.dateToSqlDate(dti)+ ' and '
  + funcDatas.dateToSqlDate(dtf) + ' and T.tipotransacaoCaixa= ''E''';

  if ( uo <> '') then
     cmd := cmd +' and S.codLoja= '+ uo ;

  if ( caixa <> '') then
     cmd := cmd + ' and C.codCaixa= ' + caixa;
  result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function getUFS():TdataSet;
var
   cmd:String;
begin
   cmd := 'Select cd_uf, nm_uf from TUF order by nm_uf';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function getTotalDeEntradasProduto(entradas:TdataSet; isFormatado:boolean):String;
begin
   result := funcSQL.somaColTable(entradas, 'quant', isFormatado);
end;

function getDataEntrada(entradas:TdataSet; primOuUlt:String):String;
var
   aux:String;
begin
   aux := '';
   if (entradas <> nil) and (entradas.isEmpty = false) then
   begin
      if ( upperCase(primOuUlt) = 'P') then
         entradas.last()
      else
         entradas.first();

      aux := entradas.fieldByName('data').AsString;
   end;
   result := aux;
end;

function getListaCidades(UF, cidade:String):TdataSet;
var
   cmd:String;
begin
   cmd := ' select nm_cid, cd_cid from tcid '  +
          ' where cd_uf = ' + quotedStr(uf) +
          ' and nm_cid like ' + quotedStr(cidade+ '%');
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function getLstaBairros(uf, cd_cid, nm_bai:String):TdataSet;
var
   cmd:String;
begin
   cmd := ' Select cd_bai, nm_bai from tbai where' +
//          ' cd_uf = ' + quotedStr(uf)+ ' and  ' +
          ' cd_cid = '+ cd_cid +
          ' and nm_bai like ' + quotedStr(nm_bai + '%') +
          ' order by nm_bai';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;

function excluirCEP(cep:String):boolean;
var
   cmd:String;
begin
   cmd := 'delete from tlog where nr_cep = ' + cep;
   result := funcSQL.execSQL(cmd, fmMain.conexao);
end;


function incluirCEP(CEP, cd_uf, cd_cid, cd_bai, tp_lograd, nm_log:String):boolean;
var
   cmd :String;
begin
   cmd :=
   'insert tlog values (' +
   cd_bai  + ', ' +
   '0'     + ', ' +
   cd_cid  + ', ' +
   quotedStr(nm_log)  + ', ' +
   quotedStr(cd_uf)   + ', ' +
   cep     + ', ' +
   quotedStr(tp_lograd)   + ', ' +
   'null'   + ', ' +
   '''A'''     + ', ' +
   '''A'''     + ')';
   result := funcSQL.execSQL(cmd, fmMain.conexao);
end;

function getCEP(nr_CEP:String):TdataSet;
var
   cmd:String;
begin
   nr_CEP := funcoes.SohNumeros(nr_CEP);
   if (nr_cep = '') then
      nr_CEP := '-1';
   cmd :=
   ' select * from tlog (nolock)' +
   ' left join tbai (nolock) on tbai.cd_bai = tlog.cd_bai1 and tlog.cd_uf = tbai.cd_uf '+
   ' and tlog.cd_cid = tbai.cd_cid ' +
   ' left join tcid (nolock) on tcid.cd_cid = tlog.cd_cid and tcid.cd_uf = tcid.cd_uf '+
   ' where tlog.nr_cep='+ nr_cep;
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;


function getTiposLogradouro():TStringlist;
var
   cmd:String;
   ds:TdataSet;
   lst:TStringlist;
begin
   cmd := 'select ds_chv, cd_chv  from dstab where cd_tab = ''10'' '+
          'order by  cd_chv ' ;

   ds := funcSQL.getDataSetQ(cmd, fmMain.conexao);

   lst := TStringlist.create();
   ds.first();
   while (ds.eof = false ) do
   begin
      lst.add( funcoes.preencheCampo(50, ' ', 'D', ds.fieldByname('ds_chv').asString) +
               ds.fieldByname('cd_chv').asString);
      ds.next;
   end;
   ds.free;
   result := lst;
end;

function getTelasPrograma():TstringList;
begin
  result := funcSQL.getListagem('select tag from zcf_telas', fmMain.Conexao);
end;

procedure CarregaImagem(is_ref:String; image: TImage);
var
  dsImagem:TdataSet;
begin
   image.Picture.Assign(nil);
   image.Refresh();
   dsImagem := uCF.getImagemProduto( is_ref );
   Image.Picture.Assign(dsImagem.FieldByName('imagem'));
   dsImagem.free();
end;

function getIsNota():String;
var
  aux:String;
begin
   aux := '';
   application.CreateForm(TfmListaItensNota, fmListaItensNota );
   fmListaItensNota.ShowModal ;

   if (fmListaItensNota.ModalResult = mrOk) then
      aux := fmListaItensNota.Caption;

   fmListaItensNota := nil;
   result := aux;
end;

procedure getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario: String);
begin
   cb.Items.Clear();
   cb.Items := funcSQL.getNomeLojas2( fmMain.conexao, IncluirLinhaTodas, IncluiNenhuma, usuario );
   setaLojaLogadaNoComboBox(cb);
   cb.DropDownCount := cb.items.count;
end;

procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox);
var
   achou:boolean;
   i:integer;
begin
   achou := false;
   if ( achou = false) then
      cb.itemIndex := -1;
   for i:=0 to cb.Items.count-1 do
   begin
      cb.ItemIndex := i;
      if (funcoes.getCodUO(cb) = fmMain.getUoLogada() ) then
      begin
         achou := true;
         break;
      end;
   end;
   if (achou = false) then
      cb.ItemIndex := -1;
end;

end.


