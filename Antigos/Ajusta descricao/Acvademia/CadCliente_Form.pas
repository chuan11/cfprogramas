unit CadCliente_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, DBCtrls, Mask, Buttons, ExtCtrls;

type
  TfrmCadAluno = class(TForm)
    qryAlu: TQuery;
    dsAlu: TDataSource;
    upsAlu: TUpdateSQL;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBMemo1: TDBMemo;
    Label13: TLabel;
    DBEdit12: TDBEdit;
    Label14: TLabel;
    DBEdit13: TDBEdit;
    Label15: TLabel;
    DBEdit14: TDBEdit;
    Label16: TLabel;
    DBEdit15: TDBEdit;
    Label17: TLabel;
    DBEdit16: TDBEdit;
    Label18: TLabel;
    DBEdit17: TDBEdit;
    qryMod: TQuery;
    dsMod: TDataSource;
    dblcMod1: TDBLookupComboBox;
    dblcMod2: TDBLookupComboBox;
    dblcMod3: TDBLookupComboBox;
    dblcMod4: TDBLookupComboBox;
    dblcMod5: TDBLookupComboBox;
    dblcMod6: TDBLookupComboBox;
    Label19: TLabel;
    DBEdit18: TDBEdit;
    GroupBox2: TGroupBox;
    dblcNomeAlu: TDBLookupComboBox;
    dsNomeAlu: TDataSource;
    qryNomeAlu: TQuery;
    btnNovoAlu: TBitBtn;
    btnAltera: TBitBtn;
    Panel1: TPanel;
    btnGrava: TBitBtn;
    btnCancela: TBitBtn;
    Panel2: TPanel;
    btnPrimeiro: TBitBtn;
    btnAnterior: TBitBtn;
    btnProximo: TBitBtn;
    btnUltimo: TBitBtn;
    btnLocCod: TBitBtn;
    btnExclui: TBitBtn;
    qryAluCOD_ALU: TIntegerField;
    qryAluNOME: TStringField;
    qryAluENDERECO: TStringField;
    qryAluBAIRRO: TStringField;
    qryAluCIDADE: TStringField;
    qryAluESTADO: TStringField;
    qryAluTELEFONE: TStringField;
    qryAluCEP: TStringField;
    qryAluRG: TStringField;
    qryAluCPF: TStringField;
    qryAluDATA_NASC: TDateTimeField;
    qryAluDATA_CAD: TDateTimeField;
    qryAluOBS: TMemoField;
    qryAluCOD_MOD1: TIntegerField;
    qryAluCOD_MOD2: TIntegerField;
    qryAluCOD_MOD3: TIntegerField;
    qryAluCOD_MOD4: TIntegerField;
    qryAluCOD_MOD5: TIntegerField;
    qryAluCOD_MOD6: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoAluClick(Sender: TObject);
    procedure btnAlteraClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure dblcNomeAluClick(Sender: TObject);
    procedure btnLocCodClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dblcMod1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcNomeAluKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcMod1Click(Sender: TObject);
    procedure dblcMod2Click(Sender: TObject);
    procedure dblcMod3Click(Sender: TObject);
    procedure dblcMod4Click(Sender: TObject);
    procedure dblcMod5Click(Sender: TObject);
    procedure dblcMod6Click(Sender: TObject);
    procedure dblcMod1Exit(Sender: TObject);
    procedure dblcMod2Exit(Sender: TObject);
    procedure dblcMod3Exit(Sender: TObject);
    procedure dblcMod4Exit(Sender: TObject);
    procedure dblcMod5Exit(Sender: TObject);
    procedure dblcMod6Exit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExcluiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAluno: TfrmCadAluno;

implementation

uses CadAluno_Rel;

{$R *.DFM}

{*****************************************************************}
{*             procedure Para tratamento de erro                 *}
{*****************************************************************}

procedure ShowError ( E: Exception);
var sMsg: string;
    i: Integer;
begin
sMsg := '';
if E is EDBEngineError then
 with EDBEngineError(E) do begin
   case Errors[0].ErrorCode of
     10024: sMsg := 'Tabela '+ Errors[1].Message+' Não Existe...';
     10241: sMsg := 'Registro Bloqueado por '+ Errors[2].Message;
     10243: sMsg := 'Tabela sendo usada por '+ Errors[2].Message;
     10245: sMsg := 'Arquivo bloqueado por '+ Errors[2].Message;
   else
     for i:=0 to ErrorCount - 1 do
        sMsg := sMsg + 'Código: '+ IntToStr(Errors[i].ErrorCode) + '........'+
                     Errors[i].Message + chr(13);

   end; // fecha Case
   ShowMessage(sMsg);
 end // fecha Begin do With
