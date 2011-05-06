unit MapaEstoque;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, ExtCtrls, adLabelEdit, Grids,
  DBGrids, SoftDBGrid, DB, ADODB,funcoes,funcSQl, adLabelComboBox, comObj,
  TFlatGaugeUnit;

type
  TForm1 = class(TForm)
    grid: TSoftDBGrid;
    fsGroupBox1: TfsGroupBox;
    edCodigo: TadLabelEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Connection: TADOConnection;
    DataSource1: TDataSource;
    Table: TADOTable;
    Label4: TLabel;
    cbOrdem: TadLabelComboBox;
    chDisponivel: TfsCheckBox;
    lbNivel: TLabel;
    lbCodigo: TLabel;
    gauge: TFlatGauge;
    cbTpEstoque: TadLabelComboBox;
    cb2: TadLabelComboBox;
    fsBitBtn3: TfsBitBtn;
    cbPrecos: TadLabelComboBox;
    procedure GerarMapaSeparacao(sender: tobject);
    procedure CarregarDadosMapaSeparacao(Sender: TObject);
    procedure CarregaEstoqueMapaSeparacao(Sender:Tobject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetProdutos(Sender:Tobject);
    procedure LimpaTabela(Sender:Tobject);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  nivelClasse, nClasse, UO_CD:string;
implementation
{$R *.dfm}
uses unClasses;

procedure TForm1.GerarMapaSeparacao(sender: tobject);
var
  Excel : Variant;
  i,Linha:integer;
begin
   grid.Visible := false;
   screen.Cursor := crHourGlass;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'MapaEstoque.xls');

   Linha:=3;
   table.First;
   While table.Eof = false do
   Begin
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,1]:= trim( table.FieldByname('código').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,2]:= trim( table.FieldByname('Descrição').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,3]:= trim( table.FieldByname('Cx').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,4]:= trim( table.FieldByname('Centro de Distribuição').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,5]:= trim( table.FieldByname('CF General Bezerril - Matriz').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,6]:= trim( table.FieldByname('CF Edgar Borges').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,7]:= trim( table.FieldByname('CF Maracanau').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,8]:= trim( table.FieldByname('PFM Pedro Borges').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,9]:= trim( table.FieldByname('PFM Dom Luis').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,10]:= trim( table.FieldByname('PF São Luis').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,11]:= trim( table.FieldByname('PFM Teresina').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,12]:= trim( table.FieldByname('PFM Messejana').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,13]:= trim( table.FieldByname('PFM Montese').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,14]:= trim( table.FieldByname('PFM Iguatemi').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,15]:= trim( table.FieldByname('PFM Liberato Barroso').AsVariant);
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,16]:= trim( table.FieldByname('preco').AsVariant);
      table.Next;
      inc(Linha);
      Form1.refresh;
   end;
   Excel.Visible :=True;

   table.First;
   grid.visible := true;
   screen.Cursor := crDefault;
end;

procedure TForm1.CarregaEstoqueMapaSeparacao(Sender: Tobject);
var
   i:integer;
   qrDados:TADOQuery;
   EhDisp:string;
