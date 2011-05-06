unit uSelecionaUo;

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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelecionaUo: TfmSelecionaUo;

implementation
uses umain, funcSQL, funcoes;

{$R *.dfm}

procedure TfmSelecionaUo.FormCreate(Sender: TObject);
begin
   fmMain.getListaLojas(cbLojas, false, false, '');
   cbLojas.Items.add(funcoes.preencheCampo(50,' ','D','Escritorio'));
end;

end.
