unit UMRegAnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ComCtrls, Psock, NMFtp,funcoes;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    StatusBar1: TStatusBar;
    NMFTP1: TNMFTP;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MaskEdit1DblClick(Sender: TObject);
    procedure MoverREgistrosAntigos(sender:tobject);
    procedure MandarArquivos(sender:tobject);
    procedure NMFTP1PacketSent(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function r1(n:string):string;
var
   aux:string;
begin
   aux:= copy(n,7,4);          //ano
   aux:= aux + copy(n,4,2);    //mes
   aux:= aux + copy(n,1,2);    //dia
   r1:=aux;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   label1.caption := funcoes.lerParam('c:\_ponto\RElogio.ini',00);
end;

function ConexaoXeon:boolean;
begin

   with form1.nmftp1 do
   begin
       if connected then disconnect;
       host := '125.4.4.200';
       port := 21;
       timeout := 1000;
       userid := 'ponto';
       password := 'ponto';
   end;
   try
      form1.nmftp1.connect;
      form1.nmftp1.timeout:=0;
      except
         on e:exception do
            if e.message <> ''then
             Showmessage('Erro  '+ e.message+ 'em '+ form1.nmftp1.host);
         on e:EaccessViolation do
            if e.message <> ''then
             Showmessage('Erro  '+ e.message+ 'em '+ form1.nmftp1.host);
      end;
  if form1.NMFTP1.connected then
     ConexaoXeon := true
  else
     ConexaoXeon := false;
end;
function pegaloja:String;
begin
   pegaloja := copy(form1.caption,01,03);
end;
function Ehdata(d:string):boolean;
var
   aDate: TDateTime;
begin
  try
     adate := StrToDate(d);
     Ehdata := true;
  except
     on e:exception do
     Ehdata := false;
  end;
end;


procedure tform1.MoverREgistrosAntigos(sender:tobject);
var
   i,j:integer;
   a,o,d:textfile;
   l:string;
begin
   i:=0;j:=0;
   assignFile(o,label1.caption);
   reset(o);

   assignFile(a,'c:\_ponto\Auxiliar.txt');
   rewrite(a);

   assignFile(d,'c:\_ponto\RegistrosAntigos_'+pegaloja()+'.ANT');

   if fileexists ('c:\_ponto\RegistrosAntigos_'+pegaloja()+'.ANT')  then
      append(d)
   else
      rewrite(d);

   while eof(o) = false do
   begin
      readln(o,l);
      inc(i);
      if r1(copy(l,01,10)) <= r1(copy(maskedit1.text,01,10)) then
      begin
         writeln(d,l);
         inc(j);
      end
      else
         writeln(a,l);

      statusbar1.SimpleText:='Lidas -> ' +IntTostr(i)+ '  Achadas -> '+inttostr(j);
   end;
   closefile(o);
   closefile(d);
   closefile(a);

   deleteFile(label1.caption);
   renamefile('c:\_ponto\Auxiliar.txt',label1.caption);

   MandarArquivos(sender);
end;

procedure tform1.MandarArquivos(sender:tobject);
begin
   try
      if conexaoXeon then
      begin
         nmftp1.mode(mode_image);
         nmftp1.upload('c:\_ponto\RegistrosAntigos_'+pegaloja()+'.ANT','RegistrosAntigos_'+pegaloja()+'.ANT');
         nmftp1.Disconnect;
         statusbar1.simpletext := 'Concluido....';
      end;
    except
       on e:exception do
       showmessage('   Ocorreum erro ao transmitir o arquivo' +#13+
                   '   O erro foi este :    ' + e.message);
    end;
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
  if paramStr(1) <> 'MRegAnt' then application.terminate
end;



procedure TForm1.MaskEdit1DblClick(Sender: TObject);
begin
   if not(ehdata(maskedit1.text)) then
     statusbar1.SimpleText := 'Data invalida'
   else
      if application.messagebox(pchar('Deseja mover os registro da loja '+ PegaLoja() + ' até a data '+ maskedit1.text+ ' ??'), 'Mover os registros antigos', mb_yesno + mb_iconwarning)= mryes then
      begin
         screen.cursor := crhourglass;
         MoverREgistrosAntigos(sender);
         screen.cursor := crdefault;
      end;
end;


procedure TForm1.NMFTP1PacketSent(Sender: TObject);
begin
   statusbar1.SimpleText := 'Enviando ' + InttoStr(nmftp1.bytesSent) +' de ' +InttoStr(nmftp1.bytesTotal);
end;

procedure TForm1.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
   IF KEY = #13 THEN
      MaskEdit1DblClick(Sender)
end;

end.
