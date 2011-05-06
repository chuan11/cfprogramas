unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, Mask, DBCtrls, Buttons;

type
  TFormIncluir = class(TForm)
    MaskEdit1: TMaskEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Query1: TQuery;
    Database1: TDatabase;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure consultaItem(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormIncluir: TFormIncluir;

implementation

uses Unit2, Unit1;

{$R *.DFM}

procedure TFormIncluir.consultaItem(Sender: TObject);
begin
  with query1 do
  begin
     sql.Clear;
     sql.add(' select codigo, nome from recurso where codigo = '  + #39+maskedit1.text+#39);
   end;
   query1.open;

   if (dbgrid1.fields[0].AsString > '') then
   begin
      label1.caption := dbgrid1.fields[1].AsString;
   end
   else
   begin
      form1.msgdeRodape('O código ' + MaskEdit1.text +' não é Cadastrado !!!!!');
      messagebeep(MB_ICONASTERISK);
      label1.caption := '';
   end;

   maskedit1.setfocus;
end;


procedure TFormIncluir.FormActivate(Sender: TObject);
begin
   database1.databasename := 'CASAFREITAS';
   query1.databasename := database1.databasename;
   FormIncluir.left := form1.left +20;
   FormIncluir.top  := form1.top +100;
end;

procedure TFormIncluir.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   action:= cafree;
end;

procedure TFormIncluir.BitBtn1Click(Sender: TObject);
begin
   formincluir.close;
end;

procedure TFormIncluir.MaskEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_return) and(length(maskedit1.text) = 7 ) then
  begin
     consultaItem(Sender);
     bitbtn2.setfocus;
 end;
 form1.msgderodape(floattostr(key));
end;

procedure TFormIncluir.FormKeyPress(Sender: TObject; var Key: Char);
begin
  form1.msgderodape(key);
end;

procedure TFormIncluir.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   form1.msgderodape('enter');

end;

end.


