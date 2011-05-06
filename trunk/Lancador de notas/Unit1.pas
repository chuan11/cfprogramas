unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, DB, ADODB,funcoes, TFlatButtonUnit,
  Grids, DBGrids, SoftDBGrid, ComCtrls, adLabelEdit, clipbrd, Buttons, comObj,
  fCtrls;

type
  TForm1 = class(TForm)
    cb2: TadLabelComboBox;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    DBGrid: TSoftDBGrid;
    query: TADOQuery;
    DataSource1: TDataSource;
    dp1: TDateTimePicker;
    FlatButton3: TFlatButton;
    Edit1: TadLabelEdit;
    FlatButton4: TFlatButton;
    Label2: TLabel;
    dp2: TDateTimePicker;
    Label3: TLabel;
    FlatButton6: TFlatButton;
    qrReducao: TADOQuery;
    FlatButton8: TFlatButton;
    Query3: TADOQuery;
    Query3is_nota: TIntegerField;
    Query3serie: TStringField;
    Query3cfo: TIntegerField;
    Query3data: TDateTimeField;
    Query3tipo: TStringField;
    Query3destino: TStringField;
    Query3uf: TStringField;
    Query3valor: TFloatField;
    Query3valorBaseIcms: TFloatField;
    Query3percicms: TFloatField;
    Query3ValorICMS: TFloatField;
    Query3a: TStringField;
    Query3b: TStringField;
    Query3c: TStringField;
    Query3nr_cpfcgc: TIntegerField;
    Query3nr_filcgc: TIntegerField;
    Query3dg_cpfcgc: TIntegerField;
    Query3codForn: TStringField;
    Query3EhCadastrado: TStringField;
    Query3nm_Pes: TStringField;
    Query3dataE: TDateTimeField;
    Query3nota: TIntegerField;
    qrReducaoIS_NOTA: TIntegerField;
    qrReducaoNOTA: TIntegerField;
    qrReducaoSERIE: TWordField;
    qrReducaoCFO: TStringField;
    qrReducaoDATA: TDateTimeField;
    qrReducaoTIPO: TIntegerField;
    qrReducaoDESTINO: TStringField;
    qrReducaoUF: TIntegerField;
    qrReducaoVALOR: TBCDField;
    qrReducaoVALORBASEICMS: TBCDField;
    qrReducaoPERCICMS: TStringField;
    qrReducaoVALORICMS: TBCDField;
    qrReducaoVL_MOVIMENTO: TBCDField;
    qrReducaoVL_CANCEL: TBCDField;
    qrReducaoVL_DESC: TBCDField;
    qrReducaoVlIsentas: TBCDField;
    qrReducaoGT_ANT: TBCDField;
    qrReducaoGT_ATUAL: TBCDField;
    qrReducaoCOO_ATUAL: TIntegerField;
    qrReducaoCOO_INICIAL: TIntegerField;
    rg1: TfsRadioGroup;
    fsBitBtn1: TfsBitBtn;
    procedure FormCreate(Sender: TObject);
    function  GetNomeLojas(sender: tobject): Tstrings;
    procedure ListarNotasSaida(Sender: TObject);
    procedure SalvaColDbgrid(NomeForm:string; Dbgrid:tdbgrid);
    procedure LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb2Change(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    function Repetir(quant:integer; Str:string):string;
    procedure ObterEntradaFornecedor(Sender: TObject);
    function  GetUoEmitentes(Uo:string):String;
    procedure FlatButton4Click(Sender: TObject);
    function GetCodForLoja(Uo:string): String;
    procedure GeraSaida(sender:tobject);
    procedure GeraEntrada(sender:tobject);
    procedure GeraReducoes(sender:tobject);
    procedure dp1Change(Sender: TObject);
    procedure StoListaReducaoParaLVSAI(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);
//    procedure FlatButton7Click(Sender: TObject);
    procedure Query3BeforePost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure CarregaFornecedores(sender:Tobject);
    procedure PreeencheCodFornecedor(sender:tobject);
    procedure PreeencheosFornecedores(sender:tobject);
    procedure FlatButton8Click(Sender: TObject);
    procedure GravarCodFornecedor(sender: tobject);
    procedure ExportarNotasFornecedor(Sender:Tobject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure GeraRelTransferencia(sender:TOBject);
    procedure GeraRelTransferenciaPFM(Sender:Tobject);
    procedure GeraRelTransferenciaCF(Sender:Tobject);

    procedure ListarEntradasParaLVENT(Sender: TObject);
    procedure ADOConnection1WillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    procedure ADOConnection1ExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);

  private
    { Private declarations }
  public
    { Public declarations }
  end;


const
   ENTER = #13;
   HOME = ^w;
   TAB  = #09;
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SalvaColDbgrid(NomeForm:string; Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
   begin
      funcoes.WParReg('LancaNotas','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
      funcoes.GravaLinhaEmUmArquivo('c:\zcoluna.txt', IntToStr(dbgrid.Columns[i].Width) );
   end;
end;

procedure Tform1.LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount -1 do
   begin
      dbgrid.Columns[i].Title.Font.name := 'MS Sans Serif';
      dbgrid.Columns[i].Title.Font.Style := [fsbold];
      if funcoes.RParReg('LancaNotas','Z_' +NomeForm+ '_'+ IntToStr(i) ) <> '' then
         dbgrid.Columns[i].width := StrToint( funcoes.RParReg('LancaNotas','Z_' +NomeForm+ '_'+ IntToStr(i))  );
   end;
end;

function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from tbuo where TP_ESTOQUE in (1,2) and cd_uf = '+ quotedstr('Ce') + ' order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' ) ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;

   cb2.Items :=  GetNomeLojas(sender);

   form1.LerColunasDbgrid('form1',dbgrid);
   form1.left := screen.Width - form1.Width - 50;
   FORM1.Caption := FORM1.CAPTION + '    '+ ADOConnection1.DefaultDatabase;


   if funcoes.RParReg('LancaNotas','loja') <> '' then
     cb2.ItemIndex := StrToInt(funcoes.RParReg('LancaNotas','loja'));

   if funcoes.RParReg('LancaNotas','Data') <> '' then
     dp1.Datetime := StrToDate(funcoes.RParReg('LancaNotas','data'));

   if funcoes.RParReg('LancaNotas','DatafIM') <> '' then
     dp2.Datetime := StrToDate(funcoes.RParReg('LancaNotas','datafIM'));

   shortdateformat := 'dd/MM/yy';
   cb2Change(Sender);
end;

procedure TForm1.ListarNotasSaida(Sender: TObject);
begin
   screen.Cursor := crHourglass;
   datasource1.DataSet := query;
   query.SQL.Clear;
   query.sql.add(' Exec  dbo.Z_CF_StoListaNotasParaLVSAI  ' +
                  copy(cb2.Items[cb2.ItemIndex],51,08) +' , '+
                  funcoes.StrToSqlDate( DateToSTr(dp1.date))+' , '+
                  funcoes.StrToSqlDate( DateToSTr(dp2.date)) );
query.SQL.SaveToFile('c:\teste.txt');
   query.Open;

   dbgrid.Columns[00].visible := false;
   dbgrid.Columns[01].Width := 60;
   dbgrid.Columns[02].Width := 40;
   dbgrid.Columns[03].Width :=  30;
   dbgrid.Columns[04].Width :=  60;
   dbgrid.Columns[05].Width :=  30;
   dbgrid.Columns[06].Width :=  30;
   dbgrid.Columns[07].Width :=  60;
   dbgrid.Columns[08].Width :=  70;
   dbgrid.Columns[09].Width :=  70;
   dbgrid.Columns[10].Width :=  40;
   dbgrid.Columns[11].Width :=  60;
   dbgrid.Columns[12].visible := false;

   LABEL2.Caption := 'LVSAI';
   screen.Cursor := crDefault;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   shortdateformat := 'dd/MM/yyyy';
//   SalvaColDbgrid('form1',dbgrid);
   funcoes.WParReg('LancaNotas','loja', IntToStr(cb2.itemindex));
   funcoes.WParReg('LancaNotas','data', DateToStr(dp1.date));
   funcoes.WParReg('LancaNotas','datafIM', DateToStr(dp2.date));
   deleteFile(funcoes.TempDir() + 'Log_'+ application.Title + '.txt');
end;

procedure TForm1.cb2Change(Sender: TObject);
var
  aux:string;
begin
   case StrToInt(copy(cb2.Items[cb2.ItemIndex],51,08)) of
      10033586 : aux := '01';
      10033587 : aux := '03';
      10033588 : aux := '05';
      10033589 : aux := '06';
      10033590 : aux := '10';
      10033591 : aux := '08';
      10033592 : aux := '09';
      10033593 : aux := '11';
      10033594 : aux := '12';
      10033595 : aux := '17';
      10036710 : aux := '02';
      10037736 : aux := '06';
      10033674 : aux := '10';
   else
      aux := '??';
   end;
   edit1.text := aux;
end;

procedure TForm1.GeraSaida(sender: tobject);
var
   aux:string;
begin
//   query.First;
   aux := '';
   aux := aux+ HOME + 'GO '+ EDIT1.TEXT + ENTER;
   while query.Eof = false do
   begin
      aux := aux + HOME + 'LVSAI'+ ENTER + HOME + TAB + 'INCSNF1'; // CABECALHO

      if  query.Fields[2].AsString = 'NF1' then // preencher a serie
         aux := aux +'-  '
      else
         aux := aux +'2  ';

      //preencher o numero
      aux := aux + funcoes.preencheCampo(6,'0','E',query.Fields[1].AsString) + TAB;
      // preencher data
      aux := aux + Funcoes.SohNumeros(query.Fields[4].AsString);
      // preencher o cfo selo
      aux := aux + Funcoes.SohNumeros(query.Fields[3].AsString) +TAB + TAB;
      //preenche o tipo de venda
      if query.Fields[5].AsString = 'V' then
         aux := aux + '001'
      else
         aux := aux + TAB;

      // dados do cliente
      aux := aux + repetir(10,TAB);
      // dados da UF
      aux := aux + query.Fields[7].AsString;
      // complemento dados do cliente
      aux := aux + repetir(02,TAB);

      // dados vend/loja
      if query.Fields[5].AsString = 'V' then
         aux := aux + '0001V'+ TAB
      else
         aux := aux + funcoes.preencheCampo(4,'0','E',query.Fields[6].AsString)+ 'T'+ TAB;

      // valor da nota
      aux := aux + funcoes.preencheCampo(12,'0','E', StrToMoney(query.FieldByName('Valor').AsString )) + repetir(07,TAB);

      // valor BASE  de calculo
      aux := aux + funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(query.Fields[09].AsString)) ) + TAB;
      // valor percentual icms
      aux := aux + funcoes.preencheCampo(04,'0','D', funcoes.SohNumeros(StrToMoney(query.Fields[10].AsString)) ) ;
      // valor icms
      aux := aux + funcoes.preencheCampo(12,'0','E', FUNCOES.SohNumeros(StrToMoney(query.Fields[11].AsString)) ) +TAB ;
      aux := aux + ENTER;
      query.Next;
   end;
   clipboard.AsText := aux;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   if label2.Caption  = 'LVSAI' then
      GeraSaida(sender)
   else
      Showmessage('Para exportar a saída você tem que antes gerar as notas de saída');
end;


function TForm1.Repetir(quant: integer; Str: string): string;
var
  aux:string;
  i:integer;
begin
   aux := Str;
   for i:= 1 to quant -1 do
      str := str+ aux;
   Repetir := str;
end;

procedure TForm1.ObterEntradaFornecedor(Sender: TObject);
begin
   screen.Cursor := crHourglass;
   datasource1.DataSet := query;
   query.SQL.Clear;
   query.sql.add(' Exec  dbo.Z_CF_StoListaNotasParaLVENT  ' + copy(cb2.Items[cb2.ItemIndex],51,08) +' , '+  funcoes.StrToSqlDate( DateToSTr(dp1.date) ) +', '+ { quotedStr(GetUoEmitentes(copy(cb2.Items[cb2.ItemIndex],51,08))) +' , '+  } funcoes.StrToSqlDate( DateToSTr(dp2.date) )  );
//   Query.sql.SaveToFile('c:\teste.txt');
   query.Open;
   form1.LerColunasDbgrid('form1',dbgrid);
   LABEL2.Caption := 'LVENT';
   screen.Cursor := crDefault;
end;

function TForm1.GetCodForLoja(Uo:string): String;
var
  Arq:TstringList;
  i:integer;
  aux:string;
begin
   arq := tstringlist.Create();
   arq.LoadFromFile('FornecedoresLojas.txt');
   for i := 0 to arq.Count -1 do
      if copy(arq[i],01,02) = uo then
      begin
         aux := arq[i];
         delete( aux,01, pos(':',arq[i]));
         break;
      end;
   GetCodForLoja := aux;
   arq.Destroy;
end;


function TForm1.GetUoEmitentes(Uo:string): String;
var
  Arq:TstringList;
  i:integer;
  aux:string;
begin
  arq := tstringlist.Create();
  arq.LoadFromFile('CodigosLojas.txt');
  for i := 0 to arq.Count -1 do
     if copy(arq[i],04,08) = uo then
     begin
       aux := arq[i];
       delete( aux,01, pos(':',arq[i]));
       break;
     end;
  GetUoEmitentes := aux;
  arq.Destroy;
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
   if label2.Caption  = 'LVENT' then
      GeraEntrada(sender)
   else
      Showmessage('Para exportar a entrada você tem que antes gerar as notas de entrada');
end;

procedure TForm1.GeraEntrada(sender: tobject);
var
   aux:string;
begin
 //  query.First;
   aux := '';
   aux := aux+ HOME + 'GO '+ EDIT1.TEXT + ENTER;
//  while query.Eof = false do
   begin
      aux := aux + HOME + 'LVENT'+ ENTER + HOME + TAB + 'INCSNF1'; // CABECALHO

      if  query.Fields[2].AsString = 'NF1' then // preencher a serie
         aux := aux +'-  '
      else
         aux := aux +'2  ';
      // preencher o numero da nota
      aux := aux + funcoes.preencheCampo(6,'0','E',query.Fields[1].AsString);


      // preencher fornecedor + tipo
      aux := aux + FORM1.GetCodForLoja( (query.FieldByName('DESTINO').AsString)) + 'F';

     // preencher data
      aux := aux + Funcoes.SohNumeros(query.FieldByName('DATA').AsString) + '1102';
     //pular os campos dos dados
      aux := aux + form1.Repetir(13,TAB);
      // data entrada
      aux := aux + Funcoes.SohNumeros(query.FieldByName('DATA').AsString) + 'E';

      // valor da nota
      aux := aux + funcoes.preencheCampo(12,'0','E',funcoes.SohNumeros( funcoes.SohNumeros(query.FieldByName('valor').AsString)))
                 +  repetir(06,TAB);

      // valor BASE  de calculo
      aux := aux + funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(query.FieldByName('valorBaseICMS').AsString)) );
      // valor percentual icms

      aux := aux + funcoes.preencheCampo(04,'0','E', funcoes.SohNumeros(StrToMoney(query.FieldByName('percICMS').AsString))) + TAB;
      // valor icms
