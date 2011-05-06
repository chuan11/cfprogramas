unit Uforn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, StdCtrls, adLabelEdit,
  TFlatButtonUnit, fCtrls;

type
  TfmForn = class(TForm)
    DataSource1: TDataSource;
    fnGrid: TSoftDBGrid;
    ed: TadLabelEdit;
    BitBtn2: TFlatButton;
    BitBtn3: TFlatButton;
    fsBuscaNumero: TfsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmForn: TfmForn;

implementation
uses unit1;
{$R *.dfm}

procedure TfmForn.FormCreate(Sender: TObject);
begin
   DataSource1.DataSet := form1.QrCredores;
end;

procedure TfmForn.edChange(Sender: TObject);
begin
   if fsBuscaNumero.Checked = true then
      form1.qrCredores.Locate('codigo',ed.text,[loPartialKey])
   else
      form1.qrCredores.Locate('fornecedor',ed.text,[loPartialKey]);
end;

procedure TfmForn.BitBtn2Click(Sender: TObject);
begin
   form1.edit1.Text := form1.qrCredores.fieldByName('codigo').asString;
end;

procedure TfmForn.BitBtn3Click(Sender: TObject);
begin
   fmForn.close;
end;

procedure TfmForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;

end.
