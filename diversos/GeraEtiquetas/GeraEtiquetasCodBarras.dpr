program GeraEtiquetasCodBarras;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uPallet in 'uPallet.pas' {Pallet};

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
