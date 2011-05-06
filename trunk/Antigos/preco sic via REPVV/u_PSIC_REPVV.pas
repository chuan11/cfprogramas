unit u_PSIC_REPVV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,clipbrd, ComCtrls, Mask, Spin;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    MaskEdit1: TMaskEdit;
    Label2: TLabel;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    SEdit1: TSpinEdit;
    Label3: TLabel;
    RG1: TRadioGroup;
    Memo2: TMemo;
    CheckBox16: TCheckBox;
    procedure Label1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

    procedure carregarListaDeprecos(sender:tobject);
    procedure MontaCopiaDosPrecos(sender:tobject);
    procedure FormActivate(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure MarcarDesmarcaLojasFortaleza(sender:tobject);
    procedure MarcarDesmarcaLojasDeFOra(sender:tobject);
    procedure RadioButton2Click(Sender: TObject);
    procedure MontaCopiaDosPrecosPorItem(sender:tobject);
    procedure CheckBox16Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   ENTER = #13;
   HOME = ^w;
   TAB  = #09;
   TITULO = 'Export Inteq -> SIC - 12 ';
var
  Form1: TForm1;
  Linha:String;
implementation

{$R *.DFM}

function EhCodigo(str:string):boolean;
const
   aux = '0123456789';
var
   i:real;
begin
     EhCodigo := true;
   try
      i:= StrToFloat(Str)
   except
      EhCodigo := false;
   end;
end;


function ajustacodigo(codigo:string):string;
begin
   while length(codigo) < 13 do
      insert(' ',codigo,length(codigo)+1);
   ajustacodigo := codigo;
end;

function ajustapreco(tam:integer;preco:string):string;
begin
   while length(preco) < tam do
      insert('0',preco,01);
   Ajustapreco:=preco
end;

function RelacaoDeLojas :string;
var
   lojas:string;
   j,i:integer;
begin
   i:=0;
      if form1.CheckBox1.Checked then
      begin
         inc(i);
          lojas:=lojas+'01';
      end;
      if form1.CheckBox2.Checked then
      begin
         inc(i);
         lojas:=lojas+'03';
      end;
      if form1.CheckBox3.Checked then
      begin
         inc(i);
         lojas:=lojas+'05';
      end;
      if form1.CheckBox4.Checked then
      begin
         inc(i);
          lojas:=lojas+'06';
      end;
      if form1.CheckBox5.Checked then
      begin
         inc(i);
          lojas:=lojas+'10';
      end;
      if form1.CheckBox6.Checked then
      begin
         inc(i);
          lojas:=lojas+'11';
      end;
      if form1.CheckBox7.Checked then
      begin
         inc(i);
         lojas:=lojas+'12';
      end;
      if form1.CheckBox8.Checked then
      begin
         inc(i);
         lojas:=lojas+'17';
      end;
      if form1.CheckBox9.Checked then
      begin
         inc(i);
         lojas:=lojas+'08';
      end;
      if form1.CheckBox10.Checked then
      begin
         inc(i);
         lojas:=lojas+'09';
      end;
      if form1.CheckBox11.Checked then
      begin
         inc(i);
         lojas:=lojas+'16';
      end;
      if form1.CheckBox12.Checked then
      begin
         inc(i);
          lojas:=lojas+'18';
      end;
      if form1.CheckBox13.Checked then
      begin
         inc(i);
          lojas:=lojas+'02';
      end;
      if form1.CheckBox14.Checked then
      begin
         inc(i);
          lojas:=lojas+'04';
      end;
      if form1.CheckBox15.Checked then
      begin
         inc(i);
         lojas:=lojas+'14';
      end;
      for j:=i to 13 do
         lojas:= lojas + TAB;
   RelacaoDeLojas := lojas;
end;

function EhArquivoValido(conteudoALocalizar:string):boolean;
var
   achou:boolean;
   arq:textfile;
   linha:string;
   i:integer;
begin
   achou := false;
   EhArquivoValido:= false;
   assignfile(arq, form1.opendialog1.filename);
   reset(arq);

   for i:=1 to 50 do
   begin
      readln(arq,linha);
      if pos(conteudoALocalizar , linha) > 0 then
         achou := true;
   end;
   closefile(arq);
   if achou = true  then
      EhArquivoValido := true;

end;

procedure tform1.MarcarDesmarcaLojasDeFOra(sender:tobject);
begin
   checkbox9.Checked := not(checkbox9.Checked );
   checkbox10.Checked := not(checkbox10.Checked );
   checkbox11.Checked := not(checkbox11.checked );
   checkbox12.Checked := not(checkbox12.Checked );

end;
procedure tform1.MarcarDesmarcaLojasFortaleza(sender:tobject);
begin
   checkbox1.Checked := true;
   checkbox2.Checked := true;
   checkbox3.Checked := true;
   checkbox4.Checked := true;
   checkbox5.Checked := true;
   checkbox6.Checked := true;
   checkbox7.Checked := true;
   checkbox8.Checked := true;
end;


function posicaoDopreconovo:integer;
var
   arq:textfile;
   AUX,linha:string;

begin
   AUX:= 'Preço Novo';
   assignfile(arq,form1.opendialog1.filename);
   reset(arq);
   while eof(arq) = false do
   begin
      readln(arq,linha);
      if pos(AUX,LINHA) > 0 then
         begin
            posicaoDopreconovo := pos(AUX,LINHA);
         end;
   end;
   closeFile(arq);
end;

function tiraEspaco(str:string):string;
begin
   while pos(' ',str)>0 do
     delete(Str,pos(' ',str),01);
   tiraEspaco := str;
end;

procedure Tform1.carregarListaDeprecos(sender:tobject);
var
  arq:textfile;
  aux,linha:string;
  posPreco,i:integer;

begin
  screen.cursor := CrHourGlass;
  statusbar1.simpletext:=('Carregando, aguarde...');
  posPreco:=0;
  posPreco:= PosicaoDoPrecoNovo();
  i:=0;
  assignFile(arq,opendialog1.filename);
  reset(arq);

  aux:= copy(linha,posPreco,10);
  while eof(arq) = false do
  begin
     readln(arq,linha);
     if (copy(linha,08,02) = '  ') and ( copy(linha,01,07) <> '       ') and( ( copy(linha,07,01) <> ' ') ) and( ( copy(linha,01,01) <> ' ') )then
     begin
        inc(i);
        memo1.lines.add(ajustapreco(5,IntToStr(i))+ ' ' +  copy(linha,01,08) + '       ' + copy(linha,posPreco,11) )
     end;
  end;
  closeFile(arq);
  statusbar1.simpletext:=('Deletando os vazios');

  for i:= 0 to memo1.lines.Count - 1 do
  begin
     if  tiraEspaco(copy(memo1.lines[i],15,30)) = '0,00' then
     begin
         memo2.lines.add(memo1.lines[i]);
         memo1.lines.Delete(i);
     end;
  end;

  if memo2.lines.Count  > 0 then
  begin
     linha :=  opendialog1.FileName;
     insert('_PrecosZerados',linha,pos('.txt',linha));
     memo2.lines.SaveToFile(linha);
     application.MessageBox(Pchar('Os preços zerados desta tabela foram copiados para' +#13+ 'O arquivo: '+ linha),TITULO,MB_OK+MB_ICONWARNING);
  end;

  statusbar1.simpletext:=('Pronto para copiar');
  screen.cursor := CrDefault;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
   label1.caption:= '';
   if opendialog1.execute then
   begin
      if (EhArquivoValido('Listagem de Tabela de Precos por Data de Reajuste') = true) or
         (EhArquivoValido('Tabela Geral de Precos')=true) then
      begin
         carregarListaDeprecos(sender);
         label1.caption := opendialog1.filename;
      end
      else
      begin
         application.messagebox(#13+'Este arquivo nao é um arquivo de reajuste gerado pela Inteq'+#13+'Lembre que o relatorio é  ->Listagem de Tabela de Precos por Data de Reajuste',TITULO ,MB_ICONEXCLAMATION);
         label1.caption:= 'Clique aqui para escolher o arquivo..'
      end;
   end;
end;

procedure tform1.MontaCopiaDosPrecos(sender:tobject);
var
   mensagem:string;
   j,i:integer;
begin
   j:=0;
   linha:= linha + HOME + 'REPVV' +#13+ HOME +  TAB + '1' +  RelacaoDeLojas ;

   if rg1.ItemIndex = 0 then
      linha := linha + 'V'
   else
      linha := linha + 'P';


   if rg1.ItemIndex = 0 then
      linha := linha + MASKEDIT1.TEXT + TAB
   else
      linha := linha + MASKEDIT1.TEXT + '311209';

   for i:= 0 to 31 do
   begin
      if i < memo1.lines.count then
      begin
         linha := linha + AjustaCodigo( copy(memo1.lines[i],07,07))  + Ajustapreco(12,copy(memo1.lines[i],22,11));

         statusbar1.simpletext := ( inttostr(memo1.lines.count));
         statusbar1.simpletext := (  copy(memo1.lines[i],07,07)+'   '+ Ajustapreco(12,copy(memo1.lines[i],22,11)));
         inc(j);
      end
      else
         linha := linha + AjustaCodigo(' ') + Ajustapreco(12,'0');
   end;
   linha:= linha + home;


   if j  < 30 then
      mensagem :='    - '+ inttoStr(j) + ' códigos estão prontos para colar ' + #13
   else
      mensagem := '   - Os 30 primeiros preços estão prontos para colar e irão sair da lista '+#13 ;

   mensagem := mensagem    + #13+ '   Agora vá para a transação REPVV do SIC, clique com o botão direito do mouse' +#13
                +  'e escolha a opção "PASTE"';

   for i:=1 to j do
   begin
      statusbar1.simpletext := (  'Deletando ' + memo1.lines[i]);
      memo1.lines.Delete(0);
   end;
  statusbar1.simpletext:=' OK ';
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
   FORM1.CAPTION:= TITULO;
   Maskedit1.text:= DateTostr(now);
   CheckBox16Click(Sender);
end;
procedure TForm1.Memo1Click(Sender: TObject);
var
column,line:integer;
begin

With Memo1 do
begin
   Line:= Perform(EM_LINEFROMCHAR,SelStart, 0);
   Column:= SelStart - Perform(EM_LINEINDEX, Line, 0);
end;

   statusbar1.simpletext:= 'linha ' +inttoStr(Line+1) +  ' coluna '+  inttoStr(Column);
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
   if radiobutton1.Checked then
   begin
      checkbox1.Checked := true;
      checkbox2.Checked := true;
      checkbox3.Checked := true;
      checkbox4.Checked := true;
      checkbox5.Checked := true;
      checkbox6.Checked := true;
      checkbox7.Checked := true;
      checkbox8.Checked := true;
      checkbox13.Checked := true;
      checkbox14.Checked := true;
      checkbox15.Checked := true;
      checkbox9.Checked :=  false;
      checkbox10.Checked := false;
      checkbox11.Checked := false;
      checkbox12.Checked := false;
   end;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
   if radiobutton2.Checked then
   begin
      checkbox1.Checked := false;
      checkbox2.Checked := false;
      checkbox3.Checked := false;
      checkbox4.Checked := false;
      checkbox5.Checked := false;
      checkbox6.Checked := false;
      checkbox7.Checked := false;
      checkbox8.Checked := false;
      checkbox13.Checked := false;
      checkbox14.Checked := false;
      checkbox15.Checked := false;
      checkbox9.Checked :=  true;
      checkbox10.Checked := true;
      checkbox11.Checked := true;
      checkbox12.Checked := true;
   end;end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i:integer;
begin
   clipboard.Clear;
   screen.cursor:= crhourglass;
   if (maskedit1.Text <> '  /  /  ') and (memo1.lines.count > 0)  then
   begin
      linha := '';
      for i := 1 to  StrToInt(Sedit1.text) do
      begin
         if checkBox16.Checked = false then
            MontaCopiaDosPrecos(sender)
         else
            MontaCopiaDosPrecosPorItem(sender);
         linha := LINHA + ENTER;
         clipboard.AsText := linha;
         statusbar1.SimpleText := 'Telas REPVV :' + IntToStr(i);
         sleep(100);
      end;
   end
   else
      application.MessageBox(#13+ 'Nao há precos para copiar',TITULO,MB_ICONEXCLAMATION ); //MB_iconquestion
   screen.cursor:= crdefault;
   maskedit1.setfocus;
end;


procedure tform1.MontaCopiaDosPrecosPorItem(sender:tobject);
var
   mensagem:string;
   j,i:integer;
begin
   j:=0;
   linha:= linha + HOME + 'REPVV' +#13+ HOME +  TAB + '1' +  RelacaoDeLojas ;

   if rg1.ItemIndex = 0 then
      linha := linha + 'V'
   else
      linha := linha + 'P';


   if rg1.ItemIndex = 0 then
      linha := linha + MASKEDIT1.TEXT + TAB
   else
      linha := linha + MASKEDIT1.TEXT + '311209';

   for i:= 0 to 0 do
   begin
      if i < memo1.lines.count then
      begin
         linha := linha + AjustaCodigo( copy(memo1.lines[i],07,07))  + Ajustapreco(12,copy(memo1.lines[i],22,11));

         statusbar1.simpletext := ( inttostr(memo1.lines.count));
         statusbar1.simpletext := (  copy(memo1.lines[i],07,07)+'   '+ Ajustapreco(12,copy(memo1.lines[i],22,11)));
         inc(j);
      end
      else
         linha := linha + AjustaCodigo(' ') + Ajustapreco(12,'0');
   end;
   linha:= linha + home;

   for i:=1 to j do
   begin
      statusbar1.simpletext := (  'Deletando ' + memo1.lines[i]);
      memo1.lines.Delete(0);
   end;
  statusbar1.simpletext:=' OK ';
end;



procedure TForm1.CheckBox16Click(Sender: TObject);
begin
   if checkBox16.Checked = true then
   begin
      sedit1.maxvalue := 450;
      label3.Caption := 'Rep (max 450)';
   end
   else
   begin
      sedit1.maxvalue := 15;
      label3.Caption := 'Rep (max 015)';
   end;

end;

end.
