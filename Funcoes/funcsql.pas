unit funcSQL;

interface
   uses ADODB,Classes,funcoes,sysutils, Dialogs, forms, DBGrids,
        funcDatas, mxExport, adLabelComboBox, windows, QStdCtrls, DB, Controls, messages;

   function criaTabelaTemporaria(conexao:TADOConnection; camposTabela:String):String;
   function devolucaoDeProduto(is_ref,uo,usuario,codCli,is_emp,nLista,sq_opf,tipoPreco, srNota:string; valor:real; Conexao:TADOConnection):boolean;
   function execSQL(comando:string; connection: TADOConnection):boolean; overload
   function executeSQL(comando:string; connection: TADOConnection):String;
   function executeSQLint(comando:string; connection: TADOConnection):integer;
   function gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor: String; conexao:TADOConnection ):Boolean;
   function gerarRequisicao(Conexao:TADOConnection; tb:TADOTable; uo,usuario:String; mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList; QT_DIAS_PEND:integer):String;
   function getADODataSetQ(comando:String; conexao:TADOConnection):TADODataSet;
   function getCaixas(Connection:TADOConnection; uo:String; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean): Tstrings;
   function getContadorWell(conexao:TADOConnection; campo:String):String;
   function getCustoPorData(uo,is_ref, data:String; conexao:TADOconnection):String;
   function getDataBd(conexao:TADOConnection ; diasARecuar:integer):String; overload;
   function getDataBd(conexao:TADOConnection):String;  overload;
   function getDateBd(conexao:TADOConnection):TDate;  
   function getDataSetQ(comando:String; conexao:TADOConnection):TDataSet;
   function getEmail(loja:string; conexao:TADOConnection):string;
   function getEmpregadosPonto(conexao:TadoConnection):TStrings;
   function getEstoqueParaRequisicao(is_ref, UO_CD:String; conexao:TADOConnection):integer;
   function getGruposWell(Connection : TADOConnection ):Tstrings;
   function getHint(nObjeto:String; conexao:TADOConnection):String;
   function getListagem(Comando:String; Connection : TADOConnection):Tstringlist;
   function getListagemH(Comando:String; Connection : TADOConnection; isQuoted:boolean ):String;
   function getListaPrecos(Connection:TADOConnection; mostraPcoCusto,MostraCampoNhenhum,MostraPrecosCalculados:boolean; grupo:String): Tstrings;
   function getMediaDeUmaColuna(cnnection:TADOConnection; ds:TDataSet; coluna:String):String;
   function getNomeLojas2(Connection:TADOConnection; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String): Tstrings;
   function getNomeTableTemp():String;
   function getOperIntegradasFiscais(conexao:TADOConnection):TStrings;
   function getParamBD(nParametro, loja: String; conexao : TADOConnection):String;
   function getStrInsertDmovi(sq_dlest, is_doc, is_movi, uo, codCli, is_oper, is_ref, dataDev, is_nota, usuario, numNf, strValor, is_emp, sq_opf:String;  is_lanc: TStringList ):String;
   function getUsersList(conexao:TADOConnection; cmd:String):String;
   function getUsuariosPonto(Connection : TADOConnection):Tstrings;
   function getUsuariosPorLoja(Connection : TADOConnection; loja:string):TStrings;
   function getUsuariosWell(Connection : TADOConnection; Grupos,cd_usu:String  ):Tstrings;
   function getValoresSQL(Lista:Tstrings; Comando:String; Connection : TADOConnection):Tstrings;
   function getValoresSQL2(Comando:String; Connection : TADOConnection):Tstrings;
   function getValorWell(ExeOrOpen:char; Comando:String; CampoRetorno:String; Connection : TADOConnection):string;
   function inserirToper(usuario,sq_opf,codTransacao,fl_entrada:string;conexao:TADOConnection):string;
   function isGrupoComRestricao(grupo:String; codTela:integer; conexao: TADOConnection):boolean;
   function isHoraPermitida(conexao:TADOConnection; tela:integer; grupo:String):boolean;
   function openQuery  (Conexao :TADOConnection; CampoInicio,CampoFim:Smallint; Comando:String):TStringList;
   function openSQL(comando, retorno:string; Connection : TADOConnection):String;
   function setParamBD(parametro, uo, valor:String; conexao:TADOConnection):boolean;
   function somaColQuery(Query:TADOQuery;Coluna:String; nDecimais:integer):String;
   function somaColTable(Table:TDataSet;Coluna:String):String; overload;
   function somaColunaTable(Table:TDataSet;Coluna:String):real; overload;
   procedure abrirQuery(var query:TADOQuery; conexao:TADOConnection; comando:String);
   procedure acertaQuantidadeItens(uo,usuario:String;qrItens:TADOQuery; conexao:TADOConnection);
   procedure doQuery(conexao:TADOConnection; var qr:TADOQUery; cmd:String);
   procedure exportaDataSet(ds:TDataSet);
   procedure exportaQuery(qr:TADOQuery;ExpParaAqquivo:boolean; nArquivo:String );
   procedure exportaTable(tb:TADOTable);
   procedure getQuery (Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string);
   procedure getQuery2(Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string);
   procedure getTable(Connection : TADOConnection; var tb:TADOTable; tbFields:string);
   procedure openTempTable(tb:TADOTable; descricaoDosCampos:String ; conexao:TADOConnection);
   procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
   procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn );
   function isReqPendProduto(conexao:TADoConnection; uo, is_ref:String; QT_DIAS_PEND:integer ): TDataSet;

implementation

function getNomeTableTemp():String;
var
  i:integer;

begin
   randomize;
   i:= random(99999);
   result := '#' + funcoes.SohNumeros(dateTimeToStr(now) + inttostr(i));
end;



function getContadorWell(conexao:TADOConnection; campo:String):String;
begin
{ Exemplo de alguns contadores
 pagamento:  SeqModPagtoPorTransCaixa

}
   result:=
   funcSql.GetValorWell( 'O',
                         ' begin declare @P1 int set @P1=0 exec stoObterContador ' +
                           quotedStr(campo)+
                         ', @P1 output, 0 select @P1 as is_Oper end ',
                          'is_oper',
                          conexao
                       );
end;

function getParamBD(nParametro, loja: String; conexao : TADOConnection):String;
var
   cmd:String;
