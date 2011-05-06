unit uTabela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, adLabelComboBox, adLabelEdit,
  TFlatButtonUnit, funcoes, Grids, DBGrids, SoftDBGrid, ExtCtrls, DBClient,
  Provider,clipbrd, ComCtrls, AppEvnts, comObj, mxExport, TFlatCheckBoxUnit,
  TFlatComboBoxUnit,funcsql, mxOneInstance, RpBase, RpSystem, RpRave,
  RpDefine, RpCon, RpConDS;

type
  TfmTabela = class(TForm)
    edCodigo: TadLabelEdit;
    cbPreco01: TadLabelComboBox;
    edDescricao: TadLabelEdit;
    Query: TADOQuery;
    FlatButton1: TFlatButton;
    cbLoja: TadLabelComboBox;
    dbgrid: TSoftDBGrid;
    DataSource1: TDataSource;
    cbItens: TRadioGroup;
    RgOrdem: TRadioGroup;
    rgTpestoque: TadLabelComboBox;
    Animate: TAnimate;
    Panel1: TPanel;
    btImprime: TFlatButton;
    cbTpImp: TadLabelComboBox;
    cbPreco02: TadLabelComboBox;
    Querycodigo: TStringField;
    Querydescricao: TStringField;
    QueryestoqueAtual: TIntegerField;
    QueryPreco01: TFloatField;
    QueryPreco02: TFloatField;
    FlatButton3: TFlatButton;
    cbOrder: TFlatCheckBox;
    Queryqt_emb: TBCDField;
    EdLocalImp: TadLabelEdit;
    tpPapel: TadLabelComboBox;
    Querycd_pes: TIntegerField;
    cbTotaliza: TFlatCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    lbTotal1: TLabel;
    lbTotal2: TLabel;
    FlatButton2: TFlatButton;
    function GetNumLojas(sender: tobject): Tstrings;
    procedure FlatButton1Click(Sender: TObject);
    function GetNomeLojas(sender: tobject): Tstrings;
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbItensClick(Sender: TObject);
    procedure MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer);
    procedure btImprimeClick(Sender: TObject);
    procedure dbgridCellClick(Column: TColumn);
    procedure PesquisaCodigos(sender:tobject);
    procedure cbTpImpChange(Sender: TObject);

    procedure GerarMapaSeparacao(sender: tobject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbTotalizaClick(Sender: TObject);
    procedure CalculaTotais(Sender:Tobject);
    procedure dbgridTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTabela: TfmTabela;

implementation

uses uMain;

{$R *.dfm}

function TfmTabela.GetNumLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := fmMain.Conexao;
   query.SQL.Clear;
   query.SQL.Add('Select DS_TIPOPRECO, tp_preco from ttpco with(NoLock) ');
   query.Open;

   aux := TstringList.create();
   query.First;

   while query.Eof = false do
   begin
      aux.add(query.Fields[0].AsString+query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;

   AUX.ADD('Preco de custo                                     1');
   AUX.ADD('Custo ultima compra                               10');

// descricao do 01 ao 50
//is_uo do 51 ao 58
end;

function TfmTabela.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := fmMain.Conexao;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from zcf_tbuo with(Nolock) where TP_ESTOQUE in (1,2) order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;

procedure tfmTabela.PesquisaCodigos(sender:tobject);
var
  OrdenaFornecedor:string;
begin
  SCREEN.CURSOR := crhourglass;
  fmMain.MsgStatus('');
  animate.Visible:= true;
  Animate.Active:= true;

  if cbOrder.Checked = true then
     OrdenaFornecedor := '1'
  else
     OrdenaFornecedor := '0';

   Query.SQL.Clear;
   query.SQL.Add('Exec Z_CF_Tabela_Estoque ' +
                  '@is_ref ='+ QuotedStr (edCodigo.text) + ', ' +
                  '@cd_desc ='+ quotedstr(edDescricao.text)  + ', ' +
                  '@uo ='+ funcoes.getCodUO(cbLoja) +' , '+
                  '@pc01='+ funcoes.SohNumeros((copy(cbPreco01.Items[cbPreco01.ItemIndex],40,100))) +' , '+
                  '@pc02='+ funcoes.SohNumeros((copy(cbPreco02.Items[cbPreco02.ItemIndex],40,100))) +' , '+
                  '@itens='+ intToStr(cbItens.ItemIndex)+ ' , ' +
                  '@ordem='+ intToStr(RgOrdem.ItemIndex)+ ' , ' +
                  '@tpEstoque='+ intToStr(RgTpEstoque.ItemIndex)+ ' , ' +
                  '@ordenafornecedor='+ OrdenaFornecedor
                );
   query.SQL.SaveToFile(funcoes.TempDir()+ 'Query_tabelaPrecos.tmp');
   query.Open;
   cbTotalizaClick(Sender);   
   animate.Visible:= false;
   Animate.Active:= false;
   edCodigo.SetFocus;
   cbpreco01.SetFocus;
   edCodigo.SetFocus;
   dbgrid.Columns[0].Width := 75;
   dbgrid.Columns[1].Width := 350;
   dbgrid.Columns[2].Width := 80;
   dbgrid.Columns[03].Width :=50;
   dbgrid.Columns[04].Width := 80;
   dbgrid.Columns[05].Width := 80;

   if query.IsEmpty = false then
      if query.RecordCount = 1 then
          fmMain.MsgStatus( inttostr(query.RecordCount) + ' Item')
      else
          fmMain.MsgStatus(inttostr(query.RecordCount) + ' Itens');

   SCREEN.CURSOR := crDefault;
end;

procedure TfmTabela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = vk_f7 then
      FlatButton1Click(Sender);
end;

procedure TfmTabela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := Cafree;
   fmMain.fecharForm(fmTabela, Action);
   fmTabela := nil;
end;

procedure TfmTabela.cbItensClick(Sender: TObject);
begin
   if cbItens.ItemIndex >0 then
   begin
      edDescricao.Visible := true;
      edDescricao.SetFocus;
   end
   else
   begin
      edDescricao.Visible := false;
      edCodigo.SetFocus;
   end;

end;


procedure TfmTabela.MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer); //sender:tobject);
var
   params, dest:TstringList;
   linha:string;
   l,Fl:integer;
   codForn:string;
begin
   dest:=  TStringList.create();
   Fl := 0; l := 0;

   if nLinPorPagina = 0 then
      nLinPorPagina := 50
   else
      nLinPorPagina := 70;

   dbgrid.visible := false;
   Query.First;
   while query.Eof = false do
   begin
      inc(fl);
      Dest.Add('                          *** TABELA DE PRECOS  ***                                     FL:' + funcoes.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('Loja: ' + copy(cbLoja.Items[cbLoja.itemindex],01,30) ) ;
      Dest.Add('Preco 01 : ' + copy(cbPreco01.items[cbPreco01.ItemIndex],01,30 )  +'   Preco 02 : ' + copy(cbPreco02.items[cbPreco02.ItemIndex],01,30 )  );
      Dest.Add('Codigo: ' + edCodigo.text);
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('CODIGO    DESCRICAO                                        ESTOQUE CAIXA  '+ copy(cbPreco01.items[cbPreco01.ItemIndex],01,10 )  +' '+ copy(cbPreco02.items[cbPreco02.ItemIndex],01,10) );
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < nLinPorPagina ) and ( query.eof = false ) do
      begin
         if cbOrder.Checked = true then
            if codForn <> Query.fieldByname('cd_pes').AsString then
            begin
               dest.Add('');
               codForn := Query.fieldByname('cd_pes').AsString;
               inc(l);
               linha := 'Fornecedor :' + FuncSql.GetValorWell('O',' Select NM_FANTASI from dspes where cd_pes = ' + codForn, 'NM_FANTASI', fmMain.Conexao );
               dest.Add(linha );
            end;


         linha :=
            funcoes.preencheCampo(10,' ', 'd', Query.fieldByname('codigo').Asstring) +
            funcoes.preencheCampo(45,' ', 'd', copy(Query.fieldByname('descricao').Asstring,01,45 )) +
            funcoes.preencheCampo(10,' ', 'e', Query.fieldByname('estoqueatual').Asstring)+
            funcoes.preencheCampo(02,' ', 'e', ' ' ) +
            funcoes.preencheCampo(06,' ', 'e', Query.fieldByname('QT_EMB').Asstring) +
            funcoes.preencheCampo(12,' ', 'e', floattostrf(Query.fieldByname('preco 01').AsFloat,ffNumber,18,2)) +
            funcoes.preencheCampo(12,' ', 'e', floattostrf(Query.fieldByname('preco 02').AsFloat,ffNumber,18,2));


         begin
            inc(l);
            dest.Add(linha );
         end;
         query.next;
      end;
      if ( query.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPorPagina ) do
         begin
            Dest.Add('');
            inc(l);
         end;
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('                                                                             Por Walter Carvalho');
      end;
   end;
   Dest.SaveToFile( ExtractFilePath(ParamStr(0)) + '\Tabela.tmp');
   query.First;

   dbgrid.visible := true;

   if cbtpImp.ItemIndex = 1 then
   begin
      linha :=  pchar('cmd.exe /c print /d:'+ EdLocalImp.Text +' '+ExtractFilePath(ParamStr(0)) + 'Tabela.tmp' );
      if Application.MessageBox('  Prepare a impressora imprimir.....    Confirma a impressão ?        ','', mb_iconquestion+mb_yesno) = mrYes then
         WinExec(pchar(linha),sw_normal);
   end
   else
   begin
      params := TStringList.Create();
      {0}params.Add( fmMain.getDescPreco(cbPreco01) );
      {1}params.Add( fmMain.getDescPreco(cbPreco02) );
      {2}params.Add(trim( edCodigo.text));
      {3}params.Add(copy( rgOrdem.Items[rgordem.ItemIndex],02,20));
      {4}params.Add( fmMain.getDescUO(cbLoja) );
      fmMain.impressaoRaveQr( Query, 'rpTabela', params );
   end;
end;


procedure TfmTabela.btImprimeClick(Sender: TObject);
begin
   MontarRelatorioImpressao(Sender, tpPapel.ItemIndex ); //
end;

procedure TfmTabela.dbgridCellClick(Column: TColumn);
begin
   clipboard.AsText := query.FieldByName('codigo').AsString;
end;

procedure TfmTabela.cbTpImpChange(Sender: TObject);
begin
   case  cbTpImp.ItemIndex of
      0,2: EdLocalImp.Visible := false
   else
     EdLocalImp.Visible := true;
   end;
end;


procedure TfmTabela.GerarMapaSeparacao(sender: tobject);
var
  Excel : Variant;
  Linha:integer;
begin
   screen.Cursor := crHourGlass;
   dbgrid.Visible := False;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'TabelaModelo.xls');
   Excel.WorkBooks[1].Sheets[1].Cells[02,02]:= trim( edCodigo.text);
   Excel.WorkBooks[1].Sheets[1].Cells[02,04]:= trim( DateTimeToStr(now));
   Excel.WorkBooks[1].Sheets[1].Cells[04,04]:= trim(copy(cbPreco01.Items[cbPreco01.ItemIndex],01,15));
   Excel.WorkBooks[1].Sheets[1].Cells[04,05]:= trim(copy(cbPreco02.Items[cbPreco02.ItemIndex],01,15));
   Linha:=5;
   While Query.Eof = false do
   Begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,1]:= trim(Query.fieldByname('codigo').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,2]:= trim(Query.fieldByname('descricao').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,3]:= trim(Query.fieldByname('estoqueAtual').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,4]:= floattostrf(  Query.fieldByname('preco 01').asfloat ,ffNumber,18,2);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,5]:= floattostrf(  Query.fieldByname('preco 02').asfloat ,ffNumber,18,2);
      query.Next;
      inc(Linha);
   end;
   Query.First;
   Excel.Visible :=True;

   screen.Cursor := crDefault;
   dbgrid.Visible := true;
