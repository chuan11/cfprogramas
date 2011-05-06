unit InfoSistema_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ColorGrd, StdCtrls, Buttons;

type
  TfrmInfoSistema = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnOK: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfoSistema: TfrmInfoSistema;

implementation

{$R *.DFM}

procedure TfrmInfoSistema.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
frmInfoSistema := Nil;
end;

procedure TfrmInfoSistema.btnOKClick(Sender: TObject);
begin
Close;
end;

end.
