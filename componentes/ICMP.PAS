unit icmp;

{ Copyright 1997 Andreas Hörstemeier                Version 0.3 1997-09-10   }
{ this component is public domain - please check the file readme.txt for     }
{ more detailed info on usage and distributing                               }

(*@/// interface *)
interface

(*@/// uses *)
uses
  sysutils,
  classes,
  winsock,
(*$ifdef ver80 *)
  winprocs,
  wintypes,
(*$else *)
  windows,
(*$endif *)
  messages,
  forms,
  ip_misc;
(*@\\\*)

(*@/// The API stuff for the ICMP.DLL *)
(* Documentation taken from http://www.sockets.com/ms_icmp.htm *)

{ Microsoft doesn't support the standard way ICMP is implemented using
  sockets, that means by the SOCK_RAW socket type - they only work as
  user administrator! And there's no way to set the TTL for the packets, so
  there's no way to build a TraceRoute using winsock. So this unit uses their
  ICMP.DLL, although MS discourages it's use - once they have a better solution
  this properitary implementation will vanish. So be careful where you
  use this unit!
}

const
(*@///   ip status values *)
ip_status_base           = 11000;
ip_success               = 0;
ip_buf_too_small         = ip_status_base +  1;
ip_dest_net_unreachable  = ip_status_base +  2;
ip_dest_host_unreachable = ip_status_base +  3;
ip_dest_prot_unreachable = ip_status_base +  4;
ip_dest_port_unreachable = ip_status_base +  5;
ip_no_resources          = ip_status_base +  6;
ip_bad_options           = ip_status_base +  7;
ip_hw_error              = ip_status_base +  8;
ip_packet_too_big        = ip_status_base +  9;
ip_req_timed_out         = ip_status_base + 10;
ip_bad_req               = ip_status_base + 11;
ip_bad_route             = ip_status_base + 12;
ip_ttl_expired_transmit  = ip_status_base + 13;
ip_ttl_expired_reassem   = ip_status_base + 14;
ip_param_problem         = ip_status_base + 15;
ip_source_quench         = ip_status_base + 16;
ip_option_too_big        = ip_status_base + 17;
ip_bad_destination       = ip_status_base + 18;
ip_addr_deleted          = ip_status_base + 19;
ip_sepc_mtu_change       = ip_status_base + 20;
ip_mtu_change            = ip_status_base + 21;
ip_unload                = ip_status_base + 22;
ip_general_failure       = ip_status_base + 50;
max_ip_status            = ip_general_failure;
ip_pending               = ip_status_base +255;
(*@\\\0000000C01*)

type
(*@///   t_ip_options=packed record *)
p_ip_options=^t_ip_options;
t_ip_options=packed record
  Ttl: byte;             (* time to live *)
  Tos: byte;             (* type of service (usually 0) *)
  flags: byte;           (* IP header flags (usually 0) *)
  optionssize: byte;     (* size of options data (usually 0, max 40) *)
  optionsdata: pointer;  (* options data buffer *)
end;
(*@\\\0000000201*)
(*@///   t_icmp_echo_reply=packed record *)
p_icmp_echo_reply=^t_icmp_echo_reply;
t_icmp_echo_reply=packed record
  address: u_long;           (* source address *)
  status: u_long;            (* IP status *)
  rttime: u_long;            (* rount trip time in milliseconds *)
  datasize: word;            (* reply data size *)
  reserved: word;            (* who knows *)
  data: pointer;             (* reply data buffer *)
  ip_options:t_ip_options;   (* reply options *)
end;
(*@\\\*)

var
  ICMPCreateFile:function:THandle; stdcall;
  ICMPCloseHandle:function(ICMPHandle:THandle):Boolean; stdcall;
  ICMPSendEcho:function(ICMPHandle: THandle;      (* handle returned from ICMPCreateFile *)
                        DestAddress:longint;      (* destination IP address (network order) *)
                        Requestdata:pointer;      (* pointer to buffer to send *)
                        requestsize:word;         (* length of data in buffer *)
                        RequestOptns: p_ip_options;
                        ReplyBuffer:pointer;      (* see note *)
                        Replysize:dword;          (* length of reply, minimum 1 reply *)
                        Timeout: DWord            (* time in milliseconds to wait for reply *)
                        ):dword; stdcall;


(* The reply buffer will have an array of ICMP_ECHO_REPLY structures, followed
   by options and the data in ICMP echo reply datagram received. You must
   have root for at least one ICMP echo reply structure, plus 8 bytes for
   an ICMP header *)
(*@\\\0000000D14*)
(*@/// The ICMP constants for winsock like calls *)
type
(*@///   t_ip_header=packed record *)
t_ip_header=packed record
  ip_hl_v: byte;   (* low nibble: header length; high nibble: version *)
  ip_tos: byte;    (* type of service *)
  ip_len: word;    (* total length *)
  ip_id: word;     (* identification *)
  ip_off: word;    (* fragment offset field *)
  ip_ttl: byte;    (* time to live *)
  ip_p: byte;      (* protocol *)
  ip_sum: word;    (* checksum *)
  ip_src,
  ip_dst:longint;  (* source and dest address *)
  end;
(*@\\\*)
(*@///   t_icmp_echo_request=packed record *)
t_icmp_echo_request=packed record
  icmp_type: byte;            (* ICMP type *)
  icmp_code: byte;            (* ICMP code *)
  icmp_cksum: word;           (* ICMP checksum *)
  icmp_id: word;              (* ICMP identification *)
  icmp_seq: word;             (* ICMP sequence number *)
  end;
(*@\\\000000050A*)
(*@///   t_icmp_reply=packed record *)
t_icmp_reply=packed record
  icmp_type: byte;            (* ICMP type *)
  icmp_code: byte;            (* ICMP code *)
  icmp_cksum: word;           (* ICMP checksum *)
  icmp_unused: longint;       (* unused area *)
  icmp_ip: t_ip_header;       (* original IP header which cause the reply *)
  icmp_dgram:array[0..63] of byte;   (* first 64 bits of datagram *)
  end;
(*@\\\000000010D*)
const
(*@///   ICMP types *)
  ICMP_ECHOREPLY           = 0  ;  (* echo reply *)
  ICMP_UNREACH             = 3  ;  (* dest unreachable, codes: *)
    ICMP_UNREACH_NET       = 0  ;  (* bad net *)
    ICMP_UNREACH_HOST      = 1  ;  (* bad host *)
    ICMP_UNREACH_PROTOCOL  = 2  ;  (* bad protocol *)
    ICMP_UNREACH_PORT      = 3  ;  (* bad port *)
    ICMP_UNREACH_NEEDFRAG  = 4  ;  (* IP_DF caused drop *)
    ICMP_UNREACH_SRCFAIL   = 5  ;  (* src route failed *)
  ICMP_SOURCEQUENCH        = 4  ;  (* packet lost, slow down *)
  ICMP_REDIRECT            = 5  ;  (* shorter route, codes: *)
    ICMP_REDIRECT_NET      = 0  ;  (* for network *)
    ICMP_REDIRECT_HOST     = 1  ;  (* for host *)
    ICMP_REDIRECT_TOSNET   = 2  ;  (* for tos and net *)
    ICMP_REDIRECT_TOSHOST  = 3  ;  (* for tos and host *)
  ICMP_ECHO                = 8  ;  (* echo service *)
  ICMP_TIMXCEED            = 11 ;  (* time exceeded, code: *)
    ICMP_TIMXCEED_INTRANS  = 0  ;  (* ttl==0 in transit *)
    ICMP_TIMXCEED_REASS    = 1  ;  (* ttl==0 in reass *)
  ICMP_PARAMPROB           = 12 ;  (* ip header bad *)
  ICMP_TSTAMP              = 13 ;  (* timestamp request *)
  ICMP_TSTAMPREPLY         = 14 ;  (* timestamp reply *)
  ICMP_IREQ                = 15 ;  (* information request *)
  ICMP_IREQREPLY           = 16 ;  (* information reply *)
  ICMP_MASKREQ             = 17 ;  (* address mask request *)
  ICMP_MASKREPLY           = 18 ;  (* address mask reply *)
(*@\\\*)
(*@///   Options for use with [gs]etsockopt at the IP level. (corrected from winsock) *)
(*  IP_OPTIONS          = 1;  *)

  IP_TTL              =  4;           { Time to live of IP packet }
  IP_MULTICAST_IF     =  9;           { set/get IP multicast interface   }
  IP_MULTICAST_TTL    = 10;           { set/get IP multicast timetolive  }
  IP_MULTICAST_LOOP   = 11;           { set/get IP multicast loopback    }
  IP_ADD_MEMBERSHIP   = 12;           { add  an IP group membership      }
  IP_DROP_MEMBERSHIP  = 13;           { drop an IP group membership      }

(*  IP_DEFAULT_MULTICAST_TTL   = 1;    { normally limit m'casts to 1 hop  }  *)
(*  IP_DEFAULT_MULTICAST_LOOP  = 1;    { normally hear sends if a member  }  *)
(*  IP_MAX_MEMBERSHIPS         = 20;   { per socket; must fit in one mbuf }  *)
(*@\\\0000000301*)

function ICMP_checksum(var buf; length:integer):word;
(*@\\\0000000701*)

type
  t_icmp_call=(  icmp_dll,         (* only ICMP.DLL calls *)
                 icmp_winsock_ttl, (* Winsock including setting TTL *)
                 icmp_winsock_dll, (* Winsock, but ICMP.DLL for TTL *)
                 icmp_winsock,     (* Winsock, but no TTL *)
                 no_icmp           (* no at all *)
               );
var
  icmp_state:t_icmp_call;

type
  TPingEvent = procedure (sender:TObject; status: integer; ip:longint; roundtime:longint) of object;
  TRouteEvent = procedure (sender:TObject; hop: byte; ip:longint; roundtime:longint) of object;
  EICMPError=class(Exception);
(*@///   TICMP=class(TComponent) *)
TICMP=class(TComponent)
protected
  icmp_handle: THandle;  (* for ICMP.DLL mode *)
  f_socket: TSocket;     (* for winsock RAW mode *)
protected
  f_blocksize: byte;
  f_replysize: dword;
  f_timeout: cardinal;
  f_ttl: byte;
  f_address: longint;
  f_hostname: string;
  f_terminated: boolean;
  f_handle: THandle;
  procedure WndProc(var Msg : TMessage); virtual;
  procedure OpenDll;
  procedure OpenSocket;
public
  constructor Create(Aowner:TComponent); override;
  procedure Terminate;
  procedure action; virtual;
  destructor Destroy; override;
end;
(*@\\\*)
(*@///   TPing=class(TICMP) *)
TPing=class(TICMP)
protected
  f_no_of_packets_rec: integer;
  f_no_of_packets_snd: integer;
  f_roundtime_max: longint;
  f_roundtime_min: longint;
  f_roundtime_med: extended;
  f_on_ping: TPingEvent;
  function GetRoundtimeMin:longint;
  function GetRoundtimeMed:extended;
  procedure UpdateStatistics(roundtime:longint);
public
  property MinimumRoundttime: longint read GetRoundtimeMin;
  property MaximumRoundttime: longint read f_roundtime_max;
  property MeanRoundttime: extended read GetRoundTimeMed;
  property ReceivedPackets: integer read f_no_of_packets_rec;
  property SentPackets: integer read f_no_of_packets_snd;
  constructor Create(Aowner:TComponent); override;
  procedure action; override;
  procedure ReceiveSock;
  procedure SendSock;
  procedure WndProc(var Msg : TMessage); override;
  procedure ResetStatistics;
published
  property Timeout:cardinal read f_timeout write f_timeout;
  property Blocksize: byte read f_blocksize write f_blocksize default 64;
  property TimeToLive: byte read f_ttl write f_ttl default 255;
  property Hostname:string read f_hostname write f_hostname;
  property OnPing: TPingEvent read f_on_ping write f_on_ping;
end;
(*@\\\0000001C01*)
(*@///   TTraceRoute=class(TICMP) *)
TTraceRoute=class(TICMP)
protected
  f_on_route: TRouteEvent;
  f_route: TStringlist;
  f_resolve: boolean;
public
  constructor Create(Aowner:TComponent); override;
  procedure action; override;
  destructor Destroy; override;
  property Route: TStringList read f_route;
published
  property ResolveHostname:boolean read f_resolve write f_resolve default false;
  property Timeout:cardinal read f_timeout write f_timeout;
  property Blocksize: byte read f_blocksize write f_blocksize default 64;
  property TimeToLive: byte read f_ttl write f_ttl default 255;
  property Hostname:string read f_hostname write f_hostname;
  property OnRoute: TRouteEvent read f_on_route write f_on_route;
end;
(*@\\\*)

const
  uwm_socketevent = wm_user+$102; (* my magic message number *)

procedure Register;
(*@\\\0000001B01*)
(*@/// implementation *)
implementation

const
  f_packet_no: word = 0;

var
  hDll: THandle;
(*@/// function ICMP_checksum(var buf; length:integer):word; *)
function ICMP_checksum(var buf; length:integer):word;
var
  p: pointer;
  sum: longint;
  i: integer;
begin
  p:=@buf;
  sum:=0;
  for i:=1 to length div 2 do begin
    sum:=sum+word(p^);
    p:=pointer(longint(p)+2);
    end;
  if length mod 1<>0 then
    sum:=sum+byte(p^);

  sum:=(sum shr 16) + (sum and $ffff);
  sum:=sum+(sum shr 16);
  result:=word(NOT sum);
  end;
(*@\\\000000080A*)
(*@/// function now_ms:longint; *)
function now_ms:longint;
var
  systime : TSystemTime;
begin
  GetLocalTime(systime);  (* to leave the date unchanged *)
  result:=systime.wmilliseconds+1000*systime.wsecond+60000*systime.wminute;
  end;
(*@\\\0000000110*)

(*@/// class ticmp(TComponent) *)
(*@/// constructor TICMP.Create(Aowner:TComponent); *)
constructor TICMP.Create(Aowner:TComponent);
begin
  inherited create(AOwner);
  f_timeout:=5000;  (* 5 second *)
  f_blocksize:=64;
  f_ttl:=255;
  f_socket:=INVALID_SOCKET;
  icmp_handle:=invalid_handle_value;
  f_handle:=AllocateHwnd(self.WndProc);
  end;
(*@\\\0000000901*)
(*@/// destructor TICMP.Destroy; *)
destructor TICMP.Destroy;
begin
  if icmp_handle<>invalid_handle_value then
    ICMPCloseHandle(icmp_handle);
  if f_socket<>INVALID_SOCKET then
    Winsock.CloseSocket(f_socket);
  inherited destroy;
  end;
(*@\\\0000000508*)
(*@/// procedure TICMP.action; *)
procedure TICMP.action;
begin
  f_terminated:=false;
  f_replysize:=16+sizeof(t_icmp_echo_reply)+f_blocksize;
  f_address:=lookup_hostname(f_hostname);
  end;
(*@\\\0000000401*)
(*@/// procedure TICMP.Terminate; *)
procedure TICMP.Terminate;
begin
  f_terminated:=true;
  end;
(*@\\\*)
(*@/// procedure TICMP.OpenDll; *)
procedure TICMP.OpenDll;
begin
  if icmp_handle=invalid_handle_value then
    icmp_handle:=ICMPCreateFile;
  end;
(*@\\\0000000501*)
(*@/// procedure TICMP.OpenSocket; *)
procedure TICMP.OpenSocket;
begin
  if f_socket=INVALID_SOCKET then begin
    f_socket:=Winsock.Socket(PF_INET,SOCK_RAW,IPPROTO_ICMP);
    winsock.WSAAsyncSelect(f_socket,f_handle,uwm_socketevent,fd_read);
    end;
  end;
(*@\\\0000000401*)

(*@/// procedure TICMP.WndProc(var Msg : TMessage); *)
procedure TICMP.WndProc(var Msg : TMessage);
begin
  if msg.msg=wm_queryendsession then
    msg.result:=1
  end;
(*@\\\000C000301000301000301*)
(*@\\\000000081C*)
(*@/// class tping(TICMP) *)
(*@/// constructor TPing.Create(Aowner:TComponent); *)
constructor TPing.Create(Aowner:TComponent);
begin
  inherited create(AOwner);
  f_blocksize:=64;
  end;
(*@\\\0000000401*)
(*@/// procedure TPing.action; *)
procedure TPing.action;
var
  requestdata,replybuffer: pointer;
  p_reply: p_icmp_echo_reply;
  requestoptions: t_ip_options;
begin
  inherited action;
  case icmp_state of
(*@///     icmp_dll:       send and receive the ping packets via ICMP.DLL *)
icmp_dll: begin
  OpenDll;
  requestdata:=NIL;
  replybuffer:=NIL;
  f_replysize:=16+sizeof(t_icmp_echo_reply)+f_blocksize;
  try
    GetMem(requestdata,f_blocksize);
    fillchar(requestdata^,f_blocksize,#$a7);
    GetMem(replybuffer,f_replysize);

    requestoptions.ttl:=f_ttl;    (* a ping should live near infinity *)
    requestoptions.tos:=0;
    requestoptions.flags:=0;
    requestoptions.optionssize:=0;
    requestoptions.optionsdata:=NIL;

    if f_terminated then EXIT;
    inc(f_no_of_packets_snd);
    if ICMPSendEcho(icmp_handle,f_address,
                    requestdata,f_blocksize,
                    @requestoptions,
                    replybuffer,f_replysize,
                    f_timeout) = 1 then begin
      p_reply:=p_icmp_echo_reply(replybuffer);
      if assigned(f_on_ping) then
        f_on_ping(self,p_reply^.status,p_reply^.address,p_reply^.rttime);
      if (p_reply^.status=ip_success) and
         (p_reply^.address=f_address) then begin
        inc(f_no_of_packets_rec);
        UpdateStatistics(p_reply^.rttime);
        end;
      end
    else
      if assigned(f_on_ping) then
        f_on_ping(self,ip_req_timed_out,f_address,0);
  finally
    if requestdata<>NIL then
      FreeMem(requestdata,f_blocksize);
    if replybuffer<>NIL then
      FreeMem(replybuffer,f_replysize);
    end;
  end;
(*@\\\*)
(*@///     icmp_winsock*:  send the ping packets via winsock, receive is asynchron *)
icmp_winsock_ttl, icmp_winsock_dll, icmp_winsock: begin
  OpenSocket;
  if f_terminated then EXIT;
  inc(f_no_of_packets_snd);
  SendSock;
  end;
(*@\\\*)
    no_icmp: raise EICMPError.Create('No ICMP available');
    end;
  end;
(*@\\\0000000A01*)
(*@/// procedure TPing.ReceiveSock;             // receive a ICMP packet *)
procedure TPing.ReceiveSock;
type
(*@///   treply_buf=record *)
treply_buf=record
  ip_header  : t_ip_header;
  icmp_header: t_icmp_echo_request;
  time       : longint;
  end;
(*@\\\*)
var
  replybuffer: pointer;
  from: TSockAddrIn;
  whereto_len: integer;
begin
  replybuffer:=NIL;
  f_replysize:=sizeof(t_icmp_echo_request)+
               sizeof(t_ip_header)+
               sizeof(longint)+
               f_blocksize;
  try
    GetMem(replybuffer,f_replysize);
    from.sin_family:=AF_INET;
    from.sin_port:=0;
    from.sin_addr.S_addr:=f_address;
    recvfrom(f_socket,replybuffer^,f_replysize,0,from,whereto_len);
    if t_ip_header(replybuffer^).ip_hl_v=$45 then begin
        if (treply_buf(replybuffer^).icmp_header.icmp_id=word(self)) and
           assigned(f_on_ping) then
          f_on_ping(self,0,treply_buf(replybuffer^).ip_header.ip_src,
            now_ms-treply_buf(replybuffer^).time);
      end;
  finally
    if replybuffer<>NIL then
      FreeMem(replybuffer,f_replysize);
    end;
  end;
(*@\\\*)
(*@/// procedure TPing.SendSock;                // send a ICMP packet *)
procedure TPing.SendSock;
type
(*@///   ticmp_sendblock=record *)
ticmp_sendblock=record
  icmp_header: t_icmp_echo_request;
  time       : longint;
  data       : char;               (* to be extended dynamically *)
  end;
(*@\\\*)
(*@///   treply_buf=record *)
treply_buf=record
  ip_header  : t_ip_header;
  icmp_header: t_icmp_echo_request;
  time       : longint;
  end;
(*@\\\*)
var
  requestdata: pointer;
  whereto: TSockAddr;
  whereto_len: integer;
  rq_size: integer;
begin
  requestdata:=NIL;
  rq_size:=sizeof(t_icmp_echo_request)+f_blocksize+sizeof(longint);
  try
    GetMem(requestdata,rq_size);
    ticmp_sendblock(requestdata^).icmp_header.icmp_type := ICMP_ECHO;
    ticmp_sendblock(requestdata^).icmp_header.icmp_code := 0;
    ticmp_sendblock(requestdata^).icmp_header.icmp_cksum := 0;
    ticmp_sendblock(requestdata^).icmp_header.icmp_seq := f_packet_no;
    inc(f_packet_no);
    ticmp_sendblock(requestdata^).icmp_header.icmp_id := word(self);
    fillchar(ticmp_sendblock(requestdata^).data,f_blocksize,#$a7);
    ticmp_sendblock(requestdata^).time:=now_ms;
    ticmp_sendblock(requestdata^).icmp_header.icmp_cksum := ICMP_checksum(requestdata^,rq_size);
    whereto_len:=sizeof(whereto);
    whereto.sin_family:=AF_INET;
    whereto.sin_port:=0;
    whereto.sin_addr.S_addr:=f_address;
    if sendto(f_socket,requestdata^,rq_size,
      0,whereto,whereto_len)=SOCKET_ERROR then
        WSAGetLastError;
  finally
    if requestdata<>NIL then
      FreeMem(requestdata,sizeof(t_icmp_echo_request)+f_blocksize);
    end;
  end;
(*@\\\0000001501*)
(*@/// function TPing.GetRoundtimeMin:longint; *)
function TPing.GetRoundtimeMin:longint;
begin
  if f_roundtime_min=maxint then
    result:=-1
  else
    result:=f_roundtime_min;
  end;
(*@\\\0000000315*)
(*@/// function TPing.GetRoundtimeMed:extended; *)
function TPing.GetRoundtimeMed:extended;
begin
  if f_no_of_packets_rec>0 then
    result:=f_roundtime_med/f_no_of_packets_rec
  else
    result:=0;
  end;
(*@\\\000000060F*)
(*@/// procedure TPing.ResetStatistics; *)
procedure TPing.ResetStatistics;
begin
  f_no_of_packets_rec:=0;
  f_no_of_packets_snd:=0;
  f_roundtime_max:=-1;
  f_roundtime_min:=maxint;
  f_roundtime_med:=0;
  end;
(*@\\\0000000716*)
(*@/// procedure TPing.UpdateStatistics(roundtime:longint); *)
procedure TPing.UpdateStatistics(roundtime:longint);
begin
  if f_roundtime_min>roundtime then
    f_roundtime_min:=roundtime;
  if f_roundtime_max<roundtime then
    f_roundtime_max:=roundtime;
  f_roundtime_med:=f_roundtime_med+roundtime;
  end;
(*@\\\0000000701*)

(*@/// procedure TPing.WndProc(var Msg : TMessage); *)
procedure TPing.WndProc(var Msg : TMessage);
begin
  if msg.msg<>uwm_socketevent then
    inherited wndproc(msg)
  else begin
    if msg.lparamhi=socket_error then
    else begin
      case msg.lparamlo of
          fd_read: ReceiveSock;
        end;
      end;
    end;
  end;
(*@\\\0030000C01000C01000401*)
(*@\\\0000000A01*)
(*@/// class TTraceRoute(TICMP) *)
(*@/// constructor TTraceRoute.Create(Aowner:TComponent); *)
constructor TTraceRoute.Create(Aowner:TComponent);
begin
  inherited create(AOwner);
  f_blocksize:=64;
  f_route:=TStringlist.Create;
  f_resolve:=false;
  end;
(*@\\\0000000601*)
(*@/// procedure TTraceRoute.action; *)
procedure TTraceRoute.action;
var
  requestdata,replybuffer: pointer;
  p_reply: p_icmp_echo_reply;
  requestoptions: t_ip_options;
  i: integer;
begin
  inherited action;
  f_route.Clear;
  case icmp_state of
    icmp_dll,
    icmp_winsock_dll:  OpenDll;
    icmp_winsock_ttl:  raise EICMPError.Create('Not yet implemented');
    icmp_winsock,
    no_icmp:           raise EICMPError.Create('No ICMP.DLL found');
    end;

  requestdata:=NIL;
  replybuffer:=NIL;
  try
    GetMem(requestdata,f_blocksize);
    fillchar(requestdata^,f_blocksize,#$a7);
    f_replysize:=16+sizeof(t_icmp_echo_reply)+f_blocksize;
    GetMem(replybuffer,f_replysize);

    i:=0;
    while (i<f_ttl) do begin
      if f_terminated then BREAK;
      requestoptions.ttl:=i+1;
      requestoptions.tos:=0;
      requestoptions.flags:=0;
      requestoptions.optionssize:=0;
      requestoptions.optionsdata:=NIL;

      if ICMPSendEcho(icmp_handle,f_address,
                      requestdata,f_blocksize,
                      @requestoptions,
                      replybuffer,f_replysize,
                      f_timeout) = 1 then begin
        p_reply:=p_icmp_echo_reply(replybuffer);
        if (p_reply^.status=ip_success) and
           (p_reply^.address=f_address) then begin
           f_terminated:=true;
           inc(i);
          end
        else if (p_reply^.status=ip_ttl_expired_transmit) then
          inc(i)
        else
          {};
        if ((p_reply^.status=ip_success) or
           (p_reply^.status=ip_ttl_expired_transmit)) then begin
          if f_resolve then
            f_route.add(resolve_hostname(p_reply^.address))
          else
            f_route.add(ip2string(p_reply^.address));
          if assigned(f_on_route) then
            f_on_route(self,i,p_reply^.address,p_reply^.rttime);
          end;
        end;
      end;
  finally
    if requestdata<>NIL then
      FreeMem(requestdata,f_blocksize);
    if replybuffer<>NIL then
      FreeMem(replybuffer,f_replysize);
    end;
  end;
(*@\\\*)
(*@/// destructor TTraceRoute.Destroy; *)
destructor TTraceRoute.Destroy;
begin
  f_route.Free;
  inherited destroy;
  end;
(*@\\\0000000310*)
(*@\\\0000000301*)

(*@/// procedure shutdown; FAR; *)
procedure shutdown; FAR;
begin
  if hDll<>0 then  FreeLibrary(hDll);
  end;
(*@\\\0000000301*)

(*@/// procedure Register; *)
procedure Register;
begin
  RegisterComponents('Internet', [TPing]);
  RegisterComponents('Internet', [TTraceRoute]);
  end;
(*@\\\000000042E*)
(*@\\\0000000B14*)
(*@/// initialization *)
var
  f_socket: TSocket;
  h: integer;
(*@/// function check_dll:boolean; *)
function check_dll:boolean;
begin
  SetErrorMode(sem_NoOpenFileErrorBox);   (* keep it silent *)
  hDll:=LoadLibrary('ICMP.DLL');
  if hdll<>0 then begin
    @ICMPCreateFile:=GetProcAddress(hdll,'IcmpCreateFile');
    @ICMPCloseHandle:=GetProcAddress(hdll,'IcmpCloseHandle');
    @ICMPSendEcho:=GetProcAddress(hdll,'IcmpSendEcho');
    result:=true;
    end
  else
    result:=false;        (* no ICMP possible *)
  end;
(*@\\\*)
(*$ifdef ver80 *)
begin
(*$else *)
initialization
begin
(*$endif *)
  f_socket:=Winsock.Socket(PF_INET,SOCK_RAW,IPPROTO_ICMP);  (* check for raw socket *)
  if f_socket=INVALID_SOCKET then begin
    if check_dll then
      icmp_state:=icmp_dll
    else
      icmp_state:=no_icmp;
    end
  else begin
    h:=64;   (* just an arbitrary number *)
    if Winsock.SetSockOpt(f_socket,IPPROTO_IP, IP_TTL, pchar(@h), sizeof(h))<>0 then begin
      winsock.WSAGetLastError;
      if check_dll then
        icmp_state:=icmp_winsock_dll
      else
        icmp_state:=icmp_winsock;
      end
    else
      icmp_state:=icmp_winsock_ttl;
    closesocket(f_socket);
    end;
(*@\\\0000000401*)
(*@/// finalization *)
(*$ifdef ver80 *)
  AddExitProc(Shutdown);
(*$else *)
  end;
finalization
  Shutdown;
(*$endif *)
(*@\\\*)
end.
(*@\\\0003000301000011000301*)
