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
    Query: TADOQuery;
    dbgrid: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    btImprime: TFlatButton;
    cbTpImp: TadLabelComboBox;
    Querycodigo: TStringField;
    Querydescricao: TStringField;
    QueryestoqueAtual: TIntegerField;
    QueryPreco01: TFloatField;
    QueryPreco02: TFloatField;
    FlatButton3: TFlatButton;
    Queryqt_emb: TBCDField;
    EdLocalImp: TadLabelEdit;
    tpPapel: TadLabelComboBox;
    Querycd_pes: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    lbTotal1: TLabel;
    lbTotal2: TLabel;
    Panel2: TPanel;
    edCodigo: TadLabelEdit;
    cbPreco01: TadLabelComboBox;
    cbPreco02: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    rgTpestoque: TadLabelComboBox;
    edDescricao: TadLabelEdit;
    cbItens: TRadioGroup;
    cbOrder: TFlatCheckBox;
    cbTotaliza: TFlatCheckBox;
    pnCategoria: TPanel;
    lbNivel: TLabel;
    lbVlCat: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    btGetCategorias: TFlatButton;
    FlatButton1: TFlatButton;
    Animate: TAnimate;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbItensClick(Sender: TObject);
    procedure MontarRelatorioImpressao(Sender:tobject; nLinPorPagina:integer);
    procedure btImprimeClick(Sender: TObject);
    procedure dbgridCellClick(Column: TColumn);
    procedure PesquisaCodigos(sender:tobject);
    procedure cbTpImpChange(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cbTotalizaClick(Sender: TObject);
    procedure CalculaTotais(Sender:Tobject);
    procedure dbgridTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btGetCategoriasClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTabela: TfmTabela;

implementation

uses uMain, uCF, cf;

{$R *.dfm}
procedure tfmTabela.PesquisaCodigos(sender:tobject);
begin
  SCREEN.CURSOR := crhourglass;
  fmMain.MsgStatus('');
  animate.Visible:= true;
  Animate.Active:= true;

  uCF.listaTabelaPrecos( cbItens.ItemIndex,
                         rgTpestoque.ItemIndex,
                         edDescricao.text,
                         edCodigo.Text,
                         funcoes.getCodUO(cbLoja),
                         funcoes.getCodPc(cbPreco01),
                         funcoes.getCodPc(cbPreco02),
                         lbNivel.caption,
                         lbVlCat.caption, Query);
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

   if (query.IsEmpty = false) then
      if query.RecordCount = 1 then
          fmMain.MsgStatus( inttostr(query.RecordCount) + ' Item')
      else
          fmMain.MsgStatus(inttostr(query.RecordCount) + ' Itens');

   SCREEN.CURSOR := crDefault;
//  fmMain.Conexao.CommandTimeout := 30;
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
      if Application.MessageBox('  Prepare a impressora imprimir.....    Confirma a impress�o ?        ','', mb_iconquestion+mb_yesno) = mrYes then
         WinExec(pchar(linha),sw_normal);
   end
   else
   begin
      params := TStringList.Create();
      {0}params.Add( fmMain.getDescPreco(cbPreco01) );
      {1}params.Add( fmMain.getDescPreco(cbPreco02) );
      {2}params.Add(trim( edCodigo.text));
      {3}params.Add('');
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
   cbpreco01.Items := cf.getListaPrecos( true, true, true, fmMain.getGrupoLogado() );
   cbPreco02.Items := cbPreco01.Items;
   funcoes.carregaCampos(fmTabela);
   uCF.getListaLojas(cbLoja, false, false, '');
end;

procedure TfmTabela.btGetCategoriasClick(Sender: TObject);
var
  descCat01, descCat02, descCat03, vlNivel, vlCat: String;
begin
   fmMain.ajustaValoresCategorias(descCat01, descCat02, descCat03, vlNivel, vlCat);
   lbClasse1.Caption := descCat01;
   lbClasse2.Caption := descCat02;
   lbClasse3.Caption := descCat03;
   lbNivel.Caption := vlNivel;
   lbVlCat.Caption := vlCat;
end;

end.

