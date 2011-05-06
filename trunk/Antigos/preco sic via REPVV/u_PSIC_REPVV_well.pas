unit u_PSIC_REPVV_well;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,clipbrd, ComCtrls, Mask, Spin, DB, ADODB,
  mxExport,funcoes, CheckLst;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    MaskEdit1: TMaskEdit;
    Label2: TLabel;
    SEdit1: TSpinEdit;
    Label3: TLabel;
    RG1: TRadioGroup;
    Memo2: TMemo;
    CheckBox16: TCheckBox;
    DT: TDateTimePicker;
    cb1: TComboBox;
    Button1: TButton;
    export1: TmxDataSetExport;
    Query1: TADOQuery;
    Clb1: TCheckListBox;
    Label1: TLabel;
    ADOConnection1: TADOConnection;
    procedure BitBtn1Click(Sender: TObject);
//    procedure carregarListaDeprecos(sender:tobject);
    procedure MontaCopiaDosPrecos(sender:tobject);
    procedure FormActivate(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure MarcarDesmarcaLojasFortaleza(sender:tobject);
    procedure MarcarDesmarcaLojasDeFOra(sender:tobject);
    procedure RadioButton2Click(Sender: TObject);
    procedure MontaCopiaDosPrecosPorItem(sender:tobject);
    procedure CheckBox16Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CarregaLojas(sender:tobject);
    function RelacaoDeLojas(sender:tobject) :string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   ENTER = #13;
   HOME = ^w;
   TAB  = #09;
   TITULO = 'Exporta preços Welll -> SIC 14';
var
  Form1: TForm1;
  Linha:String;
  Path:string;
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


function tform1.RelacaoDeLojas(sender:tobject) :string;
var
   lojas:string;
   j,i:integer;
begin
   j:=0;
   i:=0;
   for i:=0 to clb1.items.Count -1 do
      if clb1.Checked[i] = true then
      begin
         inc(j);
         lojas:=lojas+clb1.Items[i];
      end;

   for i:=j to 13 do
      lojas:= lojas + TAB;

   RelacaoDeLojas := lojas;
{
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
}





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
//   checkbox9.Checked := not(checkbox9.Checked );
//   checkbox10.Checked := not(checkbox10.Checked );
//   checkbox11.Checked := not(checkbox11.checked );
///   checkbox12.Checked := not(checkbox12.Checked );
end;
procedure tform1.MarcarDesmarcaLojasFortaleza(sender:tobject);
begin
{
   checkbox1.Checked := true;
   checkbox2.Checked := true;
   checkbox3.Checked := true;
   checkbox4.Checked := true;
   checkbox5.Checked := true;
   checkbox6.Checked := true;
   checkbox7.Checked := true;
   checkbox8.Checked := true;
}
end;

{
function posicaoDopreconovo:integer;
var
   arq:textfile;
   AUX,linha:string;
begin
   AUX:= 'Preço Novo';
//   assignfile(arq,form1.opendialog1.filename);
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
}

function tiraEspaco(str:string):string;
begin
   while pos(' ',str)>0 do
     delete(Str,pos(' ',str),01);
   tiraEspaco := str;
end;
{
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
//  assignFile(arq,opendialog1.filename);
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
//     linha :=  opendialog1.FileName;
     insert('_PrecosZerados',linha,pos('.txt',linha));
     memo2.lines.SaveToFile(linha);
     application.MessageBox(Pchar('Os preços zerados desta tabela foram copiados para' +#13+ 'O arquivo: '+ linha),TITULO,MB_OK+MB_ICONWARNING);
  end;

  statusbar1.simpletext:=('Pronto para copiar');
  screen.cursor := CrDefault;
end;
}
procedure tform1.MontaCopiaDosPrecos(sender:tobject);
var
   mensagem:string;
   j,i:integer;
begin
   j:=0;
   linha:= linha + HOME + 'REPVV' +#13+ HOME +  TAB + '1' +  RelacaoDeLojas(sender); ;

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
   path := ExtractFilePath(paramStr(0));

   Maskedit1.text:= DateTostr(now);
   CheckBox16Click(Sender);
   dt.DateTime := now();
   CarregaLojas(sender);
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
{
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
   }
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
{
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
   end;
}   
end;

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
         sleep(50);
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
   linha:= linha + HOME + 'REPVV' +#13+ HOME +  TAB + '1' +  RelacaoDeLojas(sender);

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
      label3.Caption := 'Repetir (max 450)';
      sedit1.Value := memo1.lines.count
   end
   else
   begin
      sedit1.maxvalue := 15;
      label3.Caption := 'Repetir (max 015)';
      sedit1.Value := (memo1.lines.count div 32) +1
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  loja,CodPreco,str,aux:string;
  arq:textfile;
  lista:TstringList;
  i,j:integer;
begin
   screen.Cursor := crhourglass;

   STR:= DateToStr(DT.date);
   query1.SQL.Clear;
   memo1.Lines.Clear;

   case cb1.itemindex of
      00:begin
            codpreco := '101';
            loja := '10033586';
         end;
      01: begin
             codpreco := '103';
             loja := '10033586';
          end;
      02: begin
             codpreco := '110';
             loja :='10033592';
          end;
      03: begin
             codpreco := '111';
             loja :='10033592';
          end;
      04: begin
             codpreco := '105';
             loja :='10033591';
          end;
      05: begin
             codpreco := '106';
             loja :='10033591';
          end;
   end;

   with query1.sql do
   begin
      clear;
      add(' declare @data as smalldatetime declare @tpPreco as int declare @Loja as int');
      add(' set @data = '+ quotedStr( funcoes.StrToSqlDate( DatetoStr(dt.Date ))) ) ;
      add(' set @loja = '+ loja );
      add(' set @tppreco ='+ codpreco);
      add(' SELECT CREFE.CD_REF , CREFE.DS_REF, DSALP1.VL_PRECO * 1.00');
      add(' FROM ( (crefe WITH(NOLOCK) Inner Join dspes WITH(NOLOCK) on crefe.cd_pes = dspes.cd_pes) ');
      add(' LEFT JOIN (SELECT dsalp.is_oap,dsalp.is_ref, dsalp.dt_altpv,dsalp.vl_preco,dsalp.tp_Preco,');
      add(' dsalp.is_uo,viwPrecosProdutosAlteradosPorPeriodo.is_alp FROM dsalp WITH(NOLOCK) INNER JOIN');
      add(' viwPrecosProdutosAlteradosPorPeriodo ON dsalp.is_ref=viwPrecosProdutosAlteradosPorPeriodo.is_ref');
      add(' AND dsalp.is_alp=viwPrecosProdutosAlteradosPorPeriodo.is_alp AND dsalp.is_uo=viwPrecosProdutosAlteradosPorPeriodo.is_uo');
      add(' AND dsalp.tp_preco = viwPrecosProdutosAlteradosPorPeriodo.tp_preco WHERE  dsalp.dt_altpv =  @data ');
      add(' AND dsalp.is_uo = @loja AND dsalp.tp_preco = @tppreco )dsalp1 ON crefe.is_ref = dsalp1.is_ref) INNER ');
      add(' JOIN (SELECT dsalp.dt_altpv AS dt_altpv2,dsalp.vl_preco AS vl_preco2,dsalp.is_alp,dsalp.tp_Preco,dsalp.is_uo, ');
      add(' dsalp.Is_ref FROM dsalp WITH(NOLOCK) inner join (SELECT dsalp.is_uo,dsalp.tp_preco,dsalp.is_ref,max(dsalp.is_alp) ');
      add(' AS is_alp FROM dsalp WITH(NOLOCK) INNER JOIN viwPrecosProdutosAlteradosPorPeriodo ON ');
      add(' dsalp.is_alp < viwPrecosProdutosAlteradosPorPeriodo.is_alp AND dsalp.is_uo = viwPrecosProdutosAlteradosPorPeriodo.is_uo ');
      add(' AND dsalp.tp_preco = viwPrecosProdutosAlteradosPorPeriodo.tp_preco AND dsalp.Is_ref = viwPrecosProdutosAlteradosPorPeriodo.Is_ref ');
      add(' GROUP BY dsalp.is_uo,dsalp.tp_preco,dsalp.Is_ref)PenultReajPreco ON dsalp.is_UO = PenultReajPreco.is_UO AND ');
      add(' dsalp.tp_preco= PenultReajPreco.tp_preco AND dsalp.is_ref = PenultReajPreco.is_ref AND dsalp.is_alp = PenultReajPreco.is_alp ');
      add(' WHERE dsalp.is_uo = @loja  AND dsalp.tp_preco = @tppreco )dsalp2 ON dsalp1.is_ref = dsalp2.is_ref AND ');
      add(' dsalp1.tp_preco = dsalp2.tp_preco AND dsalp1.is_uo = dsalp2.is_uo inner join dsoap (nolock) on ');
      add(' dsalp1.is_oap = dsoap.is_oap inner join (select cd_pes,nm_pes as nm_usu from dspes (nolock)) as dsusu ');
      add(' on dsoap.cd_usu = dsusu.cd_pes WHERE  dsalp1.is_uo = @loja  ORDER BY DSALP1.DT_ALTPV,CREFE.IS_REF ');
   end;

//   QUERY1.SQL.SAVETOFILE('C:\qUERYrEAJUSTEDEPRECOS.TXT');
   query1.Open;

   export1.FileName := ExtractFilePath(ParamStr(0)) + 'temp.txt';
   export1.Execute;

   AssignFile(arq, export1.FileName );
   reset(arq);

   lista := tstringlist.Create;
   while eof(arq) = false do
   begin
      readln(arq,str);
      if funcoes.EhCodigo(copy(str,01,07)) = true then
         lista.Add(str);
   end;
   closefile(arq);
//   lista.SaveToFile('c:\teste.txt');

   for i:= 0 to lista.count-1 do
      memo1.lines.add(funcoes.preencheCampo(05,'0','e',IntToStr(memo1.lines.count+1)) +' '+ copy(lista[i],01,07) +' ' +funcoes.preencheCampo(17,' ','e',StrTomoney(funcoes.tiraEspaco( copy(lista[i],73,10) ) ))  );

  DeleteFile(export1.FileName );

  screen.Cursor := crdefault;
end;

procedure TForm1.CarregaLojas(sender: tobject);
var
   lojas:tstringlist;
   i:integer;
begin

   lojas:= tstringlist.Create;
   lojas.LoadFromFile(patH+ 'LojasPorPrecoSIC.ini');

   for i:=0 to lojas.count -1 do
   begin
      clb1.Items.Add(copy(lojas[i],01, pos(',', lojas[i])-1));
      if copy(lojas[i],04,01) = '1' then
         clb1.Checked[i] := true;
   end;

end;

end.
