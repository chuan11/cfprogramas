unit RelMensalidades_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Qrctrls, QuickRpt, DBTables, ExtCtrls;

type
  TfrmRelMensalidades = class(TForm)
    QuickRep1: TQuickRep;
    qryMensalidade: TQuery;
    qryMensalidadeModalidade: TStringField;
    qryMensalidadeMensalidade: TFloatField;
    QRBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelMensalidades: TfrmRelMensalidades;

implementation

{$R *.DFM}

procedure TfrmRelMensalidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmRelMensalidades := Nil;
end;

end.
