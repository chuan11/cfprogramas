program PcODbARRAS;

uses
  Forms,
  UGeraEtiquetasCodBarras in 'UGeraEtiquetasCodBarras.pas';
{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'GeraEtiquetasCodBarras*';
  APPLICATION.CreateForm(Tform1, form1);
  Application.Run;
end.
