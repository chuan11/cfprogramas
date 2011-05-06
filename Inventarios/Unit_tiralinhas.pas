unit Unit_tiralinhas;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, adLabelEdit, adLabelNumericEdit,
  adLabelSpinEdit,FUNCOES;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Bevel2: TBevel;
    Label6: TLabel;
    Memo2: TMemo;
    Button1: TButton;
    spinedit: TadLabelSpinEdit;
    Button4: TButton;
    Label7: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation    {$R *.dfm}

function TornaInteiro( s:string):Real ;
begin
  if s <> '' then
  begin
      while pos( ' ',s ) > 0 do
         delete( s ,pos(' ', s ),1);
      while pos( '.',s ) > 0 do
         delete( s ,pos('.', s ),1);
      while pos( ',',s ) > 0 do
         delete( s ,pos(',', s ),1);
   end;
     TornaInteiro := strtoFloat(s);
end;
function pontua(s:string):string;
var
   aux : string;
   i: integer;
begin
   aux := '';
   for i:= length( s ) downto 1 do
      aux := aux + s[ i ];

   if ( length ( aux ) > 2 ) and ( length ( aux ) <= 5 ) then
      insert( ',', aux, 3)
   else if ( length ( aux ) > 5 ) and ( length ( aux ) <= 8 ) then
   begin
      insert( ',', aux, 3);
      insert( '.', aux, 7);
   end
   else if ( length ( aux ) > 8 ) then
   begin
      insert( ',', aux, 3);
      insert( '.', aux, 7);
      insert( '.', aux, 11);
   end;
   s:='';
   for i:= length( aux ) downto 1 do
      s := s + aux[ i ];

   pontua := s;
end;



procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   application.terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if button1.Caption = 'CARREGA' then
   begin
      FORM1.CLIENTHEIGHT:= 400;
      MEMO2.VISIBLE:=TRUE;
      MEMO2.Clear;
      memo2.lines.loadfromFile(edit1.text);
      button1.Caption := 'Fechar';
   end
   else
   begin
      MEMO2.VISIBLE:=FALSE;
      memo2.lines.Clear;
      button1.Caption := 'CARREGA';
      FORM1.CLIENTHEIGHT:= 216;
   end;
end;
Function AjustaFolhas(x:String):String;
begin
    while pos( ' ', x ) > 0 do delete( x ,pos(' ', x ),1);
    while length( x ) < 3 do insert('0', x, 1 );
    AjustaFolhas:= x;
end;
function AjustaCasasQuantidade(s:String):String;
begin
   while pos( ' ',s ) > 0 do
      delete( s ,pos(' ', s ),1);
   while pos( '.',s ) > 0 do
      delete( s ,pos('.', s ),1);

   if length(s) < 3 then
     while length(s) < 3 do
        insert('0',s,01);

     s:= ' ' + s ;

  AjustaCasasQuantidade := s;
end;

function Ajustalinha( s:String ):string;
var
   i:integer;
   aux : String;
begin
    aux:='';
    for i :=1 to 30 do insert(' ',aux,01);
    aux := aux + copy( s,01,35 );
    while length( aux ) < 73 do insert(' ', aux, length(aux) + 1 );
    aux := aux + 'UND';

    aux := aux + AjustaCasasQuantidade( copy(s,45,10) );
    while length(  aux ) < 87 do insert(' ', aux, 77 );
    aux := aux +  copy( s,53,30 );
    Ajustalinha := aux;
end;
procedure TForm1.Button2Click(Sender: TObject);
var
   arq2,arq: textFile;
   linha:string;
   transp:real;
   itemsPorPg,l,Fl:integer;

begin
   ItemsPorPg:=StrToInt(Spinedit.text);
   Fl := 0; l := 0;
   transp := 0;
   assignFile( arq, edit1.text);
   Reset(arq);
   assignFile( arq2, edit2.text );
   rewrite( arq2 );

   while eof( arq ) = false do
   begin
      inc(fl);
      linha := '   CNPJ: '+ memo1.lines[0] + '                       '+ memo1.lines[1] +'Pagina: ' + AjustaFolhas(inttoStr(Fl));
      while length(linha) < 123 do
         insert(' ',linha, pos('Pagina:',linha));
      writeln( arq2,linha);
      writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
      writeln( arq2, '   ESTOQUES EXISTENTES EM: '+memo1.lines[2]+'                  REGISTRO DE INVENTARIO                 ' +memo1.lines[3]);
      writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
      if  transp > 0 then
         writeln( arq2, '                                                                            VALOR TRANSPORTADO: '  + pontua(FloatToStr(transp)) )
      else
         writeln( arq2, '');

      writeln( arq2, '   CLASSE FISCAL  REFERENCIA      DESCRICAO                            UNIDADE    QUANT   VALOR UND       TOTAL ');
      writeln(arq2,'');
      while ( l < ItemsPorPg ) and ( eof(arq) = false ) do
      begin
         inc(l);
         readln(arq,linha);
         transp := transp + tornainteiro((copy(linha,65,12)));
         writeln(arq2 , AjustaLinha(linha));
      end;
      if ( eof(arq) = false ) then
      begin
      writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
         writeln( arq2, '                                                                           VALOR A TRANSPORTAR: '  + pontua(FloatToStr(transp)) );
         writeln( arq2,'');
         l:=0
      end
      else
      begin
{*}         writeln(arq2,'');
{*}         writeln(arq2,'');
{*}         writeln( arq2, '                                                                             TOTAL GERAL : '  + pontua(FloatToStr(transp)) );
         while ( l < ItemsPorPg ) do
         begin
            writeln(arq2,'');
            inc(l);
         end;
         writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
