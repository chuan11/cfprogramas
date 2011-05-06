unit UpcoAlteradoPorPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox,funcsql, DB, ADODB,  RpCon,
  TFlatButtonUnit, ComCtrls,funcoes,
  Grids, DBGrids, fCtrls, uMain  ;

type
  TfmPrecosAlterados = class(TForm)
    cbLojas: TadLabelComboBox;
    cbPreco: TadLabelComboBox;
    Label1: TLabel;
    FlatButton1: TFlatButton;
    qr: TADOQuery;
    dp1: TfsDateTimePicker;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrecosAlterados: TfmPrecosAlterados;

implementation

uses uCF;

{$R *.dfm}

procedure TfmPrecosAlterados.FlatButton1Click(Sender: TObject);
var
   param:Tstringlist;
begin
   fmMain.MsgStatus('Verificando as alterações de preço....');
   Screen.Cursor := crhourglass;

   uCF.listarPrecosAlteradosPoPeriodo( qr,
                                       funcoes.getCodUO(cbLojas),
                                       fmMain.getCodPreco(cbPreco),
                                       dp1.Date
                                     );

   if  qr.IsEmpty = false then
   begin
      param := TStringList.create();
      param.add(fmMain.getDescUO(cbLojas) );
      param.add(fmMain.getDescPreco(cbPreco));
      param.add(dateToStr(dp1.Date));
      fmMain.impressaoRaveQr(qr, 'rpRPVAL', param);
   end
   else
      msgTela('','Não há reajuste deste tipo de preço nesse dia para essa loja',mb_iconError+mb_Ok);
   fmMain.MsgStatus ('');
end;

procedure TfmPrecosAlterados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.salvaCampos(fmPrecosAlterados);
   action := caFree;
   fmPrecosAlterados := nil;
end;

procedure TfmPrecosAlterados.FormActivate(Sender: TObject);
begin
//   cbLojas.items :=  funcsql.GetNomeLojas(fmMain.Conexao , False, false, fmMain.lbPes.Caption,'');

   fmMain.getListaLojas(cbLojas, false, false, fmMain.getCdpesLogado() );

   cbPreco.items :=  funcsql.getListaPrecos(fmMain.Conexao,false, false, true, fmMain.getGrupoLogado() );
   dp1.Date := now();
   fmMain.getParametrosForm(fmPrecosAlterados);
end;

end.
