//==============================================================================
// Unit........: adUtils.pas
// Created.....: 08/04/2005
// Type Unit...: Cross platform
// -----------------------------------------------------------------------------
// Author......: Dennys dos Santos Sobrinho
// E-Mail......: dennys@activedelphi.com.br
// Copyright...: Revista ActiveDelphi
// Distribuição: Licença pública GNU GPL
//               http://lie-br.conectiva.com.br/licenca_gnu.html
// Observação..: Qualquer modificação ou implementação, deverá ser enviada para
//               o autor a fim de atualizar os demais beneficiados.
// .............................................................................
// Histórico
// ---------
// 06/05/2005 - Para auxiliar o componente TadLabelDBLookupDialog, foram criadas
//              as rotinas:
//              GetCommandSelect, GetCommandWhere, GetCommandGroupBy,
//              GetCommandHaving, GetCommandOrderBy
//              Sua finalidade é de dividir o comando SQL em partes 
//              pré-definidas.
//==============================================================================

unit adUtils;

interface

{$I ActiveDelphi.inc}

uses SysUtils, DBClient, Classes;

  // Retorna a última posição localizada do SubStr dentro do String.
  function LastPos(const sSubstr, sString : string): integer;
  // Retorna a posição exata do SubStr dentro do String.
  function PosExact(Substr: string; S: string) : Integer;

  // Retorna o texto existente no comando SELECT... do SQL.
  function GetCommandSelect(const sSQL  : string) : string; 
  // Retorna o texto existente no comando WHERE... do SQL.
  function GetCommandWhere(const sSQL   : string) : string; 
  // Retorna o texto existente no comando GROUP BY... do SQL.
  function GetCommandGroupBy(const sSQL : string) : string; 
  // Retorna o texto existente no comando HAVING... do SQL.
  function GetCommandHaving(const sSQL  : string) : string;
  // Retorna o texto existente no comando ORDER BY... do SQL.
  function GetCommandOrderBy(const sSQL : string) : string;

  //............................................................................
  function StrToClientDataSet(StrDataSet: String): TClientDataSet; overload;
  procedure StrToClientDataSet(StrDataSet: String; var CDS: TClientDataSet); overload;
  function ClientDataSetToStr(ClientDataSet: TClientDataSet): String;
  function CloneClientDataSet(ClientDataSet: TClientDataSet): TClientDataSet;
  //............................................................................
  
implementation

// -----------------------------------------------------------------------------

function LastPos(const sSubstr, sString : string): integer;
var
  sValue  : string;
  iResult : longint;
begin
  iResult := Pos(sSubstr, sString);
  Result  := iResult;
  sValue  := sString;
  while (iResult > 0) do begin
    sValue  := Copy(sValue, iResult+Length(sSubstr), Length(sValue));
    iResult := Pos(sSubstr, sValue)-2;
    if (iResult > 0) then
      Inc(Result, iResult+Length(sSubstr))
    else  
      Inc(Result, iResult);
  end;
end;

// -----------------------------------------------------------------------------

function PosExact(Substr: string; S: string) : Integer;
var
  Value : string;
