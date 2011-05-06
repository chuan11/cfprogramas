program GeraRelEstoque;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  funcoes in '..\Funcoes\funcoes.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit4 in 'Unit4.pas' {Form4},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Consulta Estoque';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
