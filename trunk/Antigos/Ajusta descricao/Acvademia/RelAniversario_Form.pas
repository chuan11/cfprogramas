unit RelAniversario_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, Db, DBTables, ExtCtrls;

type
  TfrmRelAniversario = class(TForm)
    QuickRep1: TQuickRep;
    qryAniversario: TQuery;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand3: TQRBand;
    QRlblMes: TQRLabel;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRBand4: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel4: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelAniversario: TfrmRelAniversario;

implementation

{$R *.DFM}

procedure TfrmRelAniversario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
frmRelAniversario := Nil;
end;

end.
