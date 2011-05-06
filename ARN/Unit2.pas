unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, ComCtrls,funcoes, StdCtrls,
  Buttons, Mask, DBCtrls, ADODB, adLabelDBDateTimePicker, ExtCtrls;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure baixarItem(sender:TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Retraida:boolean;
implementation
uses unit1;
{$R *.dfm}

procedure TForm2.DBGrid1DblClick(Sender: TObject);
begin
    BitBtn1.Enabled := true;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
   if Retraida = true then
   begin
      form2.Height := form2.Height +250;
      dbgrid1.Height := dbgrid1.Height + 250;
      panel1.top := panel1.top  + 250;
      bitbtn2.Caption := 'Expande';
      Retraida:= false;
   end
   else
   begin
      dbgrid1.Height := dbgrid1.Height - 250;
      panel1.Top := panel1.Top - 250;
      form2.Height := form2.Height -250;
      bitbtn2.Caption := 'Retrai';
      Retraida:= true;      
   end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form1.SalvaColDbgrid('form2',DBGRID1);
   action := cafree;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  form2.Left := screen.DesktopWidth-form2.Width-20;
  form2.Top:=-2;
  form2.Caption := form1.MainMenu1.Items[0].Caption;
  form2.Top:= form1.top;
  Retraida:= true;
end;

procedure TForm2.baixarItem(sender: TObject);
begin
   with adoquery2.sql do
   begin
      clear;
      add('update agenda');
      add('Set recebida = "1" ');
      add('where  ref = '+ dbgrid1.Fields[0].AsString);
   end;
   if checkbox1.Checked = true then
   begin
      if application.MessageBox('Confirma baixa ???',pchar(TITULO),mb_YesNo + MB_iconquestion) = mryes then
         adoquery2.ExecSQL
   end
   else
      adoquery2.ExecSQL;

   form1.adoTable1.refresh;
   adoquery1.Refresh;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
   try
      baixarItem(sender);
   except
      application.MessageBox('Escolha antes um item.                ' ,pchar(TITULO),mb_Ok + MB_iconError)
   end;
end;

procedure TForm2.DateTimePicker1Change(Sender: TObject);
var
   i:integer;
begin
   adoquery1.Filter := 'prevchegada = ' + DateToStr(DateTimePicker1.date);
   adoquery1.Filtered := true;
   adoquery1.Open;
   adoquery1.Refresh;
   dbgrid1.Columns[0].Visible := false;
   FORM1.LerColunasDbgrid('form2',DBGRID1)
end;

end.