begin
   screen.Cursor := crHourGlass;
   Gauge.MaxValue := table.RecordCount ;
   grid.Visible := false;
   gauge.Visible :=true;

   if chDisponivel.Checked = true then
      ehDisp := '1'
   else
      ehDisp := '0';

   qrDados := TADOQuery.Create(form1);
   qrDados.Connection := Connection;

   table.First;
   while table.Eof = false do
   begin
      qrDados.SQL.Clear;
      qrDados.SQL.Add('Exec Z_CF_ObterEstoqueProdutoNasFiliais ' + Table.fieldByName('Is_ref').AsString +' , '+ EhDisp );
      qrDados.Open;

      table.Edit;
      for i := 4 to table.FieldCount -1 do
      begin
         if table.Fields[i].AsString <> '0' then
            table.Fields[i].AsString := qrDados.FieldByName('Estoque').asString;
         qrDados.Next;
      end;
     table.Post;

     table.Edit;
     table.FieldByName('Preco').AsString :=  funcSQL.GetValorWell( 'O','Select dbo.Z_CF_funObterPrecoProduto_CF('+ copy(cbPrecos.Items[cbPrecos.ItemIndex],50,08) +' , '+ table.fieldByname('is_ref').asString +' , '+ trim(copy(cb2.Items[cb2.ItemIndex],50,50))+ ' , 0 ) as preco', 'preco', Connection );
     table.Post;

     table.Next;
     form1.Refresh;
     gauge.Progress := gauge.Progress +1;
   end;
   table.First;
{
   while table.Eof = false do
   begin
      table.Edit;
      table.FieldByName('Preco').AsString :=  funcSQL.GetValorWell( sender,'O','Select dbo.Z_CF_funObterPrecoProduto_CF('+ copy(cbPrecos.Items[cbPrecos.ItemIndex],50,08) +' , '+ table.fieldByname('is_ref').asString +' , '+ trim(copy(cb2.Items[cb2.ItemIndex],50,50))+ ' , 0 ) as preco', 'preco', Connection );
      table.Post;
      table.Next;
   end;
}
   table.First;
   grid.Visible := true;
   screen.Cursor := crDefault;
   gauge.Visible := false;
end;

procedure TForm1.CarregarDadosMapaSeparacao(Sender: TObject);
var
   nmTabela,cmd:string;
   qrDados:TADOQuery;
begin
   qrDados := TADOQuery.Create(form1);
   qrDados.Connection := Connection;
   qrDados.SQL.add (' Select ds_uo from tbuo with(noLock) where TP_ESTOQUE in (1,2) order by  tp_estoque, CD_UO ') ;
   qrDados.Open();

   nmTabela :=  '#MapaSeparacao'+funcoes.SohNumeros(dateTimeToStr(now));
   cmd := ' Create table '+nmTabela+ ' ( is_ref int , Código varchar(07), Descrição varchar(30), Cx int ' ;

   while qrDados.eof = false do
   begin
     cmd := cmd + ', ['+ qrDados.Fields[0].AsString + '] int ' ;
     qrDados.Next();
   end;
   cmd := cmd + ')';
   funcSQl.GetValorWell(  'E', cmd, '', form1.Connection );

   Table.Connection := form1.Connection;
   Table.TableName := nmTabela;
   Table.Active := true;
   screen.Cursor := crDefault;
end;

procedure TForm1.fsBitBtn1Click(Sender: TObject);
begin
  lbNivel.Caption := '0';
  lbCodigo.Caption := '0000';
  lbClasse1.Caption := '';
  lbClasse2.Caption := '';
  lbClasse3.Caption := '';
  Application.CreateForm(TFmClasses, FmClasses);
  FmClasses.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and (FileExists('upgrade.exe') )then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;
   connection.Connected := false;
   Connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   connection.Connected := true;

   form1.Top := 1;
   form1.Left := screen.Width - form1.Width;
   form1.Caption := FORM1.Caption + '     ' + connection.DefaultDatabase ;

   cb2.Items := FuncSQL.GetNomeLojas( connection,false,false,'','');
   cb2.ItemIndex := 0;

   cbPrecos.Items := Funcsql.getListaPrecos(Connection,true,true,false);
   cbPrecos.ItemIndex := 0;
end;


procedure TForm1.FormShow(Sender: TObject);
var
   numCampo:smallint;
   nmTabela,cmd:string;
   qrDados:TADOQuery;