//         writeln( arq2, '                                                                             TOTAL GERAL : '  + pontua(FloatToStr(transp)) );
         writeln( arq2,'');
      end;

   end;
   CloseFile( arq2 );
   CloseFile( arq );
   MEMO2.Lines.LoadFromFile(EDIT2.TEXT);
   button1.Caption := 'Fechar';
   FORM1.CLIENTHEIGHT:= 400;
   MEMO2.VISIBLE:= TRUE;
end;



procedure TForm1.Button3Click(Sender: TObject);
var
   arq2, arq: textFile;
   p1,p2,linha :string;

begin
   assignFile( arq, edit1.text);
   reset( arq);
   assignFile( arq2, edit2.text);
   rewrite( arq2);
   while eof( arq ) = false do
   begin
       p1 :='';
       p2 := '';
       readln( arq,linha );
       if copy( linha, 4, 1 ) = '0' then
       begin
           p1:= copy( linha, 1, 7 )+' '+ copy( linha, 15, 35)+' '+copy( linha, 55,13);
           readln( arq, linha);
           if (copy( linha, 1,1) <> '') then
           begin
              p2 := copy( linha, 57,20);
              writeln( arq2,p1+p2);
           end;
       end;
   end;

   CloseFile( arq );
   CloseFile( arq2 );

   showmessage('OK');

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    spinedit.Text:= '53';
   edit1.text := lerParam('C:\Projetos\Inventarios\Campos.ini',00);
   edit2.text :=lerParam('C:\Projetos\Inventarios\Campos.ini',01);
   memo1.lines[0] :=lerParam('C:\Projetos\Inventarios\Campos.ini',02);
   memo1.lines[1] :=lerParam( 'C:\Projetos\Inventarios\Campos.ini',03);
   memo1.lines[2] := lerParam('C:\Projetos\Inventarios\Campos.ini',04);
   memo1.lines[3] := lerParam('C:\Projetos\Inventarios\Campos.ini',07);   
   form1.Width := StrToInt(lerParam('C:\Projetos\Inventarios\Campos.ini',05));
   form1.left := StrToInt(lerParam('C:\Projetos\Inventarios\Campos.ini',06));
end;

procedure TForm1.Edit1Click(Sender: TObject);
var
   aux:string;
begin
   if opendialog1.execute then
   begin
      edit1.text :=  opendialog1.filename;
      aux:= edit1.text;
      insert('_2',aux,length(aux)-3);
      edit2.text := aux
   end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    memo2.Width := form1.Width-20;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   gravaParam('C:\Projetos\Inventarios\Campos.ini',edit1.text,00);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',edit2.text,01);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',memo1.lines[0],02);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',memo1.lines[1],03);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',memo1.lines[2],04);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',IntTostr(form1.Width),05);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',IntTostr(form1.left),06);
   gravaParam('C:\Projetos\Inventarios\Campos.ini',memo1.lines[3],07);   
end;

procedure TForm1.Button4Click(Sender: TObject);
var
   arq2, arq: textFile;
   p1,linha :string;
begin
   assignFile( arq, edit1.text);
   reset( arq);
   assignFile( arq2, edit2.text);
   rewrite( arq2);
   while eof( arq ) = false do
   begin
       p1 :='';
       readln( arq,linha );
       if  ( funcoes.EhCodigo( copy( linha, 14, 07 ))  ) and (funcoes.preencheCampo(05,'0','E', funcoes.tiraEspaco(copy( linha, 90,05)) ) <> '00000') then
       begin
           p1:= copy( linha, 14, 07 ) +' '+
                funcoes.preencheCampo(40,' ','D', copy( linha, 30,30))  +'  '+ 
                funcoes.preencheCampo(12,' ','E', funcoes.SohNumeros(copy( linha, 90,05)) ) +'  '+
                funcoes.preencheCampo(12,' ','E', funcoes.tiraEspaco(copy( linha,103,10)) ) ;
           writeln( arq2,p1);
       end;
   end;

   CloseFile( arq );
   CloseFile( arq2 );

   MEMO2.Lines.LoadFromFile(EDIT2.TEXT);
   button1.Caption := 'Fechar';
   FORM1.CLIENTHEIGHT:= 400;
   MEMO2.VISIBLE:= TRUE;
end;

end.
