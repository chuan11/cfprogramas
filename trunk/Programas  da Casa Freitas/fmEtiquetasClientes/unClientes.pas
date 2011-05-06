unit unClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,  funcoes, Grids,
  DBGrids, SoftDBGrid, RpCon, RpConDS, StdCtrls, ExtCtrls, Buttons, fCtrls,
  ComCtrls, TFlatButtonUnit, adLabelComboBox, TFlatPanelUnit,
  TFlatEditUnit, TFlatSpinEditUnit, funcsql, RpConBDE, Mask, adLabelEdit,
  adLabelNumericEdit, adLabelSpinEdit, Menus;

type
  TfmetqClientes = class(TForm)
    DataSource1: TDataSource;
    tbEtq: TADOTable;
    pnInicial: TPanel;
    rgTpPesquisa: TRadioGroup;
    pnPesquisaAvulsa: TPanel;
    edNmCliente: TfsEdit;
    Label1: TLabel;
    gRidResult: TSoftDBGrid;
    gridClientes: TSoftDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    dsResult: TDataSource;
    dsClientes: TDataSource;
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
    fsBitBtn1: TfsBitBtn;
    cbLojaAniversarios: TadLabelComboBox;
    Label5: TLabel;
    pnDados: TPanel;
    pnImpressao: TPanel;
    tbEtqSEQ: TAutoIncField;
    PopupMenu1: TPopupMenu;
    Exportarlista1: TMenuItem;
    rgTpPesqCliente: TRadioGroup;
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
    procedure gridClientesTitleClick(Column: TColumn);
    procedure listarClientes(Sender:Tobject; str:String );
    procedure Exportarlista1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmetqClientes: TfmetqClientes;
implementation

uses Math,  umain;

{$R *.dfm}

procedure TfmetqClientes.escondePaineis(Sender: Tobject);
begin
    pnPesquisaAvulsa.Visible     := false;
    pnCompras.Visible := false;
    pnNascimento.Visible := false;
    pnListas.Visible := false;
end;


procedure TfmetqClientes.FormCreate(Sender: TObject);
begin
   pnPesquisaAvulsa.Top :=1;
//   cbLojas.Items := funcsql.GetNomeLojas(fmMain.Conexao , false,false,'','');

   cbLojaAniversarios.Items := cbLojas.Items;
   fmMain.getParametrosForm(fmetqClientes);

   fmMain.getListaLojas(cbLojas, false, false, '' );
end;

procedure TfmetqClientes.rgTpPesquisaClick(Sender: TObject);
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

procedure TfmetqClientes.FormShow(Sender: TObject);
begin
   pnCompras.Top := pnPesquisaAvulsa.Top;
   pnCOmpras.Left := pnPesquisaAvulsa.Left;

   pnNascimento.Top :=  pnPesquisaAvulsa.Top;
   pnNascimento.left := pnPesquisaAvulsa.left;

   pnlistas.Left := pnPesquisaAvulsa.Left;
   pnlistas.top := pnPesquisaAvulsa.top;


   rgTpPesquisaClick(nil);
end;


procedure TfmetqClientes.criarTabela(Sender: Tobject);
var
   cmd:String;
begin
    cmd := 'truncate table zcf_etiquetas';
    funcsql.execSQL(cmd, fmMain.Conexao);

    tbEtq.Open;
    gridClientes.DataSource := dsClientes;
    dsClientes.DataSet := tbEtq;

    gridClientes.Columns[1].Width := 165;
    gridClientes.Columns[02].Width :=40;
    gridClientes.Columns[03].Width :=165;
    gridClientes.Columns[04].Width :=131;
    gridClientes.Columns[00].Width :=160;
end;



procedure TfmetqClientes.FormActivate(Sender: TObject);
begin
   criarTabela(nil);

end;

