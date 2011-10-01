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
uses uMain, funcoes;
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

procedure TfmForn.fsBuscaNumeroClick(Sender: TObject);
begin
   edit1Change(sender);
end;

procedure TfmForn.FlatButton1Click(Sender: TObject);
var
   cmd:string;
begin
   if (fsBuscaNumero.Checked = false) then
      cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  nm_razsoc like ' + quotedstr(edit1.text+'%')
   else
      if (funcoes.SohNumeros(edit1.Text) <> '') then
         cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  is_cred = ' +  edit1.text ;

  if (cmd <> '') then
  begin
     qrCredores.SQL.Clear;
     qrCredores.sql.Add(cmd);
     qrCredores.Open;

     fnGrid.Columns[ qrCredores.FieldByName('codigo').Index  ].Visible := false;
     fnGrid.Columns[ qrCredores.FieldByName('is_cred').Index  ].Title.Caption := 'Cod fornecedor';
  end;
  
end;

end.
