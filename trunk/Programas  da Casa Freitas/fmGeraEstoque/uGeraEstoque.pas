unit uGeraEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, DB, ADODB,comObj, ExtCtrls,funcoes, StdCtrls,
  TFlatButtonUnit, adLabelEdit, SoftDBGrid, mxExport, RpRave, RpBase,
  RpSystem, RpDefine, RpCon, RpConDS, TFlatEditUnit, adLabelComboBox,
  ComCtrls, adLabelNumericEdit, adLabelSpinEdit, Menus, funcSql, fCtrls {, uChamaCat} ;

type
  TfmGeraEstoque = class(TForm)
    edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    cbLoja: TadLabelComboBox;
    cbPrecos: TadLabelComboBox;
    cbEstoque: TadLabelComboBox;
    Bt_Saidas: TFlatButton;
    Bt_Entradas: TFlatButton;
    Panel2: TPanel;
    spedit: TadLabelSpinEdit;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    Query2: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    FloatField1: TFloatField;
    IntegerField5: TIntegerField;
    FloatField2: TFloatField;
    StringField3: TStringField;
    FlatButton5: TFlatButton;
    cbEstDisponivel: TfsCheckBox;
    FlatButton4: TFlatButton;
    tbGE: TADOTable;
    FlatButton2: TFlatButton;
    FlatButton6: TFlatButton;
    qrTVenda: TADOQuery;
    fsCheckBox1: TfsCheckBox;
    Panel1: TPanel;
    lbNivel: TLabel;
    lbCodigo: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    VerdetalhesdaCMU1: TMenuItem;
    btBuscaFornecedor: TFlatButton;
    QrCredores: TADOQuery;
    Label2: TLabel;
    lbSoEntrada: TfsCheckBox;
    Pedidosdecompra1: TMenuItem;
    FlatButton7: TFlatButton;
    Verdetalhes1: TMenuItem;
    VerdetalhesdaCRUCbaseadonanota1: TMenuItem;
    rgTpBusca: TadLabelComboBox;
    FlatButton3: TFlatButton;
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
    function GetIniDtVen():string;
    procedure speditChange(Sender: TObject);
    procedure cbLojaChange(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure MosraFormSaldos(sender: TObject);
    procedure MosraFormRequisicoes(sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure CriarTabela(Sender:Tobject);
    procedure ListaProdutosPorFornecedor(Sender:Tobject);
    procedure rgTpBuscaClick(Sender: TObject);
    Procedure ListarItensPorFaixaCodigo();
    procedure ProgressoDaExecucao(Sender:Tobject;nItem:integer);
    procedure GeraEstoque(Sender:TObject);
    procedure cbEstoqueChange(Sender: TObject);
    procedure SoftDBGrid1CellClick(Column: TColumn);
    procedure SoftDBGrid1TitleClick(Column: TColumn);
    procedure ChamaGeraEstoque(Sender:Tobject);
    procedure CalculaVendaNoPeriodo(uo, is_ref, dtInicio, dtFim, cod, desc: string; isVendaDetalhada:boolean);
    procedure FlatButton6Click(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);
    procedure VerdetalhesdaCMU1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure listaProdutoPorPedido(Sender:Tobject);
    procedure btBuscaFornecedorClick(Sender: TObject);
    procedure consultaPedidos(Sender:Tobject; nome,  is_ref:String);
    procedure PedidosDeCompra1Click(Sender: TObject);
    procedure VerdetalhesdaCRUCbaseadonanota1Click(Sender: TObject);
    function abreFormCRUC():boolean;
    procedure FlatButton3Click(Sender: TObject);


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

uses uCadFornecedor, uMain;

{$R *.dfm}


procedure TfmGeraEstoque.ProgressoDaExecucao(Sender:Tobject;nItem:integer);
begin
   fmMain.msgStatus('Item ' + intToStr(nItem) + ' de  ' +
                    intToStr(tbGE.RecordCount) +
                    '  '+ tbGE.fieldByName('Codigo').asString + ' ' +
                    tbGE.fieldByName('descricao').asString
                   );
end;

procedure TfmGeraEstoque.ListarItensPorFaixaCodigo();
var
  ds:TDataSet;
  strDisponivel,StrEstoque, cmd:String;
begin
   if (cbEstDisponivel.Checked = true) then
      strDisponivel := '1'
   else
      strDisponivel := '0';

   strEstoque := ' dbo.Z_CF_EstoqueNaLoja (crefe.is_ref, '+ funcoes.getCodUO(cbLoja) + ', '+ strDisponivel + ')';


   cmd := ' select crefe.is_ref, crefe.ds_ref, crefe.cd_ref , '+ strEstoque +  ' as EstLoja from crefe with(NoLock)' ;

   if  lbNivel.Caption <> '0' then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+ quotedstr(lbNivel.caption) + ' and cd_vcampo  = ' + quotedstr(lbCodigo.caption);

   cmd := cmd + ' where crefe.cd_ref like ' + quotedStr( edit1.Text + '%');

   if cbLoja.ItemIndex = 0 then
      cmd := cmd + ' and ' + strEstoque + ' > 0 ';

   cmd := cmd + ' order by crefe.cd_ref ';

   ds:= funcsql.getDataSetQ(cmd, fmMain.Conexao);
   ds.first;
   while ds.Eof = false do
   begin
      tbGE.Append;
      tbGE.FieldByName('codigo').AsString := ds.fieldByName('cd_ref').asString;
      tbGE.FieldByName('descricao').AsString := ds.fieldByName('ds_ref').asString;
      tbGE.FieldByName('is_ref').AsString   := ds.fieldByName('is_ref').asString;
      tbGE.FieldByName('Estoque').AsString   := ds.fieldByName('EstLoja').asString;
      tbGE.Post;
      ds.Next;
   end;
   ds.free;
end;


procedure TfmGeraEstoque.ListaProdutosPorFornecedor(Sender: Tobject);
var
  Query:TadoQuery;
  strDisponivel,StrEstoque, cmd:String;

begin
   if cbEstDisponivel.Checked = true then
      strDisponivel := '1'
   else
      strDisponivel := '0';

   strEstoque := ' dbo.Z_CF_EstoqueNaLoja (crefe.is_ref , '+ copy(cbLoja.Items[cbLoja.itemIndex],51,08) + ' , '+ strDisponivel + ')';

   query := TadoQuery.Create(fmGeraEstoque);
   Query.Connection := fmMain.Conexao;
   Query.SQL.Clear;
   cmd := ' select crefe.is_ref, crefe.ds_ref, crefe.cd_ref , '+ strEstoque +  'from dsrfo with(NoLock)' +

                 ' inner join dscre with(NoLock) on dscre.cd_pes = dsrfo.cd_pes '+
                 ' left join crefe  with(NoLock) on dsrfo.is_ref = crefe.is_ref ';

   if  lbNivel.Caption <> '0' then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+
                   quotedstr(lbNivel.Caption) + ' and cd_vcampo  = ' + quotedstr(lbCodigo.Caption);

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


function TfmGeraEstoque.GetIniDtVen: string;
var
  aux:string;
begin
  shortdateformat := 'dd/MM/yyyy';
  if fmGeraEstoque.spedit.Value < 1 then
     spedit.Value := 1;
  AUX := (DateToStr(now - (30 * spedit.Value)));
  delete(aux,01,02);
  insert('01',aux,01);
  result := funcoes.StrToSqlDate(aux);
  shortdateformat := 'dd/MM/yy';
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
   UO_CD := fmMain.getParamBD('uocd', '');
end;

procedure TfmGeraEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   SalvaColDbgrid('fmGeraEstoque',softDbGrid1);
   funcoes.WParReg('Estoque','loja', inttoStr(cbLoja.ItemIndex));
   funcoes.WParReg('Estoque','venda', inttoStr(cbLoja.ItemIndex));
   funcoes.WParReg('Estoque','estoque', inttoStr(cbPrecos.ItemIndex));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(fmGeraEstoque.left));
   funcoes.WParReg('Estoque','FormWidth', inttoStr(fmGeraEstoque.Width));
   funcoes.WParReg('Estoque','FormTop', inttoStr(fmGeraEstoque.top));
   funcoes.WParReg('Estoque','FormHeight', inttoStr(fmGeraEstoque.Height));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(fmGeraEstoque.left));
   funcoes.WParReg('Estoque','MesDefault',FloatToStr(spedit.value)) ;
   funcoes.WParReg('Estoque','TipoDeGeracao',intToStr(rgTpBusca.ItemIndex)) ;
   deleteFile(funcoes.TempDir()+'Log_'+Application.Title+'.txt');
   funcoes.WParReg('Estoque','EhEstDisponivel', BoolToStr(cbEstDisponivel.Checked,false)) ;

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
   SCREEN.Cursor := CRdEFAULT;
