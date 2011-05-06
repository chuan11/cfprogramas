program AjustaArqCatProdutos;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  funcoes;

var
  arq:textFile;
  l:string;
  i:integer;

begin
  i:=0;
  if ParamStr(1) = '' then
  else
  begin
     write(ParamStr(1));
     assignfile(arq,ParamStr(1));
     reset(arq);
     while eof(arq) = false do
     begin
        readln(arq,l);
        i:= i+1; gotoxy(05,15); write(copy(l,01,20));
        GravaLinhaEmUmArquivo('c:\CategoriaProduto_correto.txt', copy(l,01,20) + preencheCampo(30,' ','d','1')   + preencheCampo(29,' ','d',funcoes.SohNumeros(copy(l,21,10))) );
        i:= i+1; gotoxy(05,15); write(copy(l,01,20));
        GravaLinhaEmUmArquivo('c:\CategoriaProduto_correto.txt', copy(l,01,20) + preencheCampo(30,' ','d','2')   + preencheCampo(29,' ','d',SohNumeros(copy(l,51,10))) );
     end;
     CloseFIle(arq);
  end;


end.
