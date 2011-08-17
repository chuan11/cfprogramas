unit uRemoveRegTEF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, ComCtrls,
  adLabelDBDateTimePicker, StdCtrls, adLabelComboBox, TFlatButtonUnit,
  fCtrls, Menus, adLabelEdit, adLabelNumericEdit;

type
  TfmRemRegTEF = class(TForm)
    cbLojas: TadLabelComboBox;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    Label1: TLabel;
    btConsulta: TFlatButton;
    tb: TADOTable;
    dt: TfsDateTimePicker;
    PopupMenu1: TPopupMenu;
    Alteramodalidadedepagamento1: TMenuItem;
    GroupBox1: TGroupBox;
    cbModalidade: TadLabelComboBox;
    cbCaixas: TadLabelComboBox;
    RemoveregistrodeTEF1: TMenuItem;
    Inseremodalidadepagamento1: TMenuItem;
    RemoveModalidaDedePagamento1: TMenuItem;
    tbcodLoja: TIntegerField;
    tbdescEstacao: TStringField;
    tbcd_mve: TIntegerField;
    tbds_mve: TStringField;
    tbdataSessaoCaixa: TDateTimeField;
    tbseqtransacaoCaixa: TIntegerField;
    tbseqModPagtoPorTransCaixa: TIntegerField;
    tbValor: TBCDField;
    tbnumParcelas: TStringField;
    tbtefMagnetico: TStringField;
    tbseqTefTransCaixa: TIntegerField;
    edBusca: TadLabelNumericEdit;
    tbcd_tpm: TStringField;
    tbtp_mve: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridTitleClick(Column: TColumn);
    procedure Alteramodalidadedepagamento1Click(Sender: TObject);
    procedure alteraModalidadeDePagamento();
    procedure filtrarTable();
    procedure cbCaixasChange(Sender: TObject);
    procedure ajustacolunas();
    procedure RemoveregistrodeTEF1Click(Sender: TObject);
    procedure Inseremodalidadepagamento1Click(Sender: TObject);
    procedure chamaInsereModalidadePagamento1Click(Sender: TObject);
    procedure chamaRemoveRegistroDeTEF1Click(Sender: TObject);
    procedure removerModalidadePagamento();
    procedure RemoveModalidaDedePagamento1Click(Sender: TObject);
    procedure removeRegistroTEF();
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRemRegTEF: TfmRemRegTEF;

implementation


{$R *.dfm}
uses uMain, funcoes, funcSQL, uCF, uAlteraModalidadePagto;

procedure TfmRemRegTEF.FormCreate(Sender: TObject);
begin
   dt.Date := now;
   funcoes.carregaCampos(fmRemRegTEF);
   fmMain.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado() );
end;

procedure TfmRemRegTEF.ajustaColunas;
var
   i:smallInt;
begin
   for i:=0 to grid.Columns.Count-1 do
      grid.Columns[i].Visible := false;

   grid.Columns[ tb.FieldByName('descEstacao').Index ].visible := true;
   grid.Columns[ tb.FieldByName('descEstacao').Index ].Title.Caption := 'Caixa';

   grid.Columns[ tb.FieldByName('ds_mveReal').Index ].visible := true;
   grid.Columns[ tb.FieldByName('ds_mveReal').Index ].Title.Caption := 'Modalidade';

   grid.Columns[ tb.FieldByName('valor').Index ].visible := true;
   grid.Columns[ tb.FieldByName('valor').Index ].Title.Caption := 'Valor';

   grid.Columns[ tb.FieldByName('numParcelas').Index ].visible := true;
   grid.Columns[ tb.FieldByName('numParcelas').Index ].Title.Caption := 'Parcelas';

   grid.Columns[ tb.FieldByName('seqTransacaoCaixa').Index ].visible := true;
   grid.Columns[ tb.FieldByName('seqTransacaoCaixa').Index ].Title.Caption := 'Transacao do caixa';
end;


procedure TfmRemRegTEF.btConsultaClick(Sender: TObject);
begin
   cbCaixas.Items := uCF.getDescCaixas( funcoes.getCodUO(cbLojas) , true);
   cbCaixas.ItemIndex := -1;

   if (cbModalidade.Items.Count = 0) then
   begin
      cbModalidade.items := uCF.getCodModalidadesPagamento(true);
      cbModalidade.ItemIndex := -1;
   end;

   cbCaixas.ItemIndex:= 0;
   cbModalidade.ItemIndex := 0;
   uCF.listaRecebimentosCaixa( tb, funcoes.getCodUO(cbLojas), '', dt, dt, false, true, false);
   tb.Close();
   tb.Open();
   ajustaColunas();
end;

procedure TfmRemRegTEF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   edBusca.Text:='';
   funcoes.salvaCampos(fmRemRegTEF);
   action := caFree;
   fmRemRegTEF := nil;
