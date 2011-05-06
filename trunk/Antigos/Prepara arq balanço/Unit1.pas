unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,funcoes, StdCtrls,QDialogs, adLabelEdit, TFlatButtonUnit,
  TFlatMemoUnit, ComCtrls;
type
  TForm1 = class(TForm)
    Edit1: TadLabelEdit;
    Edit2: TadLabelEdit;
    FlatButton1: TFlatButton;
    Memo1: TFlatMemo;
    SB1: TStatusBar;
    procedure FlatButton1Click(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
    procedure msgRodape(msg:string);
    procedure Crialista(sender:TObject);
    function  EstaNaLista(Str:String):boolean;
    procedure Edit1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
   ARQ_SAIDA = 'C:\Arquivo.txt';
var
   Form1: TForm1;
   lista:TStringList;
implementation

{$R *.dfm}

function TForm1.EstaNaLista(Str: String): boolean;
var
   i:integer;
   achou:boolean;
begin
   EstaNaLista := false;
   for i:= 0 to lista.Count -1 do
   begin
      if str = lista[i] then
      begin
         lista.Delete(i);
         EstaNaLista := true;
         break;
      end;
   end;
end;

procedure TForm1.Crialista(Sender: TObject);
var
   arq:textfile;
   str:string;
begin
   assignFile(arq,edit2.text);
   reset(arq);
   lista := Tstringlist.Create();
   while eof(arq) = false do
   begin
      readln(arq,str);
      if (EhCodigo(copy(str,01,07))  = true) and ( copy(str,01,07) <> '       ' ) then
         lista.Add(copy(str,01,07));
    end;
    CloseFile(arq);
    memo1.Lines.add('Quantidade de itens no relatorio de saldos:' + inttostr(lista.Count -1));
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
  arq:textfile;
  str,aux:string;
  Achados:integer;
begin
  memo1.lines.clear;
   achados := 0;

   deleteFile(ARQ_SAIDA);
   screen.Cursor := crhourglass;
   msgRodape('Criando a lista de codigos q existem no cd...');
   crialista(sender);

   assignFile(arq, edit1.text);
   reset(arq);

   while eof(arq) = false do
   begin
      readln(arq,str);
      if ehCodigo(copy(str,01,07)) = true then
      begin
         if EstaNaLista( copy(str,01,07) ) = true then
         begin
            inc(achados);
            aux := '';
            if SoHnumeros(copy(str,178,13)) <> '' then
               aux := funcoes.preencheCampo(13,' ','d',copy(str, 178,13) ) +' '+ funcoes.SohNumeros(copy(str,01,07))  +' '+ copy(str,27,30)
            else
               aux := funcoes.preencheCampo(13,' ','d',copy(str,  01,07) ) +' '+ funcoes.SohNumeros(copy(str,01,07))  +' '+ copy(str,27,30) ;
            if length(aux) > 15 then
               GravaLinhaEmUmArquivo(ARQ_SAIDA, aux);
         end;
         msgRodape('Comparando com o arquivo geral de produtos...   ' + copy(str,01,07) + ' Achados:' + IntTostr(achados) );
      end;
   end;
   Closefile(arq);
   memo1.lines.add('');
   memo1.lines.add('');
   memo1.lines.add('Produtos no arquivo:' + IntTostr(achados));
   screen.cursor := crDefault;
end;

procedure TForm1.Edit2DblClick(Sender: TObject);
begin
   edit2.Text := funcoes.DialogAbrArq('');
end;

procedure TForm1.msgRodape(msg:string);
begin
   form1.SB1.SimpleText := msg;
   form1.Refresh;
end;




procedure TForm1.Edit1DblClick(Sender: TObject);
begin
   edit1.text :=DialogAbrArq('');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.gravaParam('C:\Preparacao.ini',edit1.text,00);
   funcoes.gravaParam('C:\Preparacao.ini',edit2.text,01);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   edit1.text := funcoes.lerParam('C:\Preparacao.ini',00);
   edit2.text := funcoes.lerParam('C:\Preparacao.ini',01);
end;
procedure TForm1.Edit2Click(Sender: TObject);
begin
   memo1.lines.Clear;
   memo1.Lines.Add('     Arquivo com a lista dos produtos do cd -');
   memo1.Lines.Add(' ');
   memo1.Lines.Add(' Este campo é preenchdo como arquivo gerado pela consulta');
   memo1.Lines.Add(' "Saldos por recursos Casa freitas');
   memo1.Lines.Add(' Que esta em: ');
   memo1.Lines.Add(' Consultas -> De estoque -> Saldos por recursos Casa Freitas   ');
end;
procedure TForm1.Edit1Click(Sender: TObject);
begin
   memo1.lines.Clear;
   memo1.Lines.Add('use Zteste');
   memo1.Lines.Add('select r.codigo, r.nome, c.codigo ean');
   memo1.Lines.Add('from recurso r, codigo c');
   memo1.Lines.Add('where ');
   memo1.Lines.Add('   (c.mae = r.chave)');
   memo1.Lines.Add('and  ');
   memo1.Lines.Add('   (ISNUMERIC(R.EAN)=1 )  ');
   memo1.Lines.Add('and                        ');
   memo1.Lines.Add('   (ISNUMERIC(R.codigo)=1 )  ');
   memo1.Lines.Add('order by                   ');
   memo1.Lines.Add('  c.codigo                  ');
   memo1.Lines.Add('go                           ');
   memo1.Lines.Add('select r.codigo, r.nome, r.ean ');
   memo1.Lines.Add('from                        ');
   memo1.Lines.Add('   recurso r, campo c ,tabela  t, classe cl ');
   memo1.Lines.Add('where            ');
   memo1.Lines.Add('    ( c.mae = 1850)');
   memo1.Lines.Add('and');
   memo1.Lines.Add('    ( r.clfiscal = t.chave )');
   memo1.Lines.Add('and                   ');
   memo1.Lines.Add('    ( r.classe = cl.chave )');
   memo1.Lines.Add('and');
   memo1.Lines.Add('    (ISNUMERIC(R.ean)=1 )');
   memo1.Lines.Add('order by');
   memo1.Lines.Add('   r.codigo');
end;

end.
