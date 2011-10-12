unit cf;

interface

uses  Controls, DB, SysUtils, ADODB, Classes, windows, adLabelComboBox, funcDatas,
      uMain, funcSQl, funcoes;

   function gerarRequisicao(tb:TADOTable; uo, UO_CD, usuario:String; mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList; QT_DIAS_PEND:integer):String;
   function getDadosProd(uo, cd_ref, is_ref, preco:String; mostraMsg:boolean):TdataSet;
   function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String;
   function getEstProdReq( uo, UO_CD, is_ref:String):integer;
   function getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String): Tstrings;
   function getIsref(codigo:String):String;
   function getVdItemDetPorLojaPeriodo(is_ref, uo, uocd:String; di, df:Tdate):TdataSet;
   function getVendaProduto(is_ref, uo, uocd :String;  datai, dataf:Tdate):String;

implementation


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

      ds.free();
   end
   else
      funcoes.gravaLog('DataBD dif da atual: ' + dateToStr(data) + ' ' + dateToStr(funcSQL.getDateBd(fmMain.conexao))  );

   result := saldo;
end;

function getEstProdReq( uo, UO_CD, is_ref:String):integer;
var
  qtReq, estCD:integer;
  cmd:String;
begin
  estCD := strToInt(  cf.getEstoqueProduto(UO_CD, is_ref, '1', now()) );
  cmd := 'Select coalesce( (Select sum(qt_mov) from zcf_dspd(nolock) where is_ref= '+is_ref+ ' and is_uo= ' + uo + '), 0 ) as qt';
  qtReq := strToInt( funcSQL.openSQL(cmd,'qt', fmMain.Conexao));
  getEstProdReq := estCD - qtReq;
end;


function gerarRequisicao(tb:TADOTable; uo, UO_CD, usuario:String;
                         mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList;
                         QT_DIAS_PEND:integer):String;
var
  cd_pes,is_planod,cmd, codTransacao,sq_opf,is_oper:String;
  lista:TStringList;
  is_movpd:integer;
  nItensReq, i:integer;
  incluiItem:boolean;
  estReqCD:integer;
begin
   nItensReq := 0;

   lista:= Tstringlist.Create();
   sq_opf := getParamBD('osDeposito.sq_opfRequisicao', '', fmMain.Conexao); //10000031  cod daTransacao integrada de requisicao
   codTransacao := '4';  // tipo de transacao

   try
      // obter o cd_pes
      cd_pes := funcSql.GetValorWell( 'O', 'select cd_pes from dsusu where cd_usu = '+ usuario, 'cd_pes', fmMain.conexao );

      is_oper := inserirToper( usuario, sq_opf, codTransacao, '', fmMain.Conexao);

      //obter o plano
      cmd := ' begin declare @P1 int  set @P1=0 exec zcf_stoObterContadorCF ''is_planod'' , @P1 output, @qt = 1  select @P1 as is_planod end';
      is_planod := funcSql.GetValorWell( 'O', cmd, 'is_planod', fmMain.conexao );

       cmd :=  ' exec StoInsertPlanoDistribuição ' +#13+
                 '@DT_PLANOD=' + funcoes.DateTimeToSqlDateTime(dateToStr(now), '')  +' , '+#13+
                 '@IS_PLANOD=' + is_planod +' , '+#13+
                 '@cd_usu=' + cd_pes       +' , '+#13+
                 '@is_oper='+ is_oper      +' , '+#13+
                 '@is_tpdoc=5'             +' , '+#13+
                 '@is_estoque=' +UO_CD +', ' +#13+
                 '@IS_EMP=10033585 , @ST_PD=''2'' , @TP_PLANOD=4 , @CDPES=0 ';
       lista.add(cmd);

       tb.First;
       i:=1;
       while (tb.Eof = false) do
       begin
          estReqCD :=  cf.getEstProdReq( uo, UO_CD, tb.fieldByname('is_ref').AsString);

          incluiItem := true;

          if (tb.FieldByName('Qt Pedida').AsInteger >  estReqCD ) and ( ehReqDeVenda = false ) then
          begin
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('descricao').AsString  +  '  -  Não possui estoque disponível.');
             incluiItem := false;
          end;

          if (ehReqDeVenda = false) and (isReqPendProduto( fmMain.conexao,  uo, tb.fieldByname('is_ref').AsString, QT_DIAS_PEND).IsEmpty = false ) then
          begin
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('descricao').AsString  +  '  -  Existem requisições pendentes.');
             incluiItem := false;
          end;

          if (incluiItem = true) then
          begin
