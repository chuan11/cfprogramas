unit CompFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, TFlatButtonUnit, ComCtrls, fCtrls;

type
  TForm1 = class(TForm)
    cbEmpresa: TadLabelComboBox;
    dataf: TfsDateTimePicker;
    cbTpRel: TadLabelComboBox;
    FlatButton1: TFlatButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
