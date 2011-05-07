program RelogioB;
uses
  Forms,
  RelogioPonto in 'RelogioPonto.pas' {fmMain};

{$R *.RES}
begin
  Application.Initialize;
  Application.Title := 'Controle interno';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
