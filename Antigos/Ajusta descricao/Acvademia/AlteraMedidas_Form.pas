unit AlteraMedidas_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Buttons, DBCtrls, Mask;

type
  TfrmAlteraMedidas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    dblcNomeAlu: TDBLookupComboBox;
    btnGrava: TBitBtn;
    btnCancela: TBitBtn;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    qryMedidas: TQuery;
    dsMedidas: TDataSource;
    upsMedidas: TUpdateSQL;
    qryNome: TQuery;
    dsNome: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit8KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit9KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit10KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlteraMedidas: TfrmAlteraMedidas;

implementation

uses CadMedidas_Form;

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

procedure TfrmAlteraMedidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryMedidas.CommitUpdates;
Action := caFree;
frmAlteraMedidas := Nil;
end;

procedure TfrmAlteraMedidas.FormCreate(Sender: TObject);
begin
Try
qryNome.Open;
qryMedidas.Open;
qryMedidas.Edit;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMedidas.btnCancelaClick(Sender: TObject);
begin
Try
qryMedidas.Cancel;
qryMedidas.CancelUpdates;
Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMedidas.btnGravaClick(Sender: TObject);
begin
Try
qryMedidas.Post;
qryMedidas.ApplyUpdates;
frmCadMedidas.qryMedida.Close;
frmCadMedidas.qryMedida.Open;
Close;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmAlteraMedidas.DBEdit4Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit4.Text = '')or(DBEdit4.Text = ',') then exit;

iPos := Pos('KG',DBEdit4.Text);
if iPos>0 then Exit;

 DBEdit4.Text := DBEdit4.Text + ' KG';
end;

procedure TfrmAlteraMedidas.DBEdit5Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit5.Text = '')or(DBEdit5.Text = ',') then exit;

iPos := Pos('cm',DBEdit5.Text);
if iPos>0 then Exit;

 DBEdit5.Text := DBEdit5.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit6Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit6.Text = '')or(DBEdit6.Text = ',') then exit;

iPos := Pos('cm',DBEdit6.Text);
if iPos>0 then Exit;

 DBEdit6.Text := DBEdit6.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit7Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit7.Text = '')or(DBEdit7.Text = ',') then exit;

iPos := Pos('cm',DBEdit7.Text);
if iPos>0 then Exit;

 DBEdit7.Text := DBEdit7.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit8Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit8.Text = '')or(DBEdit8.Text = ',') then exit;

iPos := Pos('cm',DBEdit8.Text);
if iPos>0 then Exit;

 DBEdit8.Text := DBEdit8.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit9Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit9.Text = '')or(DBEdit9.Text = ',') then exit;

iPos := Pos('cm',DBEdit9.Text);
if iPos>0 then Exit;

 DBEdit9.Text := DBEdit9.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit10Exit(Sender: TObject);
var iPos: Integer;
begin
if (DBEdit10.Text = '')or(DBEdit10.Text = ',') then exit;

iPos := Pos('cm',DBEdit10.Text);
if iPos>0 then Exit;

 DBEdit10.Text := DBEdit10.Text + ' cm';
end;

procedure TfrmAlteraMedidas.DBEdit4KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit4.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;
end;

procedure TfrmAlteraMedidas.DBEdit5KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit5.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.DBEdit6KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit6.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.DBEdit7KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit7.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.DBEdit8KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit8.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.DBEdit9KeyPress(Sender: TObject; var Key: Char);
var iPos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit9.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.DBEdit10KeyPress(Sender: TObject; var Key: Char);
var ipos: Integer;
begin
iPos := Pos(DecimalSeparator,DBEdit10.Text);

if (Key=DecimalSeparator) and (iPos>0) then
 Key:=#0;

if not(key in['0'..'9',DecimalSeparator,#8])then
 begin
  beep;
  Key := #0;
 end;

end;

procedure TfrmAlteraMedidas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryMedidas.State in [dsEdit] then
case MessageBox( Handle,
             'Deseja salvar as alterações feitas?',
             'Atenção!!!',
             MB_YESNOCANCEL +
             MB_ICONQUESTION +
             MB_DEFBUTTON3) of
IDYES: btnGravaClick(Sender);
IDNO: btnCancelaClick(Sender);
IDCANCEL: Canclose := False;

end;// Case
end;

end.
