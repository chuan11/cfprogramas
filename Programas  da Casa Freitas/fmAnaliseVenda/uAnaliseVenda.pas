unit uAnaliseVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcDatas,
  Menus, DB, ADODB, StdCtrls, Buttons, fCtrls, adLabelComboBox, Grids,
  DBGrids, SoftDBGrid, ComCtrls,
  Dialogs, funcoes, funcSQL, TFlatButtonUnit, mxExport, ExtCtrls;

type
  TfmFaturamento = class(TForm)
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    tb: TADOTable;
    PopupMenu1: TPopupMenu;
    Detalhar1: TMenuItem;
    tbis_uo: TIntegerField;
    tbLoja: TStringField;
    tbPreviageralcaixa: TBCDField;
    tbVendacredcliente: TBCDField;
    tbVendaLiquida: TBCDField;
    tbFatvendaClientes: TBCDField;
    tbFatvendaentrelojas: TBCDField;
    tbVendasemcartao: TBCDField;
    tbFatVendamenosVendacartao: TBCDField;
    tbFattransfcomotransf: TBCDField;
    cbLojas: TadLabelComboBox;
    cbListaVdMaracanau: TfsCheckBox;
    btExportar: TfsBitBtn;
    btImprime: TfsBitBtn;
    fsBitBtn3: TfsBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CriarTabela(Sender: Tobject);
    procedure FlatButton1Click(Sender: TObject);
    procedure CalcularVendasLoja(Sender:Tobject);
    procedure ListarLojas(Sender:Tobject);
    procedure MostraMSG(msg:String);
    procedure ObterVendaLoja(Sender:Tobject);
    procedure obterFaturamentoVenda(Sender:Tobject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dataiChange(Sender: TObject);    procedure memoEnter(Sender: TObject);
    procedure SomaColunas(Sender:Tobject);
    procedure btExportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFaturamento: TfmFaturamento;
  colunas:  array[1..10]of string;
implementation

uses uMain, uCF;

{$R *.dfm}

procedure TfmFaturamento.MostraMSG(msg:String);
begin
  fmMain.MsgStatus(msg);
end;


procedure TfmFaturamento.FormCreate(Sender: TObject);
begin
//   cbLojas.items := funcsQL.GetNomeLojas( fmMain.Conexao, true, false, fmMain.lbPes.caption,'' ); // getListaPrecos (sender);

   cbLojas.ItemIndex := 3;

   fmMain.getParametrosForm(fmFaturamento);

   fmMain.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado() );
end;

procedure TfmFaturamento.CriarTabela(Sender: Tobject);
var
  cmd,ntb:String;
  i:integer;
begin
   if tb.TableName  = '' then
   begin
      colunas[1] := 'Fat venda Clientes';
      colunas[2] := 'Fat venda entre lojas';
      colunas[3] := 'Vendas em cartao';
      colunas[4] := 'Fat Venda menos Venda cartao' ;
      colunas[5] := 'Fat transf como transf' ;
      colunas[6] := 'Previa geral caixa';
      colunas[7] := 'Venda cred cliente';
      colunas[8] := 'Venda Liquida';
      colunas[9] := 'Devolucoes';
      colunas[10] := 'Venda menos devolucao';


      ntb := '#' + funcoes.SohLetras( funcoes.GetNomeDoMicro()) + funcoes.SohNumeros( DateTimeToStr(now));

      cmd := 'Create table ' + ntb +
      '( is_uo int, Loja varchar(30), ['+colunas[6]+'] money , ' +
      '['+colunas[7]+'] money, ' +
      '['+colunas[8]+'] money, ' +
      '['+colunas[1]+'] money, ' +
      '['+colunas[2]+'] money, ' +
      '['+colunas[3]+'] money , '+
      '['+colunas[4]+'] money , '+
      '['+colunas[5]+'] money ) '  ;

      funcSQl.GetValorWell('E',cmd,'@@error', fmMain.Conexao);
      tb.tableName:= ntb;
      tb.Open;
      grid.Columns[0].Visible := false; {coluna is_uo}
      grid.Columns[1].Width := 120;
      grid.Columns[2].Width := 120;
      grid.Columns[3].Width := 140;
      grid.Columns[4].Width := 120;

      for i:=0 to grid.Columns.Count -1 do
         grid.Columns[i].Title.Font.Style :=[fsbold];
   end
   else
      while tb.IsEmpty = false do
         tb.Delete;
end;


procedure TfmFaturamento.obterFaturamentoVenda(Sender: Tobject);
var
  tbFat:TADOTable;
