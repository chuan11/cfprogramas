unit cf;

interface

uses  Controls, DB, SysUtils, ADODB, Classes, windows, adLabelComboBox, funcDatas, Extctrls,
      uMain, funcSQL, funcoes, DBGrids;

   function gerarRequisicao(tb:TADOTable; uo, UO_CD, usuario:String; mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList; QT_DIAS_PEND:integer):String;
   function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
   function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
   function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
   function getDadosNotaData(isNota, is_uo, sr_docf, nr_docf:String; di, df:Tdate):TADOQuery;
   function getDadosProd(uo, cd_ref, is_ref, preco:String; mostraMsg:boolean):TdataSet;
   function getDadosUltEntItem(is_ref, uo:String):TdataSet;
   function getDiasSemMov(uo, is_ref, tp_mov:String):integer;
   function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String;
   function getEstProdReq( uo, UO_CD, is_ref:String):integer;
   function getImagemProduto(is_ref:String):TdataSet;
   function getIsref(codigo:String):String;
   function getIsrefPorFaixaCodigo(cd_ref, numNivel, codCat:String; soAtivos:boolean):TdataSet;
   function getListaPrecos(mostraPcoCusto,MostraCampoNhenhum,MostraPrecosCalculados:boolean; grupo:String): Tstrings;
   function getVdItemDetPorLojaPeriodo(is_ref, uo, uocd:String; di, df:Tdate):TdataSet;
   function getVendaProduto(is_ref, uo, uocd :String;  datai, dataf:Tdate):String;

   procedure getTable(var tb:TADOTable; tbFields:string);
   procedure carregaImagem(is_ref:String; image: TImage);
   procedure getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String);
   procedure insereEAN(is_ref, ean:String);
   procedure removeEAN(cd_pesq, is_ref: String);
   procedure removeEansInvalidos(inicio, fim:String);
   procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox); overload;
   procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox; uo:String); overload;
   procedure getItensGeraEstoque( dsitens:TdataSet; tbGE:TADOTable; uo, preco:String; diponivel:boolean);
   procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);

   procedure verificaItensDeumNota(isNota:String);

implementation

procedure verificaItensDeumNota(isNota:String);
var
  cmd, erro:String;
  ds:TDataSet;
begin
   cmd:= ' select crefe.is_ref, crefe.cd_ref, crefe.ds_ref, dscbr.cd_pesq' +
         ' from crefe'+
         ' left join dscbr on crefe.is_ref = dscbr.is_ref and tp_cdpesq = ''1'''+
         ' where crefe.is_ref  in ( select is_ref from dmovi where is_nota = ' + isNota + ')';

   ds:= getDataSetQ(cmd, fmMain.Conexao);

   ds.First();
   while (ds.Eof = false) do
   begin
     if (funcoes.isEAN13( ds.fieldByName('cd_pesq').AsString) = false ) then
        erro := erro + ds.fieldByName('cd_ref').AsString + ' ' + ds.fieldByName('ds_ref').AsString + '('+ ds.fieldByName('is_ref').AsString + ')'+#13;

     ds.Next();
   end;
   ds.free;

   if (erro <> '') then
   begin
      erro := 'Itens que têm cod Barras fora do padrão:' +#13+ erro;
   end
   else
     erro := 'Todos os itens parecem ser válidos.';

   funcoes.msgTela('', erro, MB_ICONASTERISK + MB_OK);
end;


procedure getQuery(var qr:TADOQuery; ComandoSQL:string);
begin
   funcsqL.getQuery(fmMain.Conexao, qr, ComandoSQL);
end;

procedure getTable(var tb:TADOTable; tbFields:string);
begin

   funcSQL.getTable(fmMain.Conexao, tb, tbFields);
end;

procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);
begin
   funcSQL.organizarTabela(tabela, coluna);
end;

