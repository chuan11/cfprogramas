unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Classes,  Controls, Forms,
  Menus, ExtCtrls, ComCtrls, StdCtrls, ImgList, mxOneInstance, Db, Grids,
  DBGrids, DBTables, Buttons, adLabelMemo, ADODB;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastrodelistas1: TMenuItem;
    ProdutosNaslistas1: TMenuItem;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    mxOneInstance1: TmxOneInstance;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Memo1: TMemo;
    rg: TRadioGroup;
    ADOConnetion: TADOConnection;
    Query1: TADOQuery;
    procedure ProdutosNaslistas1Click(Sender: TObject);
    procedure Cadastrodelistas1Click(Sender: TObject);
    procedure msgderodape(msg:String);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DesabilitaMenu(sender:Tobject);
    procedure HabilitaMenu(sender:Tobject);
    procedure FormCreate(Sender: TObject);
    function  lerParametro(l:string):string;
    procedure AppException(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    function  ProximoValor(Sender: TObject; tabela,campo:string):String;
    function  ajustadataInicioDoMes(data:string):String;
    function  Ajustadata(data:string):String;
    procedure rgClick(Sender: TObject);
    procedure ADOConnetionExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
    procedure ADOConnetionWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

CONST
   PATH = 'c:\listas\';
   ARQ_PARAMETROS = PATH + 'ListaCasamento.ini';
   ARQ_ERROS = PATH + 'ErrorLog.txt';
   VERSAO = '1.36';
   TITULO = 'Gerenciador de Listas - '+ VERSAO;
var
  Form1: TForm1;
implementation

uses Unit2, Unit3, Unit5, Unit4,unit6;
{$R *.DFM}
function Tform1.ajustadataInicioDoMes(data:string):String;
var
   InicioDoMes:string;
begin
   data:=DateToStr(now);
   ajustadataInicioDoMes := copy(data,04,02)+ '/01/'+ copy(data,07,04);
end;
function Tform1.Ajustadata(data:string):String;
begin
   ajustadata := copy(data,04,02)+'/'+copy(data,01,02)+ '/' + copy(data,07,04);
end;


function  TForm1.ProximoValor(Sender: TObject; tabela,campo:string):String;
begin
   with query1.sql do
   begin
      clear;
      add('Select max ('+campo+') from '+ tabela);
   end;
   query1.open;
   if dbgrid1.fields[0].AsString <> '' then
      ProximoValor := IntToStr( StrToInt(dbgrid1.fields[0].AsString) +1 );
end;


procedure TForm1.AppException(Sender: TObject; E: Exception);
var
  dest:textfile;
begin
   assignFIle(dest, ARQ_ERROS );
   if FileExists(ARQ_ERROS) = true then
      append(dest)
   else
      rewrite(dest);
   writeln(dest, dateToSTr(now) + '   ' + timetoStr(now)+ '    ' + E.message );
   closefile(dest);
   msgderodape('Erro, consulte o log!!!');
end;


procedure TForm1.ProdutosNaslistas1Click(Sender: TObject);
begin
  rg.visible := false;
  Application.CreateForm(TProdutosNaLista, ProdutosNaLista);
  ProdutosNaLista.show;
end;


procedure TForm1.Cadastrodelistas1Click(Sender: TObject);
begin
  Application.CreateForm(TCadListas, CadListas);
  CadListas.show;
end;


procedure tform1.msgderodape(msg:String);
begin
   statusbar1.panels[0].text:= msg;
end;


procedure Tform1.HabilitaMenu(sender:Tobject);
begin
   form1.Menu:= form1.mainmenu1;
   rg.visible := true;
end;


procedure Tform1.DesabilitaMenu(sender:Tobject);
begin
    rg.visible := false;
    form1.Menu:= nil;
end;


function TForm1.lerParametro(l:string):string;
begin
   while pos('=',l) > 0 do
      delete(l,01,01);
   lerParametro := l;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   ADOConnetion.Connected := true;
   ShortDateFormat  := 'dd/mm/yyyy';
   with form1 do
   begin
      Caption := TITULO;
      top := -3;
      Left:= 800 - form1.Width;
   end;
   Application.OnException := form1.AppException;

   memo1.lines.Loadfromfile( ARQ_PARAMETROS );

   statusbar1.Panels[1].text := 'Loja: ' + lerParametro(memo1.lines[0]);
   memo1.lines[2] := copy(memo1.lines[2],01,pos('=',memo1.lines[2])) + VERSAO;
   if form1.lerParametro(memo1.lines[3]) = 'S' then
      rg.itemIndex := 1;
   memo1.lines.SaveToFile( arq_parametros );
   memo1.lines.SaveToFile('ListaCasamento.ini');
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{   if (ProdutosNaLista <> nil) or( form5 <> nil) or(cadlistas <> nil) or ( Fimpressao <> nil) then
   begin
      application.MessageBox(pchar('   Feche as janelas que estão abertas!!!  '),pchar(form1.caption),mb_ok + mb_iconwarning);
      canclose := false;
   end
}
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   deleteFile(BAT_DE_IMPRESSAO);
   deleteFile(ARQ_DE_IMPRESSAO);
   deleteFile(ARQ_DADOS);
   DELETEFILE(ARQ_PROD);
end;


procedure TForm1.mxOneInstance1InstanceExists(Sender: TObject);
begin
  application.messagebox(' Já existe uma instância deste programa aberta !!!! ',TITULO, MB_OK + MB_ICONERROR);
  application.terminate
end;


procedure TForm1.rgClick(Sender: TObject);
begin
    if rg.ItemIndex = 0 then
       memo1.lines[3] := '04 Mostrar Todas as listas=N'
    else
       memo1.lines[3] := '04 Mostrar Todas as listas=S';
    memo1.lines.SaveToFile( ARQ_PARAMETROS );
end;

procedure TForm1.ADOConnetionExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
  screen.Cursor:= crDefault;
end;

procedure TForm1.ADOConnetionWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor:= crhourglass;
end;

end.
