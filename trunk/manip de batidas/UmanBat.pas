unit UmanBat;

interface

uses
  ShellApi ,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, Gauges, Grids,
  DBGrids,  mxExport, Db, DBTables, DBCtrls, Menus, CheckLst,clipbrd,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ADODB, IdFTP,
  adLabelEdit, adLabelNumericEdit, adLabelSpinEdit,funcoes, FileCtrl, funcsql,
  SoftDBGrid;//, IdExplicitTLSClientServerBase;


type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    BitBtn9: TBitBtn;
    Label14: TLabel;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Button7: TButton;
    Memo2: TMemo;
    DataSource5: TDataSource;
    CLBox1: TCheckListBox;
    Label12: TLabel;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    dsListaHorarios: TDataSource;
    FindDialog1: TFindDialog;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    sedit1: TadLabelSpinEdit;
    Edit6: TEdit;
    Button9: TButton;
    Button11: TButton;
    Conexao: TADOConnection;
    qrListaHorarios: TADOQuery;
    conexaoWell: TADOConnection;
    tbEmpWell: TADOTable;
    MainMenu1: TMainMenu;
    Horarios1: TMenuItem;
    Cadastrodehorarios1: TMenuItem;
    CadastrodeEmpregados1: TMenuItem;
    Cadastrodeempregados2: TMenuItem;
    Funcoes1: TMenuItem;
    N1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure MaskEdit1Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure sg2SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure BitBtn12Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure OrganizaPorNome(sg2:TStringGrid);
    procedure impPontoPorDia(sender:Tobject);
    procedure AjustaRelatoriodePonto(sender:tobject);
    procedure MsgDeRodape(msg:string);
    procedure ajustaTelaParaAjusteFinos(sender:tobject;NomeArquivo:string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure procurarmemo2    (sender:tobject);
    procedure FindDialog1Find(Sender: TObject);
    procedure TabSheet4Exit(Sender: TObject);
    procedure TabSheet4Enter(Sender: TObject);
    procedure salvarMemo2(sender:tobject);
    procedure organizerpornome1Click(Sender: TObject);
    procedure qq1Click(Sender: TObject);
    function  ExisteJustificativa(sender:Tobject;linha:string):boolean;
    function  inserirBatidasDiaNormal(sender:Tobject;linha:string):string;
    function  FormatoDahora(x:integer):String;
    function  Atraso(batida,data,horarios:String):String;
    procedure Memo2KeyPress(Sender: TObject; var Key: Char);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure AjustaCadastro(sender:Tobject);
//    procedure BitBtn4Click(Sender: TObject);
    procedure AjustaHorFixoTodos(base:string);
    function NomedoDia(diasem:string):string;
    function r1(n:string):string;
    function r2(m:string):string;
    Function ProcuraEmCbox(sender:TObject; Str:string; Itens:Tstrings):integer;
    function CarregaTabelaDeCadastro(Sender:Tobject):Boolean;
    procedure CarregaListaEmpregados(sender: Tobject; lb:TComboBox);
    procedure ConectarAoBd(nBase:String);
    procedure ConexaoWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType; var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    function horaInt(hora:String):String;
    function getNumMatricula(nCartao:String):String;
    procedure conexaoWellExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
    procedure Cadastrodehorarios1Click(Sender: TObject);
    procedure CadastrodeEmpregados1Click(Sender: TObject);
    procedure Cadastrodeempregados2Click(Sender: TObject);
    function carregaCbox(str:string; cbox:TComboBox):integer;
    procedure N1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
   TITULO = 'Utilitário para editar batidas e arquivos';
   VERSAO ='11.02.01';
var
  Form2: TForm2;
  arq:TextFile;
  Linha:String;
  i:integer;

  ARQEMPREGADOS, HOR_EMPREGADOS, PATH:String;

implementation

uses UOcorrencia, uHorarios, uImportaCadastro, uCadEmpregados;

{$R *.DFM}


function  TForm2.ExisteJustificativa(sender:Tobject;linha:string):boolean;
begin
   ExisteJustificativa := false;
   if copy(linha,106,30) <> '' then
         ExisteJustificativa := true;
end;


function TForm2.FormatoDahora(x:integer):String;
var
   aux,h, m :String;
begin
   h := inttoStr( x div 60 );
   m := IntToStr( x mod 60 );
   if length(h) < 2 then insert('0',h,1);
   if length(m) < 2 then insert('0',m,1);
   aux := h +':'+ m;
   if aux = '00:00' then
      aux := '  :  ' ;
   FormatoDaHora := aux;
end;


function TForm2.Atraso(batida,data,horarios:String):String;
var
  Adate: Tdatetime;
  dif,  pos, Prev, h, m :integer;
begin
   Atraso:='  :  ';
   prev := 0;
   adate := StrToDate(data);
   case DayOfWeek(ADate) of
      2: pos:= 01;  3: pos:= 05;  4: pos:= 09;
      5: pos:= 13; 6: pos:= 17;   7: pos:= 21;
   end;
   prev := ( strtoint( copy(horarios, pos,02) ) * 60 ) + strtoint( copy(horarios, (pos+2),02) );

   if batida  <> '  :  ' then
   begin
      h := StrToInt( copy(batida, 01, 02) );
      m := StrToInt( copy(batida, 04, 02) );

      if ( (h * 60) + m  ) > prev then
      begin
         dif :=  ( (h *60) + m  ) - prev  ;
         Atraso := FormatoDaHora(dif);
      end;
  end
  else
     atraso := '  :  ';
end;


function GetNumLinhamemo2:integer;
var
   line:integer;
begin
   With form2.memo2 do
      Line:= Perform(EM_LINEFROMCHAR,SelStart, 0);
   GetNumLinhamemo2 := line;
end;

function QdiasNoMes(nummes:string):integer;
begin
end;


function NomearquivoSaida(linha:string):string;
begin
   insert('_2',linha,length(linha)-3);
   Nomearquivosaida := linha;
end;

function InserirFalta(linha:string):string;
begin
   delete(linha,51,83);
   insert('  :      :      :      :                               FALTA NAO JUSTIFICADA',linha,51);
   InserirFalta := linha;
end;


procedure tForm2.ajustaTelaParaAjusteFinos(sender:tobject;NomeArquivo:string);
begin
   form2.left:=0;
//   panel1.visible := false;
   form2.width := 1004;
   pagecontrol1.width := 1000;
   tabsheet4.Width:=990;
   memo2.width := 990;
   if memo2.visible = false then
   begin
      memo2.Lines.LoadFromFile(NomeArquivo);
      label1.caption := nomeArquivo;
   end;
   memo2.visible:= true;
   button3.Visible := true;
   button5.Visible := true;
   button6.Visible := true;
   button7.Visible := true;
   edit1.visible := true;
   sedit1.Visible:=true;
   sedit1.value:=1;

end;

procedure  tForm2.MsgDeRodape(msg:string);
begin
   form2.Refresh;
   form2.StatusBar1.simpletext := msg;
end;

function tForm2.carregaCbox(str:string; cbox:TComboBox):integer;
var
  i,j:integer;
begin
   j := -1 ;
   for i:=0 to CBox.Items.count do
      if pos(str,CBox.Items[i]) > 0 then
         j:=i;
   if j = -1 then
      form2.msgDeRodape('Nao Cadastrado !!!!!!')
   else
      form2.msgDeRodape(copy(CBox.Items[j],01,25));
   carregaCbox := j;
end;

function HoraToInt(Hora:String):integer;
begin
   HoraToInt := (StrToInt(copy(hora,01,02)) * 60) + StrToInt(copy(hora,03,02));
end;

function TForm2.horaInt(hora:String):String;
begin
   if hora <> '' then
      result := intToStr( HoraToInt(hora) )
   else
      result := '0';
end;


function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  CmdLine := '"' + Filename + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
     cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
  PChar(ExtractFilePath(Filename)), SUInfo, ProcInfo);
  if Result then
  begin
     WaitForSingleObject(ProcInfo.hProcess, INFINITE);
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
  end;
