unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Query: TADOQuery;
    DataSource1: TDataSource;
    Querydt_movi: TDateTimeField;
    Queryqt_mov: TBCDField;
    Queryds_uo: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConsultaDetalhesEntrada(sender:Tobject;Is_ref,cod,nome:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses unit1;

{$R *.dfm}
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form1.SalvaColDbgrid('form2',softdbgrid1);
   form1.Bt_Entradas.Enabled := true;
   action := CaFree;
end;

procedure TForm2.ConsultaDetalhesEntrada(sender: Tobject; Is_ref,cod,nome: string);
begin
   label2.Caption := cod + '   ' + nome;
   query.SQL.Clear;
   query.SQL.Add('Exec dbo.Z_CF_stoListaQtEntradaPorItem '+ is_ref );
   query.open;
   form1.LerColunasDbgrid('form2',softdbgrid1);
end;


end.
