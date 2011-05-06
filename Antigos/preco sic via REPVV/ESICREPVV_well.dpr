program ESICREPVV_well;

uses
  Forms,
  u_PSIC_REPVV_well in 'u_PSIC_REPVV_well.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  APPLICATION.TITLE:= TITULO;
end.