else
   ShowMessage('Erro da Classe ' + E.ClassName + Chr(13)+
               'Mensagem: ' + E.Message );
end;

{*****************************************************************}
{*        Fim da procedure Para tratamento de erro               *}
{*****************************************************************}

procedure TfrmCadAluno.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
qryAlu.CommitUpdates;
Action := caFree;
frmCadAluno := Nil;
end;

procedure TfrmCadAluno.btnNovoAluClick(Sender: TObject);
var iCod: Integer;
begin
Try
 btnPrimeiro.Enabled := False;
 btnAnterior.Enabled := False;
 btnProximo.Enabled := False;
 btnUltimo.Enabled := False;
 btnLocCod.Enabled := False;
 btnExclui.Enabled := False;
 btnNovoAlu.Enabled := False;
 btnAltera.Enabled := False;
 panel1.Visible := True;
 dblcNomeAlu.Enabled := False;
 dblcMod1.Enabled := True;
{ dblcMod2.Enabled := True;
 dblcMod3.Enabled := True;
 dblcMod4.Enabled := True;
 dblcMod5.Enabled := True;
 dblcMod6.Enabled := True;}
 qryAlu.Last;
 iCod := qryAluCOD_ALU.Value + 1;
 qryAlu.Append;
 qryAluCOD_ALU.Value := iCod;
 qryAluDATA_CAD.Value := Trunc(Date);
 DBEdit2.SetFocus;
 Tag := 1;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadAluno.btnAlteraClick(Sender: TObject);
begin
Try
 btnPrimeiro.Enabled := False;
 btnAnterior.Enabled := False;
 btnProximo.Enabled := False;
 btnUltimo.Enabled := False;
 btnLocCod.Enabled := False;
 btnExclui.Enabled := False;
 btnNovoAlu.Enabled := False;
 btnAltera.Enabled := False;
 panel1.Visible := True;
 dblcNomeAlu.Enabled := False;
 dblcMod1.Enabled := True;
 dblcMod2.Enabled := True;
 dblcMod3.Enabled := True;
 dblcMod4.Enabled := True;
 dblcMod5.Enabled := True;
 dblcMod6.Enabled := True; 
 qryAlu.Edit;
 DBEdit2.SetFocus;
 Tag := 0; 
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadAluno.btnGravaClick(Sender: TObject);
begin
Try
 if DBEdit2.Text = '' then
  begin
   Beep;
   ShowMessage('O Campo "Nome" não pode ficar vazio!!');
   DBEdit2.SetFocus;
   Exit;
  end;
 btnPrimeiro.Enabled := True;
 btnAnterior.Enabled := True;
 btnProximo.Enabled := True;
 btnUltimo.Enabled := True;
 btnLocCod.Enabled := True;
 btnExclui.Enabled := True;
 btnNovoAlu.Enabled := True;
 btnAltera.Enabled := True;
 panel1.Visible := False;
 dblcNomeAlu.Enabled := True;
 dblcMod1.Enabled := False;
 dblcMod2.Enabled := False;
 dblcMod3.Enabled := False;
 dblcMod4.Enabled := False;
 dblcMod5.Enabled := False;
 dblcMod6.Enabled := False;
 qryAlu.Post;
 qryAlu.ApplyUpdates;
 qryNomeAlu.Close;
 qryNomeAlu.Open;
if tag = 1 then
 if MessageBox( Handle,
               'Deseja imprimir a ficha de incrição?',
               'Impressos',
               MB_YESNO +
               MB_ICONQUESTION +
               MB_DEFBUTTON2 ) = IDYES Then
 begin
 frmRelCadAlu := TfrmRelCadAlu.Create(self);
 frmRelCadAlu.QuickRep1.Preview;
 end;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadAluno.btnCancelaClick(Sender: TObject);
begin
Try
 btnPrimeiro.Enabled := True;
 btnAnterior.Enabled := True;
 btnProximo.Enabled := True;
 btnUltimo.Enabled := True;
 btnLocCod.Enabled := True;
 btnExclui.Enabled := True;
 btnNovoAlu.Enabled := True;
 btnAltera.Enabled := True;
 panel1.Visible := False;
 dblcNomeAlu.Enabled := True;
 dblcMod1.Enabled := False;
 dblcMod2.Enabled := False;
 dblcMod3.Enabled := False;
 dblcMod4.Enabled := False;
 dblcMod5.Enabled := False;
 dblcMod6.Enabled := False; 
 qryAlu.Cancel;
 qryAlu.CancelUpdates;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadAluno.btnPrimeiroClick(Sender: TObject);
begin
 qryAlu.First;
 btnProximo.Enabled := True;
 btnUltimo.Enabled := True;
 btnPrimeiro.Enabled := False;
 btnAnterior.Enabled := False;
end;

