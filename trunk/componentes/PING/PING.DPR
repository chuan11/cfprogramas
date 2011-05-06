program ping;

uses
  Forms,
  u_ping in 'u_ping.pas' {frm_ping};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_ping, frm_ping);
  Application.Run;
end.
