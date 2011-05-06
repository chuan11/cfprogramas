unit CadMedidas_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, DBTables, ComCtrls, Menus, DBCtrls, StdCtrls, ImgList,
  Buttons;

type
  TfrmCadMedidas = class(TForm)
    qryMedida: TQuery;
    dsMedida: TDataSource;
    qryMedidaCOD_MED: TIntegerField;
    qryMedidaDATA_MED: TDateTimeField;
    qryMedidaPESO: TStringField;
    qryMedidaABDOMEM: TStringField;
    qryMedidaCOXA_D: TStringField;
    qryMedidaCOXA_E: TStringField;
    qryMedidaBICEPS_D: TStringField;
    qryMedidaBICEPS_E: TStringField;
    qryMedidaTORAX: TStringField;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    NovaMedio1: TMenuItem;
    AlteraMedidas1: TMenuItem;
    ExcluiMedio1: TMenuItem;
    imgLista: TImageList;
    qryMedidaNOME: TStringField;
    GroupBox1: TGroupBox;
    dblcNome: TDBLookupComboBox;
    dtpData1: TDateTimePicker;
    edCod2: TEdit;
    edCod1: TEdit;
    edNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtpData2: TDateTimePicker;
    Label5: TLabel;
    qryNome: TQuery;
    dsNome: TDataSource;
    GroupBox2: TGroupBox;
    btnFiltra: TBitBtn;
    GroupBox3: TGroupBox;
    btnRestaura: TBitBtn;
    GroupBox4: TGroupBox;
    btnNovaMed: TBitBtn;
    btnAlteraMed: TBitBtn;
    btnExcluiMed: TBitBtn;
    upsMedida: TUpdateSQL;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltraClick(Sender: TObject);
    procedure dblcNomeCloseUp(Sender: TObject);
    procedure edCod2Exit(Sender: TObject);
    procedure edCod1Exit(Sender: TObject);
    procedure edCod1KeyPress(Sender: TObject; var Key: Char);
    procedure btnRestauraClick(Sender: TObject);
    procedure btnNovaMedClick(Sender: TObject);
    procedure btnAlteraMedClick(Sender: TObject);
    procedure btnExcluiMedClick(Sender: TObject);
    procedure ExcluiMedio1Click(Sender: TObject);
    procedure NovaMedio1Click(Sender: TObject);
    procedure AlteraMedidas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMedidas: TfrmCadMedidas;

implementation

uses IncluiMedidas_Form, AlteraMedidas_Form;

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


procedure TfrmCadMedidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
qryMedida.CommitUpdates;
Action := caFree;
frmCadMedidas := Nil;
end;

procedure TfrmCadMedidas.FormCreate(Sender: TObject);
begin
Try
qryMedida.Open;
qryNome.Open;
dtpData2.Date := Trunc(Date);
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadMedidas.btnFiltraClick(Sender: TObject);
begin
Try
With qryMedida do
 begin
  Close;
  ParamByName('Cod1').Value := StrToInt(edCod1.Text);
  ParamByName('Cod2').Value := StrToInt(edCod2.Text);
  ParamByName('Data1').Value := dtpData1.Date;
  ParamByName('Data2').Value := dtpData2.Date;
  ParamByName('Nome').Value := '%' + edNome.Text + '%';
  Open;
 end; // Begin do With
btnRestaura.Enabled := True;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadMedidas.btnRestauraClick(Sender: TObject);
begin
Try
With qryMedida do
 begin
  Close;
  ParamByName('Cod1').Value := 1;
  ParamByName('Cod2').Value := 100000;
  ParamByName('Data1').Value := 01/01/2000;
  ParamByName('Data2').Value := Date;
  ParamByName('Nome').Value := '%';
  Open;
 end; // Begin do With
btnRestaura.Enabled := False;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

procedure TfrmCadMedidas.dblcNomeCloseUp(Sender: TObject);
begin
edNome.Text := dblcNome.Text;
end;

procedure TfrmCadMedidas.edCod2Exit(Sender: TObject);
begin
if edCod2.Text = '' then
 edCod2.Text := '9999999';
end;

procedure TfrmCadMedidas.edCod1Exit(Sender: TObject);
begin
if edCod1.Text = '' then
 edCod1.Text := '1';
end;

procedure TfrmCadMedidas.edCod1KeyPress(Sender: TObject; var Key: Char);
begin
if not(Key in['0'..'9',#8]) then
 begin
  beep;
  Key := #0;
 end; // Begin
end;

procedure TfrmCadMedidas.btnNovaMedClick(Sender: TObject);
begin
Try
if frmIncluiMedidas = Nil then
 begin
 frmIncluiMedidas := TfrmIncluiMedidas.Create(self);
 frmIncluiMedidas.ShowModal;
 end;
except
 ShowMessage('Erro ao tentar exibir a tela para inserir novas medidas!!');
end; // TRY
end;

procedure TfrmCadMedidas.btnAlteraMedClick(Sender: TObject);
begin
try
 if frmAlteraMedidas = Nil then
  begin
   frmAlteraMedidas := TfrmAlteraMedidas.Create(self);
   frmAlteraMedidas.ShowModal;
  end;
except
 ShowMessage('Erro ao tentar exibir a tela para alteração de medidas');
end; // TRY
end;

procedure TfrmCadMedidas.btnExcluiMedClick(Sender: TObject);
begin
if MessageBox( Handle,
              'Confirma a exclusão?',
              'Cuidado!!!',
              MB_YESNO +
              MB_ICONQUESTION+
              MB_DEFBUTTON2) = IDYES then
 Begin
  qryMedida.Delete;
  qryMedida.ApplyUpdates;
 end; // Begin
end;

procedure TfrmCadMedidas.NovaMedio1Click(Sender: TObject);
begin
btnNovaMedClick(Sender);
end;

procedure TfrmCadMedidas.AlteraMedidas1Click(Sender: TObject);
begin
btnAlteraMedClick(Sender);
end;

procedure TfrmCadMedidas.ExcluiMedio1Click(Sender: TObject);
begin
btnExcluiMedClick(Sender);
end;

end.
