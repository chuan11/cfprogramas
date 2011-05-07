unit funcDatas;

interface
   uses Controls, SysUtils, ADODB, funcoes;

   function ajustaDataMes(mesAno, sinal: String):String;
   function dataSqlToData(dataSql:String):String;
   function dataToSqlInt(data:Tdate):String;
   function dateTimeToSqlDateTime(data,hora:string):string; OverLoad;
   function dateTimeToSqlDateTime(data:Tdate; hora:string):string; Overload;
   function dateToSqlDate(data:String):string; OverLoad;
   function dateToSqlDate(data:Tdate):string; OverLoad;
   function getDescricaoDia(data:TDate;ehDescAbreviada:Boolean):string;
   function getUltimoDiaMes(data:Tdate):String; overload;
   function getUltimoDiaMes(str:String):String; overload;
   function nomeDoDia(data:String; isDataAbreviada:boolean):String;
   function strToSqlDate(Str:string):string;

implementation


function nomeDoDia(data:String; isDataAbreviada:boolean):String;
var
  ADate: TDateTime;
  days: array[1..7] of string;
begin
   if (isDataAbreviada =true )then
   begin
      days[1] := 'DOM';
      days[2] := 'SEG';
      days[3] := 'TER';
      days[4] := 'QUA';
      days[5] := 'QUI';
      days[6] := 'SEX';
      days[7] := 'SAB';
   end
   else
   begin
      days[1] := 'Domingo';
      days[2] := 'Segunda';
      days[3] := 'Terca';
      days[4] := 'Quarta';
      days[5] := 'Quinta';
      days[6] := 'Sexta';
      days[7] := 'Sabado';
   end;
  ADate := StrToDate(data);
  result:=(days[DayOfWeek(ADate)]);
end;


function ajustaDataMes(mesAno, sinal: String):String;
var
  m,a:integer;
begin
   m:= strToInt(copy(mesAno,01,02));
   a:= strToInt(copy(mesAno,04,04));

   if sinal = '-' then
      m:= m -1
   else
      m:= m +1;

   if m > 12 then
   begin
      a := a +1;
      m := 01;
   end;

   if m < 1 then
   begin
      a:= a-1;
      m:= 12;
   end;

   mesAno := funcoes.preencheCampo(2,'0','e', intToStr(m) ) + '/' + intToStr(a);
   result := mesAno;
end;


function StrToSqlDate(Str:string):string;
var
   aux:string;
begin
   if (str = '' )then
      result := ''
   else
   begin
      aux := copy(Str,07,04) + '-' + copy(Str,04,02) +'-'+ copy(Str,01,02);
      if pos(' ',str) = 0 then
         aux  := quotedStr(aux);
      result := aux;
   end;
end;


function DateToSqlDate(data:Tdate):string;
begin
   result := StrToSqlDate(dateToStr(data));
end;

function dateToSqlDate(data:String):string; OverLoad;
begin
   result := StrToSqlDate(data);
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

function getDescricaoDia(data:TDate;ehDescAbreviada:Boolean):string;
var
  days: array[1..7] of string;
begin
   if (ehDescAbreviada = true )then
   begin
      days[1] := 'DOM';  days[2] := 'SEG'; days[3] := 'TER';  days[4] := 'QUA';
      days[5] := 'QUI';  days[6] := 'SEX';  days[7] := 'SAB';
   end
   else
   begin
      days[1] := 'DOMINGO';  days[2] := 'SEGUNDA'; days[3] := 'TERCA';  days[4] := 'QUARTA';
      days[5] := 'QUINTA';  days[6] := 'SEXTA';  days[7] := 'SABADO';
   end;
   getDescricaoDia:=(days[DayOfWeek(data)]);
end;

function getUltimoDiaMes(data:Tdate):String; overload;
var
   mes, AYear:integer;
   dia:String;
begin
   AYear := StrToInt( copy(dateTostr(data),07,04));
   mes :=   StrToInt( copy(dateTostr(data),04,02));
   case mes of
      01,03,05,07,08,10,12: dia := '31';
      04,06,09,11: dia := '30';
      02: begin
          if ((AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0)) ) then
             dia := '29'
          else
             dia := '28'
          end
   end;
   result := dia+copy(dateTostr(data),03,08);
end;

function getUltimoDiaMes(str:String):String; overload
begin
   result := getUltimoDiaMes(strToDate(str));
end;


function dataToSqlInt(data:Tdate):String;
var
   aux:String;
begin
   aux := datetoStr(data);
   result := copy(aux,07,04) + copy(aux,04,02)+ copy(aux,01,02);
end;

function dataSqlToData(dataSql:String):String;
begin
   result := copy(dataSql,10,02) +'/'+ copy(dataSql,07,02)+'/'+ copy(dataSql,02,04);
end;




end.
