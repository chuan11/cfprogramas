unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SoftDBGrid, ADODB, Unit1,funcoes, funcDatas, funcsql;
type
  TForm5 = class(TForm)
    qrDetalhes: TADOQuery;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    qrCustoPorNota: TADOQuery;
    procedure DetalhesCRUC(Sender:Tobject; is_ref,cod,Descricao: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DetalhesCRUCBaSeadoNaNota(is_ref,cod,Descricao: String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation



{$R *.dfm}

{ TForm5 }

procedure TForm5.DetalhesCRUC(Sender: Tobject; is_ref,cod,Descricao: String);
begin
   qrDetalhes.SQL.Clear;
   qrDetalhes.SQL.add('Exec z_cf_DetalharCRUC '+ is_ref );
   qrDetalhes.OPEN;
   DataSource1.DataSet := qrDetalhes;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    form1.VerdetalhesdaCRUCbaseadonanota1.Enabled := true;
    action := caFree;
    form5 := nil;
end;

procedure TForm5.FormActivate(Sender: TObject);
begin
   form5.Top := form1.Height - form5.Height - 50;
end;

procedure TForm5.DetalhesCRUCBaSeadoNaNota(is_ref, cod, Descricao: String);
begin
   if qrCustoPorNota.IsEmpty = false then
   begin
     qrCustoPorNota.close();
     qrCustoPorNota.SQL.Clear();
   end;

//   uUtil.getCRUCBaseNota(form1.ADOConnection1, qrCustoPorNota, is_ref );

   DataSource1.DataSet := qrCustoPorNota;

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


end.
