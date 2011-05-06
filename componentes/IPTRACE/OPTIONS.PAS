unit options;
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
  Spin,
  ip_misc,
  winsock;
(*@\\\*)

type
(*@///   Tmainform = class(TForm) *)
Tmainform = class(TForm)
  Label1: TLabel;
  edt: TMaskEdit;
  btn_go: TButton;
  edt_freq: TSpinEdit;
  edt_timeout: TSpinEdit;
  Label2: TLabel;
  Label3: TLabel;
  chk_resolve: TCheckBox;
  procedure btn_goClick(Sender: TObject);
  end;
(*@\\\0000000B03*)

var
  mainform: Tmainform;
(*@\\\0000000601*)
(*@/// implementation *)
implementation

uses main;

{$R *.DFM}

(*@/// procedure Tmainform.btn_goClick(Sender: TObject); *)
procedure Tmainform.btn_goClick(Sender: TObject);
var s:string;
begin
  s:=edt.text;
  s:=copy(s,1,3)+'.'+copy(s,4,3)+'.'+copy(s,7,3)+'.0';
  gridform.ip_base:=ntohl(lookup_hostname(s));
  gridform.ping.timeout:=edt_timeout.value;
  gridform.timer.interval:=edt_freq.value*1000;
  gridform.resolve:=chk_resolve.checked;
  gridform.show;
  end;
(*@\\\000C000101000B07*)

(*@\\\0030000801000101000701*)
end.
(*@\\\0003000301000011000301*)