function getListaPrecos(mostraPcoCusto,MostraCampoNhenhum,MostraPrecosCalculados:boolean; grupo:String): Tstrings;
begin
   result := funcSQL.getListaPrecos(fmMain.Conexao, mostraPcoCusto, MostraCampoNhenhum, MostraPrecosCalculados, grupo);
end;

function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String;
var
   ds:TdataSet;
   strTpSaldo, saldo, cmd:String;
begin
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
  codEmpresa, cd_pes,is_planod,cmd, codTransacao,sq_opf,is_oper:String;
  lista:TStringList;
  is_movpd:integer;
  nItensReq, i:integer;
  incluiItem:boolean;
  estReqCD:integer;
begin
   codEmpresa := fmMain.getParamBD('comum.CodEmpWell', '0');

   nItensReq := 0;

   lista:= Tstringlist.Create();
   sq_opf := getParamBD('osDeposito.sq_opfRequisicao', '', fmMain.Conexao); //10000031  cod daTransacao integrada de requisicao
   codTransacao := '4';  // tipo de transacao

   try
      // obter o cd_pes
      cd_pes := funcSql.GetValorWell( 'O', 'select cd_pes from dsusu where cd_usu = '+ usuario, 'cd_pes', fmMain.conexao );

      is_oper := inserirToper( usuario, sq_opf, codTransacao, '', fmMain.Conexao);

      //obter o numero do  plano
      is_planod := funcSql.getContadorWell(fmMain.Conexao, 'is_planod');

       cmd :=  ' exec StoInsertPlanoDistribuição ' +#13+
                 '@DT_PLANOD=' + funcoes.DateTimeToSqlDateTime(dateToStr(now), '')  +' , '+#13+
                 '@IS_PLANOD=' + is_planod +' , '+#13+
                 '@cd_usu=' + cd_pes       +' , '+#13+
                 '@is_oper='+ is_oper      +' , '+#13+
                 '@is_tpdoc=5'             +' , '+#13+
                 '@is_estoque=' +UO_CD +', ' +#13+
                 '@IS_EMP='+codEmpresa+ ', @ST_PD=''2'' , @TP_PLANOD=4 , @CDPES=0 ';
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

procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox; uo:String );
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
      if (funcoes.getCodUO(cb) =  uo) then
      begin
         achou := true;
         break;
      end;
   end;
   if (achou = false) then
      cb.ItemIndex := -1;
end;

procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox);
begin
   setaLojaLogadaNoComboBox(cb, fmMain.getUoLogada() );
end;

procedure getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String);
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

   cb.DropDownCount := cb.Items.Count;

   setaLojaLogadaNoComboBox(cb);
end;

function getVdItemDetPorLojaPeriodo(is_ref, uo, uocd:String; di, df:Tdate):TdataSet;
var
   cmd:String;
begin
   gravaLog('funcao cf.getVdItemDetPorLojaPeriodo()');

   cmd :=
   ' Select UO.ds_uo as Loja, sum(qt_mov) as qt_mov from zcf_dsdsi V with(nolock)'+
   ' inner join zcf_tbuo UO (nolock) on V.is_estoque = UO.Is_uo'+
   ' where' +
   ' V.dt_mov between'+
   funcDatas.dateTimeToSqlDateTime(di, '00:00:00') + ' and ' +
   funcDatas.dateTimeToSqlDateTime(df, '23:59:00') +
   ' and V.is_ref =  ' + is_ref ;

   if (uo <> '999') then
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

procedure carregaImagem(is_ref:String; image: TImage);
var
  dsImagem:TdataSet;
begin
   image.Picture.Assign(nil);
   image.Refresh();
   dsImagem := getImagemProduto( is_ref );
   Image.Picture.Assign(dsImagem.FieldByName('imagem'));
   dsImagem.free();
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

procedure getItensGeraEstoque( dsitens:TdataSet; tbGE:TADOTable; uo, preco:String; diponivel:boolean);
var
  insereItem:boolean;
  ds:TdataSet;
