program MRegAnt;

uses
  Forms,
  UMRegAnt in 'UMRegAnt.pas' {Form1},
  funcoes in '..\ImportacaoParaWell\funcoes.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run
end.
