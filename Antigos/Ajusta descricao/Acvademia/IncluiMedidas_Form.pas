unit IncluiMedidas_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, DBTables, Buttons, ComCtrls;


type
  TfrmIncluiMedidas = class(TForm)
    qryMedidas: TQuery;
    dsMedidas: TDataSource;
    upsMedidas: TUpdateSQL;
    qryMedidasCOD_MED: TIntegerField;
    qryMedidasCOD_ALU: TIntegerField;
    qryMedidasDATA_MED: TDateTimeField;
    qryMedidasPESO: TStringField;
    qryMedidasABDOMEM: TStringField;
    qryMedidasCOXA_D: TStringField;
    qryMedidasCOXA_E: TStringField;
    qryMedidasBICEPS_D: TStringField;
    qryMedidasBICEPS_E: TStringField;
    qryMedidasTORAX: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    dblcNomeAlu: TDBLookupComboBox;
    qryNome: TQuery;
    dsNome: TDataSource;
    btnGrava: TBitBtn;
    btnCancela: TBitBtn;
    GroupBox1: TGroupBox;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit8KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit9KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit10KeyPress(Sender: TObject; var Key: Char);
    procedure dblcNomeAluKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncluiMedidas: TfrmIncluiMedidas;

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


procedure TfrmIncluiMedidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryMedidas.CommitUpdates;
Action := caFree;
frmIncluiMedidas := Nil;
end;

procedure TfrmIncluiMedidas.btnCancelaClick(Sender: TObject);
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

procedure TfrmIncluiMedidas.btnGravaClick(Sender: TObject);
begin
Try
if dblcNomeAlu.Text = '' then
 begin
  Beep;
  ShowMessage('Não é possível cadastrar as medidas sem'+#13+
              '       um aluno correspondente!!');
  dblcNomeAlu.SetFocus;            
  Exit;
 end;
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

procedure TfrmIncluiMedidas.DBEdit4Exit(Sender: TObject);
begin
if (DBEdit4.Text = '')or(DBEdit4.Text = ',') then Exit;
 DBEdit4.Text := DBEdit4.Text + ' KG';
end;

procedure TfrmIncluiMedidas.DBEdit5Exit(Sender: TObject);
begin
if (DBEdit5.Text = '')or(DBEdit5.Text = ',') then Exit;
DBEdit5.Text := DBEdit5.Text + ' cm';
end;

procedure TfrmIncluiMedidas.DBEdit6Exit(Sender: TObject);
begin
if (DBEdit6.Text = '')or(DBEdit6.Text = ',') then Exit;
DBEdit6.Text := DBEdit6.Text + ' cm';
end;

procedure TfrmIncluiMedidas.DBEdit7Exit(Sender: TObject);
begin
if (DBEdit7.Text = '')or(DBEdit7.Text = ',') then Exit;
DBEdit7.Text := DBEdit7.Text + ' cm';
end;

procedure TfrmIncluiMedidas.DBEdit8Exit(Sender: TObject);
begin
if (DBEdit8.Text = '')or(DBEdit8.Text = ',') then Exit;
DBEdit8.Text := DBEdit8.Text + ' cm';
end;

procedure TfrmIncluiMedidas.DBEdit9Exit(Sender: TObject);
begin
if (DBEdit9.Text = '')or(DBEdit9.Text = ',') then Exit;
DBEdit9.Text := DBEdit9.Text + ' cm';
end;

procedure TfrmIncluiMedidas.DBEdit10Exit(Sender: TObject);
begin
if (DBEdit10.Text = '')or(DBEdit10.Text = ',') then Exit;
DBEdit10.Text := DBEdit10.Text + ' cm';
end;

procedure TfrmIncluiMedidas.FormCreate(Sender: TObject);
var iCod: Integer;
begin
Try
qryNome.Open;
qryMedidas.Open;
qryMedidas.Last;
iCod := qryMedidasCOD_MED.Value + 1;
qryMedidas.Append;
qryMedidasCOD_MED.Value := iCod;
qryMedidasDATA_MED.Value := Trunc(Date);
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmIncluiMedidas.DBEdit4KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit5KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit6KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit7KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit8KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit9KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.DBEdit10KeyPress(Sender: TObject; var Key: Char);
var iPos:Integer;
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

procedure TfrmIncluiMedidas.dblcNomeAluKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = VK_SPACE then
 dblcNomeAlu.DropDown;
end;

procedure TfrmIncluiMedidas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if qryMedidas.State in [dsInsert] then
case MessageBox( Handle,
             'Deseja salvar as alterações feitas?',
             'Atenção!!!',
             MB_YESNOCANCEL +
             MB_ICONQUESTION +
             MB_DEFBUTTON3) of
IDYES: btnGravaClick(Sender);
IDNO: btnCancelaClick(Sender);
IDCANCEL: Canclose := False;
end; //Case
end;

end.
