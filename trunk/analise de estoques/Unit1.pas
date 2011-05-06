unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, fCtrls, DB, ADODB,
  TFlatButtonUnit, adLabelComboBox, Buttons, adLabelEdit, Grids, DBGrids,
  SoftDBGrid,
  funcoes,funcSQL, mxExport, adLabelListBox

  ;

type
  TForm1 = class(TForm)
    cbPreco01: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    pnForn: TPanel;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    Conexao: TADOConnection;
    qrCredores: TADOQuery;
    cbPreco02: TadLabelComboBox;
    sb: TStatusBar;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    pnCodigo: TPanel;
    rg1: TRadioGroup;
    edit1: TadLabelEdit;
    Panel1: TPanel;
    lbNivel: TLabel;
    lbCodigo: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    btGerar: TFlatButton;
    fsCheckBox1: TfsCheckBox;
    tbItens: TADOTable;
    Panel2: TPanel;
    btImprime: TFlatButton;
    FlatButton3: TFlatButton;
    export1: TmxDataSetExport;
    lbForn: TadLabelListBox;
    fsSeparPorLoja: TfsCheckBox;
    FlatButton4: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure Listarfornecedores(Sender: Tobject);
    procedure FlatButton1Click(Sender: TObject);
    procedure adicionaFornecedor(Sender:Tobject);
    procedure ConexaoWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure ConexaoExecuteComplete(Connection: TADOConnection;      RecordsAffected: Integer; const Error: Error;      var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton2Click(Sender: TObject);
    procedure btGerarClick(Sender: TObject);
    function getCdpesforncecedores(Sender:Tobject):string;
    procedure PreencherEstoquesConsolidado(Sender:Tobject);
    procedure criarTabela(Sender:Tobject);
    procedure edit1KeyPress(Sender: TObject; var Key: Char);
    procedure msgRodape(msg1,MSG2:String);
    procedure btImprimeClick(Sender: TObject);
    procedure geraArquivoImpressao(Sender:Tobject; nLinPorPagina:INTEGER);
    procedure FormShow(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure gridTitleClick(Column: TColumn);
    procedure preencheEstoqueDetalhado(Sender:tobject);
    procedure FlatButton4Click(Sender: TObject);
    procedure AjustaDbGrid(Sender:TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tb1,tb2:string;
implementation
uses unClasses, uForn;
{$R *.dfm}

procedure TForm1.criarTabela(Sender:Tobject);
var
  cmd,nmTable: String;
begin
   // criar a tabela dos itens com as somas totais
   nmTable :=  '#'+funcoes.SohLetras(GetNomeDoMicro() )  + '1' ;
   cmd := ' create table ' + nmTable + '( is_ref integer, Codigo varchar(08),Descricao varchar(50),Fornecedor varchar(30), Ref varchar(10), EAN varchar(13),[Pco 01] money,[Pco 02] money,Embalagem integer,[Est CD] integer,[Est Loja] integer,[Venda Periodo] integer)';
   funcSQl.GetValorWell('e',cmd,'@@error',conexao);

   tb1 := nmTable;
// criar a tabela com as quantiaddes e vendas por loja

   nmTable :=  '#'+funcoes.SohLetras(GetNomeDoMicro() )+ '2' ;

   cmd := ' create table ' + nmTable + '( is_ref integer, Codigo varchar(08),Descricao varchar(50),Fornecedor varchar(30), Ref varchar(10), EAN varchar(13),[Pco 01] money,[Pco 02] money,Embalagem integer,[Est CD] integer, [Est Matriz] integer, [Vd Matriz] integer, ' +
   '[Est Edgar] integer, [Vd Edgar] integer, ' +
   '[Est Pedro] integer, [Vd Pedro] integer, ' +
   '[Est DomLuis] integer, [Vd DomLuis] integer, ' +
   '[Est Maison] integer, [Vd Maison] integer, ' +
   '[Est Teresina] integer, [Vd Teresina] integer, ' +
   '[Est SaoLuis] integer, [Vd SaoLuis] integer, ' +
   '[Est Messejana] integer, [Vd Messejana] integer, ' +
   '[Est Montese] integer, [Vd Montese] integer, ' +
   '[Est Iguatemi] integer, [Vd Iguatemi] integer, ' +
   '[Est Liberato] integer, [Vd Liberato] integer ) ' ;

   tb2 := nmTable;
   funcSQl.GetValorWell('e',cmd,'@@error',conexao);

   tbItens.Connection := Conexao;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   conexao.Connected := false;
   conexao.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   conexao.Connected := true;

   Form1.caption := '(4) Análise de estoques de lojas       Database: ' + conexao.DefaultDatabase;


   cbLoja.Items := funcSQL.GetNomeLojas(Conexao, false, false, '','');
   if funcoes.RParRegInt('analisEst','loja') >  -1 then
      cbloja.ItemIndex := funcoes.RParRegInt('analisEst','loja')
   else
      cbloja.ItemIndex := 0;

   cbPreco01.Items := funcSQl.getListaPrecos(conexao, false,true, false);
   if  funcoes.RParRegInt('analisEst','pc01') > -1 then
      cbPreco01.ItemIndex :=  funcoes.RParRegInt('analisEst','pc01')
   else
      cbPreco01.ItemIndex :=  0;

   cbPreco02.Items := funcSQl.getListaPrecos( conexao, true ,true, true);
   if  funcoes.RParRegInt('analisEst','pc02') > -1 then
      cbPreco02.ItemIndex :=  funcoes.RParRegInt('analisEst','pc02')
   else
      cbPreco02.ItemIndex :=  0;

   if RParRegDate('analisEst','dti') > 0 then
      dti.Date := RParRegDate('analisEst','dti')
   else
      dti.Date := now;

   if RParRegDate('analisEst','dtf') > 0 then
      dtf.Date := RParRegDate('analisEst','dtf')
   else
      dtf.Date := now;

   if RParRegInt('analisEst','tipo') > -1 then
      rg1.ItemIndex := RParRegInt('analisEst','tipo');

   pnCodigo.Top := pnForn.top;
   pnCodigo.Left := pnforn.Left;
   criarTabela(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.WParRegDate('analisEst','dti', dti.Date);
   funcoes.WParRegDate('analisEst','dtf', dtf.Date);
   funcoes.WParRegint('analisEst','loja', cbLoja.ItemIndex);
   funcoes.WParRegint('analisEst','pc01', cbPreco01.ItemIndex);
   funcoes.WParRegint('analisEst','pc02', cbPreco02.ItemIndex);
   funcoes.WParRegint('analisEst','', cbLoja.ItemIndex);
   funcoes.WParRegint('analisEst','tipo',rg1.ItemIndex  );
   deletefile(funcoes.TempDir()+'log_' + application.Title + '.txt');
   deletefile(funcoes.TempDir()+'_GetValorWell');
end;


procedure TForm1.Listarfornecedores(Sender: Tobject);
begin
   qrCredores.SQL.Clear;
   qrCredores.sql.Add('Select cd_cred as codigo, nm_razsoc as fornecedor, cd_pes from dscre nolock where cd_pes in (select distinct cd_pes from crefe nolock) order by nm_razsoc');
   qrCredores.Open;
end;

procedure TForm1.rg1Click(Sender: TObject);
begin
   case rg1.ItemIndex of
   0:begin
        pnCodigo.visible := true;
        pnForn.Visible := false;
        lbForn.Clear;
        edit1.SetFocus;
     end;
   1:begin
        pnCodigo.visible := false;
        pnForn.Visible := true;
        edit1.Text := '';
     end;
   end;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   Application.CreateForm(TfmForn, fmForn);
   fmforn.Show;
end;

procedure TForm1.adicionaFornecedor(Sender: Tobject);
begin
   if lbforn.Items.count = 5 then
      funcoes.MsgTela('','Gerar itens de até 05 fornecedores de cada vez', mb_iconError+mb_ok)
   else
   begin
      lbforn.Items.Add( qrCredores.fieldByName('codigo').AsString +' - ' +
                     funcoes.preencheCampo(95, ' ' ,'d', qrCredores.fieldByName('fornecedor').AsString) +
                     qrCredores.fieldByName('cd_pes').AsString
                   );
   end;
end;

procedure TForm1.ConexaoWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType; var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
var
  cmd :string;
begin
  screen.Cursor := crHourGlass;
  cmd :=  dateTimeToStr(now) +#13+cmd+#13 + commandText +#13;
  funcoes.GravaLinhaEmUmArquivo(funcoes.TempDir()+'_log_' + application.Title + '.txt',cmd);
end;

procedure TForm1.ConexaoExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
  screen.Cursor := crDefault
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
    lbForn.DeleteSelected;
end;

function TForm1.getCdpesForncecedores(Sender: Tobject): string;
var
   i:smallint;
   aux:string;
begin
   aux :=  Quotedstr('');
   if  lbForn.Count  > 0 then
   begin
      aux := '';
      for i:=0 to lbForn.Items.count-2 do
         aux := aux + funcoes.SohNumeros( copy(lbForn.Items[i],90,60 ) ) + ' , ';
      aux := aux + funcoes.SohNumeros( copy(lbForn.Items[lbForn.items.count -1 ],90,60 ) ) ;
      aux := quotedstr(aux);
   end;
   result := aux;
end;

procedure TForm1.PreencherEstoquesConsolidado(Sender: Tobject);
var
   cmd:String;
   qrVd:TADOQuery;
   i:integer;
begin                          //
   qrVd := TADOQuery.Create(form1);
   qrVd.Connection := form1.Conexao;
   qrvd.CommandTimeout := 0;
   i:=1;
   tbItens.First;
   while tbItens.Eof = false do
   begin
      msgRodape(intToStr(i)  + '   de   ' + inttostr(tbItens.RecordCount) , 'Calculando item: '+ tbItens.fieldbyname('codigo').Asstring + ' - ' + tbItens.fieldbyname('descricao').Asstring );
      i:= i+1;

      cmd := '';
      qrVd.SQL.Clear;
      if cbLoja.ItemIndex = 0  then
      begin
         cmd := ' Select  sum(dbo.z_CF_estoqueNaLoja('+tbItens.fieldByName('is_ref').asString +' , is_uo, 0 )) as Estoque , ' +#13+
                ' dbo.Z_CF_funObterVendaPorPeriodo( '+ funcoes.getNumUO(cbLoja)                  +' , '+
                                                     tbItens.fieldByName('is_ref').asString      +' , '+
                                                     funcoes.DateTimeToSqlDateTime(dti.Date,'') + ' , '+
                                                     funcoes.DateTimeToSqlDateTime(dtf.Date,'') + ' , '+
                                                     funcoes.DateTimeToSqlDateTime(dti.Date,'') + ' , '+
                                                     ' 10033674 ) as Venda ' +#13+
                                                  ' from zcf_tbuo (nolock) where TP_ESTOQUE in (2) ';
      end
      else
      begin
         cmd := ' Select  sum(dbo.z_CF_estoqueNaLoja('+tbItens.fieldByName('is_ref').asString +' , '+  funcoes.getNumUO(cbLoja)  +', 1 )) as Estoque , ' +#13+
                ' dbo.Z_CF_funObterVendaPorPeriodo( '+ funcoes.getNumUO(cbLoja)                  +' , '+
                                                     tbItens.fieldByName('is_ref').asString      +' , '+
                                                     funcoes.DateTimeToSqlDateTime(dti.Date,'') + ' , '+
                                                     funcoes.DateTimeToSqlDateTime(dtf.Date,'') + ' , '+
                                                     funcoes.DateTimeToSqlDateTime(dti.Date,'') + ' , '+
                                                     ' 10033674 ) as Venda ' +#13
      end;
      funcoes.GravaLinhaEmUmArquivo(funcoes.TempDir()+ '_cmdPreencheEstoques.txt', cmd +#13+ ' --------------'  );
      qrVd.SQL.Add(cmd);
      qrVd.Open;

      tbItens.Edit;
      tbItens.FieldByName('Est Loja').Asinteger := qrVd.fieldByname('estoque').Asinteger;
      tbItens.FieldByName('Venda Periodo').Asinteger := qrVd.fieldByname('venda').Asinteger;
      tbItens.post;
      tbItens.next;
   end;
   msgRodape('','');
   tbItens.First;
end;


procedure TForm1.btGerarClick(Sender: TObject);
var
   erro:String;
   qrItens: TADOQuery;
begin
   erro := '';
     if rg1.ItemIndex = 0 then
         if length(edit1.Text) < 3 then
            erro := 'O código tem que ter ao menos 3 dígitos';

     if rg1.ItemIndex = 1 then
     begin
        if lbForn.Count  = 0 then
           erro :=  'Escolha ao menos um fornecedor para gerar.';
     end;
     if erro = '' then
     begin
        grid.Visible := false;
        msgRodape('','Obtendo a lista de itens...');
        qrItens := TADOQuery.Create(form1);
        qrItens.Connection := conexao;
        qrItens.CommandTimeout := 0;

        qrItens.SQL.Clear();
        qrItens.SQL.add('Exec zcf_obterTotalEstLojas ' +
                         '@uo= ' + quotedStr( getNumUO(cbLoja) )  +' , '+#13+
                         '@pc01='+ quotedStr( getNumUO(cbPreco01) )+' , '+#13+
                         '@Pc02='+ quotedStr( getNumUO(cbPreco02) )+' , '+ #13+
                         '@dti ='+  funcoes.DateTimeToSqlDateTime(dti.Date,'0')  +' , '+#13+
                         '@dtf ='+  funcoes.DateTimeToSqlDateTime(dtf.Date,'0')  +' , '+#13+
                         '@ehAtivo='+ quotedStr('1')  + ' , ' +#13+
                         '@nvCat= ' + quotedStr( lbNivel.Caption )  + ' , ' +#13+
                         '@vlCat= ' + quotedstr( lbCodigo.Caption)  + ' , ' +#13+
                         '@cd_ref=' + quotedstr( edit1.Text ) + ' , ' +#13+
                         '@forn = ' + getCdpesforncecedores(nil)
                       );
        qrItens.Open();
        qrItens.First;
        if tbItens.TableName <> '' then
        begin
           while tbItens.IsEmpty = false do
             tbItens.Delete;
           tbItens.Active := false;
        end;
        if fsSeparPorLoja.Checked = true then
          tbItens.TableName := tb2
        else
          tbItens.TableName := tb1;
        tbItens.Open();
        while qrItens.Eof = false do
        begin
           tbItens.Append;
           tbItens.FieldByName('is_ref').AsInteger := qrItens.fieldByName('is_ref').AsInteger;
           tbItens.FieldByName('Codigo').AsString := qrItens.fieldByName('codigo').AsString;
           tbItens.FieldByName('descricao').AsString := qrItens.fieldByName('descricao').AsString;
           tbItens.FieldByName('ref').AsString := qrItens.fieldByName('ref').AsString;
           tbItens.FieldByName('fornecedor').AsString := qrItens.fieldByName('fornecedor').AsString;
           tbItens.FieldByName('pco 01').AsFloat := qrItens.fieldByName('pco 01').Asfloat;
           tbItens.FieldByName('pco 02').AsFloat := qrItens.fieldByName('pco 02').AsFloat;
           tbItens.FieldByName('ean').AsString := qrItens.fieldByName('ean').AsString;
           tbItens.FieldByName('embalagem').AsInteger := qrItens.fieldByName('embalagem').AsInteger;
           tbItens.FieldByName('est cd').AsInteger := qrItens.fieldByName('est cd').AsInteger;
           tbItens.FieldByName('embalagem').AsInteger := qrItens.fieldByName('embalagem').AsInteger;
           tbItens.Post;
           qrItens.Next;
       end;
       qrItens.Destroy;


       AjustaDbGrid(Sender);

       if fsSeparPorLoja.Checked = false then
          PreencherEstoquesConsolidado(sender)
       else
          preencheEstoqueDetalhado(nil);
       grid.Visible := true;
     end
     else
        msgTela('', erro, mb_iconerror+mb_ok);
end;

procedure TForm1.edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
     btGerarClick(Sender);  
end;

procedure TForm1.msgRodape(msg1,MSG2:String);
begin
   form1.sb.Panels[0].Text := msg1;
   form1.sb.Panels[1].Text := msg2;
   sb.Refresh;
   form1.Refresh;
end;


procedure TForm1.geraArquivoImpressao(Sender: Tobject;  nLinPorPagina:integer);
var
   dest:TstringList;
   linha:string;
   l,Fl:integer;
   codForn:string;
begin
   dest:=  TStringList.create();
   Fl := 0; l := 0;

   if nLinPorPagina = 0 then
      nLinPorPagina := 50
   else
      nLinPorPagina := 70;

   grid.visible := false;
   tbItens.First;
   while tbItens.Eof = false do
   begin
      inc(fl);
      Dest.Add('                          *** ANALISE DE ESTOQUE  ***                                                                                        FL:' + funcoes.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('Loja: ' + copy(cbLoja.Items[cbLoja.itemindex],01,30) ) ;
      Dest.Add('Preco 01 : ' + copy(cbPreco01.items[cbPreco01.ItemIndex],01,30 )  +'   Preco 02 : ' + copy(cbPreco02.items[cbPreco02.ItemIndex],01,30 )  +  'CATEGORIAS:    DEPARTAMENTO: ' +  lbClasse1.CAPTION  );
      if cbLoja.ItemIndex = 0 then
         linha := 'Loja para consulta de venda: < TODAS >'
      else
         linha := 'Loja para consulta de venda: '+ copy(cbLoja.Items[cbLoja.itemIndex],01,30) ;

      Dest.Add( funcoes.preencheCampo(100,' ','d', linha ) + 'SECCAO: ' +  lbClasse2.CAPTION   );

      linha := 'Periodo de venda consultado: ' + dateToStr(dti.date) + ' até ' + dateToStr(dtf.Date);
      linha :=  FUNCOES.preencheCampo(100,' ','d',linha);
      Dest.Add(linha + 'CATEGORIA: ' +  lbClasse2.CAPTION  );

      Dest.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
      Dest.Add('CODIGO  EAN           DESCRICAO                              REF FORN  EMBALAGEM    EST CD   EST LOJAS   VEND PERIODO   ' +   copy(cbPreco01.items[cbPreco01.ItemIndex],01,10 )  +'   '+ copy(cbPreco02.items[cbPreco02.ItemIndex],01,10) );
      Dest.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
      Dest.Add('               ');
      while ( l < nLinPorPagina ) and ( tbItens.eof = false ) do
      begin
          if codForn <> tbItens.fieldByname('fornecedor').AsString then
          begin
             codForn := tbItens.fieldByname('fornecedor').AsString;
             inc(l);
             linha := 'Fornecedor: ' + tbitens.fieldByname('fornecedor').asString;
             dest.Add(linha );
          end;
          linha := tbItens.fieldByName('codigo').asString +' '+
                   funcoes.preencheCampo(13,' ','e', tbItens.fieldByName('ean').asString ) +' '+
                   funcoes.preencheCampo(40,' ','d', copy(tbItens.fieldByName('descricao').asString,01,40) ) +' '+
                   funcoes.preencheCampo(06,' ','e', tbItens.fieldByName('ref').asString ) +' '+
                   funcoes.preencheCampo(10,' ','e', tbItens.fieldByName('embalagem').asString ) +' '+
                   funcoes.preencheCampo(10,' ','e', tbItens.fieldByName('est cd').asString ) +' '+
                   funcoes.preencheCampo(10,' ','e', tbItens.fieldByName('est loja').asString ) +' '+
                   funcoes.preencheCampo(13,' ','e', tbItens.fieldByName('Venda Periodo').asString ) +' '+
                   funcoes.preencheCampo(12,' ','e', FloatToStrF(tbItens.fieldByName('Pco 01').asFloat, ffnumber,18,02 ) ) +' '+
                   funcoes.preencheCampo(12,' ','e', FloatToStrF(tbItens.fieldByName('Pco 02').asFloat, ffnumber,18,02 ) ) +' ';
         dest.Add(linha);
         tbItens.next;
      end;
      if ( tbItens.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPorPagina ) do
         begin
            Dest.Add('');
            inc(l);
         end;
      Dest.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
      Dest.Add('                                                                                                                                       Por Walter Carvalho');
      end;
   end;

   // definir o arquivo de impressao
   linha := funcoes.TempDir() +'_ImpressaoAnaliseEstoque.tmp';

   Dest.SaveToFile( linha );
   tbItens.First;

   grid.visible := true;
   funcoes.imprimeArquivo( form1, linha , false, 08, 'analise de estoque.', 0 )
end;

procedure TForm1.btImprimeClick(Sender: TObject);
begin
  if (tbItens.IsEmpty = false )  and ( tbItens.TableName = tb1 ) then
      geraArquivoImpressao(nil, 0 );
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   rg1Click(nil);
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   if tbItens.IsEmpty = false then
      export1.Execute;
end;

procedure TForm1.gridTitleClick(Column: TColumn);
begin
   if tbItens.IsEmpty = false then
      FUNCSQL.OrganizarTabela( tbItens, column);
end;

procedure TForm1.preencheEstoqueDetalhado(Sender:TObject);
var
  qrItens:TadoQuery;
  is_ref,di,df,cmd:String;
  i:integer;
begin
   qrItens := TADOQuery.Create(form1);
   qrItens.Connection:= conexao;
   qrItens.CommandTimeout := 0;

   di := funcoes.DateTimeToSqlDateTime( dti.Date , ' ' );
   df := funcoes.DateTimeToSqlDateTime( dtf.Date , ' ' );
   tbItens.First;

   i:=1;
   while tbItens.eof = false do
   begin
      msgRodape(intToStr(i)  + '   de   ' + inttostr(tbItens.RecordCount) , 'Calculando item: '+ tbItens.fieldbyname('codigo').Asstring + ' - ' + tbItens.fieldbyname('descricao').Asstring );
      inc(i);

      is_ref := tbitens.fieldByname('is_ref').AsString;
      cmd := 'Select ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ ' , 10033586, 0) as [Est Matriz], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033586, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674) as [Vd Matriz], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033587, 0) as [Est Edgar], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033587, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674) as [Vd Edgar],' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033588, 0) as [Est Pedro], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033588, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Pedro], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033589, 0) as [Est DomLuis], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033589, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd DomLuis], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10037736, 0) as [Est Maison], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10037736, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Maison], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033592, 0) as [Est Teresina], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033592, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Teresina], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033591, 0) as [Est SaoLuis], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033591, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd SaoLuis], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033590, 0) as [Est Messejana], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033590, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Messejana], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033593, 0) as [Est Montese], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033593, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Montese], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033594, 0) as [Est Iguatemi], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033594, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Iguatemi], ' +#13+
             'dbo.Z_CF_EstoqueNaLoja (' + is_ref+ '  , 10033595, 0) as [Est Liberato], ' +#13+
             'dbo.Z_CF_funObterVendaPorPeriodo(10033595, ' + is_ref+ ' , ' + di + ' , ' + df  +' , '+di+' , 10033674)as [Vd Liberato] ' ;
      with qrItens do
      begin
         SQL.Clear();
         SQL.add(cmd);
         Open();
         first;
      end;

      with tbItens do
      begin
         edit;
         fieldByName('Est Matriz').AsInteger := qrItens.fieldByName('Est Matriz').Asinteger;
         fieldByName('Vd Matriz').AsInteger := qrItens.fieldByName('Vd Matriz').Asinteger;

         fieldByName('Est Edgar').AsInteger := qrItens.fieldByName('Est Edgar').Asinteger;
         fieldByName('Vd Edgar').AsInteger := qrItens.fieldByName('Vd Edgar').Asinteger;

         fieldByName('Est Pedro').AsInteger := qrItens.fieldByName('Est Pedro').Asinteger;
         fieldByName('Vd Pedro').AsInteger := qrItens.fieldByName('Vd Pedro').Asinteger;

         fieldByName('Est DomLuis').AsInteger := qrItens.fieldByName('Est DomLuis').Asinteger;
         fieldByName('Vd DomLuis').AsInteger := qrItens.fieldByName('Vd DomLuis').Asinteger;

         fieldByName('Est Maison').AsInteger := qrItens.fieldByName('Est Maison').Asinteger;
         fieldByName('Vd Maison').AsInteger := qrItens.fieldByName('Vd Maison').Asinteger;

         fieldByName('Est Teresina').AsInteger := qrItens.fieldByName('Est Teresina').Asinteger;
         fieldByName('Vd Teresina').AsInteger := qrItens.fieldByName('Vd Teresina').Asinteger;

         fieldByName('Est SaoLuis').AsInteger := qrItens.fieldByName('Est SaoLuis').Asinteger;
         fieldByName('vd SaoLuis').AsInteger := qrItens.fieldByName('Vd SaoLuis').Asinteger;

         fieldByName('Est Messejana').AsInteger := qrItens.fieldByName('Est Messejana').Asinteger;
         fieldByName('Vd Messejana').AsInteger := qrItens.fieldByName('Vd Messejana').Asinteger;

         fieldByName('Est Montese').AsInteger := qrItens.fieldByName('Est Montese').Asinteger;
         fieldByName('Vd Montese').AsInteger := qrItens.fieldByName('Vd Montese').Asinteger;

         fieldByName('Est Iguatemi').AsInteger := qrItens.fieldByName('Est Iguatemi').Asinteger;
         fieldByName('Vd Iguatemi').AsInteger := qrItens.fieldByName('Vd Iguatemi').Asinteger;

         fieldByName('Est Liberato').AsInteger := qrItens.fieldByName('Est Liberato').Asinteger;
         fieldByName('Vd Liberato').AsInteger := qrItens.fieldByName('Vd Liberato').Asinteger;
         post;
         next;
      end;
   end;
   qrItens.Destroy();
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
   Application.CreateForm(TFmClasses, FmClasses);
   FmClasses.Show();
end;

procedure TForm1.AjustaDbGrid(Sender: TObject);
var
   i:integer;
begin
   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];

   grid.Columns[0].Width :=0;
   grid.Columns[1].Width :=48;
   grid.Columns[2].Width :=250;
   grid.Columns[3].Width :=70;
   grid.Columns[4].Width :=40;
   grid.Columns[5].Width :=60;
   grid.Columns[6].Width :=60;
   grid.Columns[7].Width :=60 ;
   grid.Columns[8].Width :=60 ;
   grid.Columns[9].Width :=60 ;
   grid.Columns[10].Width:=60 ;

   if tbItens.TableName = tb2 then
   begin
      for i:=11 to grid.Columns.Count -1 do
         grid.Columns[i].Width:= 50 ;
   end;
end;

end.