procedure TfmetqClientes.conexaoWWillExecute(Connection: TADOConnection;   var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   fmMain.Conexao.OnWillExecute(conexaoL, CommandText,CursorType, LockType, CommandType, ExecuteOptions, EventStatus, Command, Recordset);
end;

procedure TfmetqClientes.organizaColunaPorNumero(Sender: Tobject);
var
  coluna:Tcolumn;
begin
   coluna := TColumn.Create(nil);
   coluna.Field := tbEtq.FieldByName('nome');
   funcSql.OrganizarTabela(tbetq, coluna );
end;

procedure TfmetqClientes.listarClientes(Sender: Tobject; str: String);
var
   cmd : String;
begin
   LimpaQuery(nil);
   cmd := ' select dspes.cd_pes as num,'+
          ' dspes.nm_pes AS NOME,'+
          ' dspes.tp_lograd +'' ''+ dspes.ds_end as Endereco,'+
          ' dspes.nr_end as numero,'+
          ' case when nr_apto != '''' then ''Ap:'' + nr_apto else null end as apto,'+
          ' dspes.ds_compEnd  as CompEndereco,'+
          ' tbai.nm_bai as Bairro,  tcid.nm_cid + '' ''+   dspes.cd_uf  as Cidade,'+
          ' dspes.nr_cep as CEP '+
          ' from dspes with(NoLock)'+
          ' inner join Tbai with(NoLock) on dspes.cd_bai = tbai.cd_bai'+
          ' inner join tcid with(NoLock) on dspes.CD_CID = tcid.cd_cid and tcid.cd_cid = tbai.cd_cid'+
          ' where cd_pes in ('+str+') order by dspes.nr_cep ';
   qr.Connection := fmMain.Conexao;
   funcsql.AbrirQuery(qr,fmMain.Conexao, cmd);
   gRidResult.Columns[0].Visible := false;
end;


procedure TfmetqClientes.pesquisarClientes(Sender:Tobject; pesquisaCliente:Boolean);
var
   cmd:String;
begin
   if (rgTpPesqCliente.ItemIndex = 0) then
      cmd := 'Select cd_pes from dspes (nolock) where dspes.nm_pes like ''' +  edNmCliente.Text  + '%''' 
   else
      cmd := 'Select cd_pes from dspes (nolock) where dspes.cd_pes = ' + funcoes.SohNumeros(edNmCliente.Text) ;
   listarClientes(nil, cmd );
end;

procedure TfmetqClientes.LimpaQuery;
begin
   qr.Close;
   qr.SQL.Clear;
end;

procedure TfmetqClientes.btAddClienteClick(Sender: TObject);
begin
    if qr.IsEmpty = false then
    tbEtq.InsertRecord([
                       trim(qr.FieldByName('nome').asString),
                       trim(qr.FieldByName('endereco').asString),
                       trim(qr.FieldByName('numero').asString),
                       trim(qr.FieldByName('compEndereco').asString) + ' ' + trim(qr.FieldByName('apto').asString),
                       trim(qr.FieldByName('bairro').asString),
                       trim(qr.FieldByName('cidade').asString),
                       trim(qr.FieldByName('cep').asString)
    ] );
    gRidResult.SetFocus();

end;

procedure TfmetqClientes.FlatButton6Click(Sender: TObject);
var
 lin,col, i, j, num :integer;
 tbImpressao:TADOTable;

 regInicial, regFinal:integer;
begin
   verificaCEPinvalido(nil);

// COLOCAR CAMPOS EM BRANCO PARA POSICIONAR  o inicio da impressao
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

   fmMain.impressaoRave(tbEtq,'rpEtqCliente', nil);
end;

procedure TfmetqClientes.tbEtqAfterPost(DataSet: TDataSet);
var
   numPaginas:integer;
begin
   numPaginas := (tbEtq.RecordCount div 22) +1;
   FMmAIN.MsgStatus( intToStr(tbEtq.RecordCount) + ' etiqueta(s) ' + intTostr(numPaginas) + ' páginas.' );
end;

procedure TfmetqClientes.btAniversariantesClick(Sender: TObject);
var
   cmd:String;
begin
   cmd := ' select  cd_pes ' +
          ' from dspes with(NoLock) ' +
          ' where cd_lojcad in ( ' + funcoes.getNumUO(cbLojaAniversarios) + ' ) and ' +
          ' substring( cast(dt_nasc as varchar(10)) ,05,02) = ' + intToStr(cbMeses.ItemIndex+1);
   listarClientes(nil, cmd);
end;

procedure TfmetqClientes.conexaoWExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

procedure TfmetqClientes.gRidResultTitleClick(Column: TColumn);
begin
   funcSQl.Organizarquery(qr, column);
end;

procedure TfmetqClientes.btRmClienteClick(Sender: TObject);
begin
   while tbEtq.IsEmpty = false do
      btRmAllClienteClick(nil);
end;

procedure TfmetqClientes.btRmAllClienteClick(Sender: TObject);
begin
   if  tbEtq.IsEmpty = false then
      tbEtq.Delete;
end;

procedure TfmetqClientes.bdAddAllClick(Sender: TObject);
begin
    qr.First;
    while qr.Eof = false do
    begin
       btAddClienteClick(Sender);
       qr.Next
    end;
end;


procedure TfmetqClientes.listaClientesporCompra(Sender: Tobject);
var
   cmd:String;
begin
   cmd  :=   ' select  dspes.cd_pes ' +
             ' from dspes with(NoLock) ' +
             ' inner join ddocv (nolock) on dspes.cd_pes = ddocv.cd_pes ' +
             ' where ddocv.is_filial = ' + funcoes.getCodUo(cbLojas) +
             ' and  ddocv.dt_venda between '+  funcoes.DateTimeToSqlDateTime(datai.Date,'') + ' and ' + funcoes.DateTimeToSqlDateTime(dataf.Date,'') +
             ' and ddocv.st_venda = '''' group by dspes.cd_pes  having sum(ddocv.vl_venda) >= ' + floatToStr( edVlVenda.value);
   listarClientes(nil, cmd  );
end;


procedure TfmetqClientes.listasProVEncimento(Sender: Tobject);
var
   host, db, user, password, cmd:String;

begin
   host := fmMain.GetParamBD('ConexaoLista.host','');
   db := fmMain.GetParamBD('ConexaoLista.bd','');
   user := fmMain.GetParamBD('ConexaoLista.user','');
   password := fmMain.GetParamBD('ConexaoLista.password','');

   conexaoL.close;
   conexaoL.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ password +';Persist Security Info=True;User ID='+ user +';Initial Catalog=' + db +
                                ' ;Data Source='+host+ ';Workstation ID='+ funcoes.GetNomeDoMicro();
   qr.Close;
   qr.Connection := conexaoL;

   cmd := ' select  ' +
          ' numLista as num ' +
          ',noiva as nome ' +
          ',endEntrega as endereco ' +
          ', '''' as numero '+
          ', '' '' as apto ' +
          ', '' '' as compEndereco,  bairro ' +
          ', ''Fortaleza Ce'' as cidade, CEP  '+
          ' from listas '+
          ' where dataCasamento between ' + funcoes.DateTimeToSqlDateTime(dtl01.date,'') + ' and ' + funcoes.DateTimeToSqlDateTime(dtl02.date,'') +
          ' and loja = ' + cbListas.items[cblistas.itemIndex];

   qr.Connection := conexaoL;
   funcsql.AbrirQuery(qr, conexaoL , cmd);
//   gRidResult.Columns[0].Visible := false;
end;

procedure TfmetqClientes.FlatButton8Click(Sender: TObject);
begin
   listasProVencimento(Sender);
end;

procedure TfmetqClientes.verificaCEPinvalido(Sender: TObject);
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

procedure TfmetqClientes.btPesquisaClick(Sender: TObject);
begin
   case rgTpPesquisa.ItemIndex of
      0: pesquisarClientes(nil, true);
      1: listaClientesporCompra(nil);
      2: btAniversariantesClick(nil);
      3: listasProVEncimento(nil);
      4: listarClientes(nil, 'Select cd_pes from dspes where cd_lojcad in (10037736, 10068438 )' )
   end;
end;

procedure TfmetqClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   funcsql.execSQL('delete from zcf_etiquetas', fmMain.Conexao);
   funcoes.salvaCampos(fmetqClientes);
   fmetqClientes := nil;
   action := caFree;
end;

procedure TfmetqClientes.gridClientesTitleClick(Column: TColumn);
begin
   funcsql.OrganizarTabela(tbEtq, column);
end;


procedure TfmetqClientes.Exportarlista1Click(Sender: TObject);
begin
  funcSQL.exportaQuery(qr, false, '' );
end;

end.
