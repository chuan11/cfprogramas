unit uAjustaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcoes, funcsql,
  Dialogs, StdCtrls, adLabelComboBox, TFlatButtonUnit, ExtCtrls, adodb, db,
  adLabelEdit, adLabelNumericEdit, ComCtrls, fCtrls, Buttons, Grids,
  DBGrids, SoftDBGrid, Menus, uGetNotas, funcDatas;

type
  TfmAjustaNota = class(TForm)
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    edEmitDest: TadLabelEdit;
    edCFO: TadLabelEdit;
    dtEmiss: TfsDateTimePicker;
    edVlDEspExtra: TadLabelNumericEdit;
    btEmisDest: TFlatButton;
    btOk: TfsBitBtn;
    btCancela: TfsBitBtn;
    tbICM: TADOTable;
    dsICM: TDataSource;
    edSerie: TadLabelEdit;
    edNumero: TadLabelEdit;
    lbSerie: TLabel;
    lbNum: TLabel;
    Label1: TLabel;
    lbIsEstoque: TLabel;
    RadioGroup1: TRadioGroup;
    gdICMS: TSoftDBGrid;
    cbOperIntegrada: TadLabelComboBox;
    cbCancelada: TfsCheckBox;
    edObservacao: TadLabelEdit;
    Label3: TLabel;
    lbTipo: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    lbIsNota: TadLabelEdit;
    btDadosNFE: TfsBitBtn;
    RadioGroup2: TRadioGroup;
    SoftDBGrid1: TSoftDBGrid;
    edCodNFE: TadLabelEdit;
    qrXML: TADOQuery;
    dsXML: TDataSource;
    pnXML: TPanel;
    gridXML: TSoftDBGrid;
    GroupBox1: TGroupBox;
    btIncluiXML: TfsBitBtn;
    lbCodPes: TLabel;
    Label2: TLabel;
    lbCriador: TLabel;
    btDeleteXML: TfsBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure btEmisDestClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure pesquisaNota(is_nota:String);
    procedure carregaDadosICMS(is_nota:String);
    procedure btCancelaClick(Sender: TObject);
    procedure ajustaDadosICM();
    procedure FormCreate(Sender: TObject);
    procedure tbICMBeforePost(DataSet: TDataSet);
    procedure gdICMSColExit(Sender: TObject);
    procedure btDadosNFEClick(Sender: TObject);
    procedure btIncluiXMLClick(Sender: TObject);
    procedure btDeleteXMLClick(Sender: TObject);
    function  isGrupoprivilegiado():boolean;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaNota: TfmAjustaNota;
  IS_GRUPO_PERMITIDO:boolean;
implementation

uses uMain, uListaFornecedores, uCF;
{$R *.dfm}

procedure TfmAjustaNota.tbICMBeforePost(DataSet: TDataSet);
begin
   tbICM.FieldByName('isCriado').AsString := '1';
end;

procedure TfmAjustaNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmAjustaNota := nil;
   action := cafree;
end;

procedure TfmAjustaNota.pesquisaNota(is_nota:String);
var
  ds:TADOQuery;
  sqopf, cmd:String;
  i:integer;
begin
     ds := TADOQuery.create(nil);

     ds:= uCF.getDadosNota(is_nota,'','','');

     lbIsNota.text := ds.fieldByname('is_nota').asString;
     edSerie.Text := ds.fieldByname('serie').asString;
     edNumero.Text := ds.fieldByname('num').asString;
     lbSerie.Caption := edSerie.Text;
     lbNum.Caption := edNumero.Text;
     lbCodPes.caption := ds.fieldByname('cd_pes').asString;
     edEmitDest.Text := ds.fieldByname('Emissor/Destino').asString;
     edCFO.text := ds.fieldByname('cd_cfo').asString;
     edVlDEspExtra.Value := ds.fieldByname('VL_DSPEXTRA').AsFloat;
     dtEmiss.Date := ds.fieldByname('dt_emis').AsDateTime;
     lbIsEstoque.caption := ds.fieldByname('is_estoque').AsString;
     cbCancelada.Checked := ( ds.fieldByname('st_nf').AsString = 'C');
     edObservacao.Text := ds.fieldByname('observacao').AsString;
     lbTipo.Caption := ds.fieldByname('Tipo').AsString;
     lbLoja.Caption := ds.fieldByname('Loja').AsString;
     lbCriador.caption := ds.fieldByname('nm_usu').AsString;


     if (ds.fieldByname('codTransacao').AsInteger = 2) then
        btEmisDest.Enabled := false;

     if (ds.fieldByname('cd_modnf').AsString = '6') then
     begin
        edCodNFE.Text   := ds.fieldByName('codigo_nfe').AsString;
        edCodNFE.enabled := true;
        btDadosNFE.enabled := true;
     end
     else
     begin
        edCodNFE.Text   := '';
        edCodNFE.enabled := false;
        btDadosNFE.enabled := false;
     end;

     carregaDadosICMS(is_nota);

