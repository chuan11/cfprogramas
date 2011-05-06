unit Principal_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Menus, ExtCtrls, Db, DBTables, StdCtrls, Buttons, QRPrntr,
  ComCtrls, iniFiles;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Ajuda1: TMenuItem;
    SobreoSistema1: TMenuItem;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    ImageList1: TImageList;
    Impressos1: TMenuItem;
    RelatriodeAniversriantes1: TMenuItem;
    CadastrodeAlunos1: TMenuItem;
    Database1: TDatabase;
    Janeiro1: TMenuItem;
    Fevereiro1: TMenuItem;
    Maro1: TMenuItem;
    Abril1: TMenuItem;
    Maio1: TMenuItem;
    Junho1: TMenuItem;
    Julho1: TMenuItem;
    Agosto1: TMenuItem;
    Setembro1: TMenuItem;
    Outubro1: TMenuItem;
    Novembro1: TMenuItem;
    Dezembro1: TMenuItem;
    CadastrodeModalidades1: TMenuItem;
    N2: TMenuItem;
    RelatriodeMensalidades1: TMenuItem;
    CadastrodeMedidas1: TMenuItem;
    Movimento1: TMenuItem;
    PagamentosdeMensalidades1: TMenuItem;
    Shape1: TShape;
    Exibir1: TMenuItem;
    Calendrio1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Barradestatus1: TMenuItem;
    Opes1: TMenuItem;
    CordeFundo1: TMenuItem;
    CordaslinhasdeFundo1: TMenuItem;
    dlcFundo: TColorDialog;
    SobreoProgramador1: TMenuItem;
    LigarproteodeTela1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Fechar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CadastrodeAlunos1Click(Sender: TObject);
    procedure CadastrodeModalidades1Click(Sender: TObject);
    procedure RelatriodeMensalidades1Click(Sender: TObject);
    procedure Janeiro1Click(Sender: TObject);
    procedure Fevereiro1Click(Sender: TObject);
    procedure Maro1Click(Sender: TObject);
    procedure Abril1Click(Sender: TObject);
    procedure Maio1Click(Sender: TObject);
    procedure Junho1Click(Sender: TObject);
    procedure Julho1Click(Sender: TObject);
    procedure Agosto1Click(Sender: TObject);
    procedure Setembro1Click(Sender: TObject);
    procedure Outubro1Click(Sender: TObject);
    procedure Novembro1Click(Sender: TObject);
    procedure Dezembro1Click(Sender: TObject);
    procedure CadastrodeMedidas1Click(Sender: TObject);
    procedure PagamentosdeMensalidades1Click(Sender: TObject);
    procedure Calendrio1Click(Sender: TObject);
    procedure Barradestatus1Click(Sender: TObject);
    procedure CordeFundo1Click(Sender: TObject);
    procedure CordaslinhasdeFundo1Click(Sender: TObject);
    procedure LigarproteodeTela1Click(Sender: TObject);
    procedure SobreoSistema1Click(Sender: TObject);
    procedure SobreoProgramador1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Preview(Sender: TObject);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Close_Form, CadCliente_Form, CadModalidade_Form, RelAniversario_Form,
  RelMensalidades_Form, Preview_Form, CadMedidas_Form, Pagamento_Form,
  Calendario_Form, InfoSistema_Form, Programador_Form;

{$R *.DFM}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
var ini: TiniFile;
begin
{Grava a cor de fundo em arquino *.ini}
//*********************************************************//
ini := TiniFile.Create('Academia.ini');
ini.WriteInteger('CONFIG','COLOR',frmPrincipal.Color);
ini.WriteInteger('CONFIG','LINHAS',frmPrincipal.Shape1.Brush.Color);
ini.Free;
//*********************************************************//
frmClose := TfrmClose.Create(self);
frmClose.ShowModal;
Action := caFree;
end;

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
Close;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var ini: TiniFile;
begin
{lê a cor de Fundo de um arquivo *.ini}
//*********************************************************//
ini := TiniFile.Create('Academia.ini');
frmPrincipal.color := ini.ReadInteger('CONFIG','COLOR',0);
frmPrincipal.Shape1.Brush.Color := ini.ReadInteger('CONFIG','LINHAS',0);
ini.Free;
//*********************************************************//
Try
 Database1.Connected := True;
Except
 Beep;
 ShowMessage('Não foi possível conectar-se ao banco de Dados');
 Application.Terminate;
end; // TRY
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
StatusBar1.Panels[2].Text:=FormatDateTime('dddd ", " dd " de " mmmm " de " yyyy',Now());
//StatusBar1.Panels[1].Text:= TimeToStr(Time);
StatusBar1.Panels[1].Text:=FormatDateTime('hh":"nn":"ss"',Now());
end;

procedure TfrmPrincipal.CadastrodeAlunos1Click(Sender: TObject);
begin
try
 if frmCadAluno = Nil then
  begin
   frmCadAluno := TfrmCadAluno.Create(self);
   frmCadAluno.ShowModal;
  end; // Begin
except
 ShowMessage('Erro ao tentar exibir a tela de Cadastro de Alunos!!');
end; // TRY
end;

