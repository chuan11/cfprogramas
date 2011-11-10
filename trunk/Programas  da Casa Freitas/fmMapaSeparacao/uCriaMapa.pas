unit uCriaMapa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  adLabelEdit, ADODB,
  adLabelComboBox, funcSQl, CheckLst, adLabelCheckListBox, fCtrls, funcoes,
  Buttons, TFlatButtonUnit, db;

type
  TfmCriarMapa = class(TForm)
    rg: TRadioGroup;
    cbPreco: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    edCod: TadLabelEdit;
    clb1: TadLabelCheckListBox;
    fsCheckBox1: TfsCheckBox;
    edNome: TadLabelEdit;
    cbEstoque: TfsCheckBox;
    btForn: TBitBtn;
    btOk: TBitBtn;
    bitBtn3: TBitBtn;
    edIsNota: TadLabelEdit;
    lbIsNota: TLabel;
    procedure rgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fsCheckBox1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    function criarMapa(Sender:TObject):String;
    procedure insereItensMapa(nMapa:String);
    procedure btFornClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edIsNotaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCriarMapa: TfmCriarMapa;

implementation

uses uMain, uMapa, ufornACriticar, cf, uListaFornecedores;

{$R *.dfm}

procedure TfmCriarMapa.rgClick(Sender: TObject);
begin
   Case rg.ItemIndex of
   0:begin
        edCod.LabelDefs.Caption := 'Pedido de compra ';
        cbLoja.Visible := false;
        btForn.Visible := false;
        edIsNota.Visible:= false;
     end;
   1:begin
        edCod.LabelDefs.Caption := 'Faixa de codigo ';
        cbLoja.Visible := true;
        btForn.Visible := false;
        edIsNota.Visible:= false;
     end;
   2:begin
        edCod.visible := false;
        cbLoja.Visible := true;
        btForn.Visible := true;
        edIsNota.Visible:= true;
     end;
   end
end;

procedure TfmCriarMapa.FormCreate(Sender: TObject);
begin
   cf.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado() );
   cbPreco.Items := funcSQl.getListaPrecos(fmMain.Conexao,true,true,false, fmMain.getGrupoLogado());
   cbPreco.ItemIndex :=0;
   clb1.Items.Clear;
   clb1.Items := funcsql.getListagem( 'Select cd_uo +' + quotedStr(' ') + '+ ds_uo from zcf_tbuo where geramapa = 1 order by cd_uo', fmMain.Conexao );
   fsCheckBox1Click(nil);
   rgClick(nil);
   lbIsNota.Caption := '';
end;

procedure TfmCriarMapa.fsCheckBox1Click(Sender: TObject);
var
  i:integer;
begin
   for i:=0 to clb1.Items.Count -1 do
      clb1.Checked[i] := not(clb1.Checked[i]);
end;

function TfmCriarMapa.CriarMapa(Sender:TObject):String;
var
  tipo, numMapa, cmd:String;
  i:integer;
begin
   if (rg.ItemIndex = 0) then
     numMapa := edCod.Text
   else if (rg.ItemIndex = 2) then
      numMapa := funcoes.SohNumerosPositivos(edIsNota.Text)
   else if rg.ItemIndex = 1 then
   begin
       tipo := 'N';
       funcsql.execSQl( 'update zcf_mapaSeparacaoN set num = num + 1 where tipo = ' + quotedStr(tipo), fmMain.Conexao );
       numMapa := funcsql.openSQL('Select num from zcf_mapaSeparacaoN where tipo = ' + quotedStr(tipo), 'num', fmMain.Conexao );
   end;

// criar no bd o mapa separacao
   for i:=0 to clb1.Items.Count - 1 do
      if clb1.Checked[i] = true then
         cmd := cmd +', l' + copy(clb1.Items[i],01,02);
   cmd := 'begin Insert zcf_mapaSeparacao( nome, data, ehfinalizada, criador, pco' + cmd + ', criticaEstoque, num  )';

   cmd := cmd + ' values ( '+ quotedStr(edNome.Text)  +' , '+
                              funcoes.DateTimeToSqlDateTime(now,'') +' , 0, '+
                              fmMain.getUserLogado()   +' , '+
                              funcoes.getCodPc(cbPreco);

   for i:=0 to clb1.Items.Count - 1 do
      if clb1.Checked[i] = true then
         cmd := cmd +', 1';

   if  cbEstoque.Checked = true then
     cmd := cmd +', 1 '
   else
     cmd := cmd +', 2 ';

   cmd := cmd + ' , ' + numMapa +  ' ) end';

   if funcsql.execSQL(cmd, fmMain.Conexao) = true then
      result := numMapa
   else
      result := '';
end;

procedure TfmCriarMapa.insereItensMapa(nMapa: String);
var
   cmd, strEstoque:string;
   cmdItens:String;
   qrItens:TADOQuery;
