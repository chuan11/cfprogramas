unit LancaPrecosSIC2k;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, DB, Grids, DBGrids, SoftDBGrid, ADODB,funcoes,
  ComCtrls, TFlatButtonUnit, CheckLst, adLabelCheckListBox,clipbrd;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    Query: TADOQuery;
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    cb2: TadLabelComboBox;
    cb1: TadLabelComboBox;
    dp1: TDateTimePicker;
    Label1: TLabel;
    FlatButton1: TFlatButton;
    QueryCodigo: TStringField;
    QueryDescricao: TStringField;
    QueryPreco: TBCDField;
    dt2: TDateTimePicker;
    Label2: TLabel;
    cbox3: TadLabelComboBox;
    FlatButton2: TFlatButton;
    function GetTiposDePrecos(sender: tobject): Tstrings;
    function GetNomeLojas(sender: tobject): Tstrings;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure GerarPrecos(sender:tobject);
    function lojasalancar(sender:tobject):string;
    function Repetir(quant: integer; Str: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   ENTER = #13;
   HOME = ^w;
   TAB  = #09;
var
  Form1: TForm1;



implementation

{$R *.dfm}
function TForm1.Repetir(quant: integer; Str: string): string;
var
  aux:string;
  i:integer;
begin
   aux := Str;
   for i:= 1 to quant -1 do
      str := str+ aux;
   Repetir := str;
end;

function TForm1.lojasalancar(sender: tobject): string;
var
   i:integer;
   aux:string;
begin
  for i:= 0 to 13 do
      aux := aux+ tab;
   lojasaLancar:= aux;
end;

function TForm1.GetTiposDePrecos(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('Select DS_TIPOPRECO, tp_preco from ttpco ');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(query.Fields[0].AsString+query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
// descricao do 01 ao 50
//is_uo do 51 ao 58
end;

function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from tbuo where TP_ESTOQUE in (1,2) order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   datasource1.DataSet := nil;
   cb1.items := GetTiposDePrecos(sender);
   cb2.items := GetNomeLojas(sender);
   dp1.Date := now;
//   shortdateformat := 'dd/mm/yy';

   if funcoes.RParReg('LancaPreco','Loja') <> '' then
      cb2.itemindex := StrToInt(funcoes.RParReg('LancaPreco','loja'))
   else
      cb2.itemindex := 0;

   if funcoes.RParReg('LancaPreco','preco') <> '' then
      cb2.itemindex := StrToInt(funcoes.RParReg('LancaPreco','preco'))
   else
      cb1.itemindex := 0;

   datasource1.DataSet := query;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   aux:String;
begin
   screen.cursor := crhourglass;
   aux:='';
   query.SQL.clear;

   aux:= ' select crefe.cd_ref as [Codigo], crefe.ds_ref as [Descricao], dsalp.vl_preco as [Preco] from dsalp ' +
         ' inner join crefe on dsalp.is_ref = crefe.is_ref ' +
         ' where ' +
         ' dsalp.tp_preco = '+ quotedStr(copy(cb1.items[cb1.itemIndex],51,03)) +
         ' and dsalp.dt_altpv = ' +funcoes.StrToSqlDate( DateTostr(dp1.date)  )+
         ' and dsalp.is_uo = '+ copy(cb2.Items[cb2.itemIndex],51,08) ;

   query.SQL.Add(aux);
   query.Open;
   screen.cursor := crdefault;
   SoftDbgrid1.Columns[0].Width := 100;
   SoftDbgrid1.Columns[1].Width := 300;
   SoftDbgrid1.Columns[2].Width := 100;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
    if application.MessageBox('Deseja exportar para os preços para o SIC?', pchar(form1.caption), mb_iconquestion + mb_yesNo) = MrYes then
      GerarPrecos(sender);
end;

procedure TForm1.GerarPrecos(sender: tobject);
var
   str, LOJAS:string;

begin//
   str := '';
   shortdateformat := 'dd/mm/yy';

//   query.First;
//   while query.Eof = false do
   begin
      str := '';
      // MUDAR A TELA PARA REPVV
      str := HOME + 'VOLTA'+ ENTER + HOME +  'REPVV'+ ENTER;
      lojas :=    HOME + TAB + ' ' +lojasAlancar(sender) + TAB + copy(cbox3.Items[cbox3.Itemindex],01,01)+Funcoes.SohNumeros(dateToStr(dt2.date)) + TAB;
      str := str +LOJAS;
      str := str +  funcoes.preencheCampo(14,' ','D', query.fieldByname('codigo').AsString);
      str := str +  funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(query.FieldByName('preco').AsString)) );
      str := str +  ENTER;
      query.Next;
   end;
   clipboard.AsText := str;
   shortdateformat := 'dd/mm/yyyy';
end;


end.
