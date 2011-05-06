unit uClassificaProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelNumericEdit,
  ADODB, Grids, DBGrids, Mask, adLabelMaskEdit,funcoes, DBCtrls,
  adLabelDBLookupListBox, adLabelDBLookupComboBox, SoftDBGrid, mxExport,
  CheckLst, adLabelCheckListBox, fCtrls, funcsql, TFlatGaugeUnit;

type
  TfmClassificaProd = class(TForm)
    Query1: TADOQuery;
    FlatButton1: TFlatButton;
    DataSource1: TDataSource;
    edit1: TadLabelEdit;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    Query2: TADOQuery;
    Label2: TLabel;
    Query3: TADOQuery;
    DataSource3: TDataSource;
    DBGrid3: TSoftDBGrid;
    DBGrid4: TSoftDBGrid;
    DBGrid5: TSoftDBGrid;
    DataSource4: TDataSource;
    Query4: TADOQuery;
    DataSource5: TDataSource;
    Query5: TADOQuery;
    clb1: TadLabelCheckListBox;
    FlatButton2: TFlatButton;
    Query6: TADOQuery;
    cbListaClassificado: TfsComboBox;
    Label1: TLabel;
    FlatButton3: TFlatButton;
    Barra: TFlatGauge;
    cbDiversos: TfsCheckBox;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure clb1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure Classifica(sender:tobject);
    procedure edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure MarcaProdutoComoClassificado(Sender:tobject;is_ref:string);
    procedure FlatButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmClassificaProd: TfmClassificaProd;

implementation

uses uMain;

{$R *.dfm}


procedure TfmClassificaProd.clb1Click(Sender: TObject);
begin
   funcsql.getQuery(fmMain.Conexao, query2, ' select c.cd_campo, D.ds_vcampo from tvcom D, cccom C where  c.cd_vcampo = d.cd_vcampo and d.cd_campo=c.cd_campo and c.cd_chave = ' + quotedStr(funcoes.tiraEspaco(copy(clb1.Items[clb1.Itemindex],110,10))));
   dbgrid2.Columns[0].Title.caption := 'NIVEL';
   dbgrid2.Columns[0].Width := 50;
   dbgrid2.Columns[1].Title.caption := 'DESCRIÇÃO';
   dbgrid2.Columns[1].Width := 150;
end;

procedure TfmClassificaProd.FormActivate(Sender: TObject);
begin
   edit1.setfocus;
end;

procedure TfmClassificaProd.FormCreate(Sender: TObject);
begin
   query3.Active := true;
end;

procedure TfmClassificaProd.DBGrid3CellClick(Column: TColumn);
begin
   query4.sql.clear;
   query4.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =2 and cd_vcampopai = '+ quotedStr(DBGrid3.Fields[0].AsString ) + '  order by ds_vcampo');
   query4.Open;
end;

procedure TfmClassificaProd.DBGrid4CellClick(Column: TColumn);
begin
   query5.sql.clear;
   query5.SQL.add('select cd_vcampo, ds_vcampo  from tvcom  where cd_campo =3 and cd_vcampopai = '+ quotedStr(DBGrid4.Fields[0].AsString ) + '  order by ds_vcampo');
   query5.Open;
end;


procedure TfmClassificaProd.FlatButton1Click(Sender: TObject);
begin
   SCREEN.Cursor := CrHourGlass;
   begin
     {  preencher os campos da tablea zcf_ClassificacaoCrefe  }
      funcsql.GetValorWell( 'E', 'insert into zcf_ClassificacaoCrefe select is_ref,0, null from crefe where is_ref > (select max(is_ref) from zcf_ClassificacaoCrefe)  ', '', fmMain.Conexao );
      clb1.Items.Clear();



      query1.sql.clear;
      query1.SQL.add(' select crefe.cd_ref, crefe.ds_ref, Coalesce(zcf_ClassificacaoCrefe.DataClassificacao,''          '' )as DataClassificacao, ' +
                     ' crefe.is_ref from crefe with(NoLock) '+
                     ' inner join zcf_ClassificacaoCrefe on crefe.is_ref = zcf_ClassificacaoCrefe.is_ref '
                    );
// aqui é para mostrar somente a classificacao diversos
      if (cbDiversos.Checked = true) then
      query1.SQL.add(' inner join cccom with(nolock) on crefe.is_ref = cccom.cd_chave ' +' and cccom.cd_campo =1 and cccom.cd_vcampo = ''0001'' ');
{}

      Case cbListaClassificado.ItemIndex of
         0: query1.SQL.add(' and zcf_ClassificacaoCrefe.isClassificado = 0 ');
         1: query1.SQL.add(' and zcf_ClassificacaoCrefe.isClassificado = 1 ');
      end;
      query1.SQL.add(' where crefe.cd_ref like '+ quotedstr(edit1.text+ '%') + ' order by crefe.ds_ref');
      query1.SQL.SaveToFile('c:\teste.txt');
      query1.Open;

      query3.Open;

      Query1.First;
      while query1.Eof = false do
      begin
         clb1.Items.Add(
                        query1.FieldByname('cd_ref').AsString + ' - ' +
                        funcoes.preencheCampo(69,' ','d', query1.FieldByname('ds_ref').AsString ) +'- '+
                        query1.FieldByname('DataClassificacao').AsString  +'                  '+
                        query1.FieldByname('is_ref').AsString
                      );
        query1.Next;
     end;
   end;
   SCREEN.Cursor := CRdEFAULT;
