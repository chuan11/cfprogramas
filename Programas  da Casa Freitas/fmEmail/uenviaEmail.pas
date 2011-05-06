unit uEnviaEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, ADODB,
  IdTCPClient, IdMessageClient, IdSMTP, IdIOHandler, IdIOHandlerSocket,
  IdSSLOpenSSL, IdMessage, funcoes, funcsql, Buttons, ExtCtrls;

type
  TfmEnviaEmail = class(TForm)
    IdSMTP: TIdSMTP;
    Memo1: TMemo;
    socket: TIdSSLIOHandlerSocket;
    msg: TIdMessage;
    Panel1: TPanel;
    Bevel1: TBevel;
    procedure IdSMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure socketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    function enviarEmailGmail(uo,  para,assunto,anexo:String; corpoMsg:Tstringlist; conexao:TADOConnection; titulo,pesSender:String):boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getMailDestino(conexao:TADOConnection; uo:String):String;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEnviaEmail: TfmEnviaEmail;

implementation

uses uDestinoEmail, uMain;
{$R *.dfm}

function TfmEnviaEmail.getMailDestino(conexao:TADOConnection; uo:String):String;
var
   str:String;
begin
   application.CreateForm(TfmDestEmail, fmDestEmail);
   fmDestEmail.ShowModal;

   str := '';
   if (fmDestEmail.ModalResult = MROK) then
   begin
      str := fmDestEmail.lbEmail.Caption;
      if pos('@',str) = 0 then
         str := '';
   end;
   result := str
end;

procedure TfmEnviaEmail.IdSMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
   memo1.Lines.Add(AStatusText);
end;

procedure TfmEnviaEmail.socketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
   memo1.Lines.Add(AStatusText);
end;


function TfmEnviaEmail.enviarEmailGmail(uo, para, assunto, anexo: String; corpoMsg: Tstringlist;
                                      conexao: TADOConnection; titulo, pesSender:String ):boolean;
var
  i:integer;
  nmRemetente:String;
begin
   fmEnviaEmail.Show;
   if (para  = '') then
      para := getMailDestino(Conexao, uo);

   if (trim(para) <> '') then
   begin
      screen.Cursor := crHourGlass;

      memo1.Lines.add( 'E-mail para :' + para);
      panel1.Caption := titulo;
      fmEnviaEmail.Refresh();

      nmRemetente := funcSQL.openSQL('Select ds_email from dsusu (nolock) where cd_pes = '+ pesSender, 'ds_email', conexao);

      if (pos('@', nmRemetente) = 0 ) then
         nmRemetente := funcsql.getEmail(uo, conexao);

      if (pos('@', nmRemetente) = 0 ) then
         nmRemetente := uo+'@casafreitas.com.br';

      Memo1.Lines.add('Remetente: ' + nmRemetente );

      with msg do
      begin
         Create(nil);
         if corpoMsg <> nil then
            for i:=0 to corpoMsg.Count -1 do
               Body.Add(corpoMsg[i]);
         From.Address := nmRemetente;
         From.Name := nmRemetente;
         Recipients.Add;
         Recipients.Items[0].Address := para;
         Recipients.Items[0].Name := para;
         Subject := assunto
      end;

      if anexo <> '' then
         TIdAttachment.create(msg.MessageParts, TFileName(anexo));
      try
         idsmtp.Connect();
         idsmtp.Send(msg);
         Memo1.Lines.add('');
         Memo1.Lines.add('E-mail enviado para: ' + para,   );
         Memo1.Lines.add('');
         idsmtp.Disconnect;
         sleep(500);
         result := true;
      except
         on e:Exception do
         begin
            sleep(500);
            msgtela('',#13+'   Ocorreu um erro ao enviar o e-mail, o erro foi:   ' +#13+#13+  e.message, 16 + 0 );
            result := false;
         end;
      end;

    end
    else
    begin
       msgtela('',#13+'O endereço é inválido ou não foi preenchido. ' +#13+#13, 16 + 0 );
       result := false;
    end;
   fmEnviaEmail.Close();
   screen.Cursor := 0;
end;


procedure TfmEnviaEmail.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   fmEnviaEmail := nil;
   action := caFree;
end;

end.