//      aux := aux + funcoes.preencheCampo(12,'0','E', FUNCOES.SohNumeros(StrToMoney(query.FieldByName('ValorICMS').AsString)) ) +TAB ;

//      aux := aux + ENTER;
      query.Next;
   end;
   clipboard.AsText := aux;
end;

procedure TForm1.dp1Change(Sender: TObject);
begin
   dp2.DateTime := dp1.DateTime;
end;

procedure TForm1.StoListaReducaoParaLVSAI(Sender: TObject);
begin
   screen.Cursor := crHourglass;
   datasource1.DataSet := qrReducao;
   qrReducao.SQL.Clear;
   qrReducao.sql.add(' Exec  dbo.Z_CF_StoListaReducaoParaLVSAI  ' + copy(cb2.Items[cb2.ItemIndex],51,08) +' , '+
                   funcoes.StrToSqlDate( DateToSTr(dp1.date) ) +', '+
                   funcoes.StrToSqlDate( DateToSTr(dp2.date) )  );
   qrReducao.Open;
   form1.LerColunasDbgrid('form1',dbgrid);
   LABEL2.Caption := 'REDUCAO';
   screen.Cursor := crDefault;
end;

procedure TForm1.GeraReducoes(sender: tobject);
begin
   if label2.Caption  = 'REDUCAO' then
      GeraReducoes(sender)
   else
      Showmessage('Para exportar as reduções você tem que antes gerar as reduções');
