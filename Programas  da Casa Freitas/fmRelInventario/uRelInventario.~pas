unit uRelInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, db, ADOdb, mxExport;

type
  TfmRelInventario = class(TForm)
    btCarregaContagem: TfsBitBtn;
    tb: TADOTable;
    btCalculaDivergencia: TfsBitBtn;
    tb2: TADOTable;
    tbDirvg: TADOTable;
    Memo1: TMemo;
    cbExporta: TfsCheckBox;
    cbExportaWell: TfsCheckBox;
    Button1: TButton;
    procedure btCarregaContagemClick(Sender: TObject);
    procedure relatorioContagem(arquivos:TStrings);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure carregaTbInventario(tb:TADOTable; arquivos:TStrings; apagaAnterior:boolean);
    procedure btCalculaDivergenciaClick(Sender: TObject);
    procedure montaRelDivergencia(arquivos:TStrings);
    procedure calculaDivergencia(nmCont1, nmCont2:String; tb, tb2, tbDirvg:TADOTAble);
    procedure adicionaDivergencia(tipo, codigo, descricao, endereco, quant, pallet, msg, segundoValor:String);
    procedure exportaContagemWell(tableName:String);
    procedure Button1Click(Sender: TObject);
    procedure montaScriptWMS(arq:String);
    function tiraTraco(str:String):String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelInventario: TfmRelInventario;

implementation

{$R *.dfm}
uses uMain, funcoes, funcSQL, uCF;

procedure marcaDivergente(tb:TADOTable; campo:String);
begin
   tb.Edit();
   tb.FieldByName(campo).asString := 'x';
   tb.post();
end;

procedure TfmRelInventario.carregaTbInventario(tb: TADOTable; arquivos: TStrings; apagaAnterior:boolean);
const
   EAN_POS_INI = 1;
   EAN_TAM = 13;

   QT_POS_INI = 15;
   QT_TAM = 06;

   END_POS_INI =22;
   END_TAM = 12;

   PAL_POS_INI = 35;
   PAL_TAM = 4;
var
   lst:TStringList;
   j,i:integer;
   dsItem:TDataSet;
begin
   funcoes.gravaLog('carregaTbInventario()'  );


   if (tb.TableName <> '') then
     tb.close();

   funcSQL.getTable(fmMain.Conexao,
                    tb,
                    'codigo varchar(08), descricao varchar(50),'+
                    ' endereco varchar(12), qt int, pallet varchar(04), isDirvg varchar(10),'+
                    ' dvCont varchar(1), dvPallet varchar(1), msg varchar(140), ean varchar(13)' );

   if (arquivos <> nil) then
   for j:=0 to arquivos.count-1 do
   begin
      if ( fileExists(arquivos[j]) = true ) then
      begin
         memo1.lines.add( intToStr(j+1) +' de '+ intToStr(arquivos.Count) +' ' + arquivos[j]);
         funcoes.gravaLog( intToStr(j+1) +' de '+ intToStr(arquivos.Count) +' ' + arquivos[j]);
         lst := TStringList.create();
         lst.LoadFromFile(arquivos[j]);

         for i:=0 to lst.Count -1 do
         begin
            fmMain.msgStatus('item '+ intToStr(i+1) + ' de ' + intTostr(lst.count) );
            funcoes.gravaLog(lst[i]);

            if  (copy( lst[i], QT_POS_INI, QT_TAM) <> '000000') then
            begin
               // testar no ean 13
               dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], EAN_POS_INI, EAN_TAM)), '', '101', false);

               if ( dsItem.IsEmpty = true ) then
                  dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 02, 12)), '', '101', false);
               if ( dsItem.IsEmpty = true) then
                  dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 07, 07)), '', '101', false);
               if ( dsItem.IsEmpty = true) then
                  dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 06, 08)), '', '101', false);

               if ( dsItem.IsEmpty = false) then
                  tb.AppendRecord([ dsItem.fieldByName('codigo').asString,
                                    dsItem.fieldByName('descricao').asString,
                                    copy( lst[i], END_POS_INI, END_TAM),
                                    copy( lst[i], QT_POS_INI, QT_TAM),
                                    copy( lst[i], PAL_POS_INI, PAL_TAM),
                                    '',
                                    '',
                                    '',
                                    '',
                                    dsItem.fieldByName('ean').asString
                                 ])
               else
                  memo1.lines.add('Não encontrado:' +  lst[i] + arquivos[j] + ' linha:'+ intToStr(i) );
               dsItem.Free();
            end
            else
               memo1.lines.add('Qt Zero:' +  lst[i] + arquivos[j] + ' linha:'+ intToStr(i) );
         end;
      end;
   end;
   fmMain.msgStatus('');
