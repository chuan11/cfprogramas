unit uInternaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, Grids, DBGrids, SoftDBGrid, DB,
  adLabelEdit;

type
  TfmInternaNota = class(TForm)
    GroupBox1: TGroupBox;
    lbfornecedor: TLabel;
    edCodigo: TadLabelEdit;
    lbDesc: TLabel;
    edQuant: TadLabelEdit;
    adLabelEdit2: TadLabelEdit;
    adLabelEdit3: TadLabelEdit;
    lbIsRef: TLabel;
    lbSerie: TLabel;
    lbNota: TLabel;
    lbPessoa: TLabel;
    fsBitBtn1: TfsBitBtn;
    Label1: TLabel;
    procedure listaItensInternacao(sr_docf, nr_docf, nr_cfg:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function formEndereco(endereco:String):String;
    procedure getDadosNotaAInternar();

    procedure getDadosItem();
    procedure fsBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInternaNota: TfmInternaNota;
  ds:TdataSet;
implementation

{$R *.dfm}
uses funcSQL, funcoes, uMain, uCF;
{ TForm2 }
procedure TfmInternaNota.listaItensInternacao(sr_docf, nr_docf, nr_cfg: String);
var
   cmd:String;
   internado, pendente:integer;
   serie, num, pessoa:String;
begin
   fmMain.getWMSDocEntrada(serie, num, pessoa );
   lbSerie.Caption := serie;
   lbNota.Caption := num;
   lbPessoa.Caption := pessoa;
end;

procedure TfmInternaNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmInternaNota:= nil;
end;

procedure TfmInternaNota.getDadosItem;
var
   ds: TDataSet;
begin
   ds:= uCF.getDadosProd( fmMain.getUoLogada(), edCodigo.Text, '', '101', true);
   if ( ds.IsEmpty = false ) then
   begin
      lbIsRef.Caption := ds.fieldByName('is_ref').asString;
      lbDesc.Caption := ds.fieldByName('Descricao').asString;
   end;
   ds.free;
end;

procedure TfmInternaNota.edCodigoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) then
   getDadosItem();
end;


function TfmInternaNota.formEndereco(endereco: String): String;
var
  i:smallint;
begin
   for i:=1 to length(endereco) do
      while ( pos('-', endereco ) <> 0) do
         delete(endereco, pos('-', endereco ), 1);
   result := endereco;
end;

procedure TfmInternaNota.getDadosNotaAInternar;
var
   cmd :String;
begin
 {
   cmd :=
   ' select crefe.cd_ref as Cod, crefe.ds_ref, doca.qtEntrada as Ent,' +
   ' doca.qtInternada intern from zcfWmsDoca doca (nolock) ' +
   ' inner join crefe (nolock) on crefe.is_ref = doca.is_ref' +
   ' where '+
   ' doca.nr_docf= ' +  nr_docf +
   ' and doca.sr_docf=' + QuotedStr(sr_docf) +
//   ' and doca.nr_cfg= ' + nr_cfg +
   ' order by crefe.ds_ref';

   if (ds <> nil) and ( ds.IsEmpty = false) then
      ds.Free();

   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);
   ds.First;

   internado := 0;
   pendente := 0;
   while (ds.Eof = false) do
   begin






   end;




}

end;

procedure TfmInternaNota.fsBitBtn1Click(Sender: TObject);
begin
   listaItensInternacao('', '', '');
end;

end.
