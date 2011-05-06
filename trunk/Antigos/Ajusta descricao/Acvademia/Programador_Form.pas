unit Programador_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShellApi;

type
  TfrmProgramador = class(TForm)
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Shape1: TShape;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgramador: TfrmProgramador;

implementation

{$R *.DFM}

procedure TfrmProgramador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := cafree;
frmProgramador := Nil;
end;

procedure TfrmProgramador.Label5Click(Sender: TObject);
begin
ShellExecute(Handle,'open','mailto:delphicompany@ieg.com.br?subject= Sistema Academia', '', '',SW_SHOW);
end;

procedure TfrmProgramador.Label7Click(Sender: TObject);
begin
ShellExecute(Handle,'open','mailto:fernando_goncalves@ig.com.br?subject= Sistema Academia', '', '',SW_SHOW);
end;

procedure TfrmProgramador.Label1Click(Sender: TObject);
begin
ShellExecute(Handle,'Open','www.delphicompany.hpg.com.br','','',SW_SHOW);
end;

procedure TfrmProgramador.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
Key := #0;
end;

procedure TfrmProgramador.BitBtn1Click(Sender: TObject);
begin
Close;
end;

end.
