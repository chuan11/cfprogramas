unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, adLabelComboBox, adLabelEdit,
  TFlatButtonUnit, funcoes, Grids, DBGrids, SoftDBGrid, ExtCtrls, DBClient,
  Provider,clipbrd, ComCtrls, AppEvnts, comObj, mxExport, TFlatCheckBoxUnit,
  TFlatComboBoxUnit,funcsql, mxOneInstance, RpBase, RpSystem, RpRave,
  RpDefine, RpCon, RpConDS, shellapi, Jpeg;

type
  TForm1 = class(TForm)
    edCodigo: TadLabelEdit;
    CBPRECO01: TadLabelComboBox;
    edDescricao: TadLabelEdit;
    ADOConnection1: TADOConnection;
    Query: TADOQuery;
    FlatButton1: TFlatButton;
    cbLoja: TadLabelComboBox;
    dbgrid: TSoftDBGrid;
    DataSource1: TDataSource;
    cbItens: TRadioGroup;
    RgOrdem1: TRadioGroup;
    rgTpestoque: TadLabelComboBox;
    Animate: TAnimate;
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    btImprime: TFlatButton;
    cbTpImp: TadLabelComboBox;
    CBpRECO02: TadLabelComboBox;
    Querycodigo: TStringField;
    Querydescricao: TStringField;
    QueryestoqueAtual: TIntegerField;
    QueryPreco01: TFloatField;
    QueryPreco02: TFloatField;
    FlatButton3: TFlatButton;
    Export1: TmxDataSetExport;
    Timer1: TTimer;
    cbOrder: TFlatCheckBox;
    Queryqt_emb: TBCDField;
    stbar: TStatusBar;
    EdLocalImp: TadLabelEdit;
    Querycd_pes: TIntegerField;
    mxOneInstance1: TmxOneInstance;
    cbTotaliza: TFlatCheckBox;
    Label2: TLabel;
    lbTotal2: TLabel;
    RvDataSetConnection1: TRvDataSetConnection;
    RvProject: TRvProject;
    RvSystem1: TRvSystem;
    lbTotal1: TLabel;
    Label1: TLabel;
    Queryis_ref: TIntegerField;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    tb: TADOTable;
    tbis_ref: TIntegerField;
    tbpath: TStringField;
    function GetNumLojas(sender: tobject): Tstrings;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    function GetNomeLojas(sender: tobject): Tstrings;
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbItensClick(Sender: TObject);
    procedure MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer);
    procedure btImprimeClick(Sender: TObject);
    procedure dbgridCellClick(Column: TColumn);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure PesquisaCodigos(sender:tobject);
    procedure cbTpImpChange(Sender: TObject);
    procedure GerarMapaSeparacao(sender: tobject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure cbTotalizaClick(Sender: TObject);
    procedure CalculaTotais(Sender:Tobject);
    procedure ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;     const Command: _Command; const Recordset: _Recordset);
    procedure dbgridTitleClick(Column: TColumn);
    procedure impressaoRave(Sender:Tobject);
    procedure ImpressaoComImagens(Sender:Tobject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetNumLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('Select DS_TIPOPRECO, tp_preco from ttpco with(NoLock) ');
   query.Open;

   aux := TstringList.create();
   query.First;

   while query.Eof = false do
   begin
      aux.add(query.Fields[0].AsString+query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;

   AUX.ADD('Preco de custo                                     1');
   AUX.ADD('Custo ultima compra                               10');

// descricao do 01 ao 50
//is_uo do 51 ao 58
end;

function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from tbuo with(Nolock) where TP_ESTOQUE in (1,2) order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and (FileExists('upgrade.exe') = true ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   AdoConnection1.Connected := false;
   AdoConnection1.ConnectionString :=  funcoes.getDadosConexaoUDL( extractFilePath( ParamStr(0) ) + 'ConexaoAoWell.ini' );
   AdoConnection1.Connected := true;

   cbpreco01.Items := funcsql.getListaPrecos( AdoConnection1, true, true, true );

   if funcoes.RParReg('ProgramasCF\tabela','TipoPreco01') <> '' then
      CBPRECO01.ItemIndex := strToInt (funcoes.RParReg('ProgramasCF\tabela','TipoPreco01'))
   else
      cbPreco01.itemindex := 0;

   cbpreco02.Items := cbpreco01.Items;
   if funcoes.RParReg('ProgramasCF\tabela','TipoPreco02') <> '' then
      CBPRECO02.ItemIndex := strToInt (funcoes.RParReg('ProgramasCF\tabela','TipoPreco02'))
   else
      cbPreco02.itemindex := 0;

   cbLoja.items := form1.GetNomeLojas(sender);
   if funcoes.RParReg('ProgramasCF\tabela','Loja') <> '' then
      cbLoja.ItemIndex := strToInt (funcoes.RParReg('ProgramasCF\tabela','Loja'))
   else
      cbLoja.itemindex := 0;

   if funcoes.RParReg('ProgramasCF\tabela','Loja') <> '' then
      cbLoja.ItemIndex := strToInt (funcoes.RParReg('ProgramasCF\tabela','Loja'))
   else
      cbLoja.itemindex := 0;

   EdLocalImp.text := funcoes.RParReg('ProgramasCF\tabela','LocalImpressao');

   if funcoes.RParReg('ProgramasCF\tabela','tpImp') <> '' then
      cbtpImp.ItemIndex := strToInt( funcoes.RParReg('ProgramasCF\tabela','tpImp'))
   else
      cbtpImp.ItemIndex := 0;
   cbTpImpChange(Sender);


   form1.Caption := form1.caption + '                  DataBase: ' + AdoConnection1.DefaultDatabase;
end;

procedure tForm1.PesquisaCodigos(sender:tobject);
var
  OrdenaFornecedor:string;
begin
  SCREEN.CURSOR := crhourglass;
  stbar.SimpleText := '';
  animate.Visible:= true;
  Animate.Active:= true;

  if cbOrder.Checked = true then
     OrdenaFornecedor := '1'
  else
     OrdenaFornecedor := '0';


   if length(edCodigo.Text) = 13 then
      edCodigo.Text := funcSql.openSQL('Select cd_ref from crefe (nolock) where is_ref in (select is_ref from dscbr(nolock) where cd_pesq = ' + quotedstr(edCodigo.Text) + ' ) ', 'cd_ref', ADOConnection1 );
      
   Query.SQL.Clear;
   query.SQL.Add('Exec Z_CF_Tabela_Estoque ' +
                  '@is_ref ='+ QuotedStr (edCodigo.text) + ', ' +
                  '@cd_desc ='+ quotedstr(edDescricao.text)  + ', ' +
                  '@uo ='+ copy(cbLoja.Items[cbLoja.ItemIndex],51,08) +' , '+
                  '@pc01='+ funcoes.SohNumeros((copy(cbPreco01.Items[cbPreco01.ItemIndex],40,100))) +' , '+
                  '@pc02='+ funcoes.SohNumeros((copy(cbPreco02.Items[cbPreco02.ItemIndex],40,100))) +' , '+
                  '@itens='+ intToStr(cbItens.ItemIndex)+ ' , ' +
                  '@ordem='+ '0' +' , ' +  // intToStr(RgOrdem.ItemIndex)+ ' , ' +
                  '@tpEstoque='+ intToStr(RgTpEstoque.ItemIndex)+ ' , ' +
                  '@ordenafornecedor='+ OrdenaFornecedor
                );
   query.SQL.SaveToFile(funcoes.TempDir()+ 'Query_tabelaPrecos.tmp');
   query.Open;
   cbTotalizaClick(Sender);
   animate.Visible:= false;
   Animate.Active:= false;
   edCodigo.SetFocus;
   cbpreco01.SetFocus;
   edCodigo.SetFocus;
   dbgrid.Columns[0].Width := 75;
   dbgrid.Columns[1].Width := 350;
   dbgrid.Columns[2].Width := 80;
   dbgrid.Columns[03].Width :=50;
   dbgrid.Columns[04].Width := 80;
   dbgrid.Columns[05].Width := 80;

   if query.IsEmpty = false then
      if query.RecordCount = 1 then
          stbar.SimpleText := inttostr(query.RecordCount) + ' Item'
      else
          stbar.SimpleText := inttostr(query.RecordCount) + ' Itens';
   SCREEN.CURSOR := crDefault;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = vk_f7 then
      FlatButton1Click(Sender);
end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
   with DbGRid do
   begin
      Left := 5;
      top := 121;
      width := form1.Width - 25;
      height := form1.Height - 65 - 170;
   end;
   panel1.top := dbgrid.Top + dbgrid.Height +10;
   edCodigo.SetFocus;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   adoconnection1.Connected := false;
   funcoes.WParReg('ProgramasCF\tabela','LocalImpressao', EdLocalImp.text );
   funcoes.WParReg('ProgramasCF\tabela','TipoPreco01', intToStr(cbPreco01.ItemIndex));
   funcoes.WParReg('ProgramasCF\tabela','TipoPreco02', intToStr(cbPreco02.ItemIndex));
   funcoes.WParReg('ProgramasCF\tabela','Loja', intToStr(cbLoja.ItemIndex));
   funcoes.WParReg('ProgramasCF\tabela','tpitens', intToStr(cbitens.ItemIndex));
//   funcoes.WParReg('ProgramasCF\tabela','tpOrdem', intToStr(rgOrdem.ItemIndex));
   funcoes.WParReg('ProgramasCF\tabela','tpImp', intToStr(cbtpImp.ItemIndex));

//   funcoes.WParReg('ProgramasCF\tabela','tpPapel', intToStr(tpPapel.ItemIndex));



   if cbOrder.Checked = true then
      funcoes.WParReg('ProgramasCF\tabela','OrdenaPorFornecedor', '1')
   else
      funcoes.WParReg('ProgramasCF\tabela','OrdenaPorFornecedor', '')
end;

procedure TForm1.cbItensClick(Sender: TObject);
begin
   if cbItens.ItemIndex >0 then
   begin
      edDescricao.Visible := true;
      edDescricao.SetFocus;
   end
   else
   begin
      edDescricao.Visible := false;
      edCodigo.SetFocus;
   end;

end;


procedure TForm1.MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer); //sender:tobject);
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

   dbgrid.visible := false;
   Query.First;
   while query.Eof = false do
   begin
      inc(fl);
      Dest.Add('                          *** TABELA DE PRECOS  ***                                     FL:' + funcoes.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('Loja: ' + copy(cbLoja.Items[cbLoja.itemindex],01,30) ) ;
      Dest.Add('Preco 01 : ' + copy(cbPreco01.items[cbPreco01.ItemIndex],01,30 )  +'   Preco 02 : ' + copy(cbPreco02.items[cbPreco02.ItemIndex],01,30 )  );
      Dest.Add('Codigo: ' + edCodigo.text);
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('CODIGO    DESCRICAO                                        ESTOQUE CAIXA  '+ copy(cbPreco01.items[cbPreco01.ItemIndex],01,10 )  +' '+ copy(cbPreco02.items[cbPreco02.ItemIndex],01,10) );
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < nLinPorPagina ) and ( query.eof = false ) do
      begin
         if cbOrder.Checked = true then
            if codForn <> Query.fieldByname('cd_pes').AsString then
            begin
               dest.Add('');
               codForn := Query.fieldByname('cd_pes').AsString;
               inc(l);
               linha := 'Fornecedor :' + FuncSql.GetValorWell('O',' Select NM_FANTASI from dspes where cd_pes = ' + codForn, 'NM_FANTASI', AdoConnection1 );
               dest.Add(linha );
            end;


         linha :=
         // alterei em 02/09/2009 paa a aprecer o estoque a lucinete pediu
            funcoes.preencheCampo(10,' ', 'd', Query.fieldByname('codigo').Asstring) +
            funcoes.preencheCampo(45,' ', 'd', copy(Query.fieldByname('descricao').Asstring,01,45 )) +
            funcoes.preencheCampo(10,' ', 'e', Query.fieldByname('estoqueatual').Asstring)+
            funcoes.preencheCampo(02,' ', 'e', ' ' ) +
            funcoes.preencheCampo(06,' ', 'e', Query.fieldByname('QT_EMB').Asstring) +
            funcoes.preencheCampo(12,' ', 'e', floattostrf(Query.fieldByname('preco 01').AsFloat,ffNumber,18,2)) +
            funcoes.preencheCampo(12,' ', 'e', floattostrf(Query.fieldByname('preco 02').AsFloat,ffNumber,18,2));


         if (Query.fieldByname('preco 01').AsFloat <> 0) or (Query.fieldByname('preco 02').AsFloat <> 0 ) then
         begin
            inc(l);
            dest.Add(linha );
         end;
         query.next;
      end;
      if ( query.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------');
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
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('                                                                             Por Walter Carvalho');
      end;
   end;
   Dest.SaveToFile( ExtractFilePath(ParamStr(0)) + '\Tabela.tmp');
   query.First;

   dbgrid.visible := true;


   linha :=  pchar('cmd.exe /c print /d:'+ EdLocalImp.Text +' '+ExtractFilePath(ParamStr(0)) + 'Tabela.tmp' );
   if Application.MessageBox('  Prepare a impressora imprimir.....    Confirma a impressão ?        ','', mb_iconquestion+mb_yesno) = mrYes then
      WinExec(pchar(linha),sw_normal);
end;



procedure TForm1.dbgridCellClick(Column: TColumn);
begin
   clipboard.AsText := query.FieldByName('codigo').AsString;
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject;E: Exception);
begin
   animate.Visible := false;
   animate.Active := false;
   Application.MessageBox(pchar('Ocorreu um erro: ' +#13+ e.ClassName +#13+ e .Message),'' ,mb_iconError + mb_ok  );
   if e.ClassName = 'EOleSysError' then
      Application.MessageBox(pchar('Não consegui encontrar o Excel , verifique se ele está instalado corretamente.' +#13),'' ,mb_iconError + mb_ok  );
end;

procedure TForm1.cbTpImpChange(Sender: TObject);
begin
   case  cbTpImp.ItemIndex of
      0,2:begin
             EdLocalImp.Visible := false;
             cbOrder.Visible := false;
          end;
          else
          begin
             EdLocalImp.Visible := true;
             cbOrder.Visible := true;
          end
   end;
end;


procedure TForm1.GerarMapaSeparacao(sender: tobject);
var
  Excel : Variant;
  Linha:integer;
begin
   screen.Cursor := crHourGlass;
   dbgrid.Visible := False;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'TabelaModelo.xls');
   Excel.WorkBooks[1].Sheets[1].Cells[02,02]:= trim( edCodigo.text);
   Excel.WorkBooks[1].Sheets[1].Cells[02,04]:= trim( DateTimeToStr(now));
   Excel.WorkBooks[1].Sheets[1].Cells[04,04]:= trim(copy(cbPreco01.Items[cbPreco01.ItemIndex],01,15));
   Excel.WorkBooks[1].Sheets[1].Cells[04,05]:= trim(copy(cbPreco02.Items[cbPreco02.ItemIndex],01,15));
   Linha:=5;
   While Query.Eof = false do
   Begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,1]:= trim(Query.fieldByname('codigo').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,2]:= trim(Query.fieldByname('descricao').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,3]:= trim(Query.fieldByname('estoqueAtual').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,4]:= floattostrf(  Query.fieldByname('preco 01').asfloat ,ffNumber,18,2);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,5]:= floattostrf(  Query.fieldByname('preco 02').asfloat ,ffNumber,18,2);
      query.Next;
      inc(Linha);
   end;
   Query.First;
   Excel.Visible :=True;

   screen.Cursor := crDefault;
   dbgrid.Visible := true;
end;
procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   if Query.IsEmpty = false then
   begin
      export1.FileName := 'Tabela_'+ funcoes.SohNumeros(dateTimeToStr(now));
      export1.Execute();
   end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   if animate.Active = true then
      form1.Refresh;
end;


procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   if length(edCodigo.Text) >= 3 then
      PesquisaCodigos(sender)
   else if  application.MessageBox(pchar('Deseja mesmo gerar de todos os fornecedores  ???' +#13),pchar(form1.caption), mb_YesNo + mb_iconQuestion)= mrYes then
      PesquisaCodigos(sender)
end;



procedure TForm1.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_Return then
      FlatButton1Click(Sender)
end;

procedure TForm1.mxOneInstance1InstanceExists(Sender: TObject);
begin
   msgTela( form1.Caption, 'Já existem uma tela desse programa em execução.',mb_IconError+Mb_Ok);
   APPLICATION.Terminate;
end;
procedure TForm1.CalculaTotais(Sender: Tobject);
var
  t1,t2:real;
begin
   if ( query.IsEmpty = false  )   then
   begin
      dbgrid.Visible := false;
      query.First;
      if cbTotaliza.Checked = true then
      begin
         t1:=0;
         t2:=0;
         while query.Eof = false do
         begin
            t1:= t1 + query.fieldByname('Preco 01').asFloat * query.fieldByname('estoqueAtual').asFloat ;
            t2:= t2 + query.fieldByname('Preco 02').asFloat * query.fieldByname('estoqueAtual').asFloat;
            query.Next;
         end;
         lbTotal1.Caption := FloatToStrF( t1,ffnumber,18,02);
         lbTotal2.Caption := FloatToStrF( t2,ffnumber,18,02);
       end;
       dbgrid.Visible := true;
   end;
end;

procedure TForm1.cbTotalizaClick(Sender: TObject);
begin
  if (cbTotaliza.Checked = true) then
     calculaTotais(Sender);
end;
procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.GravaLinhaEmUmArquivo(funcoes.TempDir() +'_'+ application.Title+'.txt', CommandText);
end;

procedure TForm1.dbgridTitleClick(Column: TColumn);
begin
   screen.Cursor := crhourglass;
   funcsql.OrganizarQuery(query,column);
   screen.Cursor := crDefault;
end;



procedure TForm1.impressaoRave(Sender:Tobject);
begin
   RvProject.SetParam('p1', trim( copy( CBPRECO01.Items[CBPRECO01.itemIndex],01,30)) );
   RvProject.SetParam('p2', trim( copy( CBPRECO02.Items[CBPRECO02.itemIndex],01,30)) );
   RvProject.SetParam('cod', trim( edCodigo.text));
   RvProject.SetParam('ord', ''); //copy( rgOrdem.Items[rgordem.ItemIndex],02,20));
   RvProject.SetParam('loja', copy( cbLoja.Items[cbLoja.ItemIndex],01,25));
   rvproject.ExecuteReport('tabela');
end;


procedure TForm1.ImpressaoComImagens(Sender: Tobject);
begin
   tb.Open
end;


procedure TForm1.btImprimeClick(Sender: TObject);
begin
  if query.IsEmpty = false then
     case cbTpImp.ItemIndex of
        0:impressaoRave(nil);
        1:MontarRelatorioImpressao(nil, 0 ); //
        2:ImpressaoComImagens(nil);
     end;
end;


end.

