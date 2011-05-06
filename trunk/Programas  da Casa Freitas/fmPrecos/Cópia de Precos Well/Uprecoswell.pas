unit Uprecoswell;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adLabelEdit, adLabelNumericEdit, StdCtrls, TFlatEditUnit,
  DBCtrls, Mask, adLabelDBEdit, DB, ADODB, ComCtrls,
  adLabelDBDateTimePicker, Grids, DBGrids,Clipbrd, adLabelDBComboBox,
  adLabelComboBox, TFlatGaugeUnit, Menus, TFlatButtonUnit,
  CheckLst, adLabelCheckListBox,funcoes,funcSql, fCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Connection: TADOConnection;
    Edit1: TadLabelEdit;
    edit2: TadLabelEdit;
    edit3: TadLabelNumericEdit;
    Query: TADOQuery;
    sg: TStringGrid;
    CB1: TadLabelComboBox;
    Edit4: TadLabelEdit;
    EDIT5: TadLabelEdit;
    MainMenu1: TMainMenu;
    Gerardeumpedido1: TMenuItem;
    FlatButton2: TFlatButton;
    Parametros1: TMenuItem;
    Panel1: TPanel;
    clb1: TadLabelCheckListBox;
    clb2: TadLabelCheckListBox;
    clb3: TadLabelCheckListBox;
    Gauge: TFlatGauge;
    Date1: TfsDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    function AjustaPreco(valor,percentual:string):string;
    procedure GeraSQL(is_ref,tpPreco,UO,Valor,cd_ref:string);
//    procedure GeraSQL(Cod,tpPreco,UO,Valor:string);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AjustaSg1(sender:tobject);
    procedure limpaCampos(sender:tobject);
    procedure sgSelectCell(Sender: TObject; ACol, ARow: Integer;  var CanSelect: Boolean);
    procedure sgDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure limpasg1(sender:tobject);
    function  AchaItem(sender:tobject;codigo:string):boolean;
//    procedure Button3Click(Sender: TObject);
    procedure Gerardeumpedido1Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure CarregaListaLojas(sender:tobject);
    procedure SaLvaListaLojas(Sender:tobject);
    procedure Parametros1Click(Sender: TObject);
    procedure clb1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
     is_oap: real;
     Is_alp:real;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PATH:String;
  ARQ_INI:STRING;
  LinhaSg:integer;
implementation

uses Unit2, Unit1;

{$R *.dfm}

