unit uAvarias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, ExtCtrls, fCtrls, TFlatPanelUnit,
  TFlatButtonUnit, Grids, DBGrids, SoftDBGrid, mxExport, DB, ADODB,
  ImgList, Menus, adLabelNumericEdit;

type
  TfmCadAvarias = class(TForm)
    pnDados: TPanel;
    Bevel1: TBevel;
    lbIs_ref: TLabel;
    lbRef: TLabel;
    edCodigo: TadLabelEdit;
    EdDesc: TadLabelEdit;
    edQuant: TadLabelEdit;
    edObs: TadLabelEdit;
    pnTitulo: TFlatPanel;
    Label1: TLabel;
    lbNumAvaria: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    Label2: TLabel;
    lbDtAvaria: TLabel;
    Label5: TLabel;
    lbStatus: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    lbdtAprov: TLabel;
    lbtipo: TLabel;
    Label7: TLabel;
    lbuo: TLabel;
    Label8: TLabel;
    lbTotal: TLabel;
    mmObs: TfsMemo;
    Query: TADOQuery;
    menuAvarias: TMainMenu;
    Nova1: TMenuItem;
    Abrir1: TMenuItem;
    Aprovar1: TMenuItem;
    Imprimir1: TMenuItem;
    Exportar1: TMenuItem;
    QrItens: TADOQuery;
    DataSource1: TDataSource;
    pnOperacoes: TPanel;
    BitBtn3: TFlatButton;
    BitBtn5: TFlatButton;
    pnConfirma: TPanel;
    BitBtn1: TFlatButton;
    FlatButton1: TFlatButton;
    Grid: TSoftDBGrid;
    cbOrigemAvaria: TfsComboBox;
    fsLabel1: TfsLabel;
    ednResponsavel: TadLabelEdit;
    lbMNPes: TLabel;
    lbCD_pes: TLabel;
    edPcSugerido: TadLabelNumericEdit;
    edPreco: TadLabelNumericEdit;
    Relatrios1: TMenuItem;
    Imprimirrelaodeavaria1: TMenuItem;
    Vendadeprodutosavariados1: TMenuItem;
    ransferirAvaria1: TMenuItem;

    function  itemJaExiste():boolean;
    procedure AbreFmPesqLista(tag:integer);
    function  VerificaPreenchimento(Sender: TOBject): String;
    procedure CarregaItensAvarias(Sender: tobject; numero:string; loja:String);
    procedure CarregarCabecalhoAvarias(sender: Tobject; numero,loja:string);
    procedure Nova1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DesabilitaItens();
    procedure LimparCampos(sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Abrir1Click(Sender: TObject);
    procedure Aprovar1Click(Sender: TObject);
    procedure EdDescEnter(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure edQuantExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Exportar1Click(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure FormResize(Sender: TObject);
    procedure Relatrios1Click(Sender: TObject);
    procedure Imprimirrelaodeavaria1Click(Sender: TObject);
    procedure Vendadeprodutosavariados1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridTitleClick(Column: TColumn);
    procedure ransferirAvaria1Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmCadAvarias: TfmCadAvarias;
  operacao:String;
implementation
uses umain , fmAbrirAvarias, uCriaAvaria , uAprovaAvaria, verificaSenhas,  funcoes, funcsql, uRelGeral, uCF ;
{$R *.dfm}

function TfmCadAvarias.itemJaExiste():boolean;
var
  achou:boolean;
begin
   grid.visible := false;
   qrItens.First;
   achou := false;
   while (achou = false) and( qrItens.Eof = false ) do
   begin
      if qrItens.FieldByName('is_ref').AsString =  lbIs_ref.Caption then
         achou := true;
      qrItens.Next;
   end;
   Result := achou;
   qrItens.First;
   grid.visible := TRUE;
end;
procedure TfmCadAvarias.AbreFmPesqLista(tag:integer);
begin
   DesabilitaItens();
   if fmAbrirAvaria = nil then
   begin
      Application.CreateForm(TfmAbrirAvaria, fmAbrirAvaria);
      fmAbrirAvaria.Show;
      fmAbrirAvaria.preparaParaListarAvaria(tag);
   end;
end;

function TfmCadAvarias.VerificaPreenchimento(Sender: TOBject): String;
var
  Erro:String;
begin
   erro := '';
   if (lbuo.Caption <> fmMain.getUoLogada() ) and (fmMain.getUoLogada() <> '10033674') then
      Erro := erro + ' - So a loja que criou a avaria pode altera-la.' + #13;
   if edCodigo.Text = '' then
      Erro := erro + ' - Falta o código.' + #13;
   if edDesc.Text = '' then
      Erro := erro + ' - Falta a descrição.'+ #13;
   edQuant.Text := funcoes.SohNumeros(edquant.Text);

   if edQuant.text = '' then
      Erro := erro + ' - Falta o a quantidade.'+ #13;

   if copy(LbTipo.Caption,01,03) <> 'Tot' then
      if (length(edObs.Text) < 5) then
         Erro := erro + ' - Falta o a observação do item.'+ #13;

   if (itemJaExiste() = true) and (Operacao  = 'I') then
      Erro := erro + ' - Este item já existe.'+ #13;

   if (cbOrigemAvaria.ItemIndex < 0) then
      Erro := erro + ' - Informe a origem da avaria.'+ #13;

   if (funcoes.tiraEspaco( ednResponsavel.Text) = '') and  (cbOrigemAvaria.ItemIndex = 1) then
      Erro := erro + ' - Informe o responsável, pela avaria.'+ #13;
   result := erro;
end;

procedure TfmCadAvarias.CarregaItensAvarias(Sender: tobject; numero:string; loja:String);
var
  TotalAvarias: real;
  i:integer;
begin
   grid.Visible := false;
   QrItens.SQL.Clear;
   QrItens.SQL.Add(' select ava.numAvaria, crefe.cd_ref as CODIGO, crefe.ds_ref AS DESCRICAO ,' +
                   ' ava.quant as QUANT, ava.pco as PRECO, ava.pcoTotal as TOTAL,  ava.obsItem OBS, ava.Is_ref, ava.ref, ' +
                   ' case ava.origem when ''0'' then ''Cliente'' when ''1'' then ''Funcionario'' when ''2'' then ''CD'' when ''3'' then ''Gerente/SubGerente'' end as Origem, ' +
                   ' ava.Responsavel, ava.origem as codOrigem, ava.cd_pes, ava.pcoSugerido, ava.PcoVarejo as PcVarejo '+
                   ' from zcf_AvariasItens ava with(NoLock) ' +
                   ' inner join crefe with(NoLock) on ava.is_ref = crefe.is_ref '+
                   ' where ava.numAvaria =' + numero +
                   ' and ava.loja = ' + loja  +
                   ' order by ava.ref'
                  );

   QrItens.Open();
   grid.Columns[00].Visible := false;
   grid.Columns[01].Width := 50;
   grid.Columns[02].Width := 250;
   grid.Columns[03].Width := 50;
   grid.Columns[04].Width := 60;
   grid.Columns[05].Width := 60;
   grid.Columns[06].Width := 200;
   grid.Columns[08].Width := 50;



   fmMain.showGridCol(Grid,QrItens,'cd_pes',false);
   fmMain.showGridCol(Grid,QrItens,'total',false);
   fmMain.showGridCol(Grid,QrItens,'codOrigem',false);
   fmMain.showGridCol(Grid,QrItens,'is_ref',false);
   fmMain.showGridCol(Grid,QrItens,'ref',false);

   grid.Columns[QrItens.FieldByName('origem').Index].Width := 50;
   grid.Columns[QrItens.FieldByName('Responsavel').Index].Width := 80;

   if (fmMain.ehCampoPermitido('avarias.grupoPcSugestao') = true )then
      edPcSugerido.Enabled := true;

   if copy(lbStatus.Caption,01,01) <> 'A' then
      pnOperacoes.Visible := true
   else
      pnOperacoes.Visible := false;

   qrItens.First;
   totalAvarias :=0;

   while qritens.eof = false do
   begin
      totalAvarias := totalAvarias + qritens.fieldByname('TOTAL').AsFloat;
      qrItens.Next;
   end;
   lbTotal.Caption :=  floattostrf(totalAvarias,ffNumber,18,2);

   getValorWell('E', ' Update zcf_avarias set valor = ' + funcoes.ValorSql(FloatToStr(totalAvarias)) + ' where numAvaria = ' + numero + ' and loja = ' + loja ,'@@error',fmMain.Conexao);

   qritens.First;
   for i:= 0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];

   grid.Visible := true;
end;

procedure TfmCadAvarias.CarregarCabecalhoAvarias(sender: Tobject; numero,loja:string);
var
  ds:TdataSet;
begin
   ds := funcsql.getDataSetQ(' Exec zcf_ListarAvaria @numAvaria = '+ numero + ' , @uo = '+ loja + ' , @dtI= '''' , @dtF = '''' ', fmMain.Conexao);
   lbLoja.Caption := ds.fielDByName('Loja').AsString;
   lbDtAvaria.Caption := copy( ds.fielDByName('DataAvaria').AsString,01,10);
   lbStatus.Caption := ds.fielDByName('Aprovacao').AsString;
   lbNumAvaria.Caption := funcoes.preencheCampo(05,'0','e', ds.fielDByName('Numero').AsString);
   mmObs.Lines.Clear;
   mmObs.Lines[0] :=  (ds.fieldByName('observacao').asString);
   lbtipo.Caption := ds.fielDByName('tipo').AsString;
   lbuo.Caption := ds.fielDByName('uo').AsString;
   lbdtAprov.caption := ds.fielDByName('dataAprovacao').AsString;
   pnTitulo.Visible := true;
   ds.free();
end;

procedure TfmCadAvarias.Nova1Click(Sender: TObject);
begin
   DesabilitaItens();
   Application.CreateForm(TfmCriarAvaria, fmCriarAvaria);
   fmCriarAvaria.show;
end;


procedure TfmCadAvarias.BitBtn7Click(Sender: TObject);
begin
   Operacao := 'A';
   LimparCampos(sender);
   edCodigo.Text := qrItens.FieldByName('codigo').AsString;
   edcodigo.Enabled := false;
   edDesc.Text := qrItens.FieldByName('descricao').AsString;
   edPreco.Text := qrItens.FieldByName('preco').AsString;
   edQuant.Text := qrItens.FieldByName('quant').AsString;
   edobs.Text:= trim( qrItens.FieldByName('Obs').AsString);
   lbIs_ref.caption := qrItens.FieldByName('is_ref').AsString;
   lbRef.Caption := qrItens.FieldByName('ref').AsString;
   cbOrigemAvaria.ItemIndex := strToInt(qrItens.FieldByName('codOrigem').AsString);
   ednResponsavel.Text := qrItens.FieldByName('Responsavel').AsString;
   edPcSugerido.Text := qrItens.FieldByName('pcoSugerido').AsString;
   lbCD_pes.Caption := funcsql.openSQL('select nm_usu from dsusu where cd_pes = ' + qrItens.FieldByName('cd_pes').AsString, 'nm_usu', fmMain.Conexao );
   lbCD_pes.Visible := true;
   lbMNPes.Visible := true;
end;

procedure TfmCadAvarias.edCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
   ds:TDataSet;
begin
   if (key = VK_RETURN )or(key = VK_TAB) then
   begin
      ds := uCF.getDadosProd( lbuo.Caption, edCodigo.Text, '5', true );
      if (ds.IsEmpty = false ) then
      begin
         edDesc.Text := ds.fieldByName('codigo').AsString +'-'+ds.fieldByName('descricao').AsString;
         lbIs_ref.Caption := ds.fieldByName('is_ref').AsString;
      end;
      ds.Free();
   end;
end;

procedure TfmCadAvarias.BitBtn5Click(Sender: TObject);
begin
   if qrItens.FieldByname('ref').AsString <> '' then
   begin
      funcSQL.GetValorWell( 'E',' delete from zcf_AvariasItens where  ref = ' + qrItens.FieldByname('ref').AsString , '@@error',fmMain.Conexao );
      carregaItensAvarias(Sender,  lbnumAvaria.Caption,  lbUo.Caption);
   end;
end;


procedure TfmCadAvarias.BitBtn1Click(Sender: TObject);
var
  cmd:String;
  precos:Tstrings;
begin
   if VerificaPreenchimento(sender) = '' then
   begin
      if Operacao = 'I' then
      begin
        precos := TStringList.Create();
        precos := funcsql.getValoresSQL2(' select dbo.z_cf_funObterPrecoProduto_CF(005, '+ lbIs_ref.Caption + ', ' + lbuo.caption + ', 0) , ' +
                                         ' dbo.z_cf_funObterPrecoProduto_CF(005, '+ lbIs_ref.Caption + ', ' + lbuo.caption + ', 0) * '+ edQuant.Text +', ' +
                                         ' dbo.z_cf_funObterPrecoProduto_CF(101, '+ lbIs_ref.Caption + ', ' + lbuo.caption + ', 0) ',
                                         fmMain.Conexao );

         GetValorWell( 'E',' insert zcf_AvariasItens values ( ' +
                       lbnumAvaria.Caption +',  '+
                       lbUo.Caption +',  '+
                       lbIs_ref.Caption  + ', '+
                       edQuant.Text +',  '+
                       funcoes.ValorSql(precos[0]) +', ' +
                       funcoes.ValorSql(precos[1]) +', ' +
                       QuotedStr(edObs.text) +',  '+
                       intToStr(cbOrigemAvaria.ItemIndex) + ', ' +
                       QuotedStr(ednResponsavel.text) + ', ' +
                       fmMain.getCdPesLogado() + ', ' +
                       funcoes.ValorSql(precos[2]) +', ' +
                       funcoes.ValorSql(edPcSugerido.Text)
                        +', null, 0,' + lbUo.Caption +' )'
                       ,'@@error',fmMain.Conexao );

         CarregaItensAvarias(Sender,lbnumAvaria.Caption, lbUo.Caption);
      end;

      if Operacao = 'A' then
      begin
         cmd := ' Update zcf_AvariasItens set '+
                  ' Is_ref = ' + lbIs_ref.Caption  + ' , '+
                  ' quant = ' + edquant.Text +' , '+
                  ' obsItem = ' + QuotedStr(trim(edObs.Text)) +' , '+
                  ' cd_pes = '+ fmMain.getCdPesLogado()   +' , '+
                  'pcoSugerido = ' + ValorSql(edPcSugerido.Text) +
                  ' where ref = ' + lbRef.Caption;
         GetValorWell( 'E', cmd, '@@error',fmMain.Conexao);
         CarregaItensAvarias(Sender,lbnumAvaria.Caption, lbUo.caption);
      end;
      pnOperacoes.Visible := true;
      pnDados.Visible := false;
      pnConfirma.Visible := false;
      lbCD_pes.Visible := false;
      lbMNPes.Visible := false;
      grid.ReadOnly := false;
   end
   else
     funcoes.MsgTela('', VerificaPreenchimento(sender), mb_ok + mb_iconError );
end;

procedure TfmCadAvarias.FlatButton1Click(Sender: TObject);
begin
    LimparCampos(sender);
    qrItens.Cancel;
    pnOperacoes.Visible := true;
    pnDados.Visible := false;
    pnConfirma.Visible := false;
    grid.ReadOnly := false;
end;

procedure TfmCadAvarias.LimparCampos(sender: TObject);
begin
   pnOperacoes.Visible := false;
   pnDados.Visible := true;
   pnConfirma.Visible := true;

   edCodigo.Text := '';
   edDesc.Text := '';
   edQuant.Text := '';
   edobs.Text:='';
   edPcSugerido.Text:='0';

   lbIs_ref.caption := '';
end;

procedure TfmCadAvarias.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key= #13 then
   begin
       Perform (CM_DialogKey, VK_TAB, 0);
       key:=#0;
   end;
end;

procedure TfmCadAvarias.Abrir1Click(Sender: TObject);
begin
   AbreFmPesqLista(1);
end;

procedure TfmCadAvarias.Aprovar1Click(Sender: TObject);
var
  user:string;
begin
   if (qritens.IsEmpty = false ) then
   begin
      user := verificaSenhas.TelaAutorizacao2(fmMain.Conexao,fmMain.GetParamBD('avarias.grupoAprovador',''),'' );
      if (user  <> '') then
      begin
         Application.CreateForm(TfmAprovaAv, fmAprovaAv);
         fmAprovaAv.show;
         fmAprovaAv.lbUsAprovador.Caption := user;
      end;
   end;
end;

procedure TfmCadAvarias.DesabilitaItens();
begin
   qrItens.Close;
   grid.Visible := false;
   PnOperacoes.Visible := false;
   pnConfirma.Visible := false;
   pnTitulo.Visible := false;
end;


procedure TfmCadAvarias.EdDescEnter(Sender: TObject);
begin
   edCodigo.setFocus;
end;

procedure TfmCadAvarias.edQuantExit(Sender: TObject);
begin
   edQuant.Text := funcoes.SohNumeros(edQuant.Text);
end;

procedure TfmCadAvarias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if fmAbrirAvaria <> nil then
   begin
      fmAbrirAvaria.Close;
      fmAbrirAvaria := nil;
   end;
   fmCadAvarias := nil;
   action := caFree;
end;

procedure TfmCadAvarias.Exportar1Click(Sender: TObject);
begin
   if (qritens.IsEmpty = false ) then
      if verificaSenhas.TelaAutorizacao2(fmMain.Conexao,'13','10000031') <> '' then
        funcSql.exportaQuery(QrItens, false,'');
end;

procedure TfmCadAvarias.GridCellClick(Column: TColumn);
begin
   if ( QrItens.IsEmpty = false) then
   begin
      FlatButton1Click(nil);
      BitBtn7Click(nil);
      Grid.ReadOnly := true;
   end;
end;

procedure TfmCadAvarias.FormResize(Sender: TObject);
begin
   grid.Width := fmCadAvarias.Width- 30;
end;

procedure TfmCadAvarias.Relatrios1Click(Sender: TObject);
begin
   DesabilitaItens();
   if fmRelGeral = nil then
   begin
      application.createForm( TfmRelGeral,  fmRelGeral);
      fmRelGeral.show();
      fmRelGeral.setPerfil(2);
   end;
end;

procedure TfmCadAvarias.Imprimirrelaodeavaria1Click(Sender: TObject);
begin
   DesabilitaItens();
   AbreFmPesqLista(2);
end;

procedure TfmCadAvarias.Vendadeprodutosavariados1Click(Sender: TObject);
begin
   DesabilitaItens();
   if (fmRelGeral = nil) then
   begin
      application.createForm( TfmRelGeral,  fmRelGeral);
      fmRelGeral.show();
      fmRelGeral.setPerfil(1);
   end;
end;

procedure TfmCadAvarias.FormActivate(Sender: TObject);
begin
   fmMain.verificaPermissao(fmCadAvarias.Menu.Items, fmMain.getTelasPermDoGrupo( fmMain.getGrupoLogado() ) );
end;

procedure TfmCadAvarias.GridTitleClick(Column: TColumn);
begin
   if ( grid.ReadOnly = false ) then
      funcsql.organizarQuery(qrItens, column);
end;

procedure TfmCadAvarias.BitBtn3Click(Sender: TObject);
begin
   Operacao := 'I';
   LimparCampos(sender);
   edCodigo.Enabled := true;
   edCodigo.setFocus;
end;


procedure TfmCadAvarias.ransferirAvaria1Click(Sender: TObject);
begin
   if (QrItens.IsEmpty = false) then
      DesabilitaItens();
   AbreFmPesqLista(4);
end;

end.