begin
   qrItens := TADOQuery.Create(nil);
   qrItens.Connection := fmMain.Conexao;

   if cbEstoque.Checked = false then
      strEstoque :=  ' and dbo.z_cf_EstoqueNaLoja( is_ref, 10033674, 1) > 0 '
   else
      strEstoque :=  ' ';

   if rg.ItemIndex = 0 then
      cmdItens := 'Select is_ref from dsipe with(nolock) where is_pedf = '+  edCod.Text
   else if rg.ItemIndex = 1 then
      cmdItens := ' Select is_ref from crefe with(nolock) where cd_ref like ' + quotedStr(edCod.Text + '%') + strEstoque
   else if rg.ItemIndex = 2 then
   begin
      cmdItens :=  ' Select is_ref from dmovi with(nolock) where is_nota = ' + lbIsNota.Caption ;
   end;
   qrItens.sql.Add(cmdItens);
   qrItens.Open;

   if qrItens.RecordCount > 0 then
   begin
      if rg.ItemIndex = 0 then
      begin
         cmd := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                ' Select '+ nMapa+ ' , dsipe.is_ref, '+
                ' dsipe.qt_ped, '+
                ' dsipe.qt_ped, '+
                ' dbo.z_cf_funObterPrecoProduto_CF( 101, dsipe.is_Ref, 10033674, 0), '+
                ' crefe.qt_emb ' +
                ' from dsipe (nolock) inner join crefe (nolock) on dsipe.is_ref = crefe.is_ref ' +
                ' where dsipe.is_pedf = ' + nMapa  +  ' Order by dsipe.is_ref' ;
      end
      else if rg.ItemIndex = 2 then
      begin
          cmd := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                 ' Select '+ nMapa+ ', dmovi.is_ref, dmovi.qt_mov, dmovi.qt_mov,  '+
                 ' dbo.z_cf_funObterPrecoProduto_CF( '+ fmMain.getCodPreco(cbPreco)  +   ', crefe.is_Ref, ' + fmMain.getUOCD() + ', 0), crefe.qt_emb '+
                 ' from dmovi inner join crefe (nolock) on dmovi.is_ref = crefe.is_ref ' +
                 ' where dmovi.is_nota= ' + lbIsNota.caption ;
      end
      else
      begin
         cmd := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                ' Select '+ nMapa+ ' , is_ref, '+
                ' dbo.z_cf_EstoqueNaLoja( is_ref, 10033674, 1), '+
                ' dbo.z_cf_EstoqueNaLoja( is_ref, 10033674, 1), '+
                ' dbo.z_cf_funObterPrecoProduto_CF( 101, is_Ref, 10033674, 0), '+
                ' crefe.qt_emb ' +
                ' from crefe where is_ref in ( ' + cmdItens + ' ) ' + strEstoque  + ' Order by is_ref' ;
      end;


      if (funcsql.execSQL(cmd, fmMain.Conexao) = true ) then
      begin
          MsgTela('','Criada o mapa de número: ' +nMapa+ #13+ 'O mapa será carregado.', MB_ICONEXCLAMATION + MB_OK  );
          fmMapa.CarregaMapa(nMapa);
          BitBtn3.Click;
      end;
   end
   else
   begin
      funcSQl.execSQL('delete from zcf_mapaSeparacao where num = ' +nMapa , fmMain.Conexao);
      MsgTela('','A opção que você escolheu não encontrou nenhum item para a seleção', MB_OK + MB_ICONERROR ) ;
   end;
end;

procedure TfmCriarMapa.btOkClick(Sender: TObject);
var
  nMapa, erro:String;
begin
   if (length(edNome.text) < 3) then
      erro := erro+ ' - Escolha um nome para o mapa de separação. '+#13;

   if rg.ItemIndex = 0 then
      if (edCod.Text = '') then
         erro := erro+' - Informe o numero do pedido. '+#13;

   if (rg.ItemIndex = 1) then
      if (length(edCod.Text) < 3 ) then
         erro := erro+' - Informe a faixa de código. '+#13;

   if  (rg.ItemIndex = 2) then
     if (lbIsNota.Caption = '') then
        erro := erro+' - Informe os dados da nota'+#13;     

   if erro = '' then
   begin
      try
         if cbEstoque.Checked = true then
            msgTela('', '      Você selecionou gerar mapa de separação de itens ' +#13+
                        '   que não têm no estoque.' +#13+
                        '      No entanto só será feita a requisição dos produtos que constarem ' +#13+
                        '   no estoque no momento da aprovação do mapa de separação', MB_OK + MB_ICONWARNING);

         nMapa := criarMapa(nil);

         if (nMapa  <> '') then
               insereItensMapa( nMapa );

         btOk.ModalResult := mrOk;
      except
         on e:Exception do
         begin
            if pos('PK__zcf_mapaseparaca', e.Message) > 0 then
            funcoes.msgTela('','Já existe um mapa de separação com esses dados.', MB_ICONERROR + MB_OK);
         end;
      end;
   end
   else
   begin
     erro := 'Corrija antes esse problemas '+#13 + erro;
     funcoes.MsgTela('',erro,mb_iconError+mb_ok);
     btOk.ModalResult := mrNone;
   end;
end;

procedure TfmCriarMapa.btFornClick(Sender: TObject);
var
  isNota:String;
  ds:TdataSet;
begin
   isNota := fmMain.getIsNota();
   if ( isNota <> '') then
   begin
      ds:= cf.getDadosNota(isNota, '', '', '');
      edIsNota.text :=
      trim(ds.fieldByname('serie').asString) + '-' +
      trim(ds.fieldByname('num').asString) + ' '+
      trim(ds.fieldByname('Emissor/Destino').asString);
      lbIsNota.Caption := ds.fieldByname('is_nota').asString;
      ds.free();
   end
   else
      lbIsNota.Caption := '';
end;

procedure TfmCriarMapa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if (ModalResult  = mrAbort) then
     canClose := false;
end;

procedure TfmCriarMapa.edIsNotaEnter(Sender: TObject);
begin
btForn.SetFocus();
end;

end.
