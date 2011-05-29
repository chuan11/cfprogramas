unit ucf;

interface

   uses ADODB, Classes, sysutils, Dialogs, forms, DBGrids,
        ComCTRLs, mxExport, adLabelComboBox, windows, QStdCtrls, DB, DBCtrls, Controls, messages, adLabelCheckListBox,
        IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient, IdTelnet, SoftDBGrid,
        uMain, funcsql, uListaFornecedores, funcDatas, funcoes, uSelecionaUo
       ;

   function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
   function alterarModPagamento(uo, seqtransacao, seqModalidade, codNovaModalidade, valor, numParcelas, seqTEFTransCaixa, dataTrans:String):boolean;
   function getCodModalidadesCartao():TStringList;
   function getCodModalidadesPagamento(mostraTodos:boolean):TStringList;
   function getDescCaixas(uo:String; mostraTodos:boolean):TStrings;
   function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
   function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
   function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
   function getDadosPedidoDeCompra(conexao: TADOconnection; numPedido:String):TdataSet;
   function getDadosProd(uo, codigo, preco:String):TdataSet;
   function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
   function getFmDadosPessoa(codPerfil: String):String;
   function getIsUo(mostraEscritorio:boolean):String;   
   function getItensDeUmaNota(isNota:String):TDataSet;
   function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
   function getNomeImpressoraNFe():String;
   function getPreviaGeralCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria:boolean):TDataSet;
   function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
   function getOperadoresPorCaixa(qr:TADOQuery; uo, caixa:String; dt: TDateTimePicker):TdataSet;
   function getPcProd(uo, codigo, preco:String):String;
   function getTotalCartaoPorModo(tb:TADOTable):TStringlist;
   function insereModPagamento (uo, seqTransacao, codNovaModalidade, valor, numParcelas,  dataTrans:String):boolean;
   function insereRegistroTEF(uo, seqTransacao, seqModalidade, tp_mve, valor, numParcelas, dataTrans:String):boolean;
   function recalcularCmuItem(is_ref:String):String;
   function removeModPagamento(seqModalidade, seqTEFTransCaixa:String):boolean;
   function removeRegistroTef(seqTEFTransCaixa:String):boolean;
   procedure alteraLojaPedidoCompra(uo:String; nPedido:String);
   procedure calCulaPercentualDoFornecedor(var tb:TADOTable);
   procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure cargaDadosConciliacao(tb:TADOTable; dti, dtf: TDateTimePicker);
   procedure carregaListarUosPorPreco(var clb: TadLabelCheckListBox; TpPreco:String);
   procedure criaTabelaDosTotaisDeAvarias(var tb: TADOTable);
   procedure getCRUCBaseNota(conexao:TADOConnection; var query:TADOquery; is_ref:String);
   procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
   procedure getTotaIsPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
   procedure logAlteracoesBD(conexao:TADOConnection; tela, usuario, alteracao:String);
   procedure listarPrecosAlteradosPoPeriodo(qr:TADOQuery; uo,preco:String; data:Tdate);
   procedure listaRecebimentosCaixa(tb:TADOTAble; uo, caixa:String; dti, dtf: TDateTimePicker; listaSoCartao, removeTrocos, listaSangria:boolean);
   procedure getProdAvariadosPAraVenda(tb:TADOTAble; grid:TSoftDBGrid; numPedido:String);


implementation

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


function getDadosProd(uo, codigo, preco:String):TdataSet;
var
   cmd:String;
   ds:TDataSet;
begin
   ds:= TdataSet.Create(nil);
   if(codigo = '') then
   begin
      msgTela('', 'Digite um código', MB_ICONERROR + mb_ok)
   end
   else
   begin
      cmd := 'exec Z_CF_GetInformacoesProduto ' + quotedStr(codigo)  +', '+ uo + ', ' + preco;
      ds:=  funcSQl.getDataSetQ(cmd, fmMain.Conexao);

      if (ds.IsEmpty = true) then
         msgTela('','Produto não cadastrado', MB_ICONERROR + MB_OK);
   end;
   result := ds;
end;

function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
var
   comandos:Tstringlist;
begin
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
    cmd := 'is_uo varchar(08), ds_uo varchar(30), TipoAvaria varchar(20), qtItens int, valorTotalCusto money, valorTotalPcVarejo money,  TotalVendido money, Fornecedor varchar(30)';
    funcsql.getTable(fmMain.Conexao, tb, cmd);
end;

procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();
   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(30) ';
   getTable(fmMain.Conexao, tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select Fornecedor, sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' from ' + nmTabela +' group by fornecedor ';

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

   if (uo <> '') then
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
    'sum(i.quant*I.pco) as [valorCusto Total], '+#13+
    'sum(i.quant*I.pcoVarejo) as [valorVenda Total], '+#13+
    'totalVenda = ( select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos D (nolock) where D.is_uo = A.loja and data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) + '), '+#13+
    ' '''' as fornecedor ' + #13+
    'from zcf_avariasitens I (nolock) '+#13+
    'inner join zcf_avarias A (nolock) on i.numAvaria = A.numAvaria and I.loja = A.loja and a.ehAtiva = 1 ' +#13+
    'inner join zcf_tbuo UO (nolock) on UO.is_uo = A.loja ' +#13+
    'left join zcf_paramGerais P (noLock) on P.nm_Param = ''avarias.tpOrigem'' and A.tipoAvaria = p.uo ' +#13+
    'where a.data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) +#13;

    if (uo <> '' )then
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
   cmd := 'Select dmovi.is_ref, crefe.cd_ref, crefe.ds_ref, crefe.ncm_sh from dmovi (nolock)'+
          'inner join crefe (nolock) '+
          'on dmovi.is_Ref = crefe.is_ref where dmovi.is_Nota = ' + isNota;
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


function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
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
   ' case when is_fildest <> 0 then is_fildest else dnota.cd_pes end as cd_pes, '+#13+
   ' case when is_fildest <> 0 then ( select nm_pes from dspes D where d.cd_pes = dnota.is_fildest) ' +
   ' else ( select nm_pes from dspes D where d.cd_pes = dnota.cd_pes) end as [Emissor/Destino],'+#13+   ' vl_nota as Valor,' +#13+
   ' dnota.codigo_nfe,' +#13+
   ' zcf_tbuo.ds_uo as Loja,' +#13+
   ' dnota.dt_emis,'+#13+
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
   end;
   qr := TADOQuery.Create(nil);
   funcsql.getQuery(fmMain.Conexao, qr, cmd);
   result := qr;
end;


function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
var
   cmd:String;
begin
   if (cd_pes = '') then
      cmd := 'Select top 100 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  nm_razsoc like ' + quotedstr( nm_pes +'%') + ' order by nome'
   else
      cmd := 'Select top 100 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  is_cred = ' +  cd_pes + ' or cd_pes = ' + cd_pes + ' order by nome';
   result := funcSQL.getDataSetQ(CMD, fmMain.Conexao);
end;

function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
var
  cmd:String;
begin
   if (cd_pes = '') then
      cmd := 'select top 100 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where nm_pes like ' + quotedstr( nm_pes +'%') + 'order by nome'
   else
      cmd := 'select top 100 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where cd_pes  = ' + quotedstr( nm_pes ) + 'order by nome';
   result := funcSQL.getDataSetQ(CMD, fmMain.Conexao);
end;


function getFmDadosPessoa(codPerfil: String):String;
begin
   Application.CreateForm(TfmListaFornecedores, fmListaFornecedores);
   fmListaFornecedores.setPerfil(codPerfil);
   fmListaFornecedores.ShowModal;

   if (fmListaFornecedores.ModalResult = mrOk) then
      result := fmListaFornecedores.dsPes.DataSet.fieldByName('codigo').asString
   else
      result := '';
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
function getOperadoresPorCaixa(qr:TADOQuery; uo, caixa:String; dt: TDateTimePicker):TdataSet;
var
   cmd:String;
begin
   cmd :=
   ' select  c.descEstacao, dsusu.nm_usu from sessoesdecaixa S with(nolock)' +
   ' inner join caixas C  with(nolock) on s.codLoja = c.codLoja and  s.codCaixa = c.codCaixa '+
   ' inner join dsusu with(nolock) on s.codUsuario = dsusu.cd_pes '+
   ' where'+
   ' s.dataSessaoCaixa=' + funcDatas.dateToSqlDate(dt.date);

   if (caixa <> '') then
      cmd := cmd + ' and s.codCaixa = ' + caixa;

   if (uo <> '') then
      cmd := cmd + ' and  s.codLoja = ' + uo ;

   cmd := cmd + ' Order by descEstacao';
   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
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
   if (tb.TableName <> '') then
      tb.Close();

   ds := uCF.getPreviaGeralCaixa( uo, caixa, dti.date, dtf.date, false, listaSoCartao, false);

   cmd := '(codLoja int, descEstacao varchar(20), cd_mve int, ds_mve varchar(30), dataSessaoCaixa smallDateTime, seqtransacaoCaixa int,'+
          ' seqModPagtoPorTransCaixa int, Valor money, numParcelas varchar(03), tefMagnetico varchar(1), seqTefTransCaixa int )';

   tb.tablename:= funcSQL.criaTabelaTemporaria(fmMain.conexao, cmd);

   screen.cursor:= crHourglass;
   tb.open();
   while (ds.eof = false) do
   begin
      tb.AppendRecord([
                       ds.fieldByname('codLoja').AsString,
                       ds.fieldByname('descEstacao').AsString,
                       ds.fieldByname('cd_mve').AsString,
                       ds.fieldByname('ds_mve').AsString,
                       ds.fieldByname('dataSessaoCaixa').AsString,
                       ds.fieldByname('seqTransacaoCaixa').AsString,
                       ds.fieldByname('seqModPagtoPorTransCaixa').AsString,
                       ds.fieldByname('Valor').AsString,
                       ds.fieldByname('numParcelas').AsString,
                       ds.fieldByname('tefMagnetico').AsString,
                       ds.fieldByname('seqTefTransCaixa').AsString
                     ]);
      ds.next();
   end;
   ds.free();

   if ( removeTrocos = true) then
   begin
      tb.close;
      funcSQl.execSQL('delete from ' + tb.tableName + ' where valor <=0', fmMain.conexao);
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

   cmd := ' exec stoListarPreviaGeralCaixa_CF';

   if (uo <> '' )then
      cmd := cmd + ' @dsLojas = ' + Quotedstr( 'transacoesDoCaixa.codloja = '+ uo)
   else
      cmd := cmd + ' @dsLojas = ' + Quotedstr( 'transacoesDoCaixa.codloja != 0 ');

   cmd := cmd + ', @codEmpresa = ' + fmMain.getParamBD('comum.codEmpresa', '0') +
                ', @DataInicial = ' +  funcDatas.dateToSqlDate(datai) +
                ', @DataFinal = '   +  funcDatas.dateToSqlDate(dataf) +
                ', @CodCaixa = ' +caixa+
                ', @CodOperador = 0' +
                ', @listaVendaPMaracanau = ' + BoolToStr(listaVendaPMaracanau); //; +
//                ', @listaSoCartao = ' + boolToStr(listaSomenteCartao);

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
             ' from ' + tb.tableName;
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


function insereRegistroTEF(uo, seqTransacao, seqModalidade, tp_mve, valor, numParcelas, dataTrans:String):boolean;
var
   cmd:String;
begin
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
   '-1' +', '+
   '0' +', '+
   '''P''' +', '+
   '0'
   +')';
   result := funcSQL.ExecSQL(cmd, fmMain.conexao);
end;

function insereModPagamento (uo, seqTransacao, codNovaModalidade, valor, numParcelas,  dataTrans:String):boolean;
var
   cmd, seqModPagtoPorTransCaixa:String;
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
       insereRegistroTEF(uo, seqTransacao, seqModPagtoPorTransCaixa, codNovaModalidade, valor, numParcelas, dataTrans);
    result := true;
end;


function alterarModPagamento(uo, seqTransacao, seqModalidade, codNovaModalidade, valor, numParcelas, seqTEFTransCaixa, dataTrans:String):boolean;
var
   dsTEF:TdataSet;
   cmd:String;
//   is_venda_cartao:boolean;
begin
   dsTEF:= getDataSetQ('Select * from dsmve where cd_mve = ' + codNovaModalidade, fmMain.conexao);

// remova o sequencial TEF antigp, se tiver
   if (seqTEFTransCaixa <> '0') then
      removeRegistroTef(seqTEFTransCaixa);

// determinar se a nova modalidade é em cartão
   if (dsTEF.fieldByName('tp_mve').asString = 'B') or (dsTEF.fieldByName('tp_mve').asString = 'T') then
      insereRegistroTEF(uo, seqTransacao, seqModalidade, dsTEF.fieldByName('tp_mve').asString, valor, numParcelas, dataTrans);

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
   ds := getDadosProd(uo, codigo, preco);
   if (ds.isEmpty = false) then
      aux := ds.fieldbyName('preco').asString;
   ds.free();
   result := aux;
end;

procedure getProdAvariadosPAraVenda(tb:TADOTAble; grid:TSoftDBGrid; numPedido:String);
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
  aux := '';
  Application.CreateForm(TfmSelecionaUo, fmSelecionaUo);
  fmMain.getListaLojas( fmSelecionaUo.cbLojas, false, false, '');

  if (mostraEscritorio = true) then
     fmSelecionaUo.cbLojas.Items.add(funcoes.preencheCampo(50,' ','D','Escritorio'));

  fmSelecionaUo.showModal();
  if (fmSelecionaUo.modalResult = mrOk) then
     aux:= funcoes.getCodUO(fmSelecionaUo.cbLojas);
  fmSelecionaUo := nil;
  result := aux;
end;

function getNomeImpressoraNFe():String;
begin
   result := getParamBD('comum.impNFe', getIsUo(true), fmMain.conexao);
end;


end.
