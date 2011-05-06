unit unClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, RpBase, RpSystem, RpDefine, RpRave , funcoes, Grids,
  DBGrids, SoftDBGrid, RpCon, RpConDS, StdCtrls, ExtCtrls, Buttons, fCtrls,
  ComCtrls, TFlatButtonUnit, adLabelComboBox, TFlatPanelUnit,
  TFlatEditUnit, TFlatSpinEditUnit, funcsql, RpConBDE, Mask, adLabelEdit,
  adLabelNumericEdit, adLabelSpinEdit;

type
  TForm1 = class(TForm)
    conexaoW: TADOConnection;
    DataSource1: TDataSource;
    tbEtq: TADOTable;
    pnInicial: TPanel;
    rgTpPesquisa: TRadioGroup;
    pnPesquisaAvulsa: TPanel;
    edNmCliente: TfsEdit;
    Label1: TLabel;
    sb: TStatusBar;
    gRidResult: TSoftDBGrid;
    gridClientes: TSoftDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    dsResult: TDataSource;
    dsClientes: TDataSource;
    RvProject: TRvProject;
    RvSystem1: TRvSystem;
    RvDataSetConnection1: TRvDataSetConnection;
    qr: TADOQuery;
    tbEtqNome: TStringField;
    tbEtqEndereco: TStringField;
    tbEtqcompEndereco: TStringField;
    tbEtqBairro: TStringField;
    tbEtqCidade: TStringField;
    tbEtqCEP: TStringField;
    tbEtqnum: TIntegerField;
    conexaoL: TADOConnection;
    tbEtqnumero: TStringField;
    btPesquisa: TfsBitBtn;
    pnCompras: TPanel;
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    edLinha: TadLabelSpinEdit;
    edColuna: TadLabelSpinEdit;
    btAddCliente: TfsBitBtn;
    bdAddAll: TfsBitBtn;
    btRmCliente: TfsBitBtn;
    btRmAllCliente: TfsBitBtn;
    edVlVenda: TadLabelNumericEdit;
    Label2: TLabel;
    pnNascimento: TPanel;
    cbMeses: TadLabelComboBox;
    pnListas: TPanel;
    cbListas: TadLabelComboBox;
    dtl01: TfsDateTimePicker;
    dtl02: TfsDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure rgTpPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure escondePaineis(Sender:Tobject);
    procedure criarTabela(Sender:Tobject);
    procedure FormActivate(Sender: TObject);
    procedure conexaoWWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
    procedure LimpaQuery(Sender:TObject);
    procedure btAddClienteClick(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);
    procedure tbEtqAfterPost(DataSet: TDataSet);
    procedure organizaColunaPorNumero(Sender:Tobject);
    procedure btAniversariantesClick(Sender: TObject);
    procedure conexaoWExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;var EventStatus: TEventStatus; const Command: _Command;          const Recordset: _Recordset);
    procedure gRidResultTitleClick(Column: TColumn);
//    procedure listarAniversariantes(Sender:Tobject);
    procedure listasProVEncimento(Sender:Tobject);
    procedure FlatButton8Click(Sender: TObject);
    procedure verificaCEPinvalido(Sender:TObject);
    procedure pesquisarClientes(Sender:Tobject; pesquisaCliente:Boolean);
    procedure btPesquisaClick(Sender: TObject);
    procedure listaClientesporCompra(Sender: Tobject);
    procedure bdAddAllClick(Sender: TObject);
    procedure btRmClienteClick(Sender: TObject);
    procedure btRmAllClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

uses Math;

{$R *.dfm}

procedure TForm1.escondePaineis(Sender: Tobject);
begin
    pnPesquisaAvulsa.Visible := false;
    pnCompras.Visible := false;
    pnNascimento.Visible := false;
    pnListas.Visible := false;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   conexaow.Connected := false;
   conexaow.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   conexaow.Connected := true;
   form1.Caption := form1.Caption+ '    Bd: '+ conexaow.DefaultDatabase;

   pnPesquisaAvulsa.Top :=1;
   deleteFile(funcoes.TempDir()+ '_'+Application.Title + '.log');
   RvProject.ProjectFile := 'GeraEtiquetasClientes.rav'
end;