end;
procedure TfmGeraEstoque.Bt_EntradasClick(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   if (tbGE.IsEmpty = false) then
      fmMain.obterDetalhesEntrada(tbGE.fieldByName('is_ref').asString );
   screen.Cursor := crdefault;
end;

procedure TfmGeraEstoque.Bt_SaidasClick(Sender: TObject);
begin
   screen.Cursor := crHourGlass;
   if (tbGE.IsEmpty = false) then
      fmMain.obterDetalhesSaida(tbGE.fieldByName('is_ref').asString, funcoes.getCodUO(cbLoja) );
   screen.Cursor := crdefault;
end;

procedure TfmGeraEstoque.speditChange(Sender: TObject);
begin
  if spedit.Value < 1 then
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

   if cbEstDisponivel.Checked = true then
      EhDisponivel := '1'
   else
      EhDisponivel := '0';

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
   if (cbEstDisponivel.Checked = true) then
      disponivel := '1'
   else
      disponivel := '0';

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
  cmd,ntbGE:String;
  i:integer;
begin
   ntbGE := trim('#' + funcoes.GetNomeDoMicro() + funcoes.SohNumeros( DateTimeToStr(now)) );
   cmd := 'Create table ' + ntbGE + ' ( Codigo varchar(08), Descricao varchar(50), [Data Ultima Ent] smalldateTime, [Quant Ultima Ent] integer, [Total Venda] integer, Estoque integer, EstoqueCD integer, PV money, [is_ref] integer ) ';
   funcSQl.GetValorWell('E',cmd,'@@error', fmMain.Conexao);

   tbGE.tableName := ntbGE;
   tbGE.Open;

   softdbgrid1.Columns[0].Width := 60;
   softdbgrid1.Columns[1].Width := 290;
   softdbgrid1.Columns[2].Width :=  82;
   softdbgrid1.Columns[3].Width :=  88;
   softdbgrid1.Columns[4].Width :=  65;
   softdbgrid1.Columns[5].Width :=  65;
   softdbgrid1.Columns[6].Width :=  65;
   softdbgrid1.Columns[7].Width :=  80;
   softdbgrid1.Columns[8].Visible := false;

   for i:=0 to SoftDBGrid1.Columns.Count -1 do
      SoftDBGrid1.Columns[i].Title.Font.Style :=[fsbold];

end;


procedure TfmGeraEstoque.rgTpBuscaClick(Sender: TObject);
begin
    Case rgTpBusca.ItemIndex of
       0: edit1.LabelDefs.Caption := 'Faixa de c�digo';
       1: edit1.LabelDefs.Caption := 'C�digo do fornecedor';
       2: edit1.LabelDefs.Caption := 'N�mero do pedido';
    end;
    if rgTpBusca.ItemIndex  = 1 then
       btBuscaFornecedor.Visible := true
    else
       btBuscaFornecedor.Visible := false;

end;

procedure TfmGeraEstoque.GeraEstoque(Sender: TObject);
var
   aux :String;
   itens : TStrings;
   nItens:integer;
begin
   softdbgrid1.Visible := false;
   screen.cursor := crHourGlass;
   fmMain.msgStatus('Obtendo lista de itens....');

   nItens:= 0;
   while tbGE.IsEmpty = false do
     tbGE.delete;


   // procedure para Obter os items
   case rgTpBusca.ItemIndex of
      0:ListarItensPorFaixaCodigo();
      1:ListaProdutosPorFornecedor(Sender);
      2:listaProdutoPorPedido(Sender);
   end;
   itens := TStringList.Create();



   tbGE.First;
   while tbGE.Eof = false do
   begin
      aux := '';
      if (cbLoja.itemindex = 0) then
         aux:= ' Exec dbo.zcf_GeraEstoqueCD '
      else
         aux:= ' Exec dbo.zcf_GeraEstoqueLoja ' ;

      aux := aux +
          '@is_ref = '+ tbGE.fieldByName('is_ref').AsString   + ', ' +
          '@tpEst= '+ inttostr(cbEstoque.ItemIndex) + ', ' +
          '@Pco = ' + funcoes.getCodPc(cbPrecos) +' , '+
          '@DIDefault =' + GetIniDtVen() +' , '+
          '@UoCD =' + copy(cbLoja.Items[0],51,08) +' , ';

      if cbEstDisponivel.Checked = true then
         aux := aux + '@EhDisponivel= 1'
      else
         aux := aux + '@EhDisponivel= 0';

      if (cbLoja.ItemIndex > 0) then
         aux := aux +' , @uo = ' + copy(cbLoja.Items[cbLoja.itemIndex],51,08);

      ProgressoDaExecucao(Sender,nItens);
      itens := funcSQl.GetValoresSQL(itens,aux,fmMain.Conexao);

      if itens.Count > 0 then
      begin
         inc(nItens);
         ProgressoDaExecucao(Sender,nItens);
         tbGE.Edit;
         tbGE.FieldByName('Data Ultima Ent').AsString := itens[1];
         tbGE.FieldByName('Quant Ultima Ent').AsString := itens[2];
         tbGE.FieldByName('Total Venda').AsString := itens[3];
         tbGE.FieldByName('PV').AsString := itens[6];
         tbGE.FieldByName('Estoque').AsString := itens[4];
         tbGE.FieldByName('EstoqueCD').AsString := itens[5];
      end;
      tbGE.Next;
   end;

   // tirar da tabela os itens que n�o t�m entrada na filial
   if lbSoEntrada.Checked = true then
   begin
      tbGE.First;
      while tbGE.Eof = false do
      begin
         if tbGE.FieldByName('Quant Ultima Ent').AsInteger  = 0 then
            tbGE.Delete()
         else
            tbGE.Next;
      end;
 end;

 softdbgrid1.Visible := true;
end;


procedure TfmGeraEstoque.ChamaGeraEstoque(Sender: Tobject);
begin
   screen.Cursor := crhourglass;
   GeraEstoque(Sender);
   screen.Cursor := crDefault;
end;

procedure TfmGeraEstoque.cbEstoqueChange(Sender: TObject);
begin
   if cbEstoque.ItemIndex = 1 then
     cbEstDisponivel.Visible := false
   else
     cbEstDisponivel.Visible := true;
end;

procedure TfmGeraEstoque.SoftDBGrid1CellClick(Column: TColumn);
begin
   if (tbGE.IsEmpty = false) then
      fmMain.msgStatus(tbGE.fieldByName('is_ref').asString);
end;

procedure TfmGeraEstoque.SoftDBGrid1TitleClick(Column: TColumn);
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
begin
    if (tbGE.IsEmpty = false) then

end;

procedure TfmGeraEstoque.CalculaVendaNoPeriodo(uo, is_ref, dtInicio,dtFim,cod,desc: string; isVendaDetalhada:boolean);
begin
   if ( fmGeraEstoque.qrTVenda.Active = true ) then

   fmGeraEstoque.qrTVenda.Close();
   fmGeraEstoque.qrTVenda.SQL.Clear();


   if ( isVendaDetalhada = false) then
   begin
      qrTVenda.SQL.add(' select dbo.Z_CF_funObterVendaPorPeriodo( '+
                       uo       +' , '+
                       is_ref   +' , '+
                       funcoes.StrToSqlDate(dtInicio)   +', '+
                       funcoes.StrToSqlDate(dtFim)  +', '+
                       fmGeraEstoque.GetIniDtVen() +' , ' + UO_CD
                       +') as Quantidade'
                     );
   end
   else
   begin
      qrTVenda.SQL.add( 'Select UO.ds_uo as Loja, sum(qt_mov) as Quantidade from zcf_dsdsi V with(nolock) '+
                        'inner join zcf_tbuo UO (nolock) on V.is_estoque = UO.Is_uo '+
                        'where ' +
                        'V.dt_mov between '+ funcoes.StrToSqlDate(dtInicio) +' and ' + funcoes.StrToSqlDate(dtFim) +' '+
                        'and V.is_ref =  ' + is_ref + 'group by UO.ds_uo'
                      );
   end;
   qrTVenda.Open;
end;


procedure TfmGeraEstoque.FlatButton7Click(Sender: TObject);
var
   cat, vCategoria:String;
begin
 //  uChamaCat.mostraCategorias(nil, fmGeraEstoque.ADOConnection1, cat, vCategoria);
end;

procedure TfmGeraEstoque.PedidosDeCompra1Click(Sender: TObject);
begin
   consultaPedidos(nil, tbGE.fieldByname('codigo').asString +' '+ tbGE.fieldByname('descricao').asString, tbGE.fieldByname('is_ref').asString);
end;

function TfmGeraEstoque.abreFormCRUC: boolean;
begin
{   if (tbGE.IsEmpty = false) and ( form5 = nil ) then
   begin
      Application.CreateForm(TForm5, Form5);
      FORM5.SHOW;
      result := true;
   end
   else
      result := false;
}
end;

procedure TfmGeraEstoque.VerdetalhesdaCMU1Click(Sender: TObject);
begin
{   if (abreFormCRUC = true) then
     form5.DetalhesCRUC(nil, tbGE.fieldByName('is_ref').asString,'p2','p3') ;
}
end;

procedure TfmGeraEstoque.VerdetalhesdaCRUCbaseadoNaNota1Click(Sender: TObject);
begin
   if (abreFormCRUC = true) then
   begin
{      form5.DetalhesCRUCBaSeadoNaNota(tbGE.fieldByName('is_ref').asString,'p2','p3') ;
}      VerdetalhesdaCRUCbaseadonanota1.Enabled := false;
   end;

end;



procedure TfmGeraEstoque.FormActivate(Sender: TObject);
begin
   edit1.SetFocus;
   rgTpBusca.ItemIndex := 0 ;
end;

procedure TfmGeraEstoque.FlatButton1Click(Sender: TObject);
var
  erro:String;
begin
   if length(edit1.text) < 3 then
      erro := 'Informe ao menos o c�digo com 3 caracteres' + #13;

   if cbPrecos.ItemIndex < 0 then
      erro := erro +  'Escolha um tipo de pre�o para exibir' + #13;

   if cbLoja.ItemIndex < 0 then
      erro := erro +  'Escolha uma loja para gerar o relat�rio' + #13;

   if (rgTpBusca.ItemIndex < 0 )then
      erro := erro +  'Escolha um tipo  de relat�rio' + #13;

   if (erro =  '') then
   begin
      chamaGeraEstoque(Sender);

      SoftDBGrid1.Columns[ tbGE.FieldByName('pv').Index ].Title.Caption := copy(cbPrecos.Items[cbPrecos.itemindex],01,20);
   end
   else
      funcoes.msgTela('','Erro:'+#13+ erro, MB_ICONERROR);
end;


procedure TfmGeraEstoque.listaProdutoPorPedido(Sender: Tobject);
var
  Query:TADoQuery;
  cmd :string;
begin
   query := TADOQuery.Create(nil);
   cmd :=  ' select crefe.is_ref, crefe.cd_ref, crefe.ds_ref ' +
           ' from crefe inner join dsipe  on crefe.is_ref = dsipe.is_ref ';

   if  lbNivel.Caption <> '0' then
      cmd := cmd + ' inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+ quotedstr(lbNivel.caption) + ' and cd_vcampo  = ' + quotedstr(lbCodigo.caption);

      cmd := cmd + ' where    dsipe.is_pedf = '+ quotedStr(edit1.text);
   funcsql.AbrirQuery(query,fmMain.Conexao, cmd);
   query.first;
   while query.Eof = false do
   begin
      tbGE.Append;
      tbGE.FieldByName('is_ref').AsString := query.fieldByName('is_ref').asString;
      tbGE.FieldByName('codigo').AsString := query.fieldByName('cd_ref').asString;
      tbGE.FieldByName('descricao').AsString := query.fieldByName('ds_ref').asString;
      tbGE.Post;
      query.Next;
   end;
   query.Destroy();
end;


procedure TfmGeraEstoque.btBuscaFornecedorClick(Sender: TObject);
begin
   if QrCredores.IsEmpty = true then
   begin
      qrCredores.SQL.Clear;
      qrCredores.sql.Add('Select cd_cred as codigo, nm_razsoc as fornecedor from dscre with(nolock) where cd_pes in (select distinct cd_pes from crefe wit(nolock)) order by nm_razsoc');
      qrCredores.Open;
   end;
//  Application.CreateForm(TfmForn, fmForn);
//  fmForn.ShowModal;
end;

procedure TfmGeraEstoque.consultaPedidos(Sender: Tobject; nome, is_ref:String);
begin
{   if form6 = nil then
   begin
      application.CreateForm(TForm6, form6);
   end;
   form6.Show;
   form6.ListaPedidosProduto( nil, nome, is_ref );
}
end;


procedure TfmGeraEstoque.FlatButton3Click(Sender: TObject);
begin
   if ( tbGE.IsEmpty = false) then
//      funcsql.exportatbGE(tbGE);
end;

end.


