unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, TFlatEditUnit, StdCtrls, TFlatMemoUnit,
  TFlatButtonUnit, Grids, DBGrids,funcoes;

type
  TForm1 = class(TForm)
    FlatButton1: TFlatButton;
    Memo: TFlatMemo;
    Edit1: TFlatEdit;
    ADOConnection1: TADOConnection;
    Q1: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Label1: TLabel;
    FlatButton2: TFlatButton;
    q2: TADOQuery;
    Label2: TLabel;
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure CadastraEan(is_ref, ean:string; Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Function EAN13( CodigoDeBarras : String ) : String;
var nX    : Integer;
 nPeso  : Integer;
   nSoma  : Double;
   nMaior  : Double;
   nDigito : Integer;
Begin
    nPeso := 3;
    nSoma := 0;

    For nX := 12 DownTo 1 do
    Begin
       nSoma := nSoma + StrToInt( CodigoDeBarras[ nX ] ) * nPeso;
    If nPeso = 3 Then nPeso := 1 Else nPeso := 3;
    End;

 nMaior      := ( ( Trunc( nSoma / 10 ) + 1 ) * 10 );
 nDigito  := Trunc( nMaior ) - Trunc( nSoma );
 If nDigito = 10 Then nDigito := 0;
 Result := CodigoDeBarras + IntToStr( nDigito );
End;


procedure TForm1.CadastraEan(is_ref, ean: string; Sender: Tobject);
var
  cmd:string;
begin
   cmd := ' Insert dscbr(tp_cdpesq, cd_pesq, is_ref) values(' + quotedStr('1') + ' , ' +
            quotedstr(ean)  + ' , ' + is_ref + ' )';


   q2.SQL.Clear;
   q2.SQL.Add(cmd);
   q2.ExecSQL();

   funcoes.GravaLinhaEmUmArquivo('c:\eansGerados.txt', cmd);
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   cmd: String;
Begin
   cmd:= ' Select dbo.Z_CF_obterEan(is_ref) as ean, cd_ref, ds_ref,is_ref from crefe where cd_ref like ' + Quotedstr(Edit1.text+'%') + ' order by cd_ref ';
   Q1.SQL.clear;
   q1.SQL.Add(cmd);
   q1.Open;
   label1.Caption := 'itens : ' + Inttostr(q1.RecordCount-1);
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
var
   i:integer;
begin
   q1.First;
   i:=0;
   while q1.eof = false do
   begin
      if q1.FieldByName('ean').AsString = '' then
      begin
         memo.Lines.Add(
                         q1.fieldByname('cd_ref').asString + ' ' +
                         EAN13( funcoes.preencheCampo(12,'0','d', q1.FieldByName('cd_ref').AsString)) + ' '+
                         q1.fieldByname('is_ref').asString
                       );
         CadastraEan( q1.fieldByName('is_ref').AsString, EAN13( funcoes.preencheCampo(12,'0','d', q1.FieldByName('cd_ref').AsString)), Sender);
         label2.Caption := intToStr(i)+ ' de ' + Inttostr(q1.RecordCount-1);
         form1.Refresh;
         sleep(30);
      end;


//      is_ref, ean: string; Sender: Tobject);
      q1.next;
   end;

end;

end.