procedure TForm1.limpaCampos(sender: tobject);
begin
   edit1.text:= '';
   edit2.text:= '';
   edit3.text:= '';
   clipboard.AsText :='';
   edit1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and( FileExists('UpGrade.exe' ) ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   arq_ini := extractFilePath(paramStr(0)) + 'lancaprecoswell.ini';
   Path := ExtractFilePath(ParamStr(0)) ;

   Connection.Connected := false;
   connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini');
   connection.Connected :=  TRUE;

   date1.Date := (now)+1;
   AjustaSg1(sender);
   edit4.text := funcoes.lerParam( ARQ_INI ,00);
   edit5.text := funcoes.lerParam( ARQ_INI ,01);
   CarregaListaLojas(sender);

   form1.Width := sg.left +sg.width +20;
   form1.Top := 1;
   form1.left := 100;
   Form1.caption := '(5) Módulo para lançamento de preços.    ' + connection.DefaultDatabase;

   clb1.LabelDefs.Caption := 'Lojas '+ funcoes.lerParam( ARQ_INI ,14);
   clb2.LabelDefs.Caption := 'Lojas '+ funcoes.lerParam( ARQ_INI ,15);
   clb3.LabelDefs.Caption := 'Lojas '+ funcoes.lerParam( ARQ_INI ,16);

   edit3.LabelDefs.caption := '&'+funcoes.lerParam( ARQ_INI ,14);
   edit4.LabelDefs.caption := 'Perc '+ funcoes.lerParam( ARQ_INI ,15);
   edit5.LabelDefs.caption := 'Perc '+ funcoes.lerParam( ARQ_INI ,16);
end;

function tform1.AchaItem(sender:tobject;codigo:string):boolean;
begin
   query.sql.clear;
   if length(edit1.text) = 13 then
      query.SQL.add('select C.is_ref, C.ds_ref from crefe C, dscbr D where d.is_ref = c.is_ref and d.cd_pesq= '+quotedStr(codigo) )
   else
      query.SQL.add('select is_ref, ds_ref from crefe where cd_ref = '+quotedStr(codigo) );
   query.open;
   query.First;
   if query.Fields[0].AsString <> '' then
      AchaItem := true
   else
      AchaItem := false;
end;


procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if key = vk_return then
    begin
       if AchaItem(sender,edit1.text)= true then
       begin
          edit2.text := query.Fields[1].AsString;
          edit3.setfocus;
       end
       else
       begin
          application.MessageBox('Produto não cadastrado',pchar(form1.caption),mb_iconError + mb_ok);
          limpaCampos(sender);
       end;
    end;
end;

procedure TForm1.edit3KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
    if key = vk_return then
    begin
       SG.Cells[1, SG.RowCount -1 ] := edit1.text;
       SG.Cells[2, SG.RowCount -1 ] := edit2.text;
       SG.Cells[3, SG.RowCount -1 ] :=  AjustaPreco( edit3.text , '1,00' );
       SG.Cells[4, SG.RowCount -1 ] :=  AjustaPreco( edit3.text , '1,'+EDIT4.TEXT );
       SG.Cells[5, SG.RowCount -1 ] :=  AjustaPreco( edit3.text , '1,'+EDIT5.TEXT );
       SG.Cells[6, SG.RowCount -1 ] :=  funcoes.SohNumeros(query.Fields[0].AsString)  ;
       SG.RowCount := SG.RowCount + 1;
       AjustaSg1(sender);
       limpaCampos(sender);
       gauge.MaxValue := sg.RowCount -1;
    end;
end;

procedure TForm1.AjustaSg1(sender: tobject);
var
   i:integer;
begin
   SG.CELLS[1,0] := 'CODIGO';
   SG.CELLS[2,0] := 'DESCRICAO';

   SG.CELLS[3,0] := funcoes.lerParam( ARQ_INI ,14);
   SG.CELLS[4,0] := funcoes.lerParam( ARQ_INI ,15);
   SG.CELLS[5,0] := funcoes.lerParam( ARQ_INI ,16);
   SG.CELLS[6,0] := 'REFWELL';
   SG.CELLS[7,0] := 'PC CUSTO';

   sg.ColWidths[0] := 20;
   sg.ColWidths[1] := 70;
   sg.ColWidths[2] := 215;
   sg.ColWidths[3] := 60;
   sg.ColWidths[4] := 60;
   sg.ColWidths[5] := 60;
   sg.ColWidths[6] := StrToInt(funcoes.lerParam( ARQ_INI ,13));
   sg.ColWidths[7] := 70;


   for i:=0 to sg.RowCount-1 do
      sg.RowHeights[i] := 18;
   sg.fixedrows := 1;
end;

procedure TForm1.sgSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if arow > 0 then
     LinhaSg:= arow
end;

procedure TForm1.sgDblClick(Sender: TObject);
var
  i:integer;
begin
   if (linhasg > 0) then
begin
     if (sg.Cells[1,LinhaSg] <>'')then
     begin
        for i:=0 to sg.ColCount-1 do
           sg.Cells[i,linhasg] := '';
     end;

     for i:=LinhaSg to sg.RowCount - 1 do
     begin
        sg.cells[0,i ] := sg.cells[0,i+1 ];
        sg.cells[1,i ] := sg.cells[1,i+1 ];
        sg.cells[2,i ] := sg.cells[2,i+1 ];
        sg.cells[3,i ] := sg.cells[3,i+1 ];
        sg.cells[4,i ] := sg.cells[4,i+1 ];
        sg.cells[5,i ] := sg.cells[5,i+1 ];
        sg.cells[6,i ] := sg.cells[6,i+1 ];
        sg.cells[7,i ] := sg.cells[7,i+1 ];
        sg.cells[8,i ] := sg.cells[8,i+1 ];
     end;

     for i:=LinhaSg to sg.rowcount-1  do
        if sg.Cells[1,i] = '' then
           sg.RowCount := sg.RowCount - 1;
   sg.rowcount := sg.rowcount +1;
   ajustasg1(sender);
end;


end;

function TForm1.AjustaPreco(valor, percentual: string): string;
var
   aux1,aux2,aux3:real;
begin
   while pos('.',valor) > 0 do
      delete(valor,pos('.',valor),01);

   aux1 := Strtofloat(valor);
   aux2 := Strtofloat(percentual);
   aux3:=  (aux1 * aux2);
   valor := FloatTostr( aux3  );
   AjustaPreco :=  FloatToStrF( aux3 ,ffFixed,18,02);
end;
procedure tform1.GeraSQL(is_ref,tpPreco,UO,Valor,cd_ref:string);
var
  cmd:string;
begin
      cmd := '';
      cmd := ' Exec dbo.Z_CF_LancaPcoProduto '                  +
                                                   is_ref  +', '+
                                                   tpPreco +', '+
              funcoes.StrToSqlDate(datetoStr(date1.Date))  +', '+
                                                       uo  +', '+
                                  funcoes.ValorSql(valor)  +', '+
                           funcoes.lerParam( ARQ_INI ,02)  +', '+
                                          QuotedStr(cd_ref)+', '+
                                         FloatToStr(is_oap)+', '+
                                         FloatToStr(is_alp);
      query.sql.clear;
      query.sql.add(CMD);

      // testa se ira lancar o preco se for nao gera todos os comandos mas nao executa no banco
      if uppercase(funcoes.lerParam( ARQ_INI ,17)) = 'S' then
         query.ExecSQL
      else
         funcoes.GravaLinhaEmUmArquivo('LOG_LancamentoDePrecos.log' ,'Simulação : '+ CMD );
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   j,i:integer;
   PcCe,PcPI,PcMa:string;
begin
   try
      // testa se ira lancar o preco se for nao gera todos os comandos mas nao executa no banco
      if uppercase(funcoes.lerParam( ARQ_INI ,17)) = 'S' then
      begin
         funcoes.GravaLinhaEmUmArquivo('LOG_LancamentoDePrecos.log' , '');
         funcoes.GravaLinhaEmUmArquivo('LOG_LancamentoDePrecos.log' , 'Precos lancados em: ' +#13+ DateTimeToStr(now));
      end;

      if (sg.RowCount > 2) and (application.MessageBox(pchar( #13 + 'Deseja efetivar realmente esse preços ?? '+#13), pchar(form1.Caption), mb_yesNo ) = mryes)   then
      begin
         gauge.Visible := true;
         screen.Cursor := crhourglass;

         is_alp := StrToFloat ( funcsql.getValorWell(Sender,'O',' Select (contador)  as is_alp from tcont where ds_campo = ' + quotedstr('IS_ALP' ),'is_alp', Connection));
         is_oap := StrToFloat ( funcsql.getValorWell(Sender,'O',' Select (contador)  as is_oap from tcont where ds_campo = ' + quotedstr('IS_OAP' ),'is_oap', Connection));

         gauge.Progress := 10;

         for i:=1 to sg.rowCount - 2 do
         begin
            gauge.Progress := gauge.Progress + 4;
            form1.Refresh;
            case cb1.ItemIndex of
               0:begin
                    pcCe := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,18));
                    PcPi := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,19));
                    PcMa := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,20));
                 end;
               1:begin
                    pcCe := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,21));
                    PcPi := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,22));
                    PcMa := funcoes.tiraEspaco(  funcoes.lerParam(ARQ_INI,23));
                 end;
            end;

            if (pcce = '') or (pcpi = '') or (pcma = '') then
               showmessage(' Configure antes os tipos de preços !!!!');

            for j := 0 to clb1.Items.Count -1 do
            if clb1.Checked[j] = true then
            begin
               is_alp := is_alp +1;
               is_oap := is_oap +1;
               GeraSQL(sg.cells[6,i], pcCe,funcoes.tiraEspaco(copy(clb1.Items[j],41,50)), sg.cells[3,i] +'00',  sg.cells[1,i]);
            end;

            for j := 0 to clb2.Items.Count -1 do
               if clb2.Checked[j] = true then
               begin
                  is_alp := is_alp +1;
                  is_oap := is_oap +1;
               GeraSQL(sg.cells[6,i], pcPi,funcoes.tiraEspaco(copy(clb2.Items[j],41,50)), sg.cells[4,i] +'00',  sg.cells[1,i]);
               end;

            for j := 0 to clb3.Items.Count -1 do
               if clb3.Checked[j] = true then
               begin
                  is_alp := is_alp +1;
                  is_oap := is_oap +1;
                  GeraSQL(sg.cells[6,i], pcMa,funcoes.tiraEspaco(copy(clb3.Items[j],41,50)), sg.cells[5,i] +'00',  sg.cells[1,i]);
               end;
           end;
           funcsql.getValorWell(Sender,'E',' Update tcont set contador = ' + floatTostr(is_alp) + ' where ds_campo = ' + quotedstr('is_alp'),'',connection);
           funcsql.getValorWell(Sender,'E',' Update tcont set contador = ' + floatTostr(is_alp) + ' where ds_campo = ' + quotedstr('is_oap'),'',connection);
         end;
         limpasg1(sender);
         AjustaSg1(sender);
         gauge.Visible := false;
         edit1.SetFocus;
         screen.Cursor :=crdefault;
      except
         on e:Exception do
         begin
            msgTela(form1.caption, ' Erro de chave duplicada, vou avançar os contadores, tente novamente !', mb_iconwarning + Mb_Ok);
            funcoes.GravaLinhaEmUmArquivo('LOG_LancamentoDePrecos.log' , 'Erro  Gravandopreco produto' + DateTimeToStr(now) + ' Cod:'+  sg.cells[1,i] + ' Preco:' + sg.cells[4,i] );
            funcsql.getValorWell(Sender,'E',' Update tcont set contador = ( Select max(Is_alp) from dsalp  ) where ds_campo = ' + quotedstr('is_alp'),'',connection);
            funcsql.getValorWell(Sender,'E',' Update tcont set contador = ( Select max(Is_oap) from dsoap  ) where ds_campo = ' + quotedstr('is_oap'),'',connection);
         end;
     end;
