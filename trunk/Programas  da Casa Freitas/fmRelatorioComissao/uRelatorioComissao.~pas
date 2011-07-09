unit uRelatorioComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, ExtCtrls, ComCtrls, fCtrls,
  adLabelComboBox, funcoes,funcsql, DB, ADODB, Grids, DBGrids, SoftDBGrid,
  Buttons;

type
  TfmRelatorioComissao = class(TForm)
    GroupBox1: TGroupBox;
    cbLoja: TadLabelComboBox;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    GroupBox2: TGroupBox;
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    StaticText1: TStaticText;
    tb: TADOTable;
    SoftDBGrid2: TSoftDBGrid;
    DataSource2: TDataSource;
    qrResult: TADOQuery;
    tbResult: TADOTable;
    cbTipoComissao: TadLabelComboBox;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SoftDBGrid2TitleClick(Column: TColumn);
    procedure FlatButton2Click(Sender: TObject);
    procedure geraComissao(Sender:TObject);
    procedure ObterVendasDoDia(Sender:Tobject;Dia:Tdate);
    procedure ObterVendedoresDasVendasDoDia(Sender:Tobject);
    procedure AdicionarVendas(Sender:Tobject);
    procedure prencheDadosVendedor(Sender:Tobject);
    procedure exportaDadosDoAtendimento(data:Tdate);
    procedure FormResize(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelatorioComissao: TfmRelatorioComissao;

implementation
uses uMain;
{$R *.dfm}

procedure TfmRelatorioComissao.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   qrREsult.Destroy;
   tb.Close;
   tbResult.CLOSE();
   funcoes.salvaCampos(fmRelatorioComissao);
   fmRelatorioComissao := nil;
   action := CaFree;
end;


procedure TfmRelatorioComissao.FormCreate(Sender: TObject);
begin
//   cbLoja.items := funcsQL.GetNomeLojas( fmMain.Conexao, false, false, fmMain.lbPes.caption,'' ); // getListaPrecos (sender);
   fmMain.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado() );

   fmMain.getParametrosForm(fmRelatorioComissao);
   OpenTempTable( tb,  'is_oper integer, cd_mve int, valor money, TipoPrecoSugerido int, cd_vend int, cd_pes int, seq int identity(01,01) ', fmMain.Conexao);
   OpenTempTable( tbResult,  'Vendedor varchar(50), cd_vend int,  ValorBaseComissao money, [Faixa01] int, [Faixa02] int , [Faixa03] int, [Faixa04] int, [Faixa05] int, [Quant atendimentos] int, seq int identity(0,1) primary key ' , fmMain.Conexao);

   SoftDBGrid2.Columns[tbResult.FieldByName('seq').Index].Visible := false;
   SoftDBGrid2.Columns[tbResult.FieldByName('cd_vend').Index].Visible := false;
   SoftDBGrid2.Columns[tbResult.FieldByName('faixa01').Index].Title.Caption := '0 a 50';
   SoftDBGrid2.Columns[tbResult.FieldByName('faixa02').Index].Title.Caption := '51 a 100';
   SoftDBGrid2.Columns[tbResult.FieldByName('faixa03').Index].Title.Caption := '101 a 150';
   SoftDBGrid2.Columns[tbResult.FieldByName('faixa04').Index].Title.Caption := '151 a 200';
   SoftDBGrid2.Columns[tbResult.FieldByName('faixa05').Index].Title.Caption := 'Maior que 200';
   SoftDBGrid2.Columns[tbResult.FieldByName('Quant atendimentos').Index].Title.Caption := 'Total Atendimentos';
end;

procedure TfmRelatorioComissao.SoftDBGrid2TitleClick(Column: TColumn);
begin
   funcsql.OrganizarTabela(tbResult, column);
end;

procedure TfmRelatorioComissao.FlatButton2Click(Sender: TObject);
var
   lst:TStringList;
begin
   lst := TstringList.Create();
   lst.Add(dateToStr(datai.date));
   lst.Add(dateToStr(dataf.date));
   lst.Add(fmMain.StatusBar1.Panels[1].Text );
   lst.Add(cbTipoComissao.Items[cbTipoComissao.itemIndex]   );
   lst.Add(copy(cbLoja.Items[cbLoja.ItemIndex],01,30)  );

   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('faixa01').Index].Title.Caption);
   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('faixa02').Index].Title.Caption );
   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('faixa03').Index].Title.Caption );
   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('faixa04').Index].Title.Caption );
   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('faixa05').Index].Title.Caption );
   lst.Add(SoftDBGrid2.Columns[tbResult.FieldByName('Quant atendimentos').Index].Title.Caption);
   if tbResult.IsEmpty = false then
      fmMain.impressaoRave(tbResult,'rpComissao', lst);
end;


