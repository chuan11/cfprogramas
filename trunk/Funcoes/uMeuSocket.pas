unit uMeuSocket;

interface

uses
  classes, SysUtils, GrFingerXLib_TLB, ActiveX, verificaSenhas, Controls,
  dialogs, funcSQl, QForms,funcoes, funcDatas,
  ScktComp ;

type
   TMeuSocket = class
   private
      sock: TclientSocket;
      list:TStringList;
    public
       procedure destroy();
       function connect(host:String; port: integer): boolean;
       procedure SockDisconnect(Socket: TCustomWinSocket);
       procedure ClientSocket1Connect(Socket: TCustomWinSocket);
       procedure ClientSocket1Read( Socket: TCustomWinSocket);
       function buscaXML(chave:String):boolean;
end;

implementation


function TMeuSocket.buscaXML(chave: String): boolean;
begin
   sock.Socket.SendText(chave);
end;

procedure TMeuSocket.ClientSocket1Connect(Socket: TCustomWinSocket);
begin //
   funcoes.gravaLog('conectei');
end;

procedure TMeuSocket.ClientSocket1Read(Socket: TCustomWinSocket);
begin //

end;

function TMeuSocket.connect(host:String; port: integer): boolean;
begin
   if (sock = nil) then
      sock := TClientSocket.Create(nil);
   sock.Port := port;
   sock.Host := host;
   try
      sock.Open;
      result := true;
   except
      result := false;
   end;
end;

procedure TMeuSocket.destroy();
begin
   sock.Close();
   sock.Free();
end;

procedure TMeuSocket.SockDisconnect(Socket: TCustomWinSocket);
begin  //
   funcoes.gravaLog('desconectei');
end;

end.
