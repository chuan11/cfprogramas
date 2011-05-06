unit ConsultaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls;

type
  TFmConsulta = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure consultapreco(sender:tobject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmConsulta: TFmConsulta;

implementation

uses UCaixaOff;

{$R *.dfm}

procedure TFmConsulta.FormCreate(Sender: TObject);
begin
   query1.DatabaseName := form1.database1.databasename;
end;

procedure TFmConsulta.consultapreco(sender:tobject);
var
   aux:string;
begin
   query1.SQL.Clear;
   aux := ' Select Codigo, Descricao, varejo, atacado from produtos ' +
          ' where (codigo like "%' +edit1.text+ '%") or  ( descricao like "' +edit1.text+ '%" )'+
          ' order by descricao';
   query1.sql.add(aux);
   query1.Open;
end;

procedure TFmConsulta.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = Vk_Return)and(length(edit1.text) >= 5) then
   begin
      screen.Cursor := crhourglass;
      consultapreco(sender);
      edit1.setfocus;
      screen.Cursor := crdefault;
   end;
end;

procedure TFmConsulta.DBGrid1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  If KEY = VK_TAB THEN
     edit1.text
end;

end.
