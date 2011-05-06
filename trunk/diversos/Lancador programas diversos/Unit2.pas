unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, Mask, DBCtrls, adLabelDBEdit, funcoes,
  adLabelEdit;

type
  TForm2 = class(TForm)
    cbUsaSenha: TfsCheckBox;
    edLocal: TadLabelEdit;
    edRemoto: TadLabelEdit;
    edUser: TadLabelEdit;
    edSenha: TadLabelEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edRemotoDblClick(Sender: TObject);
    procedure edLocalDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    funcoes.WParReg('ProgramasCF\Upgrade','edLocal',edLocal.Text);
    funcoes.WParReg('ProgramasCF\Upgrade','edRemoto',edRemoto.Text);
    funcoes.WParReg('ProgramasCF\Upgrade','edUser',edUser.Text);
    funcoes.WParReg('ProgramasCF\Upgrade','edSenha',edSenha.Text);
    funcoes.WParReg('ProgramasCF\Upgrade','usaSenha',BoolToStr(cbUsaSenha.Checked,false));
end;

procedure TForm2.edRemotoDblClick(Sender: TObject);
begin
   edRemoto.Text := extractFilePath(funcoes.DialogAbrArQ('*','C:\'));
end;

procedure TForm2.edLocalDblClick(Sender: TObject);
begin
   edLocal.Text := extractFilePath(funcoes.DialogAbrArQ('*','C:\'));
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   edLocal.Text := funcoes.RParReg('ProgramasCF\Upgrade','edLocal');
   edRemoto.Text  := funcoes.RParReg('ProgramasCF\Upgrade','edRemoto');
   edUser.Text  := funcoes.RParReg('ProgramasCF\Upgrade','edUser');
   edSenha.Text  := funcoes.RParReg('ProgramasCF\Upgrade','edSenha');
   if funcoes.RParReg('ProgramasCF\Upgrade','usaSenha') <> '' then
      cbUsaSenha.Checked  := StrToBool(funcoes.RParReg('ProgramasCF\Upgrade','usaSenha'));
end;

end.
