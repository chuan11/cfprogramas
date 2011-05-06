unit Unit1;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, RLReport, RLBarcode, StdCtrls,clipbrd;

type
  TForm1 = class(TForm)
    RLReport1: TRLReport;
    Edit1: TEdit;
    RLImage2: TRLImage;
    RLAngleLabel1: TRLAngleLabel;
    Label1: TLabel;
    RLBarcode2: TRLBarcode;
    RLBarcode1: TRLBarcode;
    Edit2: TEdit;
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure montarrelatorio(sender:tobject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure RLReport1AfterPrint(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function gerasenha:string;
const caract = 'abcdefghijklmnopqrstuvxzABCDEFGHIJKLMNOPRSTUVXZ';
var
   aux:string;
   i:integer;
begin
   AUX:='';
   randomize;
   for i:=1 to 10 do
      aux := aux + caract[random(length(caract)-1)];
   gerasenha :=  aux;
end;

procedure tform1.montarrelatorio(sender:tobject);
begin
   rlanglelabel1.Caption := edit1.text;
   RLBarcode1.Caption := EDIT2.TEXT;//gerasenha();
   RLBarcode2.Caption := edit1.text;
   Clipboard.AsText := RLBarcode1.Caption ;
   rlreport1.Preview;

end;


procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
     if edit1.text = '' then
        showmessage( 'falta o nome do gerente')
     else
        montarRelatorio(sender);
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
      edit1.setfocus;
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
  form1.Height := 120 ;
end;

procedure TForm1.RLReport1AfterPrint(Sender: TObject);
begin
   application.MessageBox(' A senha foi copiada para a area de transferencia',pchar(Clipboard.AsText),mb_ok + mb_iconexclamation);
end;

end.
