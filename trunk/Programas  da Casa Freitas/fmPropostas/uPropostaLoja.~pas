unit uPropostaLoja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid,
  TFlatButtonUnit, Menus, ExtCtrls, StdCtrls, adLabelEdit, adLabelComboBox,
  adLabelNumericEdit, Mask, adLabelMaskEdit, ComCtrls,
  adLabelDBDateTimePicker, fCtrls, RpCon, RpConDS, RpBase, RpSystem,
  RpDefine, RpRave, RpConBDE, RpRender, RpRenderPDF,   adLabelSpinEdit;

type
  TfmProposta = class(TForm)
    grid: TSoftDBGrid;
    Table: TADOTable;
    DataSource1: TDataSource;
    gb1: TGroupBox;
    edNmCli: TadLabelEdit;
    btDadosCliente: TFlatButton;
    edEnd: TadLabelEdit;
    edMsg: TadLabelEdit;
    edCidade: TadLabelEdit;
    EdNrCGC: TadLabelEdit;
    edFilCPFCGC: TadLabelEdit;
    edDgCGC: TadLabelEdit;
    sbar: TStatusBar;
    Panel1: TPanel;
    edFmPag: TadLabelEdit;
    edVendedor: TadLabelEdit;
    Label1: TLabel;
    dtProposta: TfsDateTimePicker;
    Label2: TLabel;
    TableDescricao: TStringField;
    TableQuant: TIntegerField;
    Tablecodigo: TStringField;
    Tableund: TBCDField;
    Tabletotal: TBCDField;
    FlatButton1: TFlatButton;
    btImp: TFlatButton;
    FlatButton3: TFlatButton;
    edValidade: TadLabelSpinEdit;
    procedure CriarTabelaProposta(Sender:Tobject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure GetDadosProdutos(Sender:Tobject;cod:string);
    procedure gridColExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btDadosClienteClick(Sender: TObject);
    procedure TableAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImportaDadosPedido(Sender:TObject; numPedido:string);
    function  montaRelatorio():Tstringlist;
    procedure btImpClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton3Click(Sender: TObject);
    procedure gridDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmProposta: TfmProposta;
  PRECO:String;
  operacao:String;
implementation
uses uMain, uNovaProposta, uEmail, funcSQL,funcoes,uCF;

{$R *.dfm}

{ TForm1 }

procedure TfmProposta.GetDadosProdutos(Sender: Tobject;cod:string);
var
  ds:TdataSet;
begin
   ds:= uCF.getDadosProd(fmMain.getUoLogada(), cod, PRECO, true );
   if (ds.IsEmpty = false) then
   begin
      table.FieldByName('Descricao').AsString := ds.fieldByName('descricao').AsString;
      table.FieldByName('Und').AsString := ds.fieldByName('preco').AsString;
   end;
   ds.Free();
end;

procedure TfmProposta.CriarTabelaProposta(Sender: Tobject);
var
  nmTable, cmd:string;
  i:integer;
begin
   if table.IsEmpty = true then
   begin
      Table.close;
      nmTable := '#'+ funcoes.GetNomeDoMicro()+'_'+ funcoes.sohNumeros(DateTimeToStr(now) ) ;
      cmd := 'Create Table '+ nmTable +'( Codigo varchar(13), Descricao varchar(50), Quant int, Und money, Total money) ';
      funcSQl.GetValorWell('E',cmd, '@@error',fmMain.conexao);

      Table.TableName := nmTable;
      Table.Open;

      grid.Columns[0].Width := 100;
      grid.Columns[01].Width := 300;
      grid.Columns[02].Width := 60;
      grid.Columns[03].Width := 120;
      grid.Columns[04].Width := 120;


      for i:= 0 to grid.Columns.Count -1 do
         grid.Columns[i].Title.Font.Style := [fsBold];
   end
   else
   begin
     table.First;
     while table.IsEmpty = false do
        table.Delete;
    end;
   for i:=0 to fmProposta.ComponentCount -1 do
   begin
     if fmProposta.Components[i].ClassType = TadLabelEdit then
     TadLabelEdit(Components[i]).Text := '';
   end;

   sbar.Panels[0].TEXT :='';
   sbar.Panels[1].TEXT :='';
end;

procedure TfmProposta.FormCreate(Sender: TObject);
begin
   dtProposta.Date := now;
end;

procedure TfmProposta.BitBtn3Click(Sender: TObject);
begin
    Operacao := 'i';
end;

procedure TfmProposta.gridColExit(Sender: TObject);
begin
  if (grid.SelectedIndex = 0) and (table.Fields[1].asString = '' ) then
     GetDadosProdutos(Sender, grid.SelectedField.AsString );

  if (grid.SelectedIndex in [2,3]) and (table.Modified )then
     table.FieldByName('total').AsString :=   FloatToStr( Table.fieldByName('Und').asFloat * TAble.fieldByName('Quant').asFloat );
end;

procedure TfmProposta.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   if not (ActiveControl is TDBGrid) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
  end
  else if (ActiveControl is TDBGrid) then
     with TDBGrid(ActiveControl) do

  if selectedindex < (fieldcount -1) then
     selectedindex := selectedindex +1
  else
     selectedindex := 0;
end;

procedure TfmProposta.btDadosClienteClick(Sender: TObject);
var
   cmd:String;
   query:TADOQuery;
begin
   cmd := ' Select top 01 cd_pes from dspes with(nolock) where nr_cpfcgc = ' +  funcoes.preencheCampo(9,'0','e', funcoes.SohNumeros(EdNrCGC.Text) )
        + ' and dg_cpfcgc  = ' +  funcoes.preencheCampo(2,'0','e',  funcoes.SohNumeros(edDgCGC.Text));
   Query := TADOQuery.Create(nil);
   query.Connection := fmMain.conexao;
   Query.SQL.Clear;
   if funcSQl.GetValorWell('O',cmd,'cd_pes',fmMain.conexao) <> '' then
   begin
      Query.sql.Add(' Exec stoConsultarPessoa ' + funcSQl.GetValorWell('O',cmd,'cd_pes',fmMain.conexao) );
      query.Open;
      edNmCli.text := query.FieldByName('NM_PES').AsString;
      edEnd.text :=  query.FieldByName('TP_LOGRAD').AsString +' '+ query.FieldByName('DS_END').AsString +' '+ query.FieldByName('NR_END').AsString;
      edCidade.text := query.FieldByName('ds_cid').AsString +' '+query.FieldByName('CD_UF').AsString ;
   end
   else
      msgTEla('', 'Esse CPF/CNPJ não é cadastrado',mb_iconerror + mb_ok);
end;

procedure TfmProposta.TableAfterPost(DataSet: TDataSet);
begin
   sbar.Panels[0].Text := 'Quant de itens : ' + inttoStr(table.RecordCount);
   sbar.Panels[1].Text := funcSQl.SomaColTable(Table,'Total', true);
end;

procedure TfmProposta.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_delete) and ( table.Modified = false) then
      table.Delete;
