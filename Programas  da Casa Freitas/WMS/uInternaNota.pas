unit uInternaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, Grids, DBGrids, SoftDBGrid, DB;

type
  TfmInternaNota = class(TForm)
    GroupBox1: TGroupBox;
    fsBitBtn1: TfsBitBtn;
    lbSerie: TLabel;
    lbBarra: TLabel;
    Label1: TLabel;
    lbfornecedor: TLabel;
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    procedure listaItensInternacao(sr_docf, nr_docf, nr_cfg:String);
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
uses funcSQL, funcoes, uMain;

{ TForm2 }

procedure TfmInternaNota.listaItensInternacao(sr_docf, nr_docf, nr_cfg: String);
var
   cmd:String;
begin
   cmd :=
   ' select crefe.cd_ref as Cod, crefe.ds_ref, doca.qtEntrada as Ent,' +
   ' doca.qtInternada intern from zcfWmsDoca doca (nolock) ' +
   ' inner join crefe (nolock) on crefe.is_ref = doca.is_ref' +
   ' where '+
   ' doca.nr_docf= ' +  nr_docf +
   ' and doca.sr_docf=' + QuotedStr(sr_docf) +
   ' and doca.nr_cfg= ' + nr_cfg +
   ' order by crefe.ds_ref';

   if ( ds.IsEmpty = false) then
      ds.Free();

   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);
   DataSource1.DataSet := ds;
end;

procedure TfmInternaNota.fsBitBtn1Click(Sender: TObject);
begin
  listaItensInternacao('0', '20950', '89738173000549');
end;

end.