// mostrar o tipo de operação integrada
     for i:=0 to cbOperIntegrada.Items.Count -1 do
     begin
        cmd := ds.fieldByName('sq_opf').AsString;
        sqopf := trim(copy(cbOperIntegrada.Items[i], 101,10));
        if ( cmd = sqopf) then
        begin
           cbOperIntegrada.ItemIndex := i;
           break;
        end;
     end;
     ds.Destroy();
     lbIsNota.text := is_nota;
     Panel1.Visible := true;
end;


procedure TfmAjustaNota.btEmisDestClick(Sender: TObject);
var
  codigo:String;
  ds:TDataSet;
begin
   if ( isGrupoprivilegiado()) = true then
   begin
      if (lbTipo.Caption = 'Entrada') then
         codigo:= uCF.getFmDadosPessoa('Fornecedor')
      else
         codigo:= uCF.getFmDadosPessoa('Cliente');

      if (codigo <> '') then
      begin
          ds := TADODataSet.Create(nil);
          ds := uCF.getDadosFornecedor(codigo,'');
          lbCodPes.caption := ds.FieldByName('codigo').asString;
          edEmitDest.text := ds.FieldByName('nome').asString;
          ds.Destroy();
      end;
   end;
end;

procedure TfmAjustaNota.carregaDadosICMS(is_nota:String);
var
  cmd:String;
begin
   funcSQL.OpenTempTable( tbICM, 'is_nota int, nr_item int, [%ICMS] money, Base money, [valor ICMS] money, isCriado varchar(1), seq int identity (1,1)', fmMain.Conexao);
   tbICM.Close();
   cmd := 'insert ' + tbICM.TableName + ' select is_nota, nr_item, pc_icm, vl_base, vl_icm, 0 from dnotc where is_nota = ' + is_nota;
   funcsql.execSQL(cmd, fmMain.Conexao);
   tbICM.open();
   dsICM.DataSet := tbICM;
   gdICMS.Columns[tbICM.fieldByName('%ICMS').index ].Width := 70;
   gdICMS.Columns[tbICM.fieldByName('Base').index ].Width := 70;
   gdICMS.Columns[tbICM.fieldByName('Valor ICMS').index ].Width := 70;


   fmMain.showGridCol( gdICMS, tbICM, 'nr_item',false);
   fmMain.showGridCol( gdICMS, tbICM, 'is_nota',false);
   fmMain.showGridCol( gdICMS, tbICM, 'isCriado',false);
   fmMain.showGridCol( gdICMS, tbICM, 'Seq',false);
end;

procedure TfmAjustaNota.btCancelaClick(Sender: TObject);
begin
   funcoes.limparCamposform( fmAjustaNota );
   panel1.Visible := false;
   pnXML.Visible:=false;
   qrXML.Close();
end;

procedure TfmAjustaNota.FlatButton1Click(Sender: TObject);
var
   cmd:String;
begin
   btCancelaClick(nil);
   cmd := '';
   cmd := uGetNotas.getIsNota();

   if cmd <> '' then
      pesquisaNota(cmd)
   else
      panel1.Visible := false;
end;


procedure TfmAjustaNota.ajustaDadosICM();
var
   cmd:String;
begin
// exclui os registros antigos
  cmd := 'delete from dnotc where is_nota = ' + lbIsNota.text;
  funcSQL.execSQL(cmd, fmMain.Conexao);

