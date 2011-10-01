unit uResumoECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, ComCtrls, adLabelComboBox, Grids,
  DBGrids, SoftDBGrid, DB;

type
  TfmResumoECF = class(TForm)
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    cbECF: TadLabelComboBox;
    fsBitBtn3: TfsBitBtn;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    fsBitBtn1: TfsBitBtn;
    procedure fsBitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResumoECF: TfmResumoECF;
  ds:TdataSet;
implementation
{$R *.dfm}
uses uMain, uCF, funcoes;

procedure TfmResumoECF.fsBitBtn3Click(Sender: TObject);
begin
   ds:= uCF.listaCuponsPorLojaData(funcoes.getCodUO(cbLojas), cbECF.Items[cbECF.itemIndex], datai.Date, datai.Date);
   DataSource1.DataSet := ds;
end;

procedure TfmResumoECF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := CaFree;
    fmResumoECF := nil;
end;

procedure TfmResumoECF.FormActivate(Sender: TObject);
begin
   uCF.getListaLojas( cbLojas, false, false, fmMain.getCdPesLogado() );
   datai.Date := now;
end;

procedure TfmResumoECF.fsBitBtn1Click(Sender: TObject);
begin
   fmMain.impressaoRaveQr4(ds, nil, nil, nil, 'rpProCuponsDia', nil);
end;

end.
