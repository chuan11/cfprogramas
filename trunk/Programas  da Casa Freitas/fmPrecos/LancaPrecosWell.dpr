program LancaPrecosWell;

uses
  Forms,
  Uprecoswell in 'Uprecoswell.pas' {Form1},
  unit2 in 'unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
