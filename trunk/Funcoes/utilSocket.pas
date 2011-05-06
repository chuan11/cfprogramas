unit utilSocket;

interface

uses
   uMeusocket;

function initialize(host:String; port:integer):boolean;
function getXML(codXML:String; host:String; port:integer):boolean;

//procedure connect();
implementation

uses RelogioPonto;

var
   soc: TMeuSocket;

function initialize(host:String; port:integer):boolean;
begin
   soc := TMeuSocket.create();
   result := soc.connect(host, port);
end;

function getXML(codXML:String; host:String; port:integer):boolean;
begin
   if  (initialize(host, port) = true) then
      soc.buscaXML(codXML);
end;

end.
