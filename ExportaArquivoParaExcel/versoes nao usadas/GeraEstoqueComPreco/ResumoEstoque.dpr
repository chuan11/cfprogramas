program ResumoEstoque;

uses
  Forms,
  Unit5 in 'Unit5.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  application.Title := 'ResumoDoEstoque';
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
