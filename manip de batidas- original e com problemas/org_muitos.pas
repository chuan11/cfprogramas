unit org_muitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    FileListBox1: TFileListBox;
    ListBox1: TListBox;
    BitBtn5: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  linha:array[0..8]of string;
  un:integer;
implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
   inc(un);
   if un < 9 then
   begin
      if opendialog1.execute then
      begin
         linha[un]:= opendialog1.filename;
         listbox1.items[0]:=linha[0];
         listbox1.items[1]:=linha[1];
         listbox1.items[2]:=linha[2];
         listbox1.items[3]:=linha[3];
         listbox1.items[4]:=linha[4];
         listbox1.items[5]:=linha[5];
         listbox1.items[6]:=linha[6];
         listbox1.items[7]:=linha[7];
         listbox1.items[8]:=linha[8];

      end;
   end
   else
   begin
      showmessage('cheio');
      un:=8;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
filelistbox1.itemindex:=0;
un:=-1;
filelistbox1.directory:='C:\Arquivos de programas\Fluxus\Ultimas';
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   if un >= 0 then
   begin
      linha[un]:= '';
      listbox1.items[un]:=linha[un];
      un:=un-1;
   end
   else
      showmessage('Vazio');

end;

function r1(n:string):string;
var
   aux:string;
begin
   aux:= copy(n,7,4);
   aux:= aux + copy(n,4,2);
   aux:= aux + copy(n,1,2);
   aux:= aux + copy(n,12,2);
   aux:= aux + copy(n,15,2);
   aux:= aux + copy(n,18,2);
   aux:= aux + copy(n,21,8);
   r1:=aux;
end;
function r2(n:string):string;
var
   aux:string;
begin
   aux:= copy(n,7,4);
   aux:= aux + copy(n,4,2);
   aux:= aux + copy(n,1,2);
   aux:= aux + copy(n,12,2);
   aux:= aux + copy(n,15,2);
   aux:= aux + copy(n,18,2);
   aux:= aux + copy(n,21,8);
   r2:=aux;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
   arq :textfile;
   linha: string;
   i, j ,k :integer;
   batida: array[1..20000]of string[28];
begin
    for i:=1 to un do
    begin
       assignFile(arq,listbox1.items[i]);
       reset(arq);
       while eof(arq) = false do
       begin
          readln(arq,linha);
//          if edit1.text = copy(linha,24,2) then
//             if edit2.text = copy(linha,4,7) then
             begin
                inc(j);
                batida[j] := linha;
             end;
           closeFile(arq);
       end;
    end;

    for i:=1 to j-1 do
       for k:=i to j do
       begin
           if r2(batida[k])< r1(batida[i]) then
           begin
              linha:=batida[k];
              batida[k]:=batida[i];
              batida[i]:=linha;
           end
           else if batida[k] = batida[i] then
              batida[k]:='';
       end;

    assignFile(arq,'c:\result.txt');
    rewrite(arq);
    for i:=1 to j do
       if batida[i] <> '' then
          writeln(arq,batida[i]);


    CloseFile(arq);
    showmessage('ok');
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
i:integer;
begin
   for i:=0 to un do
   showmessage(listbox1.items[i]);

end;
procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
   BitBtn5Click(Sender);

end;
procedure TForm1.BitBtn5Click(Sender: TObject);
begin
   listbox1.items.add(filelistbox1.items[filelistbox1.itemindex]);
//   filelistbox1.items[filelistbox1.itemindex]:='';
end;



procedure TForm1.ListBox1Click(Sender: TObject);
var
   arq:array[1..15] of string;
   j, i:integer;
begin
   listbox1.Items[listbox1.itemindex]:='';
   for i := 0 to (FileListBox1.Items.Count - 1) do
   begin

   end;
end;

end.