end;



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   connection.Close;
   funcoes.gravaParam(  ARQ_INI , edit4.Text,00 );
   funcoes.gravaParam(  ARQ_INI , edit5.Text,01 ) ;
end;

procedure TForm1.limpasg1(sender: tobject);
var
  i:integer;
begin
   for i:=0 to sg.rowcount+1 do
     sg.rows[i].clear;
   sg.rowcount := 2;
end;

procedure TForm1.Gerardeumpedido1Click(Sender: TObject);
begin
   Application.CreateForm(TForm2, Form2);
   form2.Show;
end;

function AjustaLinhaCabecalho():string;
var
  str :string;
begin
   str:='   CODIGO       DESCRICAO                               PRECO CUSTO  ';
   str:= funcoes.preencheCampo(85,' ','D',str+ funcoes.lerParam( ARQ_INI ,14));
   str:= funcoes.preencheCampo(98,' ','D',str+ funcoes.lerParam( ARQ_INI ,15));
   str:= str+funcoes.lerParam( ARQ_INI ,16);
   AjustaLinhaCabecalho := str;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
var
   itens:tstringlist;
   nItens,i:integer;
begin
   itens := tstringlist.Create;
   itens.add('');
   itens.add('                      PREÇOS PARA REAJUSTAR VIA LANCAPRECOSWELL');
   itens.add( '   -----------------------------------------------------------------------------------------------------------');

   itens.add('');
   itens.add('   DATA DO REAJUSTE :' +DATETOsTR(DATE1.DATE));
   itens.add('   TIPO DE PRECO : ' + CB1.Items[CB1.ItemINDEX]);
   itens.add('   ');
   itens.add('   -----------------------------------------------------------------------------------------------------------');
   itens.add(AjustaLinhaCabecalho());
   ITENS.ADD('   -----------  ---------------------------------       -----------  ------------   -----------  -------------');
   nItens :=0;
   for i:=1 to sg.RowCount -1 do
   begin
      inc(nItens);
      itens.Add( '   '+
                 FUNCOES.preencheCampo(13,' ','D',sg.cells[1,i]) +
                 FUNCOES.preencheCampo(40,' ','D',copy(sg.cells[2,i],01,30)) +
                 FUNCOES.preencheCampo(13,' ','D',sg.cells[7,i]) +
                 FUNCOES.preencheCampo(15,' ','D',sg.cells[3,i]) +
                 FUNCOES.preencheCampo(13,' ','D',sg.cells[4,i]) +
                 FUNCOES.preencheCampo(13,' ','D',sg.cells[5,i])
               );
      if nItens > 60 then
      begin
         itens.Add( '');
         itens.Add( '');
         nItens :=0;
      end;
   end;
   ITENS.SaveToFile( ExtractFilePath(ParamStr(0)) + 'RELATORIO.TXT');
   if (sg.RowCount > 2) then
      funcoes.imprimeArquivo( Form1, ExtractFilePath(ParamStr(0)) + 'RELATORIO.TXT', false, 08, 'Precos alterados' );
