unit uEmail;

interface
  uses dialogs, forms, Classes, SysUtils, IdBaseComponent, IdComponent, messages,ADODB,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdMessage, funcoes, IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL, funcSQl;

  procedure enviarEmail( para,assunto,anexo:String; corpoMsg:Tstringlist; conexao:TADOConnection);
  procedure enviarEmailGmail( para,assunto,anexo:String; corpoMsg:Tstringlist; conexao:TADOConnection; uoSender, pesSender:String);
  function  getMailDestino(conexao:TADOConnection):String;


implementation
uses uMain, uDestinoEmail;


procedure enviarEmail( para,assunto,anexo:String; corpoMsg:Tstringlist; conexao:TADOConnection);
var
  msg:TIdMessage;
  idsmtp : TIdSMTP;
  Socket : TidSSLIOHandlerSocket;
  i:integer;
begin
   if para  = '' then
       para := getMailDestino(Conexao);

   if para <> '' then
   begin
      screen.Cursor := -11;
      Socket := TidSSLIOHandlerSocket.Create(nil);
      Socket.SSLOptions.Method := sslvTLSv1;
      Socket.SSLOptions.Mode := sslmClient;

      idsmtp := TIdSMTP.Create(nil);
      with idsmtp do
      begin
         host:= '125.4.4.254';
         Username :='programasCF';
         Password :='123456';
         Port := 587;
         idsmtp.AuthenticationType := atLogin;
         idsmtp.MailAgent := '125.4.4.254';
         IOHandler := Socket;
      end;
      msg :=  TIdMessage.Create(nil);
      with msg do
      begin
         Create(nil);
         if corpoMsg <> nil then
            for i:=0 to corpoMsg.Count -1 do
               Body.Add(corpoMsg[i]);
         From.Address := 'programascf@casafreitas.com.br'; //opcional
         From.Name := 'Casa Freitas'; //opcional
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
         msgTela('','E-mail enviado com sucesso para: ' +#13+ para, 0  );
         idsmtp.Disconnect;
      except
         on e:Exception do
            msgtela('',#13+'   Ocorreu um erro ao enviar o e-mail, o erro foi:   ' +#13+#13+  e.message, 16 + 0 );
      end;
    end
    else
       msgtela('',#13+'Não foi enviado nenhum email' +#13+#13, 16 + 0 );

   screen.Cursor := 0;
end;

function  getMailDestino(conexao:TADOConnection):String;
var
   str:String;
begin
   application.CreateForm(TfmDestEmail, fmDestEmail);
//   fmDestEmail.cbLoja.Items := funcsql.GetNomeLojas(conexao, false,false,'','');

   fmMain.getListaLojas(fmDestEmail.cbLoja, false, false, '' );

   fmDestEmail.cbLoja.ItemIndex := 0;
   fmDestEmail.ShowModal;

   if fmDestEmail.ModalResult  <> 0 then
   begin
      str := fmDestEmail.edMail.Text;
      if str = '' then str := '0';
      if pos('@',str) = 0 then
         str := funcsql.openSQL('Select email from zcf_tbuo (NOLOCK) where is_uo = ' + str , 'email',conexao);
      result := str;
   end
   else
   msgTela('', 'Cancelado pelo usuário', 0);
end;


procedure enviarEmailGmail( para,assunto,anexo:String; corpoMsg:Tstringlist; conexao:TADOConnection;uoSender,pesSender:String);
var
  msg:TIdMessage;
  idsmtp : TIdSMTP;
  Socket : TidSSLIOHandlerSocket;
  i:integer;
  nmRemetente:String;
begin
   nmRemetente :=  funcsql.openSQL('Select ds_email from dspes where cd_pes = ' + pesSender, 'ds_email', conexao );
   if nmRemetente = '' then
      nmRemetente := funcSQL.getEmail(uoSender , conexao)
   else
      nmRemetente := 'emailnaoDefinido@casafreitas.com.br';


   if para  = '' then
       para := getMailDestino(Conexao);

   if para <> '' then
   begin
      screen.Cursor := -11;
      Socket :=  TidSSLIOHandlerSocket.Create(nil);
      Socket.SSLOptions.Method := sslvTLSv1;
      Socket.SSLOptions.Mode := sslmClient;
      Socket.SSLOptions.VerifyMode := [];
      Socket.SSLOptions.VerifyDepth := 0;

      idsmtp := TIdSMTP.Create(nil);
      with idsmtp do
      begin
         host:= 'smtp.gmail.com';
         AuthenticationType := atLogin;
         Username :='casafreitas@casafreitas.com.br';
         Password :='10033585';
         Port := 465;
         idsmtp.AuthenticationType := atLogin;
         IOHandler := Socket;
      end;
      msg :=  TIdMessage.Create(nil);
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
         msgTela('','E-mail enviado com sucesso para: ' +#13+ para, 0  );
         idsmtp.Disconnect;
      except
         on e:Exception do
            msgtela('',#13+'   Ocorreu um erro ao enviar o e-mail, o erro foi:   ' +#13+#13+  e.message, 16 + 0 );
      end;
    end
    else
       msgtela('',#13+'O endereço é inválido ' +#13+#13, 16 + 0 );

   screen.Cursor := 0;
end;




end.