end;

procedure TfmProposta.ImportaDadosPedido(Sender: TObject; numPedido: string);
var
   DadosCliente:Tstrings;
   Qr:TADOQuery;
begin
   DadosCliente := GetValoresSQL2('Select nr_cpfcgc, nr_filCGC, dg_cpfcgc from dspes with(NoLock) inner join pedidoCliente with(nolock) on dspes.cd_pes = pedidoCliente.cd_pes where pedidoCliente.Numpedido = '+ numPedido, fmMain.conexao );
   EdNrCGC.Text := funcoes.preencheCampo(9,'0','e', dadosCliente[0]);
   edFilCPFCGC.text := funcoes.preencheCampo(4,'0','e', dadosCliente[1]);
   edDgCGC.text := funcoes.preencheCampo(2,'0','e', dadosCliente[2]);
   btDadosClienteClick(Sender);

   Qr := TADOQuery.Create(nil);
   Qr.Connection := fmMain.conexao;

   qr.SQL.Clear;
   Qr.SQL.Add(' Select crefe.cd_ref, crefe.Ds_ref, QuantPedido, ValorPrecoSugerido , ValorTotal, dspes.nm_fon '+
              ' from itensPedidoCliente with(noLock) '+
              ' inner join crefe with(NoLock) on itenspedidocliente.seqproduto = crefe.is_ref  ' +
              ' inner join dspes with(nolock) on itenspedidocliente.codVendedor = dspes.cd_pes ' +
              ' where NumPedido = ' + numPedido
             );
   Qr.Open;
   qr.First;
   edVendedor.text := qr.fieldByName('nm_fon').AsString;
   while qr.Eof = false do
   begin
      table.AppendRecord([
                           qr.FieldByName('cd_ref').AsString,
                           qr.FieldByName('ds_ref').AsString,
                           qr.FieldByName('QuantPedido').asInteger,
                           qr.FieldByName('ValorPrecoSugerido').AsString,
                           qr.FieldByName('ValorTotal').AsString
                         ]);
      qr.Next;
   end;
