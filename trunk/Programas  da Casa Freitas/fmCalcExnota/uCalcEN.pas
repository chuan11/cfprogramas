unit uCalcEN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcoes, funcsql,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, Buttons, fCtrls, Grids,
  DBGrids, SoftDBGrid, DB, ADODB;

type
  TfmCalcExNota = class(TForm)
    cbLojas: TadLabelComboBox;
    EdCodigo: TadLabelEdit;
    adLabelEdit1: TadLabelEdit;
    edForn: TadLabelEdit;
    btForn: TfsBitBtn;
    lbForn: TLabel;
    tb: TADOTable;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    procedure btFornClick(Sender: TObject);
    procedure carregaDadosNota(Sender:Tobject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCalcExNota: TfmCalcExNota;

implementation

uses uMain , uListaFornecedores; {  uForn;}

{$R *.dfm}

procedure TfmCalcExNota.btFornClick(Sender: TObject);
begin
{   Application.CreateForm(TfmForn, fmForn);
   fmForn.ShowModal;
   if fmForn.ModalResult = mrOk then
   begin
      edForn.Text :=     fmForn.qrCredores.FieldByName('fornecedor').asString;
      lbForn.caption :=  fmForn.qrCredores.FieldByName('codigo').asString;
   end;
}
end;

procedure TfmCalcExNota.carregaDadosNota(Sender: Tobject);
var
   cmd:String;
begin
    if tb.Active = true then
       tb.Close();
    tb.TableName := funcsql.getNomeTableTemp();
    cmd := '( seq int identity(01,01), Codigo Varchar(07), Descricao varchar(50), [Pc Pedido] money default 0, [Pc Nota] money default 0, [Extra Nota] money default 0 )';
    funcsql.getTable(fmMain.Conexao, tb, cmd);

    cmd := 'insert ' + tb.tableName +
           'Select';   


end;

end.