begin
      cmd := 'Select valor from zcf_paramGerais where nm_param = ' + quotedStr(nParametro);

      if (loja <> '') then
         cmd := cmd + ' and uo = ' + quotedStr(loja);

      cmd:= funcsql.openSQL(cmd,'valor', conexao);

      if (cmd <> '') then
         result := cmd
      else
      begin
         funcoes.MsgTela('','Nao consegui ler o parametro de BD: ' + nParametro +#13+'Erros de execução do programa poderão ocorrer.', MB_ICONERROR +- mb_ok);
         funcoes.gravaLog(#13+'Parametro ' + nParametro + ' nao existe.' +#13 );
         result := '';
      end;
end;

function isGrupoComRestricao(grupo:String; codTela:integer; conexao: TADOConnection):boolean;
var
  cmd:String;
begin
   cmd := getParamBD('gruposRestritosTela', intToStr(codTela), conexao);
   cmd := 'Select top 01 cd_grusu as cod from dsgrusu (nolock) where cd_grusu = ' + grupo + 'and cd_grusu in (' + cmd + ')';

   if openSql(cmd, 'cod', conexao) = grupo then
      result := true
   else
      result := false;
end;

function getEstoqueParaRequisicao(is_ref, UO_CD:String; conexao:TADOConnection):integer;
begin
   result := strToInt(funcsql.OpenSql('Select dbo.zcf_EstLojaParaReq('+ is_ref +', '+UO_CD+ ',1) as qt', 'qt', conexao));
end;

function getDataSetQ(comando:String; conexao:TADOConnection):TDataSet;
var
   qr:TADOQuery;
begin
   qr := TADOQuery.Create(nil);
   qr.Connection := Conexao;
   qr.CommandTimeout := 0;
   qr.SQL.Add(comando);
   qr.Open;
   result := qr;
end;

function getADODataSetQ(comando:String; conexao:TADOConnection):TADODataSet;
var
   qr:TADODataSet;
begin
   qr := TADODataSet.Create(nil);
   qr.Connection := Conexao;
   qr.CommandTimeout:=0;
   qr.CommandText := comando;
   qr.Open;
   result := qr;
end;


procedure getTable(Connection: TADOConnection; var tb:TADOTable; tbFields:string);
var
   nTable:String;
begin
   nTable := getNomeTableTemp();
   execSQL( 'create table ' + nTable + ' ( ' + tbFields +' ) ', Connection);
   if (tb = nil) then
      tb := TADOTable.Create(nil);
   tb.Connection := Connection;
   tb.TableName := nTable;
   tb.Open;
end;

procedure doQuery(conexao:TADOConnection; var qr:TADOQUery; cmd:String);
begin
   qr := TADOQuery.Create(nil);
   qr.Connection := conexao;
   qr.CommandTimeout := 0 ;
   qr.SQL.Add(cmd);
   qr.Open;
end;

function getEmail(loja:string; conexao:TADOConnection):string;
begin
   result := OpenSQl('Select email from zcf_tbuo (nolock) where is_uo = ' + loja , 'email', conexao);
end;


function getUsuariosWell(Connection : TADOConnection; Grupos,cd_usu:String  ):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;

   if cd_usu = '' then cd_usu := '-1';
   if Grupos = '' then Grupos := '-1';

   query.SQL.Add('Select nm_usu, cd_usu from  dsusu with(nolock) where ( cd_grusu in ('+Grupos+') or cd_usu in ('+ cd_usu +')      ) and fl_ativo = 1 order by nm_usu');
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;

function getUsuariosPonto(Connection : TADOConnection):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('Select nm_usu, cd_usu from  dsusu with(nolock) where cd_usu in (select cd_usu from zcf_PontoAutorizadores ) and fl_ativo = 1 order by nm_usu');
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;

function getNomeLojas2(Connection:TADOConnection; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario:String): Tstrings;
var
   cmd:String;
   ds:TDataSet;
   aux:tStrings;
begin
   if (usuario = '') then
      cmd := ('select ds_uo,is_uo from zcf_tbuo with(NoLock) where TP_ESTOQUE in (1,2) and is_uo > 10 order by ds_uo')
    else
      cmd := ('select ds_uo,is_uo from zcf_tbuo with(NoLock) where is_uo in  ' +
                    '( select distinct is_uo from usuariosUo where cd_pes = ' + usuario + ' ) order by ds_uo ');
   ds := getDataSetQ(cmd, Connection);

   aux := TstringList.create();

   if IncluirLinhaTodas = true then
     aux.Add(' Todas ');

   if IncluiNenhuma = true then
     aux.Add(' Nenhuma ');

   ds.First;
   while ds.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',ds.Fields[0].AsString) +ds.Fields[1].AsString );
      ds.Next;
   end;
   ds.Destroy;
   Result := aux;
end;

function getCaixas(Connection:TADOConnection; uo:String; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean ): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('select descEstacao, codCaixa from caixas with(noLock) where numportaCMC7 is not null and codloja = ' + uo + ' order by descEstacao');
   query.Open;

   aux := TstringList.create();

   if IncluirLinhaTodas = true then
     aux.Add(' Todas ');

   if IncluiNenhuma = true then
     aux.Add(' Nenhuma ');

   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;

function getListaPrecos(Connection:TADOConnection; mostraPcoCusto,MostraCampoNhenhum,MostraPrecosCalculados:boolean; grupo:String): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
   str:String;
begin
   str := 'Select DS_TIPOPRECO, tp_preco from ttpco P with(NoLock) ' +
          'inner join permissoesGrupoUsuario PGU with(NoLock) on p.tp_preco = PGU.codigo and PGU.tipoRegistro = ''P'' ' +
          ' where pgu.chave =' +grupo;
   if MostraPrecosCalculados = true then
      str := str +  ' and P.tabela_base = 0';

   getQuery(Connection, query, str);

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(query.Fields[0].AsString+query.Fields[1].AsString );
      query.Next;
   end;

   if mostraPcoCusto = true then
   begin
      Aux.add('Custo Fiscal  (1)                                  1');
      aux.add('Custo Médio Unitário (02)                          2');
      Aux.add('Custo da última entrada (10)                      10');
      Aux.add('Custo médio unico (05)                             5');
      Aux.add('Último ped compra     (06)                         6');
      Aux.add('Custo real últ compra (07)                         7');
   end;

   if MostraCampoNhenhum = true then
      Aux.add('< Nenhum >                                           -1');

   query.Destroy;
   Result := aux;
end;

function getValorWell(ExeOrOpen:char; Comando:String; campoRetorno:String; Connection : TADOConnection):string;
var
  query:TADOQuery;
begin
   try
      screen.Cursor := -11;
      query := Tadoquery.Create(Connection);
      query.Connection := Connection;
      query.SQL.Clear;
      query.SQL.Add(comando);
      query.CommandTimeout := 0;

      if UpperCase( ExeOrOpen ) = 'E' then
         query.ExecSQL
      else
        query.Open;

      if (campoRetorno <> '') and (campoRetorno <> '@@error') and (campoRetorno <> 'rows') then
      begin
         if (query.FieldByName(campoRetorno).AsString <> '' ) then
            result :=  query.FieldByName(Trim(campoRetorno)).AsString
         else
            result :=  '';
      end;

      if (CampoRetorno = '@@error') then
      begin
         query.SQL.Clear;
         query.SQL.Add('Select @@error');
         query.Open;
         result := query.Fields[0].AsString;
      end;

      if campoRetorno = 'rows' then
      begin
         gravaLog( intTostr(query.RowsAffected));
         result :=  intTostr(query.RowsAffected);
      end;

   except
      on e:exception do
      begin
         gravaLog('Erro ao executar o comando,o erro é:' + e.Message);
         if (campoRetorno = 'rows') then result := '0';
         if (campoRetorno = '@@error') then
         begin
              if( pos('Violation of PRIMARY KEY', e.Message) > 0 )then
                 result := 'keyViolation'
         end;
      end;
   end;
   query.Destroy;
   screen.Cursor := 0;
end;

function openQuery (Conexao :TADOConnection; CampoInicio,CampoFim:Smallint; Comando:String):TStringList;
var
   query:tadoquery;
   i:integer;
   resultado:TStringList;
   aux:string;
begin
   query := Tadoquery.Create(Conexao);
   query.Connection := Conexao;
   query.SQL.Clear;
   query.SQL.Add(comando);


   query.Open;
   Resultado := TStringList.Create();
   query.First;
   while query.Eof = false do
   begin
      aux := '';
      for i:= campoInicio to campofim do
         if i <= query.FieldCount -1 then
         aux:= aux + query.Fields[i].Asstring;

      Resultado.Add(aux);
      query.Next;
   end;
   result :=  resultado;
end;

procedure getQuery2(Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string);
begin
   if qr = nil then
      qr := TADOQuery.Create(nil);
   qr.SQL.Clear();
   qr.CommandTimeout := 60;
   qr.Connection := Connection;
   qr.SQL.Add(ComandoSQL);
   qr.open;
end;


function execSQL(comando:string; connection: TADOConnection):boolean;
begin
   result := (getValorWell('e',comando,'@@error',connection) = '0');
end;

function executeSQL(comando:string; connection: TADOConnection):String;
begin
   result := getValorWell('e',comando,'@@error',connection);
end;

function executeSQLint(comando:string; connection: TADOConnection):integer;
begin
   result := strToInt(getValorWell('e', comando, 'rows', connection));
end;

procedure getQuery(Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string);
begin
   if qr = nil then
      qr := TADOQuery.Create(nil);
   qr.Connection := Connection;   
   getQuery2(Connection, qr, ComandoSQL);
end;

function somaColQuery(Query:TADOQuery;Coluna:String; nDecimais:integer):String;
var
   aux:real;
begin
   Query.First;
   aux := 0;
   while Query.Eof = false do
   begin
      aux := aux + Query.fieldByName(coluna).AsFloat;
      Query.Next;
   end;
   Result := floattostrf( aux , ffNumber, 18, nDecimais);
end;


function somaColunaTable(Table:TDataSet;Coluna:String):real; overload;
var
   aux:real;
begin
  funcoes.gravaLog('somaColTable (real)');

   Table.First;
   aux := 0;
   while (Table.Eof = false) do
   begin
      aux := aux + Table.fieldByName(coluna).AsFloat;
      Table.Next;
   end;
   result := aux;
end;


function somaColTable(Table:TDataSet;Coluna:String):String; overload;
var
   aux:real;
begin
  funcoes.gravaLog('somaColTable (String)');
  aux := funcsql.somaColunaTable(table, Coluna);
  Result := floattostrf( aux, ffNumber, 18, 2);
end;


function getListagem(Comando:String; Connection : TADOConnection):Tstringlist;
var
   qr:TADOQuery;
   aux:Tstringlist;
begin
    aux := TStringList.Create;
    qr:= TADOQuery.Create(nil);
    abrirQuery(qr,Connection, comando);
    qr.First;
    while qr.Eof = false do
    begin
       aux.Add(qr.Fields[0].AsString );
       qr.Next;
    end;
    qr.Destroy;
    result := aux;
end;

function getListagemH(Comando:String; Connection : TADOConnection; isQuoted:boolean ):String;
var
  lista:TstringList;
  aux:String;
  i:integer;
begin
   lista := getListagem(Comando, Connection);
   if (isQuoted = false) then
   begin
      for i:=0 to lista.Count-2 do
         aux := aux + lista[i] + ', ';
      aux := aux +lista[lista.count-1];
   end
   else
   begin
      for i:=0 to lista.Count-2 do
         aux := aux + quotedStr(lista[i]) + ', ';
      aux := aux + QuotedStr( lista[lista.count-1] ) ;
   end;
   lista.Destroy();
   result := aux;
end;

function getValoresSQL2(Comando:String; Connection : TADOConnection):Tstrings;
var
   Query:TADOQuery;
   i:integer;
   lista:Tstringlist;
begin
   Lista := Tstringlist.Create();
   Query := TADOQuery.Create(connection);
   query.Connection := Connection;
   query.CommandTimeout := 0;
   query.SQL.Clear;
   Query.SQL.add(comando);
   Query.Open;
   query.First;

   for i:=0 to query.FieldCount-1 do
      Lista.Add( query.Fields[i].AsString);
   Result := Lista;
end;

function getValoresSQL(Lista:Tstrings; Comando:String; Connection : TADOConnection):Tstrings;
var
   Query:TADOQuery;
   i:integer;
begin
   Lista := Tstringlist.Create();
   Query := TADOQuery.Create(connection);
   query.Connection := Connection;
   query.CommandTimeout := 0;
   query.SQL.Clear;
   Query.SQL.add(comando);
   Query.Open;
   query.First;

   for i:=0 to query.FieldCount-1 do
      Lista.Add( query.Fields[ i ].AsString);
   Result := Lista;
end;

procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);
begin
   tabela.tag := tabela.tag * -1;
   if tabela.Tag < 0  then
   begin
      tabela.Tag := -1;
      tabela.Sort := '['+Coluna.FieldName+']';
   end
   else
   begin
      tabela.Tag := 1;
      tabela.Sort := '['+Coluna.FieldName+'] DESC';
   end;
end;

procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
begin
   query.tag := query.tag * -1;
   if query.Tag < 0  then
   begin
      query.Tag := -1;
      query.Sort := '['+Coluna.FieldName+']';
   end
   else
   begin
      query.Tag := 1;
      query.Sort := '['+Coluna.FieldName+'] DESC';
   end;
end;


function openSQL(comando,retorno:string; Connection : TADOConnection):String;
begin
    result := getValorWell( 'O', comando, retorno, connection);
end;

procedure acertaQuantidadeItens(uo,usuario:String;qrItens:TADOQuery; conexao:TADOConnection);
var
   auxVitem,data,hora,cmd,nmTable:string;
   cd_pes, is_oper , is_doc:string;
   tbAcerto:TADOTable;
   vItem:real;
   qtAtual,i:integer;
   lista:TStringList;
begin
   lista := Tstringlist.Create();
   data := dateToStr(now);
   hora := timeToStr(now);

   // pegar o cd_pes
   cd_pes := funcsql.openSQL('Select cd_pes from dsusu where cd_usu = ' + usuario, 'cd_pes', conexao );
  //   cd_pes := usuario;

   // PEGAR O IS_OPER
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''IS_OPER'', @P1 output, 0   select @P1 as is_Oper end ';
   is_oper := funcSql.GetValorWell( 'O', cmd,'is_oper',  conexao );

   //´PEGAR O IS_DOC
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''IS_DOC'', @P1 output, 0   select @P1 as is_Oper end ';
   is_doc := funcSql.GetValorWell( 'O', cmd,'is_oper',  conexao);


   nmTable := '#'+ funcoes.SohNumeros(dateTimeToStr(now))+'acerto';
   cmd := ' create table '+ nmTable +' ( is_oper integer, is_doc integer, is_lanc integer, is_ref integer, qt_mov integer, vl_mov money ) ';
   funcSql.GetValorWell( 'E', cmd,'@@error', conexao );
   tbAcerto := TADOTAble.Create(nil);
   tbacerto.Connection := conexao;
   tbAcerto.TableName := nmTable;
   tbacerto.Open;

   qrItens.Connection := conexao;
   qrItens.Open;
   qritens.First;

   while qrItens.Eof = false do
   begin
      qtAtual := 0;
      qtAtual := StrToInt( funcSql.openSQL('Select dbo.Z_CF_EstoqueNaLoja ('+ qrItens.fieldByName('is_ref').AsString +' , '+ uo  +' , 1 ) as quant ', 'quant', conexao) );
      if qrItens.FieldByName('quant').AsInteger >  qtAtual then
      begin
         qtAtual := qrItens.FieldByName('quant').AsInteger - qtAtual;
         tbAcerto.append;

         tbAcerto.FieldByName('is_oper').asString := is_oper;
         tbAcerto.FieldByName('is_doc').asString := is_doc;
         tbAcerto.FieldByName('is_ref').asString := qrItens.fieldByname('is_ref').asString;
         tbAcerto.FieldByName('qt_mov').asString := intTostr(qtAtual);
         tbAcerto.FieldByName('is_lanc').asString := funcsql.openSQL('begin declare @P1 int  set @P1=0    exec stoObterContador ''IS_lanc'', @P1 output, 0   select @P1 as is_lanc end ', 'is_lanc' , conexao);

         // tenta pegar opreco de custo se nao houver pega o custo unico, se nao houver pega o valor na avaria e divide por 2
         vItem :=0;
         vItem :=    strToFloat( funcsql.openSQL('select dbo.Z_CF_funObterPrecoProduto_CF(1 , '+ qrItens.FieldByName('is_ref').AsString +' , '+ uo + ', 0) as custo ', 'custo', conexao ));
         if vItem = 0 then
            vItem := strToFloat( funcsql.openSQL('select dbo.Z_CF_funObterPrecoProduto_CF(5 , '+ qrItens.FieldByName('is_ref').AsString +' , '+ uo + ', 0) as custo ', 'custo', conexao ));
         if vItem = 0 then
            vItem := (qrItens.fieldByName('PRECO').asFloat / 2 );
         vItem := vItem * qrItens.FieldByName('quant').asFloat;
         tbAcerto.FieldByName('vl_mov').asFloat :=  vItem ;

         tbAcerto.Post;
      end;
         qrItens.Next();
   end;
   // pega o valor total dos itens
   auxVitem := funcoes.ValorSql(funcSql.SomaColTable(tbAcerto,'vl_mov') );

   tbAcerto.First;
   while tbAcerto.Eof = false do
   begin
      cmd := '';
      for i:= 0 to tbAcerto.FieldCount -1 do

         cmd := cmd + ';'+         tbAcerto.Fields[i].DisplayName+':'+tbAcerto.Fields[i].AsString;
      tbAcerto.next;
   end;

   if tbAcerto.RecordCount > 0 then
   begin

      // iserir o valor na toper                   exec StoInsertTOPER @IS_OPER= 5295320,@DT_OPER='2009-05-09 00:00:00',@IS_EMP= 10033585,@SQ_OPF= 10000013,@DT_TRAB='2009-05-09 09:12:52',@CD_USUARIO= 10035469,@CodTransacao=Null,@CodUsuAutWMS=Null
      cmd := 'Exec stoInsertToper @is_oper = ' + is_oper + ' ,'+#13+
             '@DT_OPER= ' + funcoes.DateTimeToSqlDateTime(data, '') + ' ,'+#13+
             '@IS_EMP= 10033585 , @SQ_OPF= 10000157' + ' ,'+#13+
             '@DT_TRAB= ' + funcoes.DateTimeToSqlDateTime(data,hora)  + ' ,'+#13+
             '@CD_USUARIO= '+ usuario + ' , @CodTransacao=Null , @CodUsuAutWMS=Null ' ;
      lista.Add(cmd);
//      funcsql.execSQL(cmd, conexao);

      cmd := 'Exec StoInsertDocumento @IS_FILIAL= ' + uo +' , ' + #13+
             '@IS_DOC= '+ is_doc +' , ' + #13+
             '@CD_PES= '+ cd_pes +' , ' + #13+
             '@IS_OPER='+ is_oper+' , ' + #13+
             '@DT_LANC='+ funcoes.DateTimeToSqlDateTime(data,'')+' , ' + #13+
             '@DT_EMISS='+  funcoes.DateTimeToSqlDateTime(data,hora)+' , ' + #13+
             '@CD_USU= '+ cd_pes +' , ' + #13+
             '@IS_EMP= 10033585'  +' , ' + #13+
             '@FL_TPDOC=''A''' +' , ' + #13+
             '@NR_DOCORI= 0,@SR_DOCORI=''          '',@IS_REMESSACONT=Null';
     lista.Add(cmd);
      cmd := 'exec StoInsertAcerto @vl_acerto= ' + auxVitem +' , '+#13+
             '@IS_DOC= '+is_doc+ ' , '+#13+
             '@IS_FILIAL= '+ uo + ' , '+#13+
             '@IS_OPER= '+ is_oper +' , ' +#13+
             '@CD_MOT= 6, @DS_OBS= ''AVARIAS APROVADAS'' ';
      lista.Add(cmd);

     tbAcerto.First;
     while tbAcerto.Eof = false do
     begin
        cmd :=
            'exec StoAtualizaLancamentosEstoque' +' '+#13+
            '@is_lancPK= NULL , @qt_movPK= NULL , @vl_movPK= NULL ,' +' '+#13+
            '@is_lanc= ' + tbAcerto.FieldByName('is_lanc').asString +' , '+#13+
            '@is_movi= Null'+' , '+#13+
            '@is_oper= '+ is_oper+' , '+#13+
            '@is_doc= ' + is_doc +' , '+#13+
            '@is_estoque= '+ uo +' , '+#13+
            '@is_tpcte= 6'+' , '+#13+
            '@is_ref= ' +  tbAcerto.fieldByName('is_ref').asString +' , '+#13+
            '@dt_mov=' + funcoes.DateTimeToSqlDateTime(data,'')  +' , '+#13+
            '@qt_mov=' + tbAcerto.fieldByName('qt_mov').asString +' , '+#13+
            '@qt_sldatu= 0'+' , '+#13+
            '@vl_mov= ' + valorSql( tbAcerto.FieldByName('vl_mov').asString) +' , '+#13+
            '@vl_sldatu= 0 , @sq_dlest= 0 , @ST_MOV= '''' , @vl_custovend= 0 , @IS_EMP= 10033585' +' , '+#13+
            '@SQ_OPF= 10000157, @VL_CUSTOCONT= 0 , @flEntrada= 1 ';
        lista.Add(cmd);
        tbAcerto.Next;
     end;
   end;

   if tbAcerto.RecordCount  >  0 then
   begin
      tbAcerto.SaveToFile(funcoes.TempDir() + '_AcertosDeEstoqueGeraPrecoCusto.txt'  );
      for i := 0 to lista.Count -1 do
         funcsql.execSQL(lista[i] , conexao);
   end
   else
      msgTela('FuncSQL.AcertaQuantidadeItens','Nao há itens no acerto',0);
end;


procedure exportaQuery(qr:TADOQuery;expParaAqquivo:boolean; nArquivo:String );
var
   export:TmxDataSetExport;
begin
   export := TmxDataSetExport.Create(nil);
   export.ExportType := xtExcel;
   export.DataSet := qr;

   if ExpParaAqquivo = true then
   begin
      export.ExportStyle := xsFile;
      export.ExportType := xtExcel;
      export.FileName := nArquivo;
   end
   else
      export.ExportStyle := xsView;
   export.Execute;
end;

procedure exportaTable(tb:TADOTable);
var
   export1:TmxDataSetExport;
begin
   export1 := TmxDataSetExport.Create(nil);
   with export1 do
   begin
//      ExportType := xtTXT;
      ExportType := xtTXT;

      DataSet :=  tb;
      ExportStyle := xsView;
      Options := [xoShowProgress, xoUseAlignments ];
      Execute;
   end;
   export1.Destroy;
end;


procedure exportaDataSet(ds:TDataSet);
var
   export:TmxDataSetExport;
begin
   export := TmxDataSetExport.Create(nil);
   export.ExportType := xtExcel;
   export.DataSet :=  ds;
   export.ExportStyle := xsView;
   export.Execute;
end;

function getCodUo(cbox:TadLabelComboBox):string;
begin
   result := funcoes.SohNumeros(copy(cbox.items[cbox.itemIndex],50,100));
end;

procedure abrirQuery(var query:TADOQuery; conexao:TADOConnection; comando:String);
begin
   query.sql.Clear;
   gravaLog(comando);
   query.SQL.Add(comando);
   query.Connection := conexao;
   query.CommandTimeout := 0;
   query.Active := true;
   query.Open;
end;

function devolucaoDeProduto(is_ref,uo,usuario,codCli,is_emp,nLista,sq_opf,tipoPreco, srNota:string; valor:real; Conexao:TADOConnection):boolean;
var
  codUsuADM,empresa, numNF ,strValor, is_lanv, is_mov, is_nota, is_oper, is_movi, is_docv, cmd,str, dataDev, codEmp, codLoja, nmUser:string;
  lista:TStringList;
  is_doc, tp_doc, auxInserirDoc:array[1..3]of String;
  qt_sldatu, custoU:real;
  i:integer;
  valorDoSaldo, qt_mov, sq_dlest, vl_custocont,  custoM,custoMu:string;
  qr:TADOQuery;
  is_lanc: TStringList;
begin
   is_lanc := Tstringlist.create();

   qt_sldatu := 0;
   strValor := funcoes.ValorSql( floatToStr(valor));
   tp_doc[1] := 'N';  tp_doc[2] := 'T';   tp_doc[3] := 'D';
   lista := TStringList.Create();

   dataDev := funcSql.getDataBd(conexao);

// pegar o codigo da empresa
   empresa := funcSql.GetValorWell( 'O', 'exec StoListarEmpresas', 'cd_uo',  conexao );

// pegar o codigo da loja e transformar em is_ref
   is_ref := funcSql.GetValorWell( 'O', 'Select is_ref from crefe where cd_ref  = ' + quotedStr(is_ref), 'is_ref',  conexao );

//pegar o codigo da uo
   codEmp := funcSql.GetValorWell( 'O', 'Select top 01 cd_uo as codEmp from tbuo where is_uo = ' + uo, 'codEmp',  conexao );

// pegar o codigo da loja para a dsadi
   codLoja := funcSql.GetValorWell( 'O', 'Select top 01 cd_uo as codLoja from tbuo where is_uo = ' + uo,  'codloja', conexao );

//  usuario
   nmUser := funcSql.GetValorWell( 'O', 'Select top 01 nm_usu from dsusu where cd_pes = ' + usuario, 'nm_usu', conexao );

// codigo usuario adm
   codUsuADM := funcSql.GetValorWell( 'O', 'Select top 01 P_cod_usu from dsusu where cd_usu = ' + usuario, 'P_cod_usu', conexao );

//   pegar o is_lanv
   str:= 'is_lanv';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_lanv := funcSql.GetValorWell( 'O', cmd, str,  conexao );

  //   pegar o is_movi
   str:= 'is_movi';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_movi := funcSql.GetValorWell( 'O', cmd, str,  conexao );

//pegar os is_doc
   for i:=1 to 3 do
   begin
      str:= 'is_doc';
      cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
      is_doc[i] := funcSql.GetValorWell( 'O', cmd, str,  conexao );
      //showmessage( inttostr(i) + '  ' + is_doc[i]);
   end;

// obter o numero da nota fiscal que sera utilizada
   str:= 'numNF';
   cmd := ' begin declare @P1 int  set @P1=0  exec zcf_stoObterNumNF ' + uo + ' , ' + quotedStr(srNota) + ' , @P1 output   select @P1 as '+str+ ' end ';
   numNF := funcSql.GetValorWell( 'O', cmd, str,  conexao );

//  pegar os is_lanc
   for i:=1 to 3 do
   begin
      str:= 'is_lanc';
      cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''' , @P1 output , 0 select @P1 as '+str+ ' end ';
      is_lanc.Add(funcSql.GetValorWell( 'O', cmd, str,  conexao ) )
   end;

// pegar o is_docv
   str:= 'is_docv';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_docv := funcSql.GetValorWell( 'O', cmd, str,  conexao );


//   pegar o is_nota
   str:= 'is_nota';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ' +str+ ' , @P1 output, 0   select @P1 as '+str+ ' end ';
   is_nota := funcSql.GetValorWell( 'O', cmd, str,  conexao );


//   pegar o is_oper
   str:= 'is_oper';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_oper := funcSql.GetValorWell( 'O', cmd, str,  conexao );


// Obter os valores anteriores da dlest
    Qr := TADOQuery.Create(nil);
    funcsql.AbrirQuery(qr,Conexao, ' select top 1 qt_mov, qt_sldatu, (sq_dlest+1), vl_custocont, custoUnitario, custoMediounitario,custoMediounitarioUnico '+
                                   ' from dlest with(noLock) where is_estoque = ' + uo + ' and is_ref = '+ is_ref +
                                   ' order by is_lanc desc ');

   if ( (qt_sldatu - 1) * custoU > 0 )then
      valorDoSaldo := ValorSql( floatToStr ( (qt_sldatu - 1) * custoU) )
   else
      valorDoSaldo := '0';

// pegar os dados da dlest
   if qr.IsEmpty = false then
   begin
      qt_mov := qr.Fields[0].AsString;
      qt_sldatu := qr.Fields[1].asInteger;
      sq_dlest :=  qr.Fields[2].asString;
      vl_custocont := funcoes.ValorSql( qr.Fields[3].asString );
      custoU := qr.Fields[4].AsFloat ;
      custoM := funcoes.ValorSql( qr.Fields[5].asString );
      custoMU := funcoes.ValorSql( qr.Fields[6].asString );
   end
   else
   begin
      qt_mov := '0';
      qt_sldatu := 0;
      custoU := 0;
      sq_dlest :='0';
      vl_custocont := '0';
      custoM :=   '0';
      custoMU := '0';
   end;


// iserir o valor na toper                   exec StoInsertTOPER @IS_OPER= 5295320,@DT_OPER='2009-05-09 00:00:00',@IS_EMP= 10033585,@SQ_OPF= 10000013,@DT_TRAB='2009-05-09 09:12:52',@CD_USUARIO= 10035469,@CodTransacao=Null,@CodUsuAutWMS=Null
   cmd := 'Exec stoInsertToper @is_oper = ' + is_oper + ' ,'+#13+
           '@DT_OPER= ' + funcoes.DateTimeToSqlDateTime(dateToStr(now), '') + ' ,'+#13+
           '@IS_EMP= 10033585 , @SQ_OPF=10000168' + ' ,'+#13+
           '@DT_TRAB= ' + funcoes.DateTimeToSqlDateTime(dateToStr(now),timeToStr(now))  + ' ,'+#13+
           '@CD_USUARIO= '+ usuario + ' , @CodTransacao=Null , @CodUsuAutWMS=Null ' ;
   lista.Add(cmd);


// inserir os documentos
   auxInserirDoc[1] := 'N';
   auxInserirDoc[2] := 'D';
   auxInserirDoc[3] := 'T';
   for i :=1 to 3 do
   begin
	    cmd := ' exec StoInsertDocumento '   +
              '  @IS_FILIAL= ' + uo +
              ' , @IS_DOC= ' + is_doc[i] +
              ' , @CD_PES= ' + codCli +
              ' , @IS_OPER= '+ is_oper  +
              ' , @DT_LANC=' + dataDev  +
              ' , @DT_EMISS=' + dataDev  +
              ' , @CD_USU= ' + usuario +
              ' , @IS_EMP= '+ is_emp+
              ' , @FL_TPDOC=' + quotedStr( auxInserirDoc[i]) +
              ' , @NR_DOCORI= 0,@SR_DOCORI=''0         '',@IS_REMESSACONT=Null' ;
      lista.Add(cmd);
   end;

// inserir na dsdocR
   for i:=2 to 3 do
   begin
       cmd := ' exec stoInserirDSDOCR  ' +
              '   @IS_FILIAL= '+ uo +
              ' , @IS_DOC= '+  is_doc[i] +
              ' , @IS_FILIALREF= ' + uo +
              ' , @IS_DOCREF= ' +is_doc[1] ;
       lista.Add(cmd);
   end;

// inserir o alor da dnota
   CMD := ' Exec stoInsertDNOTA ' +
          ' @IS_NOTA = ' + is_nota +
          ' , @CD_CCT = 0 ' +
          ' , @IS_DOC = '+ is_doc[1] +
          ' , @IS_ESTOQUE = ' + uo +
          ' , @CD_CFO = 9999' +
          ' , @IS_OPER = '+ is_oper +
          ' , @CD_OBS = 0' +
          ' , @CD_USU = ' + usuario +
          ' , @IS_FILDEST = null, @IS_ESTDEST = null, @DT_CANC = null ' +
          ' , @DT_DIG = '+ dataDev +
          ' , @DT_EMIS = '+ dataDev +
          ' , @DT_ENTSAI = '+  dataDev +
          ' , @CD_EVECTB ='''' , @CD_CX = null , @CD_TIPV = 0' +
          ' , @NR_DOCF = ' +  numNF +
          ' , @NR_PED = 0, @PC_DESC = 0, @SR_DOCF = ''GE'' ' +
          ' , @ST_NF = '''', @ST_TRAM=NULL, @TP_NFV=NULL, @VL_DESC=0, @VL_JURO=0'+
          ' , @VL_NOTA = '+ strValor +
          ' , @VL_TOT = ' + strValor +
          ' , @CD_VEND =0, @NR_DOCVEN = null, @TP_DOCVEN=D' + #13+
          ' , @CD_PES = ' + codCli +
          ' , @FL_DNOTB = null, @FL_DNOTC=null, @FL_DNOTD=null, @VL_BSICMSFNt=null' +
          ' , @VL_ICMSFNT=null, @VL_FRETE=0, @VL_SEGURO=0, @VL_DSPACES=0, @VL_DSPEXTRA=0'+
          ' , @VL_BSIPI=0, @VL_IPI=0, @VL_AGREGADO=0, @FL_IPIAPOSDESC=0'+
          ' , @IS_EMP = '+ is_Emp +
          ' , @TP_PRECO = '+ tipoPreco +
          ' , @CD_MVE=0, @FL_MENSAL=null, @NR_DIASPARC=null' +
          ' , @TP_MVE = null, @FL_FINPROPRIO = null, @FL_PARIG =null, @FL_PROM = null ' +
          ' , @PC_JUROS =null, @VL_COEF = null, @NR_DIAENT = null , @PC_ENTMIN =null ' +
          ' , @NR_PARC = null, @FL_ENTRADA=1, @TP_EMIS=0, @VL_ICMSFRETE=0, @ValorBaseIcmsSubstituido=0 ' +
          ' , @ValorBaseIcmsAntecipado=0, @ValorBaseIcmsReduzido=0, @ValorBaseIcmsDiferido=0'+
          ' , @ValorIcmsSubstituido=0, @ValorIcmsAntecipado=0' +
          ' , @ValorIcmsReduzido=0, @ValorIcmsdiferido=0, @TipoPrecoSugerido=101, @ValorDescontoItens=0 '+
          ' , @ImprimiuAcrescimo=0, @ValorResidualDescontoItens=0'+
          ' , @SerieECF=null, @NumeroECF=mull, @GeradaPeloSistema=0, @ValorPercentualDesconto=0 '+
          ' , @Observacao = ''devolucao de produtos da lista  ' +nLista + ''' '   +
          ' , @SeqOrdemSeparacao = null, @DescontoIcms = null, @NumeroSelo =null ' +
          ' , @SerieSelo=null, @NumeroDoECF=null, @NumeroFormulario=null '+
          ' , @MotivoDevolucao = ''Dev itens lista'' ' +
          ' , @DataSeloAntecipacao=null, @UOPagto='+uo+ ' , @ValorBaseComissao=0, @SeqFator=0 '+
          ' , @fator=0, @ValorOriginal=0';
    lista.Add(cmd);

// inserir os valores de icms da nota
    cmd := 'exec StoInsertDNOTC ' +
           '   @IS_ESTOQUE= '+ uo +
           ' , @IS_NOTA= ' + is_nota +
           ' , @NR_ITEM= 1, @PC_ICM= 0 , @TP_ENTSAI=Null , @TP_ICM= 2 ' +
           ' , @VL_BASE= '+ strValor +
           ' , @VL_BASFRE=Null , @VL_FRE=Null  '+
           ' , @VL_ICM= 0 ' +
           ' , @VL_IPI=Null , @ValorSubstituido=Null , @BaseSubstituida=Null ';
    lista.Add(cmd);

// inserir na dmovi


    cmd := getStrInsertDmovi( sq_dlest,  is_doc[1], is_movi, uo, codCli, is_oper, is_ref, dataDev, is_nota, usuario, numNf, strValor, is_emp, sq_opf, is_lanc );
{
   cmd := ' exec stoInsertDMOVI '+
          '   @IS_MOVI = '+ is_movi +
          ' , @IS_ESTOQUE = ' + uo +
          ' , @CD_PES = '+ codCli +
          ' , @IS_TPCTE = 6 ' +
          ' , @IS_OPER = '+ is_oper +
          ' , @IS_REF = '+is_ref +
          ' , @DT_MOVI = '+ dataDev +
          ' , @IS_NOTA = '+ is_nota +
          ' , @CD_USU = '+usuario +
          ' , @CD_VEND = null ' +
          ' , @DT_DIG = '+ dataDev +
          ' , @DT_EMIS ='+ dataDev +
          ' , @FL_VPROM = '''' '+
          ' , @NR_DOCF = ' + numNF +
          ' , @NR_ITEM = 1' +
          ' , @NR_PEDF = 0 , @FT_CONV = 1, @PC_DESC = 0 , @PC_IPI = 0 '+
          ' , @PR_TABELA = '+ strValor +
          ' , @QT_BON = 0 , @QT_DESP =0 , @QT_MOV = 1 '+
          ' , @SR_DOCF = ''GE'' ' +
          ' , @ST_MOV = '''' , @VL_COMIS = 0, @VL_DESC = 0, @VL_JURO=0, @VL_PESO=0, @PC_ICM=0 '+
          ' , @VL_MOVEST = ' + strValor +
          ' , @TP_ICM = 2' +
          ' , @VL_ITEM = ' + strValor +
          ' , @VL_RATEIOAG =0, @QT_EMB=1'+
          ' , @CL_DOCMOV = 1 , @NR_DOCMOV = 0 , @CL_DOCREF = 0 , @NR_DOCREF = null '+
          ' , @IS_EMP = ' + is_emp +
          ' , @SQ_OPF = ' + sq_opf +
          ' , @IS_DOC = ' + is_doc[1] +
          ' , @VL_CUSTOVEND = 0 '+
          ' , @SQ_DLEST = '+ sq_dlest + //is_lanc[1]**** +
          ' , @VL_CUSTOCONT=0, @QT_SLDATU=0 '+
          ' , @VL_SLDATU =0 ' +
          ' , @IS_LANC = '+ is_lanc[1] +
          ' , @IS_LANC1 = '+ is_lanc[2] +
          ' , @IS_LANC2 = '+ is_lanc[3] +
          ' , @PercIcmsReducao =0 , @PercIcmsAgregacao = 0' +
          ' , @ValorBaseIcms =0 , @PercIcmsVendaEntrada =0' +
          ' , @CodCFO = ''9999''' +
          ' , @ValorFiscalDocumento = 0, @ValorIcms = 0' +
          ' , @SitTributariaTabelaA = ''0'', @SitTributariaTabelaB = ''0'', @VL_DESCRAT =0' +
          ' , @IS_UOORIGEM = '+ uo +
          ' , @IS_MOVIORIGEM = '+ uo +
          ' , @ValorJurosRateado =0 '+
          ' , @ValorPrecoSugerido = '+strValor +
          ' , @TipoPrecoSugerido = 101' +
          ' , @PrecoUnitarioLiquido = '+strValor +
          ' , @ValorResidualDesconto = 0 '+#13+
          ' , @IS_TPMVE = 6, @ValorIPI = 0' +
          ' , @IS_ESTOQUE_Destino = '+ uo +
          ' , @PrecoUnitarioFornecedor = 0'+
          ' , @VL_BSIPI=0, @CodVendedor2=0'+
          ' , @DescIcmsRat=0, @CodigoSituacaoTributaria=null, @VL_MOVESTCU=null, @FL_CALCCU=null ';
}
   lista.Add(cmd);

