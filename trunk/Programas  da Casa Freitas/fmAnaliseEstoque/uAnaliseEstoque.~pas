unit uAnaliseEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, StdCtrls,
  adLabelComboBox, adLabelEdit, Buttons, fCtrls;

type
  TfmAnaliseEstoque = class(TForm)
    edEnd: TadLabelEdit;
    CBPRECO01: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    fsBitBtn3: TfsBitBtn;
    btImprime: TfsBitBtn;
    cbTpConsulta: TadLabelComboBox;
    procedure FormActivate(Sender: TObject);
    procedure obterItensdoPedido(Sender:Tobject);
    procedure criaTabela(Sender:Tobject);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure ObterDadosEntrada(Sender:Tobject);
    procedure obterPrecos(Sender:Tobject);
    procedure obterVendas(Sender:Tobject);
    procedure cbTpConsultaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btImprimeClick(Sender: TObject);
    procedure obterQtPedido(Sender:Tobject);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAnaliseEstoque: TfmAnaliseEstoque;
  QT_MESES_VENDA_PREVISTA, UOCD:String;

implementation

uses uMain, funcoes, funcsql, uCF;

{$R *.dfm}

procedure TfmAnaliseEstoque.criaTabela(Sender: Tobject);
var
   cmd:String;
   i:integer;
begin
   if tb.Active = true then
      tb.Close();
   cmd :=  '( is_ref int, Codigo varchar(08), Descricao varchar(50), [Data Ult Entrada] varchar(10), [Qt ult Entrada] int, [Qt pedida] int, ' +
           '[Venda ultimo ano] int, [Vl ultima Compra] money,  Estoque int, [Venda Media] decimal, [Prev Venda] decimal, [Divergencia Ped x Previsto]  varchar(03)  )';
   tb.TableName :=  funcsql.criaTabelaTemporaria(fmMain.Conexao, cmd);
   tb.Open();

   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];
end;

procedure TfmAnaliseEstoque.FormActivate(Sender: TObject);
begin
   CBPRECO01.Items := funcsql.getListaPrecos(fmMain.Conexao, true, false, false, fmMain.getGrupoLogado());
   CBPRECO01.ItemIndex := 0;
//   cbLoja.Items := funcsql.GetNomeLojas(fmMain.Conexao, false, false, fmMain.lbPes.Caption,'');

   cbLoja.ItemIndex := 0;
   UOCD := fmMain.GetParamBD('uocd','');
   QT_MESES_VENDA_PREVISTA := fmMain.GetParamBD('qtMesesPrevisaoVenda','');
   fmMain.getParametrosForm(fmAnaliseEstoque);


   uCF.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado() );

   edEnd.text := '';
end;

procedure TfmAnaliseEstoque.obterItensdoPedido(Sender: Tobject);
var
  strItens, cmd:String;

begin
   fmMain.MsgStatus(' 01 de 05  - Obtendo os dados dos produtos ');

   case cbTpConsulta.ItemIndex of
      0: strItens := 'select is_ref from dsipe (nolock) where is_pedf =  ' +  edEnd.Text;
      1: strItens := 'Select is_ref from crefe where cd_ref like '+  quotedstr(edEnd.Text +'%') ;
   end;

   cmd := 'insert '+tb.TableName +
          ' Select is_ref, cd_ref' +
          ', ds_ref' +
          ',null, null, null, null, null ' +
          ', dbo.Z_CF_EstoqueNaLoja( is_ref ,' + funcoes.getNumUO(cbLoja)   +', 1)' +
          ', null, null, null ' +
          ' from crefe (nolock) where is_ref in ('+ strItens +') order by cd_ref';
   execSQL(cmd, fmMain.Conexao);
   tb.close();
   tb.Open();
end;

procedure TfmAnaliseEstoque.ObterDadosEntrada(Sender: Tobject);
var
  ds: TdataSet;
  cmd :String;
begin
   fmMain.MsgStatus('  01 de 05  -  Obtendo Dados de entrada: ');
   tb.First();
   while tb.Eof = false do
   begin
      cmd := 'exec zcf_getDadosEntProduto '+ tb.fieldByname('is_ref').asString + ' , ' +  funcoes.getNumUO(cbLoja);
      ds:= funcsql.getDataSetQ(cmd, fmMain.Conexao);

      if ds.IsEmpty = false then
      begin

         tb.Edit;
         tb.FieldByName('Data Ult Entrada').AsString:= ds.fieldByname('Data Entrada').asString;
         tb.FieldByName('Qt ult Entrada').AsInteger := ds.fieldByname('Quant Recebida').AsInteger;
         tb.Post();
      end;
      ds.Destroy();
      tb.Next();
   end;
end;

procedure TfmAnaliseEstoque.obterVendas(Sender: Tobject);
var
  ds: TdataSet;
  cmd :String;
  datai, dataf :String;