end;

procedure TfmRemRegTEF.gridTitleClick(Column: TColumn);
begin
   funcSql.organizarTabela(tb, Column);
end;

procedure TfmRemRegTEF.alteraModalidadeDePagamento;
var
   valor, descMod, codMod, nParcelas:String;
   cmd, descModAnt, nParcelasAnt, valorAnt:String;
begin
   edbusca.Value := 0;

   application.CreateForm(TfmAlteraModPagto, fmAlteraModPagto);
   fmAlteraModPagto.ShowModal();
   if  (fmAlteraModPagto.ModalResult = mrOk) then
   begin
      descModAnt := tb.fieldByName('ds_mveReal').AsString;
      nParcelasAnt := tb.fieldByName('numParcelas').AsString;
      valorAnt := tb.fieldByName('valor').AsString;

      codMod := funcoes.getCodModPagto( fmAlteraModPagto.cbModalidades );
      descMod := funcoes.getNomeModPagto( fmAlteraModPagto.cbModalidades);
      nParcelas := fmAlteraModPagto.edNumParcelas.Text;
      valor := fmAlteraModPagto.edValor.Text;

      tb.Edit();
      tb.FieldByName('ds_mveReal').AsString := descMod;
      tb.FieldByName('numParcelas').AsString := nParcelas;
      tb.FieldByName('valor').AsString := valor;
      tb.Post();

     if ( uCF.alterarModPagamento( tb.FieldByName('codLoja').AsString,
                                   tb.FieldByName('seqtransacaoCaixa').AsString,
                                   tb.FieldByName('SeqModPagtoPorTransCaixa').AsString,
                                   codMod,
                                   valor,
                                   nParcelas,
                                   tb.FieldByName('seqTefTransCaixa').AsString,
                                   tb.FieldByName('dataSessaoCaixa').asString
                                 )  = true ) then
      begin
         cmd:= 'Alteração modalidade, loja = ' + tb.FieldByName('codLoja').AsString +
               ' data: ' + tb.FieldByName('dataSessaoCaixa').asString +
               ' SeqModPagtoPorTransCaixa: '+ tb.FieldByName('SeqModPagtoPorTransCaixa').AsString +
               ' Dados: ' + descModAnt +'/'+ valorAnt +' '+ nParcelasAnt+ 'Paracelas' +
               ' Para: '+ descMod +'/'+ valor +' ' + nParcelas + 'Paracelas';

         logAlteracoesBD( fmMain.conexao, fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
         msgTela('','Dados alterados, para ver a alteração gere o dia novamente! ', MB_OK  + MB_ICONEXCLAMATION);
      end
      else
         msgTela('','Problemas ao alterar a modalidade de pagamento.', MB_OK  + mb_iconError);
   end;
end;

procedure TfmRemRegTEF.AlteraModalidadeDePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      alteraModalidadeDePagamento();
end;

procedure TfmRemRegTEF.filtrarTable();
var
  aux:String;
begin
   aux := '';
   if (tb.TableName <> '') then
   begin
      if (cbCaixas.ItemIndex > 0) then
         aux := ' descEstacao = ' + quotedStr(funcoes.getNomeDoCx(cbCaixas));

      if (cbModalidade.itemIndex > 0) then
         if (aux <> '') then
            aux := aux + ' and cd_mveReal = ' + quotedStr(funcoes.getCodModPagto(cbModalidade))
         else
            aux := ' cd_mveReal = ' + quotedStr(funcoes.getCodModPagto(cbModalidade));

      if (edBusca.value > 0) then
         if (aux <> '') then
            aux := aux + ' and valor = ' + funcoes.valorSql(edBusca.Text)
         else
            aux := ' valor = ' + funcoes.valorSql(edBusca.Text)
   end;
   funcoes.gravaLog('filtro: ' + aux);
   tb.Close();
   tb.Filter := (aux);
   tb.Filtered := true;
   tb.Open();
   ajustaColunas();
end;

procedure TfmRemRegTEF.cbCaixasChange(Sender: TObject);
begin
   filtrarTable();
end;

procedure TfmRemRegTEF.removeRegistroDeTEF1Click(Sender: TObject);
var
   cmd:String;
begin
   if (tb.FieldByName('seqTefTransCaixa').AsString <> '0') then
   begin
      if (uCF.removeRegistroTef( tb.FieldByName('seqTefTransCaixa').AsString ) = true) then
      begin
         cmd := 'Remoção de TEF ' +  ' data: ' + tb.FieldByName('dataSessaoCaixa').asString +
                ' SeqModPagtoPorTransCaixa: '+ tb.FieldByName('SeqModPagtoPorTransCaixa').AsString ;
         logAlteracoesBD( fmMain.conexao, fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
         msgTela('', ' Registro TEF removido', MB_ICONEXCLAMATION + mb_ok)
      end;
   end
   else
       msgTela('', ' Sem Registro TEF associado a esse pagamento.', MB_ICONERROR + mb_ok)
end;

procedure TfmRemRegTEF.InsereModalidadePagamento1Click(Sender: TObject);
var
   valor, descMod, codMod, nParcelas:String;
   cmd:String;
begin
   application.CreateForm(TfmAlteraModPagto, fmAlteraModPagto);
   fmAlteraModPagto.ShowModal();
   if  (fmAlteraModPagto.ModalResult = mrOk) then
   begin
      codMod := funcoes.getCodModPagto( fmAlteraModPagto.cbModalidades );
      descMod := funcoes.getNomeModPagto( fmAlteraModPagto.cbModalidades);
      nParcelas := fmAlteraModPagto.edNumParcelas.Text;
      valor := fmAlteraModPagto.edValor.Text;

     if ( uCF.insereModPagamento( tb.FieldByName('codLoja').AsString,
                                  tb.FieldByName('seqtransacaoCaixa').AsString,
                                  codMod,
                                  valor,
                                  nParcelas,
                                  tb.FieldByName('dataSessaoCaixa').asString
                                 )  = true ) then
      begin
         cmd:= 'Insercao de modalidade, loja = ' + tb.FieldByName('codLoja').AsString +
               ' data: ' + tb.FieldByName('dataSessaoCaixa').asString +
               ' SeqModPagtoPorTransCaixa: '+ tb.FieldByName('SeqModPagtoPorTransCaixa').AsString +
               ' Dados: '+ descMod +'/'+ valor +' ' + nParcelas + 'Paracelas';

         logAlteracoesBD( fmMain.conexao, fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
         msgTela('','Dados inseridos, para ver a alteração gere o dia novamente! ', MB_OK  + MB_ICONEXCLAMATION);
      end
      else
         msgTela('','Problemas ao alterar a modalidade de pagamento.', MB_OK  + mb_iconError);
   end;
end;

procedure TfmRemRegTEF.chamaInsereModalidadePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      InsereModalidadePagamento1Click(nil);
end;


procedure TfmRemRegTEF.removerModalidadePagamento;
var
   valor, descMod, codMod, nParcelas:String;
   cmd, descModAnt, nParcelasAnt, valorAnt:String;
begin
   edbusca.Value := 0;

   descModAnt := tb.fieldByName('ds_mveReal').AsString;
   nParcelasAnt := tb.fieldByName('numParcelas').AsString;
   valorAnt := tb.fieldByName('valor').AsString;

   codMod := tb.fieldByName('cd_mveReal').AsString;;
   descMod := tb.fieldByName('ds_mveReal').AsString;
   nParcelas := '0';
   valor := '000';

   tb.Edit();
   tb.FieldByName('ds_mveReal').AsString := descMod;
   tb.FieldByName('numParcelas').AsString := nParcelas;
   tb.FieldByName('valor').AsString := valor;
   tb.Post();

   if ( uCF.alterarModPagamento( tb.FieldByName('codLoja').AsString,
                                 tb.FieldByName('seqtransacaoCaixa').AsString,
                                 tb.FieldByName('SeqModPagtoPorTransCaixa').AsString,
                                 codMod,
                                 valor,
                                 nParcelas,
                                 tb.FieldByName('seqTefTransCaixa').AsString,
                                 tb.FieldByName('dataSessaoCaixa').asString
                               )  = true ) then
   begin
      cmd:= 'Exclusao de modalidade, loja = ' + tb.FieldByName('codLoja').AsString +
            ' data: ' + tb.FieldByName('dataSessaoCaixa').asString +
            ' SeqModPagtoPorTransCaixa: '+ tb.FieldByName('SeqModPagtoPorTransCaixa').AsString +
            ' Dados: ' + descModAnt +'/'+ valorAnt +' '+ nParcelasAnt+ 'Paracelas' +
            ' Para: '+ descMod +'/'+ valor +' ' + nParcelas + 'Paracelas';

      logAlteracoesBD( fmMain.conexao, fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
      msgTela('','Dados excluidos! ', MB_OK  + MB_ICONEXCLAMATION);
   end
   else
      msgTela('','Problemas ao excluir a modalidade de pagamento.', MB_OK  + mb_iconError);
end;

procedure TfmRemRegTEF.RemoveModalidaDedePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      removerModalidadePagamento();
end;

procedure TfmRemRegTEF.removeRegistroTEF;
begin
   uCF.removeRegistroTef( tb.FieldByName('seqTefTransCaixa').AsString);
end;

procedure TfmRemRegTEF.chamaRemoveregistrodeTEF1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      removeRegistroDeTEF1Click(nil);
end;

procedure TfmRemRegTEF.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) then
      filtrarTable();
end;

end.
