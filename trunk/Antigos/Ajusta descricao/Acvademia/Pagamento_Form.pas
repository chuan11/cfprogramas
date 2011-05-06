unit Pagamento_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ComCtrls,
  ScrollText, Buttons, ImgList, Menus;

type
  TfrmPagamento = class(TForm)
    qryPagtos: TQuery;
    qryPagtosCOD_PAG: TIntegerField;
    qryPagtosDATA_PAG: TDateTimeField;
    qryPagtosDATA_VENC: TDateTimeField;
    qryPagtosVLR_TOTAL: TFloatField;
    qryPagtosDESCONTO: TFloatField;
    dsPagtos: TDataSource;
    qryAlunos: TQuery;
    dsAlunos: TDataSource;
    DBGrid1: TDBGrid;
    qryPagtosNOME: TStringField;
    qryAlunosCOD_ALU: TIntegerField;
    qryAlunosNOME: TStringField;
    qryAlunosENDERECO: TStringField;
    qryAlunosBAIRRO: TStringField;
    qryAlunosCIDADE: TStringField;
    qryAlunosESTADO: TStringField;
    qryAlunosTELEFONE: TStringField;
    qryAlunosCEP: TStringField;
    qryAlunosRG: TStringField;
    qryAlunosCPF: TStringField;
    qryAlunosDATA_NASC: TDateTimeField;
    qryAlunosDATA_CAD: TDateTimeField;
    qryAlunosOBS: TMemoField;
    qryAlunosCOD_MOD1: TIntegerField;
    qryAlunosCOD_MOD2: TIntegerField;
    qryAlunosCOD_MOD3: TIntegerField;
    qryAlunosCOD_MOD4: TIntegerField;
    qryAlunosCOD_MOD5: TIntegerField;
    qryAlunosCOD_MOD6: TIntegerField;
    qryAlunosDATA_VENC: TDateTimeField;
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    dblcAluno: TDBLookupComboBox;
    PopupMenu1: TPopupMenu;
    ExcluiPagamento1: TMenuItem;
    imgLista: TImageList;
    qryPagtosMENSALIDADE: TFloatField;
    upsPagtos: TUpdateSQL;
    AlteraPagamento1: TMenuItem;
    GroupBox2: TGroupBox;
    btnNovoPagto: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dblcAlunoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoPagtoClick(Sender: TObject);
    procedure ExcluiPagamento1Click(Sender: TObject);
    procedure AlteraPagamento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagamento: TfrmPagamento;

implementation

uses NovoPagamento_Form, AlteraPagamento;


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


procedure TfrmPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryPagtos.CommitUpdates;
Action:= caFree;
frmPagamento := Nil;
end;

procedure TfrmPagamento.FormCreate(Sender: TObject);
begin
Try
qryAlunos.Open;
qryPagtos.Open;
dblcAluno.KeyValue := qryAlunos.FieldbyName('COD_ALU').AsString;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmPagamento.dblcAlunoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcAluno.DropDown;
end;

procedure TfrmPagamento.btnNovoPagtoClick(Sender: TObject);
begin
Try
 if frmNovoPagamento = Nil then
  Begin
   frmNovoPagamento := TfrmNovoPagamento.Create(self);
   frmNovoPagamento.ShowModal;
  end;
Except
 ShowMessage('Erro ao tentar exibir a tela de novos pagamentos!!');
end; // Try
end;

procedure TfrmPagamento.ExcluiPagamento1Click(Sender: TObject);
begin
if MessageBox( Handle,
              'Confirma a exclusão?',
              'Cuidado!!!',
              MB_YESNO +
              MB_ICONQUESTION+
              MB_DEFBUTTON2) = IDYES then
    Begin
     qryPagtos.Delete;
     qryPagtos.ApplyUpdates;
    end;
end;

procedure TfrmPagamento.AlteraPagamento1Click(Sender: TObject);
begin
Try
 if frmAlteraPagamento = Nil then
  Begin
   frmAlteraPagamento := TfrmAlteraPagamento.Create(self);
   frmAlteraPagamento.ShowModal;
  end;
Except
 ShowMessage('Erro ao tentar exibir a tela de alteração de pagamentos!!');
end; // Try
end;

end.