end;

{
procedure TForm1.FlatButton6Click(Sender: TObject);
var
   aux:string;
begin
   qrReducao.First;
   aux := '';
   aux := aux+ HOME + 'GO '+ EDIT1.TEXT + ENTER;
   while qrReducao.Eof = false do
   begin
      aux := aux + HOME + 'LVSAI'+ ENTER ;
      aux := aux + HOME + TAB + 'INCSCF ECF'; // CABECALHO

      //preencher o numero
      aux := aux + funcoes.preencheCampo(6,'0','E', qrReducao.fieldByName('COO_ATUAL').asString  ) + TAB  ;
      // preencher data
      aux := aux + Funcoes.SohNumeros(qrReducao.FieldByName('DATA').AsString);
      // preencher o cfo selo
      aux := aux + Funcoes.SohNumeros(qrReducao.FieldByname('CFO').AsString) +TAB + TAB;
      //preenche o tipo de venda
      aux := aux + '001';

      // dados do cliente
      aux := aux + repetir(10,TAB);
      // dados da UF
      aux := aux + 'CE';

      // complemento dados do cliente
      aux := aux + repetir(02,TAB);

      // dados vend/loja
      aux := aux + '0001V';

     // Preencher o caixa
      aux := aux + funcoes.preencheCampo(2,'0','E',qrReducao.FieldByName('serie').AsString);

      // valor da nota
//      aux := aux + qrReducao.FieldByName('VALOR').AsString + repetir(07,TAB);
       aux := aux +   floattostrf( qrReducao.FieldByName('VALOR').AsfLOAT,ffNumber,18,2) + repetir(07,TAB);
      // Base calculo do ICMS
//      aux := aux + qrReducao.FieldByName('VALORBASEICMS').asString + TAB ;
      aux := aux +   floattostrf( qrReducao.FieldByName('VALORBASEICMS').AsfLOAT,ffNumber,18,2) + TAB;

      // valor percentual icms
      aux := aux + '17.00' ;

      // valor icms
//      aux := aux + qrReducao.FieldByName('VALORICMS').asString +TAB ;
      aux := aux +   floattostrf( qrReducao.FieldByName('VALORICMS').AsfLOAT,ffNumber,18,2) + TAB;

      aux := aux + ENTER;
      qrReducao.Next;
   end;
   clipboard.AsText := aux;
end;
}