// insere os novos
  tbICM.First();
  while (tbICM.Eof=false) do
  begin
     cmd := ' insert dnotc (is_estoque, is_nota, nr_item, pc_icm, tp_entSai, tp_ICM, vl_base, vl_basfre, vl_fre, vl_icm, vl_ipi) values (' +
      lbIsEstoque.Caption + ', ' +
       lbIsNota.text + ', ' +
       tbICM.FieldByName('seq').AsString + ', ' +
       tbICM.FieldByName('%ICMS').AsString + ', ' +
       quotedStr(copy(lbTipo.Caption, 01, 01)) + ', 2, ' +
       funcoes.ValorSql(tbICM.FieldByName('base').AsString) + ', 0, 0, ' +
       funcoes.ValorSql(tbICM.FieldByName('valor ICMS').AsString) + ', 0 )';
       funcSQL.execSQL(cmd, fmMain.Conexao);
       tbICM.Next();
  end;
end;


procedure TfmAjustaNota.FormCreate(Sender: TObject);
begin
  cbOperIntegrada.Items := funcsql.getOperIntegradasFiscais(fmMain.Conexao);
  IS_GRUPO_PERMITIDO := fmMain.isGrupoPermitido( fmMain.Ajustedenotas1.Tag );
end;

procedure TfmAjustaNota.btOkClick(Sender: TObject);
var
   strStNota, cmd:String;
   isAltera:boolean;
