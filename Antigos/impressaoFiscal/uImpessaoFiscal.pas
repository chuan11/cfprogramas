unit uImpessaoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, RpBase, RpSystem, RpCon, RpConDS, RpDefine, RpRave,
  StdCtrls;

type
  TForm1 = class(TForm)
    conexao: TADOConnection;
    tbImpOco: TADOTable;
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    Button1: TButton;
  procedure imprime();
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure conexaoWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
  
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation

{$R *.dfm}
uses funcsql, funcoes;

procedure TForm1.imprime;
var
   arq:Tstringlist;
   i, j,l:integer;
   nmearquivo:String;
begin
   arq := TStringList.create();

   nmearquivo := 'c:\impFiscal.txt';

   if (nmearquivo <> '') then
      arq.LoadFromFile(nmearquivo);

   if (tbImpOco.TableName <> '') then
      tbImpOco.Close();

   funcSQL.getTable(conexao, tbImpOco, ' linha varchar(132)' );

   tbImpOco.Open();

   l:=1;
   for i:= 0 to arq.Count -1  do
   begin
      inc(l);
      if pos('', arq[i]) > 0 then
      begin
         while (l < 56) do
         begin
            tbImpOco.AppendRecord([' ']);
            inc(l);
         end;
         l:=1;
         tbImpOco.AppendRecord([arq[i]]);
      end
      else
         tbImpOco.AppendRecord([arq[i]]);
   end;

   RvDataSetConnection1.DataSet := tbImpOco;
//   RvProject1.ExecuteReport('rpImpressaoFiscal');
//   arq.Free();
//   tbImpOco.Close();
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
   if (conexao.Connected = true) then
      conexao.Connected := false;

   conexao.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   conexao.Connected := true;
   RvProject1.ProjectFile := ExtractFilePath(paramStr(0)) + 'RelatoriosPCF.rav' ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    imprime();
end;

procedure TForm1.conexaoWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
  funcoes.gravaLog(CommandText);
end;

end.
