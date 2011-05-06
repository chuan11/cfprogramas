unit diasSemvenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, SoftDBGrid, DB, ADODB,
  funcoes,funcsql
  ;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    SoftDBGrid1: TSoftDBGrid;
    ed: TEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    tb: TADOTable;
    qr: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CriarTabela(Sender:Tobject);
    procedure ADOConnection1WillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    procedure ADOConnection1ExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
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
   cmd:String;
   i:integer;
begin
cmd :=
   ' select is_ref, '+
   ' dspes.nm_fantasi as Fornecedor , '+
   ' cd_ref ,' +
   ' ds_ref, ' +
   ' dbo.z_CF_UltEntLjData(10037736, is_ref,10033674) [Data Ultima Entrada], ' +
   ' dbo.z_cf_EstoqueNaloja(crefe.is_ref,  10037736 ,0) as estoque, ' +
   ' dbo.Z_CF_funDataUltVendaProd( 10037736 , is_ref) as [Data Ultima Venda], ' +
   ' 0 as DiasSemVenda, ' +
   ' dBO.z_cf_funObterPrecoProduto_cf(101,IS_REF,  10037736 ,0) as [Pv Venda], ' +
   ' DBO.z_cf_funObterPrecoProduto_cf(5,  IS_REF,  10037736 ,0) as [CMU], ' +
   ' DBO.z_cf_funObterPrecoProduto_cf(7,  IS_REF,  10037736 ,0) as [CRUC] ' +
   ' from crefe with (nolock) ' +
   ' inner join cccom with (nolock) on crefe.is_ref = cccom.cd_chave and cccom.cd_campo =''1'' and cccom.cd_vcampo = ''0015''' +
   ' inner join dspes (nolock )on crefe.cd_pes = dspes.cd_pes ' +   
   ' where dbo.z_cf_EstoqueNaloja(crefe.is_ref,  10037736 ,0) > 0 ';

   if ed.Text <> '' then
     cmd := cmd + ' and is_ref in ( '+ ed.Text +')' ;

   cmd := cmd +' order by crefe.cd_ref';

   qr.SQL.Clear;
   qr.sql.Add(cmd);
//   qr.SQL.SaveToFile('c:\teste.txt');
   qr.Open;


   qr.First;
   while qr.Eof = false do
   begin
      tb.Append;
      for i:= 0 to qr.FieldCount -1 do
         tb.Fields[i].AsString := qr.Fields[i].AsString;
      tb.Post;

      tb.Edit;
      if qr.FieldByName('Data Ultima Venda').AsString = '' then
         tb.FieldByName('Dias Sem venda').AsFloat := now - tb.FieldByName('Data Ultima Entrada').asdateTime
      else
         tb.FieldByName('Dias Sem venda').AsFloat := now - tb.FieldByName('Data Ultima Venda').asdateTime;
     qr.Next;
   end;
   form1.Caption := 'ok';
   funcsql.exportaTable(tb);

{ }
end;

procedure TForm1.CriarTabela(Sender: Tobject);
var
   tbName,cmd:String;
begin
  tbName := funcsql.getNomeTableTemp();
  cmd := 'create table ' + tbname+ '( is_ref integer, Fornecedor varchar(50), Codigo varchar(7), Descricao varchar(50),[Data Ultima Entrada] smalldateTime,[Estoque] integer,[Data Ultima Venda] smallDateTime,[Dias Sem venda] integer,[Preco Varejo] money,[CMU] money,[CRUC] money) ';
  funcSql.execSQL(cmd,form1.ADOConnection1);
  tb.TableName := tbName;
  tb.Open;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;
CriarTabela(Sender);
end;

procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor := crhourGlass;
end;

procedure TForm1.ADOConnection1ExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

end.