procedure TForm1.FlatButton6Click(Sender: TObject);
var
   aux:string;
begin

//   query2.First;
   aux := '';
//   aux := aux+ HOME + 'GO '+ EDIT1.TEXT + ENTER + HOME +'MRIFS' + ENTER;

//   while query2.Eof = false do
   begin
//      aux := aux + HOME +'VOLTA'+ ENTER + HOME +  'MRIFS'+ ENTER;
      aux := aux + HOME + TAB + 'INC'; // CABECALHO
      // CAIXA
      aux := aux +  funcoes.preencheCampo(2,'0','E',qrReducao.FieldByName('SERIE').AsString);   // SERIE ÉO CAIXA
      // DATA
      aux := aux + Funcoes.SohNumeros(qrReducao.FieldByName('data').AsString) + repetir(05,TAB);

      // COO INICIO + COO FIM
      aux := aux + funcoes.preencheCampo(6,'0','E',qrReducao.FieldByName('Nota').AsString)+
                   funcoes.preencheCampo(6,'0','E',qrReducao.FieldByName('Nota').AsString) ;
      // GT INICIAL
      aux := aux +
      funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('GT_ANT').AsString)) ) +
      funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('GT_ATUAL').AsString)) );

      // valor da nota
      aux := aux +      qrReducao.FieldByName('VL_MOVIMENTO').AsString;


      // valor BASE  de calculo
      aux := aux + funcoes.preencheCampo(09,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('VALOR').AsString)) ) ;
      // VALOR DO CANCELAMENTO
      aux := aux + funcoes.preencheCampo(09,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('VL_CANCEL').AsString)) ) ;

      // VALOR DO DESCONTO
      aux := aux + funcoes.preencheCampo(09,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('VL_DESC').AsString)) ) ;

      // VALOR BASE CALCULO ICMS
      aux := aux + funcoes.preencheCampo(09,'0','E', funcoes.SohNumeros(StrToMoney(qrReducao.FieldByName('valorBaseICMS').AsString)) )  + TAB;


      // valor icms
      aux := aux + funcoes.preencheCampo(09,'0','E', FUNCOES.SohNumeros(StrToMoney(qrReducao.FieldByName('VALORICMS').AsString )) ) ;

      // valorr d isentas
      aux := aux + funcoes.preencheCampo(09,'0','E', FUNCOES.SohNumeros(StrToMoney(qrReducao.FieldByName('VlIsentas').AsString )) ) ;

