program CadImagensBD;

uses
  Forms,
  uCadastro in 'uCadastro.pas' {fmCadastro},
  uMain in 'uMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cadastro de imagens';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