// inserir na tabela de vendas da loja
   cmd := ' exec StoInsertDDOCV ' +
          '   @IS_FILIAL= ' + uo +
          ' , @IS_DOCV= ' + is_docv +
          ' , @NR_PED= 0 ' +
          ' , @IS_OPER= '+ is_oper +
          ' , @CD_PES= ' + codCli +
          ' , @DT_VENDA= ' + dataDev +
          ' , @IS_FILIALDEST= '+ uo +
          ' , @IS_TPCTV=Null, @IS_TPMVV=Null, @PC_DESCONTO= 0 ' +
          ' , @ST_VENDA=Null, @TP_NFV=Null, @VL_AGREGADO= 0,@VL_DESCONTO= 0 '+
          ' , @VL_FRETE= 0, @VL_JURO= 0'+
          ' , @VL_VENDA= ' +   strValor +
          ' , @DT_FATURAMENTO = '+ dataDev+
          ' , @CD_TIPV=Null,@CD_VEND=Null,@IS_NOTA=Null,@FL_EXTERNO=Null,@CD_MVE=Null '+
          ' , @FL_MENSAL=Null,@NR_DIASPARC=Null,@TP_MVE=Null,@FL_FINPROPRIO=Null,@FL_PARIG=Null'+
          ' , @FL_PROM=Null,@PC_JUROS= 0,@VL_COEF=Null,@NR_DIAENT=Null,@PC_ENTMIN=Null '+
          ' , @NR_PARC=Null,@FL_ENTRADA=1,@NR_DOCVEN=Null,@VL_ENTRADA=Null' +
          ' , @TP_DOCVEN=''D'''+
          ' , @IS_DOC= '+is_doc[1] +
          ' , @CODCONVENIADA=Null,@CodFuncionarioConveniada=Null,@NumAutorizacaoConvenio=Null ' +
          ' , @VendaSubsidiada=Null,@ValorDescontoItens= 0,@TipoPrecoSugerido=Null '+
          ' , @ImprimiuAcrescimo=Null,@ValorResidualDescontoItens=Null ' +
          ' , @ValorProdutos= ' + strValor +
          ' , @DescontoIcms= 0 ';
   lista.Add(cmd);

