unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, ComCtrls, StdCtrls, TFlatSplitterUnit,funcoes;

type
  TForm1 = class(TForm)
    LB1: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    StatusBar1: TStatusBar;
    FlatButton1: TFlatButton;
    Edit3: TEdit;
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    function PodeGravarLinha(nLinha:real):boolean;
    procedure Edit3DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Iinterv:array[0..50] of string;
  Finterv:array[0..50] of string;
  i:integer;
implementation





{$R *.dfm}

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      lb1.Items.Add(edit1.text+';'+edit2.text);
end;

function TForm1.PodeGravarLinha(nLinha: real): boolean;
var
  j:integer;
  aux:real;
begin
   PodeGravarLinha := true;
   for j := 0 to i do
   begin
      if ( nLinha >= StrToFloat(Iinterv[j]) ) and ( nLinha <= StrToFloat(Finterv[j])) then
      begin
         PodeGravarLinha := false;
         break;
      end;
   end;
end;


procedure TForm1.FlatButton1Click(Sender: TObject);
var
   arq:textFile;
   Str:string;
   NumLinha:real;
begin
   screen.cursor := CrHOurGlass;
   for i:=0 to lb1.Items.count-1 do
   begin
      Iinterv[i] :=  copy( lb1.items[i], 01, pos(';',lb1.items[i])-1          );
      finterv[i] :=  copy( lb1.items[i], pos(';',lb1.items[i])+1 ,   length(lb1.items[i])       );
   end;

   i := lb1.Items.count-1;
   numLinha:=0;

   AssignFile(arq, edit3.text );
   reset(arq);
   DeleteFile('c:\Saida.txt');
   while eof(arq) = false do
   begin
     readln(arq,str);
     numlinha := numlinha+1;
     statusbar1.SimpleText := FloatTostr(numlinha);
     if PodeGravarLinha(numlinha) = true then
        funcoes.GravaLinhaEmUmArquivo('c:\Saida.txt',str);
   end;
   closeFile(arq);

   screen.cursor := CrDefault;
end;


procedure TForm1.Edit3DblClick(Sender: TObject);
begin
   edit3.text := funcoes.DialogAbrArq('c:\')
end;

end.
