unit funcD5;

interface
       function lerParam(nomeArq:string;numParam:integer):string;
       function EhCodigo(str:string):boolean;
       function FiltraStr(str:string):string;
       function FiltraNum(str:string;NumDec:integer):string;
       function gravaParam(nomeArq,Str:string;numParam:integer):boolean;
       function preencheCampo(tamanho:integer;Com,Onde,Str:string):string;
       function tiraEspaco(str:string):string;
       function AjustaNumPag(str:string):string;
       function StrToSqlDate(Str:string):string;
       function EhDataValida(Str:string):Boolean;
       function AjPrecos(NumDginteiro,NumDgdec:integer;str:String):string;
       function AaaaMdDdToDdMmAaaa(str:string):string;
       function SohNumeros(str:string):string;
       function GravaLinhaEmUmArquivo(nomeArq,texto:string):boolean;
       function RemAcentos(Str:String):boolean;
       function CalDgCNPJCPF( str:string):string;
       function DigCNPJCPF(Num09Digitos:String) : String;
       function NumLinArq(Arquivo: string): String;
       function DialogAbrArq(DirInicial:string):string;
       function EhHoraValida(hora:string):boolean;
       Function TempDir: String;
implementation

uses windows,dialogs,SysUtils,classes;

var
   i:integer;

Function TempDir: String;
var TempDir: array[0..255] of Char;
begin
   GetTempPath(255, @TempDir);
   Result := StrPas(TempDir);
end;

function EhHoraValida(hora:string):boolean;
begin
      EhHoraValida := false;
   if (StrToInt(Copy(hora,01,02)) >= 0 ) and (StrToInt(Copy(hora,01,02)) < 24 ) and
      (StrToInt(Copy(hora,04,02)) >= 0 )or (StrToInt(Copy(hora,04,02)) < 60 ) then
      EhHoraValida := true;
end;


function SohNumeros(str:string):string;
var
  i:smallint;
  aux:string;
begin
   aux:='';
   for i:=1 to length(str) do
      if str[i] in ['0'..'9'] then
         aux := aux + str[i];
  result :=aux;
end;


function AaaaMdDdToDdMmAaaa(str:string):string;
begin
   if length(str) < 8 then
      AaaaMdDdToDdMmAaaa := '00000000'
   else
      AaaaMdDdToDdMmAaaa := copy(str,07,02) +copy(str,05,02)+ copy(str,01,04);
end;

function AjPrecos(NumDginteiro,NumDgdec:integer;str:string):string;
var
  PosDecSep,i:integer;
  p1,p2:string;
begin
   if pos(',',str) > 0 then
      PosDecSep := pos(',',str)
   else
      if pos('.',str) > 0 then
         PosDecSep := pos('.',str)
   else
      PosDecSep := length(str)+1;

   p1 := copy(str, 01, PosDecSep -1 );
   p2 := copy(str, PosDecSep +1, NumDgdec );

   while length(p1) < NumDginteiro do
      p1 := '0'+p1;
   while length(p2) < NumDgdec do
      p2 := p2+ '0';
   AjPrecos := p1+p2;
end;

function EhDataValida(Str:string):Boolean;
begin
   EhDataValida:=true;
   try
      StrToDate(str)
   except
      on e:exception do
         EhDataValida := false;
   end;
end;


function StrToSqlDate(Str:string):string;
begin
   StrToSqlDate := copy(Str,04,02) + '/' + copy(Str,01,02) +'/'+ copy(Str,07,04)
end;

function AjustaNumPag(str:string):string;
begin
   while length(str) < 3 do
      insert('0',str, 01);
   AjustaNumPag := str;
end;

function tiraEspaco(str:string):string;
begin
   while pos(' ',str) > 0 do
      delete(str,pos(' ',str),01);
   tiraEspaco:= str;
end;


function preencheCampo(tamanho:integer;Com,Onde,Str:string):string;
begin
   if pos('NULL',STR) > 0 then
      delete(str,pos('NULL',STR),04);
   if upcase(onde[1]) = 'D' then
      while length(str) < tamanho do
         insert(com,str,length(str)+1)
   else
      while length(str) < tamanho do
         insert(com,str,01);
   result := (str);
end;

function gravaParam(nomeArq,Str:string;numParam:integer):boolean;
var
  ent,sai:textFile;
  i:integer;
  l:string;
