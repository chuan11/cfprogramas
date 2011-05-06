unit UTiraLinhas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    StatusBar2: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
function ExisteCodigoNaloja(numloja:string):Boolean;
var
  i:byte;
begin
   ExisteCodigoNaloja := false;
   for i:=0 to  form1.Memo1.lines.Count -1 do
      if form1.memo1.lines[i] = numloja then
         ExisteCodigoNaloja := true;

end;
procedure TForm1.BitBtn1Click(Sender: TObject);
var
   aux :string;
begin
   screen.cursor := crhourglass;
   if opendialog1.execute then
   begin
      edit1.text := opendialog1.Filename;
      aux:= edit1.text;
      insert('_2',aux,length(aux)-3);
      edit2.text :=aux;
      if checkbox1.checked then
         listbox1.items.LoadFromFile(opendialog1.Filename);
   end;
   screen.cursor := crdefault;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
   j,i:integer;
   destino:TextFile;
   PodeGravar:boolean;
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   AnimateWindow(form1.Handle,150, AW_ver_POSITIVE);
   setforegroundWindow(handle);
   button1.hint:='verifica se existe o valor 1 e susbstitui pelo de edit4'; 
   bitbtn5.hint:='PrecosInteq.prn' +#13+'colunas de 12 codigo precos e dif';
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
   origem:textfile;
   linha:string;
   i:integer;
begin
{   ELE LE O ARQUIVO QUE EU GEREI NO EXCEL
    (COLUNAS COM LARGURA  12 )
    EXTENSAO .PRN
    MONTA UM TXT COM O CODIGO E O PRECO DO PRODUTO
    COLUNA A = CODIGO
    COLUNA B = PRECO PARA O SIC TAM 12 SEM VIRGULAS
    COLUNA C = TEXTO "DIF" COPY(LINHA,33,03) SSE TIVER DIF É PARA MUDAR
    COLUNA D =
    COLUNA E =
}
   i:=0;
   assignfile(origem,'c:\precosInteq.prn');
   reset(origem);
   while eof(origem) = false do
   begin
      readln(origem,linha);
      if  (copy (linha,33,03) = 'DIF' ) and (copy(linha,13,12) <>'000000000000' )then
      begin
         inc(i);
         listbox1.Items.add(copy(linha,01,24));
      end;
   end;
   closefile(origem);
   screen.cursor := crdefault;
   label1.caption:=('Itens para trocar o preco em cada Loja: '  + inttostr(i));
// sleep(200);
   showmessage('Itens para trocar o preco em cada Loja: '  + inttostr(i));


end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  mudadas,origem,destino:textfile;
  linha:string;
  achados,k,l,j,i: Longint;
  achei:boolean;

begin
  i:=0;k:=0;achados:=0;
  BitBtn4Click(Sender);

  assignFile(origem,edit1.text);
  reset(origem);

  AssignFile(destino,edit2.text);
  rewrite(destino);

  AssignFile(mudadas,'c:\ItensEncontrados.tmp');
  rewrite(mudadas);

  while eof(origem) = false do
  begin
     achei := false;
     j:=0;

     readln(origem,linha);
     if ExisteCodigoNaloja(  copy(linha,03,02)   ) = true then
        for i:=0 to listbox1.Items.count-1 do
        begin
           if copy(linha,05,07) <= copy(listbox1.Items[i],05,07 ) then
              if copy(linha,05,07) = copy(listbox1.Items[i],05,07 ) then
              begin
                 achei := true;
                 j := i;
              end;
        end;
     if achei = true then
     begin
        writeln(mudadas,copy(linha,03,02)+' '+copy(linha,162,12)+' -> '+ listbox1.Items[j] );
        statusbar2.simpletext:=copy(linha,03,02)+' '+copy(linha,162,12)+' -> '+ listbox1.Items[j];
        delete(linha,162,12);
        insert(copy(listbox1.Items[j],13,12),linha,162);
        writeln(destino,linha);

        inc(achados);
     end
     else
        writeln(destino,linha);

     inc(k);
   statusbar1.simpletext:= inttoStr(k) + ' / ' +  inttoStr(achados);


  end;

  CloseFile(origem);
  CloseFile(destino);
  CloseFile(mudadas);
  statusbar1.simpletext:= statusbar1.simpletext + '      terminado!!!!!';
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  origem,destino:textfile;
  linha:string;
  I:LONGint;
begin
  i:=0;
  assignFile(origem,edit1.text);
  reset(origem);
  assignfile(destino,edit2.text);
  rewrite(destino);
  while eof(origem) = false do
  begin
     readln(origem,linha);
     inc(i);
     statusbar1.simpletext:=inttoStr(i);
     if pos(edit3.text,linha) > 0 then
     begin
        delete(linha,pos(edit3.text,linha),01);
        insert(edit4.text,linha,01);
        writeln(destino,linha);
        SHOWMESSAGE('ACHEI');
     end
     else
       WRITELN(DESTINO,LINHA);
  end;
  closefile(origem);
  closefile(destino);
  showmessage('acabei');


end;

end.
