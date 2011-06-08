program GeraEtiquetasCodBarras;

uses
  Forms,
  UGeraEtiquetasCodBarras in 'UGeraEtiquetasCodBarras.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  application.title:= 'GerarCodBarras';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
