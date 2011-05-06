 program VerNumColArq;

{$APPTYPE CONSOLE}

uses
  Windows,funcoes,SysUtils,CRT32 ;

var
  dest,arq:TextFile;
  l:string;
  tamLinha,i:real;

begin   { TODO -oUser -cConsole Main : Insert code here }
   writeln('---------------------------------------------------------------------------');
   writeln(' Este programa e usado para conferir as colunas de um arquivo');
   writeln(' A primeira coluna e o tamanho de referencia. Sao mantidas somente ');
   writeln(' as linhas com a quantidade de colunas iguais a da referencia.');
   writeln(' As linhas diferentes sao movidas para c:\ColErradas.txt ');
   writeln('---------------------------------------------------------------------------');

   writeln('Arquivo e: ' + paramstr(1) + ', Tecle algo para continuar');
   readln;
   if fileexists(paramStr(1)) = true then
   begin
      assign(arq, paramStr(1) );
      reset(arq);

      AssignFile( dest, 'c:\Temp.tmp');
      rewrite(dest);

      readln( arq, l );
      tamlinha := length(l);
      i:=0;
      i:= i+1;

      while eof (arq) = false do
      begin
         gotoXY(06,20);write('Lendo linha :' + Floattostr(i));
         if length(l) = tamlinha then
            writeln(dest,l)
         else
         begin
            funcoes.GravaLinhaEmUmArquivo('c:\ColErradas.txt',' linha : ' +  floattostr(i) + '  Tamanho : '+inttostr(length(l)) + l ) ;
            gotoxy(06,21); writeln(' linha : ' +  floattostr(i) + '  Tamanho : '+inttostr(length(l)) ) ;
         end;
         i:=i+1;
         readln(arq,l);
      end;
      closefile(arq);
      closefile(Dest);
      deleteFile(paramStr(1));
      Renamefile('c:\Temp.tmp',ParamStr(1));
      writeln('Pronto');
      readln;
   end
   else
   begin
      write('Nao existe o arquivo passado no parametro');
      readln;
   end;

end.
