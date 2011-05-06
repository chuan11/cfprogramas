unit uColetaContagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, menus,
  funcoes,verificaSenhas, adLabelEdit, adLabelNumericEdit, AppEvnts,
  adLabelListBox ;

type
  TfmMain = class(TForm)
    edDescricao: TEdit;
    lbEanRecebido: TLabel;
    MainMenu1: TMainMenu;
    NovaCaptura1: TMenuItem;
    VerItens1: TMenuItem;
    NovaCaptura2: TMenuItem;
    Mudarlote1: TMenuItem;
    mnTotais: TMenuItem;
    DeletarLote1: TMenuItem;
    lbItens: TadLabelListBox;
    N1: TMenuItem;
    edEan: TadLabelEdit;
    edQuant: TadLabelNumericEdit;
    procedure edEanKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure ehCodigoCadastrado();
    procedure tratarQuantidade();
    procedure gravaContagem();
    procedure desabilitaItens;
    procedure habilitaItens;
    procedure NovaCaptura1Click(Sender: TObject);
    procedure limpaItens();
    procedure NovaCaptura2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure logar(str:String);
    procedure Mudarlote1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getLotes();
    procedure FormActivate(Sender: TObject);
    procedure edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mostraContagem();
    procedure preparaParaMostrarcontagem();
    procedure preparaParaCapturar();
    procedure mnTotaisClick(Sender: TObject);
    function getTotalLote(nLote:String):String;
    procedure lbItensDblClick(Sender: TObject);
    procedure ajustaLote(num:String);
    procedure DeletarLote1Click(Sender: TObject);
    procedure apagarLote(numLote:String);
    procedure edEanExit(Sender: TObject);
    procedure edDescricaoEnter(Sender: TObject);
    procedure carregaParametros();
    procedure edEanKeyPress(Sender: TObject; var Key: Char);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  LOTE_POS_INI = 19;
  LOTE_TAM = 10;
  QT_POS_INI =6;
  QT_TAM = 10;
  SENHA = 'db';
  STR_NAO_CADASTRADO = 'Não cadastrado.';
var
  fmMain: TfmMain;
  ITENS:Tstringlist;
  EAN:String;
  CONFIRMA_ITEM_NAO_CADASTRADO, ACEITA_PROD_INVALIDO, CONTAGEM_UNITARIA: BOOLEAN;

  COD_POS_INICIO:integer;
  COD_POS_TAMANHO:integer;
  ARQ_CONTAGEM:String;
  NUM_COLETOR, ULTIMO_NUM_LOTE:String;
  LOTES:TstringList;

  REGRAS_POS_INI: array of integer;
  REGRAS_POS_FIM: array of integer;
  REGRAS_POS_COUNT:integer;

  IDX_COD_CADASTRADO:integer;

implementation
uses uNovaContagem, unovolote;

{$R *.dfm}

procedure TfmMain.FormActivate(Sender: TObject);
begin
   edEan.SetFocus();
   if( funcoes.ExisteParametro('-desenvolvimento') = false) then
      fmMain.WindowState := wsMaximized;

   fmMain.Caption := 'ibyte-V13 - C:'+ NUM_COLETOR;
end;


procedure TfmMain.ehCodigoCadastrado();
var
   regraCodEncontrado, i :integer;
   achou:boolean;
begin
   screen.Cursor := crHourGlass;
   regraCodEncontrado := -1;

   lbEanRecebido.Caption := trim(edEan.Text);
   achou := false;
   for i:=0 to ITENS.Count -1 do
   begin
      if (lbEanRecebido.Caption = trim( COPY(ITENS[I], 01, 14)) ) then
      begin
         regraCodEncontrado := 1; // regra 000001;000013
         edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1, 40 ) ;
         achou := true;
         break;
      end
   end;

   if (Length(lbEanRecebido.Caption ) = 13) and ( achou = false) then
   begin
      for i:=0 to ITENS.Count -1 do
         if ( strToInt(copy(lbEanRecebido.Caption,01,01)) <= 2 ) and (copy(lbEanRecebido.Caption,01,05) = copy(ITENS[I], 01, 05) ) then
         begin
            lbEanRecebido.Caption :=  COPY(lbEanRecebido.Caption,01,05);
            regraCodEncontrado := 2; // regra 000001;000013
            edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1, 40 ) ;
            break;
         end;
   end;
   if( regraCodEncontrado = -1 ) then
      edDescricao.Text := STR_NAO_CADASTRADO;

  IDX_COD_CADASTRADO := regraCodEncontrado;
  screen.Cursor := crDefault;
