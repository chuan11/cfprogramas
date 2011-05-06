program Manipulador;

uses
  Forms,
  UmanBat in 'UmanBat.pas' {fmMain},
  system,
  sysUtils,
  windows,
  funcoes,
  uPessoal in '..\Funcoes\uPessoal.pas';
  uHorarios in 'uHorarios.pas' {fmHorarios},
  uUtil in '..\Relogio de ponto - biometrico\uUtil.pas',
  uDBClass in '..\Relogio de ponto - biometrico\uDBClass.pas';

//  uPessoal in '..\Funcoes\uPessoal.pas',
//  uImportaCadastro in 'uImportaCadastro.pas' {fmExportaEmp},
//  uCadEmpregados in 'uCadEmpregados.pas' {fmCadEmpregados},
//  uListagem in 'uListagem.pas' {Frame1: TFrame},
//  uListas in 'uListas.pas' {fmListas};


{$R *.res}
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe') ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end
   else begin
      Application.Initialize;
      Application.Title := 'Utilitarios ';
      Application.CreateForm(TfmMain, fmMain);
  Application.Run;
   end;
end.

