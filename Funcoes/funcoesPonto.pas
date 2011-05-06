unit funcoesPonto;

interface
uses printers,windows,dialogs,SysUtils,classes,MaskUtils,Registry,   unMsgTela2,
     Messages, Variants, Graphics, Controls, Forms,QStdCtrls,StdCtrls,dateUtils,
     adLabelComboBox, TFlatButtonUnit, ADODB, SoftDBGrid,
     QExtCtrls, ShellAPI, adLabelCheckListBox, ComCtrls, TFlatCheckBoxUnit, IniFiles;


       function AaaaMdDdToDdMmAaaa(str:string):string;
       function AjPrecos(NumDginteiro,NumDgdec:integer;str:String):string;
       function AjustaNumPag(str:string):string;
       function ArredondarPreco(num:real):real;
       function buscaEmCombobox(str:string; cbox:TCustomComboBox):integer;
       function calculaReajuste(valor,percentual:Real; Arredonda:boolean):String;
       function CalDgCNPJCPF( str:string):string;
       function DataDoArquivo(arq:String):TDateTime;
       function dataPorExtenso(data:Tdate):string;
       function dataToInt(data:Tdate):integer;
       function DateTimeToSqlDateTime(data,hora:string):string; OverLoad;
       function DateTimeToSqlDateTime(data:Tdate; hora:string):string;  overload;
       function dateToInteiro(str:string):string;
       function dateToSQLDateInt(data:String):String; overload;
       function dateToSQLDateInt(data:Tdate):String; overload;
       function DialogAbrArq(TpArquivo,DirInicial:string):string;
       function DialogSalvaArq(DirInicial,extensao,SugestaoNmArq:string):string;
       function DigCNPJCPF(Num09Digitos:String) : String;
       function ehAnoBiSexto(Ayear: Integer): Boolean;
       function EhCodigo(str:string):boolean;
       function EhDataValida(Str:string):Boolean;
       function EhHoraValida(hora:string):boolean;
       function ehParametroInicial(param:String):boolean;
       function execFileExternal(form:Tform; arq:String):Boolean;
       function ExisteParametro(Parametro:String):boolean;
       function existsParam(sessao, parametro:String):boolean;
       function FiltraNum(str:string;NumDec:integer):string;
       function FiltraStr(str:string):string;
       function floatToDinheiro(valor:Real):String;
       function FloatToStrFomatado(Str:string):String;
       function getCodCaixa(cb:TCustomComboBox): String;
       function getCodPc(cb:TCustomComboBox):String;
       function getCodUO(cb:TadLabelCheckListBox):String; overload;
       function getCodUO(cb:TCustomComboBox):String;  overload;
       function getCodModPagto(cb:TCustomComboBox): String;
       function getDadosConexaoUDL(nomeArq:string):string;
       function getDatePart(parte:String;data:Tdate):String;
       function getDirExe():String;
       function getDirLogs():String;
       function getLinhasMemo(linhas:Tstrings):String;
       function getNomeDaEstacao() : string;
       function getNomeDoCx(cb:TCustomComboBox):String;
       function GetNomeDoMicro() : string;
       function getNomePc(cb:TCustomComboBox):String;
       function getNomeUO(cbox:TcomboBox):string;
       function getNomeModPagto(cbox:TcomboBox):string;
       function getNomeCX(cbox:TcomboBox):string;
       function getNumUO(cbox:TcomboBox):string;
       function getParamLnComando(nmParam:String):String;
       Function getWinDir: String;
       function gravaArqParam(sessao,parametro,valor:String):boolean;
       function GravaLinhaEmUmArquivo(nomeArq,texto:string):boolean;
       function gravaLog(cmd:String):Boolean;
       function gravaLogErros(cmd:String):Boolean;
       function gravaParam(nomeArq,Str:string;numParam:integer):boolean;
       function horaToInt(hora:string):integer;
       function intToHora(x:integer):String;
       function lerParam(nomeArq:string;numParam:integer):string;
       function lerParamNome(nomeArq:string;nomeParam:string):string;
       function limparLog():boolean;
       function loadStrFromFile(arq:String):String;
       function msgTela(titulo, Msg: string; iconeBotao: integer): integer;
       function MsgTela2(titulo, Msg: string; iconeBotao: integer): integer;
       function NumLinArq(Arquivo: string): String;
       function PrecoSqlToStr(Str:String):string;
       function preencheCampo(tamanho:integer;Com,Onde,Str:string):string;
       function readArqParamStr(sessao,parametro,valor:String):String;
       function RemAcentos(Str:String):boolean;
       Function RParReg(folder,Key:string):string;
       function RParRegBool(folder,Key:string):Boolean;
       function RParRegDate(folder,Key:string):Tdate;
       function RParRegDateTime(folder,Key:string):TdateTime;
       function RParRegInt(folder,Key:string):integer;
       function SohLetras(str:string):string;
       function SohNumeros(str:string):string;
       function SohNumerosPositivos(str:string):string;
       function StrToData(Str:String):TdateTime;
       function StrToMoney(Valor: String) : String;
       function StrToPrecoSQL(Str:String):String; overload;
       function StrToPrecoSQL(Valor:real):String; overload;
       function StrToSqlDate(data:TdateTimePicker):string; overLoad;
       function StrToSqlDate(Str:string):string; overLoad;
       function TamArquivo(Arquivo: string): Integer;
       Function TempDir: String;
       function tiraEspaco(str:string):string;
       function tiraEspacoFim(str:string):string;
       function ultimoDisDoMes(DiaInicial:String):String;
       function valorSql(str:string):string;
       procedure carregaCampos(form:Tform);
       procedure Criaparametro(arq,nome,valor:string; numParam:integer);
       procedure imprimeArquivoPorta(NomeArq:String; nomePorta:string);
       procedure limparCamposform(  form:Tform);
       procedure MontaArquivoImpressao(titulo,corpo:TStrings);
       procedure renomearArquivoUpgrade(arqNovo, arqAntigo:String);
       procedure salvaCampos(form:Tform);
       procedure salvaColunasDbGrid(grid: TSoftDbgrid);
       procedure SetPrinterPage(Width, Height : LongInt);
       procedure WParReg(folder,NomeParametro,valor:string);
       procedure WParRegBolean(folder,NomeParametro:string; valor:Boolean);
       procedure WParRegDate(folder,NomeParametro:string; valor:Tdate);
       procedure WParRegint(folder,NomeParametro:string; valor:integer);

