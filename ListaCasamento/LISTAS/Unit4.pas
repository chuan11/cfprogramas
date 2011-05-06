unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  Grids, DBGrids, mxExport, Db, DBTables, StdCtrls, Buttons, ExtCtrls,
  ADODB;

type
  TFImpressao = class(TForm)
    DataSource1: TDataSource;
    ExportDbgrid: TmxDBGridExport;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    cb1: TComboBox;
    cb2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Query1: TADOQuery;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure CapturarDadosDasTabelas(num:string;sender:tobject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MontarRelatorioImpressao(sender:tobject);
    procedure MandarParaImpressora(sender:TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
   ARQ_DADOS = 'c:\Listas\DadosCliente.TXT';
   ARQ_PROD  = 'c:\Listas\DadosProduto.TXT';
   BAT_DE_IMPRESSAO = 'c:\Listas\imprime.bat';
   ARQ_DE_IMPRESSAO = 'c:\Listas\relatorio.txt';
var
  FImpressao: TFImpressao;

implementation

uses Unit1, Unit2, Unit6;

{$R *.DFM}
procedure TFImpressao.MandarParaImpressora(sender:TObject);
var
   arq:textFile;
begin
   AssignFile(arq,BAT_DE_IMPRESSAO);
   rewrite(arq);
   writeln(arq,'copy '+ ARQ_DE_IMPRESSAO + ' '+ FORM1.lerParametro(FORM1.memo1.lines[1]));
   CloseFile(arq);
   WinExec(BAT_DE_IMPRESSAO,sw_HIDE);
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
  { Aguarda até ser finalizado }
  if Result then
  begin
     WaitForSingleObject(ProcInfo.hProcess, INFINITE);
     { Libera os Handles }
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
  end;
end;


function Ajustalinha( s:String ):string;
var
   aux:string;
begin
   case StrToint(copy(s,17,02)) of
      01:aux:= 'INOX            - ';
      02:aux:= 'CRISTAIS/VIDRO  - ';
      03:aux:= 'PORCELANA/LOUCAS- ';
      04:aux:= 'PLASTICOS       - ';
   else
      aux:=    'OUTROS          - ';
   end;

   aux := aux + copy(s,20,07) +'  '+ copy(s,28,40) +' ';

   if copy(s,69,05) <> '     ' then
      aux := aux + copy(s,27,40)
   else
      aux := aux     + '________________________________________';
   Ajustalinha := aux;
end;


Function AjustaFolhas(x:String):String;
begin
    while pos( ' ', x ) > 0 do delete( x ,pos(' ', x ),1);
    while length( x ) < 3 do insert('0', x, 1 );
    AjustaFolhas:= x;
end;

procedure TFImpressao.FormShow(Sender: TObject);
begin
   cb1.itemindex:=0;
   cb2.itemindex:=0;
   FImpressao.Left := form1.left + 20 ;
   FImpressao. top := form1.top  + 30;

   with query1.SQL do
   begin
      clear;
      if form1.lerParametro(form1.memo1.lines[3])= 'S' then
         add('Select Numlista, loja, Noiva, noivo  from listas where (tipo <>'+#39+'99'+#39+') order by noiva')
      else
         add('Select Numlista, loja, Noiva, noivo  from listas where (tipo <>'+#39+'99'+#39+') and ( DataCasamento  >= '+#39 + form1.AjustaDataInicioDoMes('') +#39+' )order by noiva')
   end;
   query1.open;

   dbgrid1.Columns[0].Width:= 40 ;
   dbgrid1.Columns[1].Width:= 25 ;
   dbgrid1.Columns[2].Width:= 200;
end;

procedure TFImpressao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FImpressao := nil;
   action := cafree;
end;

procedure TFImpressao.BitBtn4Click(Sender: TObject);
begin
   FImpressao.close;
   FImpressao := nil;
   if ProdutosNaLista <> nil then
      ProdutosNaLista.bitbtn3.enabled := true;
end;


procedure TFimpressao.CapturarDadosDasTabelas(Num:string;sender:tobject);
var
   i:integer;
begin
   dbgrid1.Visible := false;
   with query1.sql do
   begin
      clear;
      add('Select * from Listas where NumLista = '+#39 + num + #39);
   end;
   query1.open;
   ExportDbgrid.filename := ARQ_DADOS;
   ExportDbgrid.execute;

   with query1.sql do
   begin
      clear;
      add('Select ref, tipo, codigo, nomeProduto, convidado  from produtos');
      add('where (NumLista = '+#39+  num +#39+')');

      if CB1.itemIndex = 0 then
         add(' and ( CONVIDADO = '+#39+#39 + ')');

      add('order by tipo') ;
      if CB2.itemIndex = 1 then
         add(', Codigo')
      else if CB2.itemIndex = 2 then
         add(', NomeProduto')
      else
         add(', Ref')
   end;
   query1.open;
   ExportDbgrid.filename :=  ARQ_PROD;
   ExportDbgrid.execute;
end;


procedure TFImpressao.MontarRelatorioImpressao(sender:tobject);
var
   dest,origem:textFile;
   linha:string;
   DadosCliente:array [1..7] of string;
   l,Fl:integer;
begin
   assignfile(origem,  ARQ_DADOS );
   reset(origem);
   for fl:=1 to 3 do
      readln(origem,linha);
   DadosCliente[1] := copy(linha,17,40); //noiva
   DadosCliente[2] := copy(linha,58,40); //noivo
   DadosCliente[3] := copy(linha,192,10); //dtcasamento
   DadosCliente[4] := copy(linha,99,40); //end de entrega
   DadosCliente[5] := copy(linha,140,40);
   DadosCliente[6] := copy(linha,270,40);
   DadosCliente[7] := copy(linha,371,02);
   Fl := 0; l := 0;
   AssignFile(dest,   ARQ_DE_IMPRESSAO );
   rewrite(dest);
   CloseFile(origem );
   assignfile(origem,  ARQ_PROD );
   reset(origem);
   Readln(origem,linha);
   Readln(origem,linha);
   while eof( origem ) = false do
   begin
      inc(fl);
      writeln(dest,'                                              CASA FREITAS - O SHOPPING DA ECONOMIA                                       '+ DateToStr(Now));
      if dadosCliente[07] = '01' then
         writeln(dest,'                                                       LISTA DE CASAMENTO                                                  PAGINA:'+AjustaFolhas( inttoStr(Fl) ) )
      else
         writeln(dest,'                                                    LISTA PARA CHA DE PANELA                                               PAGINA:'+AjustaFolhas( inttoStr(Fl) ) );
      writeln(dest,'ITEMS A SEREM IMPRESSOS: ' + cb1.items[cb1.itemindex] + '        ORDENADO POR: ' +cb2.items[cb2.itemindex]);
      writeln(dest,'--------------------------------------------------------[ DADOS  DA LISTA ]---------------------------------------------------------');
      writeln(dest,'NOIVA: ' + DadosCliente[1] + '     NOIVO: ' + DadosCliente[2]  + '   DATA CASAMENTO: '+    DadosCliente[3] );
      writeln(dest,'ENDERECO DE ENTREGA: '+DadosCliente[4] + '     BAIRRO: '+  DadosCliente[5]  );
      writeln(dest,'OBSERVACAO: ' + DadosCliente[6]);
      writeln(dest,'-------------------------------------------------------[ DADOS DOS PRODUTOS ]-------------------------------------------------------');
      writeln(dest,'TIPO              CODIGO   DESCRICAO                                CONVIDADO                                                            ');
      writeln(dest,'');
      while ( l < 49 ) and ( eof(origem) = false ) do
      begin
            inc(l);
            readln(origem,linha);
            writeln(dest , AjustaLinha(linha));
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
         while ( l < 50 ) do
         begin
            writeln(dest,'');
            inc(l);
         end;
         writeln( dest, '------------------------------------------------------------------------------------------------------------------------------------');
         writeln( dest,'');
      end;

   end;
   CloseFile( dest );
   CloseFile( origem );
end;


procedure TFImpressao.BitBtn2Click(Sender: TObject);
begin
   if application.messagebox(pchar('   A impressora está pronta para impressão ??? ....'),'',MB_OKCANCEL + MB_ICONASTERISK) = MROK then
   begin
      CapturarDadosDasTabelas(dbgrid1.fields[0].AsString,sender);
      MontarRelatorioImpressao(sender);
      MandarParaImpressora(sender);
      bitbtn4Click(sender);
   end;
end;

procedure TFImpressao.DBGrid1CellClick(Column: TColumn);
begin
   bitbtn2.enabled := true;
end;

procedure TFImpressao.BitBtn1Click(Sender: TObject);
begin
   produtosnalista.BitBtn1Click(Sender);
   fpesquisa.Caption := 'Pesquisa para imprimir lista';
end;

end.
