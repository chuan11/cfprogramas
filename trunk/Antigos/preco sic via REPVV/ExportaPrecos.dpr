program ExportaPrecos;

uses
  Forms,
  LancaPrecosSIC2k in 'LancaPrecosSIC2k.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
