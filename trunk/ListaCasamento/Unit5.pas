unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Mask,BUTTONS,
  adLabelDBEdit,DBITYPES, TFlatButtonUnit, SoftDBGrid ;

type
  TForm5 = class(TForm)
    DataSource1: TDataSource;
    dbEdit1: TadLabelDBEdit;
    DBGrid1: TSoftDBGrid;
    Panel2: TPanel;
    bitbtn2: TFlatButton;
    bitbtn1: TFlatButton;
    Panel1: TPanel;
    BitBtn3: TFlatButton;
    BitBtn4: TFlatButton;
    BitBtn5: TFlatButton;
    BitBtn6: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure DesabilitaEdits(sender: tobject);
    procedure habilitaEdits(sender: tobject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure bitbtn1Click(Sender: TObject);
    procedure bitbtn2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}
type TDBNewNavigator = class(TDBNavigator);

procedure TForm5.FormCreate(Sender: TObject);
begin
   form1.query1.sql.Clear;
   form1.query1.SQL.Add(' select * from tipoprodutos' );
   form1.query1.active := true;

   dbedit1.DataField := 'descricao';
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
   FormStyle := fsMDIForm;
   Form1.mostraMenu(sender);
end;

procedure TForm5.BitBtn6Click(Sender: TObject);
begin
   form1.Table1.Close;
   close;
end;

procedure TForm5.habilitaEdits(sender: tobject);
begin
   panel1.Visible := false;
   panel2.Visible := true;
   dbgrid1.Enabled := false;
   dbedit1.enabled:= true;
   dbedit1.setfocus;
end;

procedure TForm5.DesabilitaEdits(sender: tobject);
begin
   panel2.Visible := false;
   panel1.Visible := true;
   dbgrid1.Enabled := true;
   dbedit1.enabled:= false;
end;


procedure TForm5.BitBtn3Click(Sender: TObject);
begin
   form1.Query1.Append;
   habilitaEdits(sender)
end;

procedure TForm5.BitBtn4Click(Sender: TObject);
begin
   form1.Query1.edit;
   habilitaEdits(sender)
end;
procedure TForm5.BitBtn5Click(Sender: TObject);
begin
   form1.query1.Delete;
end;

procedure TForm5.bitbtn1Click(Sender: TObject);
begin
  form1.Query1.Post;
  bitbtn2Click(Sender);
end;

procedure TForm5.bitbtn2Click(Sender: TObject);
begin
   DesabilitaEdits(sender);
   form1.Query1.cancel;
end;

procedure TForm5.FormResize(Sender: TObject);
begin
   bitbtn6.left := form5.Width - bitbtn6.Width - 12;
   panel1.Left := form5.Width - panel1.Width - 12;
   panel2.Left := form5.Width - panel2.Width - 12;
   dbgrid1.Height :=  form5.Height - panel2.Top - panel2.Height - 112;
end;

end.
