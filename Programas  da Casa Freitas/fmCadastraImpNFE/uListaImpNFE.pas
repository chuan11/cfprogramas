unit uListaImpNFE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSelecionaUo, StdCtrls, Buttons, fCtrls, adLabelComboBox;

type
  TfmListaImpNFE = class(TfmSelecionaUo)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaImpNFE: TfmListaImpNFE;

implementation

uses funcSQL, uMain;
{$R *.dfm}

procedure TfmListaImpNFE.FormCreate(Sender: TObject);
var
   cmd:String;
begin
//  inherited;
   cbLojas.LabelDefs.Caption := 'Impressoras';
   cmd :=
   ' select substring(nm_param, 14, 50) as nm_param '+
   ' from zcf_paramGerais where '+
   ' nm_param like ''comum.impNFe_%'' ';
   cbLojas.Items := funcSQL.getListagem(cmd, fmMain.conexao);
end;

end.
