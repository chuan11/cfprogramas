unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, DB, ADODB, TFlatButtonUnit,funcoes, funcSql,
  StdCtrls, fCtrls, SoftDBGrid;

type
  TForm4 = class(TForm)
    DataSource1: TDataSource;
    dt01: TDateTimePicker;
    dt02: TDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cbDetalhaPorLoja: TfsCheckBox;
    StatusBar1: TStatusBar;
    gridVenda: TSoftDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
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
   Form1.qrTVenda.sql.clear;
   Form1.qrTVenda.Close();
   shortdateformat := 'dd/mm/yy';
end;

procedure TForm4.FlatButton1Click(Sender: TObject);
begin
   cbDetalhaPorLoja.Checked := (form1.cbLoja.ItemIndex = 0 );

   form4.Top := form1.Top + 50;
   label4.caption :=   form1.table.FieldByName('codigo').AsString + '   ' +
                       form1.table.FieldByName('Descricao').AsString;

   shortdateformat := 'dd/mm/yyyy';
   form1.CalculaVendaNoPeriodo(  quotedStr(copy(form1.cbLoja.Items[form1.cbLoja.ItemIndex],51,08)),
                                 form1.Table.FieldByName('is_ref').AsString,
                                 DateToStr(dt01.date),
                                 DateToStr(dt02.date),
                                 quotedstr(form1.table.FieldByName('codigo').AsString),
                                 quotedstr(form1.table.FieldByName('Descricao').AsString),
                                 cbDetalhaPorLoja.Checked
                              );


   if (cbDetalhaPorLoja.Checked = true) then
   begin
      gridVenda.Columns[0].Width := 150;
      gridVenda.Columns[1].Width := 60;
      form4.Height := 470;
      StatusBar1.SimpleText := 'Total: ' + funcSql.somaColQuery(form1.qrTVenda, 'Quantidade', 0 );
   end
   else
   begin
      form4.Height := 230;
   end;

end;


procedure TForm4.FormActivate(Sender: TObject);
begin
   cbDetalhaPorLoja.Checked := false;
   cbDetalhaPorLoja.Enabled := (form1.cbLoja.ItemIndex = 0);
end;

end.
