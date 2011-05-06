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
    edit1: TadLabelEdit;
    BitBtn2: TFlatButton;
    BitBtn3: TFlatButton;
    fsBuscaNumero: TfsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edit1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fnGridDblClick(Sender: TObject);
    procedure fsBuscaNumeroClick(Sender: TObject);
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
   if form1.qrCredores.IsEmpty = true then
     form1.Listarfornecedores(nil);
end;

procedure TfmForn.edit1Change(Sender: TObject);
begin
   if fsBuscaNumero.Checked = true then
      form1.qrCredores.Locate('codigo',edit1.text,[loPartialKey])
   else
      form1.qrCredores.Locate('fornecedor',edit1.text,[loPartialKey]);
end;

procedure TfmForn.BitBtn2Click(Sender: TObject);
begin
   form1.adicionaFornecedor(Sender);
   BitBtn3Click(nil);
end;

procedure TfmForn.BitBtn3Click(Sender: TObject);
begin
   fmForn.close;
end;

procedure TfmForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;

procedure TfmForn.fnGridDblClick(Sender: TObject);
begin
   BitBtn2Click(Sender);
end;

procedure TfmForn.fsBuscaNumeroClick(Sender: TObject);
begin
   edit1Change(sender);
end;

end.
