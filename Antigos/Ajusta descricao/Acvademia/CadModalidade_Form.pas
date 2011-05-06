unit CadModalidade_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmCadMod = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    qryMod: TQuery;
    dsMod: TDataSource;
    btnNova: TBitBtn;
    btnAltera: TBitBtn;
    qryModModalidade: TStringField;
    qryModMensalidade: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovaClick(Sender: TObject);
    procedure btnAlteraClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMod: TfrmCadMod;

implementation

uses IncluiAlteraModalidade_Form, EscolhaMod_Form;

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


procedure TfrmCadMod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmCadMod := Nil;
end;

procedure TfrmCadMod.btnNovaClick(Sender: TObject);
begin
try
 if frmIncluiMod = Nil then
  begin
   frmIncluiMod := TfrmIncluiMod.Create(self);
   frmIncluiMod.ShowModal;
  end;
except
 ShowMessage('Erro ao tentar exibir a tela para cadastrar nova modalidade!!');
end; // TRY
end;

procedure TfrmCadMod.btnAlteraClick(Sender: TObject);
begin
try
 if frmEscolha = Nil then
  begin
   frmEscolha := TfrmEscolha.Create(self);
   frmEscolha.ShowModal;
  end; // Begin
except
 ShowMessage('Erro ao tentar exibir a tela para escolha da modalidade a ser alterada');
end; // TRY
end;

procedure TfrmCadMod.FormCreate(Sender: TObject);
begin
Try
qryMod.Open;
Except
 On E:Exception Do Begin
  ShowError(E);
 end; // Begin
end; // TRY
end;

end.
