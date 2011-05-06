program Project1;

uses
  Forms,
  diasSemvenda in 'diasSemvenda.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
