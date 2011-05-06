unit AlteraPagamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ComCtrls, Buttons;

type
  TfrmAlteraPagamento = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnConfirma: TBitBtn;
    btnCancela: TBitBtn;
    dtpVenc: TDateTimePicker;
    dtpPagto: TDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    btnDesconto: TButton;
    qryPagtos: TQuery;
    qryPagtosCOD_PAG: TIntegerField;
    qryPagtosCOD_ALU: TIntegerField;
    qryPagtosDATA_PAG: TDateTimeField;
    qryPagtosDATA_VENC: TDateTimeField;
    qryPagtosDESCONTO: TFloatField;
    qryPagtosVLR_TOTAL: TFloatField;
    qryPagtosMENSALIDADE: TFloatField;
    dsPagtos: TDataSource;
    upsPagtos: TUpdateSQL;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnDescontoClick(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlteraPagamento: TfrmAlteraPagamento;

implementation

uses Pagamento_Form;

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

procedure TfrmAlteraPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryPagtos.CommitUpdates;
Action := caFree;
frmAlteraPagamento := Nil;
end;

procedure TfrmAlteraPagamento.FormCreate(Sender: TObject);
begin
Try
qryPagtos.Open;
dtpPagto.Date := qryPagtosDATA_PAG.Value;
dtpVenc.Date := qryPagtosDATA_VENC.Value;
qryPagtos.Edit;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraPagamento.btnConfirmaClick(Sender: TObject);
begin
Try
qryPagtosDATA_PAG.Value := dtpPagto.Date;
qryPagtosDATA_VENC.Value := dtpVenc.Date;
qryPagtos.Post;
qryPagtos.ApplyUpdates;
frmPagamento.qryPagtos.Close;
frmPagamento.qryPagtos.Open;
Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraPagamento.btnCancelaClick(Sender: TObject);
begin
Try
qryPagtos.Cancel;
qryPagtos.ApplyUpdates;
Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraPagamento.btnDescontoClick(Sender: TObject);
begin
DBEdit2.Enabled := True;
DBEdit2.SetFocus;
end;

procedure TfrmAlteraPagamento.DBEdit2Exit(Sender: TObject);
var dMensalidade, dDesconto:Double;
begin
if DBEdit2.Text='' then
  DBEdit2.Text := '0';
dDesconto := qryPagtosDESCONTO.Value;
dMensalidade := qryPagtosMENSALIDADE.Value;
if dMensalidade >= DDesconto then
 begin
  dMensalidade := dMensalidade - DDesconto;
  qryPagtosVLR_TOTAL.Value := dMensalidade;
 end
else
 begin
 ShowMessage('Desconto inválido!!');
 DBEdit2.SetFocus;
 Exit;
 end;
DBEdit2.Enabled := False;
end;

procedure TfrmAlteraPagamento.DBEdit2KeyPress(Sender: TObject;
  var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit2.Text);
if Key = DecimalSeparator then
 if iPos > 0 then
  Key := #0;
end;

procedure TfrmAlteraPagamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryPagtos.State in [dsEdit] then
if MessageBox( Handle,
              'Deseja cancelar as !!',
              'Atenção',
              MB_YESNO +
              MB_ICONQUESTION+
              MB_DEFBUTTON2) = IDYES then
    begin
     btnCancelaClick(Sender);
     CanClose := True;
    end
  else
   Canclose := False;
end;

end.
