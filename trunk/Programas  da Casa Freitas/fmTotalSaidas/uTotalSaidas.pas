unit uTotalSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit,funcoes, funcsql,
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
    procedure calcularVenda(is_ref, uo:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalSaidas: TfmTotalSaidas;
  fmUO, fmIS_REF:String;
implementation

uses uMain;

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


procedure TfmTotalSaidas.calcularVenda(is_ref, uo:String);
var
   lst:TStrings;
begin
   if( uo = '') then
      uo := '10033674';

   fmUO := UO;
   fmIS_REF := is_ref;
   lst := funcsql.GetValoresSQL(lst, ' Select crefe.cd_ref, crefe.ds_ref,  dbo.Z_CF_funObterVendaPorPeriodo( '+ fmUO +' , '+
                                      fmIS_REF   +' , '+
                                      funcoes.DateTimeToSqlDateTime(dt01.Date,'')   +', '+
                                      funcoes.DateTimeToSqlDateTime(dt02.Date,'')   +', '+
                                      funcoes.DateTimeToSqlDateTime(now -90,'') +' , ' + '10033674 '+
                                      ' ) as Quantidade from crefe (nolock) where is_ref = ' + fmIS_REF, fmMain.Conexao );
   if lst.Count > 0 then
   begin
      lbDados.Caption := lst[0] + '  ' + lst[1]; ;
      lbTotal.Caption := lst[2];
   end;
end;


procedure TfmTotalSaidas.FlatButton1Click(Sender: TObject);
begin
   calcularVenda(fmIS_REF, funcoes.getCodUO(cbLoja));
end;


end.
