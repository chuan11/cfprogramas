unit uSocketServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ComCtrls, AppEvnts;

type
  TForm1 = class(TForm)
    ServerSocket: TServerSocket;
    Memo: TMemo;
    StatusBar1: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    procedure ServerSocketAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject;Socket: TCustomWinSocket);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure buscaArquivoXMl(nArquivo:String;  Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure enviaArquivoXMl(nArquivo:String;  Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cmd:String;
  crLf:String;
implementation

{$R *.dfm}

uses funcoes;

procedure TForm1.ServerSocketAccept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   memo.Lines.Add('Conectado ao ip: ' + Socket.RemoteAddress + '  ' + DateToStr(now) );

//   Socket.SendText('Ola! ' +crLf);
//   Socket.SendText('Para fechar pressione CTRL+c'+crLf);
end;

procedure TForm1.ServerSocketClientWrite(Sender: TObject; Socket: TCustomWinSocket);
begin
   memo.Lines.add(Socket.ReceiveText);
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
  ServerSocket.Open;
  memo.Lines.add('Escutando na porta 3437');
  crLf := char(13)+ char(10);
end;

procedure TForm1.enviaArquivoXMl(nArquivo: String;  Socket: TCustomWinSocket);
var
  arq:TSTringlist;
  i:integer;
begin
   arq := TStringList.Create();

   arq.LoadFromFile(nArquivo);


   for i:=0 to arq.Count-1 do
   begin
      memo.Lines.add('Enviei: ' + intToStr(i) + ' pacotes');
//      Socket.SendText('<f>'+ arq[i]);
      Socket.SendText(arq[i]);
   end;
   Socket.SendText('<ok>');
   ServerSocket.Close();
   ServerSocket.open();
   arq.Free();
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ServerSocket.Close();
end;

procedure TForm1.buscaArquivoXMl(nArquivo:String;  Socket: TCustomWinSocket);
begin
   delete(nArquivo,  length(nArquivo)-4, length(nArquivo)-1 );
   nArquivo:= 'C:\ACBrNFeMonitor\Logs\NFe\' + nArquivo + '-nfe.xml';

   if ( fileExists(nArquivo) = true )then
   begin
      Memo.Lines.Add('Achei a nfe: '+ crLf + nArquivo);
      enviaArquivoXMl(nArquivo, Socket);
   end
   else
   begin
      Memo.Lines.Add('N�o achei a nfe: ' + crLf + nArquivo);
      Socket.SendText('');
   end;
   cmd := '';
end;

procedure TForm1.ServerSocketClientError(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   Memo.Lines.add('erro');
end;


procedure TForm1.ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
   cmd := cmd + Socket.ReceiveText;

   if Pos('<xml>', cmd) > 0 then
      buscaArquivoXMl(cmd, socket);

   if pos(char(13), cmd ) <> 0 then
   begin
      memo.lines.Add(cmd);
      cmd := '';
      Socket.SendText(char(13)+ char(10))
   end;
   if (Pos('', cmd) > 0) or (Pos('<bye>', cmd) > 0) then
   begin
      Socket.SendText(' Tchau ' + crLf);
      ServerSocket.Close();
      ServerSocket.open();
   end;
end;


procedure TForm1.ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
   memo.Lines.Add('Cliente desconectou ' + DateToStr(now)  );
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
    funcoes.gravaLog(e.Message);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   Form1.Top := 1;
   Form1.Left := 100;
end;

end.