//      aux := aux + ENTER;

//      query2.Next;
  end;
  clipboard.AsText := aux;
end;
{}
procedure TForm1.ListarEntradasParaLVENT(Sender: TObject);
begin
   screen.Cursor := crHourglass;
   datasource1.DataSet := query3;
   query3.SQL.Clear;
   query3.sql.add(' Exec  dbo.Z_CF_StoListarEntradasParaLVENT ' +
                          copy(cb2.Items[cb2.ItemIndex],51,08) +' , '+
                          funcoes.StrToSqlDate( DateToSTr(dp1.date) ) +', '+
                          funcoes.StrToSqlDate( DateToSTr(dp2.date) )  );
   query3.Open;
   form1.LerColunasDbgrid('form1',dbgrid);
   PreeencheosFornecedores(sender);
   LABEL2.Caption := 'Notas de entrada';
   screen.Cursor := crDefault;
end;

procedure TForm1.Query3BeforePost(DataSet: TDataSet);
begin
   if  query3.FieldByname('CodForn').AsString <> '' then
       query3.FieldByname('EhCadastrado').AsString := 'X'
   else
       query3.FieldByname('EhCadastrado').AsString := '';
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_f7 )and  (ssCtrl in shift) then
  begin
     CarregaFornecedores(sender);
  end;