begin
   dsItens.first;
   while (dsItens.Eof = false) do
   begin
      insereItem:= true;
      ds := getDadosProd( uo, '', dsItens.fieldByname('is_ref').AsString, preco, false );
      if (ds.IsEmpty = false) then
      begin
         fmMain.mostraProgresso(tbGe, 'Obtendo Itens...');
         
         if ( diponivel = true ) and ( ds.fieldByName('EstoqueDisponivel').asString = '0'  ) then
            insereItem:= false;

         if  (insereItem = true ) then
         begin
            tbGE.Append;
            tbGE.FieldByName('codigo').AsString := ds.fieldByName('codigo').asString;
            tbGE.FieldByName('descricao').AsString := ds.fieldByName('descricao').asString;
            tbGE.FieldByName('is_ref').AsString   := ds.fieldByName('is_ref').asString;
            tbGE.FieldByName('Estoque').AsString   := ds.fieldByName('EstoqueDisponivel').asString;
            tbGE.FieldByName('pv').AsString   := ds.fieldByName('preco').asString;
            tbGE.Post;
         end;
         dsItens.Next;
      end
      else
         dsItens.Next;
      ds.free;
   end;
end;

function getDiasSemMov(uo, is_ref, tp_mov:String):integer;
var
   cmd:String;
   ds:TdataSet;
   aux :integer;
begin
   cmd := ' select top 1 datediff(day, dt_mov, getDate()) as qtDias from dlest (nolock)' +
          ' where is_lanc in (' +
          ' select max(is_lanc) from dlest (nolock)' +
          ' inner join toper (nolock) on dlest.is_oper = toper.is_oper'+
          ' where is_estoque= '+uo+ ' and is_ref= ' + is_ref +
          ' and toper.codTransacao in('+ tp_mov +'))';


   ds:= funcSQL.getDataSetq ( cmd, fmMain.conexao );

   if (ds.isEmpty = true) then
      aux := 9999
   else
      aux := ds.fields[0].asInteger;

   ds.free;
   result := aux;
end;

function getDadosNotaData(isNota, is_uo, sr_docf, nr_docf:String; di, df:Tdate):TADOQuery;
var
   cmd:String;
   qr:TADOQuery;
begin
   cmd :=  'select case when topi.fl_entrada=1 then ''Entrada'' else ''Saida'' end as Tipo, ' +#13+
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
   ' case '+#13+   ' when DNOTA.is_fildest = -1 then ( select nm_pes from dspes (nolock) inner join dsdoc on dspes.cd_pes = dsdoc.cd_pes where dnota.is_doc = dsdoc.is_doc )'+#13+   ' when is_fildest = is_estoque then ( select nm_pes from dspes D where d.cd_pes = dnota.cd_pes) else ( select ds_uo from zcf_tbuo D where d.is_uo = dnota.is_fildest) end as [Emissor/Destino],' +#13+   ' vl_nota as Valor,' +#13+   ' dnota.codigo_nfe,' +#13+   ' zcf_tbuo.ds_uo as Loja,' +#13+
   ' dnota.dt_emis,'  +#13+
   ' dnota.dt_entsai, ' +#13+
   ' dnota.is_estoque,'+#13+
   ' dnota.st_nf,' +#13+
   ' dnota.observacao,' +#13+
   ' topi.sq_opf,' +#13+
   ' topi.cd_modnf,' +#13+
   ' dnota.codigo_nfe,' +#13+
   ' dnota.is_estoque,' +#13+
   ' nf_eletronica.chave_acesso_nfe,'+#13+
   ' dsusu.nm_usu,' +#13+
   ' toper.codTransacao' +#13+
   ' from dnota (nolock)' +#13+
   ' inner join toper (nolock) on dnota.is_oper = toper.is_oper' +#13+
   ' inner join topi (nolock) on toper.sq_opf = topi.sq_opf' +#13+
   ' inner join zcf_tbuo (nolock) on dnota.is_estoque = zcf_tbuo.is_uo' +#13+
   ' left join dsusu (nolock) on toper.cd_usuario = dsusu.cd_pes' +#13+
   ' left join nf_eletronica on dnota.codigo_nfe = nf_eletronica.codigo_nfe' +#13+
   ' where';
   if (isNota <> '') then
      cmd := cmd + ' is_nota = ' + isNota
   else
   begin
      cmd := cmd + ' dnota.sr_docf = '+ quotedStr(sr_docf) + ' and nr_docf = ' + nr_docf ;

      if (is_uo <> '') then
         cmd := cmd + ' and is_estoque = ' + is_uo;

      if ( (di <> 0) or (df <> 0 ) ) then
         cmd := cmd + ' dnota .dt_entSai between '+ funcDatas.dateToSqlDate(di) + ' and = ' + funcDatas.dateToSqlDate(df) ;
   end;

