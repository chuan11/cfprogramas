unit uItensSemMov;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, DB, ADODB, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, adLabelEdit, adLabelNumericEdit,
  adLabelSpinEdit, Grids, DBGrids, SoftDBGrid, ExtCtrls;

type
  TfmItensSemMov = class(TfmRelGeral)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    edCodigo: TadLabelEdit;
    spedit: TadLabelSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure geraDiasSemOperacao();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure pegarDiasSemMovimentoDositens();
    procedure gridTitleClick(Column: TColumn);
    procedure getDadosUltEntradaCompra();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmItensSemMov: TfmItensSemMov;

implementation

uses funcoes, uMain, cf;

{$R *.dfm}

procedure TfmItensSemMov.FormCreate(Sender: TObject);
begin
   GroupBox1.Visible := false;
   cbDetAvaForn.Visible := false;

   cbCaixas.Items.clear();
   cbCaixas.Items.Add('- Transferência/saída');
   cbCaixas.Items.Add('- Venda');
   cbCaixas.itemIndex := 0;
end;

procedure TfmItensSemMov.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmItensSemMov := nil;
end;

procedure TfmItensSemMov.pegarDiasSemMovimentoDosItens;
var
  tp_mov:String;
  qtDias:integer;
begin
   case cbCaixas.ItemIndex of
      0:tp_mov := '2';
      1:tp_mov := '09, 23, 24, 25, 26, 43, 44 , 46';
   end;

   tbOperadores.First();
   while (  tbOperadores.Eof = false ) do
   begin
      fmMain.mostraProgresso(tbOperadores, 'Obtendo último movimento...');

      qtDias :=  cf.getDiasSemMov( funcoes.getCodUO(cbLojas),
                                   tbOperadores.fieldByName('is_ref').asString,
                                   tp_mov
                                 );
      tbOperadores.Edit;
      tbOperadores.FieldByName('qtDias').AsInteger := qtDias;
      tbOperadores.post;
      tbOperadores.next;
   end;

   tbOperadores.First();
   while ( tbOperadores.Eof = false ) do
   begin
      fmMain.mostraProgresso(tbOperadores, 'Filtrando valores...');

      if( tbOperadores.FieldByName('qtDias').AsInteger < spedit.Value) then
         tbOperadores.Delete()
      else
         tbOperadores.Next;
   end;
end;

procedure TfmItensSemMov.geraDiasSemOperacao;
var
  cmd:String;
  dsItens:TdataSet;
begin
   funcoes.gravaLog('---------- Gerar produtos sem movimento--------');

   cmd := 'is_ref int, codigo varchar(10), descricao varchar(60), dtUltentrada smallDateTime, estoque smallInt, pv money, qtDias int';
   cf.getTable(tbOperadores , cmd );
   dsItens :=  cf.getIsrefPorFaixaCodigo(edCodigo.Text, '0', '0', true);

   cf.getItensGeraEstoque( dsItens, tbOperadores, funcoes.getCodUO(cbLojas), '103', false);

   pegarDiasSemMovimentoDosItens();

   case cbCaixas.ItemIndex of
     0:getDadosUltEntradaCompra();
   end;

   grid.Columns[ tbOperadores.FieldByName('is_ref').Index].Visible := false;
   fmMain.msgStatus('');
end;

procedure TfmItensSemMov.btOkClick(Sender: TObject);
var
   executa:boolean;
begin
   grid.Visible := false;
   executa := true;
   if (funcoes.isIntervDataValido(di, df, true, 99999) = false) then
      executa := false;

   if (edCodigo.Text = '' ) then
      if (funcoes.msgTela('', 'Se não especificar o código vou gerar para todos os itens,' +
                              'isso pode demorar, continua?', MB_YESNO + MB_ICONQUESTION ) = mrNo) then
      executa := false;

   if (executa = true) then
      geraDiasSemOperacao();

   grid.Visible := true;
end;

procedure TfmItensSemMov.gridTitleClick(Column: TColumn);
begin
  cf.organizarTabela(tbOperadores, column);
end;

procedure TfmItensSemMov.getDadosUltEntradaCompra;
var
   ds:TdataSet;
begin
   tbOperadores.First();
   while ( tbOperadores.Eof = false) do
   begin
      fmMain.mostraProgresso(tbOperadores, 'Obtendo data da ultima entrada...');

      ds:= cf.getDadosUltEntItem(tbOperadores.fieldByName('is_ref').AsString, funcoes.getCodUO(cbLojas) );
      if (ds.IsEmpty = false) then
      begin
          tbOperadores.Edit;
          tbOperadores.FieldByName('dtUltentrada').AsString :=
          ds.fieldByName('dt_Mov').asString;
          tbOperadores.post;
      end;
          tbOperadores.Next();
end;
end;

end.
