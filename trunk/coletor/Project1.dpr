program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fmMain},
  uNovaContagem in 'uNovaContagem.pas' {fmNovaContagem};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