procedure TfrmCadAluno.btnAnteriorClick(Sender: TObject);
begin
qryAlu.Prior;
btnProximo.Enabled := True;
btnUltimo.Enabled := True;
if qryALu.Bof = True then
 begin
  btnPrimeiro.Enabled := False;
  btnAnterior.Enabled := False;
 end; // Begin
end;

procedure TfrmCadAluno.btnProximoClick(Sender: TObject);
begin
qryAlu.Next;
btnPrimeiro.Enabled := True;
btnAnterior.Enabled := True;
if qryALu.Eof = True then
 begin
   btnProximo.Enabled := False;
   btnUltimo.Enabled := False;
 end; // Begin
end;

procedure TfrmCadAluno.btnUltimoClick(Sender: TObject);
begin
qryAlu.Last;
btnPrimeiro.Enabled := True;
btnAnterior.Enabled := True;
btnProximo.Enabled := False;
btnUltimo.Enabled := False;
end;

procedure TfrmCadAluno.dblcNomeAluClick(Sender: TObject);
begin
if not qryAlu.Locate ('NOME', dblcNomeAlu.Text,
        [loCaseInsensitive, loPartialKey] ) then
   ShowMessage('Erro ao tentar encontrar aluno!')
else
 begin
  btnPrimeiro.Enabled := True;
  btnAnterior.Enabled := True;
  btnProximo.Enabled := True;
  btnUltimo.Enabled := True;
 end; // Begin
end;

procedure TfrmCadAluno.btnLocCodClick(Sender: TObject);
var sCodigo: string;
begin
{Pedir ao usuário o nome ou código}
sCodigo := InputBox ('Pesquisa por Código', {Caption}
                     'Digite o Código',     {Prompt}
                     ''{Valor Inicial} );
if sCodigo = '' then Exit;
if not qryAlu.Locate ('COD_ALU', sCodigo,
        [loCaseInsensitive, loPartialKey] ) then
   ShowMessage('O Código ' + sCodigo + ' Não Existe...!')
else
 begin
  btnPrimeiro.Enabled := True;
  btnAnterior.Enabled := True;
  btnProximo.Enabled := True;
  btnUltimo.Enabled := True;
 end; // Begin
end;

procedure TfrmCadAluno.FormCreate(Sender: TObject);
begin
Try
 qryNomeAlu.Open;
 qryAlu.Open;
 qryMod.Open;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
btnPrimeiro.Enabled := False;
btnAnterior.Enabled := False;
end;

procedure TfrmCadAluno.dblcNomeAluKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcNomeAlu.DropDown;
end;

procedure TfrmCadAluno.dblcMod1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod1.DropDown;
if key = VK_ESCAPE then
 dblcMod1.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod2.DropDown;
if key = VK_ESCAPE then
 dblcMod2.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod3.DropDown;
if key = VK_ESCAPE then
 dblcMod3.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod4.DropDown;
if key = VK_ESCAPE then
 dblcMod4.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod5.DropDown;
if key = VK_ESCAPE then
 dblcMod5.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcMod6.DropDown;
if key = VK_ESCAPE then
 dblcMod6.Field.AsString := '';
end;