end;

Function TotalHorasNoDia(i:integer;e,s:String):String;
begin
end;


function Diferencas(dia:integer; totalHoras:String):String;
begin
end;

function MetadeDodia(dia:integer):String;
begin
end;



Function AjustaFolhas(x:String):String;
begin
    while pos( ' ', x ) > 0 do delete( x ,pos(' ', x ),1);
    while length( x ) < 3 do insert('0', x, 1 );
    AjustaFolhas:= x;
end;


function folgas( s:string ):string;
begin
   if  copy( s, 106, 05 ) = 'FOLGA' then
   begin
       delete(s, 51, 26 );
       insert('  :      :      :      :  ', s, 51 );
   end;
   folgas :=  s;
end;

function Tempo2(s:string;r:integer):string;
var
   aux:integer;
   h ,m :string;
begin
   if s = '  :  ' then
   begin
     h:='00';
     m:='00';
   end
   else
   begin
      h := copy( s, 1, 2 );
      m := copy( s ,4, 2 );
   end;
   aux:=0;
   aux := (( StrToInt(H) * 60 ) + ( StrToInt(m) )) -  10 ;

   aux := aux + r ;
   h := inttoStr( aux div 60 );
   m := IntToStr( aux mod 60 );
   if length(h) < 2 then insert('0',h,1);
   if length(m) < 2 then insert('0',m,1);
   tempo2 := h + ':' + m;
   if s = '  :  ' then
      tempo2 := '  :  '
