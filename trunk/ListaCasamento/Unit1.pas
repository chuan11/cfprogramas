 unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, adLabelDBComboBox, Menus, funcoes, dbgrids,
  AppEvnts, DB, ADODB, Mask, adLabelDBEdit, ComCtrls, TFlatAnimationUnit,
  mxOneInstance, ActnList, Buttons,  TFlatButtonUnit, RpBase, RpSystem,
  RpRave, RpDefine, RpCon, RpConDS, adLabelComboBox, ExtCtrls,funcSQL, verificaSenhas;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    CadastrodeListas1: TMenuItem;
    ProdutosnNasListas1: TMenuItem;
    ADOConnection1: TADOConnection;
    ApplicationEvents1: TApplicationEvents;
    mxOneInstance1: TmxOneInstance;
    iposdeProdutos1: TMenuItem;
    sugestodeProdutos1: TMenuItem;
    Query1: TADOQuery;
    Cadastrodetipos1: TMenuItem;
    iposdelistas1: TMenuItem;
    table1: TADOTable;
    sb: TStatusBar;
    Configurao1: TMenuItem;
    Relatrios1: TMenuItem;
    ProdutosCompradosporpeodo1: TMenuItem;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    dp1: TDateTimePicker;
    dp2: TDateTimePicker;
    cb1: TadLabelComboBox;
    VendasTotaisporlista1: TMenuItem;
    RvProject1: TRvProject;
    RvDSConn: TRvDataSetConnection;
    RvSystem: TRvSystem;
    N1: TMenuItem;
    Geracaodecrdito1: TMenuItem;
    ConexaoWell: TADOConnection;
    procedure FormCreate(Sender: TObject);
    procedure CadastrodeListas1Click(Sender: TObject);
    procedure EscondeMenu(sender:tobject);
    procedure mostraMenu(sender:tobject);
    procedure ADOConnection1WillExecute(Connection: TADOConnection;var CommandText: WideString; var CursorType: TCursorType;var LockType: TADOLockType; var CommandType: TCommandType; var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;const Command: _Command; const Recordset: _Recordset);
    procedure ADOConnection1ExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;var EventStatus: TEventStatus; const Command: _Command;const Recordset: _Recordset);
    procedure ProdutosnNasListas1Click(Sender: TObject);
    procedure AbreFormPesquisa(sender:tobject;Act:integer);
    function EhlistaDaloja(num:string;MostraMensagem:boolean): boolean;
    procedure verLogClick(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure iposdeProdutos1Click(Sender: TObject);
    procedure sugestodeProdutos1Click(Sender: TObject);
    procedure iposdelistas1Click(Sender: TObject);
    procedure Query1DeleteError(DataSet: TDataSet; E: EDatabaseError;var Action: TDataAction);
    function GetTiposListas(MostrarTodas:boolean;  tiposPListar:String):Tstrings;
    procedure SalvaColDbgrid(NomeForm:String;Dbgrid:tdbgrid);
    procedure LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    function  HaParametroInvalido(sender:Tobject):boolean;
    procedure AbrirLista(sender:tobject;num:string);
    function  GetNumLojas(sender:tobject; Loja:String ):Tstrings;
    function  RParReg(NomeParam:String):string;
    function  WParReg(NomeParam,valor:String):boolean;
    procedure Query1AfterOpen(DataSet: TDataSet);
    procedure Configurao1Click(Sender: TObject);
    procedure ProdutosCompradosporpeodo1Click(Sender: TObject);
    function  InVencLista():string;
    function  FimVencLista():string;
    procedure cb1Change(Sender: TObject);
    procedure dp1Change(Sender: TObject);
    procedure dp2Change(Sender: TObject);
    function  PosicaoBotoes(form:Tform):integer;
    procedure salvacomandosprograma(cmd:String);
    procedure atualizaDadosItensLista(nItens, nItensComprados, vItensComprados,nLista:String);
    procedure VendasTotaisporlista1Click(Sender: TObject);
    procedure impressaoRave(ds: TADOQuery; nRelatorio:String; params:Tstringlist );
    procedure BaixaAvulsa1Click(Sender: TObject);
    function GetParamBD(nParametro,loja:String):String;
    procedure FormResize(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Geracaodecrdito1Click(Sender: TObject);
    procedure ConexaoWellWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType; var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure renomarArquivoUpgrade();
    procedure FormActivate(Sender: TObject);
private
    { Private declarations }
  public
     acao:integer;
     function MsgTela(Msg:string;iconeBotao:integer):integer;

    { Public declarations }
  end;
var
  Form1: TForm1;
  PATH:ansiString;
  TITULO:ansiString;
  ARQ_DE_IMPRESSAO:ansiString;
  VERSAO:AnsiString;
implementation

uses unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9, uBaixaAvulsa;

{$R *.dfm}

procedure TForm1.renomarArquivoUpgrade();
  var
     acao:boolean;
  begin
     acao := ( FileExists( extractFilePath(paramStr(0)) + 'ListaNovo.exe') = true );
     Funcoes.gravaLog('nova versão do lancador?: ' + BoolToStr(acao, true) );
     if (acao = true) then
     begin
        Funcoes.gravaLog('Atualização do lancador:' );
        acao := deleteFile(pChar(extractFilePath(paramStr(0)) + 'Lista.exe'));
        Funcoes.gravaLog('Deletar arquivo lancador: ' + boolToStr(acao, true) );
        acao := renameFile( extractFilePath(paramStr(0)) + 'ListaNovo.exe',  extractFilePath(paramStr(0)) + 'Lista.exe' );
        Funcoes.gravaLog('Renomear o ListaNovo.exe para Lista.exe : ' + boolToStr(acao, true) );
     end;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   funcoes.limparLog();

   VERSAO := '11.07.05';

   if haParametroInvalido(sender) = true then
   begin
      MsgTela( ' Exitem parâmetros não preenchidos '+#13+ ' Execute o configurador (ConfigListas.exe) e informe os parâmetros',MB_Ok+ MB_IconError);
      application.terminate;
   end;
   adoconnection1.Connected := false;
   adoconnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ funcoes.RParReg('listas','DBPassWord')  +';Persist Security Info=True;User ID='+ funcoes.RParReg('listas','DBUserName') +';Initial Catalog='  +funcoes.RParReg('listas','DBName') +' ;Data Source='+funcoes.RParReg('listas','IPServer')+ ';Workstation ID='+ funcoes.GetNomeDoMicro();
   query1.Connection := ADOConnection1;
   try
     adoconnection1.Connected := true;
   except
      on e:Exception do
      begin
         msgTela('Não posso conectar ao BD, verifique as configurações e tente novamente' +#13+ 'Erro '+e.message,mb_IconError+Mb_OK);
         application.terminate;
      end;
   end;

   if  shortDateFormat <> 'dd/MM/yyyy'  then
   begin
      MsgTela( 'ATENÇÃO!!!!'+#13+'A data está em formato diferente ( o correto é  dd/MM/aaaa ) e não posso continuar.'+#13+'Consulte o suporte para corrigir esse problema',MB_OK+MB_ICONERROR);
      application.Terminate
   end;
   PATH   := ExtractFilePath(ParamStr(0));
   TITULO := VERSAO  + ' Gerenciador de listas - Versão: ' ;
   ARQ_DE_IMPRESSAO := PATH + 'EspelhoLista.txt';

   form1.top := -1;
   form1.caption := TITULO + ' - '+ RParReg('IpServer') + ' - '+ RParReg('DbName');

   sb.Panels[1].Text :=  'Loja - '+RParReg('Loja');

   funcoes.WParReg('listas','versao',VERSAO);
   if RParReg('loja') <> '00' then
      mainmenu1.Items[2].Visible := false;

   dp1.Date := now;
   dp2.Date := now + 60;
   cb1.ItemIndex := StrToint(form1.RParReg('MostraListas'));
   cb1Change(Sender);
   deleteFile(funcoes.TempDir()+'_log_ListaCasamento.txt');
   funcoes.carregaCampos(form1);
   conexaoWell.ConnectionString := 'Provider=SQLOLEDB.1;Password='+form1.RParReg('PassWordWell')  +';Persist Security Info=True;User ID='+ form1.RParReg('UserNameWell') +';Initial Catalog='+form1.RParReg('DBNameWell')+';Data Source='+ form1.RParReg('IpServerWell');
end;

function TForm1.WParReg(NomeParam,valor: String): boolean;
begin
  funcoes.WParReg('listas',NomeParam,valor);
  result:=true;
end;

function TForm1.RParReg(NomeParam: String): string;
begin
   result := Funcoes.RParReg('listas',NomeParam);
end;

function tform1.HaParametroInvalido(sender:Tobject):boolean;
var
  par:Tstringlist;
  i:integer;
begin
  par := Tstringlist.Create();
  par.add('Versao');  par.add('Loja');  par.add('PortaImp');
  par.add('TitRel');    par.add('MostraErros');  par.add('HostFTP');   par.add('User');
  par.add('TipoImp');      par.add('IPServer');  par.add('DBName');

  for i:=0 to par.count-1 do
     if funcoes.RParReg('listas',par[i]) = '' then
     begin
        msgtela('Falta o parâmetro: ' + par[i], mb_Ok + MB_iconError);
        result := true;
        PAR.Destroy;
        break;
     end;
end;
 
function TForm1.EhlistaDaloja(num:string;MostraMensagem:boolean): boolean;
begin
   if (num = funcoes.RParReg('listas','loja') ) or ( funcoes.RParReg('listas','loja') = '00' )  then
      EhlistaDaloja := true
   else
   begin
      if MostraMensagem = true then
         form1.MsgTela('Você não pode trabalhar com os dados desta lista, pois ela pertence à loja '+ funcoes.preencheCampo(02,'0','e', num) +'.'  , mb_iconerror + mb_ok);
      EhlistaDaloja := false;
   end;
end;

function TForm1.MsgTela(Msg: string; iconeBotao: integer): integer;
begin
   result := application.MessageBox(pchar(msg),pchar(TITULO), iconeBotao );
end;
procedure TForm1.CadastrodeListas1Click(Sender: TObject);
begin
   form1.EscondeMenu(sender);
   Application.CreateForm(TForm2, Form2);
   form2.show;
end;

procedure TForm1.iposdeProdutos1Click(Sender: TObject);
begin
   form1.EscondeMenu(sender);
   Application.CreateForm(TForm5, Form5);
   form5.show;
end;


procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor := crhourGlass;
   funcoes.gravaLog(CommandText);
end;

procedure TForm1.ADOConnection1ExecuteComplete(Connection: TADOConnection;RecordsAffected: Integer; const Error: Error;var EventStatus: TEventStatus; const Command: _Command;const Recordset: _Recordset);
begin
   screen.Cursor := crdefault;
end;

procedure TForm1.AbreFormPesquisa(sender: tobject; Act: integer);
begin
   acao := act;
   Application.CreateForm(TForm4, Form4);
   form4.Show;
end;

procedure TForm1.verLogClick(Sender: TObject);
begin
   winexec(pchar('notepad ' +PATH+ 'ErrorLog.txt'),sw_normal)
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
   funcoes.gravaLog(' Erro : ' +  DateToStr(now)+' Loja:'+ funcoes.RParReg('listas','loja') +' '+ timetostr(now) +' '+ e.ClassName + '  '+ e.Message);
   if UpperCase(RParReg('mostraErros')) = 'S' then
      form1.MsgTela('    Ocorreu um erro no programa   '+#13+'    Se ele persisitir contate o suporte'+#13+ '    O erro foi: '+#13+#13+e.Message,mb_ok+mb_iconerror)
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   deletefile( path +'listacasamento.cfg' );
   deletefile( path +'espelholista.txt' );
   deleteFile(funcoes.TempDir()+'Querys_ListaCasamento.txt');

   funcoes.salvaCampos(form1);
end;

procedure TForm1.mxOneInstance1InstanceExists(Sender: TObject);
begin
   form1.MsgTela(#13 + ' Este programa já está sendo executado !!',mb_iconerror + mb_ok);
   application.terminate;
end;

procedure TForm1.EscondeMenu(sender: tobject);
begin
   panel1.visible := false;
   form1.Menu := nil;
end;

procedure TForm1.mostraMenu(sender: tobject);
begin
   form1.Menu := mainmenu1;
   panel1.visible := true;
   form1.sb.Panels[0].text :='';
   form1.cb1.Items.Clear;
   form1.cb1.Items.Add('- Todas');
   form1.cb1.Items.Add('- Período');
   form1.cb1.ItemIndex :=  StrToint(form1.RParReg('MostraListas'));
   cb1Change(Sender);
end;

procedure TForm1.ProdutosnNasListas1Click(Sender: TObject);
begin
   form1.EscondeMenu(sender);
   form1.Menu := mainmenu1;
   Application.CreateForm(TForm3, Form3);
   form3.show;
end;

procedure TForm1.sugestodeProdutos1Click(Sender: TObject);
begin
   form1.EscondeMenu(sender);
   Application.CreateForm(TForm6, Form6);
   form6.show;
end;

procedure TForm1.iposdelistas1Click(Sender: TObject);
begin
   form1.EscondeMenu(sender);
   Application.CreateForm(TForm7, Form7);
   form7.show;
end;

procedure TForm1.Query1DeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
   msgTela(' - Não é possivel executar a operação. O erro é: ' +#13+#13+ e.Message, mb_iconerror+mb_ok  );
end;

function TForm1.GetTiposListas(MostrarTodas:boolean; tiposPListar:String): Tstrings;
var
   r2:Tstringlist;
   query:Tadoquery;
begin
   query := Tadoquery.Create(nil);
   query.Connection := ADOConnection1;

   query.sql.Clear;
   query.sql.add('select descricao, CodLista from tipolistas where codLista > -1 order by descricao');
   query.Open;
   R2 := Tstringlist.Create;
   if MostrarTodas = true then
      r2.Add('TODAS');
   query.First;
   while query.Eof = false do
   begin
      r2.Add(  funcoes.preencheCampo(41,' ','D', query.Fields[0].AsString)+query.Fields[1].AsString) ;
      query.Next;
   end;
   GetTiposListas :=r2;
   query.SQL.Clear;
   query.Destroy;
end;

procedure TForm1.SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
    funcoes.WParReg('listas','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
end;

procedure Tform1.LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount -1 do
   begin
      dbgrid.Columns[i].Title.Font.name := 'MS Sans Serif';
      dbgrid.Columns[i].Title.Font.Style := [fsbold];
      if funcoes.RParReg('listas','Z_' +NomeForm+ '_'+ IntToStr(i) ) <> '' then
         dbgrid.Columns[i].width := StrToint( funcoes.RParReg('listas','Z_' +NomeForm+ '_'+ IntToStr(i))  );
   end;
end;

procedure TForm1.AbrirLista(sender: tobject; num: string);
begin
   form2.Close;
   form1.ProdutosnNasListas1Click(Sender);
   form3.chamaCarregamentoDeLista( num);
end;

function TForm1.GetNumLojas(sender: tobject; Loja:String): Tstrings;
begin
   result := funcsql.getListagem(' Exec stoObterNumLojas ' + quotedStr(loja), ADOConnection1);
end;

procedure TForm1.Query1AfterOpen(DataSet: TDataSet);
begin
   form1.sb.Panels[0].text := inttoStr(form1.query1.RecordCount) + ' Item(s).';
end;

procedure TForm1.Configurao1Click(Sender: TObject);
begin
   winexec(pchar(Path + 'ConfigListas.exe'),sw_normal);
   application.terminate;
end;

procedure TForm1.ProdutosCompradosporpeodo1Click(Sender: TObject);
begin
  form1.EscondeMenu(sender);
  Application.CreateForm(TForm9, Form9);
  Form9.show;
end;

function TForm1.InVencLista(): string;
begin
   if cb1.ItemIndex <> 0 then
      InVencLista := funcoes.StrToSqlDate(DateToStr(form1.dp1.date))
   else
      InVencLista := quotedStr('01/01/2000');
end;

function TForm1.FimVencLista(): string;
begin
   if cb1.ItemIndex <> 0 then
      FimVencLista := funcoes.StrToSqlDate( DateToStr(form1.dp2.date))
   else
      FimVencLista := quotedStr('12/31/2029');
end;

procedure TForm1.cb1Change(Sender: TObject);
begin
   if cb1.ItemIndex = 0 then
      groupbox1.Visible := false
   else
   begin
      groupbox1.Visible := true;
      dp1.Date :=  strToDate('01/' + copy(dateToStr(now),04,07));
   end;
   funcoes.WParReg('listas','MostraListas',IntToStr(cb1.itemIndex) );
end;

procedure TForm1.dp1Change(Sender: TObject);
begin
   if dp1.DateTime > dp2.DateTime then
      dp2.DateTime := dp1.DateTime;
end;
procedure TForm1.dp2Change(Sender: TObject);
begin
   if dp1.DateTime > dp2.DateTime then
      dp1.DateTime := dp2.DateTime;
end;

function tform1.PosicaoBotoes(form:Tform):integer;
var
  i:integer;
begin
   for i := 0 to form.ComponentCount - 1 do
      if form.Components[i] is TflatButton then
         TflatButton(form.Components[i]).left := form.Width - TflatButton(form.Components[i]).Width - 10;
   result:=0
end;

procedure TForm1.salvacomandosprograma(cmd: String);
begin
   cmd :=  dateTimeToStr(now) +#13+cmd+#13 + '  ';
   funcoes.GravaLinhaEmUmArquivo(funcoes.TempDir()+'_log_ListaCasamento.txt',cmd);
end;

procedure tform1.atualizaDadosItensLista(nItens, nItensComprados, vItensComprados, nLista:String);
begin
   funcSQL.execSQL( ' Update listas set qtItens = ' + nItens  +' , ' +
                    'qtItensComprados = ' +  nItensComprados  +' , ' +
                    'vlItensComprados = ' +  vItensCOmprados  +
                    ' where numLista = '  + nLista,
                    form1.ADOConnection1
                    );
end;
procedure TForm1.VendasTotaisporlista1Click(Sender: TObject);
begin
  Application.CreateForm(TForm8, Form8);
  form8.Show;
end;

procedure tform1.impressaoRave(ds: TADOQuery; nRelatorio:String; params:Tstringlist );
var
  i:integer;
begin
   if params <> nil then
      for i:=0 to params.Count-1 do
         RvProject1.SetParam(intToStr(i), params[i]);

   RvDSConn.DataSet := ds;
   RvProject1.ExecuteReport(nRelatorio);
end;

procedure TForm1.Baixaavulsa1Click(Sender: TObject);
begin
   if  fmBaixaAvulsa = nil then
   begin
      form1.EscondeMenu(sender);
      Application.CreateForm(TfmBaixaAvulsa, fmBaixaAvulsa);
      fmBaixaAvulsa.Show();
   end;
end;

function TForm1.GetParamBD(nParametro, loja: String):String;
var
   cmd:String;
begin
   cmd := 'Select valor from configuracoes where param = ' + quotedStr(nParametro);
   if (loja <> '') then
      cmd := cmd + ' and loja = ' + quotedStr(loja);

   cmd := funcsql.openSQL(cmd, 'valor' ,  ADOConnection1);
   funcoes.gravaLog(' funcao GetParamBD() nParametro: ' + nParametro + ' loja ' + loja + 'result<' + cmd +'>' ) ;
   result := cmd;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   Panel1.Left := form1.Width - panel1.Width-30;

end;

procedure TForm1.N1Click(Sender: TObject);
begin
    menu.Items[2].Visible := not(menu.Items[2].Visible);
end;

procedure TForm1.Geracaodecrdito1Click(Sender: TObject);
var
  usr:String;
begin
   if form1.GetParamBD('GeraCredCompra', form1.RParReg('loja')) = '1' then
   begin
      usr := verificaSenhas.TelaAutorizacao2( form1.ConexaoWell,'13',  form1.GetParamBD('usrAutCredito', form1.RParReg('loja') )  );
      if usr <> '' then
      begin
         VendasTotaisporlista1Click(nil);
         form8.preparaTelaCredito(nil, usr );
      end
   end
   else
      msgTela('Essa loja não acessa essa transação', MB_OK + MB_ICONERROR );
end;

procedure TForm1.ConexaoWellWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.gravalog(CommandText);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   renomarArquivoUpgrade();
end;

end.