end;

{
procedure TfmMain.ehCodigoCadastrado();
var
  j, i:integer;
  regraCodEncontrado:integer;
begin
   screen.Cursor := crHourGlass;
   regraCodEncontrado := -1;

   lbEanRecebido.Caption := trim(edEan.Text);

   for i:=0 to ITENS.Count -1 do
   begin

      for j:=0 to REGRAS_POS_COUNT -1 do
      begin
         if ( lbEanRecebido.Caption = trim(copy(ITENS[i], REGRAS_POS_INI[J] , REGRAS_POS_FIM[J])))  then
         begin
            edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1, 40 ) ;
            regraCodEncontrado := j;
            break;
         end;
      end;

      // a3teraca6 fe5ta *ara en
      for j:=0 to REGRAS_POS_COUNT -1 do
      begin
         if ( copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]) = trim(copy(itens[i], 01, 14)) )then
         begin
            lbEanRecebido.caption := copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]);
            edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1, 40 ) ;
            regraCodEncontrado := j;
            break;
         end;
      end;
   end;

  if( regraCodEncontrado = -1 ) then
     edDescricao.Text := STR_NAO_CADASTRADO;

  IDX_COD_CADASTRADO := regraCodEncontrado;
  screen.Cursor := crDefault;
end;
}

{
procedure TfmMain.ehCodigoCadastrado();
var
  j, i:integer;

  regraCodEncontrado, inicio, fim, meio: integer;
  achou:boolean;
begin
   screen.Cursor := crHourGlass;
   regraCodEncontrado := -1;
   lbEanRecebido.Caption := trim(edEan.Text);

   for j:=0 to REGRAS_POS_COUNT -1 do
   begin
  // aqui eu testo  se o que foi digitado bate com as variacoes
  //  de regra aplicadas ao arquivo de lookup
       inicio := 0;
       fim := ITENS.Count-1;
       while (inicio <= fim ) do
       begin
          meio := (inicio + fim) div 2;
          gravaLog('item: '+ lbEanRecebido.caption  + ' inicio: ' + intToStr(inicio) + ' fim: ' + intToStr(fim) +' meio: ' + intToStr(meio));
          gravaLog ( lbEanRecebido.Caption +' ' +trim(copy(ITENS[meio], REGRAS_POS_INI[J] , REGRAS_POS_FIM[J])));
          if ( lbEanRecebido.Caption = trim(copy(ITENS[meio], REGRAS_POS_INI[J] , REGRAS_POS_FIM[J]))) then
          begin
             edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1, 40 ) ;
             regraCodEncontrado := j;
             inicio := fim+1;
             achou := true;
          end;
          if ( lbEanRecebido.Caption < trim(copy(ITENS[meio], REGRAS_POS_INI[J] , REGRAS_POS_FIM[J]))) then
             fim  := meio -1
          else
             inicio := meio + 1;

          if (achou = true) then
             break;
       end;


// agora  eu testo  se o codigo do lookup base com as regras de lookup aplicadas ao que foi digitado

       inicio := 0;
       fim := ITENS.Count-1;
       while (inicio <= fim ) do
       begin
          meio := (inicio + fim) div 2;
          gravaLog('');
          gravaLog('item: '+ lbEanRecebido.caption  + ' inicio: ' + intToStr(inicio) + ' fim: ' + intToStr(fim) +' meio: ' + intToStr(meio));
          gravaLog (  copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]) +' ' +  trim(copy(itens[meio], 1, 14)) );

