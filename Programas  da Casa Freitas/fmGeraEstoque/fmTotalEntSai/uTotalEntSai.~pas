unit uTotalEntSai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB;

type
  TfmTotalEntSai = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    lbPrimEnt: TLabel;
    Label5: TLabel;
    lbTotEnt: TLabel;
    Label6: TLabel;
    lbTotVenda: TLabel;
    Bevel1: TBevel;
    lbDados: TLabel;

  procedure calculaTotalEntSai(is_ref, uo, uo_cd:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalEntSai: TfmTotalEntSai;

implementation

{$R *.dfm}

uses uMain, uCF, funcSQL, funcoes;

{ TfmTotalEntSai }


procedure TfmTotalEntSai.calculaTotalEntSai(is_ref, uo, uo_cd: String);
var
   ds:TdataSet;
   dataI:Tdate;
   strTotSaida:String;
begin
   if (lbDados.Caption = '') then
   begin
      ds:= uCF.getDadosProd(uo_cd, is_ref, '101', true);
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

// parte das entradas
   ds:= uCF.getEntradasPorItem(is_ref, uo);
   if (ds.isEmpty = false) then
   begin
      ds.last();
      lbPrimEnt.Caption := ds.fieldByName('data').AsString;
      lbTotEnt.Caption :=  funcSQL.somaColTable(ds, 'quant');
   end
   else
   begin
      lbTotEnt.caption := '00000000';
      lbPrimEnt.Caption := 'Não há';
   end;

// saidas
   datai:= strToDate('01/01/2000');
   strTotSaida := ucf.getVendaProduto(is_ref, uo, UO_CD, dataI, now);
   lbTotVenda.Caption:= floatTostrf(  strToFloat(strTotSaida), ffnumber, 18, 2);
end;
procedure TfmTotalEntSai.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
    fmTotalEntSai:= nil;
end;

end.
