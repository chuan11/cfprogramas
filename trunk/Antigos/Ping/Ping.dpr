program Ping;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  IcmpPing in 'IcmpPing.pas';

var
  { ========================================================================== }
  { Parametros                                                                 }

  { Host destino }
  Host: string;
  { Numero de requisicoes. "-1" indica que � para enviar at� Ctrl-C }
  RequestCount: Integer    = 4;
  { Tamanho do buffer de sa�da }
  SendBufferSize: Cardinal = 32;
  { Tempo a esperar }
  Timeout: Cardinal        = 5000;

  { ========================================================================== }
  { Variaveis internas                                                         }

  { Critical section para o procedimento de estatisticas. Veja as funcoes CtrlBreak e
    WriteStats }
  CriticalSection: TRTLCriticalSection;

  { IP resolvido }
  ResolvedIP: string;
  { Numero de pacotes enviados }
  PacketsSent: Cardinal;
  { Numero de pacotes recebidos Ok }
  PacketsReceived: Cardinal;
  { Round trip time minimo }
  RttMin: Cardinal;
  { Round trip time maximo }
  RttMax: Cardinal;
  { Round trip time total. Usado para calcular o RTT m�dio }
  RttTotal: Cardinal;

{ Escreve o help e sai do programa (atraves de ABORT, que � "propagado") }
procedure WriteHelp;
begin
  WriteLn('Uso: Ping [-t] [-n numero] [-l tamanho] [-w tempo] destino');
  WriteLn;
  WriteLn('Opcoes:');
  WriteLn('    -t            Envia requisicoes ate sair');
  WriteLn('                  Para ver estatisticas e continuar - pressione Ctrl-Break');
  WriteLn('                  Para sair - pressione Ctrl-C');
  WriteLn('    -n numero     Numero de requisicoes a enviar');
  WriteLn('    -l tamanho    Tamanho do pacote de envio');
  WriteLn('    -w tempo      Tempo em milissegundos para esperar resposta');
  WriteLn;
  ABORT;
end;

{ Escreve uma linha de erro, o help e sai do programa }
procedure WriteError(Msg: string);
begin
  WriteLn('Erro: ' + Msg);
  WriteLn;
  WriteHelp;
end;

{ Valida e l� os par�metros }
procedure ReadParams;
var
  I, Tmp: Integer;
  S: string;
  function GetNumberParam: Integer;
  begin
    Inc(I);
    try
      Result := StrToInt(ParamStr(I));
    except
      WriteError(Format('Parametro numerico invalido da opcao %s', [S]));
      Result := -1;
    end;
  end;
begin
  I := 1;
  while I < ParamCount do begin
    S := ParamStr(I);
    if (Length(S) <> 2) or (S[1] <> '-') then WriteHelp;
    case UpCase(S[2]) of
      'T': RequestCount := -1;
      'N': begin
             Tmp := GetNumberParam;
             if Tmp <= 0 then WriteError('Numero invalido de requisicoes');
             RequestCount := Tmp;
           end;
      'L': begin
             Tmp := GetNumberParam;
             if (Tmp <= 0) or (Tmp > 512) then
               WriteError('Tamanho invalido de pacote de envio (1 a 512 bytes)');
             SendBufferSize := Tmp;
           end;
      'W': begin
             Tmp := GetNumberParam;
             if Tmp < 0 then
               WriteError('Tempo invalido de espera');
             Timeout := Tmp;
           end;
    end;
    Inc(I);
  end;
  Host := ParamStr(I);
  if Host = '' then WriteHelp;
end;

type
  { Derivei TPing para nao precisar criar uma classe s� para implementar o evento
    OnHostResolved }
  TAppPing = class(TPing)
  protected
    procedure DoHostResolved(AHost, AIp: string); override;
  end;

{ S� imprime na tela a linha inicial do ping e atribui a variavel ResolvedIP }
procedure TAppPing.DoHostResolved(AHost, AIp: string);
begin
  inherited;
  if ResolvedIp = '' then begin
    if AHost <> AIp then
      WriteLn(Format('Ping em %s [%s] com 32 bytes de dados:', [AHost, AIp]))
    else
      WriteLn(Format('Ping em %s com 32 bytes de dados:', [AIp]));
    WriteLn;
    ResolvedIP := AIp;
  end;
end;

{ Faz o pesado... }
procedure DoPing;
var
  P: TAppPing;
  I, Res: Integer;
  ReplyIP, Time, ReplyLine: string;
  TTL: Cardinal;
  ReplyStatus: LongWord;
  ReplyDataSize: Word;
