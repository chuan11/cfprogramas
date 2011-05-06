unit AlteraModalidade_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Buttons, Mask, DBCtrls;

type
  TfrmAlteraMod = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    btnGrava: TBitBtn;
    btnCancela: TBitBtn;
    qryMod: TQuery;
    qryModCOD_MOD: TIntegerField;
    qryModMODALIDADE: TStringField;
    qryModMENSALIDADE: TFloatField;
    dsMod: TDataSource;
    upsMod: TUpdateSQL;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlteraMod: TfrmAlteraMod;

implementation

uses EscolhaMod_Form, CadModalidade_Form;

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


procedure TfrmAlteraMod.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
qryMod.CommitUpdates;
Action := caFree;
frmAlteraMod := Nil;
end;

procedure TfrmAlteraMod.FormCreate(Sender: TObject);
begin
Try
qryMod.Open;
qryMod.Edit;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMod.btnCancelaClick(Sender: TObject);
begin
Try
qryMod.Cancel;
qryMod.CancelUpdates;
Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMod.btnGravaClick(Sender: TObject);
begin
Try
 if DBEdit2.Text = '' then
  begin
   Beep;
   ShowMessage('O Campo "Modalidade" não pode ficar vazio!!');
   DBEdit2.SetFocus;
   Exit;
  end // Begin
 else
  if DBEdit3.Text = '' then
   begin
    Beep;
    ShowMessage('O Campo "Mensalidade" não pode ficar vazio!!');
    DBEdit3.SetFocus;
    Exit;
   end; // Begin
 qryMod.Post;
 qryMod.ApplyUpdates;
 frmCadMod.qryMod.Close;
 frmCadMod.qryMod.Open;
 Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMod.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryMod.State in [dsEdit, dsInsert] then
 begin
  Canclose := False;
  Beep;
  ShowMessage('Não é possível fechar a janela!!'+#13+
              'Clique em Gravar ou Cancelar!!');
 end; // Begin
end;

end.