end;

procedure  tfmClassificaProd.MarcaProdutoComoClassificado(Sender:tobject;is_ref:string);
var
  aux:string;
begin
    query6.SQL.clear;
    aux := 'update zcf_ClassificacaoCrefe set isClassificado = 1, DataClassificacao = ' +
            QuotedStr(DateToStr(now)) +' where is_ref = ' +
            quotedStr(is_ref);
    query6.sql.add( aux );
    funcoes.GravaLinhaEmUmArquivo('ClassificaProdutos_query.txt',aux);
    query6.ExecSQL;
end;

procedure tfmClassificaProd.Classifica(sender:tobject);
var
   i:integer;
   aux:string;
begin
   DeleteFile('ClassificaProdutos_query.txt');
   barra.Visible := true;
   barra.MaxValue := clb1.Items.Count ;
   for i:= 0 to clb1.Items.Count -1 do
   begin
      barra.Progress := i;
      if clb1.Checked[i] = true then
      begin
// deletar a classificacao atual
         aux:= '';

         query6.SQL.clear;
         aux := 'Delete from  cccom where cd_chave =' + quotedstr( funcoes.tiraEspaco( copy(clb1.items[i],110,10)));
         query6.sql.add( aux );
         funcoes.GravaLinhaEmUmArquivo('ClassificaProdutos_query.txt',aux);
         query6.ExecSQL;


         query6.SQL.clear;
         aux := 'Insert cccom values ('+ funcoes.tiraEspaco( copy(clb1.items[i],110,10) ) +', 1, ' + quotedStr(dbgrid3.Fields[0].asString) + ')';
         query6.sql.add( aux );
         funcoes.GravaLinhaEmUmArquivo('ClassificaProdutos_query.txt',aux);
         query6.ExecSQL;

         query6.SQL.clear;
         aux := 'Insert cccom values ('+ funcoes.tiraEspaco( copy(clb1.items[i],110,10) ) +', 2, ' + quotedStr(dbgrid4.Fields[0].asString) + ')' ;
         query6.sql.add(aux);
         funcoes.GravaLinhaEmUmArquivo('ClassificaProdutos_query.txt',aux);
         query6.ExecSQL;

         query6.SQL.clear;
         aux := 'Insert cccom values ('+ funcoes.tiraEspaco( copy(clb1.items[i], 110,10) ) +', 3, ' + quotedStr(dbgrid5.Fields[0].asString) + ')';
         query6.sql.add( aux );
         funcoes.GravaLinhaEmUmArquivo('ClassificaProdutos_query.txt',aux);
         query6.ExecSQL;

         MarcaProdutoComoClassificado(sender, funcoes.tiraEspaco( copy(clb1.Items[i],110,10))  );
      end;
   end;
   query2.Close;
   query3.Close;
   query4.Close;
   query5.Close;
   query6.Close;
   clb1.Items.Clear;
   barra.Visible := false;
end;



procedure TfmClassificaProd.edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
     FlatButton1Click(Sender);
end;

procedure TfmClassificaProd.FlatButton3Click(Sender: TObject);
var
   i:integer;
   selecionado:boolean;
   erro:string;
begin
   erro :='';
   selecionado := false;
   for i:= 0 to clb1.Items.count -1 do
     if clb1.Checked[i] = true then
       selecionado := true;

   if selecionado = false then
     erro:= ' - Nenhum item foi escolhido'+#13;

   if erro <> '' then
      showmessage('Confira antes os itens ' + #13 + erro)
   else
   if application.MessageBox(pchar('Deseja confimar essa classificação ? '), pchar(''), mb_yesNo + mb_Iconquestion   ) = mrYes then
   begin
      barra.Visible := true;
      barra.MaxValue := clb1.Items.Count -1;
      for i:= 0 to clb1.Items.Count -1 do
      begin
         barra.Progress := i;
         if clb1.Checked[i] = true then
            MarcaProdutoComoClassificado(sender, funcoes.tiraEspaco( copy(clb1.Items[i],110,10)) );
      end;
      clb1.Items.Clear;
      barra.Visible := false;      
   end;
end;

procedure TfmClassificaProd.FlatButton2Click(Sender: TObject);
var
   i:integer;
   selecionado:boolean;
   erro:string;
begin
   erro :='';

   selecionado := false;
   for i:= 0 to clb1.Items.count -1 do
     if clb1.Checked[i] = true then
       selecionado := true;

   if selecionado = false then
     erro:= ' - Nenhum item foi escolhido'+#13;

   if query5.IsEmpty = true then
      erro:= erro + ' - Selecione as classes ';

   if erro <> '' then
      showmessage('Confira antes os itens ' + #13 + erro)
   else
   if application.MessageBox(pchar('Confirma a classificação para:'+#13+#13+ ' - '+dbgrid3.fields[1].AsString+#13+ ' - '+dbgrid4.fields[1].AsString+#13+ ' - '+dbgrid5.fields[1].AsString ), pchar(''), mb_yesNo + mb_Iconquestion   ) = mrYes then
   begin
      Classifica(sender);
   end;
end;


procedure TfmClassificaProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmClassificaProd := nil;
end;

end.