// inserir na dlanv
   cmd := ' exec StoInsertDLANV '+
           '   @SeqFilial= '+ uo +
           ' , @IS_LANV= ' + is_lanv +
           ' , @is_ref= '+ is_ref +
           ' , @IS_DOCV='+ is_docv +
           ' , @is_Oper= '+ is_oper +
           ' , @IS_MOVI= '+ is_movi +
           ' , @CD_VEND=Null,@PC_DESCONTO= 0 '+
           ' , @PR_TABELA= ' + strValor +
           ' , @qt_mov= 1  ' +
           ' , @VL_COMIS= '+ strValor +
           ' , @VL_CUSVEND= 0, @VL_DESCONTO= 0,@VL_MEDVEND= 0,@VL_RATEIOAGREG= 0,@TP_PRECO= 0 '+
           ' , @VL_VENDA= ' + strValor +
           ' , @PR_VENDA= ' + strValor +
           ' , @VL_RATEIODESC= 0,@VL_RATEIOFRETE= 0 ' +
           ' , @VL_CUSTOCONT= '+ strValor +
           ' , @ValorJurosRateado= 0,@ValorPrecoSugerido= 0,@TipoPrecoSugerido= 0 '+
           ' , @PrecoUnitarioLiquido= ' + strValor +
           ' , @ValorResidualDesconto= 0,@ValorRateioPercDesconto= 0,@DescIcmsRat= 0 ';
   lista.Add(cmd);

   cmd := 'update dlest set qt_sldatu = ' + floatToStr(qt_sldatu + 1)     +
                            ' , vl_custoVend = null '                      +
                            ' , vl_mov = ' +   ValorSql(FloatToStr(valor))              +
                            ' , custounitario = ' + valorSql(FloatToStr(custoU))        +
                            ' , custoMedioUnitario = ' + valorSql(custoM)   +
                            ' , custoMedioUnitarioUnico = ' + custoMU +
                            ' , vl_custocont = ' +    vl_custocont +
                            ' , vl_sldatu = ' + valorDoSaldo +
                            ' Where is_lanc = ' + is_lanc[1];
    lista.Add(cmd);

