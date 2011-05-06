program LancaPrecosWell;

uses
  Forms,
  Uprecoswell in 'Uprecoswell.pas' {Form1},
  unit2 in 'unit2.pas' {Form2},
  Unit1 in '..\..\LancaPrecosWell\Unit1.pas' {PasswordDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
