program FluxoDeClientes;

uses
  Forms,
  uFluxoClientes in 'uFluxoClientes.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