begin
   edcodigo.SetFocus;
   if table.TableName = '' then
   begin
      qrDados := TADOQuery.Create(form1);
      qrDados.Connection := Connection;
      qrDados.SQL.add (' Select ds_uo from tbuo with(noLock) where TP_ESTOQUE in (1,2) and cd_uo <> 99 order by  tp_estoque, CD_UO ') ;
      qrDados.Open();

      nmTabela :=  '#MapaSeparacao'+funcoes.SohNumeros(dateTimeToStr(now));
      cmd := ' Create table '+nmTabela+ ' ( is_ref int , Código varchar(07), Descrição varchar(30), Cx int ' ;
      while qrDados.eof = false do
      begin
         cmd := cmd + ', ['+ qrDados.Fields[0].AsString + '] varchar(06) ' ;
         qrDados.Next();
      end;

      cmd := cmd + ', Preco money)';
      funcSQl.GetValorWell(  'E', cmd, '', form1.Connection );

      Table.Connection := form1.Connection;
      Table.TableName := nmTabela;
      Table.Active := true;
    end;
    grid.Columns[0].Visible := false;
    grid.Columns[1].Width := 60;
    grid.Columns[2].Width := 150;
    grid.Columns[3].Width := 50;

    for numCampo := 4 to grid.Columns.Count -1 do
       grid.Columns[numCampo].Width := 60;
    for numCampo := 0 to grid.Columns.Count -1 do
      grid.Columns[numCampo].Title.Font.Style := [fsBold];
end;

procedure TForm1.GetProdutos(Sender: Tobject);
var
   qrMapa:TADOQuery;
   EhDisponivel:string;
begin
   screen.Cursor := crHourGlass;

   if chDisponivel.Checked = true then
      EhDisponivel := '1'
   else
      EhDisponivel := '0';

   qrMapa := TADOQuery.Create(Form1);
   qrMapa.Connection := Connection;
   LimpaTabela(Sender);
   qrMapa.SQL.Clear;
   qrMapa.SQL.add(' Exec zcf_ListarItensMapaEstoque '+
                  ' @cod=' + QuotedStr(edCodigo.Text) +' , '+
                  ' @ordem=' + QuotedStr(intToStr(cbOrdem.iteminDex)) +' , '+
                  ' @EhDisponivel= '+ QuotedStr(ehDisponivel) + ' , '+
                  ' @nvCat= '+ QuotedStr(lbNivel.Caption) +  ' , ' +
                  ' @vlCat='+ QuotedStr(lbCodigo.Caption)  +  ' , ' +
                  ' @ListaTudo = ' + QuotedStr(intToStr(cbTpEstoque.iTemIndex))  +  ' , ' +
                  ' @uo = ' + QuotedStr( copy(cb2.Items[cb2.itemIndex],51,08))
                 );
   qrMapa.SQL.SaveToFile(funcoes.TempDir() + '_GetValorWell.txt' );
   qrMapa.open;

   qrMapa.First;
   while qrMapa.Eof = false do
   begin
      table.AppendRecord([
                          qrMapa.FieldByName('is_ref').AsString,
                          qrMapa.FieldByName('cd_ref').AsString,
                          qrMapa.FieldByName('ds_ref').AsString,
                          funcoes.SohNumeros( qrMapa.FieldByName('qt_emb').AsString )
       ]);
      qrMapa.Next;
   end;
   table.First;
   screen.Cursor := crDefault;
   CarregaEstoqueMapaSeparacao(Sender);
end;

procedure TForm1.LimpaTabela(Sender: Tobject);
begin
    grid.Visible := false;
    while table.IsEmpty = false do
       table.Delete;
    grid.Visible := true;
end;

procedure TForm1.gridDrawColumnCell(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (DataCol > 4 )  then
   begin
      if (Column.Field.AsString <> '0') then
      begin
         Grid.Canvas.Font.Color:= clRed;
         Grid.Canvas.FillRect(Rect);
         Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
   end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  grid.Left := 3;
  grid.Width := form1.Width -15;
  grid.Height := form1.Height - (grid.Top + 40);
end;

procedure TForm1.fsBitBtn2Click(Sender: TObject);
begin
  if (lbNivel.caption = '0') and (length(edCodigo.text) < 3 )  then
     msgTela(form1.Caption, ' É preciso informar o fornecedor no caso de não informar as categorias', mb_iconError + mb_ok)
  else
  begin
     GetProdutos(Sender);
  end;
end;


procedure TForm1.fsBitBtn3Click(Sender: TObject);
begin
{   if table.IsEmpty = false then
      GerarMapaSeparacao(sender);
    }
    funcsql.exportaTable(Table);
end;

procedure TForm1.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
      fsBitBtn2Click(Sender);
end;

end.
