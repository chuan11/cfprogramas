unit ChamaLista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Psock, NMFtp, Ggauge, StdCtrls,funcd5;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    GGauge1: TGradientGauge;
    NMFTP1: TNMFTP;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    function  lerParametro(l:string):string;
    procedure AppException(Sender: TObject; E: Exception);
    procedure NMFTP1PacketRecvd(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure PegarArquivos(sender:tobject;NomeDoArquivo:string);
    function existeNovaVersao:boolean;
    function BaixarArquivo(sender:tobject;mens,nome:String):boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

CONST
   PATH = 'c:\listas\';
   ARQ_PARAMETROS = PATH + 'ListaCasamento.ini';
   ARQ_ERROS = PATH + 'ErrorLog.txt';
var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.lerParametro(l:string):string;
begin
   while pos('=',l) > 0 do
      delete(l,01,01);
   lerParametro := l;
end;


function tform1.existeNovaVersao:boolean;
var
   arqLocal,arqRemoto:textfile;
   l,r:string;
begin
   existeNovaVersao := false;
   memo1.lines.LoadFromFile( 'c:\listas\listacasamento.cfg');
   memo2.lines.LoadFromFile( ARQ_PARAMETROS );

   if form1.lerParametro(memo1.lines[2]) <> form1.lerParametro(memo2.lines[2]) then
      existeNovaVersao := true;
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
end;

function Tform1.BaixarArquivo(sender:Tobject;mens,nome:string):boolean;
begin
   form1.refresh;
   label2.caption := mens;
   nmftp1.download( nome ,  nome );
end;

Procedure tform1.PegarArquivos(sender:tobject;NomeDoArquivo:string);
var
   arq:textfile;
   mens,nome,lin:string;
   i:integer;
begin
   assignFile( arq, 'ArquivosParaBaixar.cfg');
   reset(arq);
   while eof( arq) = false do
   begin
      readln(arq,lin);
      if lin <> '' then
      begin
         mens := copy(lin,01,pos(',',lin) - 1);
         nome := copy(lin, pos(',',lin) + 1 , length(lin)-pos(',',lin) ) ;
         BaixarArquivo(sender,mens,nome);
      end;
   end;
   CloseFile(arq);
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
    with nmftp1 do
    begin
        if connected then disconnect;
        host := funcd5.lerParam( ARQ_PARAMETROS,06);
        port :=  21;
        timeout := 10000;
        userid  := funcd5.tiraEspaco( funcd5.lerParam( ARQ_PARAMETROS,07) );
        password:= funcd5.tiraEspaco( funcd5.lerParam( ARQ_PARAMETROS,08) );
        vendor  := NMOS_auto;
    end;
    try
       nmftp1.connect;
       nmftp1.timeout := 0;
       nmftp1.parseList:= true;
       nmftp1.mode(mode_ascii);
       nmftp1.ChangeDir('/listas');
       ggauge1.Visible := true;
       label2.caption := ' - Verificando arquivos novos...';
       nmftp1.download('ArquivosParaBaixar.cfg','ArquivosParaBaixar.cfg');
       PegarArquivos(sender,'');
       label2.caption := 'Verificando a versão';
       nmftp1.download('listacasamento.ini','c:\listas\listacasamento.cfg');
       if existeNovaVersao = true then
       begin
          label2.caption := ' - Atualizando a versão do programa, aguarde...';
          nmftp1.download('listas.exe', Path + 'listas.exe');
          memo2.lines[2] := memo1.lines[2];
          memo2.lines.SaveToFile( ARQ_PARAMETROS);
       end;
       ggauge1.visible:= false;
       label2.caption := '';
       winexec(pchar(path + 'listas.exe'),0);
    except
       on e:exception do
       begin
          form1.AppException(sender,E);
          winexec(pchar(path + 'listas.exe'),0);
       end;
    end;
    application.terminate;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   Application.OnException := form1.AppException;
end;


procedure TForm1.NMFTP1PacketRecvd(Sender: TObject);
begin
    ggauge1.Max := nmftp1.BytesTotal;
    ggauge1.Position := nmftp1.BytesRecvd;
    ggauge1.Update;
end;


end.
