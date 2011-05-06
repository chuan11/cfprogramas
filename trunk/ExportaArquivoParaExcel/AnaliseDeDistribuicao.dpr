program AnaliseDeDistribuicao;

uses
  Forms,
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Análise distribuição';
  Application.CreateForm(TForm3, Form3);
  Application.Run;

end.