implementation
var
   i:integer;

function getCodUO(cb:TCustomComboBox): String; overload;
begin
   result := trim(copy(cb.Items[cb.itemIndex], 51, 08));
end;

function getCodCaixa(cb:TCustomComboBox): String;
begin
   result := getCodUO(cb);
end;

function getCodModPagto(cb:TCustomComboBox): String;
begin
   result :=getCodUO(cb);
end;

function getCodUO(cb:TadLabelCheckListBox):String; overload;
begin
   result := copy(cb.Items[cb.itemIndex], 51, 08);
end;

function getNomeDoCx(cb:TCustomComboBox):String;
begin
   result := trim(copy(cb.Items[cb.itemIndex], 01, 50));
end;


function getDirLogs():String;
begin
   ExtractFilePath(paramStr(0) + 'logs\');
end;


function ultimoDisDoMes(DiaInicial:String):String;
var
  d,m,a:integer;
begin
   m:= strToInt(copy(DiaInicial,04,02));
   a:= strToInt(copy(DiaInicial,07,04));

   case m of
      1,3,5,7,8,10,12: d:= 31;
      4,6,9,11: d:=30;
   else
      begin
         if  ehAnoBiSexto(a) = true then
             d := 29
         else
             d := 28;
      end;
   end;
   result := intToStr(d) +'/'+ preencheCampo(02,'0', 'e', intToStr(m) ) +'/'+ intToStr(a) ;
end;


function ehAnoBiSexto(Ayear: Integer): Boolean;
begin
   Result := (AYear mod 4 = 0) and ( (AYear mod 100 <> 0) or (AYear mod 400 = 0) );
end;


function getDatePart(parte:String; data:Tdate):String;
begin
   if pos('a', parte) > 0 then
      result := copy(dateToStr(data),07,04)
   else if pos('m', parte) > 0 then
      result := copy(dateToStr(data),04,02)
   else
      result := copy(dateToStr(data),01,02);
end;


function getNumUO(cbox:TcomboBox):string;
begin
   if cbox.ItemIndex < 0 then
      result := '0'
   else
      result := funcoes.preencheCAmpo(8,'0','d', sohNumeros(copy(cbox.Items[cbox.itemIndex],50,150)) );
end;


function getNomeUO(cbox:TcomboBox):string;
begin
   result := copy(cbox.Items[cbox.itemIndex],01,30) ;
end;


function getNomeModPagto(cbox:TcomboBox):string;
begin
   result := getNomeUO(cbox);
end;

function getNomeCX(cbox:TcomboBox):string;
begin
   result := getNomeUO(cbox);
end;


function dataPorExtenso(data:Tdate):string;
var
  aux:string;
begin
   aux := intToStr(DayOf (data));

   case MonthOfTheYear(data) of
      1:aux := aux+ ' de janeiro de ';
      2:aux := aux+ ' de fevereiro de ';
      3:aux := aux+ ' de marco de ';
      4:aux := aux+ ' de abril de ';
      5:aux := aux+ ' de maio de ';
      6:aux := aux+ ' de junho de ';
      7:aux := aux+ ' de julho de ';
      8:aux := aux+ ' de agosto de ';
      9:aux := aux+ ' setembro de ';
      10:aux := aux+ ' de outubro de ';
      11:aux := aux+ ' de novembro de ';
      12:aux := aux+ ' de dezembro de ';
   end;
   aux := aux+ IntToStr(YearOf(data));
   result := aux;
end;


function FloatToStrFomatado(Str:string):String;
begin
   while pos(',',str) > 0 do delete(Str,pos(',',str),01);
   while pos(' ',str) > 0 do delete(Str,pos(' ',str),01);
   while pos('.',str) > 0 do delete(Str,pos('.',str),01);

   str:= funcoes.sohNumeros(str);
   FloatToStrFomatado := floattostrf(StrTofloat(str),ffNumber,18,2);
end;

function DataDoArquivo(arq:String):TDateTime;
var
   Fhandle: integer;
begin
   try
      FHandle := FileOpen(arq,0);
      result := FileDateToDateTime(FileGetDate(FHandle));
      FileClose(FHandle);
   except
      result := strToDateTime('01/01/1900 00:00:00');
   end;
end;

procedure Criaparametro(arq,nome,valor:string; numParam:integer);
var
   lista:tstringlist;
begin
   lista := tstringlist.Create;
   lista.LoadFromFile(arq);
   while numParam >= lista.Count do
      lista.add('');

   lista[numParam] := IntTostr(numParam);
   if length(lista[numParam]) < 2 then
      lista[numParam] := '0' + lista[numParam];
   lista[numParam] := lista[numParam] + ' ' + nome + '=' + valor;
   lista.SaveToFile(arq);
end;

function valorSql(str:string):string;
var
   i:integer;
begin
   while pos('.',str) > 0  do delete( str, pos('.',str) ,1);
   for i:=0 to length(str) do
      if str[i] = ',' then
      begin
         delete(str,i,01);
         insert('.',str,i);
      end;
    ValorSql:=str;
end;

Function GetWinDir: String;
var TempDir: array[0..255] of Char;
begin
   GetWindowsDirectory(@TempDir,255);
   Result := StrPas(TempDir);
end;


Function TempDir: String;
var TempDir: array[0..255] of Char;
begin
   GetTempPath(255, @TempDir);
   Result := StrPas(TempDir);
end;

function StrToMoney(Valor: String) : String;
var
   i:integer;
begin
   for i:=1 to length(Valor) do
   begin
      if Valor[i] in ['0'..'9',',']  = false then
         delete(Valor,i,01);
   end;
   if valor = '' then
      valor := '0';
   Result := tiraespaco(FormatMaskText('!aaaaaaaaaaaaaa;0; ',(FormatFloat('#,##0.00',StrToFloat(valor))))  );
end;

function EhHoraValida(hora:string):boolean;
begin
      EhHoraValida := false;
   if (StrToInt(Copy(hora,01,02)) >= 0 ) and (StrToInt(Copy(hora,01,02)) < 24 ) and
      (StrToInt(Copy(hora,04,02)) >= 0 )or (StrToInt(Copy(hora,04,02)) < 60 ) then
      EhHoraValida := true;
end;

function SohLetras(str:string):string;
var
  i:smallint;
  aux:string;
begin
   aux:='';
   for i:=1 to length(str) do
      if str[i] in ['a'..'z','A'..'Z'] then
         aux := aux + str[i];
  result :=aux;
end;

function SohNumeros(str:string):string;
var
  i:smallint;
  aux:string;
begin
   aux:='';
   for i:=1 to length(str) do
      if str[i] in ['-','0'..'9'] then
         aux := aux + str[i];
  result :=aux;
end;

function SohNumerosPositivos(str:string):string;
begin
   str := sohNumeros(str);
   while pos('-',str) > 0 do
      delete( str, pos('-',str) , 1 );
   result := str;
end;

function dateToInteiro(str:string):string;
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
  PosDecSep:integer;
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
var
   aux:string;
begin
   aux := copy(Str,07,04) + '-' + copy(Str,04,02) +'-'+ copy(Str,01,02);
   if pos(' ',str) = 0 then
      aux  := quotedStr(aux);
   result := aux;
end;

function StrToSqlDate(data:TdateTimePicker):string;
begin
   result := StrToSqlDate(DateToStr(data.Date));
end;


function DateToSqlDate(data:Tdate):string;
begin
   result := StrToSqlDate(dateToStr(data));
end;

function DateTimeToSqlDateTime(data,hora:string):string; OverLoad;
var
   aux:String;
begin
  if hora = '' then hora := '00:00:00';
   aux := dateToSqldate( StrToDate(data));
   insert(' '+hora,aux, length(aux));
   Result := aux;
end;

function DateTimeToSqlDateTime(data:Tdate; hora:string):string; Overload;
var
  aux:string;
begin
   aux := DateToSqlDate(data);
   insert( hora, aux, length(aux));
   result := aux;
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

function tiraEspacoFim(str:string):string;
begin
   while pos('  ',str) > 0 do
      delete(str,pos('  ',str),01);
   tiraEspacoFim:= str;
end;


function preencheCampo(tamanho:integer;Com,Onde,Str:string):string;
begin
   if pos('NULL',STR) > 0 then
      delete(str,pos('NULL',STR),04);
   if upcase(onde[1]) = 'D' then
      while length(str) < tamanho do
         insert(com,str,length(str)+1)
   else
      while length(str) <> tamanho do
      begin
          if length(str) < tamanho then
              insert(com,str,01)
          else
              delete(str, length(str)-1,01);
      end;
   result := (str);
end;

function gravaParam(nomeArq,Str:string;numParam:integer):boolean;
var
   Arq:TstringList;
   aux:string;
begin
   try
      arq:= Tstringlist.Create();
      arq.loadFromFile(nomeArq);
      if numParam > arq.Count -1 then
         arq.Add(str)
      else
      begin
         aux := arq[numParam];
         delete( aux, pos('=',aux)+1, length(aux));
         aux:= aux+ str;
         arq[numParam] := aux;
         arq.SaveToFile(nomeArq);
      end;
      result := true;
   except
         result := false;
   end;
end;

function lerParam(nomeArq:string;numParam:integer):string;
var
   arq:Tstringlist;
   l:string;
begin
   arq := Tstringlist.Create;
   if FileExists(nomeArq) = true then
   begin
      arq.LoadFromFile(nomeArq);
      if numparam >= arq.count then
         lerParam:= '*'
      else
      begin
         l:= arq[numParam];
         while pos('=',l) > 0 do
            delete(l,01,01);
         lerParam := l;
      end;
     arq.Destroy;
   end
   else
      result := '';
end;

function lerParamNome(nomeArq:string;nomeParam:string):string;
var
   arq:Tstringlist;
   l:string;
   i:integer;
begin
   if (FileExists(nomeArq) = true )then
   begin
      arq := Tstringlist.Create;
      arq.LoadFromFile(nomeArq);
      l:='';
      for i:=0 to arq.Count-1 do
      begin
         l:= arq[i];
         if nomeParam = copy( arq[i],01, pos('=', arq[i]) -1) then
         begin
             while pos('=',l) > 0 do
                delete(l,01,01);
             Break;
         end;
      end;
      result := l;
      arq.Destroy;
   end
   else
      msgTela('','Erro ao ler o par‚metro, ' + nomeParam +#13+' N„o encontrei o arquivo: '+ nomeArq, MB_OK+ MB_ICONERROR);
end;


function EhCodigo(str:string):boolean;
var
   i:integer;
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

   if numdec > 0 then
      insert('.',aux,(length(aux)) - (NumDEc-1));

  result :=aux;
end;

function limparLog():boolean;
begin
   result := DeleteFile(ExtractFilePath(ParamStr(0)) +'logs\'+ ExtractFilename(ParamStr(0)) + '_log.txt');
end;

function getDirExe():String;
begin
   result := ExtractFilePath(paramStr(0));
end;

function gravaLog(cmd:String):Boolean;
var
  dir:String;
begin
   dir := getDirExe();
   ForceDirectories(dir +'logs' );
   result := GravaLinhaEmUmArquivo( dir +'logs\' + ExtractFilename(ParamStr(0))  + '_log.txt', cmd);
end;

function gravaLogErros(cmd:String):Boolean;
var
  dir:String;
begin
//   dir := ExtractFilePath(paramStr(0));
//   ForceDirectories(dir +'logs' );
   result := gravaLog(cmd);
   //GravaLinhaEmUmArquivo( dir +'logs\' + Application.Title + '_Erros.txt', cmd);
end;

function GravaLinhaEmUmArquivo(nomeArq,texto:string):boolean;
var
   arq:textfile;
begin
   if nomeArq = '' then
      nomeArq := funcoes.TempDir() +'_gravalinhaEmArquivo.txt';
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
       begin
          funcoes.gravaLog('Erro ao gravar arquivo: '+ nomeArq);
          GravaLinhaEmUmArquivo := false;
       end;
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

function DialogAbrArq(tpArquivo,DirInicial:string):string;
var
   CxDialogo:TOpenDialog;
begin
   CxDialogo :=TOpenDialog.create(CxDialogo);

   if (tpArquivo <> '') then
      CxDialogo.Filter := 'Arquivo ' + TpArquivo +'|*.'+tpArquivo;

   CxDialogo.FilterIndex:=0;

   if DirInicial <> '' then
      CxDialogo.InitialDir := DirInicial
   else
      CxDialogo.InitialDir := 'c:\';

   if CxDialogo.Execute then
      DialogAbrArq := CxDialogo.FileName;
end;

function DialogSalvaArq(DirInicial,extensao,SugestaoNmArq:string):string;
var
   CxDialogo:TSaveDialog;
begin
   CxDialogo :=TsaveDialog.create(CxDialogo);
   if DirInicial <> '' then
      CxDialogo.InitialDir := DirInicial
   else
      CxDialogo.InitialDir := 'c:\';
   CxDialogo.DefaultExt := extensao;
   CxDialogo.Filter := 'Arquivo |*.'+extensao;
   CxDialogo.FileName := SugestaoNmArq;
   if CxDialogo.Execute then
      DialogSalvaArq := CxDialogo.FileName;
end;
procedure WParRegint(folder,NomeParametro:string; valor:integer);
begin
   wParReg(folder,nomeParametro,intToStr(valor));
end;

procedure WParRegDate(folder,NomeParametro:string; valor:Tdate);
begin
   wParReg(folder,nomeParametro,dateToStr(valor));
end;

procedure WParRegBolean(folder,NomeParametro:string; valor:Boolean);
begin
   wParReg(folder,nomeParametro, BoolToStr(valor,true) )
end;


procedure WParReg(folder,NomeParametro,valor:string);
var
  Reg: Tregistry;
begin
  Reg := Tregistry.create;
  with Reg do
  begin
    rootkey := HKEY_CURRENT_USER;
    Openkey('Software\'+folder,true);
    writestring(NomeParametro, valor);
    closekey;
  end;
end;

Function RParReg(folder,Key:string):string;
var
  Reg: Tregistry;
  S: string;
begin
   Reg:=Tregistry.create;
   with Reg do
   begin
      rootkey := HKEY_CURRENT_USER;
      Openkey('SOFTWARE\'+folder+'\',false);
      S := readString(Key);
      closekey;
   end;
   if (s <> '') then
      gravaLog('Lendo registro, chave: ' + folder + ' Parametro: ' + Key + ' Resultado: ' + s)
   else
      gravaLog('Lendo registro, chave: ' + folder + ' Parametro: ' + Key + ' Resultado: ' + 'N„o achei essa chave');
   RParReg:= s;
end;

function RParRegInt(folder,Key:string):integer;
begin
   if RParReg(folder,key) <> '' then
      result := StrToInt(RParReg(folder,key))
   else
      result := -999;
end;

function RParRegDateTime(folder,Key:string):TdateTime;
begin
   if RParReg(folder,key) <> '' then
      result := StrToDateTime(RParReg(folder,key))
   else
      result := 0;
end;

function RParRegDate(folder,Key:string):Tdate;
begin
   if RParReg(folder,key) <> '' then
      result := StrToDate(RParReg(folder,key))
   else
      result := 0;
end;

function RParRegBool(folder,Key:string):Boolean;
var
  aux:String;
begin
   aux := RParReg(folder,key);
   if aux = 'True' then
      result := true
   else
      result := false;
end;

function PrecoSqlToStr(Str:String):string;
begin //
   if pos('.',str) = 1 then
      str := '0'+str;
  insert(',',str, pos('.',str));
  delete(str, pos('.',str),01);
  result := copy(str,01, pos(',',str)+2 );
end;

function getDadosConexaoUDL(nomeArq:string):string;
var
   arq:TstringList;
begin
   if NomeArq = '' then
      nomeArq := extractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini';

   arq:= tstringlist.Create();
   arq.LoadFromFile(nomeArq);

   result  := 'Provider=SQLOLEDB.1;Persist Security Info=False;' +
          arq[0]  +';'+
          arq[01] +';'+
          arq[02] +';'+
          arq[03] +';'+
          'Workstation ID='+ GetNomeDoMicro();
end;

function StrToPrecoSQL(Valor:real):String; overload;
var
  aux: String;
  index:integer;
begin
   aux := floattostrf(valor ,ffNumber,18,2);

   funcoes.GravaLinhaEmUmArquivo('c:\zCredito.txt',aux);

   while pos('.', aux) > 0 do
      delete(aux, pos('.',aux), 1);

   while pos(',', aux) > 0 do
   begin
      index := pos(',', aux);
      Delete( aux, index , 1);
      insert( '.', aux, index);
   end;
   result := aux;
end;

function StrToPrecoSQL(Str:String):String;
begin
   while pos(',',str) > 0 do
   begin
      insert('.', str, pos(',',str));
      delete(str, pos(',',str), 1);
   end;
   result := str;
end;


function GetNomeDaEstacao() : string;
var
   buffer : array[0..255] of char;
   size : dword;
   UserName: String;
   ComputerName: String;
begin
   size := 256;
   GetUserName(buffer, size);
   UserName := buffer;
   size := MAX_COMPUTERNAME_LENGTH + 1;
   GetComputerName(buffer, size);
   ComputerName := buffer;
   Result := (ComputerName +'_'+ UserName);
end;

function GetNomeDoMicro() : string;
begin
   Result := funcoes.SohLetras(GetNomeDaEstacao);
end;

function horaToInt(hora: string): integer;
var
 h,m:String;
begin
   hora := trim(hora);
   h := SohNumeros(copy(hora,01, pos(':',hora) ) );
   m := SohNumeros(copy(hora,pos(':',hora)+1 ,02));
   if ( length(h) > 0) and ( length(m) > 0) then
      result := StrToInt(h) * 60 + strToInt(m)
   else
      result := 0;
end;

function intToHora(x:integer):String;
var
   sinal,aux,h, m :String;
begin
   sinal := '';
   if x < 0 then
   begin
     x:= x *-1;
     sinal := '-';
   end;
   h := inttoStr( x div 60 );
   m := IntToStr( x mod 60 );
   if length(h) < 2 then insert('0',h,1);
   if length(m) < 2 then insert('0',m,1);
   aux := h +':'+ m;
   if aux = '00:00' then
      aux := '  :  ';

    result := sinal + aux;
end;


function StrToData(Str:String):TdateTime;
begin
   try
      result := StrToDate(str);
   except
      result := StrToDate('01/01/1900');
   end;
end;

Procedure MontaArquivoImpressao(titulo,corpo:Tstrings);
begin

end;

function GetDadosConecxao(Arq:string):String;
begin
end;

function msgTela(titulo, Msg: string; iconeBotao: integer): integer;
begin
   if titulo = '' then
      titulo := application.Title;
   result := application.MessageBox(pchar(msg),pchar(titulo), iconeBotao );
end;

procedure SetPrinterPage(Width, Height : LongInt);
var
  Device : array[0..255] of char;
  Driver : array[0..255] of char;
  Port : array[0..255] of char;
  hDMode : THandle;
  PDMode : PDEVMODE;
begin
   printer.GetPrinter(Device, Driver, Port, hDMode);
   if hDMode <> 0 then
   begin
      pDMode := GlobalLock( hDMode );
      If pDMode <> nil then
      begin
         pDMode^.dmPaperSize := DMPAPER_USER;
         pDMode^.dmPaperWidth := Width;
         pDMode^.dmPaperLength := Height;
         pDMode^.dmFields := pDMode^.dmFields or DM_PAPERSIZE;
         GlobalUnlock( hDMode );
     end;
   end;
end;



procedure imprimeArquivoPorta(NomeArq:String; nomePorta:string);
var
  cmd:String;
begin
   Winexec( pchar('cmd.exe /c print /d:'+ nomePorta +' '+NomeArq)  , sw_Hide);
end;

function ehParametroInicial(param:String):boolean;
var
   i:smallint;
begin
   ehParametroInicial := false;
   for i:=1 to 10 do
      if ParamStr(i) = param then
         ehParametroInicial := true;
end;


function getParamLnComando(nmParam:String):String;
var
   i:integer;
begin
   for i:=0 to ParamCount -1 do
   begin
      showMessage( paramStr(i));
      if pos(nmParam,ParamStr(i)) > 0 then
      begin
        showmessage( copy( ParamStr(i) , pos(nmParam,ParamStr(i)) +  length( ParamStr(i) ) , length(ParamStr(i)) -1 ));
        result := copy( ParamStr(i) , pos(nmParam,ParamStr(i)) +  length( ParamStr(i) ) , length(ParamStr(i)) -1 );
        break;
      end;
   end;
end;


function dataToInt(data:Tdate):integer;
var
  ano,dia,mes:word;
begin
   DecodeDate(data, ano, mes, dia);
   result := (ano*365*3) + (mes*30*2) + dia ;
end;

function ExisteParametro(Parametro:String):boolean;
var
   i:smallint;
begin
   ExisteParametro := false;
   for i:=0 to ParamCount do
      if Parametro = ParamStr(i) then
      begin
         result := true;
         break;
      end;
end;

procedure salvaColunasDbGrid(grid: TSoftDbgrid);
var
   i:integer;
begin
   funcoes.GravaLinhaEmUmArquivo('c:\'+application.Title+'.txt', '----------' );
   for i:=0 to grid.Columns.Count-1 do
      funcoes.GravaLinhaEmUmArquivo('c:\'+application.Title+'.txt', inttostr( grid.Columns[i].Width ));
   funcoes.GravaLinhaEmUmArquivo('c:\'+application.Title+'.txt', '----------' );
end;

function loadStrFromFile(arq:String):String;
var
   ent:TstringList;
   i:integer;
   aux:string;
begin
   if FileExists(arq) = true then
   begin
      i:=0;
      ent := TstringList.Create();
      ent.LoadFromFile(arq);
      while i <  ent.Count do
      begin
         aux := aux + ent[i] + ' ';
         inc(i);
      end;
      ent.Destroy;
      result := aux;
   end
   else
      result :='';

end;

procedure salvaCampos(form:Tform);
var
   j,i:integer;
begin
   for i:=0 to form.ComponentCount-1 do
   begin
// edits
      if form.Components[i].InheritsFrom(TcustomEdit) or (form.Components[i].ClassName = 'TadLabelEdit') then
          funcoes.WParReg( 'ProgramasCF\'+ application.Title , form.Components[i].Name, (form.Components[i] as TcustomEdit).text);
// comboBox
      if form.Components[i].InheritsFrom(TCustomComboBox) then
         funcoes.WParReg( 'ProgramasCF\'+ application.Title , form.Components[i].Name, IntToStr((form.Components[i] as TCustomComboBox).ItemIndex) );
// datePicker ou date
      if form.Components[i].InheritsFrom(TDateTimePicker)  or (form.Components[i].ClassName = 'TfsDateTimePicker') then
         funcoes.WParReg( 'ProgramasCF\'+ application.Title , form.Components[i].Name  , dateToStr( (form.Components[i] as TDateTimePicker).date ) );
// pageControl
      if form.Components[i].ClassName = 'TPageControl'  then
         funcoes.WParReg( 'ProgramasCF\'+ application.Title , form.Components[i].Name  , intToStr( (form.Components[i] as TPageControl).tabIndex ) );

      if (form.Components[i].ClassName = 'TFlatCheckBox') then
         funcoes.WParRegBolean('ProgramasCF\'+ application.Title , form.Components[i].Name, (form.Components[i] as TFlatCheckBox).checked);

      if (form.Components[i].ClassName = 'TSoftDBGrid' ) then
      begin
          for j:=1 to (form.Components[i] as TSoftDBGrid).columns.count -1 do
             funcoes.WParRegint('ProgramasCF\'+ application.Title, form.Components[i].Name + '_C_'+intToStr(j), (form.Components[i] as TSoftDBGrid).Columns[j].Width );
      end;
   end;
end;

procedure carregaCampos(form:Tform);
var
   auxInt, j, i:integer;
   aux:String;
begin
   for i:=0 to form.ComponentCount-1 do
   begin
      if form.Components[i].InheritsFrom(TcustomEdit) or (form.Components[i].ClassName = 'TadLabelEdit') then
      begin
         aux := '';
         aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
         (form.Components[i] as TcustomEdit).text := aux;
      end;

      if form.Components[i].InheritsFrom(TCustomComboBox) then
      begin
         aux := '';
         if funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name) <> '' then
         begin
            aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
            (form.Components[i] as TCustomComboBox).Itemindex := strToInt(aux);
         end;
      end;

      if form.Components[i].InheritsFrom(TDateTimePicker) then
      begin
         aux := '';
         if funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name) <> '' then
         begin
            aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
            (form.Components[i] as TDateTimePicker).date :=  strToDate(aux);
         end;
      end;

      if form.Components[i].ClassName = 'TPageControl' then
      begin
         aux := '';
         if funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name) <> '' then
         begin
            aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
            (form.Components[i] as TPageControl).TabIndex := strToInt(aux);
         end;
      end;

      if (form.Components[i].ClassName = 'TFlatCheckBox') then
      begin
         aux := '';
         begin
            aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
            (form.Components[i] as TFlatCheckBox).Checked := funcoes.RParRegBool('ProgramasCF\'+ application.Title, form.Components[i].Name);
         end;
      end;

      if (form.Components[i].ClassName = 'TFlatCheckBox') then
      begin
         aux := '';
         begin
            aux := funcoes.RParReg('ProgramasCF\'+ application.Title, form.Components[i].Name);
           (form.Components[i] as TFlatCheckBox).Checked := funcoes.RParRegBool('ProgramasCF\'+ application.Title, form.Components[i].Name);
         end;
      end;

      if (form.Components[i].ClassName = 'TSoftDBGrid') then
      begin
         for j:=0 to (form.Components[i] as TSoftDBGrid).columns.count -1 do
         begin
           auxInt :=  funcoes.RParRegInt('ProgramasCF\'+ application.Title, form.Components[i].Name + '_C_'+intToStr(j) );
           if (auxInt > -999 )then
              (form.Components[i] as TSoftDBGrid).Columns[j].Width := auxInt;
         end;
      end;
 end;
end;

function ArredondarPreco(num:real):real;
var
  aux:string;
  j:integer;
begin
   aux := copy(  FloatToStrF(num, ffNumber,18,02)  ,length(FloatToStrF(num, ffNumber,18,02)),01);
   if aux = '0' then
      result := num-0.01 //FloatToStrF(num-0.01, ffNumber,18,02)
   else
   begin
      while aux <> '9' do
      begin
         num := num+0.01;
         aux := copy(  FloatToStrF(num, ffNumber,18,02)  ,length(FloatToStrF(num, ffNumber,18,02)),01);
      end;
      result := num; //FloatToStrF(num, ffNumber,18,02);
    end;
end;


function calculaReajuste(valor,percentual:Real; Arredonda:boolean):String;
var
  aux:String;
begin
   if  (arredonda = true) then
      aux :=       (floattostrf(ArredondarPreco(valor + (valor * percentual ) /100) ,ffNumber,18,2) )
   else
      aux :=  floattostrf( (valor + (valor * percentual ) /100), ffNumber,18,02);

   while pos('.',aux) >0 do
      delete(aux, pos('.',aux),01 );

   result := aux;

end;

function getCodPc(cb:TCustomComboBox):String;
begin
   result := funcoes.SohNumeros(copy(cb.Items[cb.ItemIndex],50,50));
end;

function getNomePc(cb:TCustomComboBox):String;
begin
   result := trim( copy(cb.Items[cb.ItemIndex],01,50));
end;

function getLinhasMemo(linhas:Tstrings):String;
var
  i:integer;
  aux:String;
begin
   for i:=0 to linhas.Count -1 do
      aux := aux + linhas[i];
   result :=  quotedStr(aux);
end;

function dateToSQLDateInt(data:Tdate):String;
var
   str:String;
begin
   str := DateToStr(data);
   result := copy(str,07,04) + copy(str,04,02) + copy(str,02,02);
end;

function dateToSQLDateInt(data:String):String;
begin
   result := copy(data,07,04) + copy(data,04,02) + copy(data,02,02);
end;

function floatToDinheiro(valor:Real):String;
begin
   result :=  floatToStrF( valor ,ffNumber,18,2);
end;

procedure limparCamposform(  form:Tform);
var
  i:integer;
begin
   for i:=0 to form.ComponentCount -1 do
   begin
      if form.Components[i].InheritsFrom(TcustomEdit) or (form.Components[i].ClassName = 'TadLabelEdit') then
         (form.Components[i] as TcustomEdit).text := '';
   end;
end;
function TamArquivo(Arquivo: string): Integer;
begin
   with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
   try
      Result := Size;
   finally
      Free;
   end;
end;

function MsgTela2(titulo, Msg: string; iconeBotao: integer): integer;
begin
   application.CreateForm(TfmMsgTela2, fmMsgTela2);
   fmMsgTela2.preparaParaExibir(titulo, Msg, iconeBotao);
   fmMsgTela2.ShowModal;
   result := fmMsgTela2.ModalResult;
end;


function buscaEmCombobox(str:string; cbox:TCustomComboBox):integer;
var
  i,j:integer;
begin
   for i:=0 to CBox.Items.count do
      if pos(str,CBox.Items[i]) > 0 then
      begin
         cbox.ItemIndex := i;
         break;
      end;
end;

procedure renomearArquivoUpgrade(arqNovo, arqAntigo:String);
var
   acao:boolean;
begin
   if( FileExists( extractFilePath(paramStr(0)) + 'UpgradeNovo.exe') = true ) then
   begin
      Funcoes.gravaLog('AtualizaÁ„o do lancador: ');
      acao := deleteFile(pChar(extractFilePath(paramStr(0)) + arqAntigo));
      Funcoes.gravaLog('Deletar arquivo upgrade: ' + boolToStr(acao, true) );
      acao := renameFile( extractFilePath(paramStr(0)) + arqNovo,  extractFilePath(paramStr(0)) + arqAntigo );
      Funcoes.gravaLog('Renomear ' + arqNovo + ' para ' + arqAntigo +': ' + boolToStr(acao, true) );
   end;
end;

function getNmArParametros():String;
var
  nmArquivo :String;
begin
   nmArquivo := extractFilePath(ParamStr(0)) + extractFileName(ParamStr(0));
   delete(nmArquivo, pos(extractFileExt(ParamStr(0)), nmArquivo), 04);
   nmArquivo := nmArquivo + '.ini';
   result := nmArquivo;
end;



function gravaArqParam(sessao,parametro,valor:String):boolean;
var
   arq: TIniFile;
begin
   try
      arq := TiniFile.Create( getNmArParametros() );
      arq.WriteString(sessao, parametro, valor);
      arq.Destroy();
      result := true;
   except
      on e:exception do
      begin
         MsgTela('', 'Houve um erro ao gravar o par‚metro '+ parametro , MB_ICONERROR + MB_OK );
         result := false;
      end;
   end;
end;

function readArqParamStr(sessao,parametro,valor:String):String;
var
   arq: TIniFile;
begin
   try
      arq := TiniFile.Create( getNmArParametros() );
      result := arq.ReadString(sessao, parametro, valor);
   except
      on e:exception do
      begin
         MsgTela('', 'Houve um erro ao ler o par‚metro '+ parametro , MB_ICONERROR + MB_OK );
         result := '';
      end;
   end;
end;

function existsParam(sessao, parametro:String):boolean;
var
   arq:TiniFile;
begin
   arq := TiniFile.Create( getNmArParametros() );
   try
     result := arq.ValueExists(sessao, parametro);
     arq.Destroy();
   except
      result := false;
   end;
end;

function execFileExternal(form:Tform;  arq:String):Boolean;
var
  r:String;
begin
   r := '';
   case  (ShellExecute(form.Handle, nil, PChar(arq), nil, nil, SW_SHOWNORMAL) ) of
      ERROR_FILE_NOT_FOUND, ERROR_PATH_NOT_FOUND: r := 'O arquivo n„o existe.';
      ERROR_BAD_FORMAT: r := 'O arquivo est· corrompido.';
      SE_ERR_NOASSOC, SE_ERR_ASSOCINCOMPLETE: r := 'N„o existe programa para abrir o arquivo.';
      SE_ERR_SHARE, SE_ERR_OOM, SE_ERR_DDEBUSY,
      SE_ERR_DDEFAIL, SE_ERR_DDETIMEOUT:  r := 'erro ao tentar abrir o arquivo.';
    end;
    gravaLog('Metodo shellexecute, retorno: ' + r);
    if (r <> '') then
    begin
       msgTela('', r, MB_ICONERROR  + MB_OK);
    end
    else
       result := true;
end;





end.

