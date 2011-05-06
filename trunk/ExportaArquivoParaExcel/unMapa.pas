unit unMapa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB,funcSQL,funcoes, ComCtrls;

type
  TFmMapa = class(TForm)
    DataSource1: TDataSource;
    table: TADOTable;
    DBGrid: TSoftDBGrid;
    StatusBar1: TStatusBar;

    procedure CarregarDadosMapaSeparacao(Sender:TObject; query:TADoQuery);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure AjustaGrid(Sender:TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMapa: TFmMapa;

implementation

uses Unit1;

{$R *.dfm}

{ TFmMapa }

procedure TFmMapa.AjustaGrid(Sender: TObject);
var
  i:smallint;
begin
   dbgrid.Columns[0].Visible := false;
   for i:=0 to dbgrid.Columns.Count -1 do
     dbgrid.Columns[i].Title.Font.Style := [fsBold];
   dbgrid.Columns[2].Width := 100;
   dbgrid.Columns[3].Width := 25;
   for i:= 4 to dbgrid.Columns.Count -1 do
     dbgrid.Columns[i].Width := 50;
end;

procedure TFmMapa.CarregarDadosMapaSeparacao(Sender: TObject;  query: TADoQuery);
var
   numCampo:smallint;
   nmTabela,cmd:string;
   qrDados:TADOQuery;

begin
   qrDados := TADOQuery.Create(FmMapa);
   qrDados.Connection := form1.ADOConnection1;
   qrDados.SQL.add (' Select ds_uo from tbuo with(noLock) where TP_ESTOQUE in (1,2) order by  tp_estoque, CD_UO ') ;
   qrDados.Open();

   nmTabela :=  '#MapaSeparacao'+funcoes.SohNumeros(dateTimeToStr(now));
   cmd := ' Create table '+nmTabela+ ' ( is_ref int , Código varchar(07), Descrição varchar(30), Cx int ' ;
   while qrDados.eof = false do
   begin
     cmd := cmd + ', ['+ qrDados.Fields[0].AsString + '] int ' ;
     qrDados.Next();
   end;
   cmd := cmd + ')';
   funcSQl.GetValorWell(  'E', cmd, '', form1.ADOConnection1 );

   Table.Connection := form1.ADOConnection1;
   Table.TableName := nmTabela;
   Table.Active := true;
   AjustaGrid(Sender);


   qrDados.Close;
   qrDados.SQL.Clear;
   qrDados.SQL.Add('Select is_ref, cd_ref, substring(ds_ref,01,30), QT_EMB  from crefe with(noLock) where dbo.Z_CF_EstoqueNaLoja( is_ref, '+ UO_CD +' ,1  ) > 0 and cd_ref like '  + quotedStr(form1.edit1.Text +'%')  );
   qrDados.Open;

   qrDados.First;
   while qrDados.eof = false do
   begin
      Table.AppendRecord( [qrDados.Fields[0].AsString,
                           qrDados.Fields[1].AsString,
                           qrDados.Fields[2].AsString,
                           qrDados.Fields[3].AsString]
                          );
      qrDados.Next;
   end;

   screen.Cursor := crHourGlass;
   table.First;
   while table.Eof = false do
   begin
      qrDados.SQL.Clear;
      qrDados.SQL.Add('Exec Z_CF_ObterEstoqueProdutoNasFiliais ' + Table.fieldByName('Is_ref').AsString +' , 1' );
      qrDados.Open;

      table.Edit;
      for numCampo := 4 to table.FieldCount -1 do
      begin
         table.Fields[numCampo].AsString := qrDados.FieldByName('Estoque').asString;
         qrDados.Next;
      end;
     table.Post;
     table.Next;
   end;
   screen.Cursor := crDefault;
end;

procedure TFmMapa.DBGridDrawColumnCell(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (DataCol > 4 ) and (Column.Field.AsInteger > 0 )then
   begin
      DBGrid.Canvas.Font.Color:= clRed;
      DBGrid.Canvas.FillRect(Rect);
      DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFmMapa.FormResize(Sender: TObject);
begin
   dbGrid.Left := 1;
   dbgrid.top := 30;
   dbgrid.Width := fmMapa.Width - 10 ;
   dbGrid.Height := fmMapa.Height - 50 - dbgrid.Top;
end;

procedure TFmMapa.FormCreate(Sender: TObject);
begin
   fmMapa.Caption := form1.Caption + ' - Mapa de estoque' ;
end;

end.

