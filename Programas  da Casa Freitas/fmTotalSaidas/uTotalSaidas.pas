unit uTotalSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit, db,
  StdCtrls, ExtCtrls, adLabelComboBox;

type
  TfmTotalSaidas = class(TForm)
    dt01: TDateTimePicker;
    dt02: TDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    lbDados: TLabel;
    Label3: TLabel;
    lbTotal: TLabel;
    cbLoja: TadLabelComboBox;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure calcularVenda(is_ref, uo:String; inicio, fim: Tdate);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalSaidas: TfmTotalSaidas;
  fmUO, fmIS_REF:String;
implementation

uses uMain,   funcoes, funcsql, uCF;

{$R *.dfm}
procedure TfmTotalSaidas.FormCreate(Sender: TObject);
var
   aux :string;
begin
   fmMain.getListaLojas(cbLoja, false, false, '');
   aux := DateToStr(now-60 );
   delete(aux,01,02);
   insert('01',aux,01);
   dt01.Date := StrToDate(aux);
   dt02.Date := now;
end;

procedure TfmTotalSaidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmTotalSaidas := nil;
end;


procedure TfmTotalSaidas.calcularVenda(is_ref, uo:String; inicio, fim: Tdate);
var
   ds:TdataSet;
   uocd:String;
begin
   uocd := fmMain.GetParamBD('uocd','');

   if (lbDados.Caption = '') then
   begin
      ds:= uCF.getDadosProd(uo, is_ref, '101', true);
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

   if( uo = '') then
      uo := fmMain.getParamBD('uocd','');

   fmUO := UO;
   fmIS_REF := is_ref;

   lbTotal.caption := ucf.getVendaProduto( fmIS_REF, fmUO, uocd, inicio, fim, fmMain.Conexao);
end;


procedure TfmTotalSaidas.FlatButton1Click(Sender: TObject);
begin
   calcularVenda( fmIS_REF, funcoes.getCodUO(cbLoja), dt01.Date, dt02.date);
end;


end.
