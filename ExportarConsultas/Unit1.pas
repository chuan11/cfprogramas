unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, ExtCtrls, TFlatMemoUnit,
  ComCtrls, TFlatButtonUnit, DB, ADODB, funcoes, Grids, DBGrids, funcsql,mxExport,
  TFlatCheckBoxUnit, uEmail, SoftDBGrid, adLabelNumericEdit,
  adLabelSpinEdit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edServer: TadLabelEdit;
    edUser: TadLabelEdit;
    edPassword: TadLabelEdit;
    cbDds: TadLabelComboBox;
    StatusBar1: TStatusBar;
    DataSource1: TDataSource;
    Qr: TADOQuery;
    btConfirma: TFlatButton;
    FlatButton1: TFlatButton;
    cb1: TComboBox;
    FlatButton3: TFlatButton;
    edMail: TadLabelEdit;
    FlatCheckBox1: TFlatCheckBox;
    mxDataSetExport1: TmxDataSetExport;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    memo: TFlatMemo;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    cbTabelas: TadLabelComboBox;
    conexao: TADOConnection;
    tb: TADOTable;
    SoftDBGrid1: TSoftDBGrid;
    DataSource2: TDataSource;
    edFiltro: TadLabelEdit;
    edNumLihas: TadLabelSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbDdsDropDown(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure msgRodape(msg:string;panel:smallInt);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cb1Change(Sender: TObject);
    procedure executa(Sender:Tobject);   procedure FlatButton3Click(Sender: TObject);   procedure cbTabelasDropDown(Sender: TObject);    procedure conexaoWillExecute(Connection: TADOConnection;      var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure SoftDBGrid1TitleClick(Column: TColumn);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure getConexao(Sender:Tobject; db:String);

  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.getConexao(Sender:Tobject; db:String);
begin
   if conexao.Connected = true then
     conexao.Close();
   conexao.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=' +edUser.text + ';Password=' + edPassword.Text + ';Initial Catalog='+ db +';Data Source=' + edServer.text;
   conexao.Connected := true;   
end;

procedure TForm1.cbDdsDropDown(Sender: TObject);
begin
   conexao.LoginPrompt := false;
   getConexao(nil, 'master');
   cbDds.Items :=  funcSql.getListagem('Select name from sysdataBases order by name' , conexao );
end;

procedure tform1.executa(Sender:Tobject);
var
   senha, str,cmd:String;
   i:integer;
begin
  screen.Cursor := crHourGlass;

  msgRodape('',00);  msgRodape('Inicio: ' + datetimeToStr(now),01);  msgRodape('',2);
  qr.SQL.Clear();
  form1.Refresh();
  try
      for i:= 0 to memo.Lines.Count -1 do
         cmd := cmd + memo.lines[i] + ' ';
      qr.SQL.Add(cmd);
      cmd := 'Begin '+ #13 + cmd + #13 + ' end';

       funcoes.gravaLog(cmd);

       getConexao(nil,   cbDds.Items[cbDds.itemIndex]);

       qr.Connection := conexao;

      if cbDds.itemIndex > -1 then
      begin
         qr.Open;
         msgRodape(inttoStr(qr.RecordCount) + ' linha(s). ' ,0);
      end
      else
         msgRodape('Selecione um banco!',2);
  except
     on e:exception do
     showmessage(e.message);
  end;
  screen.Cursor := crDefault;
  msgRodape('Fim: '+ datetimeToStr(now),02);
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   arq:String;
begin
//      btConfirmaClick(Sender);
      if FlatCheckBox1.Checked = false then
         funcsql.exportaQuery(qr,false,'')
      else
      begin
         arq := 'c:\Exportacao_' +  funcoes.SohNumeros(dateTimeToStr(now)) +'.xls';
         funcsql.exportaQuery(qr,true,arq);
         uEmail.enviarEmail( edMail.Text,'Exportação de consulta - ' + arq , arq, nil, conexao );
      end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
   aux:string;
begin
   if fileExists( funcoes.TempDir()+ 'cb1.Log') then
      cb1.Items.LoadFromFile( funcoes.TempDir()+ 'cb1.Log');
   carregaCampos(form1);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   salvaCampos(Form1);
   while cb1.Items.Count > 10 do
      cb1.Items.Delete(cb1.Items.count -1);
   cb1.Items.SaveToFile(funcoes.TempDir()+ 'cb1.Log');
end;


procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
   funcSQL.OrganizarQuery(qr, column);
end;

procedure TForm1.msgRodape(msg: string; panel: smallInt);
begin
    form1.StatusBar1.Panels[panel].Text :=    Msg;
    form1.Refresh;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_F5 then btConfirmaClick(nil);
end;
procedure TForm1.FlatButton3Click(Sender: TObject);
var
   str:String;
begin
   str := funcoes.DialogAbrArq('*.SQL', 'c:\');
   if str <> '' then
   begin
      cb1.Items.Add(str);
      cb1.ItemIndex := cb1.Items.Count-1;

      memo.lines.Clear;
      if fileExists(str) = true then
         memo.lines.LoadFromFile(str);
   end;
end;

procedure TForm1.cb1Change(Sender: TObject);
begin
    memo.Lines.LoadFromFile(cb1.Items[cb1.itemIndex]);
end;

procedure TForm1.cbTabelasDropDown(Sender: TObject);
begin
   if (cbTabelas.Items.Count < 1) and ( cbDds.ItemIndex > -1 ) then
   begin
      conexao.LoginPrompt := false;
      if conexao.Connected = true then
         conexao.Close();
      conexao.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=' +edUser.text + ';Password=' + edPassword.Text + ';Initial Catalog=' + cbDds.Items[ cbDds.itemIndex ]  + ';Data Source=' + edServer.text;
      cbTabelas.Items :=  funcSql.getListagem('Select name from sysObjects (nolock) where xtype = ''u'' order by name' , conexao );
   end;
end;

procedure TForm1.conexaoWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   Screen.Cursor := crHourGlass;
   Funcoes.gravaLog(CommandText);
   Screen.Cursor := crDefault;
end;

procedure TForm1.SoftDBGrid1TitleClick(Column: TColumn);
begin
   funcsql.OrganizarTabela(tb, Column);
end;

procedure TForm1.TabSheet2Enter(Sender: TObject);
begin
   qr.Close();
end;

procedure TForm1.TabSheet1Enter(Sender: TObject);
begin
   tb.Close();
   cbTabelas.Clear();
end;

procedure TForm1.btConfirmaClick(Sender: TObject);
var
  i:integer;
begin
   if (PageControl1.TabIndex = 0) then
   begin
      if cb1.Items[cb1.ItemIndex] <> '' then
          memo.Lines.SaveToFile( cb1.Items[cb1.ItemIndex]);
      if( FileExists( cb1.Items[cb1.itemIndex]) = true ) or ( memo.Lines.count  > 0 ) then
        executa(nil);

   end
   else
   begin
      if (tb.Active = true ) then
         tb.Close();

      tb.TableName := cbTabelas.Items[cbTabelas.ItemIndex];
//      if edFiltro.Text <> '' then
      begin
        tb.Filter := edFiltro.Text;
        tb.Filtered := true;
      end;
//      else
//        tb.Filtered := false;

      if edNumLihas.Value > -1 then
        tb.MaxRecords :=  StrToint(FloatToStr(edNumLihas.Value))
      else
        tb.MaxRecords := 0;
      tb.Open();

      for i := 0 to SoftDBGrid1.Columns.Count -1 do
      SoftDBGrid1.Columns[i].Title.Font.Style := [fsBold];
   end;
   StatusBar1.Panels[1].Text := conexao.DefaultDatabase;
end;


end.
