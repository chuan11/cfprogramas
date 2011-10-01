unit uPrecosCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, DB, ADODB,funcoes,FuncSQL, Grids,
  DBGrids, SoftDBGrid, adLabelEdit, adLabelNumericEdit, TFlatButtonUnit,
  TFlatCheckBoxUnit, fCtrls, adLabelSpinEdit;

type
  TfmPrecoCustos = class(TForm)
    edCodigo: TadLabelEdit;
    query: TADOQuery;
    Grid: TSoftDBGrid;
    DataSource1: TDataSource;
    edPcNovo: TadLabelNumericEdit;
    btAjustaPreco: TFlatButton;
    btConsultaProduto: TFlatButton;
    cbCustoFiscal: TFlatCheckBox;
    cbCustoMedio: TFlatCheckBox;
    cbCustoMedioUnico: TFlatCheckBox;
    cbajustaTodos: TFlatCheckBox;
    cbLoja: TadLabelComboBox;
    memoItens: TMemo;
    Button1: TButton;
    mmResult: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    edNome: TadLabelEdit;
    cbLancaEstoque: TCheckBox;
    GroupBox1: TGroupBox;
    FlatButton1: TFlatButton;
    edAjustaCusto: TadLabelSpinEdit;
    FlatButton2: TFlatButton;
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btAjustaPrecoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function AjustaPreco(valor, percentual: string): string;
    procedure btConsultaProdutoClick(Sender: TObject);
    procedure cbCustoMedioUnicoClick(Sender: TObject);
    procedure ajustaPrecoCusto(Sender:Tobject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AcertaQuantidades(Sender:Tobject);
    procedure Label1DblClick(Sender: TObject);
    procedure LimparMemo(var memo:Tmemo);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure custosPorNota(is_nota:String);
    procedure efetuaAjustDeNota(TipoAjuste:String);
    procedure recalcularCmuNota(isNota:String);
    procedure btRecalculaCMUItensNotaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrecoCustos: TfmPrecoCustos;

implementation

uses uMain, uCF;

{$R *.dfm}

var
  UO_CD, CD_PES_EMP:String;

function TfmPrecoCustos.AjustaPreco(valor, percentual: string): string;
var
   aux1,aux2,aux3:real;
begin
   while pos('.',valor) > 0 do
      delete(valor,pos('.',valor),01);

   aux1 := Strtofloat(valor);
   aux2 := Strtofloat(percentual);
   aux3:=  (aux1 * aux2);
   valor := FloatTostr( aux3  );
   AjustaPreco :=  FloatToStrF( aux3 ,ffFixed,18,02);
end;


procedure TfmPrecoCustos.btConsultaProdutoClick(Sender: TObject);
var
  cod:string;
  ds:TdataSet;
begin
     SCREEN.Cursor := crHourGlass;

      cod := funcSql.GetValorWell('O','Select is_ref from crefe where cd_ref = ' + QuotedStr(edCodigo.text), 'is_ref', fmMain.Conexao );
      if cod <> '' then
      begin
         edNome.text := '';      
         edNome.text := funcSql.GetValorWell('O','Select CD_REF +''  ''+ds_ref AS DS_REF from crefe where cd_ref = ' + QuotedStr(edCodigo.text), 'ds_ref', fmMain.Conexao );
         query.SQL.Clear;
         query.sql.add( ' select is_uo, ds_uo as Loja, ' +
                        ' dbo.Z_CF_funObterPrecoProduto_CF(001, ' +cod+', is_uo, ' +CD_PES_EMP+ ') VlCusto, ' +
                        ' dbo.Z_CF_funObterPrecoProduto_CF(005, ' +cod+', is_uo, ' +CD_PES_EMP+ ') VlCMU, ' +
                        ' dbo.Z_CF_funObterPrecoProduto_CF(103, ' +cod+', is_uo, ' +CD_PES_EMP+ ') VlAtacado, ' +
                        ' dbo.Z_CF_funObterPrecoProduto_CF(103, ' +cod+', is_uo, ' +CD_PES_EMP+ ') * .70  as [70% de VlAtacado], ' +
                        ' dbo.Z_CF_EstoqueNaLoja ( ' +cod+'   , is_uo, 1 ) as Estoque ' +
                        ' from tbuo with(Nolock) where tbuo.tp_estoque in (1,2) ');

                        if cbLoja.itemIndex > 0  then
                           query.sql.add( ' and is_uo in( ' +UO_CD+ ', ' +  funcoes.getCodUO(cbLoja)  +')' )
                        else
                           query.sql.add( ' and is_uo not in (10036710, 10042256, 10034573 ) ');


         query.sql.add( ' order by tp_estoque, is_uo ');
         Query.Open;
         grid.Columns[0].visible := false;
         grid.Columns[0+1].Width := 150;
         grid.Columns[1+1].Width := 100;
         grid.Columns[2+1].Width := 70;
         grid.Columns[3+1].Width := 70;
      end;
   edPcNovo.SetFocus;
   SCREEN.Cursor := crdefault;
end;


procedure TfmPrecoCustos.edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   if key = VK_Return then
   begin
      btConsultaProdutoClick(SENDER);
   end;
end;
procedure TfmPrecoCustos.ajustaPrecoCusto(Sender: Tobject);
var
   cod, Erro:String;
   cmd:String;
begin
   cod := funcSql.GetValorWell('O','Select is_ref from crefe where cd_ref = ' + QuotedStr(edCodigo.text), 'is_ref', fmMain.Conexao );

   begin
      if cbCustoFiscal.Checked = true then
      begin
         funcSql.GetValorWell('E', ' Update dlest set ' +
                                   ' custoUnitario  = ' + funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                   ' where is_lanc in ( ' +
                                                          'select top 1 is_lanc from dlest with(Nolock) where '+
                                                          ' is_ref = '+cod+
                                                          ' and is_estoque = '+  query.fieldByname('is_uo').AsString  +' and is_tpcte = 6 '+
                                                          'order by is_lanc desc '+
                                                     ' ) '
                                   ,'@@error',fmMain.Conexao);
      end;

      if cbCustoMedio.Checked = true then
      begin
         funcSql.GetValorWell('E', ' Update dlest set '+
                                   ' CustoMedioUnitario = ' +  funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                   ' where is_lanc in ( ' +
                                                          'select top 1 is_lanc from dlest with(Nolock) where '+
                                                          ' is_ref = '+cod+
                                                          ' and is_estoque = '+  query.fieldByname('is_uo').AsString  +' and is_tpcte = 6 '+
                                                          'order by is_lanc desc '+
                                                     ' ) '
                                   ,'@@error',fmMain.Conexao);
      end;

      if cbCustoMedioUnico.Checked = true then
      begin
         funcSql.GetValorWell('E', ' Update dlest set '+
                                   ' CustoMedioUnitarioUnico =  '+funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                   ' where is_lanc in ( ' +
                                                          'select top 1 is_lanc from dlest with(Nolock) where '+
                                                          ' is_ref = '+cod+
                                                          ' and is_estoque = '+  query.fieldByname('is_uo').AsString  +' and is_tpcte = 6 '+
                                                          'order by is_lanc desc '+
                                                     ' ) '
                                   ,'@@error',fmMain.Conexao);
      end;


{


      if   funcSql.GetValorWell('E', ' Update dlest set
                                     ' custoUnitario  = ' + funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                     ' ,CustoMedioUnitario = ' +  funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                     ' ,CustoMedioUnitarioUnico =  '+funcoes.StrToPrecoSQL(edPcNovo.Text) +
                                     ' where is_lanc in ( ' +
                                                          'select top 1 is_lanc from dlest with(Nolock) where '+
                                                          ' is_ref = '+cod+
                                                          ' and is_estoque = '+  query.fieldByname('is_uo').AsString  +' and is_tpcte = 6 '+
                                                          'order by is_lanc desc '+
                                                      ' ) '
                         ,'@@error',connection) = '0' then

}
   end;
   edNome.text := '';
   edCodigo.SetFocus;
end;

procedure TfmPrecoCustos.FormActivate(Sender: TObject);
begin
   edCodigo.SetFocus;
end;


procedure TfmPrecoCustos.cbCustoMedioUnicoClick(Sender: TObject);
begin
   if (query.IsEmpty = false) then
      if (cbCustoFiscal.Checked = false) and( cbCustoMedio.Checked = false ) and( cbCustoMedioUnico.Checked= false )then
      begin
         MsgTela('','Marque ao menos uma opção',mb_IconError+mb_ok);
         cbCustoFiscal.Checked :=true;
      end;
end;

procedure TfmPrecoCustos.btAjustaPrecoClick(Sender: TObject);
var
   i:smallint;
   erro:string;
begin
   screen.Cursor := crHourGlass;
   erro := '';
   if edPcNovo.Text = '0,00' then
      erro:= erro + 'Falta o valor'+ #13;

   if erro <> '' then
   begin
      erro := ' Erros encontrados : ' + #13+ erro;
      msgTela('', erro,mb_iconError + mb_ok);
   end
   else
   begin
      if cbajustaTodos.Checked then
      begin
         query.First;
         while  query.Eof = false  do
         begin
            ajustaPrecoCusto(Sender);
            query.Next;
         end;
      end
      else
         ajustaPrecoCusto(Sender);
   end;
   screen.Cursor := crDefault;
end;


procedure TfmPrecoCustos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   mmResult.Lines.Clear();
   memoItens.lines.clear();
   edCodigo.Text := '';
   edPcNovo.Text := '';
   fmMain.fecharForm(fmPrecoCustos, Action);
   action := CaFree;
   fmPrecoCustos := nil;
end;

procedure TfmPrecoCustos.AcertaQuantidades(Sender: Tobject);
var
   i:integer;
   nmTable,cod:string;
   quant,est:integer;
   tbItens:TADOTable;
   qrItens :TADOQuery;
begin
  nmTable := '#'+funcoes.SohNumeros( dateTimeToStr(now) );
  cod := 'Create table '+ nmTable+ ' ( quant integer, is_ref integer, preco money ) ';
  funcsql.execSQL(cod,fmMain.Conexao);
  tbItens  := TADOTable.Create(nil);
  tbitens.Connection := fmMain.Conexao;
  tbItens.TableName := nmTable;

  qrItens := TADOQuery.create(nil);
  qrItens.Connection := fmMain.Conexao;
  qrItens.SQL.Add('Select * from ' + nmTable);
  qrItens.open;

  for i:= 0 to memoItens.Lines.Count -1 do
  if funcoes.SohNumeros(memoItens.lines[i]) <> '' then
  begin
     cod := funcSQl.openSQL('Select is_ref from crefe (nolock) where cd_ref = ' +  quotedStr(fmMain.getCdRef(memoItens.lines[i]))  {quotedStr(trim(copy(memoItens.lines[i],01,08))) } , 'is_ref', fmMain.Conexao);
     if cod <>  '' then
     begin
        if funcoes.SohNumeros( copy(memoItens.lines[i],09,20)) = '' then
           quant :=  strToInt('0'+funcoes.SohNumeros(copy(memoItens.lines[i],09,20)))
        else
           quant :=  strToInt(funcoes.SohNumeros( copy(memoItens.lines[i],09,20)));

        est := strToInt( funcSQl.openSQL(' select dbo.Z_CF_EstoqueNaLoja ( '+cod+','+  copy(cbLoja.Items[cbLoja.ItemIndex],51,08)  + ' , 1 ) as Estoque '  , 'estoque', fmMain.Conexao) );
        if quant >  est then
        begin
           mmResult.Lines.Add('Acertar : ' + fmMain.getCdRef(memoItens.lines[i]) + '  quant:' +  intToStr(quant-est) + ' Est: '+  inttostr(est));
           qrItens.Append;
           qrItens.fieldByName('quant').asString := inttostr( quant - est );
           qrItens.fieldByName('is_ref').asString := cod;
           qrItens.fieldByName('preco').asString := '0';
           qrItens.Post;
        end
        else
          mmResult.lines.Add('Já tem estoque: ' + memoItens.lines[i]  +'  estoque: '+ inttostr(est));
     end
     else
        mmResult.lines.Add('Codigo invalido: ' + memoItens.lines[i] );
  end;

  qrItens.First;
  funcSQl.AcertaQuantidadeItens( copy(cbLoja.Items[cbLoja.ItemIndex],51,08) , '10000592', qritens,fmMain.Conexao);
end;



procedure TfmPrecoCustos.Label1DblClick(Sender: TObject);
begin
   memoItens.Lines.Clear;
end;

procedure TfmPrecoCustos.LimparMemo(var memo: Tmemo);
begin
   memo.Lines.Clear
end;

procedure TfmPrecoCustos.Label1Click(Sender: TObject);
begin
  LimparMemo( memoitens );
end;

procedure TfmPrecoCustos.Label2Click(Sender: TObject);
begin
  LimparMemo( mmResult );
end;

procedure TfmPrecoCustos.Button1Click(Sender: TObject);
var
  i:integer;
begin
  if  cbLancaEstoque.Checked = true then
     AcertaQuantidades(Sender);

  mmResult.Lines.Add('----------------------------------');


  for i:=0 to memoItens.Lines.Count -1 do
  begin
     if funcoes.SohNumeros(trim(copy(memoItens.lines[i],01,08))) <> '' then
     begin
        edCodigo.Text := fmMain.getCdRef(memoItens.lines[i]);   //   funcoes.SohNumeros(copy(memoItens.lines[i],01,07));
        btConsultaProdutoClick(Sender);
        if edNome.text <> '' then
        begin
           query.first;
           if query.fieldByName('VlCusto').AsFloat > 0 then
           begin
              edPcNovo.Text := query.fieldByName('VlCusto').asString;
              btAjustaPrecoClick(Sender);
           end
           else if query.fieldByName('VlCMU').AsFloat > 0 then
           begin
              edPcNovo.Text := query.fieldByName('VlCMU').asString;
              btAjustaPrecoClick(Sender);
           end
           else if query.fieldByName('VlAtacado').AsFloat > 0 then
              edPcNovo.Text := query.fieldByName('VlAtacado').asString
           else
              mmResult.Lines.add(edCodigo.text + ' Sem preco: ' + copy(memoItens.lines[i],01,20));

           if edPcNovo.Value > 0 then
              begin
                 query.Next;
                 if query.fieldByName('estoque').asFloat > 0 then
                 begin
                    btAjustaPrecoClick(Sender);
                    mmResult.Lines.add(edCodigo.text + ' Lancado Preco')
                 end
                 else
                    mmResult.Lines.add(edCodigo.text + ' Sem estoque: ' + copy(memoItens.lines[i],08,20));
              end;
           end;
     end;
  end;
end;

procedure TfmPrecoCustos.custosPorNota(is_nota:String);
var
  ds:TDataSEt;
  cmd: String;
begin
   cmd := '/* pegando os custo fiscal dos itens de uma nota */ ' +#13+
          '  select p.cd_ref, dbo.z_cf_funObterPrecoProduto_CF(1, p.is_ref, i.is_estoque, 0) as custo ' +
          ' from dmovi i (nolock) inner join crefe p (nolock) on i.is_ref = p.is_ref  where i.is_nota = '  + is_nota;
   ds := funcSQL.getDataSetQ( cmd, fmMain.Conexao);

   ds.First();
   while ds.Eof = false do
   begin
      edCodigo.Text := ds.fieldByName('cd_ref').AsString;
      btConsultaProdutoClick(nil);

      cmd := funcoes.floatToDinheiro(ds.FieldByName('custo').AsFloat);
      if (edAjustaCusto.Value <> 0) then
         edPcNovo.Value :=  ds.FieldByName('custo').AsFloat + ds.FieldByName('custo').AsFloat * (edAjustaCusto.Value / 100)
      else
         edPcNovo.Value :=  ds.FieldByName('custo').AsFloat;

      mmResult.Lines.Add(ds.fieldByName('cd_ref').AsString +' valor antigo: ' + cmd + ' Valor novo: ' + funcoes.floatToDinheiro(edPcNovo.Value) );
      btAjustaPrecoClick(nil);
      ds.Next();
   end;
   ds.free();
end;

procedure TfmPrecoCustos.recalcularCmuNota(isNota: String);
var
  ds:TdataSet;
begin
   ds := uCF.getItensDeUmaNota(isNota);

   cbCustoMedioUnico.Checked := true;
   cbCustoFiscal.Checked := false;
   cbCustoMedio.Checked := false;

   while (ds.Eof = false) do
   begin
      edCodigo.Text := ds.fieldByName('cd_ref').asString;
      btConsultaProdutoClick(nil);
      edPcNovo.Text :=  uCF.recalcularCmuItem(ds.fieldByName('is_ref').asString);
      mmResult.Lines.Add('cod: ' +  ds.fieldByName('cd_ref').AsString +' valor: ' + edPcNovo.Text );
      edCodigo.SetFocus();
      btAjustaPrecoClick(nil);
      ds.Next();
   end;
   mmResult.Lines.Add('OK!');
end;


procedure TfmPrecoCustos.efetuaAjustDeNota(TipoAjuste: String);
var
  cmd:String;
begin
   cmd := '';
   cmd := uCF.getIsNota();
   if cmd <> '' then
   begin
      if (TipoAjuste = '1') then
         custosPorNota(cmd)
      else
         recalcularCmuNota(cmd);
   end;
end;


procedure TfmPrecoCustos.btRecalculaCMUItensNotaClick(Sender: TObject);
begin
// recalcular o CMU dos itens de uma nota.
   efetuaAjustDeNota('2');
end;

procedure TfmPrecoCustos.FormCreate(Sender: TObject);
begin
   fmMain.getParametrosForm(fmPrecoCustos);
   uCF.getListaLojas(cbLoja, true , false, '');

   UO_CD := fmMain.getParamBD('uoCd','');
   CD_PES_EMP :=  fmMain.getParamBD('comum.codEmpresa','');
end;

procedure TfmPrecoCustos.FlatButton1Click(Sender: TObject);
begin
   efetuaAjustDeNota('1');
end;

end.
