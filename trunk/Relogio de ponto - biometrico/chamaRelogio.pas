unit chamaRelogio;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Graphics, NMFtp, Psock, NMDayTim, Gauges,funcd5,
  TFlatGaugeUnit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    dtime1: TNMDayTime;
    ftp1: TNMFTP;
    Timer1: TTimer;
    gGauge1: TFlatGauge;
    procedure FormActivate(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    function  HaNovaVersao:boolean;
    function lerParametro(l:string):string;
    procedure FormCreate(Sender: TObject);
    Procedure ExecutaPrograma(sender:tobject);
    procedure ftp1PacketRecvd(Sender: TObject);
    Procedure PegarArquivos(sender:tobject;NomeDoArquivo:string);
    procedure ChamarGravacaoDoErro(sender:Tobject;e:exception;Msg:String);
    function  BaixarArquivo(sender:Tobject;mens,nome:string):boolean;
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AcertaMatriculas(Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  PATH = 'c:\_ponto\';
  ARQ_ERROS = PATH  + 'errorlog.txt';

var
  Form1: TForm1;
  rest: integer;
implementation

{$R *.DFM}

function TForm1.lerParametro(l:string):string;
begin
   while pos('=',l) > 0 do
      delete(l,01,01);
   lerParametro := l;
end;


procedure tform1.ChamarGravacaoDoErro(sender:Tobject;e:exception;Msg:String);
begin
   e.Message := msg + ' - ' + e.message;
   AppException(sender,e);
end;


function Tform1.BaixarArquivo(sender:Tobject;mens,nome:string):boolean;
begin
   form1.refresh;
   label2.caption := mens;
   ftp1.download( nome , path + nome );
end;

Procedure tform1.PegarArquivos(sender:tobject;NomeDoArquivo:string);
var
   arq:textfile;
   mens,nome,lin:string;
begin
   assignFile( arq,NomeDoArquivo );
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


procedure TForm1.AppException(Sender: TObject; E: Exception);
var
  dest:textfile;
begin
   assignFIle(dest, ARQ_ERROS );
   if FileExists(ARQ_ERROS) = true then
      append(dest)
   else
      rewrite(dest);
   writeln(dest,'- ' + DateToStr(now)+' - '+TimeTOStr(now)+ ' - ' +  E.message );
   closefile(dest);
end;



function ajustadata2(dt:string):string;
begin
   if (length(dt) <= 19  ) and ( copy(dt,11,01) = '/' ) then   insert('0',dt,10);
   if (length(dt) <= 20  ) and ( copy(dt,14,01) = '/' ) then   insert('0',dt,13);
   ajustadata2:=dt;
end;


function Tform1.HaNovaVersao:boolean;
begin
   memo1.lines.loadfromfile(PATH +'UVPonto.new');
   memo2.lines.loadfromfile(PATH +'UVPonto.cfg');
   if lerParametro(memo1.lines[0]) <> lerParametro(memo2.lines[0]) then
   begin
      DeleteFile(PATH +'UVPonto.cfg');
      RenameFile(PATH +'UVPonto.new',PATH +'UVPonto.cfg');
      HaNovaVersao := true;
   end;
end;

Procedure TForm1.ExecutaPrograma(sender:tobject);
begin
   if FileExists (PATH + 'Relogio.exe') then
      winexec(pchar(PATH + 'Relogio.exe'),0)
   else if FileExists ('c:\Projetos\Relogi~1\Relogio.exe') then
      winexec(pchar('c:\Projetos\Relogi~1\Relogio.exe'),0);
end;


procedure TForm1.FormActivate(Sender: TObject);
var
   DataHora: TSystemTime;
   time: String;
begin
   timer1.Enabled:= true;
   memo1.lines.LoadFromFile('c:\_ponto\relogio.ini');
   form1.Refresh;
    try
       with ftp1 do
       begin
          ftp1.timeout := 3000;
          host:='125.4.4.200';
          if Connected = true then Disconnect;
          UserID:='ponto';
          password:='ponto';
       end;
       memo1.lines.Clear;
       ftp1.Connect;
       ftp1.timeout := 0;

       label1.caption := 'Iniciando o sistema, aguarde...';
       if form1.lerParametro(memo1.lines[3]) = 'S' then
          FTP1.Mode(MODE_IMAGE)
       else
          ftp1.mode(MODE_ASCII);

       label2.caption := 'Verificando arquivos novos...';
       ftp1.download('ArquivosParaPonto.cfg','ArquivosParaPonto.cfg');
       PegarArquivos(sender,'ArquivosParaPonto.cfg');

       DeleteFile( PATH + 'justificativas.cfg');
       RenameFile(PATH + 'justificativas.new',PATH + 'justificativas.cfg');
       DeleteFile( PATH + 'Cadastros.cfg');
       RenameFile(PATH + 'Cadastros.new',PATH + 'Cadastros.cfg');

       label2.caption := 'Ajustando a hora';
       time:= ajustadata2(dtime1.DayTimeStr);
       with DataHora do
       begin
          wYear  := StrToint(copy(time,16,04));
          wMonth := StrToint(copy(time,13,02));
          wDay   := StrToint(copy(time,10,02));
          wHour  := StrToint(copy(time,01,02));
          wMinute:= StrToint(copy(time,04,02));
          wSecond:= StrToint(copy(time,01,02));
          wMilliseconds := 0
      end;
      SetLocalTime(DataHora);

      if StrToDate(LerParam(path+'AcertoMatricula.cfg',00))  >= now then
         AcertaMatriculas(Sender);

      if HaNovaVersao = true then
      begin
         label2.caption := 'Baixando uma nova versão do programa, aguarde...';
         ftp1.download('Relogio.exe',PATH + 'Relogio.exe');
      end;

      ExecutaPrograma(sender);
      application.terminate;
    except
       on e:exception do
       begin
          ChamarGravacaoDoErro(sender,e,'Evento chamado em FormActivate');
          ExecutaPrograma(sender);
          application.terminate;
       end;
    end;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   rest:=ftp1.timeout;
   if FileExists('c:\_ponto\UVPonto.CFG') = false  then
   begin
      memo2.lines[0] := 'versao=0.00';
      memo2.lines.savetofile('c:\_ponto\UVPonto.CFG');
      memo2.lines.clear;
   end;
end;

procedure TForm1.ftp1PacketRecvd(Sender: TObject);
begin
   form1.refresh;
   ggauge1.MaxValue:= ftp1.BytesTotal;
   ggauge1.progress := ftp1.BytesRecvd;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    if FileExists(PATH +'UVPonto.new') then
       DeleteFile(PATH +'UVPonto.new');
    if FileExists(PATH +'ArquivosParaPonto.cfg') then
       DeleteFile(PATH +'ArquivosParaPonto.cfg');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   if (rest > 0) and(ftp1.Connected = false) then
   begin
      rest:= rest-timer1.interval;
      label1.caption := 'Iniciando o sistema, aguarde 0' + inttostr( (rest div 1000))+ ' s';
   end;
end;

function VerificaNumCartao(Cartoes:tstringList;Mat:string):String;
var
   i:integer;
begin
   VerificaNumCartao := Mat;
   for i:=1 to cartoes.count-1 do
   begin
      if Copy(cartoes[i],01,08) = mat then
      begin
         VerificaNumCartao := Copy(cartoes[i],10,08);
         break;
      end;
   end;
end;

procedure TForm1.AcertaMatriculas(Sender: Tobject);
var
  Reg: TStringList;
  arq,dest:textfile;
  str:string;
  i:LongInt;
begin
   Reg := tstringlist.Create();
   Reg.LoadFromFile(path+'AcertoMatricula.cfg');

   AssignFile(arq, funcd5.lerParam(PATH + 'RELOGIO.INI',00));
   Reset(arq);
   i:=0;
   while eof(arq) = false do
   begin
      readln(arq,str);
      inc(i);
      Label2.Caption := 'Substituindo matriculas antigas: ' + IntToStr(i);
      panel1.Refresh;
      funcd5.GravaLinhaEmUmArquivo( PATH + 'TEMP.TMP', copy(str,01,20) + VerificaNumCartao(reg, copy(str,21,08)));
   end;
   CloseFile(arq);

   deletefile(funcd5.lerParam(PATH+'RELOGIO.INI',00));
   RenameFile(PATH + 'TEMP.TMP', funcd5.lerParam(PATH+'RELOGIO.INI',00));
end;

end.