//             if gravaItens = true then
//                funcoes.GravaLinhaEmUmArquivo( extractFilePath(paramStr(0)) +'\logs\'+ application.Name +'_Requisicoes.txt',' req '+ is_planod+ ': '+' Item: ' + intToStr(tb.RecNo) + tb.fieldByName('codigo').asString +' qt: '+ tb.fieldByName('qt pedida').asString );

             inc(is_movpd);
             is_movpd := StrToInt( funcSql.GetValorWell( 'O', ' begin declare @P1 int  set @P1=0 exec zcf_stoObterContadorCF ''IS_movpd'' , @P1 output, @qt = '+ intToStr(tb.RecordCount) +   ' select @P1 as ''IS_movpd''  end', 'IS_movpd', fmMain.conexao ));
             cmd := ' exec StoInsertItensPlanoDistribuição' +
                    ' @IS_MOVPD=' + IntToStr(is_movpd) +' , '+
                    ' @IS_ESTOQUE=' + uo +' , '+
                    ' @IS_REF=' + tb.fieldByName('is_ref').asString +' , '+
                    ' @DT_MOVPD=' +funcoes.DateTimeToSqlDateTime(dateToStr(now), '' ) +' , '+
                    ' @IS_OPER=' + is_oper +' , '+
                    ' @IS_EMP=10033585'  +' , '+
                    ' @IS_PLANOD= ' + is_planod +' , '+
                    ' @NR_ITPD=' + intToStr(i)  +' , '+
                    ' @QT_PED=' + tb.fieldByName('Qt Pedida').asString+' , '+
                    ' @QT_PEND=0 ' +' , '+
                    ' @CD_GRDCOMPRAS=0,  @CD_GRDDISTRIBUICAO=0,@PC_QTDE=100, ' +
                    ' @QtdASeparar= ' + tb.fieldByName('Qt Pedida').asString+' , ' +
                    ' @QtdEmSeparacao=0 , @QtdSeparada=0 , @QtdNaoSeparada=0 , @QtdTransferida=0 , @ST_PD=''2'' , @AtualizaLancamentosEstoque=''S'' , @QtdCancelada=0 , @CD_CHV=''          '' ';
             lista.add(cmd);
             inc(i);
             inc(nItensReq);
          end;
          tb.Next;
       end;

      if (nItensReq > 0) then
      begin
         for i:=0 to lista.Count-1 do
            execSQL(lista[i], fmMain.Conexao);

         if mostraNumero = true then
           msgTela('',' Gerada a requisição: ' + is_planod, MB_ICONASTERISK + MB_ok);

         result := is_planod;
      end
      else
      begin
          funcSQL.execSQL('exec stoExcluirPlanoDistribuicao ' + is_planod, fmMain.conexao);
          funcoes.msgTela('',' Não foi gerada nenhuma requisição.', MB_ICONERROR + MB_ok);
          result := '';
      end;

      if (ocoItens.Count > 0) then
         for i:=0 to ocoItens.Count-1 do
            funcoes.gravaLog(ocoItens[i]);

   except
      on e:Exception do
      begin
         funcoes.msgTela('','Ocorreu um erro: ' +#13+ e.Message , mb_ok);
         result := '';
      end
   end;
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

function getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String): Tstrings;
var
   cmd:String;
   ds:TDataSet;
   aux:tStrings;
begin
   cb.Items.Clear();

   if (usuario = '') then
      cmd := ('select ds_uo,is_uo from zcf_tbuo with(NoLock) where TP_ESTOQUE in (1,2) and is_uo > 10 order by ds_uo')
    else
      cmd := ('select ds_uo,is_uo from zcf_tbuo with(NoLock) where is_uo in  ' +
                    '( select distinct is_uo from usuariosUo where cd_pes = ' + usuario + ' ) order by ds_uo ');
   ds := getDataSetQ(cmd, fmMain.Conexao);

   aux := TstringList.create();

   if IncluirLinhaTodas = true then
     aux.Add(funcoes.preencheCampo(50,' ','D','  Todas') + '999');

   if IncluiNenhuma = true then
     aux.Add( funcoes.preencheCampo(50,' ','D',' Nenhuma ' ) + '-1');

   ds.First;
   while ds.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',ds.Fields[0].AsString) +ds.Fields[1].AsString );
      ds.Next;
   end;
   ds.free;
   cb.Items := aux;
   setaLojaLogadaNoComboBox(cb);
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

end.
