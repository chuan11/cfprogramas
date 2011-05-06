unit uAjusteModPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, fCtrls, StdCtrls, adLabelComboBox;

type
  TfmAjusteModPag = class(TForm)
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    adLabelComboBox1: TadLabelComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjusteModPag: TfmAjusteModPag;

implementation

{$R *.dfm}

end.