end;


function tForm2.inserirBatidasDiaNormal(sender:TObject;linha:string):string;
var
   r:integer;
begin
 if form2.ExisteJustificativa(sender,linha) = false then
 begin
   r:= random(20);
   delete(linha, 51, 5);
   insert(tempo2( copy(linha,25,5),r), linha,51);
   r:= random(20);
   delete(linha, 58, 5);
   insert( tempo2( copy(linha,31,5),r), linha,58);
   r:= random(20);
   delete(linha, 65, 5);
   insert( tempo2( copy(linha,37,5),r), linha,65);

   r:= random(19);
   r:=r+7;
   delete(linha, 72, 5);
   insert( tempo2( copy(linha,43,5),r), linha,72);
 end;
   inserirBatidasDiaNormal:= linha;
end;


function tform2.r1(n:string):string;
var
   aux:string;
begin
   aux:= copy(n,7,4);          //ano
   aux:= aux + copy(n,4,2);    //mes
   aux:= aux + copy(n,1,2);    //dia
   aux:= aux + copy(n,12,2);
   aux:= aux + copy(n,15,2);
   aux:= aux + copy(n,18,2);
   aux:= aux + copy(n,21,8);
   r1:=aux;
end;


function tform2.r2(m:string):string;
var
   aux:string;
begin
   aux:= copy(m,7,4);
   aux:= aux + copy(m,4,2);
   aux:= aux + copy(m,1,2);
   aux:= aux + copy(m,12,2);
   aux:= aux + copy(m,15,2);
   aux:= aux + copy(m,18,2);
   aux:= aux + copy(m,21,8);
   r2:=aux;
end;


function tform2.NomedoDia(diasem:string):string;
var
  ADate: TDateTime;
  days: array[1..7] of string;
begin
  days[1] := 'DOM';
  days[2] := 'SEG';
  days[3] := 'TER';
  days[4] := 'QUA';
  days[5] := 'QUI';
  days[6] := 'SEX';
  days[7] := 'SAB';

  ADate := StrToDate(diasem);
  NomeDoDia:=(days[DayOfWeek(ADate)]);
end;

procedure tForm2.CarregaListaEmpregados(sender: Tobject; lb:TComboBox);
var
   arq: TextFile;
   linha:String;
   i:integer;
begin
   i:=0;
   screen.cursor := crhourglass;
   AssignFile( arq, ArqEmpregados);
   Reset(arq);

   readln( arq, linha); // salta a primeira linha  para nao pegar os dados da atualizacao
   While eof( arq ) = false do
   begin
      readln( arq, linha);
      lb.items.Add(copy (linha, 19, 25 )+ '         ' +  copy(linha, 10, 08) + '                 ' + copy(linha, 87, 01) );
   end;
   CloseFile(arq);
   screen.cursor := crdefault;
end;



procedure TForm2.MaskEdit1Click(Sender: TObject);
begin
//   tabsheet2.setfocus;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
    form2.caption := TITULO + '  '+ VERSAO;
end;

//*************************************************//
//*************************************************//

function AjustaLinha( x:String):String;
var
  aux : string;
