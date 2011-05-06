unit Notificador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdMessage, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, ExtCtrls;

type
  TForm1 = class(TForm)
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.Timer1Timer(Sender: TObject);
var
  msg:tStringList;
begin
  msg := Tstringlist.create();
  msg.Add(' Programa iniciado ');
  msg.Add(' - ' +dateTimeToStr(now) );

  IdMessage.Recipients.EMailAddresses := 'casafreitas@casafreitas.com.br';
  IdMessage.Subject := 'Inicialização do meu computador de casa.';
  IdMessage.Body := msg;

  if ParamStr(1) <> '' then
    IdSMTP.Host := ParamStr(1);

  IdSMTP.Connect;
  try
    IdSMTP.Send(IdMessage);
  finally
    IdSMTP.Disconnect;
  end;
  application.Terminate;
end;



procedure TForm1.FormActivate(Sender: TObject);
begin
label1.Caption := dateTimeToStr(now);
end;

end.