procedure TfmRelatorioComissao.ObterVendasDoDia(Sender: Tobject; Dia: Tdate);
var
   cmd:String;
   qr:TADOQuery;
begin
   while tb.IsEmpty = false do
    tb.Delete();

   cmd := ' exec stoListarPreviaGeralCaixa_CF '+
          ' @dsLojas = ' + Quotedstr( 'transacoesdocaixa.codloja = ' + getCodUo(cbLoja) ) +
          ' ,@codEmpresa = 10033585 '+
          ' ,@DataInicial = ' + ( funcoes.DateTimeToSqlDateTime(dia, ' 00:00:00' ) )+
          ' ,@DataFinal = '   + ( funcoes.DateTimeToSqlDateTime(dia, ' 00:00:00' ) )+
          ' ,@CodCaixa = 0, @CodOperador = 0 ';

   qr := TADOQuery.Create(nil);
   qr.Connection := fmMain.Conexao;
   qr.CommandTimeout := 0;
   qr.SQL.Clear();
   qr.SQL.Add(cmd);
   qr.Open();


   qr.First;
   while qr.Eof= false do
   begin
     if qr.FieldByName('fl_sinal').AsString = 'E' then
        tb.AppendRecord([
                         qr.FieldByName('is_oper').AsInteger,
                         qr.FieldByName('cd_mve').AsInteger,
                         qr.FieldByName('valor').AsFloat,
                         '',
                         '',
                         qr.FieldByName('cd_pes').AsInteger
                       ]);
       qr.Next;
   end;
end;

procedure TfmRelatorioComissao.ObterVendedoresDasVendasDoDia(Sender: Tobject);
var
  cmd:String;
  qrDadosVenda:TADOQuery;

begin
   qrDAdosVEnda := TADOQuery.Create(nil);
   qrDadosVenda.Connection := fmMain.Conexao;
   qrDadosVenda.CommandTimeout := 0;

   tb.First;
   while tb.Eof =false do
   begin
      cmd := 'Select top 01 cd_vend, TipoPrecoSugerido from dlanv (nolock) where is_oper = ' + tb.fieldByname('is_oper').asString;

      qrDadosVenda.sql.clear();
      qrDadosVenda.SQL.add(cmd);
      qrDadosVenda.Open();

      tb.Edit;
      tb.FieldByName('TipoPrecoSugerido').asInteger := qrDadosVenda.fieldByname('TipoPrecoSugerido').AsInteger;
      tb.FieldByName('cd_vend').asInteger := qrDadosVenda.fieldByname('cd_vend').AsInteger;
      tb.post;

      tb.Next;
   end;
   qrDadosVEnda.Close();
   qrDadosVEnda.Destroy();
end;

procedure TfmRelatorioComissao.AdicionarVendas(Sender: Tobject);
var
   strPreco, cmd:String;
   i,codUo:integer;
   fxValor: array[1..6] of String;
begin                   ///
   fxValor[1] := '-1';
   fxValor[2] := '50';
   fxValor[3] := '100';
   fxValor[4] := '150';
   fxValor[5] := '200';
   fxValor[6] := '999999';

   codUo := StrToInt(funcoes.getNumUO(cbLoja));
   if (cbTipoComissao.ItemIndex = 0) or (cbTipoComissao.ItemIndex  in [0,2,3] )  then    // varejo
   begin
      case codUo of
        10033592: strPreco := '101,110'; // loja Teresina
        10033591: strPreco := '101,105'; // loja sao luis
        10034573: strPreco := '0';
      else
         strpreco := '101';
      end;
   end
   else
   begin
      case codUo of
        10033592: strPreco := '103,111'; // loja Teresina
        10033591: strPreco := '103,106'; // loja sao luis
        10034573: strPreco := '0';
      else
         strPreco := '103';
      end;
   end;
// *** incluir as faixas dos valores de venda nesse local

// Soma os valores de cada vendedor
   case cbTipoComissao.ItemIndex of
      0,1: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  group by cd_vend ';
      2,4: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  and cd_pes in (1, 8, 10011715, 10037545 ) group by cd_vend ';
      3,5: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  and cd_pes not in (1, 8, 10011715, 10037545 ) group by cd_vend ';
   end;
   qrResult.sql.clear();
   qrResult.sql.add(cmd);
   qrResult.Open();