begin
   while length( x ) < 94 do insert(' ', x, 10);
   if copy( x, 10, 06) <> '      ' then
   begin
      aux :='00';
      aux := aux + copy( x, 10, 06 ); // cartao
      aux := aux + copy( x, 19, 25 ); // nome
      aux := aux + copy( x, 60, 04 ); // seg
      aux := aux + copy( x, 65, 04 ); // ter
      aux := aux + copy( x, 70, 04 ); // qua
      aux := aux + copy( x, 65, 04 ); // qui
      aux := aux + copy( x, 80, 04 ); // sex
      aux := aux + copy( x, 85, 04 ); // sab
     AjustaLinha := aux;
   end;
end;

function Conexao:boolean;
begin
end;

function AjustaData(data:string):String;
begin
   ajustadata := copy(data,04,02)+'/'+copy(data,01,02)+ '/' + copy(data,07,04);
end;


procedure tForm2.OrganizaPorNome(sg2:TStringGrid);
var
   dados:array [1..500] of string;
   j,i: integer;
   aux:String;
begin
   for i:=1 to sg2.rowcount-1 do
      dados[i] := sg2.Cells[1,i] + sg2.Cells[0,i];

   for i:=1 to sg2.rowcount-1 do
      for j := i+1 to sg2.rowcount-1 do
         if dados[j] < dados [i] then
         begin
            aux := dados[j];
            dados[j] := dados[i];
            dados[i] := aux;
         end;

   for i:=1 to sg2.rowcount-1 do
   begin
      sg2.cells[0,i] := copy(dados[i],26,08);
      sg2.cells[1,i] := copy(dados[i],01,25);
   end;
//   label11.caption := 'Organizado por nome';
end;

procedure TForm2.sg2SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
{   if acol = 0 then OrganizaPorCodigo(sg2);
   if acol = 1 then OrganizaPornome(sg2);
}
end;

{
procedure tform2.impPontoPorDia(sender:TObject);
var
   arq:TExtFIle;
   i,j:integer;
begin
   AssignFile(arq,cbox2.items[cbox2.itemindex]);
   reset(arq);
   writeln( arq,'');
   writeln( arq,'  Relacao de empregados por dia de trabalho');
   writeln( arq,'');
   writeln( arq,'  Dia da consulta: ' + DateToSTR(Calendario01.date));
   writeln( arq,'  --------------------------------------------------------------------------------');
   writeln( arq,'  Codigo  Nome');
   for i:=1 to sg2.rowcount-1 do

end;
}
procedure tForm2.impPontoPorDia(sender:TObject);
var
   arq2: textFile;
   linha:string;
   transp:real;
   j,l,Fl:integer;

begin
{   screen.Cursor := crhourglass;
   j:=0; Fl := 0; l := 0;
   transp := 0;
   assignFile( arq2, cbox2.items[cbox2.itemindex]);
   Rewrite(arq2);

   while j < sg2.RowCount -1  do
   begin
      inc(fl);
      writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
      writeln( arq2, '   RELACAO DE FUNCIONARIO POR DIA                   DIA CONSULTADO:'+dATEtOsTR(CALENDARIO01.DATE)+    '               Pagina: ' + AjustaFolhas(inttoStr(Fl)));
      writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
      writeln( arq2, '  '+label11.caption);
      writeln( arq2, '   CODIGO   NOME ');
      writeln(arq2,'');
      while ( l < 50 ) and ( j < (sg2.RowCount-1) ) do
      begin
         inc(j);
         inc(l);
         writeln(arq2 ,'   '+ sg2.cells[0,j]+ '   '+ sg2.cells[1,j]);
      end;
      if ( j < (sg2.RowCount-1) ) then
      begin
         writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
         writeln( arq2,'');
         l:=0
      end
      else
      begin
         while ( l < 55 ) do
         begin
            writeln(arq2,'');
            inc(l);
         end;
         writeln( arq2, '   ------------------------------------------------------------------------------------------------------------------------');
         writeln( arq2,'');
      end;
   end;
   CloseFile( arq2 );
   screen.Cursor := crdefault;
}
end;


procedure TForm2.BitBtn12Click(Sender: TObject);
begin
{  if sg2.RowCount <= 2 then
     showmessage('Nada para imprimir.')
  else
     impPontoPorDia(sender);
}
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
   if ParamStr(1) <> '' then
      label1.caption := ParamStr(1);

