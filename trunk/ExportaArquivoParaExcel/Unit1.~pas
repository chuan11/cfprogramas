unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, DB, ADODB,comObj, ExtCtrls,funcoes, StdCtrls,
  TFlatButtonUnit, adLabelEdit, SoftDBGrid, mxExport, RpRave, RpBase,
  RpSystem, RpDefine, RpCon, RpConDS, TFlatEditUnit, adLabelComboBox,
  ComCtrls, adLabelNumericEdit, adLabelSpinEdit, Menus, funcSql, fCtrls, uChamaCat ;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    RvProject1: TRvProject;
    cbLoja: TadLabelComboBox;
    cb1: TadLabelComboBox;
    cb3: TadLabelComboBox;
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
    CheckBox3: TfsCheckBox;
    FlatButton4: TFlatButton;
    Table: TADOTable;
    stBar: TStatusBar;
    FlatButton2: TFlatButton;
    FlatButton6: TFlatButton;
    qrEnt: TADOQuery;
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
    rgTpBusca: TadLabelComboBox;
    QrCredores: TADOQuery;
    Label2: TLabel;
    lbSoEntrada: TfsCheckBox;
    Pedidosdecompra1: TMenuItem;
    FlatButton7: TFlatButton;
    Verdetalhes1: TMenuItem;
    VerdetalhesdaCRUCbaseadonanota1: TMenuItem;
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
    Procedure ListarItensPorFaixaCodigo(Sender:Tobject);
    procedure ProgressoDaExecucao(Sender:Tobject;nItem:integer);
    procedure GeraEstoque(Sender:TObject);
    procedure cb3Change(Sender: TObject);
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
    procedure msgRodape(Str1, str2:String);
    procedure consultaPedidos(Sender:Tobject; nome,  is_ref:String);
    procedure PedidosDeCompra1Click(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure VerdetalhesdaCRUCbaseadonanota1Click(Sender: TObject);
    function abreFormCRUC():boolean;
    procedure FlatButton3Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  UO_CD:string;
  IsOrderDesc:byte;
implementation
uses unit2, Unit4,unit3, unMapa, uEentSai, UNIT5, Uforn, unit7, unit6;

{$R *.dfm}


procedure TForm1.AppException(Sender: TObject; E: Exception);
begin
   screen.Cursor := crDefault;
   msgTela('', e.Message , MB_ICONERROR + MB_OK);
   funcoes.gravaLogErros( e.ClassName + ' ' + e.Message  );

   if (e.ClassName = 'EOleException') or (e.ClassName = 'EDatabaseError' )then
      if msgTela('',' Erro de comunicação com o servidor, tento reconectar ?', MB_YESNO + MB_ICONQUESTION) = mrYes then
         ADOConnection1.Open();
end;

procedure TForm1.ProgressoDaExecucao(Sender:Tobject;nItem:integer);
begin
   stBar.Panels[0].Text := 'Item ' + intToStr(nItem) + ' de  ' +intToStr(table.RecordCount);
   stBar.Panels[1].Text := 'Calculando Produto : '+ table.fieldByName('Codigo').asString + ' ' +table.fieldByName('descricao').asString;
   form1.Refresh;
end;



procedure TForm1.ListarItensPorFaixaCodigo(Sender: Tobject);
var
  Query:TadoQuery;
  strDisponivel,StrEstoque, cmd:String;
begin
   if CheckBox3.Checked = true then
      strDisponivel := '1'
   else
      strDisponivel := '0';

   strEstoque := ' dbo.Z_CF_EstoqueNaLoja (crefe.is_ref , '+ copy(cbLoja.Items[cbLoja.itemIndex],51,08) + ' , '+ strDisponivel + ')';


   query := TadoQuery.Create(form1);
   Query.Connection := ADOConnection1;
   Query.SQL.Clear;
   cmd := ' select crefe.is_ref, crefe.ds_ref, crefe.cd_ref , '+ strEstoque +  ' as EstLoja from crefe with(NoLock)' ;

   if  lbNivel.Caption <> '0' then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+ quotedstr(lbNivel.caption) + ' and cd_vcampo  = ' + quotedstr(lbCodigo.caption);

   cmd := cmd + ' where crefe.cd_ref like ' + quotedStr( edit1.Text + '%');

   if cb3.ItemIndex = 0 then
      cmd := cmd + ' and ' + strEstoque + ' > 0 ';

   cmd := cmd + ' order by crefe.cd_ref ';

   Query.SQL.Add(cmd);
   Query.Open;

   query.first;
   while query.Eof = false do
   begin
      table.Append;
      table.FieldByName('codigo').AsString := query.fieldByName('cd_ref').asString;
      table.FieldByName('descricao').AsString := query.fieldByName('ds_ref').asString;
      table.FieldByName('is_ref').AsString   := query.fieldByName('is_ref').asString;
      table.FieldByName('Estoque').AsString   := query.fieldByName('EstLoja').asString;
      table.Post;
      query.Next;
   end;
   query.First;
end;


procedure TForm1.ListaProdutosPorFornecedor(Sender: Tobject);
var
  Query:TadoQuery;
  strDisponivel,StrEstoque, cmd:String;

begin
   if CheckBox3.Checked = true then
      strDisponivel := '1'
   else
      strDisponivel := '0';

   strEstoque := ' dbo.Z_CF_EstoqueNaLoja (crefe.is_ref , '+ copy(cbLoja.Items[cbLoja.itemIndex],51,08) + ' , '+ strDisponivel + ')';

   query := TadoQuery.Create(form1);
   Query.Connection := ADOConnection1;
   Query.SQL.Clear;
   cmd := ' select crefe.is_ref, crefe.ds_ref, crefe.cd_ref , '+ strEstoque +  'from dsrfo with(NoLock)' +

                 ' inner join dscre with(NoLock) on dscre.cd_pes = dsrfo.cd_pes '+
                 ' left join crefe  with(NoLock) on dsrfo.is_ref = crefe.is_ref ';

   if  lbNivel.Caption <> '0' then
      cmd := cmd + 'inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave and cd_campo = '+
                   quotedstr(lbNivel.Caption) + ' and cd_vcampo  = ' + quotedstr(lbCodigo.Caption);

   cmd := cmd +' where dscre.cd_cred = ' + edit1.Text ;

   if cb3.ItemIndex = 0 then
      cmd := cmd + ' and ' + strEstoque + ' > 0 ';

   cmd := cmd + ' order by crefe.cd_ref ';

   Query.SQL.Add(cmd);
   Query.Open;

   query.first;
   while query.Eof = false do
   begin
      table.Append;
      table.FieldByName('codigo').AsString := query.fieldByName('cd_ref').asString;
      table.FieldByName('descricao').AsString := query.fieldByName('ds_ref').asString;
      table.FieldByName('is_ref').AsString := query.fieldByName('is_ref').asString;

      table.Post;
      query.Next;
   end;
   query.First;
end;


function TForm1.GetIniDtVen: string;
var
  aux:string;
begin
  shortdateformat := 'dd/MM/yyyy';
  if form1.spedit.Value < 1 then
     spedit.Value := 1;
  AUX := (DateToStr(now - (30 * spedit.Value)));
  delete(aux,01,02);
  insert('01',aux,01);
  result := funcoes.StrToSqlDate(aux);
  shortdateformat := 'dd/MM/yy';
end;

procedure TForm1.SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
    funcoes.WParReg('PosEstoque','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
   if not(table.IsEmpty) then
   begin
      rvproject1.SetParam('loja', copy(cbLoja.Items[cbLoja.itemindex],01,30)) ;
      rvproject1.SetParam('TpVenda', copy(cb1.Items[cb1.itemindex],01,30)) ;
      rvproject1.SetParam('TPestoque', cb3.Items[cb3.itemindex]) ;
      rvproject1.SetParam('Ordenacao', '' ) ;
      rvproject1.SetParam('codigo', edit1.text) ;

      if checkBox2.Checked = true then
         rvproject1.SetParam('estoqueCd', 'Estoque CD') ;

      rvproject1.ExecuteReport('Report2');
   end;
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case key of
      vk_return : FlatButton1Click(Sender);
      VK_F6:Bt_EntradasClick(Sender);
      VK_F7:Bt_SaidasClick(Sender);
//      VK_F8:FlatButton3Click(Sender);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Application.OnException := AppException;
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;


   cb1.items := funcsQL.getListaPrecos( ADOConnection1, true, true, true, '13' ); // getListaPrecos (sender);
   cbLoja.items := funcsQL.GetNomeLojas(ADOConnection1, false, false,'','' );
   form1.Top := 50;
   form1.left := 200;

   if funcoes.RParReg('Estoque','loja') <> '' then
      cbLoja.itemindex := StrToInt(funcoes.RParReg('Estoque','loja'));

   if funcoes.RParReg('Estoque','venda') <> '' then
      cb1.itemindex := StrToInt(funcoes.RParReg('Estoque','venda'));

   if funcoes.RParReg('Estoque','estoque') <> '' then
      cb3.itemindex := StrToInt(funcoes.RParReg('Estoque','estoque'));

   if funcoes.RParReg('Estoque','MesDefault') <> '' then
     spedit.value := strToFloat( funcoes.RParReg('Estoque','MesDefault') );

   if funcoes.RParReg('Estoque','TipoDeGeracao') <> '' then
      rgTpBusca.ItemIndex :=   funcoes.RParRegInt('Estoque','TipoDeGeracao') ;
   checkBox3.Checked := StrToBool( funcoes.RParReg('Estoque','EhEstDisponivel') );

   cbLojaChange(Sender);
   rvProject1.ProjectFile := 'PosicaoEstoquePorLoja.rav';

   cb3Change(Sender);
   Form1.Caption := Form1.Caption  +' -  ' +ADOConnection1.DefaultDatabase;
   Form1.CriarTabela(Sender);
   rgTpBuscaClick(Sender);
   UO_CD := funcSQL.GetValorWell( 'O',' select is_uo from tbuo where tp_estoque = 1','is_uo', ADOConnection1 );


// limpar o arquivo de log
   deleteFIle( ExtractFilePath(paramStr(0)) +'logs\' + ExtractFilename(ParamStr(0))  + '_log.txt');
{   }
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.renomearArquivoUpgrade('UpgradeNovo.exe', 'Upgrade.exe');

   SalvaColDbgrid('Form1',softDbGrid1);
   funcoes.WParReg('Estoque','loja', inttoStr(cbLoja.ItemIndex));
   funcoes.WParReg('Estoque','venda', inttoStr(cb1.ItemIndex));
   funcoes.WParReg('Estoque','estoque', inttoStr(cb3.ItemIndex));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(Form1.left));
   funcoes.WParReg('Estoque','FormWidth', inttoStr(Form1.Width));
   funcoes.WParReg('Estoque','FormTop', inttoStr(Form1.top));
   funcoes.WParReg('Estoque','FormHeight', inttoStr(Form1.Height));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(Form1.left));
   funcoes.WParReg('Estoque','MesDefault',FloatToStr(spedit.value)) ;
   funcoes.WParReg('Estoque','TipoDeGeracao',intToStr(rgTpBusca.ItemIndex)) ;
   deleteFile(funcoes.TempDir()+'Log_'+Application.Title+'.txt');
   funcoes.WParReg('Estoque','EhEstDisponivel', BoolToStr(checkBox3.Checked,false)) ;
end;

procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
begin
   SCREEN.Cursor := CRHOURGLASS;
   funcoes.gravaLog(CommandText);
end;

procedure TForm1.ADOConnection1ExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   SCREEN.Cursor := CRdEFAULT;
end;
procedure TForm1.Bt_EntradasClick(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   if table.IsEmpty = false then
   begin
      Application.CreateForm(TForm2, Form2);
      form2.show;
      form2.ConsultaDetalhesEntrada(sender, table.FieldByName('Is_ref').AsString, table.FieldByName('codigo').AsString, table.FieldByName('descricao').AsString );
      Bt_Entradas.Enabled := false;
   end;
   screen.Cursor := crdefault;
end;

procedure TForm1.Bt_SaidasClick(Sender: TObject);
begin
   screen.Cursor := crHourGlass;
   if table.IsEmpty = false then
   begin
      Application.CreateForm(TForm4, Form4);
      form4.show;
      Bt_Saidas.Enabled := false;

      form4.FlatButton1Click(Sender);
   end;
   screen.Cursor := crdefault;
end;

procedure TForm1.speditChange(Sender: TObject);
begin
  if spedit.Value < 1 then
     spedit.Value := 1
end;

procedure TForm1.cbLojaChange(Sender: TObject);
begin
   if cbLoja.ItemIndex > 0 then
      checkBox2.Checked := true
   else
      checkBox2.Checked := false;
end;

procedure TForm1.MosraFormSaldos(sender: TObject);
var
  EhDisponivel,programa:string;
begin
   screen.Cursor := crhourGlass;

   if checkBox3.Checked = true then
      EhDisponivel := '1'
   else
      EhDisponivel := '0';

   programa := ExtractFilePath(ParamStr(0)) + 'ResumoEstoque.exe "'+ 'ResumoDoEstoque" '+table.FieldByName('codigo').asString+' "'+table.FieldByName('descricao').asString+'" '+table.FieldByName('is_ref').asString +' '+ EhDisponivel;

   PostMessage(FindWindow(nil, 'ResumoDoEstoque'), WM_CLOSE,0,0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
end;


procedure TForm1.MosraFormRequisicoes(sender: TObject);
var
   programa:string;
begin
   screen.Cursor := crhourGlass;

   programa := '"' + ExtractFilePath(ParamStr(0)) + 'RequisicaoPorProduto.exe" -c ';

   if cbLoja.ItemIndex = 0 then
      programa := programa + ' 0 ' + UO_CD
   else
      programa := programa + funcoes.SohNumeros(copy(cbLoja.Items[cbLoja.ItemIndex],40,50) ) +' '+ UO_CD ;

   if table.FieldByName('Data Ultima Ent').asString <> '' then
      programa := programa +' '+ table.FieldByName('Data Ultima Ent').asString
   else
      programa := programa +' '+ DateToStr(now - (30 * spEdit.Value ) );

   programa := programa +' '+ DateToStr(now) + ' '+ table.FieldByname('is_ref').AsString;

   PostMessage(FindWindow(nil, 'ConsultaRequisicao'), WM_CLOSE,0,0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
end;

procedure TForm1.FlatButton5Click(Sender: TObject);
begin
  if not(table.IsEmpty) then
     MosraFormSaldos(sender);
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
  if not(table.IsEmpty) then
     MosraFormRequisicoes(Sender);
end;

procedure TForm1.CriarTabela(Sender: Tobject);
var
  cmd,nTable:String;
  i:integer;
begin
   nTable := trim('#' + funcoes.GetNomeDoMicro() + funcoes.SohNumeros( DateTimeToStr(now)) );
   cmd := 'Create Table ' + nTable + ' ( Codigo varchar(08), Descricao varchar(50), [Data Ultima Ent] smalldateTime, [Quant Ultima Ent] integer, [Total Venda] integer, Estoque integer, EstoqueCD integer, PV money, [is_ref] integer ) ';
   funcSQl.GetValorWell('E',cmd,'@@error', form1.ADOConnection1);

   table.TableName := nTable;
   table.Open;

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


procedure TForm1.rgTpBuscaClick(Sender: TObject);
begin
    Case rgTpBusca.ItemIndex of
       0: edit1.LabelDefs.Caption := 'Faixa de código';
       1: edit1.LabelDefs.Caption := 'Código do fornecedor';
       2: edit1.LabelDefs.Caption := 'Número do pedido';
    end;
    if rgTpBusca.ItemIndex  = 1 then
       btBuscaFornecedor.Visible := true
    else
       btBuscaFornecedor.Visible := false;

end;

procedure TForm1.GeraEstoque(Sender: TObject);
var
   aux :String;
   itens : TStrings;
   nItens:integer;
begin
   softdbgrid1.Visible := false;
   screen.cursor := crHourGlass;
   msgRodape('','Obtendo lista de itens....');

   nItens:= 0;
   while table.IsEmpty = false do
     table.delete;


   // procedure para Obter os items
   case rgTpBusca.ItemIndex of
      0:ListarItensPorFaixaCodigo(sender);
      1:ListaProdutosPorFornecedor(Sender);
      2:listaProdutoPorPedido(Sender);
   end;
   itens := TStringList.Create();



   table.First;
   while table.Eof = false do
   begin
      aux := '';
      if (cbLoja.itemindex = 0) then
         aux:= ' Exec dbo.zcf_GeraEstoqueCD '
      else
         aux:= ' Exec dbo.zcf_GeraEstoqueLoja ' ;

      aux := aux +
          '@is_ref = '+ table.fieldByName('is_ref').AsString   + ', ' +
          '@tpEst= '+ inttostr(cb3.ItemIndex) + ', ' +
          '@Pco = ' + copy( cb1.Items[cb1.ItemIndex],51,08) +' , '+
          '@DIDefault =' + GetIniDtVen() +' , '+
          '@UoCD =' + copy(cbLoja.Items[0],51,08) +' , ';

      if checkBox3.Checked = true then
         aux := aux + '@EhDisponivel= 1'
      else
         aux := aux + '@EhDisponivel= 0';

      if (cbLoja.ItemIndex > 0) then
         aux := aux +' , @uo = ' + copy(cbLoja.Items[cbLoja.itemIndex],51,08);

      ProgressoDaExecucao(Sender,nItens);
      itens := funcSQl.GetValoresSQL(itens,aux,ADOConnection1);

      if itens.Count > 0 then
      begin
         inc(nItens);
         ProgressoDaExecucao(Sender,nItens);
         table.Edit;
         table.FieldByName('Data Ultima Ent').AsString := itens[1];
         table.FieldByName('Quant Ultima Ent').AsString := itens[2];
         table.FieldByName('Total Venda').AsString := itens[3];
         table.FieldByName('PV').AsString := itens[6];
         table.FieldByName('Estoque').AsString := itens[4];
         table.FieldByName('EstoqueCD').AsString := itens[5];
      end;
      table.Next;
   end;

   // tirar da tabela os itens que não têm entrada na filial
   if lbSoEntrada.Checked = true then
   begin
      table.First;
      while table.Eof = false do
      begin
         if table.FieldByName('Quant Ultima Ent').AsInteger  = 0 then
            table.Delete()
         else
            table.Next;
      end;
 end;

   stbar.panels[0].text:='';
   stbar.panels[01].text:='';
   softdbgrid1.Visible := true;
   aux := '';
end;


procedure TForm1.ChamaGeraEstoque(Sender: Tobject);
begin
   screen.Cursor := crhourglass;
   GeraEstoque(Sender);
   screen.Cursor := crDefault;
end;



procedure TForm1.cb3Change(Sender: TObject);
begin
   if cb3.ItemIndex = 1 then
     CheckBox3.Visible := false
   else
     CheckBox3.Visible := true;
end;

procedure TForm1.SoftDBGrid1CellClick(Column: TColumn);
begin
   if table.IsEmpty = false then
      stBar.Panels[0].Text := table.fieldByName('is_ref').asString;
end;

procedure TForm1.SoftDBGrid1TitleClick(Column: TColumn);
begin
   if IsOrderDesc = 0 then
   begin
      table.Sort := '['+column.FieldName+']';
      IsOrderDesc := 1;
   end
   else
   begin
      table.Sort := '['+column.FieldName+'] DESC';
      IsOrderDesc := 0;
   end;
end;


procedure TForm1.FlatButton6Click(Sender: TObject);
begin
    if table.IsEmpty = false then
    begin
       Application.CreateForm(TfmEntSai, fmEntSai);
       fmEntSai.lbDesc.caption := table.fieldByName('codigo').asString +'  '+copy(table.fieldByName('descricao').asString,01,30);
       fmEntSai.lbis_ref.Caption := table.fieldByName('is_ref').asString;
       fmEntSai.Show;
       fmEntSai.ListarEntrada(nil);
    end;
end;

procedure TForm1.CalculaVendaNoPeriodo(uo, is_ref, dtInicio,dtFim,cod,desc: string; isVendaDetalhada:boolean);
begin
   if ( form1.qrTVenda.Active = true ) then

   form1.qrTVenda.Close();
   form1.qrTVenda.SQL.Clear();


   if ( isVendaDetalhada = false) then
   begin
      qrTVenda.SQL.add(' select dbo.Z_CF_funObterVendaPorPeriodo( '+
                       uo       +' , '+
                       is_ref   +' , '+
                       funcoes.StrToSqlDate(dtInicio)   +', '+
                       funcoes.StrToSqlDate(dtFim)  +', '+
                       form1.GetIniDtVen() +' , ' + UO_CD
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


procedure TForm1.FlatButton7Click(Sender: TObject);
var
   cat,vCategoria:String;
begin
   uChamaCat.mostraCategorias(nil, form1.ADOConnection1, cat, vCategoria);
end;

procedure TForm1.PedidosDeCompra1Click(Sender: TObject);
begin
   consultaPedidos(nil, table.fieldByname('codigo').asString +' '+ table.fieldByname('descricao').asString, table.fieldByname('is_ref').asString);
end;

function TForm1.abreFormCRUC: boolean;
begin
   if (table.IsEmpty = false) and ( form5 = nil ) then
   begin
      Application.CreateForm(TForm5, Form5);
      FORM5.SHOW;
      result := true;
   end
   else
      result := false;
end;

procedure TForm1.VerdetalhesdaCMU1Click(Sender: TObject);
begin
   if (abreFormCRUC = true) then
     form5.DetalhesCRUC(nil, table.fieldByName('is_ref').asString,'p2','p3') ;
end;

procedure TForm1.VerdetalhesdaCRUCbaseadoNaNota1Click(Sender: TObject);
begin
   if (abreFormCRUC = true) then
   begin
      form5.DetalhesCRUCBaSeadoNaNota(table.fieldByName('is_ref').asString,'p2','p3') ;
      VerdetalhesdaCRUCbaseadonanota1.Enabled := false;
   end;
end;



procedure TForm1.FormActivate(Sender: TObject);
begin
   form1.Left:= screen.Width - (form1.Width-1);
   form1.Top := 10;
   edit1.SetFocus;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
  erro:String;
begin
   if length(edit1.text) < 3 then
      erro := 'Informe ao menos o código com 3 caracteres' + #13;

   if cb1.ItemIndex < 0 then
      erro := erro +  'Escolha um tipo de preço para exibir' + #13;

   if cbLoja.ItemIndex < 0 then
      erro := erro +  'Escolha uma loja para gerar o relatório' + #13;

   if (rgTpBusca.ItemIndex < 0 )then
      erro := erro +  'Escolha um tipo  de relatório' + #13;

   if (erro =  '') then
   begin
      ChamaGeraEstoque(Sender);

      SoftDBGrid1.Columns[ table.FieldByName('pv').Index ].Title.Caption := copy(cb1.Items[cb1.itemindex],01,20);
   end
   else
      msgTEla('','Erro:'+#13+ erro, MB_ICONERROR);
end;


procedure TForm1.listaProdutoPorPedido(Sender: Tobject);
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
   funcsql.AbrirQuery(query,form1.ADOConnection1, cmd);
   query.first;
   while query.Eof = false do
   begin
      table.Append;
      table.FieldByName('is_ref').AsString := query.fieldByName('is_ref').asString;
      table.FieldByName('codigo').AsString := query.fieldByName('cd_ref').asString;
      table.FieldByName('descricao').AsString := query.fieldByName('ds_ref').asString;
      table.Post;
      query.Next;
   end;
   query.Destroy();
end;


procedure TForm1.btBuscaFornecedorClick(Sender: TObject);
begin
   if QrCredores.IsEmpty = true then
   begin
      qrCredores.SQL.Clear;
      qrCredores.sql.Add('Select cd_cred as codigo, nm_razsoc as fornecedor from dscre with(nolock) where cd_pes in (select distinct cd_pes from crefe wit(nolock)) order by nm_razsoc');
      qrCredores.Open;
   end;
  Application.CreateForm(TfmForn, fmForn);
  fmForn.ShowModal;
end;

procedure TForm1.msgRodape(Str1,str2: String);
begin
  form1.stBar.Panels[0].Text:= str1;
  form1.stBar.Panels[1].text:= str2;
  form1.stBar.Refresh();
end;

procedure TForm1.consultaPedidos(Sender: Tobject; nome, is_ref:String);
begin
   if form6 = nil then
   begin
      application.CreateForm(TForm6, form6);
   end;
   form6.Show;
   form6.ListaPedidosProduto( nil, nome, is_ref );
end;


procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   if ( table.IsEmpty = false) then
      funcsql.exportaTable(Table);
end;

end.



