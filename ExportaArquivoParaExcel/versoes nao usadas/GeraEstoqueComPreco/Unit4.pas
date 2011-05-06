unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, DB, ADODB, TFlatButtonUnit,funcoes,
  StdCtrls;

type
  TForm4 = class(TForm)
    Query: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    dt01: TDateTimePicker;
    dt02: TDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalculaVendaNoPeriodo(sender:tobject; uo, is_ref, dtInicio, dtFim, cod, desc: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}
procedure TForm4.FormCreate(Sender: TObject);
var
   aux :string;
begin
    aux := DateToStr(now-60 );
    delete(aux,01,02);
    insert('01',aux,01);
    dt01.Date := StrToDate(aux);
    dt02.Date := now;     
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form1.Bt_Saidas.Enabled := true;
   shortdateformat := 'dd/mm/yy';
end;

procedure TForm4.FlatButton1Click(Sender: TObject);
begin
   shortdateformat := 'dd/mm/yyyy';
   CalculaVendaNoPeriodo(sender, quotedStr(copy(form1.cb2.Items[form1.cb2.ItemIndex],51,08)),
                                 form1.Query1.FieldByName('is_ref').AsString,
                                 DateToStr(dt01.date),
                                 DateToStr(dt02.date),
                                 quotedstr(form1.query1.FieldByName('código').AsString),
                                 quotedstr(form1.query1.FieldByName('Descrição').AsString) );
end;

procedure TForm4.CalculaVendaNoPeriodo(sender:tobject; uo, is_ref, dtInicio,dtFim,cod,desc: string);
begin
   if (cod <> '') and (desc <> '' )then
      label4.caption :=   cod + '   ' + desc;
   query.sql.clear;
   query.SQL.add(' select dbo.Z_CF_funObterVendaPorPeriodo( '+
                   uo       +', '+
                   is_ref   +', '+
                   funcoes.StrToSqlDate(dtInicio)   +', '+
                   funcoes.StrToSqlDate(dtFim)  +', '+
                   form1.GetIniDtVen() +') as Quantidade'
                );
   query.Open;
end;

end.