//  strSrCupomFiscal,strSrNotaFiscal, str:string;
  cmd:String;
begin
   MostraMSG('Obtendo faturamento da loja: ' + tb.fieldByname('Loja').asString );

// cria a tabela para das notas faturadas
   funcSql.getTable(fmMain.Conexao, tbFat,
                    ' tipo varchar(05), dt_entsai smallDatetime, transacao int,  sr_docf varchar(03), '+
                    ' nr_docf int, vl_tot money, vl_nota money, cd_cfo int, st_nf ' +
                    ' varchar(03), vl_basICM money, aliq_ICM money, vl_ICM money'   );
   tbFat.Close();

// popular a tabela das notas fiscais
   cmd := 'insert ' + tbFat.TableName +
          ' exec zcf_stoListarRegistroSaida_cf ''('+ tb.fieldByname('is_uo').asString + ')'', ' + tb.fieldByname('is_uo').asString + ', '+ funcDatas.dateToSqlDate(datai.Date) + ', '
          + funcDatas.dateToSqlDate(dataF.Date) + ',0 ';

   gravaLog('vou executar: ' + cmd);

   funCSQL.execSQL(cmd, fmMain.Conexao);



// obter o valor do faturado para clientes
   cmd := ' select isnull(sum(vl_nota),0)as valor from ' + tbFat.TableName +
          ' where  cd_cfo in (5102, 6102, 6108) and st_nf = '''' ' +
          ' and transacao <> 2';
   tb.edit;
   tb.FieldByName(colunas[1]).asString :=  funcSQL.openSQL(cmd, 'Valor', fmMain.Conexao);
   tb.post;

// faturamento transferencia como venda
   cmd := ' select isnull(sum(vl_nota),0)as valor from ' + tbFat.TableName +
          ' where  cd_cfo in (5102, 6102, 6108) and st_nf = '''' ' +
          ' and transacao = 2 ';
   tb.edit;
   tb.FieldByName(colunas[2]).asString :=  funcSQL.openSQL(cmd, 'Valor', fmMain.Conexao);
   tb.post;

