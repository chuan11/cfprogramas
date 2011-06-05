unit Uprecoswell;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adLabelEdit, adLabelNumericEdit, StdCtrls, TFlatEditUnit,
  DBCtrls, Mask, adLabelDBEdit, DB, ADODB, ComCtrls,
  adLabelDBDateTimePicker, Grids, DBGrids,Clipbrd, adLabelDBComboBox,
  adLabelComboBox, TFlatGaugeUnit, Menus, TFlatButtonUnit, funcDatas,
  CheckLst, adLabelCheckListBox,funcoes, funcSql, fCtrls, ExtCtrls,
  SoftDBGrid, TFlatCheckBoxUnit;

type
  TfmLancaPrecos = class(TForm)
    edCodigo: TadLabelEdit;
    edDesc: TadLabelEdit;
    edPcNovo: TadLabelNumericEdit;
    MainMenu1: TMainMenu;
    Gerardeumpedido1: TMenuItem;
    Parametros1: TMenuItem;
    Panel1: TPanel;
    clbPc01: TadLabelCheckListBox;
    clbPc02: TadLabelCheckListBox;
    clbPc03: TadLabelCheckListBox;
    Gauge: TFlatGauge;
    Table: TADOTable;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    Bevel1: TBevel;
    gb01: TfsGroupBox;
    cbPc01: TadLabelComboBox;
    gb02: TfsGroupBox;
    cbPc02: TadLabelComboBox;
    edVlMrg02: TadLabelEdit;
    gb03: TfsGroupBox;
    cbpc03: TadLabelComboBox;
    edVlMrg03: TadLabelEdit;
    Reajustedeprecos1: TMenuItem;
    Button2: TButton;
    Gerarprecoapartirdeumanota1: TMenuItem;
    btNovo: TFlatButton;
    btImp: TFlatButton;
    cbLoja: TadLabelComboBox;
    btExporta: TFlatButton;
    FlatButton1: TFlatButton;
    dti: TfsDateTimePicker;
    Label1: TLabel;
    dtf: TfsDateTimePicker;
    cbDtExpPreco: TFlatCheckBox;
    function AjustaPreco(valor,percentual:string;arredondar:boolean):string;
    procedure GeraSQL(is_ref,tpPreco,UO,Valor,cd_ref:string; dataPreco:Tdate);
    procedure FormCreate(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPcNovoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure limpaCampos(sender:tobject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Gerardeumpedido1Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure btImpClick(Sender: TObject);
    procedure CarregaListaLojas(sender:tobject);
    procedure clbPc01Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AdicionarItemAoReajuste(cod, des, pcAtual, pc01, pc02, pc03, is_ref, custo: string);
    procedure LimparTabela(Sender:Tobject);
    procedure btNovoClick(Sender: TObject);
    function  getCodigoPreco():String;
    procedure gridDblClick(Sender: TObject);
    procedure Reajustedeprecos1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Gerarprecoapartirdeumanota1Click(Sender: TObject);
    function getLojasDeumPreco(Sender:Tobject; itens: TadLabelCheckListBox):String;
    procedure btExportaClick(Sender: TObject);
    procedure clbPc02Click(Sender: TObject);
    procedure clbPc03Click(Sender: TObject);
    procedure cbDtExpPrecoClick(Sender: TObject);
    procedure getPrecosDeUmaNota(isNota:String);
    procedure getDadosItens(uo, cd_ref, preco:String);
    procedure chamaLancamentoDePrecos();


  private
     is_oap: real;
     Is_alp:real;
  public
    { Public declarations }
  end;

var
  fmLancaPrecos: TfmLancaPrecos;
  IS_LANCA_PRECO:String;
  DS:TdataSet;
implementation

uses umain, uPrecoPorPedido, uReajuste, uListaItensPorNota, uCF, uGetNotas;

{$R *.dfm}


function TfmLancaPrecos.getCodigoPreco: String;
begin
   result := funcoes.SohNumeros(copy(cbPc01.Items[cbpc01.ItemIndex],50,08) );
end;


procedure TfmLancaPrecos.LimparTabela(Sender: Tobject);
begin
   while table.IsEmpty = false do
      table.delete;
   gb01.Enabled := true;
   gb02.Enabled := true;
   gb03.Enabled := true;
end;


procedure TfmLancaPrecos.limpaCampos(sender: tobject);
begin
   edCodigo.text:= '';
   edDesc.text:= '';
   edPcNovo.text:= '';
   clipboard.AsText :='';
   edCodigo.SetFocus;
end;

procedure TfmLancaPrecos.carregaListaLojas(sender:tobject);
begin
   uCF.carregaListarUosPorPreco( clbPc01, 'Pc01');
   uCF.carregaListarUosPorPreco( clbPc02, 'Pc02');
   uCF.carregaListarUosPorPreco( clbPc03, 'Pc03');
end;

procedure TfmLancaPrecos.FormCreate(Sender: TObject);
var
  pc01,pc02,pc03:String;
begin
   pc01 := fmMain.GetParamBD('fmPrecos.DescPc01','');
   pc02 := fmMain.GetParamBD('fmPrecos.DescPc02','');
   pc03 := fmMain.GetParamBD('fmPrecos.DescPc03','');
   IS_LANCA_PRECO := fmMain.GetParamBD('fmPrecos.gravarPrecos','');

   begin
      if (fmMain.getGrupoLogado() = '13')  then
         Button2.Visible := true;

      table.Close;

      CarregaListaLojas(sender);

      clbPc01.LabelDefs.Caption := 'Lojas '+ pc01;
      clbPc02.LabelDefs.Caption := 'Lojas '+ pc02;
      clbPc03.LabelDefs.Caption := 'Lojas '+ pc03;

      edPcNovo.LabelDefs.caption := '&'+ pc01;
      edVlMrg02.LabelDefs.caption := 'Perc ';
      edVlMrg03.LabelDefs.caption := 'Perc ';


      gb01.Caption := 'Pco 01 - '+ pc01;
      gb02.Caption := 'Pco 02 - '+ pc02;
      gb03.Caption := 'Pco 03 - '+ pc03;


      cbPc01.Items :=  funcsql.getListaPrecos(fmMain.Conexao,false,false,false, fmMain.getGrupoLogado());
      cbPc02.Items := cbpc01.Items;
      cbPc03.Items := cbpc01.Items;

      fmMain.getListaLojas(cbLoja, false, false, '');


      fmMain.getParametrosForm(fmLancaPrecos);

      dti.Date := (now)+1;
      dtf.Date := dti.Date +1;
  end;
end;


procedure TfmLancaPrecos.getDadosItens(uo, cd_ref, preco:String);
begin
   DS:= uCF.getDadosProd( uo, cd_ref, preco);
   if  (ds.IsEmpty = false)   then
   begin
      edDesc.text := DS.fieldByName('Descricao').asString;
      edPcNovo.setfocus;
   end
   else
      limpaCampos(nil);
end;

procedure TfmLancaPrecos.edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      getDadosItens( funcoes.getCodUO(cbLoja), edCodigo.Text, fmMain.getCodPreco(cbPc01));
end;

function TfmLancaPrecos.AjustaPreco(valor,percentual:string;arredondar:boolean):string;
var
   aux1,aux2,aux3:real;
begin
   while pos('.',valor) > 0 do
      delete(valor,pos('.',valor),01);

   aux1 := Strtofloat(valor);
   aux2 := Strtofloat(percentual);
   aux3:=  (aux1 * aux2);
   valor := FloatTostr( aux3  );
   if arredondar = true then
      AjustaPreco :=  FloatToStrF( funcoes.ArredondarPreco(aux3) ,ffFixed,18,02)
   else
      AjustaPreco :=  FloatToStrF( aux3 ,ffFixed,18,02);
end;

procedure tfmLancaPrecos.GeraSQL(is_ref,tpPreco, UO, Valor,cd_ref:string; dataPreco:Tdate);
var
  cmd:string;
begin
    cmd := '';
    cmd := ' Exec dbo.Z_CF_LancaPcoProduto '                  +
                                           '@IS_REF= ' + is_ref  +', '+
                                           '@tp_Preco= '+    tpPreco +', '+
                                           '@Dt_Pco= '+ funcDatas.dateToSqlDate(dataPreco)  +', '+
                                           '@is_uo=' + uo  +', '+
                                           '@pco='+ funcoes.ValorSql(valor)  +', '+
                                           '@cd_usu='+ fmMain.getCdpesLogado()  +', '+
                                           '@cd_ref='+ QuotedStr(cd_ref)+', '+
                                           '@is_oap='+ FloatToStr(is_oap)+', '+
                                           '@is_alp='+ FloatToStr(is_alp);

// testa se ira lancar o preco se for nao gera todos os comandos mas nao executa no banco
    funcoes.gravaLog(CMD);
   if ( IS_LANCA_PRECO = 'S') then
      funcsql.execSQL(cmd, fmMain.Conexao);
end;


procedure TfmLancaPrecos.FlatButton1Click(Sender: TObject);
var
   erro:String;
begin
   erro:='';
   if (funcoes.getCodPc(cbPc01) = '') or (funcoes.getCodPc(cbPc02) = '') or (funcoes.getCodPc(cbPc03) = '') then
      erro := erro + '- Escolha os tipos de preço para atualizar.' +#13;

   if (table.IsEmpty = true) then
      erro := erro + '- Nenhum preço para lancar.' +#13;

   if ( dtf.date < dti.Date) then
      erro := erro + MSG_DATA1_MENORQ_DATA2;

   if (erro = '') then
   begin
      if (application.MessageBox(pchar( #13 + 'Deseja efetivar realmente esse preços ?? '+#13), '',mb_yesNo ) = mryes) then
         chamaLancamentoDePrecos();
   end
   else
      funcoes.msgTela('', MSG_ERRO_TIT + erro, MB_ICONERROR + mb_ok);
end;



procedure TfmLancaPrecos.chamaLancamentoDePrecos();
var
   j:integer;
   pcNormal, PcCe, PcPI, PcMa:string;
begin
   try
      pcCe := funcoes.getCodUo(cbpc01);
      pcPi := funcoes.getCodUo(cbpc02);
      pcMa := funcoes.getCodUo(cbpc03);


      gauge.MaxValue := table.RecordCount;
      gauge.Visible := true;
      screen.Cursor := crhourglass;

      is_alp := StrToFloat ( funcsql.getValorWell('O',' Select (contador)  as is_alp from tcont where ds_campo = ' + quotedstr('IS_ALP' ),'is_alp', fmMain.Conexao));
      is_oap := StrToFloat ( funcsql.getValorWell('O',' Select (contador)  as is_oap from tcont where ds_campo = ' + quotedstr('IS_OAP' ),'is_oap', fmMain.Conexao));
      table.First;

      while (table.Eof = false) do
      begin
         gauge.Progress := gauge.Progress + 1;

         for j := 0 to clbPc01.Items.Count -1 do
         begin
            clbPc01.ItemIndex := j;
            if (clbPc01.Checked[clbPc01.ItemIndex] = true) then
            begin
               is_alp := is_alp +1;
               is_oap := is_oap +1;
               geraSQL( table.fieldByName('is_ref').AsString, pcCe, funcoes.getCodUO(clbPc01), table.fieldByName('PRECO 01').AsString, table.fieldByName('CODIGO').AsString, dti.date);

               if (cbDtExpPreco.Checked = true) then
               begin
                // pega o preco atual
                  pcNormal := uCF.getPcProd( funcoes.getCodUO(clbPc01), table.fieldByName('CODIGO').AsString, fmMain.getCodPreco(cbPc01) );
                  is_alp := is_alp +1;
                  is_oap := is_oap +1;
                  geraSQL( table.fieldByName('is_ref').AsString, pcCe, funcoes.getCodUO(clbPc01), pcNormal, table.fieldByName('CODIGO').AsString, dtf.date);
               end;
            end;
         end;

         for j := 0 to clbPc02.Items.Count -1 do
         begin
            clbPc02.ItemIndex := j;
            if (clbPc02.Checked[clbPc02.ItemIndex] = true) then
            begin
               is_alp := is_alp +1;
               is_oap := is_oap +1;
               geraSQL( table.fieldByName('is_ref').AsString, pcPi, funcoes.getCodUO(clbPc02), table.fieldByName('PRECO 02').AsString , table.fieldByName('CODIGO').AsString, dti.date);

               if (cbDtExpPreco.Checked = true) then
               begin
                 // pega o preco atual
                  pcNormal := uCF.getPcProd( funcoes.getCodUO(clbPc02), table.fieldByName('CODIGO').AsString, fmMain.getCodPreco(cbPc02) );
                  is_alp := is_alp +1;
                  is_oap := is_oap +1;
                  geraSQL( table.fieldByName('is_ref').AsString, pcPi, funcoes.getCodUO(clbPc02), pcNormal, table.fieldByName('CODIGO').AsString, dtf.date);
               end;
            end;
         end;

         for j := 0 to clbPc03.Items.Count -1 do
         begin
            clbPc03.ItemIndex := j;
            if (clbPc03.Checked[clbPc03.ItemIndex] = true) then
            begin
               is_alp := is_alp +1;
               is_oap := is_oap +1;
               geraSQL( table.fieldByName('is_ref').AsString, pcMa, funcoes.getCodUO(clbPc03), table.fieldByName('PRECO 03').AsString, table.fieldByName('CODIGO').AsString, dti.date );

               if (cbDtExpPreco.Checked = true) then
               begin
                  // pega o preco atual
                  pcNormal := uCF.getPcProd( funcoes.getCodUO(clbPc03), table.fieldByName('CODIGO').AsString, fmMain.getCodPreco(cbPc03) );
                  is_alp := is_alp +1;
                  is_oap := is_oap +1;
                  geraSQL( table.fieldByName('is_ref').AsString, pcCe, funcoes.getCodUO(clbPc03), pcNormal, table.fieldByName('CODIGO').AsString, dtf.date);
               end;
            end;
         end;

         gauge.Progress := gauge.Progress + 1;
         table.Next;
       end;
       funcsql.getValorWell('E',' Update tcont set contador = ' + floatTostr(is_alp) + ' where ds_campo = ' + quotedstr('is_alp'),'',fmMain.Conexao);
       funcsql.getValorWell('E',' Update tcont set contador = ' + floatTostr(is_alp) + ' where ds_campo = ' + quotedstr('is_oap'),'',fmMain.Conexao);
       limparTabela(nil);
       gauge.Visible := false;
       screen.Cursor :=crdefault;
   except
      on e:Exception do
      begin
         msgTela('', ' Erro de chave duplicada, vou avançar os contadores, tente novamente !', mb_iconwarning + Mb_Ok);
         funcsql.getValorWell('E',' Update tcont set contador = ( Select max(Is_alp) from dsalp  ) where ds_campo = ' + quotedstr('is_alp'),'',fmMain.Conexao);
         funcsql.getValorWell('E',' Update tcont set contador = ( Select max(Is_oap) from dsoap  ) where ds_campo = ' + quotedstr('is_oap'),'',fmMain.Conexao);
      end;
   end;


end;


procedure TfmLancaPrecos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   limpaCampos(nil);
   funcoes.salvaCampos(fmLancaPrecos);
   fmLancaPrecos := NIL;
   Action := CaFree;
end;

procedure TfmLancaPrecos.Gerardeumpedido1Click(Sender: TObject);
begin
   Application.CreateForm(TfmPcporPedido, fmPcporPedido);
   fmPcporPedido.Show;
end;

procedure TfmLancaPrecos.btImpClick(Sender: TObject);
var
   itens:tstringlist;
begin
   itens := tstringlist.Create;
   itens.add(DateToStr( dti.Date) );
   itens.add(fmMain.StatusBar1.Panels[1].Text);
   itens.add(Copy(cbLoja.Items[cbLoja.ItemIndex],01,30) ) ;
   itens.add(getLojasDeumPreco(nil, clbPc01));
   itens.add(getLojasDeumPreco(nil, clbPc02));
   itens.add(getLojasDeumPreco(nil, clbPc03));

   fmMain.impressaoRave(Table, 'rpPrecosAReajustar', itens);
end;


procedure TfmLancaPrecos.clbPc01Click(Sender: TObject);
begin
   fmMain.setParamBD( 'fmPrecos.UosPc01', funcoes.getCodUO(clbPc01),  BoolToStr(clbPc01.Checked[clbPc01.ItemIndex]) );
end;

procedure TfmLancaPrecos.clbPc02Click(Sender: TObject);
begin
   fmMain.setParamBD( 'fmPrecos.UosPc02', funcoes.getCodUO(clbPc02),  BoolToStr(clbPc02.Checked[clbPc02.ItemIndex]) );
end;

procedure TfmLancaPrecos.clbPc03Click(Sender: TObject);
begin
   fmMain.setParamBD( 'fmPrecos.UosPc03', funcoes.getCodUO(clbPc03),  BoolToStr(clbPc03.Checked[clbPc03.ItemIndex]) );
end;


procedure TfmLancaPrecos.FormShow(Sender: TObject);
var
   nmTabela:string;
   i:smallint;
begin
   if table.TableName  = '' then
   begin
      nmTabela := '#lp'+funcoes.SohNumeros( TimeToStr(now));
      funcSQl.GetValorWell( 'e', 'Create table '+ nmTabela +'( CODIGO varchar(08), DESCRICAO varchar(50), [PRECO ATUAL] money, [PRECO 01] money, [PRECO 02] money, [PRECO 03] money, IS_REF int, CUSTO money) ','@@error', fmMain.Conexao );
      Table.TableName := nmTabela;
      table.Open;
      grid.Columns[0].Width := 70;
      grid.Columns[1].Width := 200;
      grid.Columns[2].Width := 100;
      for i:= 3 to grid.Columns.Count -1 do
         grid.Columns[i].Width := 80;

      // esconder a coluna de precos
      grid.Columns[grid.Columns.Count -2 ].Visible := false;

      for i:=0 to grid.Columns.Count -1 do
        grid.Columns[i].Title.Font.Style := [fsBold];
   end;
end;

procedure TfmLancaPrecos.AdicionarItemAoReajuste(cod, des, pcAtual, pc01, pc02, pc03, is_ref, custo: string);
var
   erro:boolean;
begin
   erro := false;
   grid.Visible := false;
   table.First;

   while (table.Eof = false ) and  (erro = false ) do
   begin
      if table.fieldByName('is_ref').asString = is_ref then
        erro := true;
      table.Next;
   end;

   table.first;
   grid.Visible := true;
   if Erro = false then
      Table.AppendRecord([cod, des, pcAtual, pc01, pc02, pc03, is_ref, custo])
   else
      msgTela('', ' O item :  ' +Cod + ' '+ des +#13+ ' já foi adicionado !', mb_ok + mb_iconError);
end;


procedure TfmLancaPrecos.btNovoClick(Sender: TObject);
begin
   LimparTabela(Sender);
end;

procedure TfmLancaPrecos.edPcNovoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
    if (key = vk_return)  then
    begin
       AdicionarItemAoReajuste(
                           edCodigo.text,
                           edDesc.text,
                           ds.fieldByname('Preco').asString,
                           AjustaPreco( edPcNovo.text , '1,00',false ),
                           AjustaPreco( edPcNovo.text , '1,'+edVlMrg02.TEXT, false ),
                           AjustaPreco( edPcNovo.text , '1,'+edVlMrg03.TEXT, false ),
                           DS.FieldByName('is_ref').AsString,
                           ''
                         );
       limpaCampos(sender);
    end;

    if table.IsEmpty = false then
    begin
       gb01.Enabled := false;
       gb02.Enabled := false;
       gb03.Enabled := false;
    end;
end;

procedure TfmLancaPrecos.gridDblClick(Sender: TObject);
begin
   table.Delete;
end;

procedure TfmLancaPrecos.Reajustedeprecos1Click(Sender: TObject);
begin
   if (fmPcporPedido = nil) then
   begin
      Application.CreateForm(TfmReajuste, fmReajuste);
      fmReajuste.Show;
   end;
end;

procedure TfmLancaPrecos.Button2Click(Sender: TObject);
var
  Query:TADoQuery;
  arq:String;
begin
   grid.Visible := false;
   arq := funcoes.DialogAbrArq('*.sql','c:\');

   query := TADOQuery.Create(nil);
   Query.Connection := fmMain.Conexao;
   Query.CommandTimeout := 0;

   query.SQL.clear;
   query.SQL.LoadFromFile(arq);
   query.Open;
   query.First;

   while query.Eof = false do
   begin
      tABLE.AppendRecord([
                            query.FieldByName('codigo').AsString,
                            query.FieldByName('DESCRICAO').AsString,
                            '0',
                            FloatToStr(query.FieldByName('UND').AsFloat) ,
                            FloatToStr(query.FieldByName('UND').AsFloat) ,
                            FloatToStr(query.FieldByName('UND').AsFloat) ,
                            query.FieldByName('is_ref').AsString,
                            '0'
      ]);
      edCodigo.Text :=query.FieldByName('is_ref').AsString;
      edPcNovo.Refresh;
      query.Next;
   end;
   grid.Visible := true
end;


function TfmLancaPrecos.getLojasDeumPreco(Sender: Tobject;itens: TadLabelCheckListBox): String;
var
  i:integer;
  aux:String;
begin
   for i := 0 to itens.Items.Count - 1 do
      if itens.Checked[i] = true then
         aux := Aux + trim(copy(itens.Items[i],01,20)) + ' , ';
   result := aux;
end;

procedure TfmLancaPrecos.btExportaClick(Sender: TObject);
begin
   Clipboard.AsText := '';

   Clipboard.AsText := 'CODIGO  DESCRICAO                                  PC ANTIGO    PC NOVO' + #13;
   Table.First();
   while (Table.Eof = false) do
   begin
      Clipboard.AsText := Clipboard.AsText +
      table.fieldByname('codigo').AsString + ' ' +
      copy(table.fieldByname('Descricao').AsString,01,40) + ' ' +
      funcoes.preencheCampo(12,' ','D', floattostrf( table.fieldByname('preco atual').asFloat ,ffNumber,18,2) ) + ' ' +
      funcoes.preencheCampo(12,' ','D', floattostrf( table.fieldByname('preco 01').asFloat ,ffNumber,18,2)  ) +#13;
      Table.Next();
   end;
   Table.First();
end;

procedure TfmLancaPrecos.cbDtExpPrecoClick(Sender: TObject);
begin
   dtf.Enabled := cbDtExpPreco.Checked;
end;


procedure TfmLancaPrecos.getPrecosDeUmaNota(isNota:String);
var
   preco:String;
   ds:TdataSet;
begin
   ds:= uCF.getItensDeUmaNota(isNota);
   if ds.IsEmpty = false then
   begin
      ds.First;
      while ds.Eof = false do
      begin
         preco:= ucf.getPcProd( funcoes.getCodUO(cbLoja), ds.fieldByName('cd_ref').asString, funcoes.getCodPc(cbPc01) );
         adicionarItemAoReajuste(ds.fieldByName('cd_ref').asString,
                                 ds.fieldByName('ds_ref').asString,
                                 ajustaPreco( preco, '1,00', false ),
                                 ajustaPreco( preco, '1,00', false ),
                                 ajustaPreco( preco, '1,'+edVlMrg02.text, false ),
                                 ajustaPreco( preco, '1,'+edVlMrg03.text, false ),
                                 ds.fieldByName('is_ref').asString,
                                 '0');
         ds.next();
      end;
      ds.free();
   end
end;

procedure TfmLancaPrecos.Gerarprecoapartirdeumanota1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := uGetNotas.getIsNota();
   if (cmd <> '') then
      getPrecosDeUmaNota(cmd);
end;


end.



