unit uListas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcSql, uUtil,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, StdCtrls, Buttons,
  fCtrls, ExtCtrls;

type
  TfmListas = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    Panel2: TPanel;
    fsBitBtn2: TfsBitBtn;
    fsBitBtn3: TfsBitBtn;

    procedure CarregaHorarios();
    procedure fsBitBtn3Click(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure carregaLocalizacoes();
    procedure gridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListas: TfmListas;

implementation

uses     UmanBat;
{$R *.dfm}

{ TfmListas }



procedure TfmListas.carregaLocalizacoes;
var
   i:integer;
begin
   tb.TableName := 'zcf_pontoLocalizacao';
   tb.Open();

   for i := 0 to tb.FieldCount-1do
      grid.Columns[i].Visible := false;
   grid.Columns[ tb.FieldByName('ds_uo').Index  ].Visible := true;
end;


procedure TfmListas.CarregaHorarios;
var
  i:integer;
  coluna:TColumn;
begin
   tb.TableName := 'zcf_pontoHorarios';
   tb.Filter := 'num > 0';
   tb.Filtered := true;
   tb.Open();
   grid.Columns[ tb.FieldByName('num').Index].Visible := false;


   for i:= 2 to tb.FieldCount -1 do
      grid.Columns[i].Visible := false;
end;

procedure TfmListas.fsBitBtn3Click(Sender: TObject);
begin
   ModalResult := mrOk;
end;

procedure TfmListas.fsBitBtn2Click(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfmListas.gridDblClick(Sender: TObject);
begin
   fsBitBtn3Click(nil);  
end;

end.
