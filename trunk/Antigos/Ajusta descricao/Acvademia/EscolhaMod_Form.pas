unit EscolhaMod_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, DBCtrls, StdCtrls, Buttons;

type
  TfrmEscolha = class(TForm)
    dblcEscolheMod: TDBLookupComboBox;
    qryEscolha: TQuery;
    dsEscolha: TDataSource;
    btnOK: TBitBtn;
    btnCancela: TBitBtn;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure dblcEscolheModKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEscolha: TfrmEscolha;

implementation

uses IncluiAlteraModalidade_Form, AlteraModalidade_Form;

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


procedure TfrmEscolha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmEscolha := Nil;
end;

procedure TfrmEscolha.FormCreate(Sender: TObject);
begin
Try
qryEscolha.Open;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmEscolha.btnCancelaClick(Sender: TObject);
begin
Close;
end;

procedure TfrmEscolha.btnOKClick(Sender: TObject);
begin
try
 if dblcEscolheMod.Text = '' then exit;
 if frmAlteraMod = Nil then
  begin
   frmAlteraMod := TfrmAlteraMod.Create(self);
   frmAlteraMod.ShowModal;
   Close;
  end; // Begin
except
 ShowMessage('Erro ao tentar exibir a tela para alterar a Modalidade!!');
end; // TRY
end;

procedure TfrmEscolha.dblcEscolheModKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcEscolheMod.DropDown;
end;

end.
