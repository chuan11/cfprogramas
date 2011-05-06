program ip_trace;

uses
  Forms,
  main in 'main.pas' {gridform},
  options in 'options.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(Tgridform, gridform);
  Application.Run;
  end.
