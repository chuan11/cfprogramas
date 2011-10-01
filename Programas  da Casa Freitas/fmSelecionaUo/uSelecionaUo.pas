unit uSelecionaUo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Buttons, fCtrls, DB, ADODB, Grids,
  DBGrids, SoftDBGrid;

type
  TfmSelecionaUo = class(TForm)
    cbLojas: TadLabelComboBox;
    btIncluiXML: TfsBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelecionaUo: TfmSelecionaUo;

implementation

uses uCF;

{$R *.dfm}

{ TfmSelecionaUo }

{ TfmSelecionaUo }

end.
