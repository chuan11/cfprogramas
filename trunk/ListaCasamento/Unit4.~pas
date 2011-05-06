unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, adLabelEdit, DB, ADODB, Grids, DBGrids,
  adLabelComboBox, funcoes, TFlatButtonUnit, RpDefine, RpRave,
  RpCon, RpConDS, RpBase, RpSystem, SoftDBGrid, RpRender, RpRenderText,
  RpRenderPDF, mxExport, fCtrls,funcsql;
type
  TForm4 = class(TForm)
    DataSource1: TDataSource;
    Edit1: TadLabelEdit;
    CBox2: TadLabelComboBox;
    cbox1: TadLabelComboBox;
    query2: TADOQuery;
    Export1: TmxDataSetExport;
    BitBtn1: TFlatButton;
    BitBtn2: TFlatButton;
    btCancela: TFlatButton;
    CB1: TadLabelComboBox;
    Query3: TADOQuery;
    RvSystem1: TRvSystem;
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    DBGrid1: TSoftDBGrid;
    RvDataSetConnection2: TRvDataSetConnection;
    QueryImpressao: TADOQuery;
    cbBuscaNum: TfsCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CarregaDadosParaRelatorio(sender:tobject;num: string);
    Function  AjustaFolhas(x:String):String;
    function  AjustaLinha(tp,cd,vl,ds,cv:string): string;
    procedure MontaListaEmArquivo(Sender:tobject;Acao: String; numlista:string);
    procedure MontarRelatorioImpressao(Sender:tobject;arquivo:string);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    acao:integer;
    { Public declarations }
  end;

var
  Form4: TForm4;
implementation

uses unit1,unit3,unit2;

{$R *.dfm}

function TForm4.AjustaLinha(tp,cd,vl,ds,cv:string): string;
var
   aux:string;
begin
   aux := aux + '       '+ funcoes.preencheCampo(20,' ','D',tp);
   if cd = '0000000' then
      aux := aux +  funcoes.preencheCampo(12,' ','D', ' ')
   else
      aux := aux + funcoes.preencheCampo(12,' ','D', cd );

   vl := funcoes.StrToMoney(vl);
   if  vl = '0,00' then
      vl :='';
   aux :=  aux + funcoes.preencheCampo(11,' ','D', vl);

   aux := aux +  funcoes.preencheCampo(35,' ','D', copy(DS,01,35) );

   if pos('____',cv) > 0 then
      aux := aux +'  '+ '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ '
   else
      aux := aux +'  '+ cv;

   Ajustalinha := aux;
end;

Function tform4.AjustaFolhas(x:String):String;
begin
    while pos( ' ', x ) > 0 do delete( x ,pos(' ', x ),1);
    while length( x ) < 3 do insert('0', x, 1 );
    AjustaFolhas:= x;
end;

procedure TForm4.MontarRelatorioImpressao(Sender:tobject;arquivo:string); //sender:tobject);
var
   dest:TstringList;
   aux, linha:string;
   nLinPag,l,Fl:integer;