//          if ( copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]) = trim(copy(itens[i], 01, 14)) )then
          if ( copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]) = trim(copy(itens[meio], 01, 14)) )then
          begin
             lbEanRecebido.caption := copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]);
             edDescricao.text := copy(ITENS[meio], COD_POS_TAMANHO+1, 40 ) ;
             regraCodEncontrado := j;
             inicio := fim+1;
             achou := true;
          end;

          if ( copy(lbEanRecebido.caption, REGRAS_POS_INI[J], REGRAS_POS_FIM[J]) < trim(copy(itens[meio],REGRAS_POS_INI[J], REGRAS_POS_FIM[J])) )then
             fim  := meio -1
          else
             inicio := meio + 1;

          if (achou = true) then
             break;
       end;
   end;

   if( regraCodEncontrado = -1 ) then
      edDescricao.Text := STR_NAO_CADASTRADO;

   IDX_COD_CADASTRADO := regraCodEncontrado;

   screen.Cursor := crDefault;

end;
}

procedure TfmMain.logar(str: String);
begin
   lbItens.Items.add(str);
end;

procedure TfmMain.carregaParametros;
var
   arqRegras:TStringList;
   i:integer;
   arq:String;
begin

   try
    arq := extractFilePath(ParamStr(0)) + 'lookup\' + 'RegrasLookUp.txt';

    if FileExists(arq) = false then
    begin
       forceDirectories( extractFilePath(ParamStr(0))  + '\lookUp'  );
       funcoes.GravaLinhaEmUmArquivo(extractFilePath(ParamStr(0))  + '\lookUp\RegrasLookUp.txt', '00001;00013');
    end;

     arqRegras := TStringList.Create();
     gravaLog('Carregar o arquivo de regras de lookup');
     arqRegras.LoadFromFile(arq);

     SetLength(REGRAS_POS_INI, arqRegras.Count);
     SetLength(REGRAS_POS_FIM, arqRegras.Count);

     REGRAS_POS_COUNT := 0;

     for i:=0 to arqRegras.Count-1 do
        if ( length(arqRegras[i]) = 11 ) then
        begin
           REGRAS_POS_INI[i] := strToInt(copy(arqRegras[i],1,5));
           REGRAS_POS_FIM[i] := strToInt(copy(arqRegras[i],7,10));
           REGRAS_POS_COUNT := REGRAS_POS_COUNT  + 1;
        end;

   gravaLog('Numero de regras carregadas: ' + intToStr( REGRAS_POS_COUNT  )   );

     arqRegras.Destroy();
   except
      on e:Exception do
      begin
         MsgTela2('','Erro ao carregar as regras de lookup', MB_ICONERROR);
         Application.Terminate();
      end;
   end;

   ACEITA_PROD_INVALIDO :=  RParRegBool('coletor','ACEITA_PROD_INVALIDO');
   CONTAGEM_UNITARIA := RParRegBool('coletor','ContagemUnitaria');
   CONFIRMA_ITEM_NAO_CADASTRADO := RParRegBool('coletor','confirmaItemNaoCadastrado');
   ARQ_CONTAGEM := funcoes.RParReg('coletor','nomeColetor');
   if ARQ_CONTAGEM <> '' then
   begin
      ARQ_CONTAGEM :=  extractFilePath(ParamStr(0)) + '\Dados\' + ARQ_CONTAGEM + '.txt'
   end;

   if( funcoes.RParReg('coletor','nomeColetor') = '') then
   begin
      ULTIMO_NUM_LOTE := '1';
      NUM_COLETOR := '1';
   end
   else
   begin
      NUM_COLETOR := funcoes.RParReg('coletor','nomeColetor');
      getLotes();
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  arq:String;
begin
   funcoes.limparLog();
   COD_POS_INICIO := 01;
   COD_POS_TAMANHO := 14;

// carrega o arquivo com o lookup

   arq := extractFilePath(ParamStr(0))  + 'lookUp\LookUp.txt';
   if (fileExists(arq) = true) then
   begin
      ITENS := TStringList.Create();
      ITENS.LoadFromFile(arq) ;
      ITENS.Sort();
      logar('Itens do Lookup: ' +intTostr(itens.Count) );
  //    ITENS.SaveToFile('c:\itensOrdenados.txt');
   end
   else
   begin
     msgTEla2('','Não achei ' + arq, 0);
     application.Terminate;
   end;
   NovaCaptura2.Caption := 'Ver itens';
   carregaParametros();
