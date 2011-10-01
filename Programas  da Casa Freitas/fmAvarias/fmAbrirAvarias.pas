unit fmAbrirAvarias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, adLabelComboBox, TFlatButtonUnit, ExtCtrls,
  Grids, DBGrids, SoftDBGrid, FuncSQL, fCtrls, DB, ADODB,funcoes, RpBase,
  RpSystem, RpCon, RpConDS, RpDefine, RpRave, verificaSenhas;

type
  TfmAbrirAvaria = class(TForm)
    dbgrid: TSoftDBGrid;
    cbLojas: TadLabelComboBox;
    dti: TDateTimePicker;
    btBusca: TFlatButton;
    dtf: TDateTimePicker;
    cBoxIntervalo: TfsCheckBox;
    Bevel1: TBevel;
    Label1: TLabel;
    QrBusca: TADOQuery;
    DataSource1: TDataSource;
    pnConfirma: TPanel;
    btOk: TFlatButton;
    btFechar: TFlatButton;
    qrCabeca: TADOQuery;
    qrCorpo: TADOQuery;
    FlatButton3: TFlatButton;
    cbStatus: TadLabelComboBox;
    cbImpCustoAvaria: TfsCheckBox;
    cbTipoImpresao: TadLabelComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure dbgridDblClick(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure preparaParaListarMapa(Sender:Tobject);
    procedure dbgridTitleClick(Column: TColumn);
    procedure preparaParaListarAvaria(tag:Integer);
    procedure AbrirAvaria(Sender:Tobject);
    procedure imprimirAvaria(Sender:Tobject);
    procedure abrirMapa(Sender:Tobject);
    procedure pesquisaAvarias(Sender:Tobject; di,df:Tdate);
    procedure pesquisaMapa(Sender:Tobject; di,df:Tdate);
    procedure deletarAvaria(Sender:Tobject);
    procedure deletarMapa(Sender:Tobject);
    procedure preparaimpressaoAvarias();
    procedure transfereAvaria();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbrirAvaria: TfmAbrirAvaria;
  tipoConsulta:smallInt;
implementation
uses uAvarias, umain, uMapa, uCF;
{$R *.dfm}

procedure TfmAbrirAvaria.FormCreate(Sender: TObject);
begin
   uCF.getListaLojas(cbLojas, true, false, '' );
   dti.Date := strToDate('01/' + copy(dateToStr(now),04,07));
   dtf.Date := now;
end;

procedure TfmAbrirAvaria.pesquisaMapa(Sender: Tobject; di, df: Tdate);
begin
   qrBusca.SQL.Clear;
   qrBusca.sql.add('exec zcf_stolistarMapasSep ' + funcoes.DateTimeToSqlDateTime(di,'') +' , '+ funcoes.DateTimeToSqlDateTime(df,'') +' , '+  intToStr(cbStatus.itemIndex-1) );
   qrBusca.Open;
   dbgrid.Columns[0].width :=  80;
   dbgrid.Columns[01].width :=  200;
   dbgrid.Columns[02].width :=  70;
   dbgrid.Columns[03].width :=  100;
   dbgrid.Columns[04].width :=  70;
end;

procedure TfmAbrirAvaria.pesquisaAvarias(Sender: Tobject; di, df: Tdate);
var
   status,uo:string;
begin
   uo := '';
   status := '';
   if cbStatus.ItemIndex >0 then
      status := intToStr(cbStatus.ItemIndex -1);
   if cbLojas.ItemIndex > 0 then
      uo := copy(cbLojas.Items[cbLojas.ItemIndex],51,08);

   qrbusca.SQL.Clear;
   if cBoxIntervalo.Checked = false then
      qrBusca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria='''' ' +' , @uo='+ QuotedStr(uo) +' , @dti= '''' '+ ' , @dtf = '''' , @ehAprovada = ' + quotedStr(status) )
   else
      qrBusca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria='''' ' +' , @uo='+ QuotedStr(uo) +' , @dti='+ funcoes.StrToSqlDate(DateToStr(dti.date)) +' , @dtf =  '+ funcoes.StrToSqlDate(DateToStr(dtf.date)) + '  , @ehAprovada = ' + quotedStr(status)) ;
   qrBusca.Open;
   dbgrid.Columns[0].width :=  70;
   dbgrid.Columns[01].width :=  90;
   dbgrid.Columns[02].width :=  120;
   dbgrid.Columns[03].width :=  64;
   dbgrid.Columns[04].width :=  100;
   dbgrid.Columns[05].width :=  100;
   dbgrid.Columns[06].visible := false;
   dbgrid.Columns[ QrBusca.FieldByName('uo').Index ].visible := false;
   dbgrid.Columns[ dbgrid.Columns.Count-1].Visible := false;
