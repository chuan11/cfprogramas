unit uConReqProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, ComCtrls,
  adLabelDBDateTimePicker, DB, ADODB, Grids, DBGrids, SoftDBGrid,funcsql,funcoes,
  fCtrls, ExtCtrls, adLabelEdit;

type
  TfmConReqProduto = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Query: TADOQuery;
    edCodigo: TadLabelEdit;
    cbLojas: TadLabelComboBox;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    btConsultar: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure ConsultaPedidos(Sender:Tobject; is_ref:String);
    procedure btConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure preparaParaConsultar(Sender:Tobject; Str:String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConReqProduto: TfmConReqProduto;
  is_ref:String;
implementation
uses uMain;

{$R *.dfm}

procedure TfmConReqProduto.ConsultaPedidos(Sender: Tobject; is_ref:String);
var
  cmd:String;
  i:integer;
begin
   cmd :=  ' Select  dspd.dt_planod as [Data], '
          +' dspdi.is_planod as [Requisição], '
          +' zcf_tbuo.ds_uo as Loja, '
          +' dspdi.qt_ped as [Pedido], '
          +' dspdi.qt_Pend as [Pendente] , '
          +' dspdi.QtdEmSeparacao as [Em Separação], '
          +' dspdi.QtdSeparada as [Separada], '
          +' dspdi.qtdTransferida as [Transferida], '
          +' dspdi.qtdCancelada  as [Cancelada] '
          +' from dspdi with(NoLock) '
          +' inner join dspd  with(NoLock) on dspd.is_planod = dspdi.is_planod '
          +' inner join zcf_tbuo  with(NoLock) on dspdi.is_estoque = zcf_tbuo.is_uo '
          +' where '
          +' dspdi.dt_movpd between ' + funcoes.DateTimeToSqlDateTime(dti.DateTime,' 00:00:00')
          +' and ' + funcoes.DateTimeToSqlDateTime(dtf.DateTime, ' 23:59:59')
          +' and dspd.is_estoque = 10033674' ; 

          if cbLojas.ItemIndex > 0 then
             cmd := cmd +' and dspdi.is_estoque = ' + trim(copy(cbLojas.Items[cbLojas.ItemIndex],40,50));

          cmd := cmd +' and dspdi.is_ref = ' + is_ref + ' order by dspd.dt_planod ';

   Query.SQL.Clear;
   Query.SQL.add(cmd);
   query.open;

   for i := 0 to grid.columns.count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];

   grid.Columns[0].Width := 65;
   grid.Columns[01].Width := 70;
   grid.Columns[02].Width := 137;
   grid.Columns[03].Width := 55;
   grid.Columns[04].Width := 65;
   grid.Columns[05].Width := 85;
   grid.Columns[06].Width := 70;
   grid.Columns[07].Width := 70;
   grid.Columns[08].Width := 78;
end;

procedure TfmConReqProduto.btConsultarClick(Sender: TObject);
var
   str,erro:String;
begin
   str:= '';
   str:= funcsql.openSQL('Select is_ref from dscbr where cd_pesq = ' + quotedstr(edCodigo.text) + ' or is_ref = ' + edCodigo.text, 'is_ref', fmMain.Conexao);

   if str = '' then
     erro := ' -Produto não cadastrado.';

   if dti.Date > dtf.Date then
     erro := ' -Intervalo de data inválido';

   if erro <> '' then
      msgTEla('','Corrija antes esses erros: ' + erro , MB_ICONERROR + mb_ok)
   else
      ConsultaPedidos(Sender, str);
end;

procedure TfmConReqProduto.FormCreate(Sender: TObject);
begin
//   cbLojas.Items := funcSql.GetNomeLojas(fmMain.Conexao,true,false,'','');

   fmMain.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado() );

   preparaParaConsultar(nil, '');
end;

procedure TfmConReqProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmConReqProduto:= nil;   
   action := CaFree;
end;

procedure TfmConReqProduto.preparaParaConsultar(Sender: Tobject; Str: String);
var
   aux:String;
begin
   if cbLojas.Items.Count - 1 > 0 then
      cbLojas.ItemIndex := 0 ;
      
   aux := dateToStr(now);
   delete(aux,01,02);
   insert('01',aux,01);
   dti.Date :=  strTodate(aux);
   dtf.Date := now;
   edCodigo.Text := str;
   if str <> '' then
      btConsultarClick(nil);
end;

end.
