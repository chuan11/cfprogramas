unit uCadastrarNCM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, TFlatButtonUnit, funcoes, funcSQL,
  StdCtrls, Buttons, fCtrls;

type
  TfmCadastraNCM = class(TForm)
    gRidResult: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    FlatButton1: TFlatButton;
    fsBitBtn1: TfsBitBtn;
    procedure FlatButton1Click(Sender: TObject);
    procedure carregaItensNota(isNota:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure gRidResultKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadastraNCM: TfmCadastraNCM;

implementation

USES uCF, uMain;

{$R *.dfm}

procedure TfmCadastraNCM.carregaItensNota(isNota:String);
begin
   if (tb.TableName <> '') then
      tb.Close();

   funcSQL.getTable(fmMain.Conexao, tb, ' is_ref int, Codigo varchar(08), Descricao varchar(50), NCM_SH varchar(08)' );
   uCF.getItensParaCadastroNCM(tb, isNota);

   tb.FieldByName('is_ref').Visible := false;
   tb.FieldByName('codigo').ReadOnly := true;
   tb.FieldByName('descricao').ReadOnly := true;
   gRidResult.Columns[ tb.FieldByName('descricao').Index ].Width := 100;
   tb.First();
end;

procedure TfmCadastraNCM.FlatButton1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := fmMain.getIsNota();
   if (cmd <> '' )then
      carregaItensNota(cmd);
end;

procedure TfmCadastraNCM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmCadastraNCM := nil;
end;

procedure TfmCadastraNCM.fsBitBtn1Click(Sender: TObject);
begin
   tb.First();
   while ( tb.Eof = false ) do
   begin
      if ( Length(tb.FieldByName('NCM_SH').AsString) = 8  ) then
         uCF.ajustaCodigoNCM( tb.FieldByName('is_ref').AsString, tb.FieldByName('NCM_SH').AsString)
      else
         msgTela('', 'O NCM deve ter exatamente 08 caracteres. ', 0 );
      tb.Next;
   end
end;

procedure TfmCadastraNCM.gRidResultKeyPress(Sender: TObject; var Key: Char);
begin
   if key in ['0'..'9'] = false  then
     key := #0;
end;

end.