end;


procedure TfmAbrirAvaria.btBuscaClick(Sender: TObject);
var
   di,df:Tdate;
begin
   if cBoxIntervalo.Checked = true then
   begin
     di := dti.Date;
     df := dtf.Date;
   end
   else
   begin
      di := strToDate('01/01/2000');
      df := strToDate('01/01/2050');
   end;
   case fmAbrirAvaria.Tag of
      1,2,4:pesquisaAvarias(nil, di,df);
      3: pesquisaMapa(nil,di,df);
   end;
end;

procedure TfmAbrirAvaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmAbrirAvaria := nil;
   action := CaFree;
end;

procedure TfmAbrirAvaria.btFecharClick(Sender: TObject);
begin
   fmAbrirAvaria.Close;
end;

procedure TfmAbrirAvaria.dbgridDblClick(Sender: TObject);
begin
   if qrBusca.IsEmpty = false then
      btOkClick(Sender);
end;

procedure TfmAbrirAvaria.deletarAvaria(Sender:Tobject);
var
  msg:String;
begin
    msg := ' Deseja deletar essa avaria?                             '+#13+
           ' Loja: ' + qrBusca.FieldByname('Loja').AsString +#13+
           ' Remessa: ' + qrBusca.FieldByname('Numero').AsString +#13+#13+
           ' Para deletar essa remessa é necessário a senha de autorização.';

   if msgTela( '', msg , mb_iconQuestion + mb_YesNo) = mrYes then
      if ( fmMain.telaAutWell( fmMain.GetParamBD('avarias.grupoQueDeleta',''),'') <> '') then
      begin
         msg := ' update zcf_avarias set ehAtiva = 0 where numAvaria = ' +
                  qrBusca.FieldByname('Numero').AsString + ' and Loja = ' + qrBusca.fieldByName('uo').AsString;
                  getValorWell('E', msg, '@@error', fmMain.Conexao);
         btBuscaClick(sender);
         msgTela('', ' A remessa foi excluída... ', mb_oK + mb_IconInformation);
      end;
end;

procedure TfmAbrirAvaria.deletarMapa(Sender:Tobject);
var
   msg:String;
begin
   msg := ' Deseja deletar esse mapa?                            '+#13+
          ' Numero: ' + qrBusca.FieldByname('Numero').AsString    +#13+
          ' Criador: ' + qrBusca.FieldByname('criador').AsString  +#13;

   if msgTela( '', msg , mb_iconQuestion + mb_YesNo) = mrYes then
      if verificaSenhas.TelaAutorizacao2(fmMain.Conexao, '13', openSQL('Select criador from zcf_mapaSEparacao where num = ' +qrBusca.FieldByname('Numero').AsString, 'criador', fmMain.Conexao ) ) <> '' then
      begin
         funcSQL.ExecSQL('Delete from zcf_mapaSeparacao where num =  ' + qrBusca.FieldByname('Numero').AsString , fmMain.Conexao);
         btBuscaClick(sender);
         msgTela('', ' O mapa foi excluido... ', mb_oK + mb_IconInformation);
      end;
end;

procedure TfmAbrirAvaria.FlatButton3Click(Sender: TObject);
begin
   if (qrBusca.IsEmpty = false ) then
      case fmAbrirAvaria.Tag of
         1,2: deletarAvaria(nil);
         3:deletarMapa(nil);
      end;
end;

procedure TfmAbrirAvaria.preparaParaListarMapa(Sender: Tobject);
begin
   cbLojas.Visible := false;
   fmAbrirAvaria.Caption := 'Pesquisa mapa separacao';
   fmAbrirAvaria.tag := 3;
end;


procedure TfmAbrirAvaria.preparaParaListarAvaria(tag:Integer);
begin
   cbLojas.Visible := true;
   FlatButton3.Visible := true;
   fmAbrirAvaria.Caption := 'Pesquisa avarias';
   fmAbrirAvaria.tag := tag;


   Case tag of
      2: preparaimpressaoAvarias();
   end;


   if ( pos(fmMain.getGrupoLogado(), fmMain.GetParamBD('avarias.grImpCusto','')) > 0 ) and (fmAbrirAvaria.Tag = 2) then
      cbImpCustoAvaria.Visible := true;
end;

