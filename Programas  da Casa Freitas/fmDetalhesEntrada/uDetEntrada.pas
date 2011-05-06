unit uDetEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcsql,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls;

type
  TfmDetEntrada = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    qrEnt: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConsultaDetalhesEntrada(sender:Tobject;Is_ref:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetEntrada: TfmDetEntrada;

implementation

uses uMain;

{$R *.dfm}
procedure TfmDetEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmDetEntrada := nil;
end;

procedure TfmDetEntrada.ConsultaDetalhesEntrada(sender: Tobject; Is_ref:String);
var
  lst:Tstrings;
begin
   lst := funcsql.GetValoresSQL(lst, ' Select cd_ref, ds_ref from crefe (nolock) where is_ref = ' + is_ref, fmMain.Conexao);
   label2.Caption := lst[0] + '   ' + lst[1];

   qrEnt.SQL.Add('Exec dbo.Z_CF_stoListaQtEntradaPorItem '+ is_ref );
   qrEnt.open;
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
