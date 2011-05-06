{
 ******************************************************************************
 IcmpPing

 Implementação de Ping através de ICMP.DLL.

 ******************************************************************************
 Criado por Cristiano Kliemann (cristianok@ieg.com.br).

 Visite http://www.cristianok.hpg.com.br e veja outros exemplos, dicas e
 tutoriais sobre Delphi e assuntos relacionados.

 Qualquer dúvida ou sugestão, sinta-se a vontade para enviar um e-mail.

 Essa unidade foi criada com o propósito de estudo e pode pode ser modificada e
 usada em qualquer aplicativo, comercial ou não, desde que mantenha o minha
 autoria.
 ******************************************************************************
}

unit IcmpPing;

interface

uses SysUtils, Windows;

type
  TPing = class;

  EPingException = class(Exception);
  EPingAddrNotesolvedException = class(Exception);

  THostResolvedEvent = procedure(Sender: TPing; AHost, AIp: string) of object;

  TPing = class(TObject)
  private
    FHandle: THandle;
    FOnHostResolved: THostResolvedEvent;
  protected
    procedure DoHostResolved(AHost, AIp: string); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Ping(AHost: string; ATimeout: Cardinal; ADataSize: Word;
      var ReplyIp: string;
      var ReplyDataSize: Word;
      var ReplyTTL: Cardinal;
      var ReplyStatus: LongWord): Integer; overload;
    function Ping(AHost: string; ATimeout: Cardinal = 5000; ADataSize: Word = 32): Integer; overload;
  published
    property OnHostResolved: THostResolvedEvent read FOnHostResolved write FOnHostResolved;
  end;

function GetIcmpReplyStatusMessage(AReplyStatus: LongWord): string;

implementation

uses WinSock;

type
  TIcmpCreateFileProc = function: THandle; stdcall;
  TIcmpCloseHandleProc = function(IcmpHandle: THandle): BOOL; stdcall;
  TIcmpSendEchoProc = function(
    IcmpHandle: THandle;
    DestinationAddress: LongWord;
    RequestData: Pointer;
    RequestSize: Word;
    RequestOptions: Pointer;
    ReplyBuffer: Pointer;
    ReplySize: DWORD;
    Timeout: DWORD): DWORD; stdcall;

  TIpOptionInformation = packed record
    TTL: Byte;
    TOS: Byte;
    Flags: Byte;
    OptionsSize: Byte;
    Options: Pointer;
  end;

  TIcmpEchoReply = packed record
    Address: LongWord;
    Status: LongWord;
    RoundTripTime: LongWord;
    DataSize: Word;
    Reserved: Word;
    Data: Pointer;
    Options: TIpOptionInformation;
  end;

var
  IcmpModule: HModule;
  IcmpCreateFile: TIcmpCreateFileProc;
  IcmpCloseHandle: TIcmpCloseHandleProc;
  IcmpSendEcho: TIcmpSendEchoProc;
  WinSockLoaded: Boolean;

function IcmpLoaded: Boolean;
begin
  Result := IcmpModule <> 0;
end;

procedure IcmpUnload;
begin
  if not IcmpLoaded then EXIT;
  FreeLibrary(IcmpModule);
end;

procedure IcmpLoad;
begin
  if IcmpLoaded then EXIT;
  IcmpModule := LoadLibrary('icmp.dll');
  if IcmpModule = 0 then
    raise EPingException.Create('ICMP.DLL não pôde ser carregada.');
  try
    IcmpCreateFile := GetProcAddress(IcmpModule, 'IcmpCreateFile');
    if not Assigned(IcmpCreateFile) then
      raise EPingException.Create('ICMP.DLL inválida.');
    IcmpCloseHandle := GetProcAddress(IcmpModule, 'IcmpCloseHandle');
    if not Assigned(IcmpCloseHandle) then
      raise EPingException.Create('ICMP.DLL inválida.');
    IcmpSendEcho := GetProcAddress(IcmpModule, 'IcmpSendEcho');
    if not Assigned(IcmpSendEcho) then
      raise EPingException.Create('ICMP.DLL inválida.');
  except
    IcmpUnload;
    raise;
  end;
end;

procedure WinSockLoad;
var
  D: TWSAData;
  Res: Integer;
