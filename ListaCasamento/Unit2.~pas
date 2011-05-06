unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, Mask, DBCtrls,
  adLabelDBEdit, adLabelComboBox, adLabelMaskEdit,funcoes, adLabelListBox,
  ExtCtrls,  TFlatButtonUnit, SoftDBGrid, adLabelDBLookupComboBox, ComCtrls,
  adLabelDBDateTimePicker, adLabelDBComboBox, adLabelEdit, Menus,funcsql,
  fCtrls;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    DBEdit1: TadLabelDBEdit;
    DBEdit2: TadLabelDBEdit;
    DBEdit5: TadLabelDBEdit;
    DBedit6: TadLabelDBEdit;
    DBedit7: TadLabelDBEdit;
    Dbedit8: TadLabelDBEdit;
    Dbedit11: TadLabelDBEdit;
    dbEdNumLista: TadLabelDBEdit;
    Panel1: TPanel;
    Lb1: TadLabelListBox;
    lb2: TadLabelListBox;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn3: TFlatButton;
    BitBtn4: TFlatButton;
    BitBtn5: TFlatButton;
    BitBtn6: TFlatButton;
    bitBtn1: TFlatButton;
    bitbtn2: TFlatButton;
    Query2: TADOQuery;
    DBGrid1: TSoftDBGrid;
    dBDT1: TadLabelDBDateTimePicker;
    DBText1: TDBText;
    dbedit13: TadLabelDBEdit;
    PopupMenu1: TPopupMenu;
    Abrirestalista1: TMenuItem;
    ImprimirEstalista1: TMenuItem;
    cbTpLista: TadLabelComboBox;
    dbEdTpLista: TadLabelDBEdit;
    edCEP: TadLabelDBEdit;
    edCodWell: TadLabelDBEdit;
    Imprimirotermodeconcordncia1: TMenuItem;
    edCPF: TadLabelDBEdit;
    pnBusca: TPanel;
    cb1: TComboBox;
    edit1: TadLabelEdit;
    cbLojas: TadLabelComboBox;
    btBusca: TfsBitBtn;
    Adicionarpessoasrelacioandas1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bitBtn1Click(Sender: TObject);
    function verificaPreenchimento(sender: tobject):string;
    procedure desabilitaEdits(sender:tobject);
    procedure HabilitaEdits(sender:tobject);
    procedure BitBtn2Click(Sender: TObject);
    procedure buyytClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure ChamaInclusaiDeItens(sender:tobject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure Dbedit11Exit(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CarregaDadosdaslistas(sender:tobject);
    procedure cbLojasSelect(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Abrirestalista1Click(Sender: TObject);
    procedure ImprimirEstalista1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure imprimeTermo(Sender: Tobject; nRelatorio,numLista: String);
    procedure dbEdNumListaEnter(Sender: TObject);
    procedure cbTpListaChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Imprimirotermodeconcordncia1Click(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Adicionarpessoasrelacioandas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form2: TForm2;
  EhInclusaoDeLista:boolean;
  NmLista,tplista:string[10];
implementation

{$R *.dfm}
uses unit1, unit4, uPRelacionadas;

procedure TForm2.CarregaDadosdaslistas(sender: tobject);
var
   cmd:String;
begin
   desabilitaEdits(sender);
   form1.query1.sql.Clear;
   cmd :=  ('exec stoObterCadastroDeListas2  @dtinicio = ' + form1.InVencLista()+ ' , '+
            '@dtFim =' +  form1.FimVencLista()  + ' , '+
            '@ListaLoja = '+ quotedStr( funcoes.SohNumeros(cblojas.Items[cblojas.ItemIndex])) +' , '+
            '@loja = ' + QuotedStr(form1.RParReg('Loja'))
            );
   form1.query1.sql.add(cmd);
   form1.query1.Open;
   panel1.top:= 03;
   panel1.Left := form2.Width - panel1.Width - 10;

   dbedit1.DataField := 'noiva';
   dbedit2.DataField := 'noivo';
   dbedit5.DataField := 'endEntrega';
   dbedit6.DataField := 'bairro';
   dbedit7.DataField := 'endreferencia';
   dbedit8.DataField := 'observacao';
   dbedit11.DataField := 'foneRes';
   dbEdNumLista.DataField := 'numlista';
   edCEP.DataField := 'CEP';
   dbEdTpLista.DataField :=  'Tipo';
   edCodWell.DataField := 'codWell';
   edCPF.DataField := 'cpf';

   dbedit13.DataField := 'loja';
   dbtext1.DataField := 'Tipo';
   DBDT1.DataField := 'DataCasamento' ;
   DBDT1.MinDate :=  form1.dp1.mindate;

   if form1.RParReg('loja') = '00' then

      dbedit13.visible := true;
    // pegar os valores dos tipos de listas
    cbTpLista.Items := funcSQL.OpenQuery(form1.ADOConnection1, 0, 2, 'select  descricao, aceitaNoivo,CodLista from tipoListas (nolock) where codLista > 0 order by CodLista');
    cbTpLista.ItemIndex := 0;

    form1.LerColunasDbgrid(form2.name,Dbgrid1);
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
   cbLojas.items := form1.GetNumLojas(sender, form1.RParReg('Loja'));
   cbLojas.ItemIndex := 0;
   CarregaDadosdaslistas(sender);
end;

procedure TForm2.desabilitaEdits(sender: tobject);
begin
   dbedit1.enabled := false;
   dbedit2.enabled := false;
   cbTpLista.Enabled := false;
   dbdt1.Enabled :=false;
   dbedit5.enabled := false;
   dbedit6.enabled := false;
   dbedit7.enabled := false;
   dbedit8.enabled := false;
   dbedit11.enabled := false;
   dbedit13.enabled := false;
   dbEdNumLista.Enabled := false;
   edCEP.Enabled := false;
   bitbtn1.Visible := false;
   bitbtn2.Visible := false;
   bitbtn3.Visible := true;
   bitbtn4.Visible := true;
   bitbtn5.Visible := true;
   edCodWell.Enabled := false;
   edCPF.Enabled := false;

   pnBusca.Visible := true;
   dbgrid1.Enabled:= true;
end;

procedure TForm2.HabilitaEdits(sender: tobject);
begin
   dbdt1.DateTime := now;
   dbedit1.enabled := true;
   dbedit2.enabled := true;
   cbTpLista.Enabled := true;
   dbdt1.Enabled := true;
   dbedit5.enabled := true;
   dbedit6.enabled := true;
   dbedit7.enabled := true;
   dbedit8.enabled := true;
   dbedit11.enabled := true;
   dbedit13.enabled := true;
   dbEdNumLista.Enabled := true;
   edCEP.Enabled := true;
   dbEdNumLista.Enabled := true;
   bitbtn1.Visible := true;
   bitbtn2.Visible := true;
   bitbtn3.Visible := false;
   bitbtn4.Visible := false;
   bitbtn5.Visible := false;
   edcodWell.Enabled := true;
   cbTpLista.ItemIndex := -1;
   edCPF.Enabled := true;
   dbedit1.setfocus;
   pnBusca.Visible := false;
end;

function TForm2.verificaPreenchimento(sender: tobject): string;
var
   aux,
   l:string;
begin
   if length(dbedit13.Text) < 2 then
       dbedit13.Text := '0'+ dbedit13.Text;
   l:='';

   if (funcoes.RemAcentos(dbedit1.Text) = true ) or (funcoes.RemAcentos(dbedit2.Text))  = true then l := l + ' - Por favor, não use acentuação no nome da noiva ou do noivo.          ' + #13;
   if cbTpLista.ItemIndex < 0 then l := l+ ' - Falta o tipo da lista.          ' + #13;
   if dbedit1.text = '' then l := l+ ' - Nome da noiva está faltando.          ' + #13;
   if dbedit2.text = '' then l := l+ ' - Nome do noivo está faltando.          ' + #13;
   if pos(' ',dbedit1.text) = 0 then  l := l+ ' - O nome da noiva deve ter ao menos nome e sobrenome.'+ #13;
   if dbedit5.text = '' then  l := l+ ' - Endereço de entrega.'+#13;
   if dbedit6.text = '' then  l := l+ ' - Bairro.'+#13;
   if dbedit7.text = '' then  l := l+ ' - Ponto de referencia. '+#13;
   if dbedit11.text = '' then l := l+ ' - Número do telefone.'+#13;
   if dbedit8.text = '' then  l := l+ ' - Observação é obrigatória.'+#13;
   if length(edCPF.Text) < 11 then l:= l+ ' - É obrigatório preencher o CPF da noiva. '+#13;


   aux := openSQL('Select cast(numlista as varchar(10))+'' ''+noiva as dados from listas where ehAtivo = 1 and cpf = ' + quotedstr(edCPF.Text) +' and tipo = ' + dbEdTpLista.Text, 'dados' , Form1.ADOConnection1 );
   if (aux <> '') and ( EhInclusaoDeLista = true) then
      l := l+ ' - Já exite uma lista desse tipo cadastrada para esse CPF.'+#13 +' '+ aux;

   if l <> '' then
      l := ' Alguns campos estão errados ou incompletos, verifique:    '+#13 + l;

   if funcoes.RParReg('listas','loja') = '00' then
     if MsgTela('', 'Há erros na lista, ignorar erros? ', mb_yesno + mb_iconquestion) = mrYes then
         l := '';
   verificaPreenchimento := l;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FormStyle := fsMDIForm;
   Form1.mostraMenu(sender);
   action := Cafree;
end;

procedure TForm2.bitBtn1Click(Sender: TObject);
begin
   screen.Cursor := crHourGlass;
   if ehinclusaoDeLista=true then
   begin
      if verificaPreenchimento(sender) = '' then
      begin
         TpLista:= dbEdTpLista.Text;
         form1.query1.Post;
         nmlista := dbEdNumLista.text;
         dbgrid1.Enabled := false;
         ChamaInclusaiDeItens(sender);
         CarregaDadosdaslistas(Sender);
      end
      else
        form1.MsgTela(verificaPreenchimento(sender),mb_iconerror+mb_ok);
   end
   else
   begin
      if verificaPreenchimento(sender) = '' then
      begin
         form1.query1.Post;
         desabilitaEdits(sender);
      end
      else
         form1.MsgTela(verificaPreenchimento(sender),mb_iconerror+mb_ok)
   end;
   screen.Cursor := crDefault;   
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
   if form1.EhlistaDaloja(dbgrid1.fields[0].asString,true)  = true then
   begin
      form1.query1.Edit;
      habilitaEdits(sender);
      dbgrid1.Enabled := false;
   end
end;

procedure TForm2.buyytClick(Sender: TObject);
begin
  if (form1.EhlistaDaloja(dbgrid1.fields[0].asString,true)  = true) then
     if( form1.MsgTela(' Deseja relmente excluir essa Lista ?? '+#13 + ' Se houver itens nessa lista eles serão excluídos também.',mb_iconquestion+mb_yesno) = mryes) then
     begin
        funcsql.GetValorWell( 'E', 'Exec stoDeletaLista ' + quotedStr(dbEdNumLista.text ), '@@error', form1.ADOConnection1 );
        form2.Activate;
     end;
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
begin
   Form1.SalvaColDbgrid(form2.name,Dbgrid1);
   Form2.Close;
end;

procedure TForm2.ChamaInclusaiDeItens(sender: tobject);
begin
   if form1.MsgTela('A lista foi incuida.'+ #13+' Gostaria de incluir os itens agora??',mb_iconquestion+mb_Yesno) = mrYes then
   begin
      query2.SQL.Clear;
      query2.SQL.add('exec stoListaSugestao ' +tplista);
      query2.Open;

      query2.First;
      while query2.Eof = false do
      begin
         lb1.Items.Add(' ' + trim(query2.Fields[0].AsString) + ' - '+  copy(query2.Fields[1].AsString,01,25)  );
         query2.Next;
      end;
      panel1.Visible := true;
   end
   else
      BitBtn2Click(Sender);
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
var
   i:integer;
begin
    i := LB1.itemindex;
    if lb1.itemindex > -1 then
    begin
       lb2.Items.add(lb1.items[lb1.itemindex]);
       lb1.items.delete(i);
    end;
    lb1.itemindex := i;
    lb1.setfocus;
end;


procedure TForm2.BitBtn8Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to lb1.items.count - 1 do
      lb2.Items.add(lb1.items[i]);
   lb1.items.clear;
   lb1.setfocus;
end;

procedure TForm2.BitBtn9Click(Sender: TObject);
var
   i:integer;
begin
    i := lb2.itemindex;
    if lb2.itemindex > -1 then
    begin
       lb1.Items.add(lb2.items[lb2.itemindex]);
       lb2.items.delete(i);
    end;
    lb2.itemindex := i;
    lb2.setfocus;
end;

procedure TForm2.BitBtn10Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to lb2.items.count - 1 do
      lb1.Items.add(lb2.items[i]);
   lb2.items.clear;
   lb2.setfocus;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
   desabilitaEdits(sender);
   ehinclusaodelista:= false;
   form1.query1.Cancel;
end;

procedure TForm2.BitBtn12Click(Sender: TObject);
begin
   lb1.Items.Clear;
   lb2.Items.Clear;
   panel1.Visible := false;
   BitBtn2Click(Sender);
end;

procedure TForm2.BitBtn11Click(Sender: TObject);
var
  aux:string;
  i:integer;
begin
   query2.SQL.Clear;
   for i:=0 to lb2.items.count - 1 do
   begin
       aux := lb2.items[i];
       query2.SQL.add('insert into produtos ( numlista,codigo,nomeProduto, Tipo,convidado, isPromocao ) values( '  + quotedStr(nmlista) + ' ,  ' +quotedStr('0000000')         + ' ,  ' + quotedStr(copy(aux,pos(' - ',aux)+3,length(aux)))  + ' ,  ' + quotedStr( copy(aux,pos(' ',aux)+1,pos(' - ',aux)-pos(' ',aux)-1 ) ) + ' ,  ' +quotedstr('')+ ', 0 )');
   end;
   query2.ExecSql;


   form1.atualizaDadosItensLista( inttostr(lb2.items.count),'0','0', nmlista);

   form1.MsgTela('Itens incluidos com Sucesso...',mb_iconexclamation+mb_ok);
   BitBtn12Click(Sender);
end;

procedure TForm2.Dbedit11Exit(Sender: TObject);
begin
    dbedit11.Text := funcoes.FiltraNum(dbedit11.Text,0);
end;

procedure TForm2.cbLojasSelect(Sender: TObject);
begin
   form2.CarregaDadosdaslistas(Sender);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
   form1.PosicaoBotoes(form2);
   bitbtn1.Left := form2.Width - bitbtn1.Width - bitbtn2.Width - 12;
   dbgrid1.Height :=  form2.Height - DBEDIT8.Top - DBEDIT8.Height - 35;
end;

procedure TForm2.Abrirestalista1Click(Sender: TObject);
begin
   if form1.MsgTela('  Deseja fechar essa janela e abrir a lista?  ',MB_YesNo+MB_IconQuestion ) = MrYes then
      form1.AbrirLista(nil,  dbEdNumLista.text);
end;

procedure TForm2.ImprimirEstalista1Click(Sender: TObject);
var
  Numero:String;
begin
   numero := dbEdNumLista.Text;
   form1.AbreFormPesquisa(sender,1); {1 é abrir lista}
   form4.Hide;
   form4.MontaListaEmArquivo(sender,'Impressao', numero );
   form4.Close;
end;

procedure TForm2.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) then
      DBGrid1.Canvas.Brush.Color := clAqua;
end;

procedure TForm2.dbEdNumListaEnter(Sender: TObject);
begin
   bitbtn6.SetFocus;
end;

procedure TForm2.cbTpListaChange(Sender: TObject);
begin
   form1.query1.FieldByName('tipo').AsString :=  funcoes.SohNumeros( COPY(cbTpLista.Items[cbTplista.itemIndex],42,05));
end;

procedure TForm2.DBGrid1TitleClick(Column: TColumn);
begin
   funcsql.OrganizarQuery(form1.query1,column);
end;

procedure TForm2.imprimeTermo(Sender: Tobject; nRelatorio,numLista: String);
var
   qr:TAdoQuery;
   param:TStringList;
begin
   funcsql.getQuery( Form1.ADOConnection1, qr, 'Select top 01 * from listas where numLista = '  + numLista ) ;
   param := TStringList.Create();
   param.Add( trim(form1.GetParamBD('horarioTrocas', form1.RParReg('loja'))));
   param.Add( qr.fieldByName('cpf').asString  );
   param.Add( qr.fieldByName('cep').asString  );

   Form1.impressaoRave( qr, nRelatorio, param );
end;


procedure TForm2.Imprimirotermodeconcordncia1Click(Sender: TObject);
begin
   if form1.EhlistaDaloja(form1.Query1.fieldbyName('loja').asString, true) = true then
      if form1.GetParamBD('imprimelistaMaison', form1.RParReg('loja')) = '1' then
        imprimeTermo( nil, 'rpTermoMaison' , form1.Query1.fieldbyName('numLista').asString  )
      else
        imprimeTermo( nil, 'rpTermo' , form1.Query1.fieldbyName('numLista').asString );
end;



procedure TForm2.btBuscaClick(Sender: TObject);
var
  campo:string;
begin
  case cb1.itemindex of
     0:campo := 'noiva';
     1:campo := 'noivo';
     2:campo := 'numlista';
  end;
   form1.Query1.Locate(campo, edit1.text,[loPartialKey]);
   edit1.Clear;
   edit1.setfocus;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
   EhInclusaoDeLista := true;
   form1.query1.Append;
   habilitaEdits(sender);
   dbgrid1.Fields[0].AsString := funcoes.RParReg('listas','loja');
   dbgrid1.Fields[5].AsString := DateToStr(now);
   dbgrid1.Fields[4].AsString := dateToStr( dbdt1.DateTime);
   dbedit1.SetFocus;
   dbgrid1.Enabled:= false;
end;

procedure TForm2.Adicionarpessoasrelacioandas1Click(Sender: TObject);
begin
   Application.CreateForm( TfmPRelacionadas, fmPRelacionadas);
   fmPRelacionadas.CarregaPessoasRelacionadas(nil, Form1.Query1.fieldByname('numLista').asString);
   fmPRelacionadas.ShowModal();
end;

end.

