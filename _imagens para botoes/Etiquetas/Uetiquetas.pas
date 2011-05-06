unit Uetiquetas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
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


function RemoveAcento(Str:String): String;
Const
   ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
   SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
Var
   x : Integer;
Begin
   For x := 1 to Length(Str) do
   if Pos(Str[x],ComAcento)<>0 Then
      Str[x] := SemAcento[Pos(Str[x],ComAcento)];
   Result := Str;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
   arq: textFile;
   linha: string;

begin
   edit1.text:='';
   if opendialog1.execute then
   begin
   assignFile ( arq , opendialog1.filename);
   Reset( arq );
   Readln( arq, linha );
   if copy( linha, 83 ,21) = 'RelatÛrio da Pesquisa' then
      edit1.text := opendialog1.filename
   else
      showmessage('Este arquivo  n„o È v·lido');
   end;
   CloseFile(arq);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
   a: string;
begin
   Button1Click(Sender);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
   arq: textFile;
   linha: string;
   dados: array [1..100] of string;
   i , j: integer;
begin
   i:=0;
   AssignFile( arq , edit1.text);
   Reset( arq );
   readln(arq,linha);   readln(arq,linha);   readln(arq,linha);
   edit2.text :=copy(linha, 14, 20 ) ;
   While eof( arq ) = false do
   begin
      readln( arq, linha);
      if ( copy( linha, 7,06) <> '      ' ) and ( copy(linha, 06,05)<> 'Total')then
      begin
          inc(i);
          dados[i] := linha;
      end;
   end;
   CloseFile( arq );
   linha := edit1.text;
   delete(linha, length(linha)-3, 3);

   AssignFile( arq, linha + '_Etiqueta.txt');
   Rewrite( arq );

   writeln( arq ,'ND10D08');
   writeln( arq ,'Q200,24');
   writeln( arq ,'q800');
   j:=0;
   while ( j ) < ( i ) do
   begin
       inc(j);
       if j < i then
       begin
          writeln( arq ,'A755,180,2,3,1,1,N,"'+edit2.text+'"');
          writeln( arq ,'A755,110,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],3,20))+' "');
          writeln( arq ,'A755,090,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],21,09))+' "');
          writeln( arq ,'A755,050,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],31,22))+' "');
       end;
       inc(j);
       if j < i then
       begin
          writeln( arq ,'A510,180,2,3,1,1,N,"'+edit2.text+'"');
          writeln( arq ,'A510,110,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],3,20))+' "');
          writeln( arq ,'A510,090,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],21,09))+' "');
          writeln( arq ,'A510,050,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],31,22))+' "');
       inc( j );
       if j < i then
       begin
          writeln( arq ,'A250,180,2,3,1,1,N,"'+edit2.text+'"');
          writeln( arq ,'A250,110,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],3,20))+' "');
          writeln( arq ,'A250,090,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],21,09))+' "');
          writeln( arq ,'A250,050,2,1,1,1,N,"'+RemoveAcento(copy(dados[j],31,22))+' "');
          writeln(arq , 'P');
          writeln( arq ,'ND10');
          writeln( arq ,'Q200,24');
          writeln( arq ,'q800');
       end;
   end;
   end;
   CloseFile (arq);
   showmessage('ok');
end;
end.
