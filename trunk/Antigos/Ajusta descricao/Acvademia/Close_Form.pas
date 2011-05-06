unit Close_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TfrmClose = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Timer2: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClose: TfrmClose;

implementation

{$R *.DFM}

procedure TfrmClose.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmClose.Timer1Timer(Sender: TObject);
var Digito: Integer;
begin
   Digito := StrToInt(label1.Caption);
   label1.Caption := IntToStr(Digito - 1);
   if Digito = 0 then Close;
end;

procedure TfrmClose.Timer2Timer(Sender: TObject);
begin
if label2.Font.Color = clRed then
  label2.Font.Color := clGreen
else
  if label2.Font.Color = clGreen then
   label2.Font.Color := clBlue
  else
   if label2.Font.Color = clBlue then
     label2.Font.Color := clRed
end;

end.
