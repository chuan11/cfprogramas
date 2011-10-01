unit uTipoImpGeraEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, fCtrls;

type
  TfmTipoImpressaoGera = class(TForm)
    rgTpImpressao: TRadioGroup;
    btIncluiXML: TfsBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTipoImpressaoGera: TfmTipoImpressaoGera;

implementation

{$R *.dfm}

procedure TfmTipoImpressaoGera.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
end;

end.
