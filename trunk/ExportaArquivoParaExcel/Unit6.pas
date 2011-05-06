unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Grids, DBGrids, SoftDBGrid, ADODB, funcoes,funcsql;

type
  TForm6 = class(TForm)
    qrPedidos: TADOQuery;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    procedure ListaPedidosProduto(Sender:Tobject; desc, is_ref:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
uses unit1;
{$R *.dfm}

{ TForm6 }

procedure TForm6.ListaPedidosProduto(Sender: Tobject; desc, is_ref:String);
var
  cmd:String;
  i:integer;
begin
   cmd := ' Select  p.is_pedf as Pedido, uo.ds_uo as Loja, p.dt_movpf as DataPedido, p.qt_ped as [Quant Pedida], (p.qt_ped- p.qt_pend) as  [Quant Recebido]' +
         ' , p.qt_pend as [Quant Pendente], p.pr_uni as PrecoUnitario, case when dataCancelamento is not  null then ''Cacelado'' else '''' end as Status, ' +
         ' p.pc_desc1 as [Desc 1], p.pc_desc2 as [Desc 2], p.pc_desc3 as [Desc 3], p.pc_desc4 as [Desc 4], p.pc_desc5 as [Desc 5] ' +
         ' from DSIPE p (nolock) inner join zcf_tbuo uo (nolock) on p.is_estoque = uo.is_uo where is_ref = ' + is_ref +
         ' order by p.is_pedF desc ';

   funcsql.getQuery(form1.ADOConnection1, qrPedidos, cmd );
   DataSource1.DataSet := qrPedidos;

   panel1.Caption := desc;


   if qrPedidos.IsEmpty = false then
   begin

      for i:=0 to qrPedidos.FieldCount-1 do
         grid.Columns[i].Width := 70;
      grid.Columns[1].Width := 150;
      grid.Columns[2].Width := 100;      
   end;   
end;

end.
