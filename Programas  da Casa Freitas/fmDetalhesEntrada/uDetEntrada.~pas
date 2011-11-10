unit uDetEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcsql,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls,
  ExtCtrls;

type
  TfmDetEntrada = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure consultaDetalhesEntrada(is_ref:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetEntrada: TfmDetEntrada;

implementation

uses uMain, uCF;

{$R *.dfm}
procedure TfmDetEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmDetEntrada := nil;
end;

procedure TfmDetEntrada.consultaDetalhesEntrada(is_ref:String);
var
  lst:Tstrings;
begin
   lst := funcsql.GetValoresSQL(lst, ' Select cd_ref, ds_ref from crefe (nolock) where is_ref = ' + is_ref, fmMain.Conexao);
   label2.Caption := lst[0] + '   ' + lst[1];

   DataSource1.DataSet := uCF.getEntradasPorItem(is_ref, '');
   if SoftDBGrid1.Columns.Count -1 > 2 then
   begin
      SoftDBGrid1.Columns[0].Width := 50;
      SoftDBGrid1.Columns[1].Width := 50;
      SoftDBGrid1.Columns[2].Width := 80;
      SoftDBGrid1.Columns[3].Width := 80;
      SoftDBGrid1.Columns[4].Width := 150;
      SoftDBGrid1.Columns[5].Visible := false;
   end;
end;


end.
