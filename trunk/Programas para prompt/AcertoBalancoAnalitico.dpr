program AcertoBalancoAnalitico;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
   arq,dest:textfile;
   aux,l:string;
begin
{ TODO -oUser -cConsole Main : Insert code here }
  writeln('Este programa le o arquivo gerado pelo relatorio Balancete Analitico');
  writeln('que deve estar em c:\Cf.txt e retorn o arquivo c:\saida.txt');
  writeln('');
  write  ('Tecle algo para continuar.....');
  readln;
  assignfile(arq,'c:\cf.txt');
  reset(arq);
  assignFile(dest,'c:\saida.txt');
  rewrite(dest);
  while eof(arq) = false do
  begin
     readln(arq,l);
     if length(l) < 130 then
     begin
        delete(l,101,30);
        while length(l) < 132 do
        begin
          aux:=copy(l,80,01);
            if aux = '' then aux := ' ';
          insert(aux,l,80);

         end;
     end;
        writeln(dest,l);

  end;
     closefile(arq);
     closefile(dest);
end.
 