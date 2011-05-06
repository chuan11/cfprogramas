unit Uforn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, StdCtrls, adLabelEdit,
  TFlatButtonUnit, fCtrls, ADODB;

type
  TfmForn = class(TForm)
    DataSource1: TDataSource;
    fnGrid: TSoftDBGrid;
    edit1: TadLabelEdit;
    BitBtn2: TFlatButton;
    BitBtn3: TFlatButton;
    fsBuscaNumero: TfsCheckBox;
    FlatButton1: TFlatButton;
    qrCredores: TADOQuery;
    procedure edit1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fnGridDblClick(Sender: TObject);
    procedure fsBuscaNumeroClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmForn: TfmForn;

implementation
uses uMain;
{$R *.dfm}

procedure TfmForn.edit1Change(Sender: TObject);
begin
{   if fsBuscaNumero.Checked = true then
      form1.qrCredores.Locate('codigo',edit1.text,[loPartialKey])
   else
      form1.qrCredores.Locate('fornecedor',edit1.text,[loPartialKey]);
      }
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
   //BitBtn2Click(Sender);
end;

procedure TfmForn.fsBuscaNumeroClick(Sender: TObject);
begin
   edit1Change(sender);
end;

procedure TfmForn.FlatButton1Click(Sender: TObject);
var
   cmd:string;
begin
   if fsBuscaNumero.Checked = false then
      cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  nm_razsoc like ' + quotedstr(edit1.text+'%')
   else
      cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  is_cred = ' +  edit1.text ;

   qrCredores.SQL.Clear;
   qrCredores.sql.Add(cmd);
   qrCredores.Open;

end;

end.