end;

procedure TForm1.CarregaFornecedores(sender: Tobject);
var
   dest,arq:Tstringlist;
   i:integer;
begin
   arq := Tstringlist.Create();
   arq.LoadFromFile('c:\Fornecedores.txt');
   dest := Tstringlist.Create();

   for i:= 0 to arq.count -1 do
   begin
      if  funcoes.SohNumeros(copy(arq[i],01,04)) <> '' then
      begin
          dest.Add(funcoes.preencheCampo(09,'0','E', copy(arq[i],154,08)) +
                   copy(arq[i],163,04)+
                   copy(arq[i],168,02)+':'+
                   funcoes.preencheCampo(04,'0','E', funcoes.SohNumeros(copy(arq[i],01,04)) ));
      end;
   end;
   arq.Destroy;
   dest.SaveToFile(extractFilePath(ParamStr(0)) + 'CodigosDosFornecedores.txt');
   dest.Destroy;
end;
procedure TForm1.PreeencheosFornecedores(sender: tobject);
begin
   query3.First;
   while query3.Eof = false do
   begin
      if query3.FieldByName('CodForn').AsString = '' then
          PreeencheCodFornecedor(sender);
      query3.Next;
   end;
end;

procedure TForm1.PreeencheCodFornecedor(sender: tobject);
var
   arq:tstringList;
   i:integer;
Begin
   arq := TstringList.Create();
   arq.LoadFromFile('CodigosDosFornecedores.txt');

   for i:= 0 to arq.Count -1 do
   begin
      if  ( query3.FieldByName('A').AsString + query3.FieldByName('nr_cpfCGC').AsString +
            query3.FieldByName('B').AsString + query3.FieldByName('nr_filcgc').AsString +
            query3.FieldByName('c').AsString + query3.FieldByName('dg_cpfcgc').AsString
            = copy(arq[i],01,15) ) and (query3.FieldByName('ehCadastrado').AsString <> 'X')  then
         begin
            query3.edit;
            query3.FieldByName('codForn').AsString := copy(arq[i],17,04);
            query3.FieldByName('ehCadastrado').AsString := 'X';
            query3.post;
            break;
         end;
   end;
   arq.DESTROY;
end;


procedure TForm1.GravarCodFornecedor(sender: tobject);
var
   arq:tstringList;
   i:integer;
   achou:boolean;
Begin
   arq := TstringList.Create();
   arq.LoadFromFile('CodigosDosFornecedores.txt');
   query3.First;
   while query.Eof = false do
   begin
      achou := false;
      for i:= 0 to arq.Count -1 do
      begin
         if  ( query3.FieldByName('A').AsString + query3.FieldByName('nr_cpfCGC').AsString +
               query3.FieldByName('B').AsString + query3.FieldByName('nr_filcgc').AsString +
               query3.FieldByName('c').AsString + query3.FieldByName('dg_cpfcgc').AsString
               = copy(arq[i],01,15) ) then
         begin
            showmessage( 'achei o forn' + copy(arq[i],01,15) );
            achou := true;
            break;
         end;

         if achou = false then
            arq.add(  query3.FieldByName('A').AsString + query3.FieldByName('nr_cpfCGC').AsString +
                   query3.FieldByName('B').AsString + query3.FieldByName('nr_filcgc').AsString +
                   query3.FieldByName('c').AsString + query3.FieldByName('dg_cpfcgc').AsString +':'+
                   funcoes.preencheCampo(04,'0','E', query3.FieldByName('CodForn').AsString )
                )
      end;
   end;
   arq.SaveToFile('CodigosDosFornecedores.txt');
end;


procedure TForm1.ExportarNotasFornecedor(Sender: Tobject);
var
   aux:string;
