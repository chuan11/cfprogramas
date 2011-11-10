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
    function getMailDestino(conexao:TADOConnection; uo:String; var para:String; var Texto:TstringList):String;

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

function TfmEnviaEmail.getMailDestino(conexao:TADOConnection; uo:String;
                                      var para:String; var texto:TstringList):String;
var
   str:String;
   i:integer;
begin
   application.CreateForm(TfmDestEmail, fmDestEmail);
   fmDestEmail.mmCorpoEmail.Lines := Texto;

   fmDestEmail.ShowModal;
   str := '';
   if (fmDestEmail.ModalResult = MROK) then
   begin
      str := fmDestEmail.lbEmail.Caption;
      if pos('@',str) = 0 then
         str := '';
   end
   else
      str := '';

   para := str;
   texto.Clear();

   for i:=0 to fmDestEmail.mmCorpoEmail.Lines.Count -1 do
      texto.Add(fmDestEmail.mmCorpoEmail.Lines[i]);

   fmDestEmail.Free();
   fmDestEmail := nil;
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

   if (para  = '') then
      getMailDestino(Conexao, uo, para, corpoMsg);

   if (trim(para) <> '') then
   begin
      screen.Cursor := crHourGlass;

      IdSMTP.Username := fmMain.getParamBD('comum.emailUser', '0');
      IdSMTP.Password := fmMain.getParamBD('comum.emailpassword', '0');

      fmEnviaEmail.memo1.Lines.add('E-mail para: '+ para);
      fmEnviaEmail.panel1.Caption := titulo;
      fmEnviaEmail.Refresh();

      if (pos('@', nmRemetente) = 0 ) then
         nmRemetente := funcsql.getEmail(uo, conexao);

      if (pos('@', nmRemetente) = 0 ) then
         nmRemetente := uo+ fmMain.getParamBD('comum.emailNomedominio', '');

      fmEnviaEmail.Memo1.Lines.add('Remetente: ' + nmRemetente );
      with fmEnviaEmail.msg do
      begin
         Create(nil);
         if (corpoMsg <> nil) then
            for i:=0 to corpoMsg.Count -1 do
               Body.Add(corpoMsg[i]);

         From.Address := nmRemetente;
         From.Name := nmRemetente;
         Recipients.Add;
         Recipients.Items[0].Address := para;
         Recipients.Items[0].Name := para;
         Subject := assunto
      end;

      if (anexo <> '' )then
      begin
         Memo1.Lines.add('Adicionando anexos...');
         TIdAttachment.create(fmEnviaEmail.msg.MessageParts, TFileName(anexo));
      end;

      try
         fmEnviaEmail.idsmtp.Connect();
         fmEnviaEmail.idsmtp.Send(fmEnviaEmail.msg);
         fmEnviaEmail.Memo1.Lines.add('');
         fmEnviaEmail.Memo1.Lines.add('E-mail enviado para: ' + para,   );
         fmEnviaEmail.Memo1.Lines.add('');
         fmEnviaEmail.idsmtp.Disconnect;
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
end;


procedure TfmEnviaEmail.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   action := caFree;
end;

end.
