program AnaliseDeEstoques;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  unClasses in 'unClasses.pas' {FmClasses},
  Uforn in 'Uforn.pas' {fmForn};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Analise de estoque';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
