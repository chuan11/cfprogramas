program qDemo;

uses
  Forms,
  fMain in 'fMain.pas' {frmMain},
  fDM in 'fDM.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
