program listas;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {ProdutosNaLista},
  Unit3 in 'Unit3.pas' {CadListas},
  Unit5 in 'Unit5.pas' {Form5},
  Unit4 in 'Unit4.pas' {FImpressao},
  Unit6 in 'Unit6.pas' {fpesquisa};

{$R *.RES}

var
  i:integer;
begin
   Application.Initialize;
   Application.CreateForm(Tform1, form1);
  Application.Run;
end.

end.