begin
   dest:=  TStringList.create();
   Fl := 0;
   l := 0;
   nLinPag := 45;

   dest.Add(#15);

   Query2.First;
   while query2.Eof = false do
   begin
      inc(fl);
      aux := form1.RParReg('TitRel');
//*********************** cabecalho     ******************************************************

      while length(linha) < (66 { meio da folha} - (length(aux) div 2 )) do
         linha := ' ' + linha;

      linha := linha + form1.RParReg('TitRel') + DateToStr(Now);
      while length(linha) < 132 do
      insert(' ',linha, pos(DateToStr(Now),linha) );
      dest.add(linha); linha:='';

      while length(linha) < (66   - (length(trim(query3.Fields[11].AsString) ) div 2 )) do
         linha := ' ' + linha;
      linha := linha + query3.Fields[11].AsString + 'PAGINA:'+AjustaFolhas( inttoStr(Fl) );
      while length(linha) < 132 do
          insert( ' ', linha, (pos('PAGINA:'+ AjustaFolhas(inttoStr(Fl)) ,linha)) );

      dest.Add(linha); linha := '';
      Dest.Add('');
      Dest.Add('ITEMS A SEREM IMPRESSOS: ' + cbox1.items[cbox1.itemindex] + '                            ORDENADO POR: ' +cbox2.items[cbox2.itemindex]);
      Dest.Add('--------------------------------------------------------[ DADOS  DA LISTA ]---------------------------------------------------------');
      Dest.Add('LISTA NUM : ' + query3.FieldByName('NumLista').AsString );
      Dest.Add('NOIVA: ' + query3.Fields[1].AsString + '        NOIVO: ' + query3.Fields[2].AsString  + '   DATA DO EVENTO: '+ query3.Fields[6].AsString );
      Dest.Add('ENDERECO DE ENTREGA: '+query3.FieldByName('endEntrega').AsString + '     BAIRRO: '+  query3.Fields[4].AsString );
      Dest.Add('PONTO DE REFERENCIA: '+query3.Fields[8].AsString );
      Dest.Add('OBSERVACAO: ' + query3.fieldByName('Observacao').AsString);
      Dest.Add('-------------------------------------------------------[ DADOS DOS PRODUTOS ]-------------------------------------------------------');
      Dest.Add('         TIPO              CODIGO       VALOR     DESCRICAO                          CONVIDADO');
      Dest.Add('');

      while ( l < nLinPag ) and ( query2.eof = false ) do
      begin
         inc(l);
         Dest.Add(AjustaLinha(query2.FieldByname('tipo').AsString, query2.FieldByname('codigo').AsString, query2.FieldByname('valor').AsString, query2.FieldByname('nomeProduto').AsString, query2.FieldByname('convidado').AsString ));
         query2.next;
      end;
      if ( query2.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPag ) do
         begin
            Dest.Add('');
            inc(l);
         end;
         Dest.Add('------------------------------------------------------------------------------------------------------------------------------------');
         Dest.Add('                                                                                                            GLC '+ form1.RParReg('Versao') +' Walter Carvalho');
         Dest.Add('');
      end;
   end;
   Dest.SaveToFile(ARQ_DE_IMPRESSAO);
end;

procedure TForm4.CarregaDadosParaRelatorio(sender:tobject;num: string);
begin
   query3.SQL.clear;
   query3.SQL.add('Select L.NumLista, L.Noiva, L.Noivo, L.EndEntrega, L.Bairro, L.FoneRes, L.DataCasamento, L.EndReferencia, L.DataLista, L.Loja, L.Observacao, T.Descricao from Listas L, TipoListas T where L.Tipo = CodLista and L.Numlista = ' + quotedStr(num) );
   query3.open;

   query2.SQL.Clear;
   query2.SQL.Add('Exec stoMontaListaImprimir ' + num +', '+ IntToStr(CBox1.itemIndex) +', '+ IntToStr(CBox2.itemIndex) );
   query2.open;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
   form4.top := form1.top + 50;
   form4.Left := form1.left+50;
   acao:= form1.acao;
   edit1.setfocus;
   cb1.Items := form1.GetTiposListas(true,'');
   cb1.itemIndex := 0;
   case acao of
      1:form4.caption := 'Abrir uma lista';
      2:begin
           form4.caption := 'Imprimir uma lista';
           cbox1.Visible:= true;
           cbox2.Visible:= true;
        end;
   end;
end;

procedure TForm4.btCancelaClick(Sender: TObject);
begin
  form1.query1.sql.clear;
  dbgrid1.DataSource.destroy;
   form4.Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
   QueryImpressao.sql.clear;
   QueryImpressao.sql.Add('Exec stoObterCadastroDeListasResumo2 ' +
                           '@dtinicio = ' + form1.InVencLista() +' , '+
                           '@dtFim = '    + form1.fimVencLista() +' , '+
                           '@loja = '     + quotedStr(form1.RParReg('Loja')) +' , '+
                           '@tipo = '     + quotedStr(funcoes.tiraEspaco(copy(cb1.items[cb1.ItemIndex],40,20))) +' , '+
                           '@nome = '     + quotedStr(edit1.text)
                          );

    if cbBuscaNum.Checked= true then
       QueryImpressao.sql.Add(' , @NumLista = ' + Funcoes.SohNumeros(edit1.Text) );

   QueryImpressao.open;
   edit1.setfocus;
   dbgrid1.enabled:=true;
end;

procedure TForm4.MontaListaEmArquivo(Sender:tobject;Acao: String; numlista:string);
var
   arqImpressao:TstringList;
begin
  funcoes.gravaLog('MontaListaEmArquivo()');

  CarregaDadosParaRelatorio(sender, numlista );

   if query2.IsEmpty = true then
      form1.msgtela(' Não existe nenhum item cadastrado para esta lista.',mb_iconerror+ Mb_iconExclamation)
   else
   begin
      if acao = 'Impressao' then
      begin
         if Pos('D', upperCase(funcoes.RParReg('listas','TipoImp')) ) > 0 then
         begin
            rvproject1.ProjectFile := ExtractFilePath(ParamStr(0)) + 'EspelhoLista.rav';
            rvproject1.SetParam('NmEmpresa',funcoes.RParReg('listas','TitRel')              ) ;
            rvproject1.SetParam('tpLista', trim(query3.Fields[11].AsString) ) ;
            rvproject1.SetParam('TpItens', Cbox1.Items[Cbox1.Itemindex]);
            rvproject1.SetParam('TpOrdem', Cbox2.Items[Cbox2.Itemindex]);
            rvproject1.SetParam('TpVersao',funcoes.RParReg('listas','Versao')   );
            rvproject1.SetParam('ArqLogo' ,funcoes.RParReg('listas','ArqLogo')   );
            rvproject1.ExecuteReport('rpEspelhoLista');
         end
         else
         begin
            MontarRelatorioImpressao(sender, ARQ_DE_IMPRESSAO);
            if form1.MsgTela('  Prepare a impressora imprimir. Continua ?           ', mb_iconquestion+mb_yesno) = mrYes then
            begin
               if (pos('I', upperCase(funcoes.RParReg('listas','TipoImp')) ) > 0) then
                  winExec(pchar('prFile32.exe espelholista.txt'), sw_hide)
               else
               begin
                  arqImpressao := TStringList.Create();
                  arqImpressao.Add('cmd.exe /c print /d:'+ form1.RParReg('PortaImp')+' '+ARQ_DE_IMPRESSAO) ;
                  arqImpressao.Add('pause');
                  arqImpressao.SaveToFile( ExtractFilePath(ParamStr(0)) + 'ImpMatricial.bat');
                  winExec(pchar('cmd /c ImpMatricial.bat'), sw_normal);
               end;
            end;    {/ c encerrado  /k mantem}
         end;
      end;
   end;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
   if not(QueryImpressao.IsEmpty) then
   begin
      case form1.acao of
         01:form3.chamaCarregamentoDeLista(dbgrid1.Fields[0].asString );
         02:MontaListaEmArquivo(sender,'Impressao', queryImpressao.fieldByname('NumLista').asString );
      end;
      queryImpressao.Close;
      query2.Close;
      query3.Close;
      btCancelaClick(Sender);
   end
   else
      form1.MsgTela('     Escolha uma lista antes.     ',mb_iconerror+mb_ok);
end;

procedure TForm4.DBGrid1DblClick(Sender: TObject);
begin
   BitBtn2Click(Sender);
end;

procedure TForm4.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key  = vk_return then
      BitBtn1Click(Sender)
end;

procedure TForm4.DBGrid1TitleClick(Column: TColumn);
begin
   funcSQL.OrganizarQuery(Queryimpressao, column);
end;

end.




