program ImpressaoInventario;

uses
  Forms,
  Unit_tiralinhas in 'Unit_tiralinhas.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