begin
   query3.First;
   aux := '';
   aux := aux+ HOME + 'GO '+ EDIT1.TEXT + ENTER;
   while query3.Eof = false do
   begin
      aux := aux + HOME + 'LVENT'+ ENTER + HOME + TAB + 'INCSNF '+ '1  '; // CABECALHO


      // preencher o numero da nota
      aux := aux + funcoes.preencheCampo(6,'0','E',query3.FieldByName('nota').AsString);

      // preencher fornecedor + tipo
      aux := aux + trim(query3.FieldByName('codforn').AsString) + 'F';

     // preencher data
      aux := aux + copy(Funcoes.SohNumeros(query3.FieldByName('DATA').AsString),01,06) + query3.FieldByName('cfo').AsString;
     //pular os campos dos dados
      aux := aux + form1.Repetir(13,TAB);
      // data entrada
      aux := aux + copy(Funcoes.SohNumeros(query3.FieldByName('DATAE').AsString),01,06) + 'E';

      // valor da nota
      aux := aux + funcoes.preencheCampo(12,'0','E',funcoes.SohNumeros( funcoes.SohNumeros(StrToMoney(query3.FieldByName('valor').AsString))) )
                 +  repetir(06,TAB);

      // valor BASE  de calculo
      aux := aux + funcoes.preencheCampo(12,'0','E', funcoes.SohNumeros(StrToMoney(query3.Fields[09].AsString)) );
      // valor percentual icms
      aux := aux + funcoes.preencheCampo(04,'0','e', funcoes.FloatToStrFomatado(query3.Fields[10].AsString ) );
      // valor icms
      aux := aux + funcoes.preencheCampo(12,'0','E', FUNCOES.SohNumeros( funcoes. StrToMoney(query3.Fields[11].AsString)) ) +TAB ;
      aux := aux + ENTER;
      query3.Next;
   end;
   clipboard.AsText := aux;
end;
procedure TForm1.FlatButton8Click(Sender: TObject);
var
   erro:String;
begin
   erro := '';
   query3.First;
   while query3.Eof = false do
   begin
      if query3.FieldByName('EhCadastrado').AsString <> 'X' then
          erro := erro + ' - Data: '+ query3.fieldByname('data').AsString + ' Nota: '+query3.FieldByName('Nota').AsString + ' Fornecedor: ' + query3.FieldByName('nm_pes').AsString + #13;

      query3.Next;
   end;
   erro := '';
   if Erro <> '' then
   begin
      Erro := 'Preencha antes o código do Fornecedor na escrita para  as notas: ' +#13+#13 + Erro;
      application.messagebox(pchar(erro), pchar(form1.caption), mb_iconerror+ mb_ok);
   end
   else
   begin
      GravarCodFornecedor(sender);
       ExportarNotasFornecedor(Sender);
   end;
end;

{

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'MPD.xls');

   Linha:=3;
   While Q.Eof = false do
   Begin
      for i:=0 to Q.FieldCount -1 do
      begin
         Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+2]:= trim(Q.Fields[i].AsVariant);
      end;
      Q.Next;
      inc(Linha);
   end;
   Excel.Visible :=True;
end;
}

procedure TForm1.GeraRelTransferenciaCF(Sender: Tobject);
var
  excel:OLEVariant;
  i,linha,nloja:integer;
  n01,n03,n04,v01,v03,v04:TstringList;
begin
//   dbgrid.Visible := false;
   n01 := Tstringlist.Create();
   n03 := Tstringlist.Create();
   n04 := Tstringlist.Create();
   v01 := Tstringlist.Create();
   v03 := Tstringlist.Create();
   v04 := Tstringlist.Create();

   query.First;
   while not(query.Eof) = true do
   begin
      if Query.FieldByName('tipo').AsString = 'T' then
      begin
         case Query.FieldByName('Destino').asInteger of
            1:begin
                 n01.Add( Query.FieldByName('nota').AsString );
                 v01.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;
            3:begin
                 n03.Add( Query.FieldByName('nota').AsString );
                 v03.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;
            4:begin
                 n04.Add( Query.FieldByName('nota').AsString );
                 v04.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end
         end;
      end;
      query.Next;
    end;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'NotasTransferencia.xls');

