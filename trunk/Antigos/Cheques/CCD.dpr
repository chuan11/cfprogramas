program CCD;

uses
  Forms,
  ContCheques in 'ContCheques.pas' {Form1},
  Uimpressao in 'Uimpressao.pas' {Form2},
  funcoes in '..\ImportacaoParaWell\funcoes.pas',
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
