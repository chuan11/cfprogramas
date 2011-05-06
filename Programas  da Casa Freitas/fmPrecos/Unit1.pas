unit Unit1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,funcoes,
  Buttons, dialogs;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

uses Uprecoswell;

{$R *.dfm}

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
   PasswordDlg.Close;
end;

procedure TPasswordDlg.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   action := CaFree;
end;

end.