// inserrir o adiantamento
   cmd := ' EXEC SP_INC_DSADI ' +
          '   @COD_EMP = '+ empresa +
          ' , @COD_EST = 1 , @CONTABILIZ = '''' '+
          ' , @DAT_ADI = ' + dateToInteiro(dataDev) +
          ' , @DAT_PRE = 0, @HISTORICO = ''Gerado pelo programa das listas nota  '+srNota +'-'+ numNF  + ' ''' +
          ' , @ID_ADI = '''' ' +
          ' , @NUM_CLI = ' +  codCli +
          ' , @OPC_CTADEB = '''''+
          ' , @TIP_ADI = ''D'' ' +
          ' , @VAL_ADI = ' + strValor +
          ' , @CTA_CREDIT = 0 , @CTA_DEBITO = 0, @INTERV_CRE = 0, @INTERV_DEB = 0, @CTA_GFI = 0 ' +
          ' , @LOJA_ORIGEM = ' + codLoja +
          ' , @VAL_CALC = ' + strValor +
          ' , @IS_OPER = '+ is_oper +
          ' , @COD_USU = '+ quotedstr(codUsuADM)  +
          ' , @COD_USU_AUTOR = '''', @VAL_DESP = 0 ' ;
    lista.add(cmd);

//    lista.SaveToFile('c:\zComandosDEvolucaoLista.txt');
    for i:=0 to lista.Count-1 do
      funcSql.execSQL(lista[i], Conexao);
end;


function getUsuariosPorLoja(Connection : TADOConnection; loja:string):TStrings;
var
   lista:Tstringlist;
   qr:TADOQUery;
   str:String;
begin
   str:= 'Select nm_usu, cd_usu from dsusu where cd_pes in (select distinct cd_pes from usuariosUo with(nolock) where is_uo = ' + loja + ' )and fl_ativo = 1  order by nm_usu';
   qr := TADOQUery.create(nil);
   AbrirQuery(qr, connection, str );
   qr.First;

   lista := Tstringlist.Create();
   while qr.Eof = false do
   begin
     lista.add( funcoes.preencheCampo(100,' ','d',qr.fieldByname('nm_usu').asString) +     qr.fieldByname('cd_usu').asString);
     QR.Next;
   end;
   result := lista;
end;

function getgruposWell(Connection : TADOConnection ):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('Select nm_grusu, cd_grusu from dsgrusu with(nolock) order by nm_grusu') ;
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;

function inserirToper(usuario,sq_opf,codTransacao,fl_entrada:string;conexao:TADOConnection):string;
var
   is_oper,cmd:string;
begin
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador is_oper, @P1 output, 0   select @P1 as is_oper  end';
   is_oper := funcSql.GetValorWell( 'O', cmd, 'is_oper',  conexao );
   cmd := 'Exec stoInsertToper @is_oper = ' + is_oper + ' ,'+#13+
           '@DT_OPER= ' + funcoes.DateTimeToSqlDateTime(dateToStr(now), '') + ' ,'+#13+
           '@IS_EMP= 10033585 , @SQ_OPF='+sq_opf +' , ' +#13+
           '@DT_TRAB= ' + funcoes.DateTimeToSqlDateTime(dateToStr(now),timeToStr(now))  + ' ,'+#13+
           '@CD_USUARIO= '+ usuario + ' , @CodTransacao='+ codTransacao +' , @CodUsuAutWMS=Null ' ;
   if fl_entrada = '1' then
      cmd := cmd + ' , @FL_ENTRADA=''1'''
   else
      cmd := cmd + ' , @FL_ENTRADA=''1''' ;
   funcSql.execSQL( cmd , Conexao);
   result := is_oper;        {}
