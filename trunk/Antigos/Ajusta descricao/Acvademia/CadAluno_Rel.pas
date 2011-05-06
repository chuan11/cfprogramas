unit CadAluno_Rel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, Db, DBTables, ExtCtrls;

type
  TfrmRelCadAlu = class(TForm)
    QuickRep1: TQuickRep;
    qryAlu: TQuery;
    qryAluCOD_ALU: TIntegerField;
    qryAluNOME: TStringField;
    qryAluENDERECO: TStringField;
    qryAluBAIRRO: TStringField;
    qryAluCIDADE: TStringField;
    qryAluESTADO: TStringField;
    qryAluTELEFONE: TStringField;
    qryAluCEP: TStringField;
    qryAluRG: TStringField;
    qryAluCPF: TStringField;
    qryAluDATA_NASC: TDateTimeField;
    qryAluDATA_CAD: TDateTimeField;
    qryAluOBS: TMemoField;
    qryAluCOD_MOD1: TIntegerField;
    qryAluCOD_MOD2: TIntegerField;
    qryAluCOD_MOD3: TIntegerField;
    qryAluCOD_MOD4: TIntegerField;
    qryAluCOD_MOD5: TIntegerField;
    qryAluCOD_MOD6: TIntegerField;
    qryAluDATA_VENC: TDateTimeField;
    qryAluVLR_DEVIDO: TFloatField;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadAlu: TfrmRelCadAlu;

implementation

uses CadCliente_Form;

{$R *.DFM}

procedure TfrmRelCadAlu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
frmRelCadAlu := Nil;
end;

procedure TfrmRelCadAlu.FormCreate(Sender: TObject);
begin
qryAlu.Open;
end;

end.