{ }
   qr := TADOQuery.Create(nil);
   getQuery(qr, cmd);
   result := qr;
end;

function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
begin
    result := getDadosNotaData(isNota, is_uo, sr_docf, nr_docf, 0, 0);
end;

procedure insereEAN(is_ref, ean:String);
var
   cmd:String;
begin
   if (length(ean) < 13) then
   begin
      ean := funcoes.preencheCampo(12,'0', 'd', ean);
      ean := ean + funcoes.getDigVerEAN13(ean);
   end;

   cmd := 'if not exists ( select cd_pesq from dscbr where tp_cdPesq=''1'' and cd_pesq=' + QuotedStr(ean) + ' and is_ref= '+quotedStr(is_ref) +')' +
          'insert dscbr (cd_pesq, tp_cdpesq, is_ref) values('+
          quotedstr(ean) + ', '+
          quotedStr('1') + ', '+
          quotedStr(is_ref) +')';
  funcSQL.execSQL(cmd, fmMain.Conexao);
end;

procedure removeEAN(cd_pesq, is_ref: String);
var
   cmd :String;
begin
   cmd := 'delete from dscbr where ' +
          'cd_pesq= ' +quotedstr(cd_pesq) + ' and is_Ref=' + is_ref;
   funcSQL.execSQL(cmd, fmMain.Conexao);
end;

procedure removeEansInvalidos(inicio, fim:String);
var
   ds:TdataSet;
   codAVerificar, cmd:String;
begin
   cmd := ' select crefe.is_ref, crefe.cd_ref, crefe.ds_ref, dscbr.cd_pesq' +
          ' from crefe'+
          ' left join dscbr on crefe.is_ref = dscbr.is_ref and tp_cdpesq = ''1'''+
          ' where crefe.is_ref between + '+inicio+ ' and ' + fim +
          ' order by crefe.is_ref ';

   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   ds.First();

   while( ds.Eof = false ) do
   begin
      fmMain.mostraProgresso(ds, 'Cod cadastrados');
      gravaLog('Verificando item:' + ds.FieldByName('is_ref').asString);

      if (ds.FieldByName('cd_pesq').asString = '') then
      begin
         gravaLog('Item sem Nenhum EAN, is_ref: ' +ds.fieldByName('is_ref').asString + ' codigo: '+ ds.fieldByName('cd_ref').asString);
         insereEAN(ds.fieldByName('is_ref').asString, ds.fieldByName('cd_ref').asString);
      end
      else
      begin
         if (funcoes.isEAN13( ds.fieldByName('cd_pesq').asString) = false) then
         begin
            removeEAN(ds.fieldByName('cd_pesq').asString, ds.fieldByName('is_ref').asString);
            insereEAN(ds.fieldByName('is_ref').asString, ds.fieldByName('cd_ref').asString);
         end;
         gravaLog('Item OK! ' + ds.fieldByName('is_ref').asString + ' codigo: '+ ds.fieldByName('cd_ref').asString);
      end;
      ds.Next();
   end;
   ds.free();
   funcoes.msgTela('','Terminado',0);
   fmMain.msgStatus('');
end;


end.
