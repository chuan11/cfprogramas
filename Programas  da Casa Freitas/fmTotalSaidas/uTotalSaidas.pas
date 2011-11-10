unit uTotalSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit, db,
  StdCtrls, ExtCtrls, adLabelComboBox, Grids, DBGrids, SoftDBGrid;

type
  TfmTotalSaidas = class(TForm)
    dt01: TDateTimePicker;
    dt02: TDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbTotal: TLabel;
    cbLoja: TadLabelComboBox;
    Bevel1: TBevel;
    Panel1: TPanel;
    Label4: TLabel;
    lbDados: TLabel;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure calcularVenda(is_ref, uo:String; inicio, fim: Tdate);
    procedure ajustaDataInicio(data:Tdate);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalSaidas: TfmTotalSaidas;
  fmIS_REF:String;
implementation

uses uMain,   funcoes, funcsql, cf;

{$R *.dfm}
procedure TfmTotalSaidas.FormCreate(Sender: TObject);
begin
   cf.getListaLojas( cbLoja, true, false, '');
end;

procedure TfmTotalSaidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmTotalSaidas := nil;
end;

procedure TfmTotalSaidas.calcularVenda(is_ref, uo:String; inicio, fim: Tdate);
var
   ds:TdataSet;
begin
   if (lbDados.Caption = '') then
   begin
      ds:= cf.getDadosProd(uo, '', is_ref, '101', false);
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

   fmIS_REF := is_ref;

   ds:= cf.getVdItemDetPorLojaPeriodo(is_ref, uo, fmMain.getUOCD(), inicio, fim);

   dataSource1.DataSet := ds;
   lbTotal.caption := funcSQL.somaColTable(ds, 'qt_mov', true);

   grid.Columns[ ds.FieldByName('qt_mov').Index ].Title.Caption := 'Quantidade';
end;


procedure TfmTotalSaidas.FlatButton1Click(Sender: TObject);
begin
   calcularVenda( fmIS_REF, funcoes.getCodUO(cbLoja), dt01.Date, dt02.date);
end;

procedure TfmTotalSaidas.ajustaDataInicio(data: Tdate);
begin
   dt01.Date := data;
   dt02.Date := now;
end;

end.