end;


procedure TfmMain.gravaContagem();
var
  qtAux,Str:String;
  podeGravar:Boolean;
begin
   podeGravar := true;
   if (IDX_COD_CADASTRADO < 0  )then
      if (CONFIRMA_ITEM_NAO_CADASTRADO = true) then
         if (MsgTela2('','Grava valor não cadastrado ?', mb_yesNo) <> mrOk)then
            podeGravar := false;

   if (podeGravar = true) then
   begin
      logar('---------------------------');
      logar('Lote: ' + ULTIMO_NUM_LOTE + ' Prod: '+ copy(edDescricao.Text,01,25)  );
      logar('Ean: ' + edEan.Text +'    Qt: ' + edQuant.Text);

      qtAux := edQuant.Text+'.00';

      str:= funcoes.preencheCampo(05, ' ', 'D', NUM_COLETOR)+                //numero do coletor
            funcoes.preencheCampo(QT_TAM+3, ' ', 'D', qtAux ) +               // quantidade
            funcoes.preencheCampo(LOTE_TAM , ' ', 'D', ULTIMO_NUM_LOTE ) +
            funcoes.preencheCampo(16, ' ', 'D', lbEanRecebido.Caption ) +
            funcoes.SohNumeros(dateTimeToStr(now));

      funcoes.GravaLinhaEmUmArquivo(ARQ_CONTAGEM, str);
      limpaItens();
      lbItens.ItemIndex := lbItens.Count-1;
   end
   else
   begin
      edEan.Text := '';
      edQuant.Text := '0';
      edEan.SetFocus();
   end;
end;

procedure TfmMain.tratarQuantidade();
begin
   if ( CONTAGEM_UNITARIA = true ) then
   begin
      edQuant.Text := '1';
      gravaContagem();
   end
   else
      edQuant.SetFocus();
end;

procedure TfmMain.edEanKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   if (Key = VK_RETURN) then
      if ( Length(edEan.Text) >= 12 ) then
      begin
         edDescricao.Text := 'Pesquisando...';
         edDescricao.Refresh;

      // verifica se ocodigo e cadastrado de acordo com as regras cadastradas
         ehCodigoCadastrado();

          if ( IDX_COD_CADASTRADO > 0 )then
         begin
             if (CONTAGEM_UNITARIA  = true ) then
             begin
               edQuant.Text := '1';
               gravaContagem();
             end
             else
               tratarQuantidade()
         end
         else // codigos cadastrados
         begin
            if ( ACEITA_PROD_INVALIDO = false ) then
            begin
               edQuant.Text := '0';
               edEan.SetFocus();
               edEan.SelectAll();
            end
            else
               tratarQuantidade();
         end
      end
      else
      begin
         msgTela2('', 'Tamanho fora do padrão', mb_ok );
         edEan.SetFocus;
         edEan.SelectAll();
      end;
end;


procedure TfmMain.desabilitaItens;
begin
   edEan.Visible := false;
   edQuant.Visible := false;
   edQuant.LabelDefs.Caption := '';
   edDescricao.Visible := false;
   lbItens.Visible := false;
   lbItens.LabelDefs.Visible:= false
end;

procedure TfmMain.habilitaItens;
begin
   edEan.Visible := true;
   edQuant.Visible := true;
   edDescricao.Visible := true;
   lbItens.Visible := true;
   edQuant.LabelDefs.Caption := 'Quantidade';
   edQuant.LabelDefs.Visible := true;
end;


procedure TfmMain.NovaCaptura1Click(Sender: TObject);
begin
   if verificaSenhas.telaAutorizacaoSimples(SENHA,'confcaptura') = SENHA then
   begin
      desabilitaItens();
      application.CreateForm(TfmNovaContagem, fmNovaContagem);
      fmNovaContagem.Show;
   end
end;

procedure TfmMain.limpaItens();
begin
   edQuant.Text := '';
   edEan.Text := '';
   lbEanRecebido.Caption := '';
   edDescricao.Text := '';
   edEan.SetFocus();
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (msgTela2('', 'Sair?', mb_YesNo ) <> mrOK) then
     CanClose:= false;
