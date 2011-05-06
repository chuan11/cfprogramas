program ConfigListas;
uses
  Forms,
  unConflistas in 'unConflistas.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