//   Excel.WorkBooks[1].Sheets[1].Cells[ linha , coluna ]


   Excel.WorkBooks[1].Sheets[1].Cells[3,2]:= 'Matriz';
   linha:=4;
   i:=0;
   for i:= 0 to n01.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,2]:= trim(n01[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,3]:= trim(v01[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,5]:= 'Edgar Borges';
   linha:=4;
   for i:= 0 to n03.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,5]:= trim(n03[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,6]:= trim(v03[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,8]:= 'BR 116';
   linha:=4;
   for i:= 0 to n04.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,8]:= trim(n04[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,9]:= trim(v04[i]);
      inc(linha);
   end;
   Excel.Visible :=True;
   dbgrid.Visible := true;
end;


procedure TForm1.GeraRelTransferenciaPFM(Sender: Tobject);
var
  excel:OLEVariant;
  i,linha,nloja:integer;
  n05,v05: TstringList;
  n06,v06: TstringList;
  n09,v09: TstringList;
  n10,v10: TstringList;
  n11,v11: TstringList;
  n12,v12: TstringList;
  n17,v17: TstringList;
  n16,v16: TstringList;
begin
   dbgrid.Visible := false;
   n05 := Tstringlist.Create();
   v05 := Tstringlist.Create();
   n06 := Tstringlist.Create();
   v06 := Tstringlist.Create();
   n09 := Tstringlist.Create();
   v09 := Tstringlist.Create();
   n10 := Tstringlist.Create();
   v10 := Tstringlist.Create();
   n11 := Tstringlist.Create();
   v11 := Tstringlist.Create();
   n12 := Tstringlist.Create();
   v12 := Tstringlist.Create();
   n17 := Tstringlist.Create();
   v17 := Tstringlist.Create();
   n16 := Tstringlist.Create();
   v16 := Tstringlist.Create();

   query.First;
   while not(query.Eof) = true do
   begin
      if Query.FieldByName('tipo').AsString = 'T' then
      begin
         case Query.FieldByName('Destino').asInteger of
            5:begin
                 n05.Add( Query.FieldByName('nota').AsString );
                 v05.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;

            6:begin
                 n06.Add( Query.FieldByName('nota').AsString );
                 v06.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;
            9:begin
                 n09.Add( Query.FieldByName('nota').AsString );
                 v09.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;

            10:begin
                 n10.Add( Query.FieldByName('nota').AsString );
                 v10.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;

            11:begin
                 n11.Add( Query.FieldByName('nota').AsString );
                 v11.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;

            12:begin
                 n12.Add( Query.FieldByName('nota').AsString );
                 v12.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;

            17:begin
                 n17.Add( Query.FieldByName('nota').AsString );
                 v17.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;
            16:begin
                 n16.Add( Query.FieldByName('nota').AsString );
                 v16.Add( floattostrf( Query.FieldByName('valor').asFloat ,ffNumber,18,2)) ;
               end;
         end;
      end;
      query.Next;
    end;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'NotasTransferencia.xls');

//   Excel.WorkBooks[1].Sheets[1].Cells[ linha , coluna ]

   Excel.WorkBooks[1].Sheets[1].Cells[3,2]:= 'Pedro';
   linha:=4;
   i:=0;
   for i:= 0 to n05.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,2]:= trim(n05[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,3]:= trim(v05[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,5]:= 'Dom Luis';
   linha:=4;
   for i:= 0 to n06.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,5]:= trim(n06[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,6]:= trim(v06[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,8]:= 'Teodoro ';
   linha:=4;
   for i:= 0 to n09.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,8]:= trim(n09[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,9]:= trim(v09[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,11]:= 'Messejana ';
   linha:=4;
   for i:= 0 to n10.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,11]:= trim(n10[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,12]:= trim(v10[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,14]:= 'Montese ';
   linha:=4;
   for i:= 0 to n11.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,14]:= trim(n11[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,15]:= trim(v11[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,17]:= 'Iguatemi ';
   linha:=4;
   for i:= 0 to n12.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,17]:= trim(n12[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,18]:= trim(v12[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,20]:= 'Paissandu ';
   linha:=4;
   for i:= 0 to n16.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,20]:= trim(n16[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,21]:= trim(v16[i]);
      inc(linha);
   end;

   Excel.WorkBooks[1].Sheets[1].Cells[3,23]:= 'Liberato ';
   linha:=4;
   for i:= 0 to n17.Count -1 do
   begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,23]:= trim(n17[i]);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,24]:= trim(v17[i]);
      inc(linha);
   end;

   Excel.Visible :=True;
   dbgrid.Visible := true;
end;


procedure TForm1.GeraRelTransferencia(sender: TOBject);
begin
   ListarNotasSaida(Sender);
   case StrToInt(edit1.text)of
     1,3,4: GeraRelTransferenciaCF(sender);
   else
      GeraRelTransferenciaPFM(sender)
   end;

end;

procedure TForm1.fsBitBtn1Click(Sender: TObject);
begin
  case rg1.ItemIndex of
     0:ListarNotasSaida(Sender);
     1:ListarEntradasParaLVENT(Sender);
     2:StoListaReducaoParaLVSAI(Sender);
     3:ObterEntradaFornecedor(Sender);
     4:GeraRelTransferencia(sender);
  end;
end;

procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
  screen.Cursor := crHourglass;
  funcoes.GravaLinhaEmUmArquivo( funcoes.TempDir() + 'Log_'+ application.Title + '.txt', commandtext );
end;

procedure TForm1.ADOConnection1ExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crHourglass;
end;

end.
