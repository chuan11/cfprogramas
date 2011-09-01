unit uDescPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adLabelEdit, StdCtrls, ExtCtrls, adLabelNumericEdit, Grids,
  DBGrids, SoftDBGrid, DB, ADODB, funcoes, TFlatButtonUnit, funcsql, verificaSenhas ;
type
  TfmDescPed = class(TForm)
    Query: TADOQuery;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    tpDesconto: TRadioGroup;
    nmPed: TadLabelEdit;
    btConsultaPed: TFlatButton;
    gridParcelas: TSoftDBGrid;
    gridEntrada: TSoftDBGrid;
    DataSource2: TDataSource;
    dtsEnt: TDataSource;
    tbEnt: TADOTable;
    tbParc: TADOTable;
    tbEntN: TIntegerField;
    tbEntValor: TFloatField;
    tbParcN: TIntegerField;
    tbParcVenc: TDateTimeField;
    tbParcValor: TFloatField;
    lbParcelas: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbItens: TLabel;
    QueryPedido: TIntegerField;
    QueryLoja: TStringField;
    QueryData: TDateTimeField;
    QueryCliente: TStringField;
    QuerySt: TStringField;
    QueryVlProdutos: TBCDField;
    QueryVlPedido: TBCDField;
    QueryVlDesconto: TBCDField;
    QueryDesconto: TBCDField;
    QueryAutorizador: TStringField;
    gridItens: TSoftDBGrid;
    Label1: TLabel;
    Label4: TLabel;
    dsItens: TDataSource;
    tbItens: TADOTable;
    GroupBox1: TGroupBox;
    gbDescCusto: TGroupBox;
    FlatButton2: TFlatButton;
    btConfirmaCusto: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    edValor: TadLabelNumericEdit;
    GroupBox3: TGroupBox;
    gridAvarias: TSoftDBGrid;
    dsAvaItem: TDataSource;
    tbAvarias: TADOTable;
    FlatButton5: TFlatButton;
    btRetiraDoCaixa: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure tpDescontoClick(Sender: TObject);
    procedure btConsultaPedClick(Sender: TObject);
    procedure nmPedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function criticaErroDesconto(vDesconto:real):String;
    procedure calculaDesconto(Sender: Tobject; UsrAutorizador:string; vDesconto:real);
    function getSomaDasParcelas():real;
    function GetValorDesconto():real;
    procedure gridEntradaExit(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure AplicarDesconto(Sender:Tobject; vDesconto:Real;autorizador:string);
    procedure FlatButton2Click(Sender: TObject);
    function existeitemSemCusto(Sender:Tobject):string;
    procedure aplicaPrecoDeCusto(Sender:TObject);
    procedure btConfirmaCustoClick(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure carregaItensPedido();
    procedure gravaDescAvarias(pedido:String);
    procedure gridItensCellClick(Column: TColumn);
    procedure gridAvariasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbAvariasBeforePost(DataSet: TDataSet);
    procedure FlatButton5Click(Sender: TObject);


    function getvDescontoAvarias():Real;
    procedure btRetiraDoCaixaClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   TITULO  = '- Inserir desconto em Pedido';

var
  fmDescPed: TfmDescPed;
  nmpedido :string;
  IS_TELA_RESTRITA:boolean;
implementation

uses uMain, uCF;

{$R *.dfm}


function TfmDescPed.getValorDesconto: real;
var
  aux:real;
begin
   aux:=0;
   Case TpDesconto.ItemIndex of
      0:aux := edValor.Value;
      1:aux := (query.fieldByName('Vl Produtos').AsFloat * edValor.Value)  / 100;
      2:aux := query.fieldByName('Vl Produtos').AsFloat - edValor.Value ;
   end;
   result := aux;
end;

procedure TfmDescPed.tpDescontoClick(Sender: TObject);
begin
   case tpDesconto.ItemIndex of
      0:edValor.LabelDefs.Caption := 'Valor do desconto';
      1:edValor.LabelDefs.Caption := 'Percentual de desconto';
      2:edValor.LabelDefs.Caption := 'Valor desejado';
   end;
end;


procedure TfmDescPed.FormCreate(Sender: TObject);
var
  cmd:string;

begin
   tpDescontoClick(Sender);

   IS_TELA_RESTRITA :=  fmMain.isGrupoRestrito(fmMain.Descontodepedido1.Tag);

   fmDescPed.Caption := TITULO;

   if (IS_TELA_RESTRITA = true) then
      fmDescPed.Caption := TITULO + ' - Modo de Desconto de avarias.'
   else
      fmDescPed.Caption := TITULO + ' - Modo Normal.';

   if (IS_TELA_RESTRITA = true )  then
   begin
      gbDescCusto.Visible := false;
      label2.Visible := false;
      label3.Visible := false;

      gridParcelas.visible := false;
      gridEntrada.visible := false;
      tpdesconto.Enabled := false;
   end;

   tbParc.TableName := funcSql.getNomeTableTemp();
   cmd := ' create table ' + tbParc.TableName + ' ( N int, Venc SmallDateTime, Valor money)';
   funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);
   tbEnt.TableName := funcSql.getNomeTableTemp();
   cmd := ' create table ' + tbEnt.TableName + ' ( N int, Valor money)';
   funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);

   fmMain.getParametrosForm(fmDescPed);
