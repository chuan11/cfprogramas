 program VerificaDuplicidade;

{$APPTYPE CONSOLE}

uses
  Windows,classes,  funcoes,
  SysUtils,
  CRT32 in '..\Funcoes\CRT32.pas';

var
  dest,arq:TextFile;
  Str:string;
  inicio,tam,i,j:integer;
  List:TStringList;
  EhDuplo:boolean;
begin
   writeln('---------------------------------------------------------------------------');
   writeln(' Este programa e usado para verificar se existem linha duplicadas num arquivo');
   writeln(' param1 = nome do arquivo, Param2 = pos inicial, Param3= tamanho da string');
   writeln(' Os registro repetidos sao movidos para c:\LinhasRepetidas.txt');
   writeln('---------------------------------------------------------------------------');

   list:= tstringlist.Create;

   writeln('Arquivo e: ' + paramstr(1));
   write('Tecle algo para continuar...'); readln;

   if fileexists(paramStr(1)) = true then
   begin
      if paramStr(2) = '' then
      begin
         write('Inicio do intervalo: ');readln(inicio)
      end
      else
         inicio := StrToInt(paramStr(2));

      if paramStr(3) = '' then
      begin
         write('Tamanho do intervalo: ');readln(tam);
      end
      else
         tam  := StrToInt(paramStr(3));


      assign(arq, paramStr(1) );
      reset(arq);
      gotoXY(01,11);write('Criando a lista:...') ;
      while eof(arq) = false  do
      begin
         readln(arq,str);
         list.Add(str);
         gotoxy(15,20);writeln(copy(list[list.count-1],inicio,tam));
      end;


      reset(arq);


      AssignFile( dest, 'c:\Temp.tmp');
      rewrite(dest);

      gotoXY(01,11);writeln('Verificando duplicidades...') ;

      for i:=1 to list.Count-1 do
      begin
         EhDuplo := false;
         gotoxy(15,20);write('Produto :' +  IntToStr(i) + '  '+copy(list[i],inicio,tam) );
         for j:=i+1 to list.Count-1 do
            if copy(list[i],inicio,tam) = copy(list[j],inicio,tam) then
            begin
               EhDuplo := true;
               funcoes.GravaLinhaEmUmArquivo('c:\LinhasRepetidas.txt',list[i])
            end;

         if ehduplo = false then
            writeln(dest,list[i])
      end;


      closefile(arq);
      closefile(Dest);
//      deleteFile(paramStr(1));
//      Renamefile('c:\Temp.tmp',ParamStr(1));
      writeln('Pronto');
      readln;
    end
   else
   begin
      write('Nao existe o arquivo passado no parametro');
      readln;
   end;


end.
