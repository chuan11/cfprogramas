unit uPedidosFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Grids, DBGrids, SoftDBGrid, ADODB, funcoes,funcsql,
  StdCtrls;

type
  TfmPedidosFornecedor = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    lbDados: TLabel;
    Label2: TLabel;
    procedure getPedidosProduto(is_ref, uo:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPedidosFornecedor: TfmPedidosFornecedor;

implementation
uses uMain, uCF;
{$R *.dfm}

{ TForm6 }

procedure TfmPedidosFornecedor.getPedidosProduto(is_ref, uo:String);
var
  cmd:String;
  i:integer;
  ds:TDataSet;
begin
   if (lbDados.Caption = '') then
   begin
      ds:= uCF.getDadosProd(uo, '', is_ref, '101', true);
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

   cmd := ' Select  p.is_pedf as Pedido, uo.ds_uo as Loja, p.dt_movpf as DataPedido, p.qt_ped as [Quant Pedida], (p.qt_ped- p.qt_pend) as  [Quant Recebido]' +
         ' , p.qt_pend as [Quant Pendente], p.pr_uni as PrecoUnitario, case when dataCancelamento is not  null then ''Cacelado'' else '''' end as Status, ' +
         ' p.pc_desc1 as [Desc 1], p.pc_desc2 as [Desc 2], p.pc_desc3 as [Desc 3], p.pc_desc4 as [Desc 4], p.pc_desc5 as [Desc 5] ' +
         ' from DSIPE p (nolock) inner join zcf_tbuo uo (nolock) on p.is_estoque = uo.is_uo where is_ref = ' + is_ref +
         ' order by p.is_pedF desc ';

   ds:= funcSQL.getDataSetQ(cmd, fmMain.conexao);
   if (ds.IsEmpty = false)  then
   begin
      DataSource1.DataSet := ds;
      for i:=0 to ds.FieldCount-1 do
         grid.Columns[i].Width := 70;

      grid.Columns[1].Width := 150;
      grid.Columns[2].Width := 100;      
   end;   
end;

procedure TfmPedidosFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmPedidosFornecedor := nil;
end;

end.
