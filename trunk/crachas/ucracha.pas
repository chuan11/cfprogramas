unit ucracha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RLReport, Mask, RLBarcode, jpeg, Grids, DBGrids, DB, ADODB,
  adLabelComboBox;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;


///    RLAngleLabel2: TRLAngleLabel;

    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;

    RLReport1: TRLReport;
    RLImage1: TRLImage;
    RLLabel1: TRLLabel;
    RLBarcode1: TRLBarcode;
    RLLabel2: TRLLabel;
    RLAngleLabel1: TRLAngleLabel;
    Edit3: TEdit;
    Label3: TLabel;
    RLAngleLabel2: TRLAngleLabel;
    cb1: TadLabelComboBox;
    cb2: TadLabelComboBox;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    Query: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure cracha(sender:TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure TForm1.Button1Click(Sender: TObject);
var
   ok:boolean;
   erro:string;
begin
   ok:= true;
   erro:=' Falta(m) preencher o(s) campo(s): ' +#13;
   if edit1.text = '' then
   begin
      ok := false;
      erro:= erro + '   Nome' +#13;
   end;
   if edit2.text = '' then
   begin
      ok := false;
      erro:= erro + '   Nome Completo' +#13;
   end;
   if edit3.text = '' then
   begin
      ok := false;
      erro:= erro + '   Funcao' +#13;
   end;

   if ok = true then
      cracha(sender)
   else
      showmessage(erro);


end;
procedure tform1.cracha(sender : TObject);
begin

   rllabel2.caption:=edit1.text;
   rlanglelabel1.Caption := edit2.text;
   rlanglelabel2.Caption := maskedit1.text;
   rlbarcode1.caption := maskedit1.text;
   rllabel1.caption := EDIT3.TEXT;
   if maskedit1.text = '' then
   begin
      rlbarcode1.visible:= false;
      rlanglelabel2.visible := false;
   end;
   rlReport1.Preview;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   adoconnection1.Connected := false;
   adoconnection1.ConnectionString :='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Initial Catalog='+ cb1.Items[cb1.itemIndex] +';Data Source=125.4.4.200';
   adoconnection1.Connected := true;

   query.SQL.Clear;
   query.SQL.add(' select  e.Emp_cartaodeponto, e.emp_nome, f.fun_descricao from empregados e, funcoes f');
   query.SQL.add(' where emp_estabelecimento = ' + quotedstr(cb2.items[cb2.itemindex]) +' and e.emp_funcao =  f.fun_referencia and e.emp_status = ''1''   order by e.emp_nome' );

   query.sql.savetofile('c:\QueryCrachas.txt');
   query.Open;

   dbgrid1.Columns[0].Title.caption := 'Cartão';
   dbgrid1.Columns[1].Title.caption := 'Nome';
   dbgrid1.Columns[2].Title.caption := 'Funcao';
   dbgrid1.Columns[1].Width := 200;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    form1.Width := 430;


end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
   edit1.Text :='';
   edit2.text := dbgrid1.Fields[1].AsString;
   edit3.text := dbgrid1.Fields[2].AsString;
   maskedit1.text := dbgrid1.Fields[0].AsString;
end;

end.

