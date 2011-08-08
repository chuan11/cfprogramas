program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  funcoes,
  funcSQL,
  adoDB,
  DB,
  classes;

var
  conexao :TADOConnection;
  ds:TDataSet;
  cidades: Tstringlist;
  i:integer;
  cmd:String;

procedure ConexaoWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.gravaLog(CommandText);
end;

begin
   limparLog();
   writeln('Teste...');
   conexao := TADOConnection.create(nil);
   conexao.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   conexao.LoginPrompt := false;
   conexao.Open();
   cidades := TstringList.create();
   cidades.LoadFromFile('C:\CadastroDeCidades\cadastro.dat');

   for i:=0 to cidades.Count-1 do
   begin
     writeln(intToStr((i*100) div (cidades.Count)) + '% consultando: '+ copy(cidades[i], 01, 02) + '  ' +trim( copy(cidades[i], 12, 50) ));
     gravaLog(intToStr((i*100) div (cidades.Count)) + '% consultando: '+ copy(cidades[i], 01, 02) + '  ' +trim( copy(cidades[i], 12, 50) ));
     cmd:=
     'Select * from tcid (nolock) where cd_uf = ' + quotedStr(copy(cidades[i], 01, 02)) +
     ' and nm_cid= ' + quotedStr(trim( copy(cidades[i], 12, 50)) );
     funcoes.gravaLog(cmd);

     ds:= funcSQL.getDataSetQ(cmd, conexao);

     if (ds.IsEmpty = false) then
     begin
        gravaLog(intToStr(LENGTH(ds.fieldbyName('codigoIBGE').AsString)));
        if (Length(ds.fieldbyName('codigoIBGE').AsString) = 0) then
        begin
           writeln('    Inserir: '+ copy(cidades[i], 01, 02) + '  ' +trim( copy(cidades[i], 12, 50) ));
           cmd :=
           ' update  tcid set codigoIBGE= '+ copy(cidades[i], 04, 07) +
           ' where cd_uf = ' + quotedStr(copy(cidades[i], 01, 02)) +
           ' and nm_cid= ' + quotedStr(trim( copy(cidades[i], 12, 50)) );
           funcoes.gravaLog(cmd);
           funcSQL.execSQL(cmd, conexao);
        end;
      end
      else
      writeln('Nao achei');
      ds.free;
   end;
   readln;
end.