procedure TfrmPrincipal.CadastrodeModalidades1Click(Sender: TObject);
begin
try
if frmCadMod = Nil then
 begin
  frmCadMod := TfrmCadMod.Create(self);
  frmCadMod.ShowModal;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir a tela de Cadastro de Modalidades!!');
end; // TRY
end;

procedure TfrmPrincipal.Preview(Sender: TObject);
begin
try
 frmPreview := TfrmPreview.Create(self);
 frmPreview.QRPreview1.QRPrinter := TQRPrinter(Sender);
 frmPreview.Show;
Except
 ShowMessage('Erro ao tentar exibir tela de preview');
end; // TRY
end;

procedure TfrmPrincipal.RelatriodeMensalidades1Click(Sender: TObject);
begin
try
 if frmRelMensalidades = Nil then
  begin
  frmRelMensalidades := TfrmRelMensalidades.Create(self);
  frmRelMensalidades.QuickRep1.OnPreview := Preview;
  frmRelMensalidades.qryMensalidade.Open;
  frmRelMensalidades.QuickRep1.Preview;
  frmRelMensalidades.Free;
  frmRelMensalidades := Nil;
  end;
except
 ShowMessage('Erro ao tentar exibir o Relatório de Mensalidades!!');
end; // TRY
end;

procedure TfrmPrincipal.Janeiro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Janeiro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 1;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Fevereiro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Fevereiro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 2;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Maro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Março';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 3;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Abril1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Abril';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 4;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Maio1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Maio';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 5;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Junho1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Junho';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 6;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Julho1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Julho';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 7;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Agosto1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Agosto';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 8;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Setembro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Setembro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 9;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Outubro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Outubro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 10;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Novembro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Novembro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 11;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.Dezembro1Click(Sender: TObject);
begin
Try
if frmRelAniversario = Nil then
 begin
  frmRelAniversario := TfrmRelAniversario.Create(self);
  frmRelAniversario.QuickRep1.OnPreview := Preview;
  frmRelAniversario.QRlblMes.Caption := 'Aniversariantes do Mês de: Dezembro';
  With frmRelAniversario.qryAniversario do
   begin
    ParambyName('Mes').Value := 12;
    Open;
   end; // do begin
  frmRelAniversario.QuickRep1.Preview;
  frmRelAniversario.Free;
  frmRelAniversario := Nil;
 end; // Begin
except
 ShowMessage('Erro ao tentar exibir o Relatório de Aniversariantes!!');
end; // TRY
end;

procedure TfrmPrincipal.CadastrodeMedidas1Click(Sender: TObject);
begin
Try
 if frmCadMedidas = Nil then
  begin
   frmCadMedidas := TfrmCadMedidas.Create(self);
   frmCadMedidas.ShowModal;
  end;
except
 ShowMessage('Erro ao tentar exibir a tela de cadastro de medidas!!');
end; // TRY
end;

procedure TfrmPrincipal.PagamentosdeMensalidades1Click(Sender: TObject);
begin
Try
 if frmPagamento = Nil then
  begin
   frmPagamento := TfrmPagamento.Create(self);
   frmPagamento.ShowModal;
  end;
Except
 ShowMessage('Erro ao tentar exibir a tela de pagamentos!!');
end; // TRY
end;

procedure TfrmPrincipal.Calendrio1Click(Sender: TObject);
begin
Try
 if frmCalendario = Nil then
  begin
   frmCalendario := TfrmCalendario.Create(self);
   frmCalendario.ShowModal;
  end;
Except
 ShowMessage('Erro ao tentar exibir o calendário!!');
end; // TRY
end;

procedure TfrmPrincipal.Barradestatus1Click(Sender: TObject);
begin
if Barradestatus1.Checked then
 begin
 Barradestatus1.Checked := False;
 StatusBar1.Visible := False;
 end // Begin
else
 begin
 Barradestatus1.Checked := True;
 StatusBar1.Visible := True;
 end; // Begin
end;

procedure TfrmPrincipal.CordeFundo1Click(Sender: TObject);
begin
dlcFundo.Color := Color;
if dlcFundo.Execute then
 Color := dlcFundo.Color;
end;

procedure TfrmPrincipal.CordaslinhasdeFundo1Click(Sender: TObject);
begin
dlcFundo.Color := Shape1.Brush.Color;
if dlcFundo.Execute then
 Shape1.Brush.Color := dlcFundo.Color;
end;

procedure TfrmPrincipal.LigarproteodeTela1Click(Sender: TObject);
begin
SendMessage(Application.Handle, WM_SYSCOMMAND, SC_SCREENSAVE, 0);
end;

procedure TfrmPrincipal.SobreoSistema1Click(Sender: TObject);
begin
Try
 if frmInfoSistema = Nil then
  Begin
    frmInfoSistema := TfrmInfoSistema.Create(self);
    frmInfoSistema.ShowModal;
  End;
Except
 ShowMessage('Erro ao tentar exibir as informações do Sistema!!');
end; // Try
end;

procedure TfrmPrincipal.SobreoProgramador1Click(Sender: TObject);
begin
Try
 if frmProgramador = Nil then
  Begin
   frmProgramador := TfrmProgramador.Create(self);
   frmProgramador.ShowModal;
  End;
Except
 ShowMessage('Erro ao tentar exibir as informações sobre o programador!!');
end; // Try
end;

end.
