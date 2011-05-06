unit main;
(*@/// interface *)
interface

(*@/// uses *)
uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Mask,
  ExtCtrls,
  icmp,
  Grids,
  Aligrid,
  ip_misc,
  winsock;
(*@\\\0000001103*)

type
(*@///   Tgridform = class(TForm) *)
Tgridform = class(TForm)
  grid: TStringAlignGrid;
  ping: TPing;
  Timer: TTimer;
  procedure pingPing(sender: TObject; status: Integer; ip,roundtime: Longint);
  procedure TimerCall(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure FormHide(Sender: TObject);
public
  ip: byte;
  ip_base: longint;
  resolve: boolean;
  end;
(*@\\\0000000103*)

var
  gridform: Tgridform;
(*@\\\0000000601*)
(*@/// implementation *)
implementation

{$R *.DFM}

(*@/// procedure Tgridform.pingPing(sender: TObject; status: Integer; ip,roundtime: Longint); *)
procedure Tgridform.pingPing(sender: TObject; status: Integer; ip,roundtime: Longint);
var x,y: integer;
begin
  x:=(byte(ip) and $0f)+1;
  y:=((byte(ip) and $f0) shr 4) +1;
  if status<=ip_success then begin
    grid.colorcell[x,y]:=clLime;
    grid.cells[x,y]:=inttostr(roundtime)+' ms';
    end;
  end;
(*@\\\0000000A03*)
(*@/// procedure Tgridform.TimerCall(Sender: TObject); *)
procedure Tgridform.TimerCall(Sender: TObject);
var
  x,y: integer;
  s:string;
begin
  x:=(ip and $0f)+1;
  y:=((ip and $f0) shr 4) +1;
  if grid.colorcell[x,y]=clYellow then
    grid.colorcell[x,y]:=clRed;
  inc(ip);
  if ip>=255 then ip:=0;
  x:=(ip and $0f)+1;
  y:=((ip and $f0) shr 4) +1;
  grid.colorcell[x,y]:=clYellow;
  grid.cells[x,y]:='';
  ping.hostname:=ip2string(htonl(ip_base+ip));
  try
    grid.hintcell[x,y]:=ping.hostname;
    ping.action;
    if resolve then begin
      s:=resolve_hostname(lookup_hostname(ping.hostname));
      if s<>'' then grid.hintcell[x,y]:=s;
      end;
  except
    end;
  end;
(*@\\\*)
(*@/// procedure Tgridform.FormShow(Sender: TObject); *)
procedure Tgridform.FormShow(Sender: TObject);
begin
  timer.enabled:=true;
  ip:=0;
  end;
(*@\\\0000000601*)
(*@/// procedure Tgridform.FormHide(Sender: TObject); *)
procedure Tgridform.FormHide(Sender: TObject);
var x,y: integer;
begin
  timer.enabled:=false;
  x:=(ip and $0f)+1;
  y:=((ip and $f0) shr 4) +1;
  if grid.colorcell[x,y]=clYellow then
    grid.colorcell[x,y]:=clRed;
  end;
(*@\\\000C000101000907*)

(*@\\\0030000901000101000801*)
end.
(*@\\\0003000301000011000301*)
