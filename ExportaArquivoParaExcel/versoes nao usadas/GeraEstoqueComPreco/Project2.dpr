program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  funcoes in '..\Funcoes\funcoes.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
