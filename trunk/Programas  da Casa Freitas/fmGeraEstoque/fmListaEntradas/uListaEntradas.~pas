unit uListaEntradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls, funcsql,
  ExtCtrls;

type
  TfmListaEntradas = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Label2: TLabel;
    DataSource1: TDataSource;
    qrEnt: TADOQuery;
    Panel1: TPanel;
    lbDescicao: TLabel;
    lbQtNotas: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listaNotasEntrada(is_ref, cod, nome:string);
    procedure SoftDBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaEntradas: TfmListaEntradas;

implementation

uses uGeraEstoque, uMain;


{$R *.dfm}
procedure TfmListaEntradas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmGeraEstoque.Bt_Entradas.Enabled := true;
   fmListaEntradas := nil;
end;

procedure TfmListaEntradas.listaNotasEntrada(is_ref, cod, nome: string);
begin
   lbDescicao.Caption := cod + '   ' + nome;
   qrEnt.SQL.Clear;
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
      lbQtNotas.caption := 'Total: ' + funcSql.somaColQuery(qrEnt, 'quant', 0);
      qrEnt.First();
   end;
end;


procedure TfmListaEntradas.SoftDBGrid1TitleClick(Column: TColumn);
begin
   if (qrEnt.IsEmpty = false) then
     funcsql.OrganizarQuery(qrEnt, Column);
end;

end.