procedure TfrmCadAluno.dblcMod1Click(Sender: TObject);
begin
if dblcMod1.Text = '' then Exit;
if  (dblcMod1.Text <> dblcMod2.Text) and (dblcMod1.Text <> dblcMod3.Text) and
  (dblcMod1.Text <> dblcMod4.Text) and (dblcMod1.Text <> dblcMod5.Text) and
 (dblcMod1.Text <> dblcMod6.Text) then
 begin
  dblcMod2.Enabled := True;
  Exit;
 end
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod1.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod2Click(Sender: TObject);
begin
if dblcMod2.Text = '' then Exit;
if  (dblcMod2.Text <> dblcMod1.Text) and (dblcMod2.Text <> dblcMod3.Text) and
  (dblcMod2.Text <> dblcMod4.Text) and (dblcMod2.Text <> dblcMod5.Text) and
 (dblcMod2.Text <> dblcMod6.Text) then
 begin
  dblcMod3.Enabled := True;
  Exit;
 end
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod2.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod3Click(Sender: TObject);
begin
if dblcMod3.Text = '' then Exit;
if  (dblcMod3.Text <> dblcMod1.Text) and (dblcMod3.Text <> dblcMod2.Text) and
  (dblcMod3.Text <> dblcMod4.Text) and (dblcMod3.Text <> dblcMod5.Text) and
 (dblcMod3.Text <> dblcMod6.Text) then
  begin
  dblcMod4.Enabled := True;
  Exit;
 end
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod3.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod4Click(Sender: TObject);
begin
if dblcMod4.Text = '' then Exit;
if  (dblcMod4.Text <> dblcMod1.Text) and (dblcMod4.Text <> dblcMod2.Text) and
  (dblcMod4.Text <> dblcMod3.Text) and (dblcMod4.Text <> dblcMod5.Text) and
 (dblcMod4.Text <> dblcMod6.Text) then
  begin
  dblcMod5.Enabled := True;
  Exit;
 end
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod4.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod5Click(Sender: TObject);
begin
if dblcMod5.Text = '' then Exit;
if  (dblcMod5.Text <> dblcMod1.Text) and (dblcMod5.Text <> dblcMod2.Text) and
  (dblcMod5.Text <> dblcMod3.Text) and (dblcMod5.Text <> dblcMod4.Text) and
 (dblcMod5.Text <> dblcMod6.Text) then
  begin
  dblcMod6.Enabled := True;
  Exit;
 end
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod5.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod6Click(Sender: TObject);
begin
if dblcMod6.Text = '' then Exit;
if  (dblcMod6.Text <> dblcMod1.Text) and (dblcMod6.Text <> dblcMod2.Text) and
  (dblcMod6.Text <> dblcMod3.Text) and (dblcMod6.Text <> dblcMod4.Text) and
 (dblcMod6.Text <> dblcMod5.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod6.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod1Exit(Sender: TObject);
begin
if dblcMod1.Text = '' then Exit;
if  (dblcMod1.Text <> dblcMod2.Text) and (dblcMod1.Text <> dblcMod3.Text) and
  (dblcMod1.Text <> dblcMod4.Text) and (dblcMod1.Text <> dblcMod5.Text) and
 (dblcMod1.Text <> dblcMod6.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod1.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod2Exit(Sender: TObject);
begin
if dblcMod2.Text = '' then Exit;
if  (dblcMod2.Text <> dblcMod1.Text) and (dblcMod2.Text <> dblcMod3.Text) and
  (dblcMod2.Text <> dblcMod4.Text) and (dblcMod2.Text <> dblcMod5.Text) and
 (dblcMod2.Text <> dblcMod6.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod2.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod3Exit(Sender: TObject);
begin
if dblcMod3.Text = '' then Exit;
if  (dblcMod3.Text <> dblcMod1.Text) and (dblcMod3.Text <> dblcMod2.Text) and
  (dblcMod3.Text <> dblcMod4.Text) and (dblcMod3.Text <> dblcMod5.Text) and
 (dblcMod3.Text <> dblcMod6.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod3.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod4Exit(Sender: TObject);
begin
if dblcMod4.Text = '' then Exit;
if  (dblcMod4.Text <> dblcMod1.Text) and (dblcMod4.Text <> dblcMod2.Text) and
  (dblcMod4.Text <> dblcMod3.Text) and (dblcMod4.Text <> dblcMod5.Text) and
 (dblcMod4.Text <> dblcMod6.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod4.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod5Exit(Sender: TObject);
begin
if dblcMod5.Text = '' then Exit;
if  (dblcMod5.Text <> dblcMod1.Text) and (dblcMod5.Text <> dblcMod2.Text) and
  (dblcMod5.Text <> dblcMod3.Text) and (dblcMod5.Text <> dblcMod4.Text) and
 (dblcMod5.Text <> dblcMod6.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod5.SetFocus;
 end;
end;

procedure TfrmCadAluno.dblcMod6Exit(Sender: TObject);
begin
if dblcMod6.Text = '' then Exit;
if  (dblcMod6.Text <> dblcMod1.Text) and (dblcMod6.Text <> dblcMod2.Text) and
  (dblcMod6.Text <> dblcMod3.Text) and (dblcMod6.Text <> dblcMod4.Text) and
 (dblcMod6.Text <> dblcMod5.Text) then Exit
else
 begin
  ShowMessage('Não é possível cadastrar duas vezes a mesma modalidade!!');
  dblcMod6.SetFocus;
 end;
end;

procedure TfrmCadAluno.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryAlu.State in [dsEdit, dsInsert] then
Case MessageBox( Handle,
                'Deseja salvar as alterações?',
                'Cuidado!!',
                MB_YESNOCANCEL+
                MB_ICONQUESTION) of
     IDYES: btnGravaClick(Sender);
     IDNO: btnCancelaClick(Sender);
     IDCANCEL: CanClose := False;
end; // Case
end;

procedure TfrmCadAluno.btnExcluiClick(Sender: TObject);
begin
if MessageBox( Handle,
              'Confirma a exclusão?',
              'Cuidado!!!',
              MB_YESNO +
              MB_ICONQUESTION+
              MB_DEFBUTTON2) = IDYES then
 Begin
  qryAlu.Delete;
  qryAlu.ApplyUpdates;
  qryNomeAlu.Close;
  qryNomeAlu.Open;
 end; // Begin
end;

end.