end;

procedure TfmDescPed.carregaItensPedido();
var
   cmd:String;
   nTable:string;
begin
   if tbItens.Active = true then
      tbItens.Close();
   nTable := funcSQl.getNomeTableTemp;
   cmd := 'Create table ' + ntable + '( seq int, Codigo varchar(13),  Descricao varchar(50), [Qt] integer not null default 0, und money, total money , is_ref int, codLoja int, [Responsavel pela avaria] varchar(20) )';
   funcSql.execSQL(cmd , fmMain.Conexao);
   tbItens.TableName := nTable;

   cmd := 'insert ' + tbItens.TableName +
          ' select i.seqitemPedido ' +
          ' , p.cd_ref, p.ds_ref, i.quantPedido, i.valorPrecoSugerido, i.valorTotal, i.seqProduto as is_ref, i.codLoja, '''' ' +
          ' from itensPedidoCliente i (nolock) inner join crefe p (nolock) on p.is_ref = i.seqProduto where ' +
          ' numPedido = ' + nmPed.Text;

   funcSql.execSQL(cmd , fmMain.Conexao);

   tbItens.Open();
   dsItens.DataSet := tbItens;

   gridItens.Refresh();
   gridItens.columns[tbItens.FieldByname('seq').index].visible := false;
   gridItens.columns[tbItens.FieldByname('is_ref').index].visible := false;
   gridItens.columns[tbItens.FieldByname('codLoja').index].visible := false;
end;


procedure TfmDescPed.btConsultaPedClick(Sender: TObject);
var
   cmd:String;
begin
   nmPedido := nmPed.Text;
   cmd :=
   ' select tbuo.is_uo, '+
   ' pedidoCliente.numPedido as [Pedido], tbuo.ds_uo as [Loja], pedidoCliente.DataPedido as [Data], '+
   ' dspes.nm_pes as [Cliente] , pedidocliente.situacaoPedido as  [St], '+
   ' pedidoCliente.ValorTotal as [Vl Produtos], pedidoCliente.ValorNota as [Vl Pedido], ' +
   ' pedidoCliente.ValorDesconto as [Vl Desconto], pedidoCliente.PercentualDesconto as [% Desconto], ' +
   ' dsusu.nm_usu as [Autorizador] ' +
   ' from pedidocliente  '+
   ' inner join zcf_tbuo tbuo on pedidocliente.seqfilial = tbuo.is_uo '+
   ' left join dspes on pedidoCliente.cd_pes = dspes.cd_pes '+
   ' left join dsusu on  pedidoCliente.codUsuarioAutorizacao = dsusu.CD_USU '+
   ' where pedidoCliente.numpedido = ' + nmPed.Text ;

   Query.SQL.Clear;
   query.SQL.Add(cmd);
   query.Open;

   softDbgrid1.Columns[0].Width := 50;
   softDbgrid1.Columns[01].Width := 130;
   softDbgrid1.Columns[02].Width := 62;
   softDbgrid1.Columns[03].Width := 127;
   softDbgrid1.Columns[04].Width := 15;
   softDbgrid1.Columns[05].Width := 59;
   softDbgrid1.Columns[06].Width := 59;
   softDbgrid1.Columns[07].Width := 62;
   softDbgrid1.Columns[08].Width := 61;
   softDbgrid1.Columns[09].Width := 126;

  // query das parcelas
   tbParc.close;
   if tbParc.TableName <> '' then
   begin
      cmd := 'truncate table ' + tbParc.TableName;
      funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);
   end;

   cmd := ' insert ' + tbParc.TableName +' Select numParcela as N, dataVencimento AS Venc, valorParcela as Valor from parcelasPedidoCliente where numPedido = ' +nmPedido +' and tipoParcela = ''P'' ';
   funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);
   tbParc.Open;

   gridParcelas.Columns[0].Width := 20;
   gridParcelas.Columns[1].Width := 70;
   gridParcelas.Columns[2].Width := 70;

   // query da entrada
   tbEnt.close;
   if tbEnt.TableName <> '' then
   begin
      cmd := 'truncate table ' + tbEnt.TableName;
      funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);
   end;

   cmd := ' insert ' + tbEnt.TableName + ' Select numParcela as N, valorParcela as Valor from parcelasPedidoCliente where numPedido = ' + nmPedido +' and tipoParcela = ''E'' ';
   funcSql.GetValorWell('E',cmd,'@@error', fmMain.Conexao);

   tbEnt.Open;
   gridEntrada.Columns[0].Width := 20;
   gridEntrada.Columns[1].Width := 70;
   gridEntradaExit(Sender);

   carregaItensPedido();

//   if (IS_TELA_RESTRITA = true) then
   uCF.getProdAvariadosParaVenda(tbAvarias, gridAvarias, query.fieldByname('pedido').AsString);

   if query.IsEmpty then
   begin
      msgTela('', 'Não achei esse pedido.', mb_iconError + mb_ok);
      query.Close;
   end
end;

procedure TfmDescPed.nmPedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      btConsultaPedClick(Sender);
end;

function TfmDescPed.getSomaDasParcelas: real;
var
   aux: real;
begin
   aux:=0;
   if tbEnt.IsEmpty = false then
      aux := aux + tbEnt.fieldByName('Valor').asFloat;

   if tbParc.IsEmpty = false then
   begin
       tbParc.First;
       while tbParc.Eof = false do
       begin
          aux := aux + tbParc.fieldByName('valor').AsFloat;
          tbParc.Next;
       end;
   end;
   getSomaDasParcelas := aux;
end;


function TfmDescPed.criticaErroDesconto(vDesconto:real):String;
var
   erro:string;
   vDescAvarias:real;
begin
   erro:= '';

   if (IS_TELA_RESTRITA = true ) then
   begin
      vDescAvarias := getvDescontoAvarias();
      if (edValor.Value  > vDescAvarias + 0.10 ) then
         erro := erro + ' - O  desconto máximo, é de: R$ ' +  funcoes.floatToDinheiro(vDescAvarias) + #13;
   end;

   if edValor.Value < 0 then
      erro := erro + ' - O valor/percentual do desconto não pode ser menor que zero. ' + #13;

   if tpDesconto.ItemIndex = 0 then
      if edValor.Value > query.FieldByName('Vl Pedido').asFloat then
         erro := erro + ' - O valor do desconto não pode ser maior que o valor da compra ' + #13;

   if tpDesconto.ItemIndex = 2 then
      if edValor.Value > query.FieldByName('Vl Pedido').asFloat then
         erro := erro + ' - O valor desejado não pode ser maior que o valor da compra ' + #13;

   if tpDesconto.ItemIndex = 1 then
      if edValor.Value > 100 then
         erro := erro + ' - O percentual de  desconto não pode ser maior que 100%' + #13;

   if query.FieldByName('st').AsString = 'F' then
      erro := erro + ' - O pedido já foi recebido no caixa' + #13;

   if query.FieldByName('st').AsString = 'A' then
      erro := erro + ' - O pedido esta aberto' + #13;

   if query.FieldByName('st').AsString = 'C' then
      erro := erro + ' - O pedido esta cancelado' + #13;

   if (tbParc.IsEmpty = false) or (tbEnt.IsEmpty = false) then
      if FloatToStrF( getSomaDasParcelas() , ffNumber,18,02) <>
         FloatToStrF( query.fieldByName('Vl Produtos').AsFloat - vDesconto, ffNumber, 18,02)  then
      begin
         gridEntradaExit(nil);
         erro := erro + ' - O valor das parcelas está diferente do valor do pedido ' +#13+
                        'Valor com desconto: '+ floattostrf(  query.fieldByName('Vl Produtos').AsFloat - vDesconto , ffNumber, 18, 2) +#13+
                        'Valor Parcelas: ' + floattostrf(  getSomaDasParcelas() , ffNumber, 18, 2) +#13 ;
      end;
   if erro <> '' then
   begin
      erro := '    Erro! '+#13 + erro;
      msgTela('', erro, mb_iconError + mb_Ok);
   end;
      result := erro;
end;

procedure TfmDescPed.calculaDesconto(Sender: Tobject; UsrAutorizador:string; vDesconto:real);
var
   Strdesconto,cmd:string;
begin
   StrDesconto := funcoes.StrToPrecoSQL( floattostr(vDesconto) );
   cmd :=  ' Update pedidoCliente set ValorDesconto = round(' + StrDesconto +', 2 ) , '+
           ' valorNota = valorTotal - round(' +  StrDesconto  +' ,2) , '+
           ' codUsuarioAutorizacao = ' + UsrAutorizador  +' , '+
           ' ValorBaseDescontoFechamentoVenda = valorTotal ' +
           ' where numPedido = ' + query.fieldByName('Pedido').AsString;
   funcSQL.GetValorWell('e',cmd,'@@error',fmMain.Conexao);

//LANCA o valor da entrada
   if (tbEnt.IsEmpty = false ) then
   begin
      cmd := ' Update parcelasPedidoCliente ' +
             ' set valorParcela = ' + FUNCOES.StrToPrecoSQL( tbEnt.fieldByname('valor').AsString) +
             ' where numpedido = '  +  query.fieldByName('Pedido').asString +
             ' and NumParcela = 1 and TipoParcela = ''E''  ';

     funcSQL.GetValorWell('e',cmd,'@@error',fmMain.Conexao);
   end;
// Lanca o novo valor das parcelas

   if ( tbParc.IsEmpty = false) then
   begin
      tbParc.First;
      while (tbParc.Eof = false) do
      begin
         cmd := ' Update parcelasPedidoCliente ' +
                ' set valorParcela = ' + FUNCOES.StrToPrecoSQL( tbParc.fieldByname('valor').AsString) +
                ' where numpedido = '  +  query.fieldByName('Pedido').asString +
                ' and NumParcela = ' + tbParc.fieldByname('N').AsString +
                ' and TipoParcela = ''P''  ';
         funcSQL.GetValorWell('e',cmd,'@@error',fmMain.Conexao);
         tbParc.Next;
      end;
   end;

   gravaDescAvarias(query.fieldByname('Pedido').asString);

   nmPed.Enabled := true;
   btConsultaPed.Enabled := true;
   btConsultaPedClick(Sender);
end;

procedure TfmDescPed.AplicarDesconto(Sender: Tobject; vDesconto: Real;autorizador:string);
var
 userLogado:String;
begin
   userLogado := '';
   if (IS_TELA_RESTRITA = true) then
     userLogado := fmMain.getUserLogado();

   if autorizador = '' then
      autorizador := verificaSenhas.TelaAutorizacao2(fmMain.Conexao,' 13, 08' , userlogado);

   if (query.IsEmpty = false) and ( autorizador <> '' ) then
   begin
         if (query.FieldByName('Vl Desconto').AsFloat <> 0) or (query.FieldByName('% Desconto').AsFloat <> 0) then
         begin
            if msgTela('', 'Ja existe desconto nesse pedido.' +#13+ 'Se aplicar esse desconto o anterior irá ser descartado. '+#13+ 'Continua? ', mb_IconQuestion + mb_yesNo) = mrYes then
               calculaDesconto( Sender, autorizador, vDesconto );
         end
         else
            calculaDesconto(Sender, autorizador, vDesconto );
   end
//   else
//      btConsultaPed.Enabled := true;
end;

procedure TfmDescPed.gridEntradaExit(Sender: TObject);
begin
     lbParcelas.Caption :=  'Total das parcelas: ' + floattostrf(getSomaDasParcelas() , ffNumber,18,02);
     lbItens.Caption :=  'Total do pedido : ' +   floattostrf(query.fieldByName('Vl Produtos').AsFloat -  GetValorDesconto() , ffNumber,18,02);
end;

function TfmDescPed.existeitemSemCusto(Sender: Tobject): string;
var
   query:TADOQuery;
   erro:string;
begin
   screen.Cursor := crHourGlass;
   erro := '';
   query := TADOQuery.Create(nil);
   query.Connection := fmMain.Conexao;
   query.CommandTimeout := 0;
   query.SQL.Clear;
   query.SQL.add(' select dbo.Z_CF_funObterPrecoProduto_CF(7, is_ref, 10033674,0) as custoreal from CREFE WHERE ' +
                 ' IS_REF IN (SELECT seqProduto FROM itenspedidocliente WHERE numpedido = ' + nmPedido + ')' );

   query.Open;
   query.Destroy;

   if erro <> '' then
   begin
      erro := ' Os seguintes produtos não têm preço de custo real ( cod preço 07 ). ' +#13 + #13+
               erro +#13+#13+
              ' Só posso aplicar as modificações quando todos os produtos têm preço de custo.';
       msgTela('',erro,mb_iconerror+mb_OK);
    end;
   result := '';
   screen.Cursor := crDefault;
end;

procedure TfmDescPed.aplicaPrecoDeCusto(Sender: TObject);
var
   vpreco, cmd:string;
begin
//   vPreco := '1';
   vPreco := '7';

   cmd := ' update itensPedidoCliente set ' +
          ' valorPrecoSugerido =   round( (dbo.Z_CF_funObterPrecoProduto_CF('+ vPreco + ', seqProduto, 10033674, 0) / 0.83), 2) , ' + #13+
          ' precoUnitarioLiquido = round( (dbo.Z_CF_funObterPrecoProduto_CF('+ vPreco + ', seqProduto, 10033674, 0) / 0.83), 2), '  + #13+
          ' valorTotal =           round( ((dbo.Z_CF_funObterPrecoProduto_CF('+ vPreco + ', seqProduto, 10033674,0) / 0.83) * quantPedido), 2) '+
          ' where numpedido = ' + nmPedido;

   if funcSQL.GetValorWell('E',cmd, '@@error', fmMain.Conexao )  <> '0' then
      showmessage('erro na alteração itens ');

// alterar os valores do pedido
  cmd :=  ' update pedidoCliente set ' +
          ' valorNota =  round( ( Select Sum(valorTotal) from itenspedidocliente where numpedido = '+nmPedido +' ) ,2) , '+
          ' valorTotal = round( ( Select Sum(valorTotal) from itenspedidocliente where numpedido = '+nmPedido +' ) ,2) '+
          ' where numPedido = ' + nmPedido ;

   if funcSQL.GetValorWell('E',cmd, '@@error', fmMain.Conexao )  <> '0' then
      showmessage('erro na alteração dos valores do pedido');
end;

procedure TfmDescPed.btConfirmaCustoClick(Sender: TObject);
var
   usAutorizador: string;
begin
   usAutorizador :=  verificaSenhas.TelaAutorizacao2(fmMain.Conexao,' 13,6,8,111 ','');
   if usAutorizador <> '' then
   begin
      AplicarDesconto(sender,0,usAutorizador);
      nmPed.Enabled := true;
      btConfirmaCusto.Enabled := false;
      btConsultaPed.Enabled := true;
      FlatButton2.Enabled := true;
      FlatButton3.Enabled := false;
      FlatButton4.Enabled := true;
      nmPedido := nmped.Text;
   end;
end;

procedure TfmDescPed.FlatButton4Click(Sender: TObject);
var
   vDesconto:real;
begin
   gridEntradaExit(Sender);
   vDesconto := GetValorDesconto();
   if criticaErroDesconto( vDesconto ) = ''  then
   begin
      nmPed.Enabled := false;
      FlatButton2.Enabled := false;
      btConsultaPed.Enabled := false;
      FlatButton4.Enabled := false;
      FlatButton3.Enabled := true;
      edValor.Enabled := false; 
   end;
end;

procedure TfmDescPed.FlatButton2Click(Sender: TObject);
begin
    if query.IsEmpty = false then
       if criticaErroDesconto(0) = '' then
          if msgTEla('', ' ATENÇÃO   ' +#13+
                         ' Esse modo de desconto é exclusivo para faturamento  ' + #13+
                         ' a preço de custo( custo real ) para a loja Maracanau.   '+#13+
                         ' Deseja relamente aplicar o preço real de custo ao pedido ???               ', mb_iconwarning + mb_yesno) = mrYes then
          begin
             if (existeitemSemCusto(nil) = '') then
             begin
                aplicaPrecoDeCusto(nil);
                btConsultaPedClick(Sender);
                if (tbParc.IsEmpty = false) or (tbEnt.IsEmpty = false  )then
                  showmessage('Ajuste os valores das parcelas do pedido e depois clique em  confirma preço de custo');

                nmPed.Enabled := false;
                btConfirmaCusto.Enabled := true;
                btConsultaPed.Enabled := false;
                FlatButton2.Enabled := false;
                FlatButton3.Enabled := false;
                FlatButton4.Enabled := false;
                nmPedido := nmped.Text;
              end;
         end;
end;

procedure TfmDescPed.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   fmDescPed := nil;
   ACTION := caFree
end;


procedure TfmDescPed.gravaDescAvarias(pedido:String);
var
  pcDesconto:String;
  cmd:String;
  isDescAvarias:boolean;
begin
   isDescAvarias := false;
   tbAvarias.First();
   while (tbAvarias.Eof = false) do
   begin
      if (tbAvarias.FieldByName('qtParaVenda').AsInteger > 0) then
      begin
         isDescAvarias := true;
         break
      end;
      break;
   end;

   if (isDescAvarias = true) then
   begin
      funcSQL.execSQL('delete from zcf_avariasDescontos where is_uo = ' +tbItens.fieldByName('codLoja').asString +' and pedido = ' + query.fieldByName('pedido').asString, fmMain.Conexao);

      pcDesconto := funcsql.openSQL(' Select ((valorDesconto*100)/valorTotal)/100  as pcDesconto from pedidocliente (nolock) where numPedido= ' + pedido , 'pcDesconto', fmMain.Conexao);
      pcDesconto := funcoes.ValorSql(pcDesconto);
      cmd := 'insert zcf_avariasDescontos ' +
             'select codLoja, getdate(), ' + query.fieldByName('pedido').asString  + ' , is_ref, qt, round( und - (und * '+ pcDesconto +'),2 ) , und, ' +
             '(Select dbo.z_cf_funObterPrecoProduto_cf(5, is_ref, '+ fmMain.getUoLogada() +', 0)) from ' + tbItens.TableName ;
      funcSql.execSQL(cmd, fmMain.Conexao);
   end;

   tbAvarias.First();
   while (tbAvarias.Eof = false) do
   begin
      if (tbAvarias.FieldByName('qtParaVenda').AsInteger > 0) then
      begin
         cmd := 'update zcf_avariasItens set qtVendido = qtVendido + ' + tbAvarias.FieldByName('qtParaVenda').asString +
                'where  ref = ' + tbAvarias.FieldByName('ref').asString;
         funcSql.execSQL(cmd, fmMain.Conexao);
      end;
      tbAvarias.next();
   end;
   funcSql.execSQL(cmd, fmMain.Conexao);
end;

procedure TfmDescPed.gridItensCellClick(Column: TColumn);
var
   cmd :String;
begin
   cmd := ' select L.DS_uo as Loja, a.numAvaria [Num Avaria], a.DataAprovacao [Data Aprovacao], i.pcoSugerido as [ Valor sugerido], ' +
          'i.obsItem as [Observação], i.ref from zcf_avariasItens i inner join zcf_avarias a on i.numAvaria = a.numAvaria '+
          'inner join zcf_tbuo L on i.loja = L.is_uo ' +
          'where i.is_ref = ' + tbItens.fieldByname('is_ref').asString;
end;

procedure TfmDescPed.gridAvariasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_RETUrn ) then key :=  VK_down
end;

procedure TfmDescPed.tbAvariasBeforePost(DataSet: TDataSet);
var
   erro:String;
begin
   if ( tbAvarias.fieldByName('qtParaVenda').AsInteger > tbAvarias.fieldByName('Disponivel').AsInteger ) then
      erro := 'A quantidade é maior que a diposnivel';

   if ( tbAvarias.fieldByName('qtParaVenda').AsInteger > tbItens.FieldByName('qt').asinteger ) then
      erro := 'A quantidade é maior que a do pedido';

   if ( tbAvarias.fieldByName('Disponivel').AsString = '' ) then
      erro := ' Ajuste a quantidade somente onde tem item.';

   if (erro <> '') then
   begin
      raise Exception.Create(erro);
      tbAvarias.Edit;
   end;
end;

function TfmDescPed.getvDescontoAvarias():real;
var
  vDesc:real;
begin
   gridAvarias.Visible := false;
   vDesc:=0;
   tbItens.First();
   while (tbItens.Eof = false) do
   begin
      tbAvarias.First();
      while (tbAvarias.Eof = false) do
      begin

         if (tbItens.FieldByName('is_ref').asString = tbAvarias.FieldByName('is_ref').asString) and
            (tbAvarias.FieldByName('qtParaVenda').asString <> '0')                              and
            (tbAvarias.FieldByName('pcoSugerido').asString <> '0')                              then
             vDesc := vDesc+ (tbItens.FieldByName('und').AsFloat - tbAvarias.FieldByName('pcoSugerido').AsFloat) * tbAvarias.FieldByName('qtParaVenda').AsFloat;

         tbAvarias.next();
      end;
      tbItens.Next();
   end;
   tbAvarias.First();
   tbItens.First();

   gridAvarias.Visible := true;
   result := vDesc;
end;



procedure TfmDescPed.FlatButton3Click(Sender: TObject);
var
   vDesconto:real;
begin
   vDesconto := GetValorDesconto();
   if (criticaErroDesconto(vDesconto ) = '') then
   begin
      funcoes.MsgTela('','Verificação confirmada. ', MB_ICONASTERISK + mb_ok);
      AplicarDesconto(nil, vDesconto,'');

      nmped.Text := '';
      nmped.Enabled  := true;
      btConsultaPed.Enabled := true;
      FlatButton4.Enabled := true;
      FlatButton3.Enabled := false;
      FlatButton2.Enabled := true;
      btConfirmaCusto.Enabled:= false;
   end;
end;


procedure TfmDescPed.FlatButton5Click(Sender: TObject);
begin
   if (tbAvarias.IsEmpty = false) then
      edValor.Value:= getvDescontoAvarias();
end;

procedure TfmDescPed.btRetiraDoCaixaClick(Sender: TObject);
begin
   if nmPed.Text<> '' then
   begin
      funcSQL.execSQL('update pedidoCliente set codCaixa = null '+
                      'where numPedido= '+ nmPed.Text, fmMain.Conexao);
      funcoes.msgTela('','Pedido '+ nmPed.Text +' retirado do caixa...', MB_OK + MB_ICONEXCLAMATION);
   end;
end;

end.
