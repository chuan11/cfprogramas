program GrFingerXSampleDelphi;

uses
  Forms,
  uMain in 'uMain.pas' {formMain},
  uOptions in 'uOptions.pas' {formOptions},
  uDBClass in 'uDBClass.pas',
  uUtil in 'uUtil.pas';

{$R *.res}

 begin
  Application.Initialize;
  Application.Title := 'GrFingerX - Sample application - Delphi';
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformOptions, formOptions);
  Application.Run;
end.
