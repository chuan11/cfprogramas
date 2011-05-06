program BackupPastaTemp;

{$APPTYPE CONSOLE}

uses
  windows,
  SysUtils,
  funcoes;

var
  dia,mes,ano:string;
  cmd:string;
begin
   if  Paramstr(1)<> '' then
   begin
      ano := copy(DateToStr(now),07,04);
      mes := copy(DateToStr(now),04,02);
      dia := copy(DateToStr(now),01,02);
      cmd := 'rar a -o+ "' + Paramstr(1) +'CopiaTemp ' + ano +'-'+ mes +'-'+ dia+'.rar" c:\temp\* ';
//      writeln('Comando :' + cmd);
//      readln;
      winexec(pchar(cmd),sw_normal);
//      readln;
   end
   else
   begin
      writeln('Falta o destino da copia');
      writeln('Ex: c:\  ou c:\LogMonitor\');
      funcoes.GravaLinhaEmUmArquivo('c:\LogErrosSalvaCopiaTemp.txt','Erro no dia:' + DateToStr(now) );
      readln;
   end;


end.
 