begin
  if not WinSockLoaded then begin
    FillChar(D, SizeOf(D), 0);
    Res := WSAStartup($0101, D);
    if Res <> 0 then begin
      raise EPingException.CreateFmt('WinSock não pôde ser carregada. (%d)', [Res]);
    end;
    WinSockLoaded := True;
  end;
end;

procedure WinSockUnload;
begin
  if WinSockLoaded then begin
    WSACleanup;
    WinSockLoaded := False;
  end;
end;

{ TPing }

constructor TPing.Create;
begin
  WinSockLoad;
  IcmpLoad;
  FHandle := IcmpCreateFile;
  if FHandle = INVALID_HANDLE_VALUE then
    raise EPingException.Create('Não pude criar handle ICMP.');
end;

destructor TPing.Destroy;
begin
  IcmpCloseHandle(FHandle);
  inherited;
end;

function TPing.Ping(AHost: string; ATimeout: Cardinal; ADataSize: Word;
  var ReplyIp: string;
  var ReplyDataSize: Word;
  var ReplyTTL: Cardinal;
  var ReplyStatus: LongWord): Integer;
var
  Addr: PInAddr;
  Req: PChar;
  Reply: ^TIcmpEchoReply;
  Res: Cardinal;
  HostEnt: PHostEnt;
begin
  HostEnt := gethostbyname(PChar(AHost));
  if HostEnt = nil then
    raise EPingAddrNotesolvedException.CreateFmt('Endereço ''%s'' não resolvido', [AHost]);

  Addr := PInAddr(HostEnt.h_addr^);

  DoHostResolved(AHost, inet_ntoa(Addr^));

  Req := AllocMem(ADataSize);
  try
    Reply := AllocMem(SizeOf(TIcmpEchoReply) + ADataSize);
    try
      Res := IcmpSendEcho(FHandle, LongWord(Addr^), @Req, ADataSize, nil, Reply,
        SizeOf(TIcmpEchoReply) + ADataSize, ATimeOut);
      if Res > 0 then begin
        ReplyStatus := Reply.Status;
        Result := Reply.RoundTripTime;
        ReplyIp := inet_ntoa(TInAddr(Reply.Address));
        ReplyDataSize := Reply.DataSize;
        ReplyTTL := Reply.Options.TTL;
      end else begin
        Result := -1;
      end;
    finally
      FreeMem(Reply);
    end;
  finally
    FreeMem(Req);
  end;
end;
//54.69.69.66
procedure TPing.DoHostResolved(AHost, AIp: string);
begin
  if Assigned(FOnHostResolved) then FOnHostResolved(Self, AHost, AIp);
end;

function TPing.Ping(AHost: string; ATimeout: Cardinal = 5000;
  ADataSize: Word = 32): Integer;
var
  ReplyIP: string;
  ReplyDataSize: Word;
  ReplyStatus: LongWord;
  ReplyTTL: Cardinal;
begin
  Result := Ping(AHost, ADataSize, ATimeout, ReplyIP, ReplyDataSize, ReplyTTL, ReplyStatus);
  if ReplyStatus <> 0 then Result := -1;
end;

{ EPingReplyException }

function GetIcmpReplyStatusMessage(AReplyStatus: LongWord): string;
begin
  case AReplyStatus of
    0: Result := 'Sucesso';
    11001: Result := 'Buffer muito pequeno';
    11003: Result := 'Host destino inalcancavel';
    11004: Result := 'Protocolo destino inalcancavel';
    11005: Result := 'Porta destino inalcancavel';
    11006: Result := 'Sem recursos disponiveis';
    11007: Result := 'Opcao incorreta';
    11008: Result := 'Erro de hardware';
    11009: Result := 'Pacote muito grande';
    11010: Result := 'Tempo expirou';
    11011: Result := 'Requisicao incorreta';
    11012: Result := 'Rota incorreta';
    11013: Result := 'TTL expirou em transito';
    11014: Result := 'TTL Exprd Reassemb';
    11015: Result := 'Problema com parametros';
    11016: Result := 'Source Quench';
    11017: Result := 'Opcao muito grande';
    11018: Result := 'Destino incorreto';
    11019: Result := 'Endereco excluido';
    11020: Result := 'Spec MTU Change';
    11021: Result := 'MTU Change';
    11022: Result := 'Unload';
    11050: Result := 'General Failure';
  else
    Result := Format('Status desconhecido (%d)', [AReplyStatus]);
  end;
end;

initialization
  { Nada }
finalization
  IcmpUnload;
  WinSockUnload;
end.
