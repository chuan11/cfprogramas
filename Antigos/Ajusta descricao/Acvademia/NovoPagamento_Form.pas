unit NovoPagamento_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, dbtables, db, Mask, DBCtrls, ComCtrls;

type
  TfrmNovoPagamento = class(TForm)
    btnConfirma: TBitBtn;
    btnCancela: TBitBtn;
    qryPagtos: TQuery;
    dsPagtos: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    dtpVenc: TDateTimePicker;
    qryVenc: TQuery;
    dsVenc: TDataSource;
    qryVencDATA_VENC: TDateTimeField;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    upsPagtos: TUpdateSQL;
    qryCodigo: TQuery;
    qryCodigoCOLUMN1: TIntegerField;
    qryVencCOD_ALU: TIntegerField;
    qryPagtosCOD_PAG: TIntegerField;
    qryPagtosDATA_PAG: TDateTimeField;
    qryPagtosCOD_ALU: TIntegerField;
    qryPagtosDATA_VENC: TDateTimeField;
    qryPagtosVLR_TOTAL: TFloatField;
    qryPagtosDESCONTO: TFloatField;
    qryVencVLR_DEVIDO: TFloatField;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    btnDesconto: TButton;
    qryPagtosMENSALIDADE: TFloatField;
    dtpPagto: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBEdit2Exit(Sender: TObject);
    procedure btnDescontoClick(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNovoPagamento: TfrmNovoPagamento;
  VlrPagto: Double;

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

procedure TfrmNovoPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryPagtos.CommitUpdates;
Action := caFree;
frmNovoPagamento := Nil;
end;

procedure TfrmNovoPagamento.FormCreate(Sender: TObject);
begin
Try
// Abre as TQuery
qryPagtos.Open;
qryCodigo.Open;
// Passa data atual
dtpPagto.Date := (Now);
// passa a data de Vencimento
   qryVenc.SQL.Clear;
   qryVenc.sql.Add(' SELECT COD_ALU, DATA_VENC,  VLR_DEVIDO FROM ALUNO WHERE COD_ALU =' + Pagamento_Form.frmPagamento.DBEdit1.Text);
   qryVenc.Open;
   dtpVenc.Date := qryVencDATA_VENC.AsDateTime;
//  dtpVenc.Date := now();
// Coloca em modo de inserção
qryPagtos.Append;
qryPagtosCOD_PAG.Value := qryCodigoCOLUMN1.Value;
qryPagtosCOD_ALU.Value := qryVencCOD_ALU.Value;
// Passa o valor da mensalidade para o campo total pago
qryPagtosVLR_TOTAL.Value := qryVencVLR_DEVIDO.Value;
// Passa o valor da mensalidade para o campo Mensalidade
qryPagtosMensalidade.Value := qryVencVLR_DEVIDO.Value;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmNovoPagamento.btnConfirmaClick(Sender: TObject);
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

procedure TfrmNovoPagamento.btnCancelaClick(Sender: TObject);
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

procedure TfrmNovoPagamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryPagtos.State in [dsInsert] then
 if MessageBox( Handle,
              'Deseja cancelar o pagamento da mensalidade!!',
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

procedure TfrmNovoPagamento.DBEdit2Exit(Sender: TObject);
var dDesconto,dMensalidade : Double;
begin
if DBEdit2.Text='' then
  DBEdit2.Text := '0';
dDesconto := qryPagtosDESCONTO.Value;
//dDesconto := StrToFloat(DBEdit2.Text);
dMensalidade := qryVencVLR_DEVIDO.Value;
//DValor := StrToFloat(DBEdit3.Text);
if dMensalidade >= DDesconto then
 begin
  dMensalidade := dMensalidade - DDesconto;
  qryPagtosVLR_TOTAL.Value := dMensalidade;
//  DBEdit1.Text := FloatToStr(DValor);
 end
else
 begin
 ShowMessage('Desconto inválido!!');
 DBEdit2.SetFocus;
 Exit;
 end;
DBEdit2.Enabled := False;
end;

procedure TfrmNovoPagamento.btnDescontoClick(Sender: TObject);
begin
DBEdit2.Enabled := True;
DBEdit2.SetFocus;
end;

procedure TfrmNovoPagamento.DBEdit2KeyPress(Sender: TObject;
  var Key: Char);
var iPos: Integer;
begin
ipos := Pos(DecimalSeparator,DBEdit2.Text);
if key = DecimalSeparator then
 if iPos > 0 then
  key := #0;
end;

end.