end;

procedure TfmMain.Mudarlote1Click(Sender: TObject);
begin
   if (fmNovoLote = nil) then
   begin
      Application.CreateForm(TfmNovoLote, fmNovoLote);
      fmNovoLote.edNovoLote.Text :=  ULTIMO_NUM_LOTE;
      fmNovoLote.ShowModal();

      if (fmNovoLote.ModalResult = mrOk) then
      begin
        ULTIMO_NUM_LOTE := fmNovoLote.edNovoLote.Text;
        edEan.SetFocus();
      end;
      fmNovoLote := nil;
   end;
end;

procedure TfmMain.getLotes;
var
   arq:TstringList;
   j,i:integer;
   isLoteCadastrado:boolean;
begin
   arq := TStringList.Create();
   if ( FileExists(ARQ_CONTAGEM) = false) then
      arq.SaveToFile(ARQ_CONTAGEM);

   arq.LoadFromFile(ARQ_CONTAGEM);
   if (arq.Count-1 > 0) then
   begin
      if (LOTES = nil) then
         LOTES := TStringList.Create();

      for i:=0 to arq.Count -1 do
      begin
         isLoteCadastrado := false;
         for j:= 0 to LOTES.Count-1 do
            if trim( copy(arq[i],19,05) ) = LOTES[j] then
            begin
               isLoteCadastrado := true;
               break;
            end;

         if isLoteCadastrado = false then
            LOTES.Add( trim(copy(arq[i],19,05)))
      end;
      ULTIMO_NUM_LOTE:= LOTES[lotes.Count-1];
   end
   else
      ULTIMO_NUM_LOTE:= '1'
end;


procedure TfmMain.edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) and (edQuant.Value > 0 ) then
   begin
      if(IDX_COD_CADASTRADO > -1 ) then
        gravaContagem()
      else
      begin
         if (ACEITA_PROD_INVALIDO = TRUE) then

            gravaContagem()
         else
         begin
            edQuant.Text := '0';
            edEan.Text := '';
            edEan.SetFocus;
            edEan.SelectAll();
         end;
      end;
   end;
end;

procedure TfmMain.mostraContagem;
var
  arq:TstringList;
  i:integer;
begin
   screen.Cursor := crHourGlass;
   arq:= tStringList.Create();
   arq.LoadFromFile(ARQ_CONTAGEM);

   lbItens.Clear();
   for i:= 0 to arq.Count -1 do
      lbItens.Items.Add('L:' +  TRIM(copy(arq[i], LOTE_POS_INI,LOTE_TAM)) +
                        ' P:' + copy(arq[i],29,15) +
                        ' Q:' + copy(arq[i],QT_POS_INI , QT_TAM)
                        );
   screen.Cursor := crDefault;
end;

procedure TfmMain.preparaParaMostrarContagem;
begin
   desabilitaItens();
   lbItens.Visible := true;
   mostraContagem();
   NovaCaptura1.Enabled := false;
   Mudarlote1.Enabled := false;
   mnTotais.Enabled := false;   
   NovaCaptura2.Caption := 'Contagem';
   NovaCaptura2.tag := 1;
end;

procedure TfmMain.preparaParaCapturar;
begin
   habilitaItens();
   lbItens.Clear();
   NovaCaptura1.Enabled := true;
   Mudarlote1.Enabled := true;
   mnTotais.Enabled := true;
   NovaCaptura2.Caption := 'Ver itens';
   NovaCaptura2.tag := 0;
   edEan.SetFocus();
end;

function TfmMain.getTotalLote(nLote: String): String;
var
   arq:TStringList;
   i:integer;
   itens,qt:real;
   qtAux:String;
begin
   qt:=0;
   itens := 0;
   arq:= TstringList.Create();
   arq.LoadFromFile(ARQ_CONTAGEM);
   for i:=0 to arq.Count -1 do
   begin
      if (trim(copy(arq[i], LOTE_POS_INI, LOTE_TAM)) = nLote) then
      begin
         qtAux := copy(arq[i], QT_POS_INI, QT_TAM);
         while pos('.00',qtAux) > 0 do delete(qtAux, pos('.00',qtAux),3);
         qt := qt+ StrToFloat('0'+ trim(qtAux) ) ;
         itens := itens+1;
      end;
   end;
   result :=  'Itens: ' + floatToStr(itens) + '    Qt: '+ FloatToStr(qt);
