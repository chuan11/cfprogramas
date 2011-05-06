unit u_ping;
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
  icmp,
  ExtCtrls;
(*@\\\0000000C01*)

type
(*@///   Tfrm_ping = class(TForm) *)
Tfrm_ping = class(TForm)
  Ping: TPing;
  lbl_host: TLabel;
  edt_hostname: TEdit;
  mem_out: TMemo;
  btn_start: TButton;
  btn_break: TButton;
  Timer: TTimer;
  procedure btn_startClick(Sender: TObject);
  procedure PingPing(sender:TObject; status:Integer; ip,roundtime:Longint);
  procedure btn_breakClick(Sender: TObject);
  procedure TimerTimer(Sender: TObject);
end;
(*@\\\0000000A1D*)

var
  frm_ping: Tfrm_ping;
(*@\\\0000000301*)
(*@/// implementation *)
implementation

{$R *.DFM}

uses
  ip_misc;

var
  nr: integer;

(*@/// procedure Tfrm_ping.btn_startClick(Sender: TObject); *)
procedure Tfrm_ping.btn_startClick(Sender: TObject);
begin
  ping.hostname:=edt_hostname.text;
  mem_out.lines.clear;
  nr:=0;
  timer.enabled:=true;
  end;
(*@\\\*)
(*@/// procedure Tfrm_ping.PingPing(sender:TObject; status:Integer; ip,roundtime:Longint); *)
procedure Tfrm_ping.PingPing(sender:TObject; status:Integer; ip,roundtime:Longint);
begin
  inc(nr);
  case status of
    ip_success:
      mem_out.lines.add(inttostr(nr)+'. '+inttostr(roundtime)+'ms');
    else
      mem_out.lines.add(inttostr(nr)+'. Failed')
    end;
end;
(*@\\\003E000601000601000801000A01000709000709*)
(*@/// procedure Tfrm_ping.btn_breakClick(Sender: TObject); *)
procedure Tfrm_ping.btn_breakClick(Sender: TObject);
begin
  ping.terminate;
  timer.enabled:=false;
  end;
(*@\\\*)
(*@/// procedure Tfrm_ping.TimerTimer(Sender: TObject); *)
procedure Tfrm_ping.TimerTimer(Sender: TObject);
begin
  ping.action;
  end;
(*@\\\*)
(*@\\\0000000C31*)
end.
(*@\\\0001000011000301*)