procedure TfmAbrirAvaria.dbgridTitleClick(Column: TColumn);
begin
   funcsql.OrganizarQuery(qrBusca, Column);
end;

procedure TfmAbrirAvaria.AbrirAvaria(Sender: Tobject);
begin
   fmCadAvarias.CarregarCabecalhoAvarias(sender, qrBusca.fieldByName('numero').AsString, qrBusca.fieldByName('uo').AsString );
   fmCadAvarias.CarregaItensAvarias(sender, qrBusca.fieldByName('numero').AsString, qrBusca.fieldByName('uo').AsString );
   fmAbrirAvaria.Hide;
end;

procedure TfmAbrirAvaria.imprimirAvaria(Sender: Tobject);
var
   params:TStringlist;
   cmd:String;
begin
   params := TStringList.Create();
   qrCabeca.SQL.Clear;
   qrCabeca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria = '+ qrBusca.fieldByName('numero').AsString +' , @uo = '+ quotedStr( qrBusca.fieldByName('uo').AsString)+ ' , @dtI= '''' , @dtF = '''' ');
   qrCorpo.sql.Clear;
   cmd :=         (' select ava.numAvaria, crefe.cd_ref as CODIGO, crefe.ds_ref AS DESCRICAO, ava.*, dspes.nm_fantasi, ' +
                   ' case ava.origem when ''0'' then ''Cliente'' when ''1'' then ''Funcionario'' when ''2'' then ''CD'' when ''3'' then ''Gerente/SubGerente'' end as DescOrigem ' +
                   ' from zcf_AvariasItens ava with(noLock)' +
                   ' inner join crefe with(noLock) on ava.is_ref = crefe.is_ref '+
                   ' inner join dspes on crefe.cd_pes = dspes.cd_pes ' +
                   ' where ava.numAvaria =' + qrBusca.fieldByName('numero').AsString +
                   ' and ava.loja = ' + QuotedStr(qrBusca.fieldByName('uo').AsString) ) ;

                   if ( cbTipoImpresao.itemIndex = 0) then
                      cmd := cmd + ' order by crefe.ds_ref'
                   else
                      cmd := cmd + ' order by crefe.cd_ref' ;


                  qrCorpo.SQL.Add(cmd );
   qrCabeca.open;
   qrCorpo.Open;
   params.Add(boolToStr(cbImpCustoAvaria.Checked,true));
   fmMain.impressaoRaveQr4( qrCabeca, qrCorpo, nil, nil, 'rpAvarias', params )
end;

procedure TfmAbrirAvaria.abrirMapa(Sender: Tobject);
begin
   fmMapa.CarregaMapa(QrBusca.FieldByName('numero').AsString );
   fmAbrirAvaria.Close;
end;

procedure TfmAbrirAvaria.btOkClick(Sender: TObject);
begin
   Screen.cursor := CrHourGlass;
   if QrBusca.IsEmpty = false then
      case fmAbrirAvaria.Tag of
          1:AbrirAvaria(nil);
          2:imprimirAvaria(nil);
          3:abrirMapa(nil);
          4:transfereAvaria();
      end;
   btFecharClick(nil);
   Screen.cursor := Crdefault;
end;


procedure TfmAbrirAvaria.preparaimpressaoAvarias;
begin
   cbTipoImpresao.Visible := true;
end;

procedure TfmAbrirAvaria.transfereAvaria;
var
   cmd, uo:String;
begin
   uo := uCF.getIsUo(false);
   if (uo <> '') then
      if (qrBusca.fieldByName('dataAprovacao').AsString <> '') then
      begin
         if (msgTela('','Deseja setar a loja para desconto dessa a varia ?', MB_ICONQUESTION + MB_YESNO ) = mrYes) then
         begin
            cmd := ' update zcf_avarias set codLojaDesconto = ' + uo  +
                   ' where numAvaria= ' + qrBusca.fieldByName('numero').AsString + ' and  loja = '+ qrBusca.fieldByName('uo').AsString;
            funcSQL.execSQL(cmd, fmMain.Conexao);
            cmd := ' update zcf_avariasItens set codLojaDesconto = ' + uo  +
                   ' where numAvaria= ' + qrBusca.fieldByName('numero').AsString +  ' and  loja = '+ qrBusca.fieldByName('uo').AsString ;
            funcSQL.execSQL(cmd, fmMain.Conexao);
            funcoes.msgTela('',' Ajuste efetuado com sucesso.', mb_ok + MB_ICONEXCLAMATION );
         end
      end;
end;

end.