end;
procedure TfmTabela.FlatButton3Click(Sender: TObject);
begin
   funcsql.exportaQuery(Query, false,'');
end;

procedure TfmTabela.Timer1Timer(Sender: TObject);
begin
   if animate.Active = true then
      fmTabela.Refresh;
end;


procedure TfmTabela.FlatButton1Click(Sender: TObject);
begin
   if length(edCodigo.Text) >= 3 then
      PesquisaCodigos(sender)
   else if  application.MessageBox(pchar('Deseja mesmo gerar de todos os fornecedores  ???' +#13),pchar(fmTabela.caption), mb_YesNo + mb_iconQuestion)= mrYes then
      PesquisaCodigos(sender)
end;



procedure TfmTabela.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_Return then
      FlatButton1Click(Sender)
end;

procedure TfmTabela.CalculaTotais(Sender: Tobject);
var
  t1,t2:real;
begin
   if ( query.IsEmpty = false  )   then
   begin
      dbgrid.Visible := false;
      query.First;
      if cbTotaliza.Checked = true then
      begin
         t1:=0;
         t2:=0;
         while query.Eof = false do
         begin
            t1:= t1 + query.fieldByname('Preco 01').asFloat * query.fieldByname('estoqueAtual').asFloat ;
            t2:= t2 + query.fieldByname('Preco 02').asFloat * query.fieldByname('estoqueAtual').asFloat;
            query.Next;
         end;
         lbTotal1.Caption := FloatToStrF( t1,ffnumber,18,02);
         lbTotal2.Caption := FloatToStrF( t2,ffnumber,18,02);
       end;
       dbgrid.Visible := true;
   end;
end;

procedure TfmTabela.cbTotalizaClick(Sender: TObject);
begin
  if (cbTotaliza.Checked = true) then
     calculaTotais(Sender);
end;
procedure TfmTabela.dbgridTitleClick(Column: TColumn);
begin
   screen.Cursor := crhourglass;
   funcsql.OrganizarQuery(query,column);
   screen.Cursor := crDefault;   
end;


procedure TfmTabela.FormCreate(Sender: TObject);
begin
   cbpreco01.Items := funcsql.getListaPrecos( fmMain.Conexao, true, true, true, fmMain.getGrupoLogado() );
   cbPreco02.Items := cbPreco01.Items;

//   cbLoja.items :=  funcsql.GetNomeLojas(fmMain.Conexao,false,false,'','');
   funcoes.carregaCampos(fmTabela);

   fmMain.getListaLojas(cbLoja, false, false, '');
end;

end.

