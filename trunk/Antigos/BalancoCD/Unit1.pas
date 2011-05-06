unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    Button1: TButton;
    Memo1: TMemo;
    QPesquisa: TADOQuery;
    Edit1: TEdit;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function ProcuraCodigoPeloEan(Str:string;sender:tobject):string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   button1.Hint := 'Insere o codigo da loja na tabela Zcoletor procurando pelo Ean na DSCBR'
end;

function TForm1.ProcuraCodigoPeloEan(Str: string; sender: tobject): string;
begin
   QPesquisa.SQL.Clear;
   QPesquisa.SQL.Add('Select crefe.cd_ref from crefe inner join dscbr on dscbr.is_ref = crefe.is_ref where dscbr.cd_pesq = ' + quotedstr(str) );
   QPesquisa.Open;

   if not(qpesquisa.IsEmpty) = true then
      ProcuraCodigoPeloEan := QPesquisa.Fields[0].AsString
   else
     ProcuraCodigoPeloEan := '';
end;


procedure TForm1.Button1Click(Sender: TObject);

begin




//   memo1.Lines.add( ProcuraCodigoPeloEan(edit1.text,sender));
end;

end.