procedure TForm1.rgTpPesquisaClick(Sender: TObject);
begin
   escondePaineis(nil);
   case rgTpPesquisa.ItemIndex of
      0:begin
           pnPesquisaAvulsa.Visible := true;
           edNmCliente.SetFocus;
        end;
      1:begin
            pnCompras.Visible := true;
            if cbLojas.Items.Count = 0 then
            begin
               cbLojas.Items := funcsql.GetNomeLojas(conexaoW, false,false,'','');
               cbLojas.ItemIndex :=0;
               dataf.date := now;
               datai.Date := dataf.Date;
            end;
        end;
      2:begin
           pnNascimento.Visible := true;
           cbMeses.SetFocus;
        end;
      3:begin
           pnListas.Visible := true;
           dtl01.Date := now;
           dtl02.Date := now;
        end;
   end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   pnCompras.Top := pnPesquisaAvulsa.Top;
   pnCOmpras.Left := pnPesquisaAvulsa.Left;

   pnNascimento.Top :=  pnPesquisaAvulsa.Top;
   pnNascimento.left := pnPesquisaAvulsa.left;

   pnlistas.Left := pnPesquisaAvulsa.Left;
   pnlistas.top := pnPesquisaAvulsa.top;


   rgTpPesquisaClick(nil);
end;


procedure TForm1.criarTabela(Sender: Tobject);
var
   cmd:String;
begin
 {
    cmd := ' create table zcf_etiquetas (  '+
                                         ' Nome varchar(50),  ' +
                                         ' Endereco varchar(50) , '+
                                         ' compEndereco varchar(50), ' +
                                         ' [Bairro] varchar(50), '+
                                         ' Cidade varchar(30), ' +
                                         ' CEP varchar(09), num integer ) ' ;
}
    cmd := 'truncate table zcf_etiquetas';
    funcsql.execSQL(cmd, conexaoW);
    tbEtq.Open;
    gridClientes.DataSource := dsClientes;
    dsClientes.DataSet := tbEtq;
    RvProject.ProjectFile := 'ListaEtiquetas.rav';
    gridClientes.Columns[1].Width := 165;
    gridClientes.Columns[02].Width :=40;
    gridClientes.Columns[03].Width :=165;
    gridClientes.Columns[04].Width :=131;
    gridClientes.Columns[00].Width :=160;
end;



procedure TForm1.FormActivate(Sender: TObject);
begin
   form1.Top := 1;
   form1.Left := screen.Width - form1.width;
   criarTabela(nil);
end;