begin
   isAltera := true;

   if (lbSerie.Caption <> edSerie.Text) or (lbNum.Caption <> edNumero.Text) then
   begin
      cmd := ' Select is_nota from dnota (nolock) where sr_docf =' + Quotedstr(edSerie.Text) + ' and nr_docf = ' + edNumero.Text +
             ' and is_estoque = ' + lbIsEstoque.Caption +' and cd_pes= ' + lbCodPes.Caption;
      if funcSQL.openSQL(cmd, 'is_nota', fmMain.Conexao) <> '' then
      begin
          msgTela('', 'Já existe essa nota/série na loja. ', MB_ok + MB_ICONERROR);
          isAltera := false;
      end;
   end;

   if (edCodNFE.text <> '') then
      if (isGrupoprivilegiado() = true) then
         if (msgTela('', 'Não Altere uma nota fiscal eletrônica a menos que você saiba realmente o que está fazendo...'+#13+'Altera mesmo ?', MB_YESNO + MB_ICONWARNING) = mrNo) then
            isAltera := false;

   if (isAltera = true) then
      if msgTela('', 'Deseja mesmo alterar os dados dessa nota?', MB_YESNO + MB_ICONQUESTION) = mrYes then
      begin
         if  cbCancelada.Checked = true then
            strStNota := 'C'
         else
            strStNota := '';

         cmd := ' Update dnota set ' +
                ' nr_docf =' + trim(edNumero.Text) + ' , ' +
                ' sr_docf =' + quotedstr( trim(edSerie.Text)) + ' , ' +
                ' cd_cfo = ' + edCFO.Text + ' , ';

         if (btEmisDest.Enabled = true) then
            cmd :=   cmd + ' cd_pes = ' + lbCodPes.Caption + ' , ';

         cmd :=   cmd + ' VL_DSPEXTRA = '  +  funcoes.ValorSql( floatToStr(edVlDEspExtra.value) ) + ' , ' +
                ' dt_emis = ' + funcoes.DateTimeToSqlDateTime(dtEmiss.Date,'') +', '+
                ' st_nf = ' + quotedStr(strStNota) +', '+
                ' observacao = ' + quotedStr(edObservacao.Text) +
                ' where is_nota in ( ' + lbIsNota.Text + ' )';
         funcsql.execSQL(cmd, fmMain.Conexao);

         cmd := 'update dmovi set st_mov = ' + quotedStr(strStNota) + ' where is_nota = ' + lbIsNota.Text;
         funcsql.execSQL(cmd, fmMain.Conexao);

         cmd := 'update toper set sq_opf = ' + trim(copy(cbOperIntegrada.Items[cbOperIntegrada.itemIndex],101,10)) +
                ' where is_oper in (select is_oper from dnota (nolock) where is_nota = ' + lbIsNota.Text + ')';
         funcsql.execSQL(cmd, fmMain.Conexao);

         ajustaDadosICM();
         msgTela('','A nota foi Alterada...', MB_ICONEXCLAMATION + MB_OK );
      end;
end;

procedure TfmAjustaNota.gdICMSColExit(Sender: TObject);
begin
   if ( tbICM.fieldByName('base').Index = gdICMS.SelectedIndex) and ( tbICM.fieldByName('%icms').AsString <> '' ) then
   begin
      tbICM.edit();
      tbICM.fieldByName('valor ICMS').AsFloat := tbICM.fieldByName('base').asFloat * (tbICM.fieldByName('%icms').asFloat / 100);
      tbICM.post();
   end
end;

procedure TfmAjustaNota.btDadosNFEClick(Sender: TObject);
var
  codNfe, cmd:String;
begin
   if isGrupoprivilegiado() then
   begin
      if ( edCodNFE.Text = '') then
      begin
         codNfe := funcsql.getContadorWell(fmMain.Conexao, 'CODIGO_NfE');
         edCodNFE.Text := codNfe
      end
      else
         codNfe := edCodNFE.Text;

      if ( funcSql.openSQL('Select CODIGO_NFE from nf_eletronica where codigo_nfe = ' + codNFE, 'CODIGO_NFE', fmMain.Conexao) = '' ) then
      begin
         cmd := 'insert nf_eletronica values(' + codNfe + ' , -1, ''-'', '''', '''', '+ funcDatas.dateToSqlDate(dtEmiss.Date) + ', null, null) ';
         funcSQL.execSQL(cmd, fmMain.Conexao);
      end;

      qrXML.SQL.Clear();
      funcSQL.getQuery2( fmMain.Conexao, qrXML,  'select codigo_nfe, nrLote_nfe, xml_nfe, chave_acesso_nfe, protocolo_autorizacao_nfe, dt_autorizacao_nfe from nf_eletronica where codigo_nfe = ' + codNFE);
      gridXML.Columns[qrXML.FieldByName('xml_nfe').Index ].Width := 30;
      btDadosNFE.Enabled := false;
      pnXML.Visible := true;
   end;
end;

procedure TfmAjustaNota.btIncluiXMLClick(Sender: TObject);
var
  cmd:String;
begin
   cmd :=  'delete from nf_eletronica where codigo_nfe= ' + edCodNFE.Text;
   funcSQL.execSQL(cmd, fmMain.Conexao);

   cmd := ' insert nf_eletronica ( codigo_nfe, NRLOTE_NFE, XML_NFE, CHAVE_ACESSO_NFE, ' +
                                 'PROTOCOLO_AUTORIZACAO_NFE, DT_AUTORIZACAO_NFE) ' +
                                 'values (' +
          edCodNFE.Text +', -1, ''-'', '+
          quotedStr(qrXML.fieldByName('chave_acesso_nfe').AsString) +', ' +
          quotedStr(qrXML.fieldByName('protocolo_autorizacao_nfe').AsString) +', ' +
          funcDatas.StrToSqlDate(qrXML.fieldByName('dt_autorizacao_nfe').AsString) + ' )';
   funcSQL.execSQL(cmd, fmMain.Conexao);

   pnXml.Visible := false;
   edCodNFE.Enabled := true;
end;

procedure TfmAjustaNota.btDeleteXMLClick(Sender: TObject);
begin
   if (qrXML.IsEmpty = false ) then
      if ( msgTela('','Deseja realmente remover o registro do XML da NF-e ?', MB_YESNO + MB_ICONQUESTION) = mrYes) then
      begin
         funcSQl.execSQL('delete from nf_eletronica where codigo_nfe = ' + qrXML.fieldByName('codigo_nfe').AsString, fmMain.Conexao  );
         funcSQl.execSQL('update dnota set codigo_nfe = null where is_nota = ' + lbIsNota.text , fmMain.Conexao  );
         pnXml.Visible := false;
         edCodNFE.Enabled := true;
      end;
end;

function TfmAjustaNota.isGrupoprivilegiado: boolean;
begin
    if (IS_GRUPO_PERMITIDO = false) then
       msgTela('', 'Você não tem acesso a essa função', MB_OK + MB_ICONERROR);
    result := IS_GRUPO_PERMITIDO;
end;

end.

