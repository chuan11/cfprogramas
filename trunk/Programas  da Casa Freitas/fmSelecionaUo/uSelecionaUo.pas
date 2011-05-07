unit uSelecionaUo;


interface

implementation

end.


{
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Buttons, fCtrls;

type
  TfmSelecionaUo = class(TForm)
    cbLojas: TadLabelComboBox;
    btIncluiXML: TfsBitBtn;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fmSelecionaUo: TfmSelecionaUo;

implementation
//uses umain, funcSQL, funcoes;

// {$R *.dfm

procedure TfmSelecionaUo.FormCreate(Sender: TObject);
begin
//   fmMain.getListaLojas(cbLojas, false, false, '');
//   cbLojas.Items.add(funcoes.preencheCampo(50,' ','D','Escritorio'));
end;

end.