begin
   fmMain.MsgStatus('03 de 05 - Obtendo vendas: ');

   dataF := funcSql.getDataBd(fmMain.Conexao);
   datai := funcSql.getDataBd(fmMain.Conexao,365);
   tb.First();
   while tb.Eof = false do
   begin
      cmd :=' SELECT dbo.Z_CF_funObterVendaPorPeriodo ('+
              funcoes.getNumUO(cbLoja) +', '+
              tb.fieldByname('is_ref').asString + ', '+
              datai +', '+
              dataf +', '+
              datai +', '+
              UOCD  + ' ) as qtVenda';
      ds:= funcsql.getDataSetQ(cmd, fmMain.Conexao);
      if ds.IsEmpty = false then
      begin
         tb.Edit;
         tb.FieldByName('Venda ultimo ano').AsString:= ds.fieldByname('qtVenda').asString;
         tb.FieldByName('Venda Media').AsFloat := (ds.fieldByname('qtVenda').AsFloat / 12);
         tb.FieldByName('Prev Venda').AsFloat := (ds.fieldByname('qtVenda').AsFloat /2);

         if cbTpConsulta.ItemIndex  = 0 then
            if tb.FieldByName('Prev Venda').AsFloat  < tb.FieldByName('Qt pedida').AsFloat then
               tb.fieldByname('Divergencia Ped x Previsto').AsString := 'Sim';

         tb.Post();
      end;
      ds.Destroy();
      tb.Next();
   end;
end;

procedure TfmAnaliseEstoque.obterPrecos(Sender: Tobject);
var
  ds: TdataSet;
  cmd :String;
begin
   fmMain.MsgStatus('04 de 05  Obtendo preços: '  + tb.FieldByName('Codigo').AsString + ' ' + tb.FieldByName('Descricao').AsString );

   tb.First();
   while tb.Eof = false do
   begin
      cmd :=' SELECT dbo.Z_CF_funObterPrecoProduto_CF('+
              funcoes.getCodPc(CBPRECO01) +', '+
              tb.fieldByname('is_ref').asString + ', '+
              funcoes.getNumUO(cbLoja) +', '+
              ' 0 ) as preco';
      ds:= funcsql.getDataSetQ(cmd, fmMain.Conexao);
      if ds.IsEmpty = false then
      begin
         tb.Edit;
         tb.FieldByName('Vl ultima Compra').AsString:= ds.fieldByname('preco').asString;
         tb.Post();
      end;
      ds.Destroy();
      tb.Next();
   end;
end;

procedure TfmAnaliseEstoque.cbTpConsultaChange(Sender: TObject);
begin
   case cbTpConsulta.ItemIndex of
     0:edEnd.LabelDefs.Caption := 'Numero do Pedido';
     1:edEnd.LabelDefs.Caption := 'Faixa de código';
   end;
end;

procedure TfmAnaliseEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   salvaCampos(fmAnaliseEstoque);
   action := cafree;
   fmAnaliseEstoque := nil;
end;

procedure TfmAnaliseEstoque.btImprimeClick(Sender: TObject);
var
  p:TStringlist;
begin
   if tb.IsEmpty = false then
   begin
      p := TStringList.Create();
      p.Add( edEnd.LabelDefs.Caption); //0
      p.Add( copy(funcoes.getNomePc(CBPRECO01),01,20 ) ); //1
      p.Add( trim(getNomeUO(cbLoja)) );            //2
      p.Add( fmMain.getNomeUsuario());      //3
      p.Add( QT_MESES_VENDA_PREVISTA  );      //4
      fmMain.impressaoRave(tb, 'rpAnaliseEstoqueParaCompra', p);
   end;
end;



procedure TfmAnaliseEstoque.obterQtPedido(Sender: Tobject);
var
  cmd :String;
begin
   fmMain.MsgStatus('05 de 05 '  + tb.FieldByName('Codigo').AsString + ' ' + tb.FieldByName('Descricao').AsString );
   tb.First();
   while tb.Eof = false do
   begin
      cmd := ' Select top 01 isnull(qt_ped,0) as qt from dsipe (nolock) where is_pedf = '+ edEnd.Text+ ' and is_ref = ' + tb.fieldByname('is_ref').asString;
      cmd :=   funcsql.openSQL(cmd, 'qt', fmMain.Conexao );
      if cmd <> '0' then
      begin
         tb.Edit;
         tb.FieldByName('Qt pedida').AsString:= cmd;
         tb.Post();
      end;
      tb.Next();
   end;
   tb.First();
end;

procedure TfmAnaliseEstoque.fsBitBtn3Click(Sender: TObject);
begin
   if length( edEnd.Text ) >= 3 then
   begin
      criaTabela(nil);

      grid.Visible := false;

      obterItensdoPedido(nil);
      obterDadosEntrada(nil);

      if cbTpConsulta.ItemIndex  = 0 then
         obterQtPedido(nil);

      obterVendas(nil);
      obterPrecos(nil);

      fmMain.MsgStatus('');

      tb.First();
      grid.Visible := true;
      tb.Fields[ tb.Fields.IndexOf(tb.fieldByname('is_ref'))   ].Visible := false;
      grid.Columns[ tb.Fields.IndexOf( tb.fieldByname('Vl ultima Compra'))  ].Title.caption := funcoes.getNomePc(CBPRECO01);
   end;
end;

procedure TfmAnaliseEstoque.gridDrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
begin
   if  Column.Title.caption  =  'Divergencia Ped x Previsto'  then
   begin
      grid.Canvas.Font.Color:= clRed;
      grid.Canvas.Font.Style := [fsBold];
      grid.DefaultDrawDataCell(Rect, tb.Fields[  tb.Fields.IndexOf( tb.fieldByname('Divergencia Ped x Previsto')) ] , State);
   end;
end;

end.