end;

procedure TForm1.CarregaListaLojas(sender:tobject);
var
   Lojas:tstringlist;
   i,j:integer;
   vt,v1,v2,v3:string;
begin
   lojas := tstringlist.Create;
   lojas.loadfromfile('LojasPorPreco.ini');

   for i:=0 to lojas.Count -1 do
   begin
      v1:='';
      v2:='';
      v3:='';
      vt:=lojas[i];

      v1:= copy(vt,01, pos(',',vt) -1);

      for j:=0 to pos(',',vt)-1 do
         delete(vt,01,01);

      v2:= copy(vt,01, pos(',',vt) -1);

      for j:=0 to pos(',',vt)-1 do
         delete(vt,01,01);

      v3:= copy(vt,01, pos(',',vt) -1);

      for j:=0 to pos(',',vt)-1 do
         delete(vt,01,01);


   v2:= funcoes.preencheCampo(50,' ','e',v2);
   if uppercase(v1) = 'P1' then
   begin
      clb1.Items.Add(v3+ v2);
      if vt = '1' then
         clb1.Checked[clb1.Items.Count-1] := true;
   end;
   if uppercase(v1) = 'P2' then
   begin
      clb2.Items.Add(v3+ v2);
      if vt = '1' then
         clb2.Checked[clb2.Items.Count-1] := true;
   end;
   if uppercase(v1) = 'P3' then
   begin
      clb3.Items.Add(v3+ v2);
      if vt = '1' then
         clb3.Checked[clb3.Items.Count-1] := true;
   end;
   end;
