unit uAlteraModalidadePagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelNumericEdit, adLabelComboBox,
  TFlatButtonUnit, adLabelSpinEdit;

type
  TfmAlteraModPagto = class(TForm)
    edValor: TadLabelNumericEdit;
    cbModalidades: TadLabelComboBox;
    edNumParcelas: TadLabelSpinEdit;
    btOk: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAlteraModPagto: TfmAlteraModPagto;

implementation

uses uRemoveRegTEF, funcoes, funcSQL, uCF;

{$R *.dfm}

procedure TfmAlteraModPagto.FormCreate(Sender: TObject);
begin
   cbModalidades.Items := uCF.getCodModalidadesPagamento(false);
   edValor.Value :=  fmRemRegTEF.tb.fieldByName('valor').asFloat;
   edNumParcelas.Value := fmRemRegTEF.tb.fieldByName('numParcelas').asFloat;
end;

procedure TfmAlteraModPagto.btOkClick(Sender: TObject);
begin
   fmAlteraModPagto.ModalResult := mrOk;
end;





end.