// colocar o nome do vendedor na tabela de resultados
   qrResult.First;
   while qrResult.Eof = false do
   begin
      if openSQL( ' Select cd_vend from ' + tbResult.tableName + ' where cd_vend = ' + qrResult.fieldByName('cd_vend').AsString , 'cd_vend' , fmMain.Conexao ) = '' then
         tbResult.AppendRecord(['',
                               qrResult.FieldByName('cd_vend').AsString ,
                               qrResult.FieldByName('valorBaseComissao').AsString,
                               '0','0','0','0','0','0'])
      else
      begin
         cmd :=   ' Update ' + tbResult.tableName +
                  '  set ValorBaseComissao = ValorBaseComissao + ' +  funcoes.ValorSql( qrResult.FieldByName('ValorBaseComissao').asString ) +
                  ' where cd_vend = ' + qrResult.FieldByName('cd_vend').asString ;
         execSQL(cmd , fmMain.conexao);
      end;
      qrResult.Next();
   end;

   fmMain.MsgStatus(' Calculando a quantidade de atendimentos...');

   for i:= 2 to 6 do
   begin

   case cbTipoComissao.ItemIndex of
       0: cmd :=   ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' group by cd_vend ';
       1: cmd :=   ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' group by cd_vend ';
       2,4: cmd := ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' and cd_pes in (1, 8, 10011715, 10037545 ) group by cd_vend ';
       3,5: cmd := ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' and cd_pes not in (1, 8, 10011715, 10037545 ) group by cd_vend ';
   end;


      qrResult.sql.clear();
      qrResult.sql.add(cmd);
      qrResult.Open();
      qrResult.First();
      while (qrResult.Eof = false) do
      begin
          cmd :=   ' Update ' + tbResult.tableName +
                   ' set faixa0'+ intToStr(i-1) + ' = faixa0'+ intToStr(i-1) +' + '+ qrResult.FieldByName('NumAtendimentos').asString +' where cd_vend = ' + qrResult.FieldByName('cd_vend').asString;
          execSQL(cmd, fmMain.Conexao);
          qrResult.Next();
      end;
   end;

   cmd := ' update ' + tbResult.TableName  + ' set [Quant atendimentos] =  faixa01 + faixa02 + faixa03 + faixa04 + faixa05 ';
   execSQL(cmd, fmMain.Conexao);

   fmMain.msgstatus('');
   tbResult.Refresh();
end;

procedure TfmRelatorioComissao.prencheDadosVendedor(Sender: Tobject);
var
   cmd:String;
begin
   tbResult.First;
   while tbResult.Eof = false do
   begin
      cmd := 'Select nm_usu from dsusu where  cd_pes = ' + tbResult.fieldByname('cd_vend').asString;
      tbResult.edit();
      tbREsult.FieldByName('Vendedor').asString := funcSQL.openSQL(cmd,'nm_usu', fmMain.Conexao);
      tbResult.post;
      tbResult.next();
   end;
   tbResult.Refresh();
end;

procedure TfmRelatorioComissao.geraComissao(Sender: TObject);
var
  inicio,fim :integer;
  dataAux:Tdate;
begin
   dataAux := datai.Date;
   inicio := funcoes.dataToInt(datai.Date) -1;
   fim := funcoes.dataToInt(dataf.Date);

   while tbResult.IsEmpty = false do
      tbResult.Delete();

   while inicio < fim do
   begin
      fmMain.MsgStatus(dateToStr(dataAux) + ' Obter Vendas...');
      ObterVendasDoDia(nil, dataAux);
      fmMain.MsgStatus(dateToStr(dataAux) + ' Obter atendente das vendas...');
      ObterVendedoresDasVendasDoDia(nil);
      fmMain.MsgStatus(dateToStr(dataAux) + ' Somar os resultados...');
//      exportaDadosDoAtendimento(dataAux);
      AdicionarVendas(nil);
      dataAux:= dataAux +1;
      inc(inicio);
   end;
   prencheDadosVendedor(nil);
end;

procedure TfmRelatorioComissao.FlatButton1Click(Sender: TObject);
var
   erro:String;
begin
   if dataf.Date < datai.Date then
      erro := MSG_DATA1_MAIORQ_DATA2;
   if cbLoja.itemIndex < 0 then
      erro := MSG_FALTA_LOJA;

   if erro <> '' then
   begin
      erro := '   Corrija antes esses erros ' +  #13+ erro;
      msgTEla('', erro, MB_OK + MB_ICONERROR);
   end
   else
   begin
      geraComissao(nil);
      memo1.Lines.Add(copy(cbLoja.Items[cbLoja.itemindex], 01,30)
                      + ' tipo: ' +  copy(cbTipoComissao.Items[cbTipoComissao.itemindex], 01,30)
                      + ' de: ' + DateToStr(datai.Date)
                      + ' ate: ' + DateToStr(dataf.Date)
                           );
   end;
end;


procedure TfmRelatorioComissao.exportaDadosDoAtendimento(data:Tdate);
begin
   funcsql.execSQL('insert zcf_comissaoDL select ' + funcoes.DateTimeToSqlDateTime(data,'') + ', * from ' + tb.TableName, fmMain.Conexao );
end;

procedure TfmRelatorioComissao.FormResize(Sender: TObject);
begin
  memo1.Top := SoftDBGrid2.Height + SoftDBGrid2.top + 5;
end;

end.
