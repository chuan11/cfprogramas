unit uGeraEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, DB, ADODB,comObj, ExtCtrls,funcoes, StdCtrls,
  TFlatButtonUnit, adLabelEdit, SoftDBGrid, mxExport, RpRave, RpBase,
  RpSystem, RpDefine, RpCon, RpConDS, TFlatEditUnit, adLabelComboBox,
  ComCtrls, adLabelNumericEdit, adLabelSpinEdit, Menus, funcSql, fCtrls,
  CheckLst, adLabelCheckListBox, adLabelListBox {, uChamaCat} ;

type
  TfmGeraEstoque = class(TForm)
    edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    cbLoja: TadLabelComboBox;
    cbPrecos: TadLabelComboBox;
    cbEstoque: TadLabelComboBox;
    Bt_Saidas: TFlatButton;
    Bt_Entradas: TFlatButton;
    pbRodape: TPanel;
    spedit: TadLabelSpinEdit;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    FlatButton5: TFlatButton;
    FlatButton4: TFlatButton;
    tbGE: TADOTable;
    FlatButton2: TFlatButton;
    FlatButton6: TFlatButton;
    cbProdAtivos: TfsCheckBox;
    Panel1: TPanel;
    lbNivel: TLabel;
    lbVlCat: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    VerdetalhesdaCMU1: TMenuItem;
    Label2: TLabel;
    cbSoEntrada: TfsCheckBox;
    Pedidosdecompra1: TMenuItem;
    FlatButton7: TFlatButton;
    rgTpBusca: TadLabelComboBox;
    FlatButton3: TFlatButton;
    cbCalEmp: TfsCheckBox;
    Label3: TLabel;
    pnForn: TPanel;
    btAddForn: TFlatButton;
    btRemoveForn: TFlatButton;
    lbForn: TadLabelListBox;
    Vermovimentodoestoque1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure ADOConnection1ExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;      var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure Bt_EntradasClick(Sender: TObject);
    procedure Bt_SaidasClick(Sender: TObject);
    function GetIniDtVen():Tdate;
    procedure speditChange(Sender: TObject);
    procedure cbLojaChange(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure MosraFormSaldos(sender: TObject);
    procedure MosraFormRequisicoes(sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure CriarTabela(Sender:Tobject);
    procedure ListaProdutosPorFornecedor(Sender:Tobject);
    procedure rgTpBuscaClick(Sender: TObject);
//    function  listarItensPorFaixaCodigo():TdataSet;
    procedure ProgressoDaExecucao(Sender:Tobject;nItem:integer);
    procedure GeraEstoque(Sender:TObject);
    procedure gridCellClick(Column: TColumn);
    procedure gridTitleClick(Column: TColumn);
    procedure FlatButton6Click(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PedidosDeCompra1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure getDadosEstoqueCD();
    procedure getDadosEntrada();
    procedure removeItensSemEntrada();
    procedure calcularVenda();
    procedure preencheDadosDosProdutos();
    function  listaProdutoPorPedido():TdataSet;
    procedure VerdetalhesdaCMU1Click(Sender: TObject);
    procedure btAddFornClick(Sender: TObject);
    procedure btRemoveFornClick(Sender: TObject);
    function  listaProdPorFornecedor():TDataSet;
    procedure FlatButton3Click(Sender: TObject);
    procedure Vermovimentodoestoque1Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmGeraEstoque: TfmGeraEstoque;
  UO_CD:string;
  IsOrderDesc:byte;
implementation

uses uMain, ucf, uforn, uExportaTable;

{$R *.dfm}

procedure TfmGeraEstoque.removeItensSemEntrada();
var
  cmd:String;
begin
   fmMain.msgStatus('Removendo itens sem entrada...');
   tbGE.Close();
   cmd := 'delete from ' + tbge.TableName + ' where [Data Ultima Ent] = '''' or  [Data Ultima Ent] is null ';
   funcSQL.execSQL(cmd, fmMain.Conexao);
   tbGE.Open();
end;

procedure TfmGeraEstoque.ProgressoDaExecucao(Sender:Tobject;nItem:integer);
begin
   fmMain.msgStatus('Item ' + intToStr(nItem) + ' de  ' +
                    intToStr(tbGE.RecordCount) +
                    '  '+ tbGE.fieldByName('Codigo').asString + ' ' +
                    tbGE.fieldByName('descricao').asString
                   );
end;

procedure TfmGeraEstoque.calcularVenda;
var
   dataI:Tdate;
begin
   fmMain.msgStatus('Calculando vendas...');
   tbGE.first();
   while (tbGE.Eof = false) do
   begin
      if ( tbGE.FieldByName('Data Ultima Ent').AsString = '') then
         datai := now - (30* spedit.Value)
      else
         datai := tbGE.FieldByName('Data Ultima Ent').AsDateTime;

      tbGE.edit();
      tbGE.fieldByName('Total venda').asString := uCF.getVendaProduto(
                        tbGe.fieldByName('is_ref').AsString,
                        funcoes.getCodUO(cbLoja),
                        UO_CD,
                        datai,
                        now);
      tbGE.post();
      tbGE.next();
   end;
end;

procedure TfmGeraEstoque.ListaProdutosPorFornecedor(Sender: Tobject);
var
  Query:TadoQuery;
  strDisponivel,StrEstoque, cmd:String;

begin
   strDisponivel := '0';

   strEstoque := ' dbo.Z_CF_EstoqueNaLoja (crefe.is_ref , '+ copy(cbLoja.Items[cbLoja.itemIndex], 51, 08) + ' , '+ strDisponivel + ')';

   
   query := TadoQuery.Create(fmGeraEstoque);
   Query.Connection := fmMain.Conexao;
   Query.SQL.Clear;
   cmd := ' select crefe.is_ref, crefe.ds_ref, crefe.cd_ref , '+ strEstoque +  'from dsrfo with(NoLock)' +

                 ' inner join dscre with(NoLock) on dscre.cd_pes = dsrfo.cd_pes '+
                 ' left join crefe  with(NoLock) on dsrfo.is_ref = crefe.is_ref ';

   if  lbNivel.Caption <> '0' then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+
                   quotedstr(lbNivel.Caption) + ' and cd_vcampo  = ' + quotedstr(lbVlCat.Caption);

   cmd := cmd +' where dscre.cd_cred = ' + edit1.Text ;

   if cbLoja.ItemIndex = 0 then
      cmd := cmd + ' and ' + strEstoque + ' > 0 ';

   cmd := cmd + ' order by crefe.cd_ref ';

   Query.SQL.Add(cmd);
   Query.Open;

   query.first;
   while query.Eof = false do
   begin
      tbGE.Append;
      tbGE.FieldByName('codigo').AsString := query.fieldByName('cd_ref').asString;
      tbGE.FieldByName('descricao').AsString := query.fieldByName('ds_ref').asString;
      tbGE.FieldByName('is_ref').AsString := query.fieldByName('is_ref').asString;

      tbGE.Post;
      query.Next;
   end;
   query.First;
end;

function TfmGeraEstoque.getIniDtVen():TDate;
begin
   result := (now - (30 * spedit.Value));
end;

procedure TfmGeraEstoque.SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
    funcoes.WParReg('PosEstoque','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
end;

procedure TfmGeraEstoque.FlatButton2Click(Sender: TObject);
begin
   if not(tbGE.IsEmpty) then
   begin
{      rvproject1.SetParam('loja', copy(cbLoja.Items[cbLoja.itemindex],01,30)) ;
      rvproject1.SetParam('TpVenda', copy(cb1.Items[cb1.itemindex],01,30)) ;
      rvproject1.SetParam('TPestoque', cb3.Items[cb3.itemindex]) ;
      rvproject1.SetParam('Ordenacao', '' ) ;
      rvproject1.SetParam('codigo', edit1.text) ;

      if checkBox2.Checked = true then
         rvproject1.SetParam('estoqueCd', 'Estoque CD') ;

      rvproject1.ExecuteReport('Report2');
}
   end;
end;


procedure TfmGeraEstoque.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case key of
      vk_return : FlatButton1Click(Sender);
      VK_F6:Bt_EntradasClick(Sender);
      VK_F7:Bt_SaidasClick(Sender);
//      VK_F8:FlatButton3Click(Sender);
   end;
end;

procedure TfmGeraEstoque.FormCreate(Sender: TObject);
begin
   cbPrecos.items := funcsQL.getListaPrecos( fmMain.Conexao, true, true, true, '13' ); // getListaPrecos (sender);
   fmMain.getListaLojas( cbLoja, false, false, '' );

   carregaCampos(fmGeraEstoque);

   cbLojaChange(Sender);
   fmGeraEstoque.CriarTabela(Sender);
   rgTpBuscaClick(Sender);
   UO_CD := fmMain.getUOCD();

   pnforn.Top := 55;
   pnforn.Left := edit1.Left;
end;

procedure TfmGeraEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   tbge.Close();
   funcoes.salvaCampos(fmGeraEstoque);
   Action := caFree;
   fmGeraEstoque := nil;
end;

procedure TfmGeraEstoque.ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
begin
   SCREEN.Cursor := CRHOURGLASS;
   funcoes.gravaLog(CommandText);
end;

procedure TfmGeraEstoque.ADOConnection1ExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.cursor := crDefault;
end;
procedure TfmGeraEstoque.Bt_EntradasClick(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   if (tbGE.IsEmpty = false) then
      fmMain.obterDetalhesEntrada(tbGE.fieldByName('is_ref').asString );
   screen.Cursor := crdefault;
end;

procedure TfmGeraEstoque.Bt_SaidasClick(Sender: TObject);
var
   dtInicio:Tdate;
begin
   screen.Cursor := crHourGlass;

   if (tbGE.fieldByName('Data Ultima Ent').AsString <> '') then
      dtInicio := tbGE.fieldByName('Data Ultima Ent').AsDateTime
   else
      dtInicio :=  getIniDtVen();

   if (tbGE.IsEmpty = false) then
       fmMain.obterDetalhesSaida( tbGE.fieldByName('is_ref').asString,
                                  funcoes.getCodUO(cbLoja), dtInicio
                                 );
   screen.Cursor := crdefault;
end;

procedure TfmGeraEstoque.speditChange(Sender: TObject);
begin
  if (spedit.Value < 1) then
     spedit.Value := 1
end;

procedure TfmGeraEstoque.cbLojaChange(Sender: TObject);
begin
   if cbLoja.ItemIndex > 0 then
      checkBox2.Checked := true
   else
      checkBox2.Checked := false;
end;

procedure TfmGeraEstoque.MosraFormSaldos(sender: TObject);
var
  EhDisponivel,programa:string;
begin
   screen.Cursor := crhourGlass;


   programa := ExtractFilePath(ParamStr(0)) + 'ResumoEstoque.exe "'+ 'ResumoDoEstoque" '+tbGE.FieldByName('codigo').asString+' "'+tbGE.FieldByName('descricao').asString+'" '+tbGE.FieldByName('is_ref').asString +' '+ EhDisponivel;

   PostMessage(FindWindow(nil, 'ResumoDoEstoque'), WM_CLOSE,0,0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
end;


procedure TfmGeraEstoque.MosraFormRequisicoes(sender: TObject);
var
   programa:string;
begin
   screen.Cursor := crhourGlass;

   programa := '"' + ExtractFilePath(ParamStr(0)) + 'RequisicaoPorProduto.exe" -c ';

   if cbLoja.ItemIndex = 0 then
      programa := programa + ' 0 ' + UO_CD
   else
      programa := programa + funcoes.SohNumeros(copy(cbLoja.Items[cbLoja.ItemIndex],40,50) ) +' '+ UO_CD ;

   if tbGE.FieldByName('Data Ultima Ent').asString <> '' then
      programa := programa +' '+ tbGE.FieldByName('Data Ultima Ent').asString
   else
      programa := programa +' '+ DateToStr(now - (30 * spEdit.Value ) );

   programa := programa +' '+ DateToStr(now) + ' '+ tbGE.FieldByname('is_ref').AsString;

   PostMessage(FindWindow(nil, 'ConsultaRequisicao'), WM_CLOSE,0,0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
end;

procedure TfmGeraEstoque.FlatButton5Click(Sender: TObject);
var
   disponivel: String;
begin
   if not(tbGE.IsEmpty) then
      fmMain.obterResumoEstoque(
                                tbGE.fieldByName('is_ref').AsString,
                                disponivel
                               );
end;

procedure TfmGeraEstoque.FlatButton4Click(Sender: TObject);
begin
  if not(tbGE.IsEmpty) then
     MosraFormRequisicoes(Sender);
end;

procedure TfmGeraEstoque.CriarTabela(Sender: Tobject);
var
  i:integer;
begin
   tbGE.TableName := funcSQL.criaTabelaTemporaria(fmMain.Conexao, ' ( Codigo varchar(08), Descricao varchar(50), '+
   ' [Data Ultima Ent] smalldateTime, [Quant Ultima Ent] integer, ' +
   ' [Total Venda] integer, Estoque integer, EstoqueCD integer, PV money, [is_ref] integer ) ' );
   tbGE.Open;

   grid.Columns[0].Width := 60;
   grid.Columns[1].Width := 290;
   grid.Columns[2].Width :=  82;
   grid.Columns[3].Width :=  88;
   grid.Columns[4].Width :=  65;
   grid.Columns[5].Width :=  65;
   grid.Columns[6].Width :=  65;
   grid.Columns[7].Width :=  80;
   grid.Columns[8].Visible := false;

   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style :=[fsbold];
end;


procedure TfmGeraEstoque.rgTpBuscaClick(Sender: TObject);
begin
    Case rgTpBusca.ItemIndex of
       0: edit1.LabelDefs.Caption := 'Faixa de c�digo';
       1: edit1.LabelDefs.Caption := 'N�mero do pedido';
       2: edit1.LabelDefs.Caption := 'C�digo do fornecedor';
    end;

    if (rgTpBusca.ItemIndex  = 2) then
       pnForn.Visible := true
    else
       pnForn.Visible := false;
end;

procedure TfmGeraEstoque.gridCellClick(Column: TColumn);
begin
   if (tbGE.IsEmpty = false) then
      fmMain.msgStatus(tbGE.fieldByName('is_ref').asString);
end;

procedure TfmGeraEstoque.gridTitleClick(Column: TColumn);
begin
   if IsOrderDesc = 0 then
   begin
      tbGE.Sort := '['+column.FieldName+']';
      IsOrderDesc := 1;
   end
   else
   begin
      tbGE.Sort := '['+column.FieldName+'] DESC';
      IsOrderDesc := 0;
   end;
end;


procedure TfmGeraEstoque.FlatButton6Click(Sender: TObject);
var
  uo:String;
begin
   if (cbCalEmp.Checked = true) then
      uo := ''
   else
      uo := funcoes.getCodUO(cbLoja);

    if (tbGE.IsEmpty = false) then
       fmMain.obterResumoEntSai(tbGE.FieldByName('is_ref').AsString, uo);
end;

procedure TfmGeraEstoque.FlatButton7Click(Sender: TObject);
var
  descCat01, descCat02, descCat03, vlNivel, vlCat: String;
begin
   fmMain.ajustaValoresCategorias(descCat01, descCat02, descCat03, vlNivel, vlCat);
   lbClasse1.Caption := descCat01;
   lbClasse2.Caption := descCat02;
   lbClasse3.Caption := descCat03;
   lbNivel.Caption := vlNivel;
   lbVlCat.Caption := vlCat;
end;

procedure TfmGeraEstoque.PedidosDeCompra1Click(Sender: TObject);
begin
   if (tbGE.IsEmpty = false) then
     fmMain.getPedidosFornecedor( tbGE.fieldByname('is_ref').asString, UO_CD);
end;

procedure TfmGeraEstoque.FormActivate(Sender: TObject);
begin
   edit1.SetFocus;
   rgTpBusca.ItemIndex := 0 ;
end;


function TfmGeraEstoque.listaProdutoPorPedido():TdataSet;
var
  cmd :string;
begin
   cmd :=  ' select crefe.is_ref, crefe.cd_ref, crefe.ds_ref ' +
           ' from crefe inner join dsipe  on crefe.is_ref = dsipe.is_ref ';

   if  lbNivel.Caption <> '0' then
      cmd := cmd + ' inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+ quotedstr(lbNivel.caption) + ' and cd_vcampo  = ' + quotedstr(lbVlCat.caption);

   cmd := cmd + ' where    dsipe.is_pedf = '+ quotedStr(edit1.text);

   result := funcSQL.getDataSetQ(cmd, fmMain.conexao);
end;


procedure TfmGeraEstoque.FormResize(Sender: TObject);
begin
   grid.Height :=  fmGeraEstoque.Height - (grid.Top + pbRodape.Height + 40 );
end;

procedure TfmGeraEstoque.getDadosEstoqueCD;
var
  data:Tdate;
begin
   fmMain.msgStatus('Obtendo estoques cod CD');
   data:= now;

   tbGE.First();
   while (tbGE.Eof = false) do
   begin
       tbge.Edit();
       tbge.FieldByName('EstoqueCD').AsString:=
          uCF.getEstoqueProduto( UO_CD,
                                 tbGE.fieldByName('is_ref').AsString,
                                 'D',
                                 data
                                );
      tbGE.post();
      tbGE.Next();
   end;
end;

function  TfmGeraEstoque.listaProdPorFornecedor():TDataSet;
var
  strForn, cmd:String;
  i:integer;
begin
   for i:=0 to lbForn.Items.Count -1 do
   begin
      strForn := strForn + trim( copy(lbForn.Items[i], 101, 20));
      if (i < lbForn.Items.Count -1) then
         strForn := strForn + ', ';
   end;

   cmd := 'Select is_ref from crefe (nolock)';
   if (lbNivel.Caption <> '0') then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave ' +
      ' and cd_campo = '+ quotedstr(lbNivel.caption) +
      ' and cd_vcampo  = ' + quotedstr(lbVlCat.caption);

   cmd := cmd + 'where crefe.cd_pes in (' + strForn + ')';

   if (cbProdAtivos.Checked = true) then
      cmd := cmd + ' and crefe.fl_ativo = ''1''  order by cd_ref ';

   result := funcsql.getDataSetQ(cmd, fmMain.Conexao);
end;


procedure TfmGeraEstoque.getDadosEntrada();
var
   ds:TdataSet;
begin
   fmMain.msgStatus('Obtendo dados sobre as entradas...');

   tbGE.First();
   while (tbGE.Eof = false) do
   begin
      ds:= uCF.getDadosUltEntItem(tbGE.fieldByName('is_ref').AsString, funcoes.getCodUO(cbLoja));
      if (ds.IsEmpty = false) then
      begin
         tbge.Edit();
         tbge.FieldByName('Data Ultima Ent').AsDateTime := ds.fieldByName('dt_mov').AsDateTime;
         tbge.FieldByName('Quant Ultima Ent').AsString := ds.fieldByName('qt_mov').asString;
         tbGE.post();
      end;
      ds.free;
      tbGE.Next();
   end;
end;

procedure TfmGeraEstoque.VerdetalhesdaCMU1Click(Sender: TObject);
begin
   if (tbGe.IsEmpty = false) then
      fmMain.getDadosCRUC(tbGE.fieldByName('is_ref').asString);
end;

procedure TfmGeraEstoque.preencheDadosDosProdutos;
var
   ds, dsItens:TdataSet;
   insereItem:boolean;
begin
   dsItens := TDataSet.Create(nil);
   ds := TDataSet.Create(nil);
   fmMain.msgStatus('Obtendo lista de itens....');

   case (rgTpBusca.ItemIndex) of
      0:dsItens:= uCF.getIsrefPorFaixaCodigo(edit1.Text, lbNivel.Caption, lbVlCat.Caption, cbProdAtivos.Checked);
      1:dsItens:= listaProdutoPorPedido();
      2:dsItens:= listaProdPorFornecedor();
   end;

   if (dsItens.IsEmpty = false ) then
     dsItens.first;

   while (dsItens.Eof = false) do
   begin
      insereItem:= true;
      ds := uCF.getDadosProd( funcoes.getCodUO(cbLoja), dsItens.fieldByname('is_ref').AsString, fmMain.getCodPreco(cbPrecos), true );
      if (ds.IsEmpty = false) then
      begin
         if (cbEstoque.ItemIndex = 0 ) and ( ds.fieldByName('EstoqueDisponivel').asString = '0'  ) then
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
      end;
      ds.free;
   end;
end;

procedure TfmGeraEstoque.GeraEstoque(Sender: TObject);
begin
   grid.Visible := false;
   screen.cursor := crHourGlass;

   while (tbGE.IsEmpty = false) do
      tbGE.delete;

// procedure para Obter os items
   preencheDadosDosProdutos();

// preenche os dados do Estoque dos produtos
   if ( UO_CD <> funcoes.getCodUO(cbLoja) ) then
      getDadosEstoqueCD();

// pega os Dados das entradas dos produtos
   getDadosEntrada();

// remove os itens sem entrada se for solicitado
   if (cbSoEntrada.Checked = true) then
      removeItensSemEntrada();

// calculaVenda dos produtos
    calcularVenda();

 fmMain.msgStatus('');
 grid.Visible := true;
end;


procedure TfmGeraEstoque.FlatButton1Click(Sender: TObject);
var
  erro:String;
begin
   if (rgTpBusca.ItemIndex = 0)  and  (length(edit1.text) < 3) then
      erro := 'Informe ao menos o c�digo com 3 caracteres' + #13;

   if (rgTpBusca.ItemIndex = 1)  and  (length(edit1.text) < 1) then
      erro := 'Informe o numero do pedido.' + #13;

   if (rgTpBusca.ItemIndex = 2)  and  (lbForn.Items.Count < 1) then
      erro := 'Escolha ao menos um fornecedor' + #13;

   if (cbPrecos.ItemIndex < 0) then
      erro := erro +  'Escolha um tipo de pre�o para exibir' + #13;

   if (cbLoja.ItemIndex < 0) then
      erro := erro +  'Escolha uma loja para gerar o relat�rio' + #13;

   if (rgTpBusca.ItemIndex < 0 )then
      erro := erro +  'Escolha um tipo  de relat�rio' + #13;

   if (erro =  '') then
   begin
      screen.Cursor := crhourglass;

      geraEstoque(Sender);

      screen.Cursor := crDefault;
      grid.Columns[ tbGE.FieldByName('pv').Index ].Title.Caption := copy(cbPrecos.Items[cbPrecos.itemindex], 01, 20);
   end
   else
      funcoes.msgTela('','Erro:'+#13+ erro, MB_ICONERROR);
end;


procedure TfmGeraEstoque.btAddFornClick(Sender: TObject);
begin
   Application.CreateForm(TfmForn, fmForn);
   fmForn.ShowModal;
   if fmForn.ModalResult = mrOk then
      lbForn.Items.Add(
         funcoes.preencheCampo(100,' ','D', fmForn.qrCredores.FieldByName('fornecedor').asString ) +
         fmForn.qrCredores.FieldByName('codigo').asString,
                       );
   fmForn.Close();
end;

procedure TfmGeraEstoque.btRemoveFornClick(Sender: TObject);
begin
    if ( lbForn.Items.Count > 0 ) then
       lbForn.Items.Delete(lbForn.ItemIndex);
end;


procedure TfmGeraEstoque.FlatButton3Click(Sender: TObject);
begin
    if (fmExportaTable = nil) then
    begin
       Application.CreateForm(TfmExportaTable, fmExportaTable);
       fmExportaTable.show();
    end;
end;

procedure TfmGeraEstoque.Vermovimentodoestoque1Click(Sender: TObject);
var
   di,df:Tdate;
   itens:TStringList;
   tbItens, tbMov:TADOTable;
   params:TStringList;
begin
   if (tbGE.IsEmpty = false) then
   begin
     if (tbGE.fieldByName('Data Ultima Ent').AsString <> '') then
        di := strToDate(tbGE.fieldByName('Data Ultima Ent').AsString)
     else
        di := GetIniDtVen();

    df:= now;

    itens := TSTringlist.Create();
    itens.Add(tbGE.fieldByName('is_ref').AsString);

    tbItens := TADOTable.create(nil);
    tbItens.Connection := fmMain.Conexao;

    tbMov := TADOTable.create(nil);
    tbMov.Connection := fmMain.Conexao;

    uCF.calculaRRANA(tbItens, tbMov, itens, funcoes.getCodUO(cbLoja), di, df);

    Params:= TStringlist.create();
    params.Add(dateToStr(di));
    params.Add(dateToStr(df));
    params.Add(funcoes.getNomeUO(cbLoja));
    params.Add(fmMain.getNomeUsuario()) ;

    if (tbMov.IsEmpty = false) then
       fmMain.impressaoRaveQr4(tbItens, tbMov, nil, nil, 'rpRRANA', params)
    else
       msgTela('','Sem movimenta��o no per�odo.', MB_ICONERROR + MB_OK);

    tbItens.Close();
    tbMov.Close();
   end;
end;

end.