end;


function gerarRequisicao(Conexao:TADOConnection; tb:TADOTable; uo,usuario:String;mostraNumero, ehReqDeVenda :Boolean; var ocoItens:TStringList ;QT_DIAS_PEND:integer):String;
var
  cd_pes,is_planod,cmd, codTransacao,sq_opf,is_oper:String;
  lista:TStringList;
  is_movpd:integer;
  nItensReq, i:integer;
  UO_CD:String;
//  gravaItens:boolean;
  estReqCD:integer;
begin
//   if funcSQL.lerParamBD('salvaItensReqPastaLog','', Conexao) = '1' then
//      gravaItens:= true
//   else
//      gravaItens:= false;

   nItensReq := 0;
   // pegar o is_uo do cd
   UO_CD := openSQL('Select valor from zcf_paramGerais where nm_param = ''uocd'' ', 'valor', Conexao);

   lista:= Tstringlist.Create();
   sq_opf := '10000031'; // cod daTransacao integrada de requisicao
   codTransacao := '4';  // tipo de transacao

   try
      // obter o cd_pes
      cd_pes := funcSql.GetValorWell( 'O', 'select cd_pes from dsusu where cd_usu = '+ usuario, 'cd_pes', conexao );

      is_oper := inserirToper( usuario, sq_opf, codTransacao ,'', Conexao  );

      //obter o plano
      cmd := ' begin declare @P1 int  set @P1=0 exec zcf_stoObterContadorCF ''is_planod'' , @P1 output, @qt = 1  select @P1 as is_planod end';
      is_planod := funcSql.GetValorWell( 'O', cmd, 'is_planod', conexao );

       cmd :=  ' exec StoInsertPlanoDistribuição ' +#13+
                 '@DT_PLANOD=' + funcoes.DateTimeToSqlDateTime(dateToStr(now), '')  +' , '+#13+
                 '@IS_PLANOD=' + is_planod +' , '+#13+
                 '@cd_usu=' + cd_pes       +' , '+#13+
                 '@is_oper='+ is_oper      +' , '+#13+
                 '@is_tpdoc=5'             +' , '+#13+
                 '@is_estoque=10033674 , ' +#13+
                 '@IS_EMP=10033585 , @ST_PD=''2'' , @TP_PLANOD=4 , @CDPES=0 ';
       lista.add(cmd);

       tb.First;
       i:=1;
       while tb.Eof = false do
       begin
          estReqCD :=  funcSQL.getEstoqueParaRequisicao(tb.fieldByname('is_ref').AsString, UO_CD, Conexao);

          if (tb.FieldByName('Qt Pedida').AsInteger >  estReqCD ) and ( ehReqDeVenda = false ) then
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('descricao').AsString  +  '  -  Não possui estoque disponível.')
          else if (ehReqDeVenda = false) and (isReqPendProduto( conexao,  uo, tb.fieldByname('is_ref').AsString, QT_DIAS_PEND).IsEmpty = false ) then
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('descricao').AsString  +  '  -  Existem requisições pendentes.')

          else
          begin
