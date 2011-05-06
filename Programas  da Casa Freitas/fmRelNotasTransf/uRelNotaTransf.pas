unit uRelNotaTransf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, ComCtrls, fCtrls, TFlatButtonUnit;

type
  TfmRelNotaTransf = class(TForm)
    cbPreco: TadLabelComboBox;
    data: TfsDateTimePicker;
    fsDateTimePicker1: TfsDateTimePicker;
    lbInicio: TLabel;
    Label1: TLabel;
    adLabelComboBox1: TadLabelComboBox;
    btDadosCliente: TFlatButton;
    FlatButton1: TFlatButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelNotaTransf: TfmRelNotaTransf;

implementation

{$R *.dfm}

end.