end;

procedure TForm1.SaLvaListaLojas(Sender: tobject);
var
   i:integer;
   vt,v1,v2,v3:string;
begin
   deletefile('LojasPorPreco.ini');
   for i:=0 to clb1.Items.Count -1 do
   begin
      v1 := 'P1,';
      v2 := funcoes.tiraEspaco(copy(clb1.Items[i],41,50))+',';
      v3 := funcoes.tiraEspaco(copy(clb1.Items[i],01,40))+',';
      if clb1.Checked[i] = true then
         vt:='1'
      else
         vt:='0';
      funcoes.GravaLinhaEmUmArquivo('LojasPorPreco.ini',v1+v2+v3+vt);
   end;
   for i:=0 to clb2.Items.Count-1 do
   begin
      v1 := 'P2,';
      v2 := funcoes.tiraEspaco(copy(clb2.Items[i],41,50))+',';
      v3 := funcoes.tiraEspaco(copy(clb2.Items[i],01,40))+',';
      if clb2.Checked[i] = true then
         vt:='1'
      else
         vt:='0';
      funcoes.GravaLinhaEmUmArquivo('LojasPorPreco.ini',v1+v2+v3+vt);
   end;
   for i:=0 to clb3.Items.Count-1 do
   begin
      v1 := 'P3,';
      v2 := funcoes.tiraEspaco(copy(clb3.Items[i],41,50))+',';
      v3 := funcoes.tiraEspaco(copy(clb3.Items[i],01,40))+',';
      if clb3.Checked[i] = true then
         vt:='1'
      else
         vt:='0';
      funcoes.GravaLinhaEmUmArquivo('LojasPorPreco.ini',v1+v2+v3+vt);
   end;
end;


procedure TForm1.Parametros1Click(Sender: TObject);
begin
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  PasswordDlg.show;
end;

procedure TForm1.clb1Click(Sender: TObject);
begin
   SaLvaListaLojas(Sender);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   sg.Width := form1.Width -15;
   sg.Height := form1.Height - panel1.Height-160;
   sg.Top := 94;

   panel1.Top := form1.ClientHeight - panel1.Height - 10;

end;

end.
