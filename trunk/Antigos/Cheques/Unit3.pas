unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpBase, RpSystem, RpCon, RpConDS, RpDefine, RpRave, DB, DBTables,
  StdCtrls, Mask, adLabelMaskEdit;

type
  TForm3 = class(TForm)
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    Query1: TQuery;
    Button1: TButton;
    medit1: TadLabelMaskEdit;
    Query1lancamento: TDateTimeField;
    Query1loja: TStringField;
    Query1cliente: TStringField;
    Query1NumCheque: TStringField;
    Query1vencimento: TDateTimeField;
    Query1valor: TFloatField;
    Query1porconta: TFloatField;
    Query1observacao: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses ContCheques;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
   query1.DatabaseName := form1.Database1.databasename;
   query1.Close;
   with query1.sql do
   begin
      clear;
      add('select lancamento, loja, cliente, NumCheque, vencimento, valor, porconta, observacao from cheques');
      add('where (lancamento = "'+ form1.AjustaData(medit1.text) + '") and (status = "A" ) order by cliente')
   end;
   query1.sql.SaveToFile('c:\Zteste.txt');
   query1.databaseName:= form1.database1.databasename;
   query1.Active:= true;
   RvProject1.ExecuteReport('RelChDevPorData');
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  medit1.setfocus;
end;

end.
