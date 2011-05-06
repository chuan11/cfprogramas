unit uMeuSocket;

interface

uses
  classes, SysUtils, GrFingerXLib_TLB, ActiveX, verificaSenhas, Controls,
  dialogs, QForms,funcoes, funcDatas, funcoes,

  ScktComp ;

type
  TMeuSocket = class

  soquete: TclientSocket;

    public
    procedure create(Host:String);
    procedure destroy();
    function connect(Host:String):boolean;
end;

implementation

procedure TMeuSocket.Create();
begin
   soquete := TClientSocket.Create(nil);
end;

procedure TMeuSocket.destroy();
begin
   soquete.Close();
   soquete.Free();
end;

function connect(Host:String):boolean;
begin
//  try
   soquete.Host := Host;
   soquete.Port := 3436;
   soquete.

//  except
//  on e:exception do
//  begin
//     funcoes.MsgTela('','Erro ao tentar conexao',0);
//  end;
end;

end.