end;

function TfmProposta.montaRelatorio():Tstringlist;
var
   params :Tstringlist;
   dadosLoja:Tstrings;
   cmd:string;
begin
   cmd := ' Select REPLICATE (0, 9 - LEN(zcf_tbuo.nr_cgc)) +  cast( zcf_tbuo.nr_cgc as varchar(07))+''/''+ REPLICATE (0, 4 - LEN(zcf_tbuo.sr_cgc))  + cast(zcf_tbuo.sr_cgc as varchar(04)) +''-''+ CAST(zcf_tbuo.dg_cgc as varchar(02)) as CNPJ ,' +
          ' zcf_tbuo.nm_razsoc, tp_lograd+''  ''+ds_end + '' Nº''+ zcf_tbuo.nr_end + '' ''+ tbai.nm_Bai as endereco, tcid.nm_cid + '' ''+ zcf_tbuo.cd_uf, nr_cgf  from zcf_tbuo with (Nolock) ' +
          ' inner join tcid with(nolock) on zcf_tbuo.cd_cid = tcid.cd_cid ' +
          ' inner join tbai with(nolock) on zcf_tbuo.cd_bai = tbai.cd_bai and tbai.cd_cid = zcf_tbuo.cd_cid '+
          ' where zcf_tbuo.is_uo = ' + fmMain.getUoLogada() ;

   dadosLoja := funcSQl.GetValoresSQL2( CMD ,fmMain.conexao);
   params := TStringlist.Create();

{0}   params.add(dadosLoja[01] );
   params.add(dadosLoja[02] );
   params.add(dadosLoja[03] );
   params.add(dadosLoja[00] );
   params.add(dadosLoja[04] );
{5}params.add( EdNrCGC.text + '/'+ edFilCPFCGC.text +'-'+ edDgCGC.TEXT );
   params.add( edNmCli.Text );
   params.add( edEnd.Text);
   params.add( edMsg.Text );
   params.add( sbar.Panels[0].Text);
{10}params.add( sbar.Panels[1].Text);
   params.add( edFmPag.Text);
   params.add( edVendedor.Text);
   params.add( funcoes.dataPorExtenso(dtProposta.Date) );
   params.add( edValidade.Text );

   dadosLoja.Free();
   result := params;
end;

procedure TfmProposta.btImpClick(Sender: TObject);
begin
   if table.IsEmpty = false then
      fmMain.impressaoRave(Table, 'rpProposta', montaRelatorio() );
end;

procedure TfmProposta.FlatButton1Click(Sender: TObject);
begin
   Application.CreateForm(TfmNovaProposta, fmNovaProposta);
   fmNovaProposta.showModal

end;

procedure TfmProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmProposta := nil;
   Action := caFree;
end;

procedure TfmProposta.FlatButton3Click(Sender: TObject);
var
  arq:String;
  body:Tstringlist;
begin
   if table.IsEmpty = false then
   begin
      body := TStringList.Create();
      body.Add('proposta enviada pela loja ' );
      body.Add(fmMain.StatusBar1.Panels[0].Text);
      body.Add('Gerada em: ' + dateTimeToStr(now) );
      arq :=  funcoes.getDirLogs() + 'Proposta_' + fmMain.StatusBar1.Panels[0].Text +'_'+ funcoes.SohNumeros( dateToStr(now) ) + '.pdf';

      fmMain.impressaoRavePDF(Table, nil, 'rpProposta',  montaRelatorio(), arq );

      fmMain.EnviarEmail('', 'Assunto - proposta ' +arq , arq, body, 'Enviando e-mail para cliente...' );

      if ( msgTela('','Deseja guardar uma cópia ?', MB_YESNO + MB_ICONQUESTION) = mrYes ) then
         fmMain.EnviarEmail(funcsql.getEmail(fmMain.getUoLogada(), fmMain.Conexao), 'Assunto - proposta ' +arq , arq, body, 'Enviando copia do email  para a loja.. ');
      DeleteFile(arq);
   end;
end;

procedure TfmProposta.gridDblClick(Sender: TObject);
begin
   table.Delete;
end;

end.