//             if gravaItens = true then
//                funcoes.GravaLinhaEmUmArquivo( extractFilePath(paramStr(0)) +'\logs\'+ application.Name +'_Requisicoes.txt',' req '+ is_planod+ ': '+' Item: ' + intToStr(tb.RecNo) + tb.fieldByName('codigo').asString +' qt: '+ tb.fieldByName('qt pedida').asString );
             inc(is_movpd);
             is_movpd := StrToInt( funcSql.GetValorWell( 'O', ' begin declare @P1 int  set @P1=0 exec zcf_stoObterContadorCF ''IS_movpd'' , @P1 output, @qt = '+ intToStr(tb.RecordCount) +   ' select @P1 as ''IS_movpd''  end', 'IS_movpd', conexao ));
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
      if nItensReq > 0 then
      begin
         for i:=0 to lista.Count-1 do
            execSQL(lista[i], Conexao);
         if mostraNumero = true then
           msgTela('',' Gerada a requisição: ' + is_planod, MB_ICONASTERISK + MB_ok);
         result := is_planod;
      end
      else
      begin
          execSQL('exec stoExcluirPlanoDistribuicao ' + is_planod, Conexao);
          msgTela('',' Não foi gerada nenhuma requisição.', MB_ICONERROR + MB_ok);
          result := '';
      end;
   except
      on e:Exception do
      begin
         msgTela('','Ocorreu um erro: ' +#13+ e.Message , mb_ok);
         result := '';
      end
   end;
end;

function criaTabelaTemporaria(conexao:TADOConnection; camposTabela:String):String;
var
   nTable :String;
begin
   nTAble := funcsql.getNomeTableTemp;

   if ( pos('(' , trim(copy(camposTabela,01,02))) <= 0 ) then
      camposTabela := '( ' + camposTabela + ' )';

   execSQL( 'create table ' +nTAble +  camposTabela, conexao );

   result := nTable;
end;

function isHoraPermitida(conexao:TADOConnection; tela:integer; grupo:String):boolean;
var
   qr:TADOQuery;
   hour:integer;
   isPermitido:Boolean;
   str:String;
begin
   isPermitido := true;
   hour := StrToInt(openSQL('Select DATEPART ( hour , getdate()) as hora', 'hora', conexao ) );

   qr := TADOQuery.Create(nil);
   qr.Connection := conexao;
   qr.sql.add('Select codTela, codgrupo, horI, horF from  zcf_horBloqRel (nolock) where codTela = ' + intToStr(tela)  + ' and codGrupo = ' + grupo);
   qr.Open;

   if qr.IsEmpty  = false then
   begin
      qr.First;
      while qr.Eof = false do
      begin
         if ( hour >= qr.FieldByName('horI').asInteger ) and( hour <= qr.FieldByName('horF').asInteger ) then
         begin
            isPermitido := false;
            break;
         end;
         qr.Next;
      end;

      if isPermitido = false then
      begin
         qr.First;
         while qr.Eof = false do
         begin
            str := str+ '       De ' +  qr.FieldByName('horI').asString + ':00 as ' + qr.FieldByName('horf').asString+':00. '+#13;
            qr.Next;
          end;
          str := ' Esse relatório é bloqueado para geração nos seguintes horários: ' + #13 + str;
          qr.Close;
          msgTela('',str, MB_OK + MB_ICONERROR);
      end;
   end;
   result := isPermitido
end;


procedure openTempTable(tb:TADOTable; descricaoDosCampos:String; conexao:TADOConnection);
var
   nTable, cmd:String;
begin
   if tb.TableName <> '' then
      tb.close;
   nTable := funcSQl.getNomeTableTemp;
   tb.Connection := conexao;
   cmd := ' Create table ' + nTable +  '( ' +  descricaoDosCampos+ ' )';
   funcsql.execSQL(cmd, conexao);
   tb.TableName := nTable;
   tb.Open;
end;

function getUsersList(conexao:TADOConnection; cmd:String):String;
var
   qr:TADOQuery;
   continua:Boolean;
   aux:String;
begin
   qr := TADOQuery.Create(nil);
   getQuery( conexao, qr, cmd);
   continua := not(qr.IsEmpty);
   aux := '';
   while continua = true do
   begin
      aux := aux + qr.Fields[0].AsString;
      qr.Next();
      if qr.Eof = false then
         aux := aux + ', '
      else
         continua := false;
   end;
   qr.Destroy();
   result := aux;
end;

function gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor :String; conexao:TADOConnection ):Boolean;
var
  strData, cmd: String;
  dadosUsrAut:TStrings;
begin
   // pegar a data do bd
   strData := funcoes.SohNumerosPositivos( getDataBd(conexao) );


   // pegar os dados do usuario autorizador
   dadosUsrAut :=  TStringList.Create();
   dadosUsrAut := funcSQl.GetValoresSQL2('Select nm_usu, p_cod_usu from dsusu where cd_usu = ' + usAutorizador, conexao);


   cmd := ' exec [SP_INC_DSADI] ' +
          '  @COD_EMP= ' + cod_emp  +
          ', @COD_EST=1, @CONTABILIZ= '''' '  +
          ', @DAT_ADI = ' + strData +
          ', @DAT_PRE= 0' +
          ', @HISTORICO = ' +  quotedStr('Gerado por ' + dadosUsrAut[0] ) +
          ', @ID_ADI = '''' ' +
          ', @NUM_CLI = ' + num_cli +
          ', @OPC_CTADEB = '''' ' +
          ', @TIP_ADI = ''D'' ' +
          ', @VAL_ADI = ' + funcoes.ValorSql(valor) +
          ', @CTA_CREDIT = ''0'' ' +
          ', @CTA_DEBITO = ''0'' ' +
          ', @INTERV_CRE = ''0'' ' +
          ', @INTERV_DEB = ''0'' ' +
          ', @CTA_GFI = ''0'' '    +
          ', @LOJA_ORIGEM = ' + loja +
          ', @VAL_CALC = ' + funcoes.ValorSql(valor) +
          ', @IS_OPER = 0 '+
          ', @IS_DOC = 0 ' +
          ', @COD_USU = ' + quotedstr(dadosUsrAut[1]) +
          ', @COD_USU_AUTOR = '''' ' +
          ', @VAL_DESP  = 0.00 ';
   result :=  execSQL(cmd, conexao);
