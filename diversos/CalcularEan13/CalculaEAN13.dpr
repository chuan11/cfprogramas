program CalculaEAN13;

uses
  Forms,
  UCalcEAN13 in 'UCalcEAN13.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
