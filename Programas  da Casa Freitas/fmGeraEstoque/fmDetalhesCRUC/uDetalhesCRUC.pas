unit uDetalhesCRUC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid,DB;

type
  TfmDetalhesCRUC = class(TForm)
     grid: TSoftDBGrid;
     DataSource1: TDataSource;

    procedure getDadosCRUC(is_ref:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetalhesCRUC: TfmDetalhesCRUC;

implementation

uses uMain, uCF;

{$R *.dfm}


procedure TfmDetalhesCRUC.getDadosCRUC(is_ref: String);
var
  ds:TdataSet;
begin
   ds := uCF.getDetalhesCRUC(is_ref);
   DataSource1.DataSet := ds;
   grid.Columns[0].width := 30;
   grid.Columns[1].width := 45;
   grid.Columns[2].width := 200;
   grid.Columns[3].width := 65;
   grid.Columns[4].width := 75;
   grid.Columns[5].width := 30;
   grid.Columns[6].width := 65;
   grid.Columns[7].width := 40;
   grid.Columns[8].width := 60;
   grid.Columns[9].width := 100;
   grid.Columns[10].width := 100;
end;
procedure TfmDetalhesCRUC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
    fmDetalhesCRUC:= nil;
end;

end.