begin
  RttMin := MaxInt;
  RttMax := 0;
  P := TAppPing.Create;
  try
    I := 0;
    Res := 0;
    while (RequestCount < 0) or (I < RequestCount) do begin
      try
        if (Res >= 0) and (I > 0) then Sleep(1000);
        Res := P.Ping(Host, Timeout, SendBufferSize, ReplyIp, ReplyDataSize,
          TTL, ReplyStatus);
        EnterCriticalSection(CriticalSection);
        try
          Inc(PacketsSent);
          if Res >= 0 then begin
            Inc(PacketsReceived);
            Inc(RttTotal, Res);
            if Cardinal(Res) < RttMin then RttMin := Res;
            if Cardinal(Res) > RttMax then RttMax := Res;
            if ReplyStatus = 0 then begin
              if Res = 0 then
                Time := '<1'
              else
                Time := '=' + IntToStr(Res);
              ReplyLine := Format('bytes=%d tempo%sms TTL=%d', [ReplyDataSize, Time, TTL]);
            end else
              ReplyLine := GetIcmpReplyStatusMessage(ReplyStatus); 
            WriteLn(Format('Resposta de %s: %s', [ReplyIP, ReplyLine]));
          end else
            WriteLn('Tempo esgotado');
        finally
          LeaveCriticalSection(CriticalSection);
        end;
      except
        on E: EPingAddrNotesolvedException do begin
          WriteLn(Format('O programa nao pode resolver o host %s. Por favor '+
            'verifique o nome e tente novamente.', [Host]));
          ABORT;
        end;
        on E: Exception do begin
          WriteLn(E.Message);
          ABORT;
        end;
      end;
      Inc(I);
    end;
  finally
    P.Free;
  end;
end;

{ Escreve as estat�sticas na tela. Perceba que a funcao usa um Critical Section.
  Isso � feito porque ela � chamada a partir da fun��o CtrlBreak que, por
  sua vez, � chamada pelo sistema quando Ctrl-Break ou Ctrl-C s�o pressionados.

  A chamada pelo sistema ao CtrlBrek � feita em um thread separado do principal
  e, portanto, deve usar m�todos de sincronismo com ele, sen�o corremos o risco
  de imprimir estat�sticas incorretas.

  Para calcular a m�dia do RTT, por exemplo, dividimos a soma de todos os RTT
  pelo n�mero de pacotes recebidos. Se o CtrlBreak ocorrer, por exemplo,
  dentro da fun��o Ping, entre a linha que incrementa o n�mero de pacotes
  recebidos e a que soma a variavel RttTotal, a estat�stica impressa iria
  aparecer incorreta.

  Lembre-se que o Ctrl-Break (ou Ctrl-C), nessa caso, n�o interrompe o thread
  principal, ou seja, a fun��o Ping e a CtrlBreak ir�o rodar em paralelo.

  Um Critical Section � um objeto do Windows que impede que dois threads executem
  peda�os de c�digo entre EnterCriticalSection e LeaveCriticalSection. Assim,
  as linhas internas de WriteStats nunca ir�o rodar junto com as linhas que
  atualizam as vari�veis de estat�sticas da fun��o Ping. Um deles ficar� suspenso
  at� que o outro saia.

  Para mais informa��es sobre Critical Sections e Threads, veja a API do Windows
  ou a ajuda do objeto TThread do Delphi. }
procedure WriteStats;
begin
  EnterCriticalSection(CriticalSection);
  try
    if PacketsSent <= 0 then EXIT;
    WriteLn;
    WriteLn(Format('Estatisticas para %s:', [ResolvedIP]));
    WriteLn(Format('    Pacotes: Enviados = %d, Recebidos = %d, Perda = %d (%d%%)',
      [PacketsSent, PacketsReceived, PacketsSent - PacketsReceived,
       ((PacketsSent - PacketsReceived) * 100) div PacketsSent]));
    if PacketsReceived > 0 then begin
      WriteLn('Round trip times aproximados em milissegundos:');
      WriteLn(Format('    Minimo = %dms, Maximo = %dms, Media = %dms',
        [RttMin, RttMax, RttTotal div PacketsReceived]));
    end;
  finally
    LeaveCriticalSection(CriticalSection);
  end;
end;

{ Fun��o chamada pelo Windows quando Ctrl-Break ou Ctrl-C s�o acionados. Veja
  a fun��o da API do Windows "SetConsoleCtrlHandler". }
function CtrlBreak(dwCtrlType: DWORD): BOOL; stdcall;
begin
  if dwCtrlType = CTRL_BREAK_EVENT then begin
    WriteStats;
    WriteLn('Control-Break');
    Result := RequestCount < 0;
  end else if dwCtrlType = CTRL_C_EVENT then begin
    WriteStats;
    WriteLn('Control-C');
    Result := False;
  end else
    Result := False;
end;

begin
  SetConsoleCtrlHandler(@CtrlBreak, True);

  try
    InitializeCriticalSection(CriticalSection);
    try
      WriteLn;
      ReadParams;
      DoPing;
      WriteStats;
    finally
      DeleteCriticalSection(CriticalSection);
    end;
  except
    { Se ocorrer ABORT, simplesmente sai do programa. }
    on EAbort do;
    on E: Exception do WriteLn('Excecao: ' + E.Message);
  end;
end.
