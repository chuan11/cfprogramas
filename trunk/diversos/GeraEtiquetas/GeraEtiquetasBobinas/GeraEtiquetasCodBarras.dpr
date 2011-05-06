program GeraEtiquetasCodBarras;

uses
  Forms,
  UGeraEtiquetasCodBarras in 'UGeraEtiquetasCodBarras.pas'
//  UetiquetaPallete in 'UetiquetaPallete.pas' {Fmpallete}
;

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'GeraEtiquetasCodBarras*';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
