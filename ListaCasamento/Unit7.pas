unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, StdCtrls, Mask, DBCtrls,
  adLabelDBEdit, TFlatButtonUnit, ExtCtrls, ADODB;

type
  TForm7 = class(TForm)
    BitBtn6: TFlatButton;
    DBEdit1: TadLabelDBEdit;
    DataSource1: TDataSource;
    DBGrid1: TSoftDBGrid;
    Panel1: TPanel;
    BitBtn3: TFlatButton;
    BitBtn4: TFlatButton;
    BitBtn5: TFlatButton;
    Panel2: TPanel;
    bitbtn2: TFlatButton;
    bitbtn1: TFlatButton;
    dbedit2: TadLabelDBEdit;
    CheckBox1: TCheckBox;
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure habilitaEdits(sender:tobject);
    procedure DesabilitaEdits(sender:tobject);    
    procedure bitbtn1Click(Sender: TObject);
    procedure bitbtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure dbedit2Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm7.BitBtn6Click(Sender: TObject);
begin
   form1.query1.sql.Clear;
   Form7.Close;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
   FormStyle := fsMDIForm;
   Form1.mostraMenu(sender);
end;

procedure TForm7.FormShow(Sender: TObject);
begin
   form1.query1.sql.Clear;
   form1.query1.SQL.Add(' select * from TipoListas order by descricao' );
   form1.query1.Open;
   dbedit1.DataField := 'descricao';
   dbedit2.DataField := 'AceitaNoivo';
end;

procedure TForm7.BitBtn3Click(Sender: TObject);
begin
   form1.Query1.Append;
   habilitaEdits(sender)
end;

procedure TForm7.BitBtn4Click(Sender: TObject);
begin
   form1.Query1.edit;
   habilitaEdits(sender)
end;
procedure TForm7.BitBtn5Click(Sender: TObject);
begin
   form1.query1.Delete;
end;

procedure TForm7.bitbtn1Click(Sender: TObject);
begin
  form1.Query1.Post;
  bitbtn2Click(Sender);
end;

procedure TForm7.bitbtn2Click(Sender: TObject);
begin
   DesabilitaEdits(sender);
   form1.Query1.cancel;
end;

procedure TForm7.habilitaEdits(sender: tobject);
begin
   panel1.Visible := false;
   panel2.Visible := true;
   dbgrid1.Enabled := false;
   dbedit1.enabled:= true;
   checkbox1.enabled:= true;
   dbedit1.setfocus;
end;

procedure TForm7.DesabilitaEdits(sender: tobject);
begin
   panel2.Visible := false;
   panel1.Visible := true;
   dbgrid1.Enabled := true;
   dbedit1.enabled:= false;
   checkbox1.enabled:= false;
end;


procedure TForm7.dbedit2Change(Sender: TObject);
begin
   if  pos('S',dbedit2.Text) > 0 then
      checkBox1.checked := true
   else
      checkBox1.checked := false;         
end;

procedure TForm7.FormResize(Sender: TObject);
begin
   bitbtn6.left := form7.Width - bitbtn6.Width - 10;
   panel1.Left := form7.Width - panel1.Width - 10;
   panel2.Left := form7.Width - panel2.Width - 10;
   dbgrid1.Height :=  form7.Height - panel2.Top - panel2.Height - 80;
end;

end.
