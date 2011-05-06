unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,funcoes, TFlatButtonUnit, StdCtrls, adLabelEdit, DB, ADODB,
  Grids, DBGrids, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    connection: TADOConnection;
    q1: TADOQuery;
    Edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    q2: TADOQuery;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    edit2: TadLabelEdit;
    Rg1: TRadioGroup;
    FlatButton2: TFlatButton;
    CheckBox1: TCheckBox;
    FlatButton3: TFlatButton;
    SB1: TStatusBar;
    FlatButton4: TFlatButton;
    Label1: TLabel;
    procedure Edit1DblClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    function EhCodigoValido(Str:string;Sender:tobject):String;
    function EhJaContado(lj,Str,is_ref:string;Sender:tobject):boolean;
    function IncluiItemNaContagem(lj, cod, qt,ean, is_ref: String; Sender: tobject): boolean;
    function IncluirQuantidade(Cod,Qt,lj,is_ref:string; Adicionar:integer;Sender:tobject):boolean;
    function  ajustaDescricao(cod,Str: string; Sender: tobject): boolean;
    function TemDescricao(Str: string; Sender: tobject): boolean;
    procedure FlatButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure limpamemos(sender:tobject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ljI,LjT,codI,Codt,qtI,qtT,eanI,EanT:integer;
implementation
{$R *.dfm}
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.gravaParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',edit1.text,00);
   funcoes.gravaParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',edit2.text,01);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   connection.Connected := false;
   if paramstr(1) <> '' then
      connection.ConnectionString := paramstr(1)
   else
      funcoes.MsgTela('','Falta o arquivo de conexao ao Well ( conexaoAoWell.ini', mb_IconError+mb_ok);

   edit1.text := funcoes.lerParam(ExtractFilePath(ParamStr(0)) + 'ConsolidaInventario.ini',00);
   edit2.text := funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',01);
   ljI:=  StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',02));  //01
   ljT:=  StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',03));  //03;
   codI:= StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',04));  // 05;  // posicao do inicio do codigo
   codT:= StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',05));  //07;   // taqmnho do codigo
   eanI:= StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',06));  // 22;
   eanT:= StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',07));  // 13;
   qtI := StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',08));  // 18;
   qtT := StrToint(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'ConsolidaInventario.ini',09));  // 05;
end;


