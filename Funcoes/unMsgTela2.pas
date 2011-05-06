unit unMsgTela2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls;

type
  TfmMsgTela2 = class(TForm)
    btCancel: TfsBitBtn;
    btOk: TfsBitBtn;
    lbMsg: TLabel;
    lbMsg2: TLabel;
    Label1: TLabel;
    procedure preparaParaExibir(titulo,msg:String; icone:integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgTela2: TfmMsgTela2;

implementation

{$R *.dfm}

procedure TfmMsgTela2.preparaParaExibir(titulo, msg: String; icone:integer);
begin
   fmMsgTela2.Top := Application.MainForm.Top + 10;
   fmMsgTela2.Left := Application.MainForm.Left + 10;
   fmMsgTela2.Position := poMainFormCenter;
   fmMsgTela2.BorderStyle := bsDialog;
   fmMsgTela2.Caption := titulo;
   fmMsgTela2.lbMsg.caption := copy(msg,01,27);
   fmMsgTela2.lbMsg2.caption := copy(msg,28,25);

   if (icone = 0) or (icone = mb_ok) then
   begin
      btCancel.Visible := false;
      label1.Caption := '';
      btOk.Left := btCancel.Left;
   end;
end;

procedure TfmMsgTela2.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (UpperCase(key) = 'S') then
     ModalResult := mrOk;
   if (UpperCase(key) = 'N') then
     ModalResult := mrCancel;
end;

end.
