unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,

  funcoes, funcsql, Menus, Grids, DBGrids, SoftDBGrid, StdCtrls, RpBase,
  RpSystem, RpRave, RpDefine, RpCon, RpConDS, fCtrls;

type
  TfmMain = class(TForm)
    conn: TADOConnection;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    GroupBox1: TGroupBox;
    grid: TSoftDBGrid;
    tbItens: TADOTable;
    dsItens: TDataSource;
    tbItensis_ref: TIntegerField;
    tbItenscd_ref: TStringField;
    tbItensds_ref: TStringField;
    tbItensean: TStringField;
    tbItensobs: TStringField;
    tbItenspreco: TBCDField;
    tbItensqt_emb: TIntegerField;
    Imprimir1: TMenuItem;
    qr: TADOQuery;
    rvcImagens: TRvDataSetConnection;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    Importardeumpedido1: TMenuItem;
    GroupBox2: TGroupBox;
    gridC: TSoftDBGrid;
    tbPromocao: TADOTable;
    DataSource1: TDataSource;
    tbItensnum: TIntegerField;
    rcvPromocao: TRvDataSetConnection;
    qrseq: TAutoIncField;
    qris_ref: TIntegerField;
    qrcd_ref: TStringField;
    qrds_ref: TStringField;
    qrean: TStringField;
    qrqt_emb: TIntegerField;
    qrobs: TStringField;
    qrpreco: TBCDField;
    qrnum: TIntegerField;
    qrimagem: TBlobField;
    tbItensseq2: TAutoIncField;
    tbItensseq22: TStringField;
    procedure connWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure Cadastro1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridColExit(Sender: TObject);
    procedure getDadosProduto(cod:String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Imprimir1Click(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure Importardeumpedido1Click(Sender: TObject);
    procedure gridCDblClick(Sender: TObject);
    procedure tbItensNewRecord(DataSet: TDataSet);
    procedure tbItensAfterPost(DataSet: TDataSet);
    procedure salvaItens();
    procedure gridTitleClick(Column: TColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  UO:String;
  IS_TBITENS_MODIFICADA:Boolean;
  NUM_PROMOCAO:String;
implementation
uses uCadastro;

{$R *.dfm}

procedure TfmMain.connWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.gravaLog(CommandText);
end;

procedure TfmMain.Cadastro1Click(Sender: TObject);
begin
    if ( fmCadastro = nil) then
    begin
       Application.CreateForm(TfmCadastro, fmCadastro );
       fmCadastro.Show();
    end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   if (conn.Connected = true) then
      conn.Close();
   conn.ConnectionString := funcoes.getDadosConexaoUDL('conexaoAoWell.ini');
   tbItens.TableName := 'zcf_itensPromocao';
   tbPromocao.TableName :='zcf_itensPromocaoC';
   tbPromocao.Open();
   gridC.Columns[ tbPromocao.FieldByName('num').Index].Visible := false;
end;

procedure TfmMain.gridColExit(Sender: TObject);
begin
    if ( grid.SelectedIndex = tbItens.FieldByName('cd_ref').Index ) and ( tbItens.FieldByName('ds_ref').AsString = ''  ) then
    begin
       getDadosProduto(tbItens.FieldByName('cd_ref').asString);
    end;
end;

procedure TfmMain.getDadosProduto(cod:String);
var
   ds:TDataSet;
   cmd :String;

begin
   cmd := 'exec Z_CF_getInformacoesProduto ' + quotedStr(cod) + ', '+ UO + ', 103';
   ds := funcsql.getDataSetQ(cmd, fmMain.conn);

   if (ds.IsEmpty = false) then
   begin
      tbItens.Edit;
      tbItens.FieldByName('cd_ref').AsString:= ds.FieldByName('codigo').asString;
      tbItens.FieldByName('is_ref').AsString:= ds.FieldByName('is_ref').asString;
      tbItens.FieldByName('ds_ref').AsString:= ds.FieldByName('descricao').asString;
      tbItens.FieldByName('ean').AsString:= ds.FieldByName('ean').asString;
      tbItens.FieldByName('qt_emb').AsString:= ds.FieldByName('embalagem').asString;
      tbItens.FieldByName('ean').AsString:= ds.FieldByName('ean').asString;
      tbItens.FieldByName('preco').AsString:= ds.FieldByName('preco').asString;
      tbItens.Post();
      tbItens.Edit;
      tbItens.FieldByName('seq2').AsString := tbItens.FieldByName('seq').AsString;
      tbItens.Post();
   end
   else
   begin
      msgTela('', 'Produto n�o cadastrado.', MB_OK + MB_ICONHAND);
      tbItens.Cancel();
      grid.SelectedIndex := tbItens.FieldByName('cd_ref').Index;
   end;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) or (key = vk_DOWN)then
     key  := vk_TaB;
end;

procedure TfmMain.Imprimir1Click(Sender: TObject);
var
   str:String;
begin
   gridCDblClick(nil);
   str := 'Select p.*, i.imagem from ' + tbItens.TableName +' p (nolock) left join zcf_crefe_imagens i (nolock) on p.is_ref = i.is_ref '+
          ' where num = ' + NUM_PROMOCAO ;
   getQuery( conn, qr, str );
   qr.Connection := conn;
   RvProject1.SetParam('0', ExtractFilePath(paramStr(0))+ 'images\logo1.bmp');
   RvProject1.SetParam('1', ExtractFilePath(paramStr(0))+ 'images\logo2.bmp');
   RvProject1.ExecuteReport('rpImagens');
   qr.SQL.Clear();
   qr.Active := false
end;

procedure TfmMain.gridDblClick(Sender: TObject);
begin
   if ( MsgTela('', 'Exclui esse item?' , mb_yesNo + mb_Iconquestion ) = mrYes) then
      tbItens.Delete();
end;

procedure TfmMain.Importardeumpedido1Click(Sender: TObject);
var
   str:String;
   itens:Tstrings;
   i:integer;
begin
   str := '';
   str :=  InputBox('','Pedido:',str);
   if  (tbItens.Active = true) and  (funcoes.SohNumeros(str) <> '' )then
   begin
      itens := funcsql.getListagem(' select cd_ref from crefe where is_ref in ( '+
                                      ' Select seqproduto from itensPedidoCliente where numPedido = ' + str +' )', conn);
      if itens.Count > 0 then
        for i:=0 to itens.Count-1 do
        begin
           getDadosProduto(itens[i]);
           tbItens.Append();
        end;
        tbItens.Cancel();
   end;
end;

procedure TfmMain.gridCDblClick(Sender: TObject);
begin
   IF IS_TBITENS_MODIFICADA = TRUE THEN
   salvaItens();

   if (tbItens.Active = true) then
      tbItens.Close();

   NUM_PROMOCAO := tbPromocao.fieldbyname('num').AsString;

   funcSQl.getTable(conn, tbItens,'seq int IDENTITY(0,1) NOT NULL, is_ref int,	cd_ref varchar(8),	ds_ref varchar(50), ean varchar(13),	qt_emb int,	obs varchar(50),	preco money,	num int, seq2 varchar(08) ');
   tbItens.close();
   funcsql.execSQL( 'insert ' + tbItens.TableName  + ' select is_ref, cd_ref, ds_ref, ean, qt_emb, obs, preco, num , seq2 from zcf_itensPromocao where num = ' +  tbPromocao.fieldbyname('num').asString, conn );

   tbItens.Open();

  grid.Columns[ tbItens.FieldByName('seq').Index  ].Visible := false;
   grid.Columns[tbItens.FieldByName('preco').Index ].Width :=  20;
   grid.Columns[ tbItens.FieldByName('seq2').Index  ].Width := 20;
   grid.Columns[ tbItens.FieldByName('is_ref').Index  ].Visible := false;
   grid.Columns[ tbItens.FieldByName('num').Index  ].Visible := false;
   grid.Columns[ tbItens.FieldByName('cd_ref').Index  ].Title.Caption :='Codigo';
   grid.Columns[ tbItens.FieldByName('ds_ref').Index  ].Title.Caption :='Descri��o';
   grid.Columns[ tbItens.FieldByName('EAN').Index  ].Title.Caption :='EAN';
   grid.Columns[ tbItens.FieldByName('qt_emb').Index  ].Title.Caption :='Master';
   grid.Columns[ tbItens.FieldByName('Obs').Index  ].Title.Caption :='Observa��o';
   grid.Columns[ tbItens.FieldByName('preco').Index  ].Title.Caption :='Pre�o';
   UO := funcSQl.openSQL('Select top 01 is_uo from tbuo where tp_uo = 3', 'is_uo', conn);
   grid.Columns[tbItens.FieldByName('cd_ref').Index ].Width :=  60;
   grid.Columns[3].Width :=  200;
   grid.Columns[ tbItens.FieldByName('Obs').Index  ].Width :=  200;
   grid.Columns[4].Width :=  50;
   grid.Columns[5].Width :=  50;
   grid.Columns[tbItens.FieldByName('ds_ref').Index].Width :=  270;
   grid.Columns[tbItens.FieldByName('preco').Index ].Width :=  60;
end;

procedure TfmMain.tbItensNewRecord(DataSet: TDataSet);
begin
   grid.SelectedIndex := tbItens.FieldByName('cd_ref').Index;
   tbItens.FieldByName('num').AsString := NUM_PROMOCAO;
end;

procedure TfmMain.tbItensAfterPost(DataSet: TDataSet);
begin
   IS_TBITENS_MODIFICADA:= TRUE;
end;

procedure TfmMain.salvaItens;
var
   tbAux:TAdoTAble;
   i:integer;
begin
   tbItens.First();
   funcsql.execSQL('delete from zcf_itensPromocao where num = ' + NUM_PROMOCAO , conn );

   tbAux := TADOTable.Create(nil);
   with tbAux do
   begin
      TableName := 'zcf_itensPromocao';
      Connection := conn;
      Filtered := true;
      Filter := 'num = -1';
      open;
   end;

   while (tbItens.Eof = false) do
   begin
      tbAux.Append();
//      for i:= to tbItens.FieldCount -1 do

      tbAux.fieldbyname('is_ref').asString := tbItens.fieldByname('is_ref').asString;
      tbAux.fieldbyname('cd_ref').asString := tbItens.fieldByname('cd_ref').asString;
      tbAux.fieldbyname('ean').asString := tbItens.fieldByname('ean').asString;
      tbAux.fieldbyname('qt_emb').asString := tbItens.fieldByname('qt_emb').asString;
      tbAux.fieldbyname('obs').asString := tbItens.fieldByname('obs').asString;
      tbAux.fieldbyname('preco').Assign(tbItens.fieldByname('preco'));
      tbAux.fieldbyname('seq2').Assign(tbItens.fieldByname('seq2'));
      tbAux.fieldbyname('num').Assign(tbItens.fieldByname('num'));

//is_ref, cd_ref, ds_ref, ean, qt_emb, obs, preco, num , seq2

  //       tbAux.Fields[i].Assign(  tbItens.Fields[i]  );
//      tbAux.FieldByName('seq2').AsString := tbItens.FieldByName('seq').AsString;
      tbAux.Post();
      tbItens.Next();
   end;
   tbAux.Close();
   tbAux.Destroy();

   IS_TBITENS_MODIFICADA := FALSE;
end;

procedure TfmMain.gridTitleClick(Column: TColumn);
begin
   funcsql.organizarTabela(tbItens,column );
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if tbItens.Active = true then
     salvaItens();
end;

end.
// Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;User ID=secrel;Initial Catalog=wellCfreitas;Data Source=125.4.4.200
