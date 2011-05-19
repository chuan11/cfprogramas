unit uMapa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, funcoes, ComCtrls, Grids, DBGrids, SoftDBGrid, funcsql,
  TFlatButtonUnit, StdCtrls, Buttons, fCtrls, ExtCtrls, TFlatPanelUnit, verificaSenhas;

type
  TfmMapa = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    tb: TADOTable;
    pnTitulo: TFlatPanel;
    lbNumMp: TLabel;
    Label2: TLabel;
    lbDtAvaria: TLabel;
    Label5: TLabel;
    lbNome: TLabel;
    Label6: TLabel;
    mmObs: TfsMemo;
    Label3: TLabel;
    lbStatus: TLabel;
    MainMenu1: TMainMenu;
    Nova1: TMenuItem;
    Abrir1: TMenuItem;
    Salvar1: TMenuItem;
    Aprovar1: TMenuItem;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    lbAprovador: TLabel;
    lbCriador: TLabel;
    PopupMenu1: TPopupMenu;
    Resumodeestoquedaslojas1: TMenuItem;
    Listarentradasdoproduto1: TMenuItem;
    Vendasnoperiodo1: TMenuItem;
    Resumoentradassaidas1: TMenuItem;
    Label8: TLabel;
    Imprimir1: TMenuItem;
    lbCodCriador: TLabel;
    Verrequisicoes1: TMenuItem;
    cbCriticaQuant: TfsCheckBox;
    Inserir1: TMenuItem;

    function errosDeSeparacao(Sender:Tobject):Boolean;
    function GeraRequisicoes(Sender:Tobject; autorizador:String):String;
    function validaQuantidade(Sender:Tobject; alteraValores,mostraErro:boolean):boolean;
    procedure Abrir1Click(Sender: TObject);
    procedure Aprovar1Click(Sender: TObject);
    procedure CarregaMapa(nMapa:String);
    procedure criarTabela(Sender:Tobject);
    procedure CriaTabelaTemporaria(Sender:Tobject);
    procedure fecharMapa();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure gridColEnter(Sender: TObject);
    procedure gridColExit(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridTitleClick(Column: TColumn);
    procedure Imprimir1Click(Sender: TObject);
    procedure insereItem(codigo:String);
    procedure Inserir1Click(Sender: TObject);
    procedure liberaEdicaoMapa();
    procedure Listarentradasdoproduto1Click(Sender: TObject);
    procedure Nova1Click(Sender: TObject);
    procedure Resumodeestoquedaslojas1Click(Sender: TObject);
    procedure salvaMapa();
    procedure Salvar1Click(Sender: TObject);
    procedure tbAfterOpen(DataSet: TDataSet);
    procedure tbBeforePost(DataSet: TDataSet);
    procedure vendasNoPeriodo1Click(Sender: TObject);
    procedure verRequisicoes1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMapa: TfmMapa;
  criticaQuantidade,alterada:Boolean;
  PERMITE_EDITAR:boolean;

implementation

uses uCriaMapa, uMain, fmAbrirAvarias, uCF ;

{$R *.dfm}

function TfmMapa.validaQuantidade(Sender: Tobject; alteraValores,mostraErro:boolean): boolean;
var
   soma,i:integer;
   erro:String;
begin
   soma := 0;
   for i := 7  to 18 do
     if tb.Fields[i].AsString <> '' then
        soma := soma + tb.Fields[i].AsInteger;

   if soma > tb.fieldByName('Estoque').asinteger then
      erro := 'A soma dos separados excede a quantidade disponivel.';

   if alteraValores = true then
   begin
      tb.Edit;
      tb.FieldByName('saldo').asInteger := tb.FieldByName('Estoque').asInteger - soma;
      tb.Post;
      alterada := true;
   end;

   if erro <> '' then
   begin
      result := false;
      if mostraErro = true then
         msgTela('',erro,mb_iconerror + MB_OK);
   end
   else
      result := true;
end;

function TfmMapa.errosDeSeparacao(Sender: Tobject): Boolean;
var
   erro:String;
begin
   tb.First;
   while tb.Eof = false do
   begin
      if validaQuantidade(nil,false,false) = false then
        erro := erro + '    - ' +  tb.fieldByName('cd_ref').ASString + ' '+ tb.fieldByName('ds_ref').ASString + #13;
       tb.Next;
   end;
   tb.First;
   if erro <> '' then
   begin
      erro := ' Existem itens com a separacção errada, corrija eles antes: ' +#13 + erro;
      msgTela('',erro, MB_ICONERROR + mb_ok);
      result := true;
   end
   else
     result := false;
end;



procedure TfmMapa.CriaTabelaTemporaria(Sender: Tobject);
var
   nmTb,cmd:String;
begin
   nmTb := funcsql.getNomeTableTemp();

   cmd := ' Create table ' + nmTb + ' ( ' +
          ' Codigo varchar(13) , ' +
          ' Nome varchar(50) , '   +
          ' Est int ' +
          ' )' ;
   funcSql.execSQL( cmd, fmMain.Conexao );
end;

procedure TfmMapa.FormShow(Sender: TObject);
begin
   alterada := false;
end;

procedure TfmMapa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    fmMapa := nil;
    Action := Cafree;
end;

procedure TfmMapa.criarTabela(Sender: Tobject);
var
   nTable, cmd:String;
begin
   if tb.TableName <> '' then
      tb.close;
   nTable := funcSQl.getNomeTableTemp;
   cmd := ' Create table ' + nTable +  '( Seq int, n smallInt, is_ref int, cd_ref varchar(08), ds_ref varchar(50), Caixa int, '+
          ' Estoque int, L01 int , L03 int , L05 int , L06 int , L07 int , L08 int , L09 int , L10 int , L11 int ,'+
          ' L12 int , L17 int , L18 int , Saldo int , Pco money )';
   funcsql.execSQL(cmd, fmMain.Conexao);
   tb.TableName := nTable;
   tb.Open;
end;

procedure TfmMapa.insereItem(codigo:String);
var
   dsItem:TdataSet;
   numMapa,cmd:String;
begin
   dsItem :=  uCF.getDadosProd(fmMain.getUoLogada(), codigo, '5');
   if ( dsItem.IsEmpty=false ) then
   begin
      numMapa := lbNumMp.Caption;
      tb.Cancel();
      cmd :=  'insert zcf_mapaSeparacaoI(num, is_ref, caixa, estI,saldo,pco) values (' +
              lbNumMp.Caption  + ' , ' +
              dsItem.FieldByName('is_ref').AsString + ' , ' +
              dsItem.FieldByName('embalagem').AsString + ' , ' +
              dsItem.FieldByName('EstoqueDisponivel').AsString + ' , ' +
              dsItem.FieldByName('EstoqueDisponivel').AsString + ' , ' +
              ValorSql(dsItem.FieldByName('preco').AsString) +')';
       funcSql.execSQL(cmd, fmMain.Conexao);
       Salvar1Click(nil);
       fecharMapa();
       CarregaMapa(numMapa);
   end;
end;

procedure TfmMapa.CarregaMapa(nMapa:String);
var
   qr:TADOQuery;
   j,i:integer;
   lista:Tstringlist;
begin
   criarTabela(nil);
   qr := TADOQuery.Create(nil);
   qr.Connection := tb.Connection;
   qr.SQL.Clear;
   qr.SQL.Add(' select num ,nome , data ,nm_usu  , ehfinalizada, case when aprovador is not null then (select nm_usu from dsusu (nolock) where cd_usu = aprovador ) ' +
              ' else '''' end as Aprovador, historico, criticaEstoque , l01, l03, l05, l06, l07,  l08, l09, l10, l11, l12,  l17, l18, criador  from zcf_mapaSeparacao (nolock) inner join dsusu on criador = cd_usu  where num = ' + nMapa);
   qr.Open;

   lbNumMp.Caption :=  funcoes.preencheCampo(10,' ','e', qr.fieldByName('num').asString );
   lbNome.Caption :=  qr.fieldByName('nome').asString;
   lbDtAvaria.caption := qr.fieldByName('data').asString;
   lbCriador.Caption := qr.fieldByName('nm_usu').asString;
   lbAprovador.Caption := qr.fieldByName('aprovador').asString;
   lbCodCriador.Caption :=qr.fieldByName('criador').asString;

   mmObs.Lines.Clear;
   mmObs.Lines.Add( qr.fieldByName('historico').asString);

   if qr.fieldByName('ehFinalizada').AsBoolean = false then
   begin
      lbStatus.Caption := 'Aberta';
      grid.Enabled := true;
   end
   else
   begin
      lbStatus.Caption := 'Finalizada';
      mmObs.Enabled:=false;
      grid.Enabled := false;
   end;

   cbCriticaQuant.Checked := (qr.fieldByName('criticaEstoque').AsBoolean);




   if (fmMain.getUserLogado() = fmMain.GetParamBD('mapa.usAutEdicao','') ) or( fmMain.getGrupoLogado() <> '')  then
   begin
      PERMITE_EDITAR := true;
      Inserir1.Enabled := true;
   end
   else
      PERMITE_EDITAR := false;


   lista := TStringList.Create();

   for i:=0 to qr.FieldCount-1 do
   begin

      if copy(qr.Fields[i].FieldName,01,01) = 'l' then
         if qr.Fields[i].AsString = 'False' then
            lista.Add(qr.Fields[i].FieldName);
    end;

// esonder as lojas que nao foram escolhidas
   for i:=0 to grid.Columns.Count -1 do
   begin
      for j:=0 to lista.Count-1 do
         if grid.Columns[i].Title.Caption = UpperCase(lista[j]) then
            grid.Columns[i].Visible := false;
   end;

   // carregar os itens
   while tb.IsEmpty = false do
      tb.Delete;

   qr.SQL.Clear;
   qr.SQL.Add('select i.seq, c.is_ref, c.cd_ref, c.ds_ref, i.Caixa, i.estI as Estoque, i.L01, i.L03, i.L05, i.L06, i.L07, i.L08, i.L09, i.L10, i.L11, i.L12, i.L17, i.L18, i.Saldo,i.pco '+
              ' from zcf_mapaSeparacaoI i (nolock) inner join crefe c (nolock) on i.is_ref = c.is_ref where i.num = '+nMapa);
   qr.Open;
   qr.First;

   while qr.Eof = false do
   begin
      tb.AppendRecord([
                       qr.FieldByName('seq').asString,
                       '0',
                       qr.FieldByName('is_ref').asString,
                       qr.FieldByName('cd_ref').asString,
                       qr.FieldByName('ds_ref').asString,
                       qr.FieldByName('caixa').asString,
                       qr.FieldByName('Estoque').asString,
                       qr.FieldByName('l01').asString,
                       qr.FieldByName('l03').asString,
                       qr.FieldByName('l05').asString,
                       qr.FieldByName('l06').asString,
                       qr.FieldByName('l07').asString,
                       qr.FieldByName('l08').asString,
                       qr.FieldByName('l09').asString,
                       qr.FieldByName('l10').asString,
                       qr.FieldByName('l11').asString,
                       qr.FieldByName('l12').asString,
                       qr.FieldByName('l17').asString,
                       qr.FieldByName('l18').asString,
                       qr.FieldByName('saldo').asString,
                       qr.FieldByName('pco').asString
                     ]);
      qr.Next;
   end;
   qr.Close;
   tb.First;
   tb.Edit;

   grid.Columns[0].visible := false;
   grid.Columns[1].visible := false;
   grid.Columns[2].visible := false;

   grid.Columns[3].Title.Caption := 'Codigo';
   grid.Columns[4].Title.Caption := 'Produto';

   for i:=0 to grid.Columns.Count -1 do
     grid.Columns[i].Title.font.style := [fsbold];

   alterada := false;
// ajustar o tamanho da coluna das quantidades
   grid.Columns[3].Width := 50;
   grid.Columns[4].Width := 290;
   grid.Columns[5].Width := 35;
   grid.Columns[6].Width := 55;
   for i:=7 to 18 do
      grid.Columns[i].Width := 35;
   grid.Columns[19].Width := 55;
   grid.Columns[20].Width := 55;
end;

procedure TfmMapa.gridColExit(Sender: TObject);
begin
    if cbCriticaQuant.Checked = false then
       validaQuantidade(nil, true, cbCriticaQuant.Checked );
end;

procedure TfmMapa.tbAfterOpen(DataSet: TDataSet);
begin
   alterada := true;
end;

procedure TfmMapa.salvaMapa;
var
  cmd:String;
begin
   fmMain.MsgStatus('Salvando mapa..');
   tb.First;
// ajuste para atualizar as contagens
   while tb.Eof = false do
   begin
      validaQuantidade(nil, true, cbCriticaQuant.Checked );
      tb.Next;
   end;

   tb.First;
   while tb.Eof = false do
   begin
      cmd := 'Update zcf_mapaSeparacaoI set ';
      if tb.fieldByName('l01').AsString <> '' then
         cmd := cmd + 'l01 = ' + tb.fieldByName('l01').AsString +' , '
      else
         cmd := cmd + 'l01 = null, ';

      if tb.fieldByName('l03').AsString <> '' then
         cmd := cmd + 'l03 = ' + tb.fieldByName('l03').AsString +' , '
      else
         cmd := cmd + 'l03 = null, ';

      if tb.fieldByName('l05').AsString <> '' then
         cmd := cmd + 'l05 = ' + tb.fieldByName('l05').AsString +' , '
      else
         cmd := cmd + 'l05 = null, ';

      if tb.fieldByName('l06').AsString <> '' then
         cmd := cmd + 'l06 = ' + tb.fieldByName('l06').AsString +' , '
      else
         cmd := cmd + 'l06 = null, ';

      if tb.fieldByName('l07').AsString <> '' then
         cmd := cmd + 'l07 = ' + tb.fieldByName('l07').AsString +' , '
      else
         cmd := cmd + 'l07 = null, ';

      if tb.fieldByName('l08').AsString <> '' then
         cmd := cmd + 'l08 = ' + tb.fieldByName('l08').AsString +' , '
      else
         cmd := cmd + 'l08 = null, ';

      if tb.fieldByName('l09').AsString <> '' then
         cmd := cmd + 'l09 = ' + tb.fieldByName('l09').AsString +' , '
      else
         cmd := cmd + 'l09 = null, ';

      if tb.fieldByName('l10').AsString <> '' then
         cmd := cmd + 'l10 = ' + tb.fieldByName('l10').AsString +' , '
      else
         cmd := cmd + 'l10 = null, ';

      if tb.fieldByName('l11').AsString <> '' then
         cmd := cmd + 'l11 = ' + tb.fieldByName('l11').AsString +' , '
      else
         cmd := cmd + 'l11 = null, ';

      if tb.fieldByName('l12').AsString <> '' then
         cmd := cmd + 'l12 = ' + tb.fieldByName('l12').AsString +' , '
      else
         cmd := cmd + 'l12 = null, ';

      if tb.fieldByName('l17').AsString <> '' then
         cmd := cmd + 'l17 = ' + tb.fieldByName('l17').AsString +' , '
      else
         cmd := cmd + 'l17 = null, ';

      if tb.fieldByName('l18').AsString <> '' then
         cmd := cmd + 'l18 = ' + tb.fieldByName('l18').AsString +' , '
      else
         cmd := cmd + 'l18 = null, ';

     cmd := cmd + 'saldo = ' +tb.fieldByName('saldo').AsString + ' where seq = ' + tb.fieldByName('seq').AsString ;

     funcSql.execSQL(cmd, fmMain.Conexao);
     tb.Next;
  end;
  cmd := ' update zcf_mapaSeparacao set historico  = '+ funcoes.getLinhasMemo(mmObs.lines) + ' where num = ' + lbNumMp.caption;
  funcSql.execSQL(cmd, fmMain.Conexao);

  tb.First();
  fmMain.MsgStatus('');
  alterada := false;
end;

procedure TfmMapa.Salvar1Click(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
      salvaMapa();
end;


procedure TfmMapa.Nova1Click(Sender: TObject);
begin
   if alterada = true then
      if MsgTela('','Foram feitas alterações no mapa, deseja salva-las? ', MB_YESNO ) = mrYes then
         Salvar1Click(Sender);
    fecharMapa();
    Application.CreateForm(TfmCriarMapa, fmCriarMapa);
    fmCriarMapa.showModal;
end;

procedure TfmMapa.Abrir1Click(Sender: TObject);
begin
   if fmAbrirAvaria = nil then
   begin
      if alterada = true then
        if MsgTela('','Foram feitas alterações no mapa, deseja salva-las? ', MB_YESNO ) = mrYes then
           Salvar1Click(nil);
      fecharMapa();
      Application.CreateForm(TfmAbrirAvaria, fmAbrirAvaria);
      fmAbrirAvaria.preparaParaListarMapa(nil);
      fmAbrirAvaria.showModal;
   end;
end;

procedure TfmMapa.gridColEnter(Sender: TObject);
begin
   if (PERMITE_EDITAR = false) then
      if (pos('L', tb.Fields[grid.SelectedIndex].FieldName) <> 0 ) then
         grid.SelectedIndex  := 7;
end;

procedure TfmMapa.gridDblClick(Sender: TObject);
begin
   if msgTela('', 'Tem certeza que deseja remover esse item ? ' , MB_ICONQUESTION + MB_YESNO) = mrYes then
   begin
      execSQl('delete from zcf_mapaSeparacaoI where seq = ' + tb.fieldByName('seq').asString , fmMain.Conexao );
      tb.Delete;
   end;
end;

function TfmMapa.GeraRequisicoes(Sender: Tobject; autorizador:String):String;
var
   QT_DIAS_PEND, i:integer;
   tbReq:TADOTable;
   lj,cmd,nTbReq:String;
   uos: array[7..18] of String;
   ocoItens:TStringList;
begin
   QT_DIAS_PEND := strToInt( fmMain.GetParamBD('periodoParaReqPendentes',''));

   ocoItens := TStringlist.Create();
   tbReq := TADOTable.Create(nil);
   tbReq.Connection := fmMain.Conexao;

   nTbReq := funcsql.getNomeTableTemp();
   cmd := ' create table '+ nTbReq + '( seq int identity (1,1), is_ref int, [Qt Pedida] int, codigo varchar(08), ds_ref varchar(50) )' ;
   funcsql.execSQL(cmd, fmMain.Conexao);
   tbReq.TableName := nTbReq;
   tbREq.Open;

   uos[07] := '10033586'; //01
   uos[08] := '10033587'; //03
   uos[09] := '10033588'; //05
   uos[10] := '10033589'; //06
   uos[11] := '10037736'; //07
   uos[12] := '10033591'; //08
   uos[13] := '10033592'; //09
   uos[14] := '10033590'; //10
   uos[15] := '10033593'; //11
   uos[16] := '10033594'; //12
   uos[17] := '10033595'; //17
   uos[18] := '10068438'; //18

   nTbReq := '';
   for i:=7 to 18 do
   begin
      lj := '  '+grid.Fields[i].FieldName + ': ';
      cmd := '';
      tb.First;
      while tb.Eof = false do
      begin

         fmMain.MsgStatus('Gerando Requisicoes loja: ' + grid.Fields[i].FieldName );

         while tbReq.IsEmpty = false do
            tbReq.Delete;

         while (tbReq.RecordCount < 35 ) and (tb.Eof = false )do
         begin
            if ( tb.Eof = false ) and ( tb.Fields[i].AsString <> '' )  and ( tb.Fields[i].AsInteger <> 0 ) then
            begin
               tbReq.Append;
               tbReq.FieldByName('is_ref').AsString :=  tb.FieldByName('is_ref').asString;
               tbReq.FieldByName('codigo').AsString :=  tb.FieldByName('cd_ref').asString;
               tbReq.FieldByName('ds_ref').AsString := tb.FieldByName('ds_ref').asString;
               tbReq.FieldByName('Qt Pedida').AsString :=  tb.Fields[i].AsString ;
               tbReq.post;
               tb.Next;
            end
            else
               tb.Next;
          end;
          if  tbReq.RecordCount <> 0 then
          begin
             cmd := funcsql.gerarRequisicao( fmMain.Conexao, tbReq, uos[i], autorizador, false, true, ocoItens, QT_DIAS_PEND);
             lj:= lj + cmd +'   ';
          end;
      end;
       nTbReq := nTbReq + lj + #13;
   end;

   ocoItens.free;
   msgTela('','Foram Geradas as requisicoes: ' + #13 + nTbReq, MB_OK + MB_ICONEXCLAMATION );
   result := nTbReq;
end;

procedure TfmMapa.gridKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key in [VK_DOWN,VK_UP, VK_LEFT, VK_RIGHT ] then
      gridColExit(nil);
end;
procedure TfmMapa.Aprovar1Click(Sender: TObject);
var
  aut:String;
begin
   if trim(lbStatus.Caption) = 'Aberta' then
      if msgTela('', 'Após a aprovação, são feitas as requisições para o depósito, continua? ', MB_YESNO + MB_ICONQUESTION ) = mrYes then
      begin
         Salvar1Click(nil);
         if errosDeSeparacao(nil) = false then
         begin
            aut := VerificaSenhas.TelaAutorizacao2(fmMain.Conexao, '-1', getParamBD('autorizadoresAvarias','', fmMain.Conexao) + lbCodCriador.Caption);
            if  aut <> '' then
            begin
              aut := 'update zcf_mapaSeparacao set ehFinalizada = 1 , aprovador = '+aut+ ' , historico = ' + funcoes.getLinhasMemo(mmObs.Lines) +
                     ' , requisicoes = ' + quotedStr( GeraRequisicoes(nil, aut) ) +  ' where num = ' + lbNumMp.Caption;
              funcsql.execSQL(aut,fmMain.Conexao);
              CarregaMapa( lbNumMp.Caption);
            end
            else
               fmMain.MsgStatus(lbStatus.Caption);
         end;
     end;
end;


procedure TfmMapa.Resumodeestoquedaslojas1Click(Sender: TObject);
begin
   fmMain.obterResumoEstoque( nil, tb.fieldByName('is_ref').asString, '1');
end;

procedure TfmMapa.Listarentradasdoproduto1Click(Sender: TObject);
begin
   fmMain.obterDetalhesEntrada(nil,   tb.fieldByName('is_ref').asString );
end;

procedure TfmMapa.Vendasnoperiodo1Click(Sender: TObject);
begin
   fmMain.obterDetalhesSaida( nil, tb.fieldByName('is_ref').asString , fmMain.getUoLogada() );
end;

procedure TfmMapa.Imprimir1Click(Sender: TObject);
var
   Param:TStringList;
begin
   if tb.IsEmpty = false then
   begin
      Param := TStringList.Create();
      param.Add(lbNumMp.caption);
      param.Add(lbNome.caption);
      param.Add(lbStatus.Caption);
      param.Add(lbCriador.caption);
      param.Add(lbAprovador.Caption);
      fmMain.impressaoRave(tb, 'rpMapaSep', Param);
   end;
end;

procedure TfmMapa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  result:integer;
begin
    result := 0;
    if alterada = true then
      result := msgTela('',' Salvar as Alterações no mapa?', MB_YESNOCANCEL + MB_ICONQUESTION);

    if result = MrYes then
       Salvar1Click(nil);
    if result = mrCancel then
       CanClose := false;
end;

procedure TfmMapa.fecharMapa();
begin
   tb.Close;
   lbNumMp.Caption := '-';
   lbDtAvaria.caption := '-';
   lbNome.caption := '-';
   lbStatus.Caption := '-';
   lbAprovador.Caption := '-';
   lbCriador.Caption := '-';
   lbCodCriador.Caption := '-';
   mmObs.Clear;
end;

procedure TfmMapa.VerRequisicoes1Click(Sender: TObject);
begin
   if tb.IsEmpty = false then
      fmMain.requisicoesPorProduto(nil, tb.FieldByName('is_ref').asString);
end;

procedure TfmMapa.gridTitleClick(Column: TColumn);
begin
   OrganizarTabela(tb, Column);
end;

procedure TfmMapa.tbBeforePost(DataSet: TDataSet);
begin
    if tb.FieldByName('is_ref').AsString = '' then
     tb.Cancel;
end;

procedure TfmMapa.liberaEdicaoMapa;
var
   i:integer;
begin
   for i := 0 to grid.Columns.Count -1 do
      grid.Columns[i].ReadOnly :=  false;
end;


procedure TfmMapa.Inserir1Click(Sender: TObject);
var
  str:String;
begin
   str:= InputBox('','Digite o Código do produto ou EAN.',str);
   if (str <> '') then
      insereItem(str);
end;


end.

