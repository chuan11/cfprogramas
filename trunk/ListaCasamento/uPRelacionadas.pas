unit uPRelacionadas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, fCtrls, Grids, DBGrids, SoftDBGrid;
type
  TfmPRelacionadas = class(TForm)
    grid: TSoftDBGrid;
    btBusca: TfsBitBtn;
    fsBitBtn1: TfsBitBtn;
    tb: TADOTable;
    DataSource1: TDataSource;
    procedure CarregaPessoasRelacionadas(Sender:Tobject; numLista:String);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure tbBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPRelacionadas: TfmPRelacionadas;
  N_LISTA:String;
implementation

uses unit1;

{$R *.dfm}

procedure TfmPRelacionadas.CarregaPessoasRelacionadas(Sender: Tobject;numLista: String);
begin
   tb.TableName := 'PRListas';
   tb.Filter := 'NumLista = ' + numLista;
   tb.Filtered := true;
   tb.Open();
   grid.Columns[0].visible := false;
   N_LISTA := numLista;
end;

procedure TfmPRelacionadas.fsBitBtn1Click(Sender: TObject);
begin
   if tb.IsEmpty = false then
      tb.Delete();
end;

procedure TfmPRelacionadas.btBuscaClick(Sender: TObject);
begin
   tb.Append();
end;

procedure TfmPRelacionadas.tbBeforePost(DataSet: TDataSet);
begin
  tb.FieldByName('numLista').asString := N_LISTA;
  tb.FieldByName('pessoa').asString  := uppercase( tb.FieldByName('pessoa').asString );
end;

end.
