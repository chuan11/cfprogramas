unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, TFlatEditUnit, DB, Grids, DBGrids,
  ADODB, adLabelEdit;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Query1: TADOQuery;
    edLocaliza: TadLabelEdit;
    edDestino: TadLabelEdit;
    edCodigo: TadLabelEdit;
    FlatButton2: TFlatButton;
    btLista: TFlatButton;
    procedure FlatButton1Click(Sender: TObject);
    procedure Query1BeforePost(DataSet: TDataSet);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   query1.sql.clear;
   query1.sql.add('SELECT cd_ref, DS_REF, DS_RESU FROM CREFE WHERE CD_REF LIKE ' + quotedstr(edCodigo.text+'%') + ' ORDER BY ds_ref' ) ;
   query1.open;
   edCodigo.Enabled := false;
   btLista.Enabled := false;
end;

procedure TForm1.Query1BeforePost(DataSet: TDataSet);
begin
   query1.Fields[2].AsString := copy( query1.Fields[1].AsString,01,20);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
     FlatButton1Click(Sender);
end;

procedure TForm1.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) and (length(edcodigo.Text) > 3 )then
      FlatButton1Click(sender);
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
   if (edLocaliza.text <>'') and ( application.MessageBox(pchar('Deseja Alterar descrição : '+ edLocaliza.text +#13+ '                      Para : '+ edDestino.text) ,pchar(form1), mb_YesNo+ mb_IconQuestion) = mrYes ) then
end;

end.