procedure TForm1.conexaoWWillExecute(Connection: TADOConnection;   var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.GravaLinhaEmUmArquivo( funcoes.TempDir()+ '_'+Application.Title + '.log', CommandText  );
   screen.Cursor := crHourGlass;
end;

procedure TForm1.organizaColunaPorNumero(Sender: Tobject);
var
  coluna:Tcolumn;
begin
   coluna := TColumn.Create(nil);
   coluna.Field := tbEtq.FieldByName('num');
   funcSql.OrganizarTabela(tbetq, coluna );
end;

procedure TForm1.pesquisarClientes(Sender:Tobject; pesquisaCliente:Boolean);
var
   cmd:String;
begin
   LimpaQuery(nil);
   cmd := ' select ';

   if pesquisaCliente = true then
      cmd := cmd + ' top 100 ' ;

   cmd := cmd +
          ' dspes.cd_pes as num, ' +
          ' dspes.nm_pes AS NOME, ' +
          ' cast( dspes.tp_lograd +'' ''+ dspes.ds_end as char(40) )  as Endereco, ' +
          ' dspes.nr_end as numero , ' +
          ' cast( dspes.ds_compEnd as char(40) ) as CompEndereco, ' +
          ' tbai.nm_bai as Bairro, ' +
          ' tcid.nm_cid + '' ''+   dspes.cd_uf  as Cidade, ' +
          ' dspes.nr_cep as CEP ' +
          ' from dspes with(NoLock) ' +
          ' inner join Tbai with(NoLock) on dspes.cd_bai = tbai.cd_bai ' +
          ' inner join tcid with(NoLock) on dspes.CD_CID = tcid.cd_cid and tcid.cd_cid = tbai.cd_cid ' ;


   if pesquisaCliente = true then
       cmd := cmd + ' where dspes.nm_pes like ''' +  edNmCliente.Text  + '%'''
   else
       cmd := cmd + ' where  dspes.cd_lojcad in ( 10037736, 10068438 ) ';

   cmd := cmd + ' order by dspes.nm_pes ';

   qr.Connection := conexaoW;
   funcsql.AbrirQuery(qr,conexaoW, cmd);
   gRidResult.Columns[0].Visible := false;

   if pesquisaCliente = true then
      edNmCliente.SetFocus;
end;

procedure TForm1.LimpaQuery;
begin
   qr.Close;
   qr.SQL.Clear;
end;

procedure TForm1.btAddClienteClick(Sender: TObject);
begin
    if qr.IsEmpty = false then
    tbEtq.InsertRecord([
                       trim(qr.FieldByName('nome').asString),
                       trim(qr.FieldByName('endereco').asString),
                       trim(qr.FieldByName('numero').asString),
                       trim(qr.FieldByName('compEndereco').asString),
                       trim(qr.FieldByName('bairro').asString),
                       trim(qr.FieldByName('cidade').asString),
                       trim(qr.FieldByName('cep').asString)
    ] )



end;

procedure TForm1.FlatButton6Click(Sender: TObject);
var
 lin,col, i, j, num :integer;
begin
   verificaCEPinvalido(nil);
   lin := Floor(edLinha.Value);
   col := Floor(edColuna.Value-1);

   num := tbEtq.fieldByName('num').asInteger + 1 ;
   for i:= 1 to ((2 * lin ) - 2) + (1* col) do
   begin
       tbEtq.Append;
       for j:=0 to 5 do
          tbEtq.Fields[j].AsString := ' ';
       tbEtq.Fields[6].AsFloat := num;
       num := num +1;
       tbEtq.Post
   end;
   organizaColunaPorNumero(nil);
   RvProject.Execute;//Report('impressaoFichas');
end;

procedure TForm1.tbEtqAfterPost(DataSet: TDataSet);
begin
   sb.Panels[0].Text := '  ' + intToStr(tbEtq.RecordCount) + ' etiqueta(s)';
end;


procedure TForm1.btAniversariantesClick(Sender: TObject);
var
   cmd:String;
begin
   LimpaQuery(nil);
   qr.Connection := conexaoW;
   cmd := ' select  ' +
          ' dspes.nm_pes AS NOME, ' +
          ' cast( dspes.tp_lograd +'' ''+ dspes.ds_end as char(40) )  as endereco, ' +
          ' dspes.nr_end as numero , ' +
          ' cast( dspes.ds_compEnd as char(40) ) as compEndereco, ' +
          ' tbai.nm_bai as Bairro, ' +
          ' tcid.nm_cid + '' ''+   dspes.cd_uf  as cidade, ' +
          ' dspes.nr_cep as CEP, ' +
          ' dspes.cd_pes as num ' +
          ' from dspes with(NoLock) ' +
          ' inner join Tbai with(NoLock) on dspes.cd_bai = tbai.cd_bai ' +
          ' inner join tcid with(NoLock) on dspes.CD_CID = tcid.cd_cid and tcid.cd_cid = tbai.cd_cid ' +
          ' where cd_lojcad in (10037736, 10068438 ) and ' +
          ' substring( cast(dt_nasc as varchar(10)) ,05,02) = ' + intToStr(cbMeses.ItemIndex+1) +
          ' order by dspes.nm_pes';
   funcsql.AbrirQuery(qr,conexaoW, cmd);
end;

procedure TForm1.conexaoWExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

procedure TForm1.gRidResultTitleClick(Column: TColumn);
begin
   funcSQl.Organizarquery(qr, column);
end;

procedure TForm1.btRmClienteClick(Sender: TObject);
begin
   while tbEtq.IsEmpty = false do
      btRmAllClienteClick(nil);
{
   tbEtq.Close;
   funcsql.execSQL('truncate table zcf_etiquetas', conexaoW);
   tbEtq.Open;
}
end;

procedure TForm1.btRmAllClienteClick(Sender: TObject);
begin
   if  tbEtq.IsEmpty = false then
      tbEtq.Delete;
end;

procedure TForm1.bdAddAllClick(Sender: TObject);
begin
    qr.First;
    while qr.Eof = false do
    begin
       btAddClienteClick(Sender);
       qr.Next
    end;
end;


procedure TForm1.listaClientesporCompra(Sender: Tobject);
var
   cmd:String;
begin
   cmd  := ' select  dspes.cd_pes as Num,  ' +
           ' dspes.nm_pes AS NOME, '+
           ' cast( dspes.tp_lograd +'' ''+ dspes.ds_end as char(40) )  as Endereco, '+
           ' dspes.nr_end as numero , ' +
           ' cast( dspes.ds_compEnd as char(40) ) as CompEndereco, '+
           ' tbai.nm_bai as Bairro, '+
           ' tcid.nm_cid + '' ''+   dspes.cd_uf  as Cidade, '+
           ' dspes.nr_cep as CEP, '+
           ' sum(ddocv.vl_venda)  as ValorComprado ' +
           ' from dspes with(NoLock) '+
           ' inner join Tbai with(NoLock) on dspes.cd_bai = tbai.cd_bai '+
           ' inner join tcid with(NoLock) on dspes.CD_CID = tcid.cd_cid and tcid.cd_cid = tbai.cd_cid '+
           ' inner join ddocv on dspes.cd_pes = ddocv.cd_pes '+
           ' where '+
           ' ddocv.is_filial = ' + funcsql.getCodUo(cbLojas) +
           ' and  ddocv.dt_venda between '+  funcoes.DateTimeToSqlDateTime(datai.Date,'') + ' and ' + funcoes.DateTimeToSqlDateTime(dataf.Date,'') +
           ' and ddocv.st_venda = '''' '+
           ' group by dspes.cd_pes, dspes.nm_pes, dspes.TP_LOGRAD, dspes.DS_END, dspes.NR_END, dspes.DS_COMPEND,Tbai.NM_BAI '+
           ', tcid.NM_CID, dspes.CD_UF, dspes.NR_CEP ' +
           ' having sum(ddocv.vl_venda) >= ' + floatToStr( edVlVenda.value);

     funcsql.AbrirQuery(qr,conexaow,cmd);
end;


procedure TForm1.listasProVEncimento(Sender: Tobject);
var
   cmd:String;
begin
   conexaoL.close;                      //
   conexaoL.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ funcoes.RParReg('listas','DBPassWord')  +';Persist Security Info=True;User ID='+ funcoes.RParReg('listas','DBUserName') +';Initial Catalog='  +funcoes.RParReg('listas','DBName') +' ;Data Source='+funcoes.RParReg('listas','IPServer')+ ';Workstation ID='+ funcoes.GetNomeDoMicro();
   qr.Close;
   qr.Connection := conexaoL;

   cmd := 'select  ' +
          'noiva as nome, endEntrega as endereco, '''' as numero,  '' '' as compEndereco,  bairro, ' +
          ' ''Fortaleza Ce'' as cidade, ''00000-000'' as CEP  '+
          'from listas '+
          'where dataCasamento between ' + funcoes.DateTimeToSqlDateTime(dtl01.date,'') + ' and ' + funcoes.DateTimeToSqlDateTime(dtl02.date,'') +
          'and loja = ' + cbListas.items[cblistas.itemIndex];
   funcsql.AbrirQuery(qr,conexaoL, cmd);
end;

procedure TForm1.FlatButton8Click(Sender: TObject);
begin
   listasProVencimento(Sender);
end;

procedure TForm1.verificaCEPinvalido(Sender: TObject);
begin
    tbEtq.First;
    while tbEtq.Eof = false do
    begin
       if tbetq.FieldByName('cep').asString = '0' then
       begin
          funcoes.MsgTela('','Existem CEP''s em branco, por favor preencha os CEP''S. '+#13 , MB_ICONERROR + MB_OK );
          break;
       end;
       tbEtq.Next
    end;
end;

procedure TForm1.btPesquisaClick(Sender: TObject);
begin
   case rgTpPesquisa.ItemIndex of
      0: pesquisarClientes(nil, true);
      1: listaClientesporCompra(nil);
      2:btAniversariantesClick(nil);
      4: pesquisarClientes(nil, false);
   end;


end;



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcsql.execSQL('truncate table zcf_etiquetas', conexaoW);
end;

end.
