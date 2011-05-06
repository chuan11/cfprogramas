unit Uimpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, adLabelMaskEdit, adLabelComboBox,
  Buttons, DB, Grids, DBGrids, ADODB, mxExport,printers, DBTables, ExtCtrls, ContCheques,funcoes;

type
  TForm2 = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    rgroup: TRadioGroup;
    medit1: TadLabelMaskEdit;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure MontaArquivoImpressao(sender:Tobject);
    procedure MandarParaImpressora(sender:TObject);
    procedure imprimeMatricial(sender:TObject);
    procedure imprimeDeskjet(sender:TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregaRegistros(sender:tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   BAT_DE_IMPRESSAO = PATH + 'imprime.bat';
   ARQ_DE_IMPRESSAO = PATH + 'impressao.txt' ;
var
  Form2: TForm2;

implementation

{$R *.dfm}

function AjustaLinha(str:string):string;
var
   aux:string;
begin
   aux := copy(str,19,03) +' - '+ copy(str,40,30) + funcoes.preencheCampo(10,' ','e',funcoes.tiraespaco(copy(str,90,10))) + copy(str,100,12)+ funcoes.preencheCampo(12,' ','e', floattostrf(  form1.TiraPontos( copy(str,124,10) ),ffNumber,18,2) ) + '  _______________________________';
   AjustaLinha:= aux;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
   funcoes.gravaParam(ARQ_INI,IntToStr(Rgroup.ItemIndex),03);
   form2.Close;
   form1.CarregaQuery(sender);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
end;

procedure tform2.MontaArquivoImpressao(sender:Tobject);
var
   origem,dest:textFile;
   aux,lin:string;
   NumLin,l,fl:integer;
begin
   numLin := 78;
   assignFile( origem, form1.Export1.FileName );
   reset( origem );

   assignFile( dest, ARQ_DE_IMPRESSAO);
   rewrite( dest );
   fl:=0;
   while eof( origem ) = false do
   begin
      inc(fl);
      writeln( dest ,'FOLHA: '+ AjustaNumPag(IntToStr(fl))+'                          RELATORIO DE CHEQUES DEVOLVIDOS');
      writeln( dest,'');
      writeln( dest ,'Lancados em : ' + medit1.text);
      writeln( dest ,'');
      writeln( dest,'----------------------------------------[DADOS DOS CHEQUES]---------------------------------------------------------');
      writeln( dest,'LJ    CLIENTE                           N CH    VENC          VALOR     OBSERVACAO');
      l:=0;
      while ( l < numLin ) and ( eof(origem) = false ) do
      begin
         inc(l);
         readln(origem,lin);
         inc(l);
         writeln(dest, ' ');
         writeln(dest , AjustaLinha(lin));
      end;
      if ( eof(origem) = false ) then
      begin
         writeln( dest, '');
         writeln( dest, '------------------------------------------------------------------------------------------------------------------------------------');
         writeln( dest,'');
         l:=0
      end
      else
      begin
         while ( l < (numLin + 2) ) do
         begin
            writeln(dest,'');
            inc(l);
         end;
         writeln( dest, '------------------------------------------------------------------------------------------------------------------------------------');
      end;

   end;
   closefile(origem);
   closefile(dest);
   winexec(pchar('notepad '+ARQ_DE_IMPRESSAO),SW_SHOWNORMAL);
end;


procedure tform2.MandarParaImpressora(sender:TObject);
begin
   if rgroup.ItemIndex = 0 then
      imprimeMatricial(sender)
   else
      imprimeDeskjet(sender);
end;


procedure tform2.imprimeDeskjet(sender:TObject);
var
   arq:textFile;
   lin:string;
   espaco,i:integer;
begin
   assignFile(arq,PATH+'impressao.txt');
   reset(arq);
   i:=0;
   espaco := 15;
   with printer do
   begin
      beginDoc;
      printer.canvas.font.name := 'Courier new';
      printer.canvas.font.Height:= 08;
      if rgroup.ItemIndex = 1 then
      begin
         printer.canvas.font.Height:=44;
         espaco:=30;
      end;
      while eof(arq) = false do
      begin
         i:= i + espaco;
         readln(arq,lin);
         if pos('',lin) > 0 then
         begin
            i:=0;
            printer.NewPage;
         end;
         printer.Canvas.TextOut(01,i,lin);
      end;
      endDoc;
   end;
   CloseFile(arq);
end;

procedure tform2.imprimeMatricial(sender:TObject);
var
   arq:textFile;
   lin:string;
   espaco,i:integer;
begin
   AssignFile(arq,BAT_DE_IMPRESSAO);
   rewrite(arq);
   writeln(arq,'copy '+ ARQ_DE_IMPRESSAO + ' LPT1');
   closefile(arq);
   WinExec(BAT_DE_IMPRESSAO,sw_HIDE);
end;

procedure tform2.CarregaRegistros(sender:tobject);
begin
   with form1.query1.SQL do
   begin
      clear;
      add('Select Ref, loja, cliente, Numcheque, Vencimento, Valor, Observacao, lancamento from cheques');
      add('where  lancamento ="'+form1.Ajustadata(medit1.text )+'"'    );
      savetofile('c:\zteste.txt');
   end;
   form1.query1.open;
   form1.label1.caption:='';
   form1.label1.caption := 'Total: ' + form1.SomaValores(sender);
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
      StrToDate(medit1.text);
      CarregaRegistros(sender);
      MontaArquivoImpressao(sender);
   MandarParaImpressora(sender);
      BitBtn3Click(Sender);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
   Rgroup.ItemIndex :=   StrToInt(funcoes.lerParam(ARQ_INI,03));
   form2.Top:= form1.top+200;
   form2.left := form1.Left+300;
   medit1.text:= dateToStr(now);
   mEdit1.SetFocus;
end;

end.
