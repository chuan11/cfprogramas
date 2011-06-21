unit uRelInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, db, ADOdb;

type
  TfmRelInventario = class(TForm)
    fsBitBtn1: TfsBitBtn;
    tb: TADOTable;
    fsBitBtn2: TfsBitBtn;
    tb2: TADOTable;
    tbDirvg: TADOTable;
    Memo1: TMemo;
    procedure fsBitBtn1Click(Sender: TObject);
    procedure relatorioContagem(arq:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure carregaTbInventario(tb:TADOTable; arq:String);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure montaRelDivergencia(arq1,arq2:String);
    procedure calculaDivergencia(nmCont1, nmCont2:String; tb, tb2, tbDirvg:TADOTAble);
    procedure adicionaDivergencia(tipo, codigo, descricao, endereco, quant, pallet, msg, segundoValor:String);

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

procedure TfmRelInventario.fsBitBtn1Click(Sender: TObject);
var
  arq:String;
begin
    arq:= funcoes.DialogAbrArq('txt','c:\');
    if (fileExists(arq) = true ) then
       relatorioContagem(arq);
end;

procedure TfmRelInventario.carregaTbInventario(tb: TADOTable; arq: String);
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
   i:integer;
   dsItem:TDataSet;
begin
   fmMain.msgStatus('Carregando itens de '+ arq);
   if (tb.TableName <> '') then
      tb.close();

   funcSQL.getTable(fmMain.Conexao, tb, 'codigo varchar(08), descricao varchar(50),'+
                   ' endereco varchar(12), qt varchar(06), pallet varchar(04), isDirvg varchar(1), dvCont varchar(1), dvPallet varchar(1), msg varchar(100)' );
   if (arq <> '') then
   begin
      lst := TStringList.create();
      lst.LoadFromFile(arq);


      for i:=0 to lst.Count -1 do
      begin
         fmMain.msgStatus('item '+ intToStr(i+1) + ' de ' + intTostr(lst.count) );
         funcoes.gravaLog(lst[i]);

        // testar no ean 13
         dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], EAN_POS_INI, EAN_TAM)), '101', false);

         if ( dsItem.IsEmpty = true ) then
            dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 02, 12)), '101', false);

         if ( dsItem.IsEmpty = true) then
            dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 07, 07)), '101', false);

         if ( dsItem.IsEmpty = true) then
            dsItem:= uCF.getDadosProd( fmMain.getUoLogada, trim(copy(lst[i], 06, 08)), '101', false);


         if ( dsItem.IsEmpty = false) then
            tb.AppendRecord([ dsItem.fieldByName('codigo').asString, dsItem.fieldByName('descricao').asString, copy( lst[i], END_POS_INI, END_TAM), copy( lst[i], QT_POS_INI, QT_TAM), copy( lst[i], PAL_POS_INI, PAL_TAM) ])
         else
            memo1.lines.add('Não encontrado:' +  lst[i]);

        dsItem.Free();
      end;
   end;
   fmMain.msgStatus('');
end;

procedure TfmRelInventario.relatorioContagem(arq: String);
var
   params:TStringlist;
begin
  carregaTbInventario(tb, arq);
  params := TStringList.create();
  params.add(arq);
  params.add(intTostr(tb.RecordCount));
  fmMain.impressaoRaveQr2(tb, nil, 'rpInvContagem', params );
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
                               'Item de '+ nmCont1 + ', falta a outra contagem',
                               ''
                               );
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
                                  'Pallet divergente, ' + nmCont1 +' '+ tb.FieldByName('pallet').AsString +' '+nmCont2 +' '+ ds.FieldByName('pallet').AsString
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
                                  'Quant divergente, ' + nmCont1 +' '+ tb.FieldByName('qt').AsString +' '+ nmCont2 +' '+ ds.FieldByName('qt').AsString
                                  ,ds.FieldByName('qt').AsString
                                 );
          end;
       end;
       ds.Free;
       tb.next();
    end;
end;


procedure TfmRelInventario.montaRelDivergencia(arq1, arq2: String);
begin
    carregaTbInventario(tb, arq1);
    carregaTbInventario(tb2, arq2);
    carregaTbInventario(tbDirvg, '');

    calculaDivergencia('C1', 'C2', tb, tb2, tbDirvg);
    calculaDivergencia('C2', 'C1', tb2, tb, tbDirvg);
end;

procedure TfmRelInventario.fsBitBtn2Click(Sender: TObject);
var
   arq2, arq1:String;
   params:TStringList;
begin
   arq1 := funcoes.dialogAbrArq('txt','c:\');
   arq2 := funcoes.dialogAbrArq('txt','c:\');

   if (arq1 <> '') and (arq2 <> '') and (arq1 <> arq2) then
   begin
      montaRelDivergencia(arq1, arq2);

      params := TStringlist.create();
      params.add(arq1);
      params.add(arq2);

      fmMain.msgStatus('Ordenando divergencias...' );
      tbDirvg.Sort := 'codigo, msg';

      fmMain.msgStatus('');
      fmMain.impressaoRaveQr2(tbDirvg, nil, 'rpInvDivergencias', params);
   end
   else
      funcoes.msgTela('', 'Erro ao carregar arquivos.', MB_ICONERROR + MB_OK);
end;

procedure TfmRelInventario.adicionaDivergencia(tipo, codigo, descricao, endereco, quant, pallet, msg, segundoValor: String);
begin
   tbDirvg.AppendRecord([codigo, descricao, endereco, quant, pallet, '', '', '', msg]);
end;

end.
