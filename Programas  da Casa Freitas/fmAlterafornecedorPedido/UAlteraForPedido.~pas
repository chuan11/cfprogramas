unit UAlteraForPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, TFlatButtonUnit, DB, ADODB, Grids,
  DBGrids, SoftDBGrid, adLabelComboBox;

type
  TfmAlteraPedForn = class(TForm)
    Query1: TADOQuery;
    FlatButton1: TFlatButton;
    Edit1: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    DataSource1: TDataSource;
    Query1ds_uo: TStringField;
    Query1nm_pes: TStringField;
    Query1vl_total: TBCDField;
    cb2: TadLabelComboBox;
    FlatButton2: TFlatButton;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  fmAlteraPedForn: TfmAlteraPedForn;

implementation

uses uMain, funcsql, funcoes, uCF;

{$R *.dfm}

procedure TfmAlteraPedForn.FlatButton1Click(Sender: TObject);
var
  Str:string;
begin
  str:= ' select zcf_tbuo.ds_uo, dspes.nm_pes, dspdf.vl_total from dspdf inner join zcf_tbuo  on dspdf.is_uoCompra = zcf_tbuo.is_uo ' +
        ' inner join dspes on dspdf.cd_pes = dspes.cd_pes where dspdf.is_pedf = ' + Edit1.text ;
  query1.SQL.Clear;
  query1.SQL.add(str);
  query1.Open;
  FormShow(Sender);
  if  query1.IsEmpty = false  then
  begin
     dbgrid.Columns[0].Width := 150;
     dbgrid.Columns[1].Width := 250;
     dbgrid.Columns[2].Width := 80;

     uCF.getListaLojas(cb2, false, false, fmMain.getCdPesLogado() );

     cb2.Enabled := true;
     dbgrid.Enabled := true;
     cb2.Setfocus;
  end
  else
    msgTela('', 'Pedido não cadastrado.',mb_iconerror+mb_ok);
end;

procedure TfmAlteraPedForn.FormShow(Sender: TObject);
begin
  dbgrid.Enabled := false;
end;

procedure TfmAlteraPedForn.FlatButton2Click(Sender: TObject);
var
   str:string;
begin
    str:= ' Antes de mudar o fornecedor de um pedido de compra você deve se certificar ' +#13+
          ' de que não existe nenhum item recebido nesse pedido.' +#13+
          '   Deseja realmente alterar a loja para '   +#13+#13+'   '+trim(copy( cb2.Items[cb2.itemindex],01,40)) + ' ?';

   if ( msgTela('', str , mb_Iconwarning + mb_YesNo ) = mrYes ) then
   begin
      str := '';
      str := 'exec zcf_alteraLojaPedCompra ' + copy( cb2.Items[cb2.itemindex],51,08) +', '+ edit1.text;

      query1.SQL.Clear;
      query1.SQL.add(str);
      query1.ExecSql;
      FormShow(Sender);
      FlatButton1Click(Sender);
      edit1.SetFocus;
   end;
end;

procedure TfmAlteraPedForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmAlteraPedForn := nil;
end;

end.