procedure TForm1.Edit1DblClick(Sender: TObject);
begin
   edit1.text := funcoes.DialogAbrArq('*.txt;*.prn |*.txt;*.prn', 'c:\');
end;

function TForm1.EhCodigoValido(Str: string; Sender: tobject): string;
var
   aux:string;
begin
   q1.SQL.Clear;
//   aux := 'Z_CF_getInformacoesProduto '+ QUOTEDSTR (FUNCOES.tiraEspaco((funcoes.SohNumeros(str)))); + ' , 10033586, 101';
   aux := 'Z_CF_getInformacoesProduto '+ QUOTEDSTR (FUNCOES.tiraEspaco((funcoes.SohNumeros(str))))  + ' , 10033586, 101';
   q1.sql.add(aux);
//   funcoes.GravaLinhaEmUmArquivo('c:\ConsultaProduto.txt',aux);
   q1.Open;

   if q1.isempty = true then
      EhCodigoValido := ''
   else
      EhCodigoValido := q1.FieldByName('is_ref').AsString;
   form1.Refresh;
end;

function TForm1.TemDescricao(Str: string; Sender: tobject): boolean;
begin
   q1.SQL.Clear;
   q1.sql.add('Select ds_ref from crefe where cd_ref = '+ quotedstr(Str));
   q1.Open;
end;

function TForm1.EhJaContado(lj,Str,is_ref: string; Sender: tobject): boolean;
begin
   q1.SQL.Clear;
   q1.sql.add('Select qt from ZContloja where loja = ' + quotedStr(lj)+ ' and is_ref = ' + quotedStr(is_ref) );
   q1.Open;

   if q1.isempty = true then
      EhJaContado := false
   else
      EhJaContado := true
end;

function TForm1.IncluiItemNaContagem(lj, cod, qt,ean, is_ref: String; Sender: tobject): boolean;
var
  aux:string;
begin
   aux := '';
   q2.SQL.Clear;
   aux:= (' Insert ZContloja (cod, qt, loja, ean, is_ref) values( ' + quotedStr(trim(cod)) +', '+ qt +', '+ Quotedstr(lj)+', '+ Quotedstr(ean)+', '+ Quotedstr(is_ref)   +')');
   q2.sql.add(aux);
   funcoes.GravaLinhaEmUmArquivo( extractFilePath(paramStr(0)) +  ' zadicionacontagem.txt',aux);
   q2.ExecSQL;
end;

function TForm1.IncluirQuantidade(Cod, Qt, lj, is_ref: string;  Adicionar:integer; Sender:tobject): boolean;
var
  aux:char;
  comando:string;
begin
  if Adicionar = 0 then
     aux:= '+'
  else
     aux:= '-';

  q2.SQL.Clear;
  comando := (' update zContLoja set qt = qt '+aux +'('+ qt  +') where is_ref = ' + funcoes.tiraEspaco(  quotedStr(is_ref) ) + ' and loja = ' + quotedStr(lj) );
  q2.SQL.Add(comando);
  funcoes.GravaLinhaEmUmArquivo('c:\zateraitenscontagem.txt',comando);
  q2.ExecSQL;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   arq:Tstringlist;
   i:integer;
   is_ref:string;
begin
   limpamemos(sender);
   screen.Cursor := crHourglass;
   arq := Tstringlist.Create;
   arq.LoadFromFile(edit1.text);


   for i:= 0 to arq.count -1  do
   begin
      is_ref := EhCodigoValido(copy(arq[i],codI,codT),sender);
      form1.Refresh;
      sb1.SimpleText := InttoStr(i) + ' de ' +InttoStr( arq.count -1 );

      if is_ref <> '' then
      begin

         if EhJaContado( edit2.text, trim(copy(arq[i],codI,codT)), is_ref,  sender) = false then
         begin
            if rg1.ItemIndex = 0 then
            begin
//               IncluiItemNaContagem(edit2.text, copy(arq[i],codI,codT), funcoes.SohNumeros(copy(arq[i],qtI,qtT)),funcoes.SohNumeros(copy(arq[i],eanI,eanT)), is_ref, sender );

               IncluiItemNaContagem(edit2.text, copy(arq[i],codI,codT), funcoes.tiraEspaco(copy(arq[i],qtI,qtT)),funcoes.SohNumeros(copy(arq[i],eanI,eanT)), is_ref, sender );
               memo1.lines.add( IntToStr(i) + ' - incluido: ' + copy(arq[i],codI,codT) );
            end
         end
         else
         begin
            IncluirQuantidade( copy(arq[i],codI,codT), funcoes.tiraEspaco(copy(arq[i],qtI,qtT)),edit2.text, is_ref, rg1.ItemIndex, sender);
            memo2.lines.add( IntToStr(i) + '  '+ copy(arq[i],codI,codT) +' - repetido ' + funcoes.SohNumeros(copy(arq[i],qtI,qtT)) );
         end;

      end
      else
         memo3.lines.add( IntToStr(i) + '  '+ copy(arq[i],codI,codT) +'  - codigo invalido' );

      form1.Refresh;
   end;
   memo1.Lines.SaveToFile(edit2.text+'_Itens_contados.txt');
   memo2.Lines.SaveToFile(edit2.text+'_Itens_AdicionadosNaContagem.txt');
   memo3.Lines.SaveToFile(edit2.text+'_Itens_NaoEncontrados.txt');
   screen.Cursor := crDefault;
end;

function TForm1.ajustaDescricao(cod,Str: string; Sender: tobject): boolean;
var
   aux:string;
begin
   aux:= ' update crefe set ds_ref = '+ quotedstr(str) + ' where cd_ref = ' + quotedstr(cod);
   memo3.Lines.Add(aux);
   q1.SQL.Clear;
   q1.sql.add(aux);
   q1.execSql
end;


procedure TForm1.FlatButton2Click(Sender: TObject);
var
   arq,dest:Tstringlist;
   aux:String;
   i:integer;
begin
   limpamemos(sender);
   screen.Cursor := crHourglass;
   arq := Tstringlist.Create;
   dest := Tstringlist.Create;
   arq.LoadFromFile(edit1.text);

   for i:= 0 to arq.count -1 do
   begin
      form1.Refresh;
      if EhCodigoValido(copy(arq[i],codI,codT),sender) = '' then
      begin
         memo1.lines.add('Nao achei item da  linha: ' + inttoStr(i+1)+':'+copy(arq[i],codI,codT));
      end
      else
      begin
         dest.Add(arq[i]);
         memo2.lines.add('Item ' + inttoStr(i+1)+' OK :'+copy(arq[i],codI,codT));
      end;
   end;

   if checkbox1.Checked = true then
      dest.SaveToFile(edit1.text);

   aux:= edit1.text;
   insert('_ItensNaoCadastrados',aux,length(aux)-3);

   if memo1.Lines.Count > 0 then
      memo1.lines.SaveToFile(aux);

   screen.Cursor := crDefault;
end;

procedure TForm1.limpamemos(sender: tobject);
begin
   memo1.lines.Clear;
   memo2.lines.Clear;
   memo3.lines.Clear;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
var
   arq:string;
begin
   arq := extractFilePath(paramStr(0)) + 'Arq_Coletor_Well_'+ edit2.text +'.txt';
   limpamemos(sender);
   q1.SQL.Clear;
   q1.SQL.Add('Select cod, qt from Zcontloja where qt > -1 and loja = ' + quotedStr(edit2.text) );
   q1.open;
   q1.First;

   while q1.Eof = false do
   begin
       memo1.Lines.Add(
                        funcoes.preencheCampo(04,'0','e', edit2.text)                       +
                        funcoes.preencheCampo(13,' ','D', q1.FieldByName('cod') .AsString) +
                        funcoes.preencheCampo(05,'0','E', q1.FieldByName('qt').AsString)
                      );
      Q1.Next;
   end;
   memo1.lines.SaveToFile(arq);
end;
//inttoStr(form1.query1.RecordCount)


procedure TForm1.FlatButton4Click(Sender: TObject);
begin
  winexec(pchar('notepad ' +extractFilePath(ParamStr(0))+ 'ConsolidaInventario.ini'),sw_normal);
end;

end.



