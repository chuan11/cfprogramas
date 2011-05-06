program CopiaPlanodeContas;

uses
  Forms,
  ucopiarPlanodeContas in 'ucopiarPlanodeContas.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Copiar planos de conta';
  Application.CreateForm(TForm1, Form1);
  application.Run;
end.
