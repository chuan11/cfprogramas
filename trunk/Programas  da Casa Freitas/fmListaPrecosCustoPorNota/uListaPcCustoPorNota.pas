unit uListaPcCustoPorNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, umain, funcoes, funcSQL, StdCtrls,
  Buttons, fCtrls, DB, ADODB, adLabelEdit;

type
  TFrame1 = class(TFrame)
    SoftDBGrid1: TSoftDBGrid;
    Edit1: TadLabelEdit;
    tb: TADOTable;
    btCalc: TfsBitBtn;
    procedure btCalcClick(Sender: TObject);
    procedure criaTabela();

      private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame1.btCalcClick(Sender: TObject);
begin
    criaTabela();

end;

procedure TFrame1.criaTabela;
var
  cmd:String;
begin
    if (tb.IsEmpty = false) then
       tb.Close;
    cmd := 'is_ref int, cd_Ref varchar(08), ds_ref, varchar(50), pc_01 money, pc_02 money';
     funcsql.getTable(fmMain.Conexao, tb, cmd);
end;

end.
