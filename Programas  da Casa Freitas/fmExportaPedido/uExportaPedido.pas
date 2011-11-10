unit uExportaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, DB;

type
  TfmExportaPedido = class(TForm)
    cbPreco02: TadLabelComboBox;
    cbPreco01: TadLabelComboBox;
    edCodigo: TadLabelEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExportaPedido: TfmExportaPedido;

implementation
uses uMain, funcSQL, cf, funcoes;

{$R *.dfm}

procedure TfmExportaPedido.FormCreate(Sender: TObject);
begin
   cbPreco01.Items := cf.getListaPrecos(true, false, true, fmMain.getGrupoLogado());
   cbPreco02.Items := cbPreco01.Items;
end;

procedure TfmExportaPedido.Button1Click(Sender: TObject);
var
   cmd:String;
   ds:TdataSet;
   params:TStringlist;
begin
   cmd :=
   ' select i.seqitemPedido,' +
   ' p.cd_ref, p.ds_ref,'+
   ' dbo.Z_CF_FunObterPrecoProduto_CF( '+ funcoes.getCodUO(cbPreco01) + ', is_ref, i.codLoja, 0 ) as [Preco 01],'+#13+
   ' dbo.Z_CF_FunObterPrecoProduto_CF( '+ funcoes.getCodUO(cbPreco02) + ', is_ref, i.codLoja, 0 ) as [Preco 02]'+#13+
   ' from itensPedidoCliente i (nolock) inner join crefe p (nolock) on p.is_ref = i.seqProduto where ' +
   ' numPedido = ' + edCodigo.Text;
   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   if (ds.IsEmpty = false) then
   begin
      params := TStringList.Create();
      params.Add('exportacao do pedido:' + edCodigo.text );
      fmMain.exportaDataSet(ds, params);
      ds.free;
   end;
end;

end.
