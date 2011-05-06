program PrecoAlteradosPorPeriodo;

uses
  Forms,
  UpcoAlteradoPorPeriodo in 'UpcoAlteradoPorPeriodo.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Precos alterados por dia';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