begin
  {Grava no arquivo e fecha, a 1∫ linha È a linha zero}
  try
   if FileExists(nomeArq) = false then
   begin
      assignFile(ent,nomeArq);
      rewrite(ent);
      CloseFile(ent);
   end;

   assignFile(ent,nomeArq);
   reset(ent);
   assignFile(sai,'temp.txt');
   REWRITE(sai);
   for i:=0 to (numParam)-1 do
   begin
     readln(ent,l);
     writeln(sai,l);
   end;
   readln(ent,l);
   delete(l,pos('=',l)+1, length(l));
   writeln(sai,l+str);
   while eof(ent) = false do
   begin
     readln(ent,l);
     writeln(sai,l);
   end;
   closeFile(ent);
   closeFile(sai);
   gravaParam :=true;
   deletefile(pchar(nomeArq));
   RenameFile('temp.txt',nomearq);
  except
     gravaParam :=true;
  end;
end;


function lerParam(nomeArq:string;numParam:integer):string;
var
  arq:textFile;
  i:integer;
  l:string;
begin
   if FileExists(nomeArq) = true then
   begin
      assignFile(arq,NomeArq);
      reset(arq);
      for i:= 0 to numparam do
        readln(arq,l);
      Closefile(arq);
      while pos('=',l) > 0 do
         delete(l,01,01);
      lerParam := l;
    end
    else
      lerParam := '';
end;

function EhCodigo(str:string):boolean;
begin
  result := true;
  for i:=1 to length(str) do
     if str[i] in ['0'..'9'] = false  then
     begin
        result:= false;
        break;
     end;
  if length(soHnumeros(str)) <> 7 then
     result:= false;
end;

function FiltraStr(str:string):string;
var
  i:smallint;
begin
   result := '';
   if pos('NULL',str) > 0 then
      delete( str,pos('NULL',str),04);
   if pos('NU',str) > 0 then
      delete( str,pos('NU',str),02);

   for i:=1 to length(str) do
      if str[i] in ['a'..'z','A'..'Z','0'..'9',' '] then
         result:= result + str[i];
end;


function FiltraNum(str:string;NumDec:integer):string;
var
  i:smallint;
  aux:string;
begin
   result := '';
   for i:=1 to length(str) do
      if str[i] in ['0'..'9'] then
         aux := aux + str[i];
  insert('.',aux,(length(aux)) - (NumDEc-1));
  result :=aux;
end;

function GravaLinhaEmUmArquivo(nomeArq,texto:string):boolean;
var
   arq:textfile;
begin
   try
      assignfile(arq, nomearq);
      if fileExists(nomeArq) = false then
         rewrite(arq)
      else
         append(arq);

      writeln(arq,texto);
      closefile(arq);
      GravaLinhaEmUmArquivo:= true;
   except
      GravaLinhaEmUmArquivo := false;
   end;
end;

function RemAcentos(Str:String):boolean;
Const
   CA = '·‡„‚‰ÈËÍÎÌÏÓÔÛÚÙˆ˙˘˚¸Á¿¡√¬ƒ…» ÀÕÃŒœ”“‘÷⁄Ÿ€‹«';
Var
   x : Integer;
Begin
   RemAcentos := false;
   For x := 1 to Length(Str) do
      if Pos(Str[x],CA)<>0 Then
   RemAcentos := true;
end;

function DigCNPJCPF(Num09Digitos:String) : String;
var
  i,j,k, Soma, Digito : Integer;
  CNPJ : Boolean;
begin
  Result := Num09Digitos;
  case Length(Num09Digitos) of
     9: CNPJ := False;
     12:CNPJ := True;
  else
     Exit;
  end;

  for j := 1 to 2 do
  begin
     k := 2;
     Soma := 0;
     for i := Length(Result) downto 1 do
     begin
        Soma := Soma + (Ord(Result[i])-Ord('0'))*k;
        Inc(k);
        if (k > 9) and CNPJ then
           k := 2;
     end;
     Digito := 11 - Soma mod 11;
     if Digito >= 10 then
        Digito := 0;
     Result := Result + Chr(Digito + Ord('0'));
  end;
end;

function CalDgCNPJCPF( str:string):string;
var
   aux:string ;
begin
   aux :=DigCNPJCPF(str);
   CalDgCNPJCPF := copy(aux,length(aux)-1 ,02);
end;

function NumLinArq(Arquivo: string): String;
var
  arq:TextFile;
  l:string;
  TamArq,col:integer;
begin
   with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
      try
         TamArq := Size;
      finally
         Free;
      end;
   AssignFile(arq,arquivo);
   reset(arq);
   readln(arq,l);
   CloseFile(arq);
   col := length(l);
   NumLinArq := Inttostr( tamArq div col )
end;

function DialogAbrArq(DirInicial:string):string;
var
   CxDialogo:TOpenDialog;
begin
   CxDialogo :=TOpenDialog.create(CxDialogo);
   if DirInicial <> '' then
      CxDialogo.InitialDir := DirInicial
   else
      CxDialogo.InitialDir := 'c:\';
   if CxDialogo.Execute then
      DialogAbrArq := CxDialogo.FileName;
end;

end.
