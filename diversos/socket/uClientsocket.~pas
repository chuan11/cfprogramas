unit uClientsocket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, funcoes, uMeuSocket;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  gravar:boolean;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   ClientSocket1.Open;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
   cmd:String;
begin
   cmd := Socket.ReceiveText;

   if cmd = '<inicio>' then
   begin
      gravar := true;
      exit;
   end;

   if cmd = '<fim>' then
      gravar := false;

   if (gravar = true) then
   begin
     Memo1.Lines.add(cmd);
     funcoes.GravaLinhaEmUmArquivo('c:\arq.XML', cmd);
   end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    ClientSocket1.Socket.SendText('21110104765543000150550010000000240000012231<xml>'  )
end;

end.
