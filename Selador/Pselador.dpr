program Pselador;

uses
  Forms,  sysUtils, windows,
  Uselador in 'Uselador.pas' {Form1},
  CadstroFormuarios in 'CadstroFormuarios.pas' {Form2},
  Unumeracao in 'Unumeracao.pas' {Fnumeracao};

{$R *.RES}

begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe') ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end
   else begin
      Application.Initialize;
      Application.CreateForm(TForm1, Form1);
      Application.Run;
   end;
end.