end;


function getEmpregadosPonto(conexao:TadoConnection):TStrings;
var
   qr:TADOQuery;
   lst:TstringList;
begin
  getQuery(conexao, qr, 'select nome, cartaoponto from zcf_pontoEmpregados (nolock) order by nome' );
  lst := TStringList.Create();
  qr.First();
  while( qr.Eof = false ) do
  begin
     lst.Add (funcoes.preencheCampo(100,' ','D', qr.fieldByname('nome').asString ) + qr.fieldByname('cartaoPonto').asString );
     qr.Next();
  end;
  qr.Destroy();
  result := lst;
end;

function getDataBd(conexao:TADOConnection):String;
begin
   result := getDataBd(conexao,0) ;
end;

function getDateBd(conexao:TADOConnection):TDate;
var
   aux:String;
begin
   aux := getDataBd(conexao, 0);
   result := strToDate( copy(aux, 10, 02) +'/'+ copy(aux, 07, 02) +'/'+ copy(aux, 02, 04));
end;

function getDataBd(conexao:TADOConnection ; diasARecuar:integer):String; overload;
var
  str:string;
begin
   str := funcsql.GetValorWell( 'O', 'Select getDate()- ' + intToStr(diasARecuar) + ' as data', 'data',  conexao );
   result := quotedStr(copy(str,07,04) +'-'+ copy(str, 04,02) +'-'+ copy(str,01,02));
end;

function getOperIntegradasFiscais(conexao:TADOConnection):TStrings;
var
  ds:TDataSet;
  aux:TStringlist;
begin
   ds := funcsql.getDataSetQ('select substring(ds_res,01,50) as ds_res, cast(sq_opf as  varchar(10)) as sq_opf from topi (nolock) ' +
                             'where cd_cfoI is not null and  cd_cfoI > 0 order by ds_res ', conexao);
   aux := TStringList.Create();
   while (ds.Eof = false) do
   begin
      aux.Add( funcoes.preencheCampo(100, ' ', 'D',   ds.fieldByName('ds_res').asString) + ds.fieldByName('sq_opf').asString );
      ds.Next();
   end;
   ds.Destroy();
   result := aux;
end;

function setParamBD(parametro, uo, valor:String; conexao:TADOConnection):boolean;
var
   cmd:String;
begin
   if getParamBD(parametro, uo, conexao) <> '' then
      cmd := ' update zcf_paramGerais set valor = ' +  quotedstr(valor) + ' where nm_param = ' + quotedstr(parametro) + ' and  uo = ' + quotedstr(uo)
   else
      cmd := ' insert zcf_paramGerais (valor, nm_param, uo ) values ('+quotedstr(valor) +', '+ quotedstr(parametro) + ' , ' +quotedstr(uo) + ')';
   result :=    execSQL(cmd,conexao);
end;

function getHint(nObjeto:String; conexao:TADOConnection):String;
begin
   result := openSQL('Select hint from zcf_hints where nome = ' + quotedStr(nObjeto), 'hint', conexao );
end;

function getMediaDeUmaColuna(cnnection:TADOConnection; ds:TDataSet; coluna:String):String;
begin
   result := floatToStr( somaColunaTable( ds, coluna) / ds.RecordCount) ;
end;

procedure carregaTabelaTemporaria(conexao: TADOConnection; var tabela:TADOTAble; cmdCarga:String);
begin
end;


function getStrInsertDmovi(sq_dlest, is_doc, is_movi, uo, codCli, is_oper, is_ref, dataDev, is_nota, usuario, numNf, strValor, is_emp, sq_opf:String;  is_lanc: TStringList ):String;
begin
   result :=
' exec stoInsertDMOVI '+
          '   @IS_MOVI = '+ is_movi +
          ' , @IS_ESTOQUE = ' + uo +
          ' , @CD_PES = '+ codCli +
          ' , @IS_TPCTE = 6 ' +
          ' , @IS_OPER = '+ is_oper +
          ' , @IS_REF = '+is_ref +
          ' , @DT_MOVI = '+ dataDev +
          ' , @IS_NOTA = '+ is_nota +
          ' , @CD_USU = '+usuario +
          ' , @CD_VEND = null ' +
          ' , @DT_DIG = '+ dataDev +
          ' , @DT_EMIS ='+ dataDev +
          ' , @FL_VPROM = '''' '+
          ' , @NR_DOCF = ' + numNF +
          ' , @NR_ITEM = 1' +
          ' , @NR_PEDF = 0 , @FT_CONV = 1, @PC_DESC = 0 , @PC_IPI = 0 '+
          ' , @PR_TABELA = '+ strValor +
          ' , @QT_BON = 0 , @QT_DESP =0 , @QT_MOV = 1 '+
          ' , @SR_DOCF = ''GE'' ' +
          ' , @ST_MOV = '''' , @VL_COMIS = 0, @VL_DESC = 0, @VL_JURO=0, @VL_PESO=0, @PC_ICM=0 '+
          ' , @VL_MOVEST = ' + strValor +
          ' , @TP_ICM = 2' +
          ' , @VL_ITEM = ' + strValor +
          ' , @VL_RATEIOAG =0, @QT_EMB=1'+
          ' , @CL_DOCMOV = 1 , @NR_DOCMOV = 0 , @CL_DOCREF = 0 , @NR_DOCREF = null '+
          ' , @IS_EMP = ' + is_emp +
          ' , @SQ_OPF = ' + sq_opf +
          ' , @IS_DOC = ' + is_doc +
          ' , @VL_CUSTOVEND = 0 '+
          ' , @SQ_DLEST = '+ sq_dlest +
          ' , @VL_CUSTOCONT=0, @QT_SLDATU=0 '+
          ' , @VL_SLDATU =0 ' +
          ' , @IS_LANC = '+ is_lanc[1] +
          ' , @IS_LANC1 = '+ is_lanc[2] +
          ' , @IS_LANC2 = '+ is_lanc[3] +
          ' , @PercIcmsReducao =0 , @PercIcmsAgregacao = 0' +
          ' , @ValorBaseIcms =0 , @PercIcmsVendaEntrada =0' +
          ' , @CodCFO = ''9999''' +
          ' , @ValorFiscalDocumento = 0, @ValorIcms = 0' +
          ' , @SitTributariaTabelaA = ''0'', @SitTributariaTabelaB = ''0'', @VL_DESCRAT =0' +
          ' , @IS_UOORIGEM = '+ uo +
          ' , @IS_MOVIORIGEM = '+ uo +
          ' , @ValorJurosRateado =0 '+
          ' , @ValorPrecoSugerido = '+strValor +
          ' , @TipoPrecoSugerido = 101' +
          ' , @PrecoUnitarioLiquido = '+strValor +
          ' , @ValorResidualDesconto = 0 '+#13+
          ' , @IS_TPMVE = 6, @ValorIPI = 0' +
          ' , @IS_ESTOQUE_Destino = '+ uo +
          ' , @PrecoUnitarioFornecedor = 0'+
          ' , @VL_BSIPI=0, @CodVendedor2=0'+
          ' , @DescIcmsRat=0, @CodigoSituacaoTributaria=null, @VL_MOVESTCU=null, @FL_CALCCU=null ';
end;


function getCustoPorData(uo,is_ref, data:String; conexao:TADOconnection):String;
var
   cmd:String;
begin
   if ( strToDate(data) <> now ) then
   begin
      cmd := ' Select top 01 custoUnitario from dlest (nolock)' +
             ' inner join toper on dlest.is_oper = toper.is_oper'+
             ' where is_ref = ' + is_ref +
             ' and toper.dt_trab  <= ' + funcDatas.dateToSqlDate(data) +
             ' and is_estoque = ' + uo +
             ' order by is_movi desc';
       cmd := openSQL(cmd, 'custoUnitario', conexao ) ;
   end
   else
   begin
      cmd :=  ' Select top 01  custoUnitario from dlest (nolock)' +
              ' inner join toper on dlest.is_oper = toper.is_oper where is_ref = ' + is_ref +
              ' and custoUnitario > 0 rder by is_movi desc ';
      cmd := openSQL(cmd, 'custoUnitario', conexao ) ;
   end;

   if( cmd = '' )then
      cmd := '0';
   result := cmd;
end;

function isReqPendProduto(conexao:TADoConnection; uo, is_ref:String; QT_DIAS_PEND:integer ): TDataSet;
var
  cmd:String;
begin
   cmd :=  'Select top 01 * from dspdi (nolock) where is_ref = '+is_ref +
           ' and is_estoque = '+ uo +' and qtdtransferida <> qt_ped' +
           ' and dt_movpd > ' + funcDatas.dateToSqlDate(now -QT_DIAS_PEND);
   result := getDataSetQ(cmd, Conexao );
end;
end.


