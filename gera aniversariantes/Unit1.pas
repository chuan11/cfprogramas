unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DB, ADODB, Grids, DBGrids, mxExport;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOConnection2: TADOConnection;
    medit1: TMaskEdit;
    UpDown1: TUpDown;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    export1: TmxDBGridExport;
    memo1: TMemo;
    Memo2: TMemo;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    ADOQuery2: TADOQuery;
    export2: TmxDBGridExport;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Memo3: TMemo;
    DataSource3: TDataSource;
    ADOQuery3: TADOQuery;
    ADOConnection3: TADOConnection;
    Export3: TmxDBGridExport;
    DBGrid3: TDBGrid;
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    function AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
    procedure FormCreate(Sender: TObject);
    procedure SelecionaDatasCF(sender:tobject);
    procedure carregaCF(sender:tobject);
    procedure SelecionaDatasPFM(sender:tobject);
    procedure carregaPFM(sender:tobject);
    procedure Button1Click(Sender: TObject);
    function  GetEstabCF(mat:string):string;
    function  GetEstabPFM(mat:string):string;
    function  GetEstabPF(mat:string):string;
    procedure carregaPF(sender:tobject);
    procedure SelecionaDatasPF(sender:tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function  Tform1.GetEstabCF(mat:string):string;
begin
   case StrToint( mat  ) of
      03:GetEstabcf:='Edgar'
   else
     GetEstabcf:='Matriz';
   end;
end;

function  Tform1.GetEstabPFM(mat:string):string;
begin
   case StrToint( mat  ) of
      06:GetEstabPFM:='Dom Luis';
      10:GetEstabPFM:='Messejana';
      11:GetEstabPFM:='Montese';
      12:GetEstabPFM:='Washington';
      18:GetEstabPFM:='Liberato';
      09:GetEstabPFM:='Teresina';
   else
     GetEstabPFM:='Pedro Borges';
   end;
end;
function  Tform1.GetEstabPF(mat:string):string;
begin
   case StrToint( mat  ) of
      08:GetEstabPF:='Sao Luis';
   else
     GetEstabPF:='FREITAS JEANS';
   end;
end;


function TForm1.AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
var
  mes,ano:integer;
  data:string[6];
begin
   mes := strtoint(copy (text,01,02));
   ano := strtoint(copy (text,03,04));
   data := copy (text,01,02) + (copy (text,03,04));
   if button = btnext then
      mes := mes + 1
   else  if button = btprev then
    mes := mes - 1;
   if mes = 13 then
   begin
      mes := 01;
      inc(ano);
   end;
   if mes = 0 then
   begin
      mes := 12;
      dec(ano);
   end;
   data:= ( inttostr(mes) + inttostr(ano));
   while length(data) < 6 do insert('0',data,01);
      AjustaMesANo:=data;
end;

procedure tform1.SelecionaDatasPFM(sender:tobject);
begin
   adoquery2.sql:=   adoquery1.sql;
   adoquery2.open;
   export2.filename := 'c:\anivPFM.txt';
   export2.Execute;
   carregaPFM(sender);
end;

procedure tform1.carregaPFM(sender:tobject);
var
   arq:textfile;
   lin:string;
begin
   assignfile( arq,export2.filename);
   reset(arq);
   while eof( arq) = false do
   begin
      readln(arq,lin);
      if copy(lin,65,02) = copy(medit1.text,01,02) then
         memo2.lines.add( copy(lin,01,40) +'  '+ copy(lin,62,02)+'  '+ GetEstabPFM(copy(lin,79,03)));
   end;
   closefile(arq);
end;

procedure tform1.carregaCF(sender:tobject);
var
   arq:textfile;
   lin:string;
begin
   assignfile( arq, export1.filename);
   reset(arq);
   while eof( arq) = false do
   begin
      readln(arq,lin);
      if copy(lin,65,02) = copy(medit1.text,01,02) then
         memo1.lines.add( copy(lin,01,40) +'  '+ copy(lin,62,02) +' '+GetEstabCF(copy(lin,79,03)));
   end;
   closefile(arq);
end;

procedure tform1.SelecionaDatasCF(sender:tobject);
begin

   with adoquery1.SQL do
   begin
      clear;
      add('select emp_nome, emp_datanascimento, emp_estabelecimento from empregados');
      add('where (emp_status =' +#39+ '1'+ #39+') and ( emp_datanascimento <>'+ #39+' '+#39')');
      add('order by emp_nome');
   end;
   adoquery1.open;
   export1.filename := 'c:\anivCF.txt';
   export1.Execute;
   carregaCF(sender);
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
   medit1.text:=AjustaMesANo(sender, button ,medit1.text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    medit1.text:=( copy(DateToStr(now),04,02) + copy(DateToStr(now),07,04) );
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   memo1.Lines.Clear;
   memo2.Lines.Clear;
   SelecionaDatasCF(sender);
   SelecionaDatasPFM(sender);
   SelecionaDatasPF(sender);
   screen.Cursor := crdefault;
end;

procedure tform1.carregaPF(sender:tobject);
var
   arq:textfile;
   lin:string;
begin
   assignfile( arq,export3.filename);
   reset(arq);
   while eof( arq) = false do
   begin
      readln(arq,lin);
      if copy(lin,65,02) = copy(medit1.text,01,02) then
         memo3.lines.add( copy(lin,01,40) +'  '+ copy(lin,62,02)+'  '+ GetEstabPF(copy(lin,79,03)));
   end;
   closefile(arq);
end;

procedure tform1.SelecionaDatasPF(sender:tobject);
begin
   adoquery3.sql:=   adoquery1.sql;
   adoquery3.open;
   export3.filename := 'c:\anivPF.txt';
   export3.Execute;
   carregaPF(sender);
end;



end.


