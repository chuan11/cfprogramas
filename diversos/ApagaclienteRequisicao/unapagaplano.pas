unit unapagaplano;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,funcsql, StdCtrls, adLabelEdit, DB, ADODB,funcoes;

type
  TForm1 = class(TForm)
    edPedido: TadLabelEdit;
    Button1: TButton;
    Connection: TADOConnection;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   if funcSql.GetValorWell('e','UPDATE dspd set cdpes = 0  WHERE IS_PLANOD = '+ edPedido.text, '@@error', connection ) = '0' then
      msgtela(form1.caption, 'Alteração efetuada',mb_iconExclamation)
   else
      msgtela(form1.caption, 'Alteração efetuada', mb_iconExclamation)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   connection.Connected := false;
   connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   connection.Connected := true;
end;

end.
