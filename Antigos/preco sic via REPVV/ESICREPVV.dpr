program ESICREPVV;

uses
  Forms,
  u_PSIC_REPVV in 'u_PSIC_REPVV.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  APPLICATION.TITLE:= TITULO;
end.
