program Sistema;

uses
  Forms,
  Principal_Form in 'Principal_Form.pas' {frmPrincipal},
  Close_Form in 'Close_Form.pas' {frmClose},
  CadCliente_Form in 'CadCliente_Form.pas' {frmCadAluno},
  CadModalidade_Form in 'CadModalidade_Form.pas' {frmCadMod},
  IncluiAlteraModalidade_Form in 'IncluiAlteraModalidade_Form.pas' {frmIncluiMod},
  EscolhaMod_Form in 'EscolhaMod_Form.pas' {frmEscolha},
  AlteraModalidade_Form in 'AlteraModalidade_Form.pas' {frmAlteraMod},
  RelAniversario_Form in 'RelAniversario_Form.pas' {frmRelAniversario},
  RelMensalidades_Form in 'RelMensalidades_Form.pas' {frmRelMensalidades},
  Preview_Form in 'Preview_Form.pas' {frmPreview},
  CadMedidas_Form in 'CadMedidas_Form.pas' {frmCadMedidas},
  IncluiMedidas_Form in 'IncluiMedidas_Form.pas' {frmIncluiMedidas},
  AlteraMedidas_Form in 'AlteraMedidas_Form.pas' {frmAlteraMedidas},
  Pagamento_Form in 'Pagamento_Form.pas' {frmPagamento},
  Calendario_Form in 'Calendario_Form.pas' {frmCalendario},
  NovoPagamento_Form in 'NovoPagamento_Form.pas' {frmNovoPagamento},
  AlteraPagamento in 'AlteraPagamento.pas' {frmAlteraPagamento},
  CadAluno_Rel in 'CadAluno_Rel.pas' {frmRelCadAlu},
  InfoSistema_Form in 'InfoSistema_Form.pas' {frmInfoSistema},
  Programador_Form in 'Programador_Form.pas' {frmProgramador};

{$R *.RES}


begin
{Exibe tela de Splash}
// F_Splash := TF_Splash.Create(Application);
// F_Splash.Show;
// F_Splash.Refresh;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.