end;


procedure TfmMain.mnTotaisClick(Sender: TObject);
var
   i:integer;
begin
   SCREEN.Cursor := crHourGlass;
   if (LOTES = nil) then
      LOTES := TStringList.Create();

   LOTES.Clear();
   getLotes();
   logar('---------------------------');
   if (LOTES <> nil) then
      for i:=0 to LOTES.Count -1 do
         logar('Lt: '+ LOTES[I] + ': ' + getTotalLote( lotes[i]) );
   lbItens.ItemIndex := lbItens.Count-1;
   SCREEN.Cursor := crDefault;
end;

procedure TfmMain.lbItensDblClick(Sender: TObject);
var
   arq: TStringList;
begin
   if ( NovaCaptura2.Tag = 1) and (MsgTela2('','Deleta esse item?', MB_ICONERROR + MB_YESNO) = mrOk )then
   begin
      arq := TstringList.create();
      arq.LoadFromFile(ARQ_CONTAGEM);
      ARQ.Delete(lbItens.ItemIndex);
      lbItens.DeleteSelected;
      arq.SaveToFile(ARQ_CONTAGEM);
      arq.Destroy();
   end;
end;

procedure TfmMain.ajustaLote(num: String);
begin
   ULTIMO_NUM_LOTE := num;
end;

procedure TfmMain.NovaCaptura2Click(Sender: TObject);
begin
   if (NovaCaptura2.Tag = 0) and (verificaSenhas.telaAutorizacaoSimples(SENHA,'') = SENHA) then
      preparaParaMostrarContagem()
   else
      preparaParaCapturar();
end;

procedure TfmMain.apagarLote(numLote: String);
var
  ent,sai:Tstringlist;
  qt,i:integer;
begin
   screen.Cursor := crHourGlass;
   ent := TStringList.Create();
   sai := TStringList.Create();
   qt:=0;

   ent.LoadFromFile(ARQ_CONTAGEM);
   for i:=0 to ent.Count -1  do
   begin
      if  trim( copy(ent[i],LOTE_POS_INI,LOTE_TAM)) = trim(numLote) then
         qt := qt+1
      else
         sai.Add(ent[i]);
   end;
   ent.Destroy();
   sai.SaveToFile(ARQ_CONTAGEM);
   SAI.Destroy();
   MsgTela2('','Foram removidos ' + IntToStr(qt) + ' itens.',0 );
   lbItens.Items.Clear();
   screen.Cursor := crDefault;
end;


procedure TfmMain.DeletarLote1Click(Sender: TObject);
var
   numLote:String;
begin
   desabilitaItens();
   if (fmNovoLote = nil) then
   begin
      Application.CreateForm(TfmNovoLote, fmNovoLote);
      fmNovoLote.Caption := 'Lote a apagar';
      fmNovoLote.ShowModal();

      if (fmNovoLote.ModalResult = mrOk) then
      begin
        numLote := fmNovoLote.edNovoLote.Text;
        if (numLote <>'') then
           apagarLote(numLote);
      end;
      fmNovoLote := nil;
   end;
   habilitaItens();
   edEan.SetFocus();
end;

procedure TfmMain.edEanExit(Sender: TObject);
begin
   if (CONTAGEM_UNITARIA = true) and (edDescricao.Visible = true) then
   begin
     edEan.SetFocus;
     edEan.SelectAll();
   end;
end;

procedure TfmMain.edDescricaoEnter(Sender: TObject);
begin
   edEan.SetFocus;
   edEan.SelectAll();
end;

procedure TfmMain.edEanKeyPress(Sender: TObject; var Key: Char);
begin
   if (key in ['a'..'z', 'A'..'Z', '~', '´', '^', '/', '?', ',',   '.', '<', '>', '@', '$', '%', '!', '"', '&' ] = true)  then
     key := #0;
end;

end.

