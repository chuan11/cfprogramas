unit uCadImpNFE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls;

type
  TfmCadImpNFE = class(TForm)
    GroupBox1: TGroupBox;
    tb: TADOTable;
    DataSource1: TDataSource;
    gridImpressoras: TSoftDBGrid;
    procedure carregaDadosImpressoras();
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tbAfterPost(DataSet: TDataSet);
    procedure salvaCadastroImpressoras();
    procedure gridImpressorasDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadImpNFE: TfmCadImpNFE;
  TB_IS_ALTERADA:boolean;
implementation

uses umain, funcoes, funcSQL;

{$R *.dfm}

{ TForm2 }

procedure TfmCadImpNFE.CarregaDadosImpressoras;
var
  cmd:String;
begin
   cmd := 'nm_param varchar(35) not null, valor varchar(50) not null';
   funcsql.getTable(fmMain.conexao, tb, cmd);
   tb.Close();

   cmd :=
   ' insert ' + tb.TableName +
   ' select substring(nm_param, 14, 50 ), valor ' +
   ' from zcf_paramGerais where nm_param like ''comum.impNFe_%'' ';
   funcSQl.execSQL(cmd, fmMain.Conexao);
   tb.Open();

   gridImpressoras.Columns[ tb.FieldByName('nm_param').Index].Title.Caption := 'Impressora';
   gridImpressoras.Columns[ tb.FieldByName('Valor').Index].Title.Caption := 'Nome da Impressora no servidor';
end;

procedure TfmCadImpNFE.FormCreate(Sender: TObject);
begin
   carregaDadosImpressoras();
   TB_IS_ALTERADA := false;
end;

procedure TfmCadImpNFE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmCadImpNFE := nil;
end;

procedure TfmCadImpNFE.salvaCadastroImpressoras;
var
   cmd: String;
begin
   cmd := 'Delete from zcf_paramGerais where nm_param like ''comum.impNFe_%'' ';
   funcSQL.execSQL(cmd, fmMain.Conexao);

   tb.First();
   while (tb.Eof = false ) do
   begin
      cmd :=
      ' insert zcf_paramGerais (nm_param, valor) ' +
      ' values ('+
      quotedStr('comum.impNFe_' + tb.fieldByName('nm_param').AsString) +', '+
      quotedStr(tb.fieldByName('valor').AsString) + ')';
      funcSQL.execSQL(cmd, fmMain.Conexao);
      tb.Next();
   end;
end;

procedure TfmCadImpNFE.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if (TB_IS_ALTERADA = true) then
     if (funcoes.msgTela('', 'Salva as alterações ?', MB_YESNO + MB_ICONQUESTION) = mrYes ) then
       salvaCadastroImpressoras();
end;

procedure TfmCadImpNFE.tbAfterPost(DataSet: TDataSet);
begin
   TB_IS_ALTERADA := true;
end;


procedure TfmCadImpNFE.gridImpressorasDblClick(Sender: TObject);
begin
   if (funcoes.msgTela('','Remove essa impressora da lista ?', MB_YESNO + MB_ICONQUESTION) = mrYes) then
      tb.delete();
end;

end.
