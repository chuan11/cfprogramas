program ScrollTextDemoPjt;

uses
  Forms,
  ScrollTextDemo in 'ScrollTextDemo.pas' {Form1},
  ScrollText in 'Library\Components\ScrollText.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

