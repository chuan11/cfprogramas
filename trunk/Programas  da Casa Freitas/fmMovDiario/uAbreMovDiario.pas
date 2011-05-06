unit uAbreMovDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, ComCtrls, Buttons;

type
  TfmDialogMov = class(TForm)
    fsDateTimePicker1: TfsDateTimePicker;
    cbLoja: TfsComboBox;
    Label2: TLabel;
    Label1: TLabel;
    btOk: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDialogMov: TfmDialogMov;

implementation

{$R *.dfm}

end.