begin
  Result  := 1;
  Value   := S;
  while Result > 0 do begin
    Result := Pos(Substr, Value);
    if (Result <= 0) or (Value[Result-1] = #32) then 
      Break
    else
      Value := Copy(Value, Result+1, Length(Value));
  end;
end;

// -----------------------------------------------------------------------------

// Esta função retorna o texto existente no comando SELECT... do SQL.
function GetCommandSelect(const sSQL : string) : string;
begin
  Result    := '';
  if (LastPos('where', AnsiLowerCase(sSQL)) > 0) then 
    Result  := Copy(sSQL, 1, LastPos('where', AnsiLowerCase(sSQL))-1)
  else if (LastPos('group by', AnsiLowerCase(sSQL)) > 0) then 
    Result  := Copy(sSQL, 1, LastPos('group by', AnsiLowerCase(sSQL))-1)
  else if (LastPos('order by', sSQL) > 0) then 
    Result  := Copy(sSQL, 1, LastPos('order by', AnsiLowerCase(sSQL))-1)
  else
    Result  := sSQL;
  if (Trim(Result) <> '') then Result := #32+Trim(Result)+#32#13;
end;

// -----------------------------------------------------------------------------

// Esta função retorna o texto existente no comando WHERE... do SQL.
function GetCommandWhere(const sSQL : string) : string;
var
  iPosGroupBy, iPosOrderBy : longint;
begin
  Result        := '';
  if (LastPos('where', AnsiLowerCase(sSQL)) > 0) then begin
    iPosGroupBy := LastPos('group by', AnsiLowerCase(sSQL));
    iPosOrderBy := LastPos('order by', AnsiLowerCase(sSQL));
    if (iPosGroupBy > 0) then
      Result    := Copy(sSQL, LastPos('where', AnsiLowerCase(sSQL)), iPosGroupBy - LastPos('where', AnsiLowerCase(sSQL)))
    else if (iPosOrderBy > 0) then
      Result    := Copy(sSQL, LastPos('where', AnsiLowerCase(sSQL)), iPosOrderBy - LastPos('where', AnsiLowerCase(sSQL)))
    else
      Result    := Copy(sSQL, LastPos('where', AnsiLowerCase(sSQL)), Length(sSQL));
  end;
  if (Trim(Result) <> '') then Result := #32+Trim(Result)+#32#13;
end;

// -----------------------------------------------------------------------------

// Esta função retorna o texto existente no comando GROUP BY... do SQL.
function GetCommandGroupBy(const sSQL : string) : string;
var
  iPosHaving  : longint;
begin
  Result        := '';
  if (LastPos('group by', AnsiLowerCase(sSQL)) > 0) then begin
    iPosHaving := LastPos('having', AnsiLowerCase(sSQL));
    if (iPosHaving > 0) then
      Result    := Copy(sSQL, LastPos('group by', AnsiLowerCase(sSQL)), iPosHaving - LastPos('group by', AnsiLowerCase(sSQL)))
    else
      Result    := Copy(sSQL, LastPos('group by', AnsiLowerCase(sSQL)), Length(sSQL));
  end;
  if (Trim(Result) <> '') then Result := #32+Trim(Result)+#32#13;
end;

// -----------------------------------------------------------------------------

// Esta função retorna o texto existente no comando HAVING... do SQL.
function GetCommandHaving(const sSQL : string) : string;
var
  iPosOrderBy : longint;
begin
  Result        := '';
  if (LastPos('having', AnsiLowerCase(sSQL)) > 0) then begin
    iPosOrderBy := LastPos('order by', AnsiLowerCase(sSQL));
    if (iPosOrderBy > 0) then
      Result    := Copy(sSQL, LastPos('having', AnsiLowerCase(sSQL)), iPosOrderBy - LastPos('having', AnsiLowerCase(sSQL)))
    else
      Result    := Copy(sSQL, LastPos('having', AnsiLowerCase(sSQL)), Length(sSQL));
  end;
  if (Trim(Result) <> '') then Result := #32+Trim(Result)+#32#13;
end;

// -----------------------------------------------------------------------------

// Esta função retorna o texto existente no comando ORDER BY... do SQL.
function GetCommandOrderBy(const sSQL : string) : string;
begin
  Result    := '';
  if (LastPos('order by', AnsiLowerCase(sSQL)) > 0) then 
    Result  := Copy(sSQL, LastPos('order by', AnsiLowerCase(sSQL)), Length(sSQL));
  if (Trim(Result) <> '') then Result := #32+Trim(Result)+#32#13;
end;

// -----------------------------------------------------------------------------

function StrToClientDataSet(StrDataSet: String): TClientDataSet;
begin
  Result := TClientDataSet.Create(nil);
  Result.LoadFromStream(TStringStream.Create(StrDataSet));
end;

// -----------------------------------------------------------------------------

procedure StrToClientDataSet(StrDataSet: String; var CDS: TClientDataSet); overload;
begin
  CDS.LoadFromStream(TStringStream.Create(StrDataSet));
end;

// -----------------------------------------------------------------------------

function ClientDataSetToStr(ClientDataSet: TClientDataSet): String;
var
  ResultStream: TStringStream;
begin
  ResultStream := TStringStream.Create('');
  ClientDataSet.SaveToStream(ResultStream, dfXML);
  Result       := ResultStream.DataString;
end;

// -----------------------------------------------------------------------------

function CloneClientDataSet(ClientDataSet: TClientDataSet): TClientDataSet;
var
  Data: String;
begin
  Data   := ClientDataSetToStr(ClientDataSet);
  Result := StrToClientDataSet(Data);
end;

// -----------------------------------------------------------------------------

end.