end;

procedure TfmRelInventario.relatorioContagem(arquivos: TStrings);
var
   i:integer;
   params:TStringList;
begin
   funcoes.gravaLog('procedure relatorioContagem()' );

   if (tb2.TableName <> '') then
      tb2.close();
   funcsql.getTable(fmMAin.Conexao, tb2, 'arquivos varchar(250)' );

   for i:=0 to arquivos.Count-1 do
      tb2.AppendRecord([arquivos[i]]);


   carregaTbInventario( tb, arquivos, false );

   params := TStringList.create();
   params.add(intToStr(tb.RecordCount));

   if ( cbExporta.Checked = true) then
     funcsql.exportaTable(tb);

   if (cbExportaWell.Checked = true) then
      exportaContagemWell(tb.TableName);

    fmMain.impressaoRaveQr4( tb, tb2, nil, nil, 'rpInvContagem', params );
    tb.close();
    tb2.close();
end;

procedure TfmRelInventario.btCarregaContagemClick(Sender: TObject);
var
  arquivos:TStrings;
begin
    memo1.lines.clear();
    arquivos:= funcoes.dialogAbrVariosArq('txt','c:\');

    if (arquivos <> nil  ) then
       relatorioContagem(arquivos);
end;


procedure TfmRelInventario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    fmRelInventario := nil;
    action := caFree;
end;


procedure TfmRelInventario.calculaDivergencia(nmCont1, nmCont2:String; tb, tb2, tbDirvg: TADOTAble);
var
   ds:TDataSet;
   cmd:String;
begin
   fmMain.msgStatus('Calculando divergencias...');

    tb.first();
    while (tb.eof = false) do
    begin
       if (tb.FieldByName('isDirvg').asString = 'x') then
       begin
           tb.next();
           continue;
       end;

       cmd := 'select * from '+ tb2.TableName +' where  codigo = ' +
              quotedStr(tb.fieldByName('codigo').AsString) +
              ' and endereco = ' + quotedStr(tb.fieldByName('endereco').AsString);

       ds:= funcSQL.getDataSetQ(cmd, fmMain.conexao);

       if (ds.IsEmpty = true) then
       begin
          adicionaDivergencia( 'endereco',
                               tb.FieldByName('codigo').AsString,
                               tb.FieldByName('descricao').AsString,
                               tb.FieldByName('endereco').AsString,
                               tb.FieldByName('qt').AsString,
                               tb.FieldByName('pallet').AsString,
                               '('+ intToStr(tb.RecNo)+') '+
                               'Item de '+ nmCont1 + ', falta a outra contagem   ',
                               '');
       end
       else
       begin
          if (tb.FieldByName('pallet').AsString <> ds.FieldByName('pallet').AsString) then
          begin
             adicionaDivergencia( 'pallet',
                                  tb.FieldByName('codigo').AsString,
                                  tb.FieldByName('descricao').AsString,
                                  tb.FieldByName('endereco').AsString,
                                  tb.FieldByName('qt').AsString,
                                  tb.FieldByName('pallet').AsString,
                                  '('+ intToStr(tb.RecNo)+')'+'Pallet divergente, ' + nmCont1 +' '
                                  + tb.FieldByName('pallet').AsString
                                  +' '+nmCont2 +' '+ ds.FieldByName('pallet').AsString
                                  , ds.FieldByName('pallet').AsString
                               );
          end;

          if (tb.FieldByName('qt').AsString <> ds.FieldByName('qt').AsString) then
          begin
             adicionaDivergencia( 'qt',
                                  tb.FieldByName('codigo').AsString,
                                  tb.FieldByName('descricao').AsString,
                                  tb.FieldByName('endereco').AsString,
                                  tb.FieldByName('qt').AsString,
                                  tb.FieldByName('pallet').AsString,
                                  '('+ intToStr(tb.RecNo)+')'+'Quant divergente, ' + nmCont1 +' '
                                  + tb.FieldByName('qt').AsString +' '+ nmCont2
                                  +' '+ ds.FieldByName('qt').AsString
                                  ,ds.FieldByName('qt').AsString
                               );
          end;
       end;
       ds.Free;
       tb.next();
    end;
end;


procedure TfmRelInventario.montaRelDivergencia(arquivos:TStrings);
var
  aux:Tstrings;
begin
    aux := TStringList.create();
    aux.Add(arquivos[0]);
    carregaTbInventario(tb, aux, true);

    funcoes.gravaLog('carreguei  a primeira');

    aux := TStringList.create();
    aux.Add(arquivos[1]);

    carregaTbInventario(tb2, aux, true);
    funcoes.gravaLog('carreguei  a segunda');

    carregaTbInventario(tbDirvg, nil, true);

    calculaDivergencia('C1', 'C2', tb, tb2, tbDirvg);
    calculaDivergencia('C2', 'C1', tb2, tb, tbDirvg);
end;

procedure TfmRelInventario.btCalculaDivergenciaClick(Sender: TObject);
var
   params:TStringList;
   arquivos : TStrings;
begin
   arquivos :=  funcoes.dialogAbrVariosArq('txt','c:\');

   if (arquivos <> nil) then
      if (arquivos[0] <> '') and (arquivos[01] <> '') and (arquivos[0] <> arquivos[1]) then
      begin
         montaRelDivergencia(arquivos);


         params := TStringlist.create();
         params.add(arquivos[0]);
         params.add(arquivos[1]);

         fmMain.msgStatus('Ordenando divergências...' );
         tbDirvg.Sort := 'endereco, codigo, msg';

         funcoes.gravaLog('terminei as divergencias');

         fmMain.msgStatus('');
         fmMain.impressaoRaveQr4(tbDirvg, nil, nil, nil, 'rpInvDivergencias', params);

      end
      else
         funcoes.msgTela('', 'Erro ao carregar arquivos.', MB_ICONERROR + MB_OK);
end;

procedure TfmRelInventario.adicionaDivergencia(tipo, codigo, descricao, endereco, quant, pallet, msg, segundoValor: String);
var
   ds:TdataSet;
   cmd:String;
begin
   funcoes.gravaLog('adicionaDivergencia()');
   
   cmd := 'Select * from '+ tbDirvg.tablename + ' where codigo = ' + quotedStr(codigo) + 'and  isDirvg = ' + quotedStr(tipo);

   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   if ( ds.IsEmpty = true) then
      tbDirvg.AppendRecord([codigo, descricao, endereco, quant, pallet, tipo, '', '', msg,'ean']);
end;



procedure TfmRelInventario.exportaContagemWell(tableName: String);
var
   ds:Tdataset;
   cmd,codLoja:String;
begin
   codLoja := funcSQl.openSQL('Select cd_uo from zcf_tbuo where is_uo = '+ fmMain.getUoLogada(), 'cd_uo',fmMain.Conexao);
   codLoja := funcoes.preencheCampo(4,'0','E',codLoja);

   cmd :=
   'Select codigo, ean, sum (qt) as qt from ' +
   tableName +
   ' group by codigo, ean, qt';
   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   ds.First();
   while ( ds.Eof = false) do
   begin
       funcoes.GravaLinhaEmUmArquivo( 'c:\Contagem_'+codloja+'.txt',
       codLoja +
       funcoes.preencheCampo(13, ' ', 'D', ds.fieldByname('codigo').AsString) +
       funcoes.preencheCampo(05, '0', 'E', ds.fieldByname('qt').AsString)
         );
      ds.Next();
   end;
   ds.free();
end;
{
procedure TfmRelInventario.Button1Click(Sender: TObject);
{var
   arq:Tstrings;
   arqCorrente:TStringlist;
   i,j:integer;
begin
{    arq := funcoes.dialogAbrVariosArq('txt','c:\');
    arqCorrente := TStringlist.create();
    for i:=0 to arq.Count -1 do
    begin
       arqCorrente.LoadFromFile(arq[i]);

       for j:=0 to arqCorrente.count- 1 do
         arqCorrente[j] := funcoes.preencheCampo( 38, '0', 'e',    trim(arqCorrente[j])   );

       arqCorrente.SaveToFile(arq[i]);
    end;
    memo1.Lines.Add('ók');



end;
}
procedure TfmRelInventario.montaScriptWMS(arq: String);
var
   ds:TDataSet;
   arqPallet,arqItensP: TstringList;
   i:integer;
   aux:String;
   cmd:String;
begin



{   arqPallet:=TStringList.create();


   cmd := 'Select pallet, endereco from zcf_pallet order by pallet' ;
   ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

{
//montar arquivo script de pallet
   ds.First();
   while (ds.Eof = false) do
   begin
      aux:=
      'INSERT INTO TPALETE ( STR_ID_PALETE, '  +
                            'STR_ID_TIPOPALETE, '+
				                  	'STR_ID_PESSOA, '+
					                  'STR_ID_ENDERECO, '+
					                  'INT_ID_ARMAZEM, '+
					                  'FLT_PESOEMPILHAMENTO_PALETE, '+
					                  'DTM_MONTAGEM_PALETE, '+
					                  'STR_FLAGUTILIZADO_PALETE, '+
					                  'STR_FLAGBLOQUEADO_PALETE, '+
					                  'STR_FLAGRESERVADO_PALETE, '+
					                  'STR_FLAGRECEBIMENTO_PALETE, '+
					                  'STR_FLAGPRODAVARIADO_PALETE '+
                            ') VALUES ( '+
       quotedStr( funcoes.preencheCampo(4,'0','e', ds.fieldByName('pallet').AsString) ) +', '+
       quotedStr('P01') +', '+
       quotedStr('7221377000110') +', '+
       quotedStr(tiraTraco( ds.fieldByName('endereco').AsString)) +', '+
       '1' +', '+
       '100000'+', '+
       'NULL'+', '+
       quotedstr('true')+', '+
       quotedstr('false')+', '+
       quotedstr('false')+', '+
       quotedstr('false')+', '+
       quotedstr('false')+'); ' ;

       arqPallet.add(aux);
       ds.Next();
   end;
   arqPallet.SaveToFile('c:\Script_carga_pallet.sql' );
   arqPallet.Free();
   memo1.Lines.add('Pallet');


   arqItensP := TStringlist.Create();

    ds.Free();
}
    arqItensP := TStringlist.Create();
    cmd := 'Select codigo, ean, endereco, pallet2 as pallet, qt from zcf_inv_wms where codigo = ''00020443'' order by codigo';
    ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);


   i:=0;
   ds.First();
   while (ds.Eof = false) do
   begin
      inc(i);
      aux :=
      'INSERT INTO TITPALETE ( STR_ID_PALETE, ' +
                              'STR_ID_ITPALETE, ' +
                              'STR_SERIE_ITPALETE, ' +
                              'STR_ID_SKU,  ' +
                              'STR_ID_PESSOA_SKU, ' +
                              'FLT_QUANTIDADE_ITPALETE, ' +
                              'STR_NUMERO_DOC, ' +
                              'STR_SERIE_DOC, ' +
                              'STR_ID_PESSOA, ' +
                              'STR_IDPRODUTO_DOC, ' +
                              'DTM_ENTRADA_ITPALETE, ' +
                              'STR_FLAG_ALOCADO, ' +
                              'DTM_VALIDADE_ITPALETE, ' +
                              'STR_LOTE_ITPALETE, ' +
                              'STR_FLAG_BLOQUEIO, ' +
                              'FLT_PESO_ITPALETE, ' +
                              'STR_TIPO_DOC, ' +
                              'STR_UNIDADE_ITPALETE, ' +
                              'FLT_QTDALOCADA_ITPALETE, ' +
                              'FLT_PESOALOCADO_ITPALETE ' +
                              ') VALUES (' +

         quotedStr(tiraTraco( ds.fieldByName('pallet').AsString )) +', '+
         quotedStr( intToStr(i)  ) +', '+
         quotedStr( intToStr(i)  ) +', '+
         quotedStr( ds.fieldByName('codigo').AsString ) +', '+
         quotedStr( '7221377000110') +', '+
         ds.fieldByName('qt').AsString  +', '+
         quotedStr('00001') +', '+
         quotedStr('0') +', '+
         quotedStr( '7221377000110') +', '+
         quotedStr( '0000001') +', '+
         quotedStr( '2011-07-01 00:00:00') +', '+
         quotedStr( 'false') +', '+
         quotedStr( '2050-07-01 00:00:00') +', '+
         quotedStr('0') +', '+
         quotedStr('false') +', '+
         '0' +', '+
         quotedStr('E') +', '+
         quotedStr('MT') +', '+
         '0' +', '+
         '0' +' );';

       arqItensP.add(aux);
       ds.Next();
   end;
   arqItensP.SaveToFile('c:\Script_carga_pallet_itens.sql' );
   arqItensP.Free();
   memo1.Lines.add('itens do Pallet');
{ }
 cmd:=
    'select codigo, ean, endereco, qt, pallet from zcf_inv_wms order by codigo';

 ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);
 ds.First();
 while (ds.Eof = false) do
 begin
    funcoes.GravaLinhaEmUmArquivo('c:\InventarioWMS.txt',
    ds.FieldByName('codigo').AsString +';'+
    ds.FieldByName('ean').AsString +';'+
    ds.FieldByName('endereco').AsString +';'+
    ds.FieldByName('qt').AsString +';'+
    ds.FieldByName('pallet').AsString +';');
    ds.Next();
end;
end;


procedure TfmRelInventario.Button1Click(Sender: TObject);
var
  str:String;
begin
//   str:= funcoes.dialogAbrArq('txt','c:\');
//   if ( str <> '') then
      montaScriptWMS(str);
end;


function TfmRelInventario.tiraTraco(str: String): String;
begin
   while (pos('-',str) > 0) do
      delete(str, pos('-',str), 01);
   result := str;
end;

end.
