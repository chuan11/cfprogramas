// Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;User ID=secrel;Initial Catalog=WellCfreitas;Data Source=125.0.0.200;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=CPD-PC;Use Encryption for Data=False;Tag with column collation when possible=False
unit uMain;

interface

uses
  qforms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, ComCtrls, funcoes, funcsql, verificaSenhas,
  StdCtrls, Buttons, fCtrls, mxOneInstance, uEmail, ExtCtrls, TFlatEditUnit,
  TFlatButtonUnit,  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave,
  ImgList, ugetNotas, UAlteraForPedido, Grids, DBGrids, SoftDBGrid, Typinfo,
  IdTCPConnection, Sockets, ScktComp, DBCtrls,
  AppEvnts, RpRender, RpRenderPDF, RpRenderCanvas, RpRenderPrinter,
  OleCtrls, AcroPDFLib_TLB, shellAPI, adLabelCheckListBox, IdBaseComponent,
  IdComponent, IdTCPClient, IdTelnet, adLabelComboBox;


type
  TfmMain = class(TForm)
    menuPrincipal: TMainMenu;
    Estoques1: TMenuItem;
    ConsultaaRequisies1: TMenuItem;
    Preos1: TMenuItem;
    abeladePreos1: TMenuItem;
    Consultaarequisies2: TMenuItem;
    Precosalteradosporperodo1: TMenuItem;
    Fiscal1: TMenuItem;
    Conexao: TADOConnection;
    Vendas1: TMenuItem;
    Funcoes1: TMenuItem;
    Propostasdaloja1: TMenuItem;
    StatusBar1: TStatusBar;
    Requisicoentreloas1: TMenuItem;
    rocardeUsuario1: TMenuItem;
    Requisicaoparaocd1: TMenuItem;
    mxOneInstance1: TmxOneInstance;
    Cadastrodeavarias1: TMenuItem;
    Relatorios1: TMenuItem;
    Relacaodenotasdetransferncia1: TMenuItem;
    Mapadeseparao1: TMenuItem;
    abeladePreos2: TMenuItem;
    Precosalteradosporperodo2: TMenuItem;
    Descontodepedido1: TMenuItem;
    AjustedePrecos1: TMenuItem;
    Relatorios2: TMenuItem;
    AnaliseVLC1: TMenuItem;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvDSConn: TRvDataSetConnection;
    Etiquetas1: TMenuItem;
    EtiquetasDeClientes1: TMenuItem;
    Geracaopreodecusto1: TMenuItem;
    N1: TMenuItem;
    RelatriodeComisso1: TMenuItem;
    Funcoes2: TMenuItem;
    Comporavendafiscal1: TMenuItem;
    Ajustedenotas1: TMenuItem;
    Analisedeestoque1: TMenuItem;
    Requisiodereposio1: TMenuItem;
    RequisioparaoCDAbastecimento1: TMenuItem;
    ConsultaarequisioCDporproduto1: TMenuItem;
    compras1: TMenuItem;
    Alterafornpedidodecompra1: TMenuItem;
    Classificaodepro1: TMenuItem;
    RvDSConn2: TRvDataSetConnection;
    Cadastrarcodigodebarrasdeproduto1: TMenuItem;
    DeletarRegistrodecartoTEF1: TMenuItem;
    CadastrarNCM1: TMenuItem;
    administrao1: TMenuItem;
    RemovevendasregistroTEF1: TMenuItem;
    Permisses1: TMenuItem;
    Fornecedoresaignorarnarequisio1: TMenuItem;
    Mudafinanceiradeboleto1: TMenuItem;
    MudaversodoBD1: TMenuItem;
    Fichasdefornecedorpordata1: TMenuItem;
    parmetrosdosistema1: TMenuItem;
    AjustedoarquivoSPED1: TMenuItem;
    Timer1: TTimer;
    Listarcustodeitensporpedido1: TMenuItem;
    EnviarXML1: TMenuItem;
    ImprimirNFe1: TMenuItem;
    RvRenderPDF1: TRvRenderPDF;
    Saldofiscalpormes1: TMenuItem;
    EnviarespelhoPDFdeNFeparaemail1: TMenuItem;
    Pagamentosemcarto1: TMenuItem;
    Cargadedadosparaconciliao1: TMenuItem;
    ImprimirDANFE1: TMenuItem;
    RegistroSCAN1: TMenuItem;
    RvDSConn3: TRvDataSetConnection;
    RvDSConn4: TRvDataSetConnection;
    Geraestoque1: TMenuItem;
    Processarinventrio1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Produtostransferidos1: TMenuItem;

    function isTelaRequerSenha( codTela:smallInt ):boolean;

    function ehCampoPermitido(nParam:String): Boolean;
    function ehTelaPermitida(tag:string;  Telas:Tstrings):Boolean;
    function executeTelnetCmd(uo, comando:String):boolean;
    function getCdPesLogado():String;
    function getCdRef(str:String):String;
    function getCodPreco(cb:TCustomComboBox): String;
    function getDescUO(cb:TCustomComboBox):String;
    function getDescPreco(cb:TCustomComboBox):String;
    function getGrupoLogado():String;
    function getNomeLojaLogada():String;
    function getNomeUsuario():String;
    function getUoLogada():String;
    function getUOCD():String;
    function getUserLogado:String;
    function getParamBD(nParametro, loja: String):String;
    function isGrupoPermitido(codTela: integer):boolean;
    function isPermiteAbrirTela( codTela:smallInt ): boolean;
    function setParamBD(nParametro, loja, valor: String):boolean;
    function telaAutWell(Grupos,cd_usu:string ):String;
    procedure abeladePreos2Click(Sender: TObject);
    procedure abreFormRequisicao(mostraMsg:Boolean; perfil:integer);
    procedure Ajustedenotas1Click(Sender: TObject);
    procedure AjustedePrecos1Click(Sender: TObject);
    procedure Alterafornpedidodecompra1Click(Sender: TObject);
    procedure Analisedeestoque1Click(Sender: TObject);
    procedure AnaliseVLC1Click(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure Cadastrarcodigodebarrasdeproduto1Click(Sender: TObject);
    procedure Cadastrodeavarias1Click(Sender: TObject);
    procedure Calculodeextranota1Click(Sender: TObject);
    procedure chamaImpressaoRave( nRelatorio:String; params:Tstrings);
    procedure Classificaodepro1Click(Sender: TObject);
    procedure Comporavendafiscal1Click(Sender: TObject);
    procedure ConexaoExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
    procedure ConexaoWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType; var LockType: TADOLockType; var CommandType: TCommandType;     var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure Consultaarequisies2Click(Sender: TObject);
    procedure ConsultaarequisioCDporproduto1Click(Sender: TObject);
    procedure consultaRequisicaoPorProduto(Sender:Tobject; str: String);
    procedure Descontodepedido1Click(Sender: TObject);
    procedure EnviarEmail(para, assunto, anexo:String; corpoMsg:Tstringlist; titulo:String);
    procedure Etiquetas1Click(Sender: TObject);
    procedure EtiquetasDeClientes1Click(Sender: TObject);
    procedure fecharForm(form:Tform; var Action:TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Fornecedoreacriticar1Click(Sender: TObject);
    procedure Geracaopreodecusto1Click(Sender: TObject);
    procedure getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario: String);
    procedure getTelasPermDoGrupo(grupo:String);
    procedure impressaoRave(tb:TADOTable; nRelatorio:String; params:Tstrings);
    procedure impressaoRaveQr(qr:TADOQuery; nRelatorio:String; params:Tstrings);
    procedure impressaoRaveQr2(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings);
    procedure impressaoRaveQr4(qr, qr2, qr3, qr4:TDataSet; nRelatorio:String; params:Tstrings);
    procedure impressaoRaveTbQr(tb: TADOTable; qr:TADOQuery; nRelatorio:String; params:Tstrings);
    procedure impressaoRavePDF(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings;nmArquivo:String);
    procedure imprimirDANFE1Click(Sender:Tobject);
    procedure mapadeseparao1Click(Sender: TObject);
    procedure montarMenu(nomeloja, nomeUsuario, is_uo, is_usu:string);
    procedure mostraDetalhesNota(Sender:Tobject; is_nota:String);
    procedure msgStatus(msg:String);
    procedure mudarfinanceiradeboleto1Click(Sender: TObject);
    procedure n1Click(Sender: TObject);
    procedure obterDetalhesEntrada(is_ref:String);
    procedure obterDetalhesSaida(is_ref, uo:String; dtInicio:Tdate);
    procedure obterResumoEstoque(is_ref, is_disponivel:String);
    procedure obterResumoEntSai(isref:String);
    procedure parmetrosDoSistema1Click(Sender: TObject);
    procedure permisses2Click(Sender: TObject);
    procedure precosalteradosporperodo2Click(Sender: TObject);
    procedure propostasdaloja1Click(Sender: TObject);
    procedure relacaodenotasdetransferncia1Click(Sender: TObject);
    procedure relatriodeComisso1Click(Sender: TObject);
    procedure requisicaoparaocd1Click(Sender: TObject);
    procedure requisicoEntreLoas1Click(Sender: TObject);
    procedure getRequisicoesPorProduto(cd_ref:String);
    procedure requisiodereposio1Click(Sender: TObject);
    procedure requisioParaoCDAbastecimento1Click(Sender: TObject);
    procedure resunmoMovimentodirio1Click(Sender: TObject);
    procedure rocardeUsuario1Click(Sender: TObject);
    procedure setaAversoNobd1Click(Sender: TObject);
    procedure showGridCol(grid:TSoftDBGrid;qr:TdataSet;col:String;is_visible:Boolean);
    procedure timer1Timer(Sender: TObject);
    procedure verificaPermissao(item:TmenuItem { ; telas: Tstrings });
    procedure compromissosdefornecedorespordata1Click(Sender: TObject);
    procedure CadastrarNCM1Click(Sender: TObject);
    procedure ajustedoarquivoSPED1Click(Sender: TObject);
    procedure listarcustodeitensporpedido1Click(Sender: TObject);
    procedure applicationEvents1Exception(Sender: TObject; E: Exception);
    procedure enviarXML1Click(Sender: TObject);
    procedure exportaXMLNota(is_nota:String);
    procedure tnDataAvailable(Sender: TIdTelnet; const Buffer: String);
    procedure getParametrosForm(form:Tform);
    procedure ImprimirNFe1Click(Sender: TObject);
    function  getPDFNFe(isNota:String):String;
    procedure saldofiscalpormes1Click(Sender: TObject);
    procedure enviarespelhoPDFdeNFeparaemail1Click(Sender: TObject);
    procedure pagamentosEmCartao1Click(Sender: TObject);
    procedure cargadedadosparaconciliao1Click(Sender: TObject);
    procedure deletarRegistrodecartoTEF1Click(Sender: TObject);
    procedure RegistroSCAN1Click(Sender: TObject);
    procedure setaLojaLogadaNoComboBox(cb:TadLabelComboBox);
    procedure Geraestoque1Click(Sender: TObject);
    procedure Processarinventrio1Click(Sender: TObject);
    procedure Produtostransferidos1Click(Sender: TObject);
  private
    { Private declarations }
    DS_PERMISSOES:TdataSet;
  public
     is_logado:boolean;

     PARAMS_APLICACAO: TStringList;

    { Public declarations }
  end;
CONST
   VERSAO = '11.07.01';
   SUB_VERSAO = ' ';
   MSG_ERRO_TIT = '  Corrija antes os seguintes erros: ' +#13;
   MSG_DATA1_MAIORQ_DATA2 = ' - A data final não pode ser maior que a inicial.' + #13;
   MSG_DATA1_MENORQ_DATA2 = ' - A data final não pode ser menor que a inicial.' + #13;
   MSG_PER_MQ_31D = ' - Período maior que 31 dias.'+ #13;
   MSG_FALTA_LOJA =  ' - Escolha uma loja. ' + #13;
   MSG_SEM_DADOS  = ' Não existem dados para essa consulta...';
   MSG_ERRO_CH_NFE = 'Não existe chave de acesso para essa nota, ou ela não é eltrônica.';
var
  fmMain: TfmMain;
  TIME_OUT_PROGRAMA_DEFAULT, TIME_OUT_PROGRAMA:integer;

  RESP_TELNET:String;

implementation

uses uConReqDep, urequisicao, ufornACriticar, uPermissoes, uLogin, uTabela, upcoAlteradoPorPeriodo,
     uOsDeposito, uAvarias, uPropostaLoja, uMapa, uDetEntrada, uTotalSaidas, uEnviaEmail,
     uprecoswell, uDescPedido, uAnaliseVenda, uEtiquetas, unNotasTransfrencia, uResumoEstoque,
     uPrecosCusto, uAlteraFinanceira, uDetalhesNotas, uRelatorioComissao, uComporEstoque,
     unClientes, uAjustaNota, uAnaliseEstoque, uConReqProd, uCalcEN, uRelGeral, unMovDiario,
     uClassificaProd, uCompFornecedor, fmAbrirAvarias, uParametros,
     uRemoveRegTEF, uCadastrarNCM, uListaFornecedores, uAjustaSPED,
     uCustoPorPedido, uCF, Math, funcDatas, uObterSaldoFiscal,
  uAjusteModPag, uGeraEstoque, uEentSai, uRelInventario;
{$R *.dfm}


function TfmMain.isGrupoPermitido(codTela: integer): boolean;
var
   aux:boolean;
begin
   DS_PERMISSOES.Locate('codTela', intToStr(codTela),[]);
   aux := (DS_PERMISSOES.FieldByName('isAcessoRestrito').AsString <> '1') ;
   funcoes.gravaLog('funcao isGrupoPermitido(), cod tela:'+ intToStr(codTela)+ ' result: '+ BoolToStr(aux,true));
   result := aux;
end;

procedure TfmMain.getTelasPermDoGrupo(grupo:String);
begin
   DS_PERMISSOES := funcSQl.getDataSetQ('Select distinct codTela, isAcessoRestrito, isPedeAutorizacao from zcf_telasPermitidas where grupo = ' + grupo + ' order by codTela' , conexao);
end;

function TfmMain.isTelaRequerSenha( codTela:smallInt ):boolean;
begin
   DS_PERMISSOES.Locate('codTela', intToStr(codTela),[]);
   gravaLog( 'getTelasPermDoGrupo()' +    boolToStr((DS_PERMISSOES.FieldByName('isPedeAutorizacao').asString = '1') , true) );
   result := (DS_PERMISSOES.FieldByName('isPedeAutorizacao').asString = '1');
end;

function TfmMain.isPermiteAbrirTela( codTela:smallInt ): boolean;
begin
   if (isTelaRequerSenha(codTela) = true) then
      result := (verificaSenhas.TelaAutorizacao2( fmMain.Conexao, ucf.getAutorizadoresPorTela(codTela, fmMain.getGrupoLogado()), '' ) <> '')
   else
      result := true;
end;

procedure TfmMain.verificaPermissao(item:TmenuItem {; telas: Tstrings });
var
   i:integer;
begin
   if (item.Count > 0) then
   begin
      for i:=0 to item.Count -1 do
         verificaPermissao(item.Items[i]{, telas});
    end
    else
    begin
       if (DS_PERMISSOES.Locate('codTela', intToStr(item.tag),[]) = true) or (item.tag = 0) then
          item.Visible := true
       else
          item.Visible := false;
    end;
end;

procedure TfmMain.montarMenu(nomeloja, nomeUsuario, is_uo, is_usu:string);
var
  i:integer;
begin
   fmMain.Menu := menuPrincipal;

   if (is_uo <> '-1') then
   begin
      PARAMS_APLICACAO.Values['IS_UO'] := is_uo;
      PARAMS_APLICACAO.Values['CD_USU'] := is_usu;

      PARAMS_APLICACAO.Values['cd_pes'] := funcSQl.GetValorWell( 'O','select cd_pes from dsusu with(nolock)where cd_usu = '+ getUserLogado(),'cd_pes', Conexao);
      PARAMS_APLICACAO.Values['CD_GRUSU'] :=  funcSQl.GetValorWell( 'O','select cd_grusu from dsusu with(nolock)where cd_usu = '+ getUserLogado(),'cd_grusu', Conexao);
      PARAMS_APLICACAO.Values['uocd'] :=  fmMain.getParamBD('uocd','');

      StatusBar1.Panels[0].Text := nomeloja;
      StatusBar1.Panels[1].Text := nomeUsuario;

      getTelasPermDoGrupo(getGrupoLogado() );
    end;

   for i:=0 to fmMain.Menu.Items.Count -1 do
   begin
      verificaPermissao(fmMain.Menu.Items[i]);
   end;
end;


procedure TfmMain.FormActivate(Sender: TObject);
var
   versao_BD:String;
begin
   fmMain.Caption := VERSAO + SUB_VERSAO + ' - Programas da loja.  ';

// monta o menu com todas as opcoes quando estiver desenvolvendo
   if ExisteParametro('-nl') then
   begin
      fmMain.WindowState := wsNormal;
      is_logado := true;
      montarMenu('Matriz', 'walter', '10033674','10000592');

//   montar menu na freitas
//        montarMenu('Matriz', 'walter', '10001008','10001593');

      fmMain.Width := 900;
      fmMain.Height := 700;
      fmMain.Left := 100;
      fmMain.top := 10;
   end;

   if (is_logado = false) then
   begin
      fmMain.Menu := nil;
      versao_BD := GetParamBD('comum.versao','');
      if (VERSAO <> versao_BD ) and (versao_BD <> '') then
      begin
         msgTela('', '   A versão do programa é diferente do banco de dados, '+#13+
                     'isso pode resultar em erros na execução do programa.' +#13+
                     '  Entre em contato com o T.I. ' +#13+#13+
                     '  Versão do BD:       ' + versao_BD    +#13+
                     '  Versão do programa: ' + VERSAO ,
                      MB_OK + MB_ICONERROR
                );
         Application.Terminate();
      end
      else
      begin
         is_logado := true;
         Application.CreateForm(TfmLogin, fmLogin);
         fmLogin.Show();
         fmLogin.Caption := 'Login';
      end;
   end;
end;

function TFmMain.getParamBD(nParametro, loja: String):String;
var
  str:String;
begin
  str := funcSQl.getParamBD(nParametro,loja, Conexao);
  funcoes.gravaLog('Lendo parametro: ' + nParametro + ' loja: ' + loja +' Resultado: '+ str );
  result := str;
end;

function TFmMain.setParamBD(nParametro, loja, valor: String):boolean;
begin
   funcoes.gravaLog('Gravando parametro: ' + nParametro + ' loja: ' + loja );
   result := funcSql.setParamBD(nParametro, loja, valor, Conexao);
end;

procedure TfmMain.appException(Sender: TObject; E: Exception);
var
   str:String;
begin
   msgTela('', 'Erro:'+#13+e.Message, 0);
   str:=  dateTimeTostr(now)+ ' '+ fmMain.getUoLogada() +   ' Usuario: ' + fmMain.getCdPesLogado() +#13+ e.Message;
   funcoes.gravaLog('Erro - Loja: ' + fmMain.getUoLogada() +'  usuario: '+ fmMain.getUserLogado()  + ' ' + e.Message );
end;

procedure TfmMain.ConsultaARequisies2Click(Sender: TObject);
begin
   if  fmConReqDep = nil then
   begin
      Application.CreateForm(TfmConReqDep, fmConReqDep);
      fmConReqDep.show;
   end;
end;

procedure TfmMain.rocarDeUsuario1Click(Sender: TObject);
var
  i:integer;
  aux:String;
  erro:Boolean;
  telas:String;
begin
   erro := false;
   for i:=0 to Application.ComponentCount -1 do
   begin
      aux := application.Components[i].ClassType.ClassName;
      if (pos('Tfm',aux) > 0) and ( aux <> 'TfmMain') then
      begin
         erro := true;
         telas := telas + ' '+ aux;
      end;
   end;

   if (erro  = true) then
       msgTela('',' Feche as telas do programa antes de trocar de usuario. '+#13+'Telas : '+telas,MB_ICONERROR+ mb_ok)
   else
   begin
      Application.CreateForm(TfmLogin, fmLogin);
      fmlogin.Show;
      fmLogin.Caption := 'Mudar a loja ou usuário';
   end;
end;

procedure TfmMain.Requisicoentreloas1Click(Sender: TObject);
begin
   if fmReqLojas = nil then
   begin
      Application.CreateForm(TfmReqLojas, fmReqLojas);
      fmReqLojas.Show
   end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// verifica se ha uma nova versao do programa de upgrade e substitui o antigo.
   funcoes.renomearArquivoUpgrade('UpgradeNovo.exe', 'upgrade.exe');
   Conexao.Close();
   application.Terminate();
end;

procedure TfmMain.ConexaoExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   Screen.cursor := crDefault;
   timer1.enabled := true;
end;

procedure TfmMain.ConexaoWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   Screen.cursor := crHourGlass;
   funcoes.gravaLog(CommandText);
   timer1.enabled := false;
   TIME_OUT_PROGRAMA_DEFAULT := 180;
   TIME_OUT_PROGRAMA :=  TIME_OUT_PROGRAMA_DEFAULT;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   try
      if (fileexists(funcoes.getDirExe()+ 'CF.ico') = true) then
         Application.Icon.LoadFromFile(funcoes.getDirExe()+ 'CF.ico')
       else
         funcoes.gravaLog('Não acjei o arquivo de icone da aplicação');

      conexao.Connected := false;
      conexao.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
      conexao.Connected := true;
      StatusBar1.Panels[2].Text := conexao.DefaultDatabase + ' ' + funcoes.lerParam( extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini', 3  );
      deleteFile( ExtractFilePath(paramStr(0)) +'logs\' + ExtractFilename(ParamStr(0))  + '_log.txt'  );

      PARAMS_APLICACAO := TStringlist.Create();
      RvProject1.ProjectFile := 'C:\ProgramasDiversos\RelatoriosPCF.rav';
   except
      on e:Exception do
      begin
         funcoes.msgTela('','Não foi possivel efetuar a conexão com o banco de dados!', MB_ICONEXCLAMATION + MB_ICONERROR);
         application.Terminate();
      end;
   end;
end;

function TfmMain.ehTelaPermitida(tag:string;  Telas:Tstrings): Boolean;
var
   i:integer;
   achou:boolean;
begin
   achou := false;
   for i:=0 to telas.Count-1 do
   begin
      if (tag = telas[i]) or ( telas[0] = '-1') then
         begin
            achou := true;
            break;
         end;
   end;
   result := achou;
end;

procedure TfmMain.msgStatus(msg: String);
begin
    fmMain.StatusBar1.Panels[3].Text := msg;
    funcoes.gravaLog('msgStatus: '+ msg);
    fmMain.StatusBar1.Refresh;
    fmMain.Refresh();
end;


procedure TfmMain.Fornecedoreacriticar1Click(Sender: TObject);
begin
   if fmFornACriticar = nil then
   begin
      Application.CreateForm(TfmFornACriticar, fmFornACriticar);
      fmFornACriticar.Show
   end;
end;

procedure TfmMain.Permisses2Click(Sender: TObject);
begin
   if  fmPermissoes = nil then
   begin
      Application.CreateForm(TfmPermissoes, fmPermissoes);
      fmPermissoes.Show;
   end;
end;

procedure TfmMain.abreFormRequisicao(mostraMsg: Boolean;perfil:integer);
var
   uoCD:String;
begin
   uoCD := fmMain.GetParamBD('uocd','');

   if (fmOsDeposito = nil) then
   begin
      if  (getUoLogada() = uoCD ) and ( perfil <> 3 )  then
         msgTela('','O Cd não pode fazer requisições para ele mesmo.', MB_ICONERROR + MB_OK)
      else
      if  (fmMain.getUoLogada() <> uoCD ) and ( perfil =  3 )  then
         msgTela('','Só posso acessar essa tela se estiver logado no CD.', MB_ICONERROR + MB_OK)
      else   
      begin
         if (mostraMsg = true) then
            msgTela('','Essa tela só deverá ser utilizada para fazer requisições ' +#13+'de mercadorias vendidas ou encarte',mb_ok+MB_ICONWARNING);
            
         Application.CreateForm(TfmOsDeposito, fmOsDeposito);
         fmOsDeposito.Show;
         fmOsDeposito.SetPerfil(perfil, uoCD );
      end;
   end;
end;

procedure TfmMain.Requisicaoparaocd1Click(Sender: TObject);
begin
   abreFormRequisicao(true, 1);
end;

procedure TfmMain.Cadastrodeavarias1Click(Sender: TObject);
begin
  if (fmCadAvarias = nil) then
  begin
     Application.CreateForm( TfmCadAvarias  , fmCadAvarias);
     fmCadAvarias.Show;
  end
end;

procedure TfmMain.Propostasdaloja1Click(Sender: TObject);
begin
  if (fmProposta = nil) then
  begin
     Application.CreateForm(TfmProposta, fmProposta);
     fmProposta.Show;
  end
end;

procedure TfmMain.Mapadeseparao1Click(Sender: TObject);
begin
  if (fmMapa = nil) then
  begin
     Application.CreateForm(TfmMapa, fmMapa);
     fmMapa.Show;
  end
end;

procedure TfmMain.abeladePreos2Click(Sender: TObject);
begin
   if fmTabela  = nil then  Application.CreateForm(TfmTabela, fmTabela);
end;

procedure TfmMain.Precosalteradosporperodo2Click(Sender: TObject);
begin
   if fmPrecosAlterados = nil then
   begin
      Application.CreateForm(TfmPrecosAlterados, fmPrecosAlterados);
   end;
end;

procedure TfmMain.AjustedePrecos1Click(Sender: TObject);
begin
   if (fmLancaPrecos = nil) then
   begin
      Application.CreateForm(TfmLancaPrecos, fmLancaPrecos);
      fmLancaPrecos.show;
   end;
end;

procedure TfmMain.Descontodepedido1Click(Sender: TObject);
begin
   if fmPrecosAlterados = nil then
   begin
      Application.CreateForm(TfmDescPed, fmDescPed);
      fmDescPed.show;
   end;
end;

procedure TfmMain.AnaliseVLC1Click(Sender: TObject);
begin
   if (fmFaturamento = nil) then
      if (funcsql.isHoraPermitida(fmMain.Conexao, AnaliseVLC1.tag, fmMain.getGrupoLogado() ) = true ) then
      begin
         Application.CreateForm(TfmFaturamento, fmFaturamento);
         fmFaturamento.show;
      end;
end;

procedure TfmMain.chamaImpressaoRave( nRelatorio:String; params:Tstrings);
var
  i:integer;
begin
   gravaLog('Impressao de relatorio:' + nRelatorio);

   if params <> nil then
      for i:=0 to params.Count-1 do
         RvProject1.SetParam(intToStr(i), params[i]);

  RvProject1.ExecuteReport(nRelatorio);
end;

procedure TfmMain.impressaoRaveQr(qr:TADOQuery; nRelatorio:String; params:Tstrings);
begin
   RvDSConn.DataSet := qr;
   chamaImpressaoRave(nRelatorio, params);
end;

procedure TfmMain.impressaoRaveQr2(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings);
begin
   RvDSConn2.DataSet := qr2;
   RvDSConn.DataSet := qr;
   chamaImpressaoRave(nRelatorio, params);
end;

procedure TfmMain.impressaoRaveQr4(qr, qr2, qr3, qr4:TDataSet; nRelatorio:String; params:Tstrings);
begin
   RvDSConn.DataSet := qr;
   RvDSConn2.DataSet := qr2;
   RvDSConn3.DataSet := qr3;
   RvDSConn4.DataSet := qr4;
   chamaImpressaoRave(nRelatorio, params);
end;

procedure TfmMain.impressaoRavePDF(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings;nmArquivo:String);
begin
   RvSystem1.SystemSetups := RvSystem1.SystemSetups - [ssAllowSetup];
   RvSystem1.DefaultDest := rdFile;
   RvSystem1.DoNativeOutput:= false;
   RvSystem1.RenderObject:= rvRenderPDF1;
   RvSystem1.OutputFileName:=  nmArquivo;

   impressaoRaveQr2(qr, qr2, nRelatorio, params);
   RvSystem1.SystemSetups := RvSystem1.SystemSetups + [ssAllowSetup];
   RvSystem1.DefaultDest := rdPrinter;
   RvSystem1.DoNativeOutput:= true;
end;

procedure TfmMain.impressaoRave(tb: TADOTable; nRelatorio:String; params:Tstrings);
begin
   RvDSConn.DataSet := tb;
   chamaImpressaoRave(nRelatorio, params);
end;

procedure TfmMain.impressaoRaveTbQr(tb: TADOTable; qr:TADOQuery; nRelatorio:String; params:Tstrings);
begin
   RvDSConn.DataSet := tb;
   RvDSConn2.DataSet := qr;
   chamaImpressaoRave(nRelatorio, params);
end;

procedure TfmMain.Geracaopreodecusto1Click(Sender: TObject);
begin
   if fmEtiquetas  = nil then
   begin
      Application.CreateForm(TfmPrecoCustos, fmPrecoCustos);
      fmPrecoCustos.show;
   end;
end;

procedure TfmMain.Etiquetas1Click(Sender: TObject);
begin
   if fmEtiquetas  = nil then
   begin
      Application.CreateForm(TfmEtiquetas, fmEtiquetas);
      fmEtiquetas.show;
   end;
end;

procedure TfmMain.fecharForm(form: Tform; var Action: TCloseAction);
begin
    funcoes.salvaCampos(Form);
    Action := caFree;
    MsgStatus('');
end;

procedure TfmMain.Relacaodenotasdetransferncia1Click(Sender: TObject);
begin
   if fmEtiquetas  = nil then
   begin
      Application.CreateForm(TfmNotasTransf, fmNotasTransf);
      fmNotasTransf.show;
   end;
end;

procedure TfmMain.obterResumoEstoque(is_ref, is_disponivel: String);
begin
   if fmEtiquetas  = nil then
   begin
      Application.CreateForm( TfmResEstoque , fmResEstoque);
      fmResEstoque.obterEstoques(nil, is_ref, is_disponivel);
      fmResEstoque.ShowModal;
   end;
end;

procedure TfmMain.obterDetalhesEntrada(is_ref: String);
begin
   if fmDetEntrada  = nil then
   begin
      Application.CreateForm( TfmDetEntrada , fmDetEntrada );
      fmDetEntrada.ConsultaDetalhesEntrada(is_ref);
      fmDetEntrada.showModal;
   end;
end;

procedure TfmMain.obterDetalhesSaida(is_ref,uo:String; dtInicio:Tdate);
begin
   if (fmTotalSaidas  = nil) then
   begin
      Application.CreateForm( TfmTotalSaidas , fmTotalSaidas );
      fmTotalSaidas.calcularVenda(is_ref, uo, dtInicio, now );
      fmTotalSaidas.ajustaDataInicio(dtInicio);
      fmTotalSaidas.showModal;
   end;
end;

procedure TfmMain.EnviarEmail( para, assunto, anexo:String; corpoMsg:Tstringlist; titulo:String);
begin
   Application.CreateForm(TfmEnviaEmail, fmEnviaEmail);
   fmEnviaEmail.enviarEmailGmail( fmMain.getUoLogada() , para , assunto, anexo , corpoMsg, Conexao, titulo, getCdPesLogado() );
end;

procedure TfmMain.N1Click(Sender: TObject);
begin
   // recarregar o menu
   montarMenu( fmMain.getNomeLojaLogada(),  fmMain.getNomeUsuario(), fmMain.getUoLogada(), getUserLogado());
end;

procedure TfmMain.Mudarfinanceiradeboleto1Click(Sender: TObject);
begin
   if fmAlteraFiananceira = nil then
   begin
      Application.CreateForm(TfmAlteraFiananceira, fmAlteraFiananceira);
      fmAlteraFiananceira.show;
   end;
end;

procedure TfmMain.mostraDetalhesNota(Sender: Tobject; is_nota: String);
begin
   if fmDetEntrada = nil then
   begin
      application.CreateForm(TfmDetalhesNota,fmDetalhesNota);
      fmDetalhesNota.show;
      fmDetalhesNota.carregarDadosNota(nil, is_nota);
   end;
end;

procedure TfmMain.RelatriodeComisso1Click(Sender: TObject);
begin
   if fmDetEntrada = nil then
   begin
      application.CreateForm(TfmRelatorioComissao,fmRelatorioComissao);
      fmRelatorioComissao.show;
   end;
end;

procedure TfmMain.getRequisicoesPorProduto(cd_ref: String);
var
   programa, UO_CD :String;
begin
   UO_CD := GetParamBD('uocd','');
   screen.Cursor := crhourGlass;
   programa := '"' + ExtractFilePath(ParamStr(0)) + 'RequisicaoPorProduto.exe" -c ' +
   ' 0 ' + UO_CD +
   ' '+ DateToStr(now - 60 ) +
   ' '+ DateToStr(now) + ' ' + cd_ref;
   PostMessage(FindWindow(nil, 'ConsultaRequisicao'), WM_CLOSE, 0, 0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
end;

procedure TfmMain.Comporavendafiscal1Click(Sender: TObject);
begin
  if (fmComporEstoque = nil) then
  begin
     Application.CreateForm(TfmComporEstoque, fmComporEstoque);
     fmComporEstoque.Show;
  end
end;

procedure TfmMain.EtiquetasDeClientes1Click(Sender: TObject);
begin
  if (fmetqClientes = nil) then
  begin
     Application.CreateForm(TfmetqClientes, fmetqClientes);
     fmetqClientes.Show;
  end
end;

procedure TfmMain.Ajustedenotas1Click(Sender: TObject);
begin
   if (fmAjustaNota = nil) then
   begin
      Application.CreateForm(TfmAjustaNota, fmAjustaNota);
      fmAjustaNota.show;
   end;
end;

procedure TfmMain.Analisedeestoque1Click(Sender: TObject);
begin
   if (fmAnaliseEstoque = nil) then
   begin
      Application.CreateForm(TfmAnaliseEstoque, fmAnaliseEstoque);
      fmAnaliseEstoque.show();
   end;
end;

function TfmMain.getNomeUsuario: String;
begin
   result := fmMain.StatusBar1.Panels[1].Text;
end;

function TfmMain.getUserLogado(): String;
begin
   result := PARAMS_APLICACAO.Values['CD_USU'];
end;

function TfmMain.getUOCD: String;
begin
   result := PARAMS_APLICACAO.Values['uocd'];
end;

procedure TfmMain.Requisiodereposio1Click(Sender: TObject);
begin
   abreFormRequisicao( false,2);
end;


procedure TfmMain.RequisioparaoCDAbastecimento1Click(Sender: TObject);
begin
   abreFormRequisicao(false, 3);
end;


procedure TfmMain.ConsultaarequisioCDporproduto1Click(Sender: TObject);
begin
   if (fmConReqProduto = nil) then
   begin
      Application.CreateForm(TfmConReqProduto, fmConReqProduto);
      fmConReqProduto.Show();
   end;
end;

procedure TfmMain.Calculodeextranota1Click(Sender: TObject);
begin
   if (fmCalcExNota = nil) then
   begin
      Application.CreateForm(TfmCalcExNota, fmCalcExNota);
      fmCalcExNota.show;
   end;
end;

procedure TfmMain.consultaRequisicaoPorProduto(Sender: Tobject; str: String);
begin
   ConsultaarequisioCDporproduto1Click(nil);
   fmConReqProduto.preparaParaConsultar(nil, str );
end;

function TfmMain.getNomeLojaLogada(): String;
begin
   result := fmMain.StatusBar1.Panels[0].Text;
end;

procedure TfmMain.Resunmomovimentodirio1Click(Sender: TObject);
begin
   if (fmMovDiario = nil) then
   begin
      Application.CreateForm(TfmMovDiario, fmMovDiario);
      fmMovDiario.show()
   end;
end;

procedure TfmMain.Alterafornpedidodecompra1Click(Sender: TObject);
begin
   if (fmAlteraPedForn = nil ) then
   begin
      Application.CreateForm(TfmAlteraPedForn, fmAlteraPedForn);
      fmAlteraPedForn.Show();
   end;
end;

procedure TfmMain.Classificaodepro1Click(Sender: TObject);
begin
   if (fmAlteraPedForn = nil ) then
   begin
      Application.CreateForm(TfmClassificaProd, fmClassificaProd);
      fmClassificaProd.Show();
   end;
end;

procedure TfmMain.SetaAVersoNoBd1Click(Sender: TObject);
var
  str:String;
begin
   str := InputBox('','Entre com o novo número da versão:' ,  GetParamBD('comum.Versao','')) ;
   if str <> '' then
      funcsql.execSQL('update zcf_paramGerais set valor = ' + quotedstr(str) +' where nm_param = ''comum.Versao'' ', Conexao );
end;

function TfmMain.getCdPesLogado(): String;
begin
   result := PARAMS_APLICACAO.Values['CD_PES'];
end;

function TfmMain.getGrupoLogado: String;
begin
   result := PARAMS_APLICACAO.Values['CD_GRUSU'];
end;

function TfmMain.getUoLogada(): String;
begin
   result := PARAMS_APLICACAO.Values['IS_UO'];
end;

function TfmMain.ehCampoPermitido(nParam:String): Boolean;
var
   str:String;
begin
   str:= funcSQL. getParamBD(nParam,'', Conexao);
   if pos(fmMain.getGrupoLogado(), str) > 0 then
      result := true
   else
      result := false;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
var
   nFormsAbertos, i:integer;
begin
    nFormsAbertos :=0;
    TIME_OUT_PROGRAMA := TIME_OUT_PROGRAMA -1;
    if (TIME_OUT_PROGRAMA < 1) then
    begin
       for i:=0 to Application.ComponentCount-1do
          if application.Components[i].InheritsFrom(Tform) = true then
            inc(nFormsAbertos);

       if (pos(fmMain.getUserLogado(), fmMain.GetParamBD('comum.usrSemTimeOut','') ) = 0 ) and (nFormsAbertos <= 1) then
          Application.Terminate()
       else
          TIME_OUT_PROGRAMA := TIME_OUT_PROGRAMA_DEFAULT;

    end;
end;

procedure TfmMain.Parmetrosdosistema1Click(Sender: TObject);
begin
   if ( fmParametros = nil) then
   begin
      Application.CreateForm(TfmParametros, fmParametros);
      fmParametros.show;
   end;
end;


procedure TfmMain.showGridCol(grid:TSoftDBGrid; qr: TdataSet; col:String; is_visible: Boolean);
begin
   grid.Columns[qr.FieldByName(col).Index ].Visible := is_visible;
end;

procedure TfmMain.Cadastrarcodigodebarrasdeproduto1Click(Sender: TObject);
var
  is_ref, EAN,desc,cd_ref:String;
begin
   cd_ref := InputBox('','Qual o código do produto que você quer' +#13+ 'cadastrar?', cd_ref  ) ;
   desc := funcsql.openSQL('Select cd_ref +'' - ''+ ds_ref as cd_ref from crefe(nolock) where cd_ref = ' + quotedStr(cd_ref), 'cd_ref', Conexao );
   if desc = '' then
      funcoes.MsgTela('','Produto não cadastrado.', MB_OK + MB_ICONERROR )
   else
   begin
      EAN := InputBox('','Digite o EAN que você quer informar para o produto: ' +#13+ desc , EAN );

      if (length(EAN) < 13) then
         funcoes.MsgTela('','EAN inválido', MB_OK + MB_ICONERROR )
      else if ( funcsql.openSQL('select cd_pesq from dscbr where cd_pesq = ' + quotedStr(ean) + ' and tp_cdPesq = 1', 'cd_pesq', Conexao ) ) <> '' then
         funcoes.MsgTela('','Esse EAN já é cadastrado' , MB_OK + MB_ICONERROR )
      else
      begin
         is_ref := funcsql.openSQL('select is_ref from crefe where cd_ref = ' + quotedStr(cd_ref), 'is_ref', Conexao );
         execSQL('insert dscbr (CD_PESQ, TP_CDPESQ,IS_REF) Values ( '+ean+', 1, ' + is_ref  + ')', fmMain.Conexao);
         funcoes.MsgTela('','O EAN foi incluído com sucesso.', MB_OK + MB_ICONERROR )
      end;
   end;
end;


function TfmMain.telaAutWell(Grupos, cd_usu: string): String;
begin
   if ( pos(fmMain.getGrupoLogado(), Grupos) > 0) or  ( pos(getUserLogado(), Grupos) > 0 ) then
      result := getUserLogado()
   else
      result := verificaSenhas.TelaAutorizacao2(Conexao, grupos,cd_usu);
end;

function TfmMain.getCdRef(str: String): String;
begin
   result := trim(funcoes.SohNumeros(copy(str, 01, 08)));
end;


function TfmMain.getDescUO(cb: TCustomComboBox): String;
begin
   result := copy(cb.Items[cb.itemIndex], 01, 30);
end;


procedure TfmMain.getParametrosForm(form: Tform);
var
  i:integer;
begin
//   Carrega os hints dos campos
//  para carregar o hint, marque a propriedade showHint como True

   for i:= 0 to form.ComponentCount -1 do
      if GetPropInfo(form.Components[i], 'ShowHint') <> nil then
         if ((form.Components[i] as TControl).ShowHint = true ) then
            (form.Components[i] as TControl).Hint := funcSQL.getHint(form.Name + '.'+form.Components[i].Name, conexao);
// carrega as informacoes dos components
   funcoes.carregaCampos(form);
end;

procedure TfmMain.CompromissosDeFornecedoresPorData1Click(Sender: TObject);
begin
   if (fmCompFornecedor = nil) then
   begin
      Application.CreateForm( TfmCompFornecedor, fmCompFornecedor);
      fmCompFornecedor.Show();
   end;
end;

procedure TfmMain.CadastrarNCM1Click(Sender: TObject);
begin
   if (fmCadastraNCM = nil) then
   begin
      Application.CreateForm( TfmCadastraNCM, fmCadastraNCM);
      fmCadastraNCM.Show();
   end;
end;

procedure TfmMain.AjustedoarquivoSPED1Click(Sender: TObject);
begin
   if (fmAjustaSPED = nil) then
   begin
      Application.CreateForm( TfmAjustaSPED, fmAjustaSPED);
      fmAjustaSPED.Show();
   end;
end;


function TfmMain.getCodPreco(cb: TCustomComboBox): String;
begin
   result := funcoes.SohNumeros(copy(cb.Items[cb.ItemIndex],50,08) );
end;

function TfmMain.getDescPreco(cb: TCustomComboBox): String;
begin
    result := trim(copy(CB.Items[CB.itemIndex], 01, 30));
end;


procedure TfmMain.Listarcustodeitensporpedido1Click(Sender: TObject);
begin
   if ( fmCustoPorPedido = nil) then
   begin
      Application.CreateForm( TfmCustoPorPedido, fmCustoPorPedido);
      fmCustoPorPedido.Show();
   end;
end;

procedure TfmMain.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
   funcoes.gravaLog('Erro:' + e.Message);
end;

procedure TfmMain.exportaXMLNota(is_nota:String);
var
  ds:TdataSet;
  msgEmail:Tstringlist;
  server, dirRemoto, dirLocal, arquivo:String;
begin
   ds :=  ucf.getDadosNota(is_nota , '', '', '');
   msgEmail := TStringList.create();


   if (ds.IsEmpty = true ) or ( ds.FieldByName('chave_acesso_nfe').asString = '') then
      funcoes.msgTela('', 'Não existe chave de acesso para essa nota. ', mb_ok + MB_ICONERROR)
   else
   begin
     try
        server := fmMain.GetParamBD('ServerNFE.ip',  ds.fieldByName('is_estoque').asString);
        dirRemoto := fmMain.GetParamBD('ServerNFE.DirNFE', fmMain.getUoLogada() );
        dirLocal :=  ExtractFilePath(paramStr(0))+'logs';
        arquivo:=  ds.FieldByName('chave_acesso_nfe').asString + '-NFE.XML';

        if (getFileFromACBR(server, dirRemoto, dirLocal, arquivo ) = true) then
        begin
           msgEmail.Clear();
           msgEmail.add( 'Segue o XML da nota fiscal ' +  ds.FieldByName('Num').asString);
           msgEmail.add( 'Emitida pela loja: '+ ds.FieldByName('loja').asString );
           enviarEmail( '', 'Envio de XML nota fiscal eletrônica', dirLocal+'\'+arquivo ,  msgEmail, 'Envio de XML');
//           deleteFile(dirLocal+'\'+arquivo); // Deleta o arqXML;
         end
       else
         msgTela('', 'Não encontrei o XML dessa nota', MB_OK + MB_ICONERROR);
       msgEmail.Free();
     except
        on e:Exception do
          funcoes.msgTela('', 'Erro ao processar o comando de captura do xml, '+#13+ 'Detalhes: ' + e.Message, mb_ok + MB_ICONERROR);
     end;
   end;
end;

procedure TfmMain.EnviarXML1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := uGetNotas.getIsNota();
   if (cmd <> '') then
      exportaXMLNota(cmd);
end;

procedure TfmMain.EnviarespelhoPDFdeNFeParaEmail1Click(Sender: TObject);
var
   cmd:String;
   msgEmail: TStringList;
   ds:TdataSet;
begin
   cmd := uGetNotas.getIsNota();
   if (cmd <> '') then
   begin
      ds:= uCF.getDadosNota(cmd, '','','');

      screen.Cursor := crHourglass;

      cmd := GetPDFNFe(cmd);
      msgEmail := TStringlist.Create();
      msgEmail.add( 'Segue o XML da nota fiscal ' +  ds.FieldByName('Num').asString);
      msgEmail.add( 'Emitida pela loja: '+ ds.FieldByName('loja').asString );
      enviarEmail('', 'Envio de PDF, nota fiscal eletrônica', cmd,  msgEmail, 'Envio de XML');
      ds.Free();

      if (fileExists(cmd)= true) then
         deleteFile(cmd);
   end;
   screen.Cursor := crDefault;
end;

procedure TfmMain.tnDataAvailable(Sender: TIdTelnet; const Buffer: String);
begin
   FUNCOES.gravaLog(Buffer);
   RESP_TELNET := RESP_TELNET + Buffer;
end;


function TfmMain.executeTelnetCmd(uo, comando:String):boolean;
var
   CR_PONTO_LF :String;
   tn:TidTelnet;
begin
    screen.Cursor := crHourglass;
    RESP_TELNET := '';
    CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
    try
       CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
       tn := TIdTelnet.Create(nil);
       tn.OnDataAvailable :=  tnDataAvailable;
       tn.Host := fmMain.GetParamBD('ServerNFE.ip', uo );
       tn.Port := 3436;
       msgstatus('Conectando ao servidor ACBR...');
       tn.Connect(2000);
       sleep(1000);
       funcoes.gravaLog(comando);
       tn.write( comando + CR_PONTO_LF);
       msgstatus('Solicitando ação...');
       sleep(3000);
       msgstatus('Fechando conexão...');
       tn.write('bye' + CR_PONTO_LF );
       sleep(6000);

       gravaLog('Respostas do servidor:' + RESP_TELNET);
       gravaLog('');
       result := (pos('ERRO: ', RESP_TELNET) = 0)
     except
     begin
        screen.Cursor := crDefault;
        gravaLog('');
        result :=false;
     end;
    end;
end;

function TfmMain.GetPDFNFe(isNota: String):String;
var
  server, dirLocal, dirRemoto, arquivo :String;
  ds:TdataSet;
begin
   screen.Cursor := crHourGlass;
   msgStatus('Gerando arquivo PDF');

   ds:= UCF.getDadosNota(isNota,'','','');

   if (ds.IsEmpty = true ) or ( ds.FieldByName('chave_acesso_nfe').asString = '') then
   begin
      funcoes.msgTela('', MSG_ERRO_CH_NFE, mb_ok + MB_ICONERROR);
      result := '';
   end
   else
   begin
      try
         server := fmMain.GetParamBD('ServerNFE.ip',  ds.fieldByName('is_estoque').asString);
         dirLocal :=  ExtractFilePath(paramStr(0))+'logs';
         dirRemoto := fmMain.GetParamBD('ServerNFE.DirNFE', fmMain.getUoLogada() );
         arquivo :=  ds.FieldByName('chave_acesso_nfe').asString;

         if ( executeTelnetCmd( ds.fieldByName('is_estoque').asString, 'NFe.ImprimirDANFEPDF("' +dirRemoto+ arquivo+ '-NFE.XML'+ '")'  ) = true) then
         begin
            dirRemoto := fmMain.GetParamBD('ServerNFE.DirPDF', fmMain.getUoLogada() );
            fmMain.MsgStatus('Baixando arquivo PDF');

            if (getFileFromACBR( server, dirRemoto, dirLocal, arquivo +'.pdf') = true) then
               result := dirLocal +'\'+ arquivo +'.pdf'
            else
            begin
               msgTela('',' Não consegui obter o arquivo PDF.', MB_ICONERROR + MB_OK);
               result := '';
            end
         end
         else
         begin
            msgTela('',' Não existe o arquivo xml no servidor.', MB_ICONERROR + MB_OK);
            result := '';
         end;
      except
      on e:Exception do
      begin
         funcoes.gravaLog('Erro ao baixar o pdf '+ e.Message);
         msgTela('', 'Houve um erro ao tentar obter o arquivo.', MB_OK + MB_ICONERROR);
         result := '';
      end
      end;
   end;
   screen.Cursor := crDefault;
end;

procedure TfmMain.ImprimirNFe1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := uGetNotas.getIsNota();
   if (cmd <> '') then
      cmd := fmMain.getPDFNFe(cmd);
    if ( cmd <> '') then
    begin
       fmMain.MsgStatus('Impressão....');
       funcoes.execFileExternal(fmMain, cmd );
    end;
    msgStatus('');
end;

procedure TfmMain.Saldofiscalpormes1Click(Sender: TObject);
begin
   if ( fmObterSaldoFiscal = nil) then
   begin
      Application.CreateForm(TfmObterSaldoFiscal, fmObterSaldoFiscal);
      fmObterSaldoFiscal.Show();
    end;
end;

procedure TfmMain.PagamentosEmCartao1Click(Sender: TObject);
begin
  if (isPermiteAbrirTela(Pagamentosemcarto1.Tag) = true) then
  begin
     Application.CreateForm(TfmRelGeral, fmRelGeral);
     fmRelGeral.show();
     fmRelGeral.setPerfil(Pagamentosemcarto1.Tag);
  end;
end;

procedure TfmMain.Cargadedadosparaconciliao1Click(Sender: TObject);
begin
   Application.CreateForm(TfmRelGeral, fmRelGeral);
   fmRelGeral.show();
   fmRelGeral.setPerfil(407);
end;

procedure TfmMain.DeletarRegistrodecartoTEF1Click(Sender: TObject);
begin
   if (fmRemRegTEF = nil) then
   begin
      Application.CreateForm( TfmRemRegTEF, fmRemRegTEF);
      fmRemRegTEF.Show();
   end;
end;

procedure TfmMain.ImprimirDANFE1Click(Sender:Tobject);
var
   impressora, server, dirNFE, cmd:String;
   ds:TdataSet;
begin
   cmd := uGetNotas.getIsNota();
   if (cmd <> '') then
   begin
      impressora:= getNomeImpressoraNFe();
      ds:= uCf.getDadosNota(cmd, '','','');
      if (impressora <> '') then
         if (ds.FieldByName('chave_acesso_nfe').AsString <> '') then
         begin
            server := funcSQL.getParamBD('ServerNFE.ip',ds.FieldByName('is_estoque').AsString, fmMain.conexao);
            dirNFE := funcSQL.getParamBD('ServerNFE.DirNFE', ds.FieldByName('is_estoque').AsString, fmMain.conexao);
            cmd :='NFE.ImprimirDANFE("' + dirNFE + ds.FieldByName('chave_acesso_nfe').AsString + '-nfe.xml","'+  impressora+'")';
            executeTelnetCmd( ds.FieldByName('is_estoque').AsString, cmd);
         end
         else
            funcoes.msgTela('', MSG_ERRO_CH_NFE, MB_ICONERROR + MB_OK);
   end;
      msgStatus('');
end;

procedure TfmMain.setaLojaLogadaNoComboBox(cb:TadLabelComboBox);
var
   achou:boolean;
   i:integer;
begin
   achou := false;
   if ( achou = false) then
      cb.itemIndex := -1;
   for i:=0 to cb.Items.count-1 do
   begin
      cb.ItemIndex := i;
      if (funcoes.getCodUO(cb) = getUoLogada() ) then
      begin
         achou := true;
         break;
      end;
   end;
   if (achou = false) then
      cb.ItemIndex := -1;
end;

procedure TfmMain.getListaLojas(cb:TadLabelComboBox; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean; usuario: String);
begin
   cb.Items.Clear();
   cb.Items := funcSQL.getNomeLojas2( conexao, IncluirLinhaTodas, IncluiNenhuma, usuario );
   setaLojaLogadaNoComboBox(cb);
   cb.DropDownCount := cb.items.count;
end;

procedure TfmMain.RegistroSCAN1Click(Sender: TObject);
var
   posTags, j,i:integer;
   nmArq, dataSql, dhCont, xjust, aux :String;
   arq:TStringlist;
begin
   screen.Cursor := crHourGlass;
   nmArq:= funcoes.DialogAbrArq('xml', 'c:\');
   arq:= TStringlist.create();

   arq.LoadFromFile(nmArq);

   for i:=0 to arq.Count-1do
   begin
      j:= pos('</verProc>',arq[i]);
      posTags :=  j+ length('</verProc>');
      if (j > 0) then
      begin
         aux := arq[i];
         dataSql := funcdatas.dateTimeToSqlDateTime(dateToStr(now), timeToStr(now) );

         delete(dataSql, 1, 1);
         delete(dataSql, length(dataSql), 1);
         insert('T', dataSql, 11);
         delete(dataSql, 12, 1);
                  
         dhCont := '<dhCont>'+ dataSql +'</dhCont>';
         xjust:= '<xJust>Sefaz ceara fora do ar</xJust>';

         insert(dhCont+xjust, aux, posTags);

         arq[i] := aux;

         arq.SaveToFile(nmArq);
      end;
   end;
   screen.Cursor := crDefault;
end;

procedure TfmMain.Geraestoque1Click(Sender: TObject);
begin
   if (fmGeraEstoque  = nil) then
   begin
      Application.CreateForm(TfmGeraEstoque, fmGeraEstoque);
      fmGeraEstoque.show;
   end;
end;

procedure TfmMain.obterResumoEntSai(isref: String);
begin
   if (fmEntSai = nil) then
   begin
      Application.CreateForm(TfmEntSai, fmEntSai);
      fmEntSai.show();
   end;
end;

procedure TfmMain.Processarinventrio1Click(Sender: TObject);
begin
   if (fmRelInventario = nil) then
   begin
      Application.CreateForm(TfmRelInventario, fmRelInventario);
      fmRelInventario.show();
   end;
end;


procedure TfmMain.Produtostransferidos1Click(Sender: TObject);
begin
  begin
     Application.CreateForm(TfmRelGeral, fmRelGeral);
     fmRelGeral.show();
     fmRelGeral.setPerfil(ProdutosTransferidos1.Tag);
  end;
end;

end.


