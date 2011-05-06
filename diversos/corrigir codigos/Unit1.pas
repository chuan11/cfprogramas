unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ADODB, funcsql, StdCtrls, funcoes;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure ADOConnection1WillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   cmd :String;
   i:integer;
begin
   funcsql.openTempTable(ADOTable1, ' seq int primary key identity(0,1),  is_ref int, ds_ref varchar(50), cd_ref varchar(08), cd_ref2 varchar(8)', ADOConnection1);

   ADOTable1.Close();


  cmd := 'INSERT ' + ADOTABLE1.TableName +' ';

   for i:=0 to memo1.Lines.Count-1 do
      cmd := cmd + memo1.Lines[i];

{   cmd :=
          'INSERT ' + ADOTABLE1.TableName +' ' +
          'select c.is_ref,  ds_ref, c.cd_ref, '''' as cd_ref2 '+
          'from crefe c ' +
          'where  len(c.cd_ref) = 8 ' +
          ' and cd_ref not like (''922%'') ' +
          ' and cd_ref not like (''922%'') ' +


          'order by cd_ref';

}

   funcSQL.execSQL(CMD, ADOConnection1);

   DataSource1.DataSet := ADOTable1;
   ADOTable1.Active := true;
   ADOTable1.Refresh;
end;

procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
    funcoes.gravaLog(CommandText);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    ADOTable1.First();
    while ADOTable1.Eof = false do
    begin
       if length(  adotable1.fieldByname('cd_ref2').asString) > 0 then
       begin
          funcSQl.execSQL( 'update crefe set cd_ref = ' + quotedstr(adotable1.fieldByname('cd_ref2').asString) +
                           'where is_ref = ' + adotable1.fieldByname('is_ref').asString,
                           ADOConnection1);
       end;
       ADOTable1.Next;
    end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   salvaCampos(Form1);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  funcoes.carregaCampos(form1);

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
var
   aumento, i:integer;
begin
   aumento := 10;
   ADOTable1.Prior;
   i:= adotable1.fieldByname('cd_ref2').asinteger+ aumento;

   ADOTable1.Next();

   while ADOTable1.Eof = false do
   begin
      adotable1.Edit;
      adotable1.fieldByname('cd_ref2').AsInteger := i;
      i:= i+aumento;

      ADOTable1.Next();

   end;


end;

end.
