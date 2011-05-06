program VerListaDeForn;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
   ent,sai:textfile;
   str:string;
   forne:array[1..1000] of string[6];
   i,j:integer;

function existe(str:string):boolean;
var
   i:integer;
begin
   existe := false;
   for i:= 0 to 1000 do
      if str = forne[i] then
         existe:= true;
end;

begin
   i := 0;
   j := 0;

   writeln('Esse arquivo le numeros de fonecedores repetidos de (num forn de 01a05)');
   writeln('de um arquivo c:\entrada.txt');
   writeln('e gera uma lista com cada um delees');
   writeln('No arquivo c:\saida.txt');
   write('Tecle algo para continuar');
   readln;

   assignFile( ent, 'c:\entrada.txt');
   reset(ent);

   while eof(ent) = false do
   begin
      readln(ent, str);
      writeln(str);
      if existe(str) = false then
      begin
         inc(i);
         forne[i] := str;
         writeln( 'Forcenedor ' +  forne[i]); sleep(100);
      end;
   end;

   closeFile(ent);


   assignFile(sai,'c:\saida.txt');
   rewrite(sai);

   for j:=1 to i do
   begin
      writeln(sai,forne[j]);
   end;

   CloseFile(sai);

  { TODO -oUser -cConsole Main : Insert code here }
end.
