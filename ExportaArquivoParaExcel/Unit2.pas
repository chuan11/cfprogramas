unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls, funcsql;

type
  TForm2 = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConsultaDetalhesEntrada(sender:Tobject;Is_ref,cod,nome:string);
    procedure SoftDBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   form1.Bt_Entradas.Enabled := true;
end;

procedure TForm2.ConsultaDetalhesEntrada(sender: Tobject; Is_ref,cod,nome: string);
begin
   label2.Caption := cod + '   ' + nome;
   form1.qrEnt.SQL.Clear;
   form1.qrEnt.SQL.Add('Exec dbo.Z_CF_stoListaQtEntradaPorItem '+ is_ref );
   form1.qrEnt.open;
   if SoftDBGrid1.Columns.Count -1 > 2 then
   begin
      SoftDBGrid1.Columns[0].Width := 50;
      SoftDBGrid1.Columns[1].Width := 50;
      SoftDBGrid1.Columns[2].Width := 80;
      SoftDBGrid1.Columns[3].Width := 80;
      SoftDBGrid1.Columns[4].Width := 150;
      SoftDBGrid1.Columns[5].Visible := false;
   end;
   statusBar1.SimpleText := 'Total: ' + funcSql.somaColQuery(form1.qrEnt, 'quant', 0 );
end;


procedure TForm2.SoftDBGrid1TitleClick(Column: TColumn);
begin
   if form1.qrEnt.IsEmpty = false then
     funcsql.OrganizarQuery(form1.qrEnt, Column);
end;

end.