// Faturamento de transferencia entre lojas
   cmd := ' select isnull(sum(vl_nota),0)as valor from ' + tbFat.TableName +
          ' where  cd_cfo in (5152, 6152) and st_nf = '''' ' +
          ' and transacao = 2';
   tb.edit;
   tb.FieldByName(colunas[5]).asString :=  funcSQL.openSQL(cmd, 'Valor', fmMain.Conexao);
   tb.FieldByName(colunas[4]).asFloat := (tb.FieldByName(colunas[1]).asFloat + tb.FieldByName(colunas[2]).asFloat) - tb.FieldByName(colunas[3]).asFloat;
   tb.post;

   tbFat.Close();
end;

procedure TfmFaturamento.ObterVendaLoja(Sender: Tobject);
var
   qr:TDataSet;
   vVenda,vCartao,vCredito:real;
//   modCartao: array[1..27] of byte;
   i:byte;
   dsModalidadeCartao:TStringList;
begin
   MostraMSG('Obtendo vendas loja: ' + tb.fieldByName('Loja').AsString +'   -  ' );

   dsModalidadeCartao:= uCF.getCodModalidadesCartao();
   qr := uCF.getPreviaGeralCaixa(tb.fieldByName('is_uo').asString, '', datai.date, dataf.date, cbListaVdMaracanau.Checked, false);


  vVenda := 0;
  vCartao := 0;
  vCredito := 0;
  qr.First;
  while qr.Eof = false do
  begin
     if qr.FieldByName('fl_sinal').AsString = 'E' then
     begin
        vVenda:= vVenda + qr.FieldByName('valor').AsFloat;
        if ( dsModalidadeCartao.IndexOf(trim(qr.FieldByName('cd_mve').asString)) > -1  ) then
           vCartao := vcartao + qr.FieldByName('valor').asFloat;

        if ( qr.FieldByName('cd_mve').asInteger = 68   ) or ( qr.FieldByName('cd_mve').asInteger = 68 + 999  ) then
           vCredito := vCredito + qr.FieldByName('valor').asFloat;
     end;
     qr.Next;
  end;
  tb.Edit;
//  tb.FieldByName(colunas[6]).AsFloat := vVenda;
  tb.FieldByName('Previa geral caixa').AsFloat := vVenda;
  tb.FieldByName(colunas[7]).AsFloat := vCredito;
  tb.FieldByName(colunas[3]).AsFloat := vCartao;
  tb.FieldByName(colunas[8]).AsFloat := vVenda - vCredito;
  tb.Post;
end;

procedure TfmFaturamento.ListarLojas(Sender: Tobject);
var
   i:integer;
begin
   MostraMSG('Definindo as lojas que ir�o ser calculadas');

   if (cbLojas.ItemIndex <> 0 )then
   begin
      tb.Append;
      tb.FieldByName('is_uo').AsString :=  funcoes.getCodUO(cbLojas);
      tb.FieldByName('Loja').AsString := fmMain.getDescUO(cbLojas);
   end
   else
   begin
      for i := 1 to cbLojas.Items.Count -1 do
      begin
         cbLojas.ItemIndex := i;
         tb.Append;
         tb.FieldByName('is_uo').AsString := funcoes.getCodUO(cbLojas);
         tb.FieldByName('Loja').AsString := fmMain.getDescUO(cbLojas);
         tb.post
      end;
      cbLojas.ItemIndex := 0;      
   end;
   tb.First;
end;


procedure TfmFaturamento.CalcularVendasLoja(Sender: Tobject);
begin
   grid.Visible := false;
// cria a tabela que armazena os resultados
   CriarTabela(Sender);

   // Lmpar os campos da tabela
      MostraMSG('Limpando Campos.');
      While tb.IsEmpty = false do tb.Delete;

   //preencher a tabela com os dados das lojas
      ListarLojas(Sender);

   if (cbLojas.ItemIndex = 0) then
   begin
      tb.First;
      while (tb.Eof = false) do
      begin
         ObterVendaLoja(Sender);
         obterFaturamentoVenda(Sender);
         tb.Next;
      end;
      SomaColunas(Sender);
   end
   else
   begin
     // Obter Valores previa GeralCaixa e venda cartoes
      ObterVendaLoja(Sender);
      obterFaturamentoVenda(Sender);
   end;

 //verificar se for do grupo de gerentes ele nao mostrara algumas colunas
   if (pos(fmMain.getGrupoLogado(), fmMain.getParamBD('gruposRestritosTela','') ) <> 0 ) then
   begin
      btImprime.Visible := false;
      tb.First;
      while tb.Eof = false do
      begin
         tb.Edit;
         tb.FieldByName(colunas[7]).asinteger := 0;
         tb.FieldByName(colunas[5]).asinteger := 0;
         tb.FieldByName(colunas[2]).asinteger := 0;
         tb.Post;
         tb.Next;
      end;
   end;
   grid.Visible := true;
   MostraMSG('');
end;

procedure TfmFaturamento.FlatButton2Click(Sender: TObject);
var
  params:TStringList;
begin
   if tb.IsEmpty = false then
   begin
      params := TStringList.Create();
      params.Add(dateToStr(datai.Date) );
      params.Add(dateToStr(dataf.Date) );
      params.Add(fmMain.StatusBar1.Panels[01].Text );
      if( cbListaVdMaracanau.Checked = true) then
        params.Add('Sim')
      else
        params.Add('N�o');

      fmMain.impressaoRave(tb, 'rpAnaliseVendas', params);
//      tb.Close();
   end;
end;


procedure TfmFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.salvaCampos(fmFaturamento);
   fmFaturamento := nil;
   action := CaFree;
end;

procedure TfmFaturamento.dataiChange(Sender: TObject);
begin
   dataf.Date := datai.Date;
end;

procedure TfmFaturamento.memoEnter(Sender: TObject);
begin
  cbLojas.SetFocus;
end;

procedure TfmFaturamento.SomaColunas(Sender: Tobject);
var
  i:integer;
  t2:TADOTable;
begin
   t2 := TADOTable.Create(nil);
   t2.Connection := fmMain.Conexao;
   t2.Recordset := tb.Recordset;
   t2.open;
   tb.Last;
   tb.Append();
   tb.Fields[0].asString := '000000';
   tb.Fields[1].asString := 'Total                    ';

   for i:= 2 to tb.FieldCount -1 do
   begin
      tb.Fields[i].asFloat := Funcsql.SomaColunaTable(t2,t2.Fields[i].FieldName);
   end;
   t2.Close;
   t2.Free;
   tb.Post;
   tb.First;
end;

procedure TfmFaturamento.FlatButton1Click(Sender: TObject);
begin
   if ( (dataf.Date < datai.Date) or ( (dataf.Date - datai.Date) > 30 ) ) then
      MsgTela('', 'Intervalo de data inv�lido.', MB_ICONERROR + MB_OK)
   else
      CalcularVendasLoja(Sender);
end;

procedure TfmFaturamento.btExportarClick(Sender: TObject);
begin
   if tb.IsEmpty = false then
     funcsql.exportaTable(tb);
end;

end.
