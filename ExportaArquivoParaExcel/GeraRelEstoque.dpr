program GeraRelEstoque;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  funcoes in '..\Funcoes\funcoes.pas',
  fmNotasEntrada in '..\Programas  da Casa Freitas\fmGeraEstoque\fmNotasEntrada.pas' {Form2},
  Unit4 in 'Unit4.pas' {Form4},
  Unit3 in 'Unit3.pas' {Form3},
  uEentSai in '..\Programas  da Casa Freitas\fmGeraEstoque\fmResumoEntSai\uEentSai.pas' {fmEntSai},
  AbreCategorias in '..\Funcoes\AbreCategorias.pas',
  chamaCategorias in '..\Funcoes\chamaCategorias.pas',
  uChamaCat in '..\Funcoes\Categorias\uChamaCat.pas',
  uSelCat in '..\Funcoes\Categorias\uSelCat.pas' {fmSelCat},
  Unit5 in 'Unit5.pas' {Form5},
  Unit7 in 'Unit7.pas',
  Unit6 in 'Unit6.pas' {Form6};

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Consulta Estoque';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
