program LancaMonitor;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  classes, windows, funcoes ;

var
  listtemp2: TStringList;
  ARQ_LOG, dir, mascara:String;
  cmd:string;
  ARQ_TEMP:String;

procedure executaCMD(cmd:String);
begin
   writeln('');
   writeln(cmd);
   writeln('');
   funcoes.gravaLog(cmd + ' >'+ARQ_LOG);
   winexec( pchar(cmd),  sw_normal );
end;

procedure atualizaConfigCtf();
var
   arq:TStringlist;
begin
   funcoes.WParReg('Monitor','AtualizaLancaMonitor', '1');

   arq:= TStringlist.Create();
   if FileExists( 'c:\arquivos de programas\auttar\ctfclient\bin\configCTFClient.xml') = true then
   begin
      arq.LoadFromFile('c:\arquivos de programas\auttar\ctfclient\bin\configCTFClient.xml');
      arq[44] := '        <Parameter name="host">125.0.0.212</Parameter>';
      arq.SaveToFile('c:\arquivos de programas\auttar\ctfclient\bin\configCTFClient.xml');
      arq.Free();
   end;
end;

Function TempDir: String;
var TempDir: array[0..255] of Char;
begin
   GetTempPath(255, @TempDir);
   Result := StrPas(TempDir);
end;

begin
   funcoes.limparLog();
   ARQ_LOG := '"'+ExtracTFilePath(ParamStr(0)) + 'logs\LogLancaMonitor.txt' + '"'  ;

   writeln('--------------------------------------------------------------------------------');
   writeln('                            Lancador do monitor 11.02.03');
   writeln('--------------------------------------------------------------------------------');
   writeln('');
   writeln('');
   sleep(600);


   if(funcoes.RParReg('Monitor','AtualizacaoLancaMonitor') = '') then
      atualizaConfigCtf();

   // conectar  no package do servidor
   writeln('Conectar no servidor...');
   cmd := 'cmd /c net use \\125.0.0.250\package /user:convidado2 convidado2';
   executaCMD(cmd);


   writeln('Tentando atualizar a data...');
   cmd := 'cmd /c net time \\125.0.0.250 /set /yes';
   executaCMD(cmd);

   writeln('Iniciar o CTFClient...');
   cmd := 'cmd /c net start ctfclient';
   executaCMD(cmd);

   cmd :=  ExtractFilePath(ParamStr(0))+'MonitorTEFECF.exe';
   executaCMD(cmd);
   writeln('Iniciando o Monitor.....');
end.
