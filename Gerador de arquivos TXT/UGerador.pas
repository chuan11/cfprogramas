unit UGerador;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Edit5: TEdit;
    BitBtn1: TBitBtn;
    open2: TOpenDialog;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    Panel1: TPanel;
    b1: TButton;
    ch1: TCheckBox;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    sg1: TStringGrid;
    Save1: TSaveDialog;
    Open1: TOpenDialog;
    bit1: TBitBtn;
    bit2: TBitBtn;
    b2: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    ch2: TCheckBox;
    ch3: TCheckBox;
    cbox1: TComboBox;
    cbox2: TComboBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AjustaLista(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure ch1Click(Sender: TObject);
    procedure bit2Click(Sender: TObject);
    procedure SalvaParaArquivo(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bit1Click(Sender: TObject);
    procedure Carrega(sender:tobject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure sg1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Mensagem(msg:string);
    procedure GeraArquivo(sender:tobject);
    procedure Edit5Click(Sender: TObject);
    function  FiltrAlfaNum(S:string): string;
//    function  PreencheString(Str:string):string;

    function PreencheString(Str:string;l:integer):string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}
type TChars = set of Char;

function TiraEspacos(Str:string):string;
begin
   while pos(' ',Str) > 0 do
      delete(str,pos(' ',Str),01);
   TiraEspacos := str;
end;


function tform1.PreencheString(Str:string;l:integer):string;
var
   i:integer;
begin
   str:=TiraEspacos(str);
   if sg1.cells[6,l] = 'DIR' then
      while length(str) < StrToInt(sg1.cells[3,l]) do
         str := str + copy(sg1.cells[5,l],02,01)
   else
      while length(str) < StrToInt(sg1.cells[3,l]) do
         str := copy(sg1.cells[5,l],02,01) + str ;

   PreencheString := str;
end;


//function  FiltrAlfaNum(Str:string): string;
function tform1.FiltrAlfaNum(S:string): string;
var
  I: integer;
begin
  Result := '';
  for I := 1 to Length(S) do
     if S[I] in ['a'..'z','A'..'Z','0'..'9',' ']then
  Result := Result + S[I];
end;


procedure tform1.Mensagem(Msg:string);
begin
   form1.refresh;
   form1.statusbar1.SimpleText := msg;
end;


procedure TForm1.AjustaLista(Sender: TObject);
var
   i:integer;
begin
   sg1.ColWidths[0] := 15;
   sg1.ColWidths[1] := 100;
   sg1.ColWidths[2] := 60;
   sg1.ColWidths[3] := 60;
   sg1.ColWidths[4] := 60;
   sg1.ColWidths[5] := 60;
   sg1.ColWidths[6] := 60;
   sg1.ColWidths[7] := 60;

   sg1.Cells[1,0]:= 'Campo';
   sg1.Cells[2,0]:= 'Inicio';
   sg1.Cells[3,0]:= 'Tam';
   sg1.Cells[4,0]:= 'Zero?';
   sg1.Cells[5,0]:= 'VaziosCom';
   sg1.Cells[6,0]:= 'Dir/Esq';
   sg1.Cells[7,0]:= 'FiltraAlfa?';
   for i:=0 to sg1.rowcount-1 do
   begin
      sg1.RowHeights[i] := 17;
      if i > 0 then
         sg1.cells[0,i]:= intToStr(i);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   AjustaLista(Sender);
   b1.Caption := 'Ok';
   b2.Caption := 'Cancela';
   edit1.text:='';
   edit2.text:='';
   edit3.text:='';
   edit4.text:='0';
   save1.Filter := open1.Filter;
   save1.InitialDir:= open1.InitialDir;
end;


procedure TForm1.b1Click(Sender: TObject);
begin
      sg1.cells[1,sg1.RowCount - 1] := edit1.text;
      sg1.cells[3,sg1.RowCount - 1] := edit3.text;

      if ch1.Checked = true then
      begin
         sg1.cells[4,sg1.RowCount - 1] := edit4.text;
         sg1.cells[5,sg1.RowCount - 1] := '-';
         sg1.cells[6,sg1.RowCount - 1] := '-';
      end
      else
      begin
         sg1.cells[2,sg1.RowCount - 1] := edit2.text;
         sg1.cells[4,sg1.RowCount - 1] := '-';

         if Ch3.Checked = true then
         begin
            sg1.cells[5,sg1.RowCount - 1] := cbox1.Items[cbox1.ItemIndex];
            sg1.cells[6,sg1.RowCount - 1] := cbox2.Items[cbox2.ItemIndex];
         end
         else
         begin
            sg1.cells[5,sg1.RowCount - 1] := '-';
            sg1.cells[6,sg1.RowCount - 1] := '-';
         end;
      end;

      if Ch2.Checked then
         sg1.cells[7,sg1.RowCount - 1] := 'S'
      else
         sg1.cells[7,sg1.RowCount - 1] := '-';


      sg1.rowcount :=   sg1.rowcount + 1;
      AjustaLista(Sender);
      b2Click(Sender);
end;

procedure TForm1.b2Click(Sender: TObject);
begin
   edit1.text:='';
   edit2.text:='';
   edit3.text:='';
   edit4.text:='';
   ch1.Checked := false;
   edit1.setfocus;
end;

procedure TForm1.ch1Click(Sender: TObject);
begin
  if ch1.Checked = true then
  begin
     edit4.visible:= true;
     edit4.setfocus;
     edit4.text:='0';

     ch2.Checked:=false;
     ch3.Checked:=false;

     ch3.Visible:= false;
     cbox1.Visible:=false;
     cbox2.Visible:=false;
     label4.Visible:=false;
     cbox1.itemindex:=-1;
     cbox2.itemindex:=-1;
  end
  else
  begin
     cbox1.Visible:=true;
     cbox2.Visible:=true;
     ch3.Visible:= true;
     edit4.visible:= false;
     edit4.text:='';
  end;
end;

procedure TForm1.SalvaParaArquivo(Sender: TObject);
var
   arq: TextFile;
   aux1,aux2:String;
   j,i:integer;
begin
   if pos('.lai',save1.filename) = 0 then
      save1.filename := save1.filename + '.lai';

   AssignFile(arq, save1.filename);
   rewrite(arq);

   for i:=1 to sg1.RowCount - 2 do
   begin
      aux1 := '';
      for j:=1 to  sg1.colcount - 1 do
         aux1:= aux1+ sg1.cells[j,i]+',';

      writeln(arq,aux1);
   end;
   closefile(arq);
end;


procedure TForm1.bit2Click(Sender: TObject);
begin
   if sg1.RowCount - 1  > 1 then
      if save1.execute then
         SalvaParaArquivo(Sender);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   edit1.setfocus;
   cbox1.itemindex:=0;
   cbox2.itemindex:=0;   
end;

procedure tform1.Carrega(sender:tobject);
var
   arq:textfile;
   aux,lin:string;
   col,linha,i,j:integer;
begin
  for i:=1 to sg1.rowcount -1 do
     for j:=1 to sg1.ColCount -1 do
        sg1.cells[j,i]:='';
  sg1.rowcount := 2;
  col:=1;
  col:=1;
  linha:=0;
  assignFile(arq, open1.filename);
  reset(arq);
  while eof(arq) = false do
  begin
     aux:='';
     col:=1;
     inc(linha);
     readln(arq,lin);

     for i:=1 to length(lin) do
     begin
        if copy(lin,i,01) = ',' then
        begin
           sg1.Cells[col,linha]:= aux;
           inc(col);
           aux:='';
        end
        else
          aux := aux+lin[i];
     end;

     sg1.RowCount := sg1.RowCount + 1;
  end;
  CloseFile(arq);
  AjustaLista(Sender);
end;

procedure TForm1.bit1Click(Sender: TObject);
begin
   if open1.execute then
     Carrega(sender);
end;

procedure TForm1.sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
   i:integer;
begin
  if canselect = false then
  begin
     for i:= arow+1 to sg1.RowCount - 1 do
     begin
        sg1.cells[1,i-1 ] := sg1.cells[1,i ];
        sg1.cells[2,i-1 ] := sg1.cells[2,i ];
        sg1.cells[3,i-1 ] := sg1.cells[3,i ];
        sg1.cells[4,i-1 ] := sg1.cells[4,i ];
     end;
     sg1.rowCount := sg1.rowCount -1 ;
  end;
end;

procedure TForm1.sg1DblClick(Sender: TObject);
var
  i:integer;
  ok:boolean;
begin
   ok := false;
   sg1SelectCell(Sender,i,i,ok);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action :=cafree;
end;


procedure tform1.GeraArquivo(sender:tobject);
var
  arq,dest:textfile;
  lin,lin2:string;
  lidos:real;
  j,i:integer;
begin
    panel1.Visible:= false;
    assignFile(arq,edit5.text);
    reset(arq);
    lin:= edit5.text;
    insert('_Saida',lin,length(lin)-3);
    assignfile(dest,lin);
    rewrite(dest);
    lidos:=0;
    while eof(arq) = false do
    begin
       lin2:='';
       lidos := lidos + 1;
       mensagem(FloatToStr(lidos));
       readln(arq,lin);
       for i:=1 to sg1.rowcount-2 do
       begin
          if sg1.cells[4,i] = '-' then
          begin
             lin2 := lin2 + copy(lin,StrToInt(sg1.cells[2,i]), StrToInt(sg1.cells[3,i]));

             if sg1.cells[7,i] <> '-' then
                lin2 := FiltrAlfaNum(lin2);

             if sg1.cells[5,i] <> '-' then
                lin2 := PreencheString(lin2,i);
          end
          else
             for j:= 1 to StrToInt(sg1.cells[3,i])-1 do // Preeenche com o conteudo do campo
                lin2 := lin2 + sg1.cells[4,i];
       end;
       writeln(dest,lin2);
       if lidos < 100 then
          memo1.lines.add(lin2);
   end;
   CloseFile(arq);
   CloseFile(dest);
   panel1.Visible:=true;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
var
  can:boolean;
begin
   screen.cursor := crhourglass;
   can:= true;

   if edit5.text = '' then
      can := false;
   if sg1.RowCount  <= 2 then
      can := false;

   if can = true then
      GeraArquivo(sender);

   screen.cursor := crdefault;
end;

procedure TForm1.Edit5Click(Sender: TObject);
begin
   if open2.execute then
      edit5.text := open2.filename;
end;

end.
