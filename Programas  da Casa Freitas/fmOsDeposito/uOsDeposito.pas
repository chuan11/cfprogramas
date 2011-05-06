{
  PERFIL = 2 REQUISICAO DE AASTECIMENTO
  PERFIL = 1 REQUISICAO DE VENDA
  PERFIL = 3 TELA DE APROVAÇÃO
}
unit uOsDeposito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, TFlatButtonUnit, Math,
  StdCtrls, fCtrls, ADODB, DB, ExtCtrls, adLabelComboBox;

type
  TfmOsDeposito = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    Panel1: TPanel;
    btNova: TFlatButton;
    FlatButton2: TFlatButton;
    Query: TADOQuery;
    cbCritica: TfsCheckBox;
    cbLojas: TadLabelComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNovaClick(Sender: TObject);
    procedure GetDadosProdutos(cod:string);
    procedure gridColExit(Sender: TObject);
    procedure travaGrid(Sender:Tobject);
    procedure destravaGrid(Sender:Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function criticaQuantidade(Sender:TObject):String;
    procedure tbPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction); procedure tbAfterPost(DataSet: TDataSet);
    procedure gridDblClick(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure gridKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure tbBeforePost(DataSet: TDataSet);
    procedure cbCriticaClick(Sender: TObject);
    procedure tbAfterCancel(DataSet: TDataSet);
    function  existeQuantidadePendente(uo, is_ref:String; showErro:boolean): Boolean;
    function  isEmSeparacao(is_ref:String; mostraMsgErro:boolean):Boolean;
    procedure preparaParaRequisicaoNormal(Sender:Tobject);
    procedure preparaParaLiberarRequisicao(Sender:Tobject);
    procedure criaTabela(Sender:Tobject; var table:TADOTable);
    procedure carregaTabelaRequisicao(Sender: TObject; uo:String);
    procedure formatarGrid(Sender:Tobject);
    procedure salvaReqVenda(Sender:Tobject);
    procedure salvaReqAbastecimento(Sender:Tobject);
    procedure cbLojasClick(Sender: TObject);
    procedure geraRequisicaoReabastecimento(Sender:Tobject);
    procedure SetPerfil(P:integer; uoCD:String);
    procedure emailParaCD(nReq,de:String);
    function getValorMaxPedReabatecimento():Integer;
    function verificaRequisicaoAberta():Boolean;
    procedure fechaSessaoRequisicao(uo:String);
    procedure bloqueiaSessaoRequisicao(uo:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmOsDeposito: TfmOsDeposito;
  DUR_ESTOQUE, MESES_VD_MEDIA, MAX_ITENS_REQ, PERFIL,  QT_DIAS_PEND: integer;
  PEDE_PROD_MAISON,IS_REQ_SALVA:Boolean;
  IS_CRITICA_VD_MEDIA, UO_CD, PC_VAREJO, COL_UO_MAPA_SEPARACAO:String;
implementation

uses umain, funcoes, funcSQL, verificaSenhas, funcDatas;
{$R *.dfm}

procedure TfmOsDeposito.bloqueiaSessaoRequisicao(uo: String);
var
   cmd:String;
begin
   cmd := 'if not exists (select * from zcf_paramGerais where nm_param = ''osDeposito.reqAberta'' and uo = ' + uo + ' ) ' + #13+
          'insert zcf_paramGerais values (''osDeposito.reqAberta'',' + uo + ', ' + quotedStr(fmMain.getNomeUsuario()) + ', ''-'' )';
   funcsql.execSQL( cmd, fmMain.Conexao );
end;


procedure TfmOsDeposito.fechaSessaoRequisicao(uo: String);
begin
   funcsql.execSQL('delete from zcf_paramGerais where nm_param = ''osDeposito.reqAberta'' and uo = ' + uo, fmMain.Conexao );
end;
         
function TfmOsDeposito.verificaRequisicaoAberta: Boolean;
var
   uo:String;
begin
   if (PERFIL = 2) then
      uo := fmMain.getUoLogada();
   if ( PERFIL = 3 ) then
     uo := funcoes.getNumUO(cbLojas);

   uo := funcSql.openSQL('Select valor  from zcf_paramGerais where nm_param = ''osDeposito.reqAberta'' and  uo = ' + uo, 'valor', fmMain.Conexao );
   if (uo <> '') and (uo <> fmMain.getNomeUsuario()) then
   begin
     msgTela('', 'A lista de requisição dessa loja está aberta por: '+#13 + uo + #13+
                 'Você não pode trabalhar com essa requisição enquanto esse usuário '+#13+'a estiver usando.', MB_OK + MB_ICONERROR);
     Result := true;
   end
   else
      result := false;
end;

function TfmOsDeposito.getValorMaxPedReabatecimento():Integer;
var
  datai,dataf:Tdate;
  qtVenda,qtVendaSemestre, qtVendaMes: Real;
  diasDesdePrimVenda:integer;
  cmd:String;
begin
   if ( IS_CRITICA_VD_MEDIA <> '0' ) then
   begin
      funcoes.gravaLog ('Loja critica venda media' );
      fmMain.MsgStatus('Obtendo venda média...');
      dataf := now();

//pega quantos dias desde a primeira venda
     cmd := ' select isNull(  (select top 01  datediff( day, dt_mov, getdate()) from zcf_dsdsi (noLock) where is_ref = ' + tb.fieldByname('is_ref').AsString  + 'and is_estoque= ' + fmMain.getUoLogada() + '),1) as diasDesdePrimVenda';
     diasDesdePrimVenda :=  strToInt( funcsql.openSQL(cmd,'diasDesdePrimVenda', fmMain.Conexao) ) ;


     if (diasDesdePrimVenda  > (MESES_VD_MEDIA * 30)) then
     begin
        datai := now - (MESES_VD_MEDIA * 30);
        diasDesdePrimVenda := (MESES_VD_MEDIA * 30);
     end
     else
        datai := now - diasDesdePrimVenda ;

//pegar a venda do ultimo semestre (ou antes, se houver)
      qtVendaSemestre := funcSQl.qtVendaProduto( tb.fieldByname('is_ref').asString, fmMain.getUoLogada(), UO_CD, datai, dataf, fmMain.Conexao) ;
      funcoes.gravaLog ( tb.fieldByname('codigo').asString + ' qtVendaUltimoSemestre: ' + floatToStr(qtVendaSemestre) );
      qtVendaSemestre :=  ( qtVendaSemestre / diasDesdePrimVenda ) * DUR_ESTOQUE;
      funcoes.gravaLog ( tb.fieldByname('codigo').asString + ' Venda Media semestre: ' + floatToStr(qtVendaSemestre) );


//pegar a venda do ultimo mes
      qtVendaMes := funcSQl.qtVendaProduto( tb.fieldByname('is_ref').asString, fmMain.getUoLogada(), UO_CD, (dataf-30), dataf, fmMain.Conexao) ;
      funcoes.gravaLog ( tb.fieldByname('codigo').asString + ' qtVendaUltimoMes: ' + floatToStr(qtVendaMes) );
      qtVendaMes :=  ( qtVendaSemestre / 30 ) * DUR_ESTOQUE;
      funcoes.gravaLog ( tb.fieldByname('codigo').asString + ' Venda Media mes: ' + floatToStr(qtVendaMes) );

      if (qtVendaSemestre > qtVendaMes) then
         qtVenda := qtVendaSemestre
      else
         qtVenda := qtVendaMes;

       if (qtVenda = 0) then
          qtVenda := 1;

      result := ( ceil( ( qtVenda / tb.fieldByname('Qt caixa').AsInteger))) * tb.fieldByname('Qt caixa').AsInteger ;
   end
   else
   begin
      funcoes.gravaLog ('Loja sem critica de venda para requisicao.' );
      result := tb.fieldByname('Est CD').AsInteger;
    end;
   fmMain.MsgStatus('');
end;

function TfmOsDeposito.isEmSeparacao(is_ref:String; mostraMsgErro:boolean):Boolean;
var
  cmd : String;
  ds:TDataSet;
  resultado:boolean;
begin
   fmMain.MsgStatus('Consultando mapa dse separação.');

   cmd := 'select i.num, isNull(i.' + COL_UO_MAPA_SEPARACAO + ',0) as qtMapa from zcf_MapaSeparacaoI i (nolock) ' +
          'inner join zcf_MapaSeparacao m (nolock) on i.num = m.num   where m.ehFinalizada <> 1 and i.is_ref = ' + is_ref;

    ds:= funcsql.getDataSetQ(cmd, fmMain.Conexao);

    if (ds.IsEmpty = true) then
       result := false
    else
       if (ds.fieldByname('qtMapa').AsInteger > 0) then
       begin
         cmd := ' Você não pode pedir esse item agora, pois existe ' +#13+
                ' um mapa de separação aberto para essa loja. ' +#13+
                ' Dados do mapa: ' + #13+
                ' Numero do mapa: ' + ds.fieldByname('num').AsString + '.' + #13+
                ' Quantidade: '+ ds.fieldByname('qtMapa').AsString + '.';
         msgTela('',cmd , MB_OK + MB_ICONERROR);
         result := true;
        end;
    ds.Destroy();
    fmMain.MsgStatus('');
end;


function TfmOsDeposito.existeQuantidadePendente(uo, is_ref:String; showErro:boolean): Boolean;
var
  ds:TdataSet;
  cmd:String;
begin
   fmMain.MsgStatus('Verificando requisição pendente.');

   ds:= funcSQL.isReqPendProduto(fmMain.Conexao, fmMain.getUoLogada, is_ref, QT_DIAS_PEND );
   if (ds.IsEmpty = false) then
   begin
       cmd :='    Já existe quantidade pedida e não transferida desse produto '+#13+
             ' a menos de ' + IntToStr(QT_DIAS_PEND)  + ' dias. ' +#13+
             ' Requisicao: ' + ds.fieldByName('is_planod').AsString + #13+
             ' Quantidade: ' + ds.fieldByName('qt_ped').AsString + #13 +
             ' Data: ' + ds.fieldByName('dt_movpd').AsString + #13;

      if (showErro = true) then
         msgTela('',cmd, MB_OK+MB_ICONERROR);

      ds.Destroy;

      if (PERFIL = 2) then
         result:= true
      else
         result:= false;
   end
   else
   begin
      ds.Destroy;
      result := false;
   end;
   fmMain.MsgStatus('');
end;


function TfmOsDeposito.criticaQuantidade(Sender: TObject):String;
var
   aux, erro:String;
begin
   aux := Query.fieldbyname('fornecedor').AsString;
   if aux = '' then aux := '0';
   aux := funcsql.GetValorWell( 'O','select codFornecedor from zcf_FornCritReq where codfornecedor = ' + aux, 'codFornecedor' , fmMain.conexao );
   if aux = '' then
   begin
     if (Query.fieldbyname('embalagem').AsInteger <> 0) and ( Query.fieldbyname('embalagem').AsInteger <> 1 ) then
        if (cbCritica.Checked = false) then
           if  ( tb.FieldByName('Qt Pedida').AsInteger  mod Query.fieldbyname('embalagem').AsInteger > 0 ) then
              erro := ' - Esse produto deve ser pedido em caixa fechada. ' + #13+ '    A caixa dele tem ' + Query.fieldbyname('embalagem').AsString  + ' unidades.' + #13;
   end;

   if (tb.Fields[1].asString = '0')  then
      erro := erro +' - Falta a quantidade. '+ #13
   else if ( tb.FieldByName('Qt Pedida').AsInteger > tb.FieldByName('Est CD').AsInteger) then
      erro := erro +' - Quantidade pedida maior que a disponivel. '+ #13

   else if ( tb.FieldByName('Qt Pedida').AsInteger > (tb.FieldByName('Est CD').AsFloat/2) ) then
      if cbCritica.Checked = false then
         msgTela('','                        AVISO'+#13+
                    'A quantidade pedida é mais da metade do que consta no CD.' +#13+
                    'Tenha certeza de que essa quantidade é mesmo necessária.', MB_ICONEXCLAMATION+MB_OK);

   if PERFIL = 2 then
      if ( tb.FieldByName('Qt Pedida').AsInteger > tb.FieldByName('Pedido Maximo').AsInteger) then
         erro := erro +' - Quantidade pedida é maior maior que o que o pedido máximo. '+ #13;

   if PERFIL = 1 then
      if (tb.RecordCount > MAX_ITENS_REQ) then
          erro := erro +' - A requisição só pode ter até ' + intToStr(MAX_ITENS_REQ) +' itens.'+ #13;

   if (erro <> '') then
      msgTela('', erro, mb_iconerror + mb_ok );
   result := erro;
end;

procedure TfmOsDeposito.GetDadosProdutos(cod:string);
var
  is_ref, cmd:string;
  ds:TdataSet;
begin
   fmMain.MsgStatus('Consultando codigo.');

   cmd :=' exec Z_CF_getInformacoesProduto ' + QuotedStr(cod) + ' , '+ UO_CD +' , '+ '-1';

   destravaGrid(nil);
   query.Connection := fmMain.Conexao;
   query.SQL.Clear;
   query.SQL.add(cmd);
   funcoes.gravaLog(cmd);
   query.Open;

   if (query.IsEmpty = true) then
   begin
      msgTela('','Este código não é cadastrado', mb_iconError+mb_ok);
      tb.Cancel;
   end
   else if (PEDE_PROD_MAISON = false) and (query.FieldByName('categoria').AsString = '15') then
   begin
      msgTela('',
                  ' O produto: ' +#13+
                  query.fieldByname('codigo').asString + ' ' + query.fieldByname('descricao').asString +#13+
                  'não pode ser pedido por essa loja ,pois é um produto da linha maison.',
              MB_OK + MB_ICONERROR);
      tb.Cancel;
   end
   else
   begin
      if (perfil =  2) then
      begin
         if isEmSeparacao( query.FieldByName('is_ref').AsString, true ) = true then
          begin
             grid.SelectedIndex := 0;
             tb.Cancel();
          end;
       end;

      if existeQuantidadePendente(fmMain.getUoLogada(), query.FieldByName('is_ref').AsString, true ) = false then
      begin
         tb.FieldByName('codigo').AsString := query.fieldByName('codigo').AsString;
         tb.FieldByName('Descricao').AsString := query.fieldByName('descricao').AsString;
         tb.FieldByName('Est CD').AsString := query.fieldByName('estoqueDisponivel').AsString;
         tb.FieldByName('qt caixa').AsString := query.fieldByName('embalagem').AsString;
         tb.FieldByName('is_ref').AsString := query.fieldByName('is_ref').AsString;

// pegar as informacoes do preco e estoque local
         fmMain.MsgStatus('Consultando dados de saldos...');
         cmd :=' exec Z_CF_getInformacoesProduto ' + QuotedStr(cod) + ' , '+ fmMain.getUoLogada() + ' , 101';
         destravaGrid(nil);
         query.Connection := fmMain.Conexao;
         query.SQL.Clear;
         query.SQL.add(cmd);
         query.Open;
         tb.FieldByName('Est Loja').AsString := query.fieldByName('EstoqueDisponivel').AsString;
         tb.FieldByName('Pc Loja').AsString := query.fieldByName('PRECO').AsString;

         if perfil = 2 then
            tb.FieldByName('Pedido Maximo').AsInteger := getValorMaxPedReabatecimento();
      end;
   end;
   travaGrid(nil);
end;


procedure TfmOsDeposito.criaTabela(Sender: Tobject; var table:TADOTable);
var
   cmd:String;
   nTable:string;
begin
   if tb.Active = true then
      tb.Close();
   nTable := funcSQl.getNomeTableTemp;
   cmd := 'Create table ' + ntable + '( Codigo varchar(13) PRIMARY KEY, [Qt Pedida] integer not null default 0, Descricao varchar(50), [Est CD] integer, [Est Loja] integer,[Pc Loja] money, [Qt caixa] integer, is_ref integer, [Pedido Maximo] int )';
   funcSql.execSQL(cmd , fmMain.Conexao);
   table.TableName := nTable;
end;

procedure TfmOsDeposito.FormActivate(Sender: TObject);
begin
   IS_REQ_SALVA:=TRUE;
   QT_DIAS_PEND := strToInt( fmMain.GetParamBD('periodoParaReqPendentes',''));

   if funcsql.getParamBD('PedeCat15DoCd', fmMain.getUoLogada(), fmMain.Conexao) <> '' then
      PEDE_PROD_MAISON := true
   else
      PEDE_PROD_MAISON := false;

   COL_UO_MAPA_SEPARACAO := 'l' + funcsql.openSQL('Select top 01 cd_uo from zcf_tbuo where is_uo = ' + fmMain.getUoLogada(), 'cd_uo', fmMain.Conexao);
   PC_VAREJO := fmMain.GetParamBD('pcVarejo', fmMain.getUoLogada() );
   MAX_ITENS_REQ := strToInt(funcsql.getParamBD('maxItensReqVenda', '' , fmMain.Conexao));
   MESES_VD_MEDIA :=  strToInt(fmMain.GetParamBD('mesesVendaMedia', '')  );
   DUR_ESTOQUE := strToInt(fmMain.GetParamBD('osDeposito.qtDiasDurEstoque', '')  );
   IS_CRITICA_VD_MEDIA := fmMain.GetParamBD('osDeposito.uosCriticaReq', fmMain.getUoLogada() ) ;
end;

procedure TfmOsDeposito.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (perfil = 2) and (tb.IsEmpty = false) then
     fechaSessaoRequisicao( fmMain.getUoLogada());

   if (perfil = 3 ) and (tb.IsEmpty = false) then
     fechaSessaoRequisicao(  funcoes.getNumUO(cbLojas) );


   fmMain.MsgStatus ('');
   fmOsDeposito := nil;
   action := caFree;
end;

procedure TfmOsDeposito.gridColExit(Sender: TObject);
begin
   if (PERFIL <> 3) then
   begin
      if ( grid.SelectedIndex = 0) and ( grid.SelectedField.AsString <> '' ) then
         GetDadosProdutos( grid.SelectedField.AsString);

      if ( grid.SelectedIndex = 1) then
         if ( tb.FieldByName('Descricao').AsString <> '' ) then
             if (criticaQuantidade(nil) <> '') then
             begin
                grid.SelectedIndex := 1;
                tb.FieldByName('Qt Pedida').AsInteger := 0;
             end
             else
             begin
                tb.Post;
                tb.Append;
                grid.SelectedIndex := 0;
             end;
   end
   else
      tb.cancel();
   fmMain.MsgStatus('');
end;

procedure TfmOsDeposito.travaGrid(Sender: Tobject);
begin
   grid.Columns[2].ReadOnly := true;
   grid.Columns[3].ReadOnly := true;
end;

procedure TfmOsDeposito.destravaGrid(Sender: Tobject);
begin
   grid.Columns[2].ReadOnly := false;
   grid.Columns[3].ReadOnly := false;
end;

procedure TfmOsDeposito.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_return) or (key = vk_DOWN)then
     key  := vk_TaB;
end;


procedure TfmOsDeposito.tbPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
   if pos( 'Violation', e.Message ) > 0 then
   begin
      msgTela('','Esse código já consta na requisição', mb_IconError + mb_ok);
      action := daAbort;
      tb.Delete;
   end;
end;

procedure TfmOsDeposito.tbAfterPost(DataSet: TDataSet);
begin
   fmMain.MsgStatus('Itens na requisição: ' +  intTostr(tb.RecordCount) );
   IS_REQ_SALVA := false;
end;

procedure TfmOsDeposito.gridDblClick(Sender: TObject);
begin
    if (PERFIL <> 3) then
       if MsgTela('',' Remover esse item?' , mb_iconquestion + mb_yesNo) = mrYes then
       begin
          tb.Delete;
          tb.edit;
       end;
end;

procedure TfmOsDeposito.salvaReqVenda(Sender: Tobject);
var
  str:String;
  ocoItens:TStringList;
begin
   ocoItens:= TStringList.create();
   if tb.IsEmpty = false then
   str :=  funcSQl.gerarRequisicao( fmMain.Conexao, tb, fmMain.getUoLogada(),  fmMain.getUserLogado(), true, true, ocoItens, QT_DIAS_PEND);
   if (str <> '') then
   begin
      gravaLog(str);
      emailParaCD(str, fmMain.getUoLogada() );
   end;
   while tb.IsEmpty = false do
      tb.Delete;
   tb.close;
   cbCritica.enabled := false;
   ocoItens.free;
end;

procedure TfmOsDeposito.salvaReqAbastecimento(Sender: Tobject);
var
   cmd:String;
begin
   cmd := 'delete from zcf_dspd where is_uo = ' + fmMain.getUoLogada();
   funcSql.execSQL(cmd, fmMain.Conexao);
   tb.First();
   while tb.Eof = false do
   begin
      cmd :='insert zcf_dspd values(' +
             fmMain.getUoLogada()              +', '+
             tb.fieldByName('is_ref').asString +', '+
             tb.fieldByName('Qt pedida').asString +', '+
             tb.fieldByName('Pedido Maximo').asString +')';

      funcsql.execSQL(cmd, fmMain.Conexao);
      tb.Next();
   end;
   msgTela('','Requisição foi salva, a efetiva inclusão dessa requisição será feita pelo CD.', MB_OK + MB_ICONWARNING);
end;

procedure TfmOsDeposito.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if (tb.IsEmpty = false) then
      if (IS_REQ_SALVA = false) then
         if (MsgTela('','Deseja sair sem salvar ?', MB_ICONQUESTION + MB_YESNO) = mrNo) then
            canclose := false
end;

procedure TfmOsDeposito.gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_down then key := 0;
end;

procedure TfmOsDeposito.tbBeforePost(DataSet: TDataSet);
begin
   if (tb.FieldByName('Qt Pedida').AsInteger = 0) then
    begin
      raise Exception.Create('  Falta a quantidade  ');
      tb.Edit;
   end;
end;

procedure TfmOsDeposito.cbCriticaClick(Sender: TObject);
begin
   if cbCritica.Enabled = true then
   begin
      if cbCritica.Checked = true then
         if verificaSenhas.TelaAutorizacao2( fmMain.Conexao, '13',' 10000032, 10000613') <> '' then
            cbCritica.Checked := true
         else
            cbCritica.Checked := false;
   end;
end;

procedure TfmOsDeposito.tbAfterCancel(DataSet: TDataSet);
begin
   tb.Edit;
end;


procedure TfmOsDeposito.carregaTabelaRequisicao(Sender: TObject; uo:String);
var
   cmd :String;
begin
   cmd :=  'Insert ' + tb.TableName +
           ' select c.cd_ref as Codigo, i.qt_mov [Qt Pedida], c.ds_ref as Descricao' +
           ', dbo.zcf_EstLojaParaReq(c.is_ref, ' + uo_cd +  ' , 1) as [Est CD]' +
           ', dbo.Z_CF_EstoqueNaLoja ( c.is_ref, ' + uo + ' , 1 ) ' +
           ', dbo.z_cf_funObterPrecoProduto_CF( '+ PC_VAREJO + ' , i.is_ref, '+ uo + ' ,0)as [Pc Loja]' +
           ' , c.qt_emb, c.is_ref, i.qtMaxPedido ' +
           ' from zcf_dspd  i (nolock) ' +
           ' inner join crefe c (nolock) on c.is_ref = i.is_ref ' +
           ' where is_uo = ' + uo;

   funcsql.execSQL(cmd, fmMain.Conexao);
   tb.Open();
   tb.Refresh();
   if (grid.Enabled = true) then
   begin
      formatarGrid(nil);
      tb.Append();
   end;

   if tb.IsEmpty = true then
   begin
      MsgTela('','Não há itens para essa loja.', MB_OK + MB_ICONWARNING);
      tb.Close();
      fechaSessaoRequisicao(uo);
   end;
end;

procedure TfmOsDeposito.preparaParaRequisicaoNormal(Sender: Tobject);
begin
   if (verificaRequisicaoAberta() = false) then
   begin
      bloqueiaSessaoRequisicao( fmMain.getUoLogada()) ;
      btNova.Enabled := false;
      criaTabela(nil, tb);
      carregaTabelaRequisicao(nil, fmMain.getUoLogada() );
   end
   else
      fmOsDeposito.Close();
end;

procedure TfmOsDeposito.formatarGrid(Sender: Tobject);
var
   i: integer;
begin
    for i:=0 to grid.Columns.Count -1 do
        grid.Columns[i].Title.Font.Style := [fsbold];
    grid.SetFocus;

    grid.Columns[tb.FieldByname('is_ref').Index].Visible := false;
    grid.Columns[0].Width := 70;
    grid.Columns[1].Width := 70;
    grid.Columns[2].Width := 200;
    grid.Columns[3].Width := 70;
    grid.Columns[4].Width := 70;
    grid.Columns[5].Width := 70;
    grid.Columns[6].Width := 70;
    fmMain.MsgStatus('');
    cbCritica.Enabled := true;

    if perfil <> 2 then
       grid.Columns[tb.FieldByname('pedido maximo').Index].Visible := false;
end;

procedure TfmOsDeposito.preparaParaLiberarRequisicao(Sender: Tobject);
begin
   PERFIL := 3;
//   cbLojas.Items := funcsql.GetNomeLojas(fmMain.Conexao, false, false,'','');

   fmMain.getListaLojas(cbLojas, false, false, '');

   cbLojas.Visible := true;
   btNova.Visible := false;
   grid.Enabled := false;
end;

procedure TfmOsDeposito.cbLojasClick(Sender: TObject);
begin
   if (verificaRequisicaoAberta() = false) then
   begin
      bloqueiaSessaoRequisicao( funcoes.getNumUO(cbLojas) );
      criaTabela(nil, tb);
      carregaTabelaRequisicao(nil, funcoes.getNumUO(cbLojas) );
   end;
end;

procedure TfmOsDeposito.geraRequisicaoReabastecimento(Sender: Tobject);
var
  tbAux:TADOTable;
  uo, aux,nGerados:String;
  i:integer;
  ocoReq, msgDeReq:Tstringlist;
begin
   funcoes.gravaLog('------Requisicao-------------');

   ocoReq := TStringList.Create();

   uo := funcoes.getNumUO(cbLojas);
   nGerados := '';
   tb.First();

   while tb.Eof = false do
   begin
      tbAux := TADOTable.Create(nil);
      tbAux.Connection := fmMain.Conexao;
      tbAux.TableName := funcsql.criaTabelaTemporaria( fmMain.Conexao, '( is_ref int, codigo varchar(08), descricao varchar(50), [qt Pedida] int )');
      tbAux.Open();

      for i:= 1 to MAX_ITENS_REQ do
         if (tb.Eof = false) then
         begin
            tbAux.AppendRecord( [ tb.FieldByName('is_ref').asString, tb.FieldByName('codigo').asString, tb.FieldByName('descricao').asString, tb.FieldByName('Qt pedida').asString ]);
            tb.Next();
         end;

      aux := '';
      aux := funcsql.gerarRequisicao( fmMain.Conexao, tbAux, funcoes.getCodPc(cbLojas), fmMain.getUserLogado(), false, false, ocoReq, QT_DIAS_PEND );
      if (aux <> '') then
         nGerados := nGerados  + aux + ' ';
   end;
   if (nGerados <> '') then
   begin
      msgTela('',' Foram geradas as requisições: ' + nGerados + #13+' Vou mandar um email para a loja, avisando.', MB_OK + MB_ICONWARNING );

      msgDeReq := TStringList.Create();
      msgDeReq.Add('Segue a lista das requisições geradas para reabastecimento da loja' );
      msgDeReq.add('geradas em: ' + funcDatas.dataSqlToData(funcsql.getDataBd(fmMain.Conexao,0))    );
      msgDeReq.Add('Os numero são: ' + nGerados);
      msgDeReq.Add('As requisições foram liberadas por: ' + fmMain.getNomeUsuario() );

      if (ocoReq.Count > 0) then
      begin
         msgDeReq.Add('');
         msgDeReq.Add('Alguns produtos não foram requisitado, veja a lista abaixo:');
         for i := 0 to ocoReq.Count -1 do
            msgDeReq.add(ocoReq[i]);
      end;
      fmMain.EnviarEmail( funcsql.getEmail( getCodUo(cbLojas), fmmain.Conexao) ,'Requisições geradas para reabastecimento em ' + dateToStr(now),'', msgDeReq,'Requisições reabastecimento para: ' + funcoes.getNomeUO(cbLojas) );
   end
   else
      MsgTela('','Não foi gerada nehuma requisição.' , MB_OK + MB_ICONERROR );

   funcSql.execSQL('delete from zcf_dspd where is_uo=' + funcoes.getNumUO(cbLojas) , fmMain.Conexao );
   fechaSessaoRequisicao(uo);
   tb.close();
   tbAux.Destroy();

   ocoReq.Free();
   msgDeReq.Free();
end;

procedure TfmOsDeposito.FlatButton2Click(Sender: TObject);
begin
    case PERFIL of
       1:salvaReqVenda(nil);
       2:salvaReqAbastecimento(nil);
       3:geraRequisicaoReabastecimento(nil);
    end;
    IS_REQ_SALVA := true;
end;

procedure TfmOsDeposito.emailParaCD(nReq, de: String);
var
    bodyEmail: TStringList;
    aux:String;
begin
   bodyEmail := TStringList.Create();
   bodyEmail.Add('Olá');
   bodyEmail.Add('Foi gerada uma requisição de venda/abastecimento para o cd.');
   bodyEmail.Add('Pela loja: ' +  fmMain.getNomeLojaLogada()  );
   bodyEmail.Add('Os numeros da requisição é: ' +  nreq);
   bodyEmail.add('Feita por: ' + fmMain.getNomeUsuario() + ' em: '+ funcSQl.getDataBd(fmMain.Conexao) );

   fmMain.EnviarEmail(  funcsql.getEmail( fmMain.getUoLogada() , fmMain.Conexao) ,
                           'Requisições venda/encarte geradas em ' + dateToStr(now),
                           '',
                           bodyEmail,
                           'Enviando email para a loja geradora...'
                     );

   aux :=  fmMain.GetParamBD('emailDeRequisicao1','');
   if aux <> '' then
      fmMain.EnviarEmail( aux ,
                              'Requisições venda/encarte geradas em ' + dateToStr(now),
                              '',
                              bodyEmail,
                              'Email para ' + aux
                         );

   aux :=  fmMain.GetParamBD('emailDeRequisicao2','');
   if aux <> '' then
      fmMain.EnviarEmail( aux ,
                              'Requisições venda/encarte geradas em ' + dateToStr(now),
                              '',
                              bodyEmail,
                              'Email para: ' + aux
                        );
end;

procedure TfmOsDeposito.btNovaClick(Sender: TObject);
begin
   if tb.Active = false then
     criaTabela(nil, tb);

   if tb.IsEmpty = true then
      tb.Open
   else
   begin
      if msgTela('','Deseja abandonar as alterações ? ' , mb_yesNo + mb_iconQuestion) = mrYes then
          while tb.IsEmpty = false do
             tb.Delete;
    end;
    formatarGrid(nil);
end;

procedure TfmOsDeposito.SetPerfil(P: integer; uoCD:String);
begin
   UO_CD := uoCD;
   PERFIL := P;
   case perfil of
      2:fmOsDeposito.preparaParaRequisicaoNormal(nil);
      3:preparaParaLiberarRequisicao(nil);
   end;
end;




end.