end;

function ultimoregistro(Sender: TObject;arquivo:String):String;
var
  arq:textfile;
  linha:string;
begin
   assignFile( arq,arquivo);
   reset(arq);
   while (eof(arq)) = false do readln(arq,linha);
   closefile(arq);
   result :=(copy(linha,01,10));
end;
function primeiroregistro(Sender: TObject;arquivo:String):String;
var
  arq:textfile;
  linha:string;
begin
   assignFile( arq,arquivo);
   reset(arq);
   readln(arq,linha);
   closefile(arq);
   result :=(copy(linha,01,10));
end;

procedure CalculoDeAtraso(sender:Tobject);
begin

end;

procedure mostraerro(sender:tobject);
begin
   showmessage( 'ocorreu um erro');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   PATH := extractFilePath(paramStr(0));
   ARQEMPREGADOS := PATH + 'cadastros.cfg';
   HOR_EMPREGADOS:= path + 'cadastros.new';
   AnimateWindow(form2.Handle,150, AW_ver_POSITIVE);
   form2.Top := 01;
   form2.Left := 100;
   application.OnException :=AppException;
   deleteFile(ExtractFilePath(ParamStr(0))+ 'logs\LogManipulador.txt');
   DeleteFile( ExtractFilePath(paramStr(0)) +'logs\' + ExtractFilename(ParamStr(0))  + '_log.txt');

   form2.conexaoWell.ConnectionString := funcoes.getDadosConexaoUDL( ExtractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini');
   form2.conexaoWell.Open
end;


procedure TForm2.AppException(Sender: TObject; E: Exception);
begin
  Showmessage('Ocorreu um erro ao executar o programa '+#13+'o nome do erro é : '+ E.message);
  screen.Cursor:= crdefault;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
   ajustaTelaParaAjusteFinos(sender,label1.caption);
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
   memo2.Lines[ GetNumLinhamemo2] := inserirfalta(memo2.Lines[ GetNumLinhamemo2 ] );
   msgDeRodape(IntTostr(GetNumLinhamemo2+1));
   memo2.setfocus;
end;


procedure TForm2.Button3Click(Sender: TObject);
begin
   memo2.Lines[ GetNumLinhaMemo2 ] := inserirBatidasDiaNormal(sender, copy(memo2.Lines[ GetNumLinhaMemo2 ],01,11) +
                                                               copy(memo2.Lines[ GetNumLinhaMemo2 - StrToint(sedit1.Text) ],12,36 )+'     :      :      :      :  '  );  //  memo2.Lines[ GetNumLinhamemo2 ]
   msgDeRodape(IntTostr(GetNumLinhamemo2+1));
   memo2.setfocus;
end;


procedure TForm2.Button7Click(Sender: TObject);
var
  linha:string;
begin
   linha :=   memo2.Lines[ GetNumLinhamemo2 ];
   delete(linha, 106, 30 );
   insert('FOLGA',LINHA,106);

   memo2.Lines[ GetNumLinhamemo2 ] := folgas(linha);
   msgDeRodape(IntTostr(GetNumLinhamemo2+1));
   memo2.setfocus;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  linha:string;
begin
   linha := memo2.Lines[ GetNumLinhamemo2 ];
   linha := inserirfalta(linha );
   delete(linha,106,50);
   insert(edit1.text,linha,106);
   memo2.Lines[ GetNumLinhamemo2 ] := linha;
   msgDeRodape(IntTostr(GetNumLinhamemo2+1));
   memo2.setfocus;
end;


procedure TForm2.FindDialog1Find(Sender: TObject);
var
  k,j,I:integer;
  achou:boolean;
begin
  k := 0;
  With Memo2 do
     j:= Perform(EM_LINEFROMCHAR,SelStart, 0);
  if j > 0 then
     k := j;

  for I := k to Memo2.Lines.Count - 1 do
     if  Pos(UPPERCASE(FindDialog1.FindText),Memo2.Lines[I]) > 0 then
     begin
        achou:= true;
        memo2.setfocus;
        With Memo2 do
        begin
           SelStart :=  Perform(EM_LINEINDEX, I, 0) ;
           sellength:= Pos(UPPERCASE(FindDialog1.FindText),Memo2.Lines[I]);
           Break;
        end;
     end;
   msgDeRodape('');
   if achou  = false then
      msgDeRodape('Nao achei -> ' + FindDialog1.FindText );
  finddialog1.findtext:='';
end;


procedure tForm2.procurarmemo2(sender:tobject);
begin
  if  Finddialog1.execute then
     FindDialog1Find(Sender);
end;


procedure TForm2.TabSheet4Exit(Sender: TObject);
begin
   if memo2.Modified then
      if application.MessageBox('Salva o arquivo ?',TITULO, MB_YESNO + MB_ICONQUESTION)  = mryes THEN
      begin
         memo2.lines.SaveToFile(NomearquivoSaida(label1.caption));
         msgDeRodape('salvo no arquivo : '+label1.caption);
         memo2.Visible:= false;
      end
      else
         memo2.Visible:= false;

      memo2.visible:= false;
      button7.visible:= false;
      button6.visible:= false;
      button5.visible:= false;
      button3.visible:= false;
      sedit1.visible:= false;
      edit1.visible:= false;
end;

procedure TForm2.TabSheet4Enter(Sender: TObject);
begin
   if memo2.visible then
      ajustaTelaParaAjusteFinos(sender,label1.caption);

end;


procedure tForm2.salvarMemo2(sender:tobject);
begin
  memo2.lines.SaveToFile(label1.caption);
  memo2.Modified:= false;
  msgDeRodape('salvo no arquivo : ' + label1.caption);
end;


function EhLinhaDeBatidas(linha:string):boolean;
const
   dias: array[1..7]of string = ('SEG','TER','QUA','QUI','SEX','SAB','DOM');
var
   i:integer;
begin
  EhLinhaDeBatidas:= false;
  for i:= 1 to 7 do
     if linha = dias[i] then
        EhLinhaDeBatidas := true;
end;


procedure TForm2.AjustaRelatoriodePonto(Sender: TObject);
var
   arq, arq2: textFile;
   linha : string;
begin
   AssignFile( arq, label1.caption);
   Reset( arq );

   AssignFile( arq2, NomeArquivoSaida(label1.caption));
   rewrite( arq2);
   randomize;
   while eof( arq ) = false do
   begin
      readln( arq, linha );
      if copy(linha,80,23) = '00:00 00:00 00:00 00:00' then
      begin
         delete(linha,80,23);
         insert('                       ',linha,80);
      end;
      if ( EhLinhaDeBatidas(copy(linha,09,03)) = true ) then
      begin
        linha:= inserirBatidasDiaNormal(sender,linha);
      end;

      writeln(arq2,linha);

   end;
   CloseFile( arq );
   CloseFile( arq2 );
   messagebeep(MB_ICONEXCLAMATION);

end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
{   case( key) of
      vk_F6 : salvarmemo2(sender);
      70:begin
            if Shift = [ssCtrl] then
               Procurarmemo2(sender);
         end;
   end;
   statusbar1.Panels[1].Text := IntToStr(key);
}
end;
procedure TForm2.organizerpornome1Click(Sender: TObject);
begin
   showmessage('');
end;

procedure TForm2.qq1Click(Sender: TObject);
begin
showmessage('');
end;

{
procedure tform2.selecionarEmpregados(base:String);
var
  ds:TDataSet;
begin
   ds := funcsql.getDataSetQ( ' select a.emp_matricula, a.EMP_CARTAODEPONTO, a.EMP_nome, B.HOR_SEG_ENTRADA, B.HOR_TER_ENTRADA, B.HOR_QUA_ENTRADA, B.HOR_QUI_ENTRADA, B.HOR_SEX_ENTRADA, B.HOR_SAB_ENTRADA, B.HOR_sab_ENTRADA' +
      'FROM EMPREGADOS A, HORARIOS B' +
      'WHERE (a.EMP_Horario = B.Hor_REFERENCIA) AND (A.EMP_STATUS = 1) ' +
      'ORDER BY EMP_NOME' , Conexao);

   funcsql.exportaDataSet(ds);

   ds.Destroy();
end;

}

procedure TForm2.BitBtn9Click(Sender: TObject);
begin
   if label1.caption = '' then
      msgDeRodape('Nome do arquivo ?')
   else
   begin
      AjustaRelatoriodePonto(sender);
      ajustaTelaParaAjusteFinos(sender,Nomearquivosaida(label1.caption));
   end;
   msgDeRodape('Ajuste do Relatorio Espelho pronto')
end;


procedure TForm2.Memo2KeyPress(Sender: TObject; var Key: Char);
begin
   KEY :=   UPCASE(KEY);
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
   edit6.text := copy(memo2.Lines[GetNumLinhamemo2],25,23);
end;

procedure TForm2.Button11Click(Sender: TObject);
var
  aux:string;
begin
   aux := memo2.Lines[ GetNumLinhaMemo2 ];
   delete(aux,25,23);
   insert(edit6.Text, aux,25);
   memo2.Lines[ GetNumLinhaMemo2 ]:= aux;
   memo2.Lines[ GetNumLinhaMemo2 ] := inserirBatidasDiaNormal(sender, copy(memo2.Lines[ GetNumLinhaMemo2 ],01,11) +                                                               copy(memo2.Lines[ GetNumLinhaMemo2],12,36 )+'     :      :      :      :  '  );
   msgDeRodape(IntTostr(GetNumLinhamemo2+1));
   memo2.setfocus;
end;

procedure Tform2.AjustaHorFixoTodos(base:string);
var
   cmd:String;
begin
   ConectarAoBd(base);
   MsgDeRodape('Atribuindo horarios fixos em todos os funcionários da base '+ base);
   sleep(1000);

    cmd := ' update empregados set    EMP_TIPOHORARIO = ''5001'', EMP_ALEATORIEDADE = ''T'',   EMP_BATINTERVALO = ''T'',   EMP_BATENTRADA =''F'',   EMP_BATSAIDA = ''F'' ' +
           ' where emp_funcao <> 53';
   funcSql.execSQL(cmd, Conexao );
end;

function  AjustaLinhaCadastro(linha:String;Base:string):String;
begin
// MONTA A LINHA COM OS DADOS DO FUNCIONARIO para o arquivo cadastro.cfg
   result :=
    funcoes.PreencheCampo(08,'0','e', copy(linha,01,08) ) +' '+
    funcoes.PreencheCampo(08,'0','e', copy(linha,10,06) ) + ' ' +
    copy(linha,17,40) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 78,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( Copy(linha, 83,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 88,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 93,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 98,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha,103,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha,108,04)) ) +
    Base +
    funcoes.preencheCampo(02,' ','e', funcoes.sohNumeros(copy(linha,113,02)) )+
    copy(linha,116,03)+';'+

    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 120,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( Copy(linha, 125,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 130,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 135,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 140,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 145,04)) ) +
    funcoes.preencheCampo(4,'0','e', funcoes.tiraEspaco( copy(linha, 145,04)) +
    copy(linha, 150 ,01)
 );
end;

procedure tform2.AjustaCadastro(sender:Tobject);
var
   origem,destino:textfile;
   linha:string;
begin
   MsgDeRodape('Montando arquivo...');
   AssignFile( origem, PATH + '1'+'.TXT');
   reset( origem );

   AssignFile( destino, PATH + '\cadastros.new');
   rewrite( destino );
   while eof( origem ) = false do
   begin
      readln(origem,linha);
      if {(copy(linha,01,02) = '00')} (1=1) and(copy(linha,10,06) <> '      ') then
         writeln(destino,  AjustaLinhaCadastro(linha,'1') );
   end;
   closefile( origem );

   AssignFile( origem, PATH + '2'+'.TXT');
   reset( origem );
   while eof( origem ) = false do
   begin
      readln(origem,linha);
      if {(copy(linha,01,02) = '00') } (1=1) and(copy(linha,10,06) <> '      ') then
         writeln(destino,  AjustaLinhaCadastro(linha,'2') );
   end;
   closefile( origem );


   AssignFile( origem, PATH + '3'+'.TXT');
   reset( origem );
   while eof( origem ) = false do
   begin
      readln(origem,linha);
      if {(copy(linha,01,02) = '00') } (1=1) and(copy(linha,10,06) <> '      ') then
         writeln(destino,  AjustaLinhaCadastro(linha,'3') );
   end;
   closefile( origem );
   closefile( destino );

   screen.cursor := crDEFAULT;
end;


function TForm2.getNumMatricula(nCartao:String): String;
begin
   result := funcsql.openSQL('Select top 01 emp_matricula from empregados where emp_cartaoDePonto = '+ nCartao + ' and emp_status = 1 and( emp_estabelecimento < ''900'' ) order by EMP_DATAADMISSAO Desc', 'emp_matricula', conexao  );
end;


function TForm2.ProcuraEmCbox(sender: TObject; Str: string; Itens: Tstrings): integer;
var
  j,i:integer;
begin
   j:= -1;
   for i:= 0 to itens.count -1 do
      if pos(str,itens[i]) > 0 then
         j := i;
      if j = -1 then
         form2.msgDeRodape('Não Cadastrado !!!!')
      else
         result := j;
end;

function TForm2.CarregaTabelaDeCadastro(Sender: Tobject): Boolean;
var
  Conexao:TADOConnection;
  Query:TADOQuery;
  Arq:TstringList;
  i:integer;
begin
   try
     MsgDeRodape('Transferindo cadastro para o servidor...');


      Conexao := TADOConnection.Create(nil);
      Conexao.LoginPrompt := false;
      Conexao.ConnectionTimeout := 03;
      Conexao.ConnectionString := funcoes.getDadosConexaoUDL(PATH +'\ConexaoAoWell.ini');

      query := TADOQuery.Create(nil);
      query.Connection := Conexao;
      query.SQL.Add('truncate table zcf_DigitaisCadastro');
      query.ExecSQL;

      query.SQL.Clear;
      query.SQL.Add('Select * from zcf_DigitaisCadastro');
      query.Open;

      arq := TstringList.Create();
      arq.LoadFromFile(PATH + '\cadastros.new');
      query.AppendRecord(['Atualizado por: '+ funcoes.GetNomeDoMicro() + ' em ' + DateTimeToStr(now),dateTimeToStr(now),'']);


      for i:=0 to arq.Count -1 do
      begin
         query.Append;
//      primeira parte
         query.FieldByName('dados').AsString := copy(arq[i],01,92);
         query.FieldByName('data').AsDateTime := now;
//      parte da saida
         query.FieldByName('Saida').asString := copy(arq[i],94,28);
         query.FieldByName('is_horaFlexivel').AsString := copy(arq[i],121,01);
         query.Post;
      end;
      query.Close;
      conexao.Close;
      conexao.Free;
      MsgDeRodape('');
    except
       showmessage('Erro ao dar carga da tabela ade funcionarios');
    end;
end;


procedure TForm2.ConectarAoBd(nBase: String);
var
  bd:String;
begin
    case strToInt(nBase)of
       1: bd := 'fluxus001';
       2: bd := 'fluxus002';
       3: bd := 'fluxus003';
    end;

   if Conexao.Connected = true then
      Conexao.Close();

   Conexao.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;' +
                               'password=welladm;user ID=secrel; ' +
                               'initial Catalog=' + bd +
                               ';data Source=125.0.0.200';
   Conexao.Open();
   statusbar1.SimpleText:= bd;
end;

procedure TForm2.ConexaoWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
  Screen.Cursor := crHourGlass;
  funcoes.gravaLog(CommandText );
end;

procedure TForm2.conexaoWellExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
  Screen.Cursor := crDefault;
end;

procedure TForm2.Cadastrodehorarios1Click(Sender: TObject);
begin
   if ( fmHorarios = nil) then
   begin
      Application.CreateForm(TfmHorarios, fmHorarios);
      fmHorarios.show;
      PageControl1.Visible := false;
   end;
end;

procedure TForm2.CadastrodeEmpregados1Click(Sender: TObject);
begin
    PageControl1.Visible := false;
    Application.CreateForm(TfmExportaEmp, fmExportaEmp);
    fmExportaEmp.show;
end;

procedure TForm2.Cadastrodeempregados2Click(Sender: TObject);
begin
   if ( fmCadEmpregados = nil) then
   begin
      Application.CreateForm(TfmCadEmpregados, fmCadEmpregados);
      fmCadEmpregados.show;
      PageControl1.Visible := false;
   end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
    PageControl1.Visible := not (PageControl1.Visible);
end;

end.


