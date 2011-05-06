program MapaDeEstoque;

uses
  Forms,
  MapaEstoque in 'MapaEstoque.pas' {Form1},
  unClasses in 'unClasses.pas' {FmClasses};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Mapa de estoque';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
