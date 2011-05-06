unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, DB, ADODB,comObj, ExtCtrls,funcoes, StdCtrls,
  TFlatButtonUnit, adLabelEdit, SoftDBGrid, mxExport, RpRave, RpBase,
  RpSystem, RpDefine, RpCon, RpConDS, TFlatEditUnit, adLabelComboBox,
  ComCtrls, adLabelNumericEdit, adLabelSpinEdit, Menus, AppEvnts ;

type
  TForm1 = class(TForm)
    Query1: TADOQuery;
    ADOConnection1: TADOConnection;
    edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    Export1: TmxDataSetExport;
    CheckBox1: TCheckBox;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    RvProject1: TRvProject;
    cb2: TadLabelComboBox;
    cb1: TadLabelComboBox;
    cb3: TadLabelComboBox;
    cb4: TadLabelComboBox;
    FlatButton2: TFlatButton;
    Bt_Saidas: TFlatButton;
    Bt_Entradas: TFlatButton;
    Panel2: TPanel;
    spedit: TadLabelSpinEdit;
    Label1: TLabel;
    FlatButton3: TFlatButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Query1Cdigo: TStringField;
    Query1Descrio: TStringField;
    Query1DataUltimaEnt: TDateTimeField;
    Query1QuantUltimaEnt: TIntegerField;
    Query1TotalVenda: TIntegerField;
    Query1Estoque: TIntegerField;
    Query1EstoqueCD: TIntegerField;
    Query1is_ref: TIntegerField;
    Query1PV: TFloatField;
    FlatButton4: TFlatButton;
    Animate: TAnimate;
    ApplicationEvents1: TApplicationEvents;
//    function ExportaQuery(Query:TadoQUery):boolean;
    procedure FormCreate(Sender: TObject);
    function GetNumLojas(sender: tobject): Tstrings;
    function GetNomeLojas(sender: tobject): Tstrings;
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CalcularEstoque(sender:tobject);
    procedure LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure ADOConnection1ExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;      var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure Bt_EntradasClick(Sender: TObject);
    procedure Bt_SaidasClick(Sender: TObject);
    procedure AJustaDbgridNaTela(sender:tobject);
    procedure FormResize(Sender: TObject);
    function GetIniDtVen():string;
    procedure speditChange(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure GerarMapaSeparacao(sender:tobject);
    procedure cb2Change(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure MosraFormSaldos(sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    function  GetUoCd(sender: tobject): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  UO_CD:string;

implementation
uses unit2, Unit4,unit3,unit5;

{$R *.dfm}
function TForm1.GetIniDtVen: string;
var
  aux:string;
begin
   shortdateformat := 'dd/MM/yyyy';
  if form1.spedit.Value < 1 then
     spedit.Value := 1;
  AUX := (DateToStr(now - (30 * spedit.Value)));
  delete(aux,01,02);
  insert('01',aux,01);
  result := funcoes.StrToSqlDate(aux);
  shortdateformat := 'dd/MM/yy';
end;

procedure TForm1.SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
    funcoes.WParReg('PosEstoque','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
end;

procedure Tform1.LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount -1 do
   begin
      dbgrid.Columns[i].Title.Font.name := 'MS Sans Serif';
      dbgrid.Columns[i].Title.Font.size := 06;
      dbgrid.Columns[i].Title.Font.Style := [fsbold];
      if funcoes.RParReg('PosEstoque','Z_' +NomeForm+ '_'+ IntToStr(i) ) <> '' then
         dbgrid.Columns[i].width := StrToint( funcoes.RParReg('PosEstoque','Z_' +NomeForm+ '_'+ IntToStr(i))  );
   end;
   if checkBox2.Checked = true then
      Softdbgrid1.Columns[6].Visible := true
   else
      Softdbgrid1.Columns[6].Visible := false;
end;

procedure TForm1.CalcularEstoque(sender: tobject);
var
   aux:String;
begin
   Query1.SQL.Clear;

//   if cb2.itemindex = 0 then
   if funcoes.SohNumeros (Copy(cb2.Items[cb2.itemIndex],51,08)) = UO_CD then
      aux:= ' Exec dbo.Z_CF_ListaEstoqueFornCD '
   else
   begin
      aux:= ' Exec dbo.Z_CF_ListaEstoqueFornLoja ' +
      copy(cb2.Items[cb2.itemIndex],51,08) + ', ';
   end;
   aux := aux +
   quotedstr(edit1.text)   + ', ' +
   inttostr(cb3.ItemIndex) + ', ' +
   inttostr(cb4.ItemIndex) + ', ' +
   funcoes.SohNumeros( copy(cb1.Items[cb1.itemIndex],50,05)) + ', ' +
   GetIniDtVen() +' , '+
   UO_CD +' , ';
   if checkBox3.Checked = true then
      aux := aux + '1'
   else
      aux := aux +'0';

   query1.sql.add(aux);
   query1.SQL.SaveToFile(funcoes.TempDir()+'Query_'+form1.Caption+'.txt');

   Query1.Open;
   if checkBox1.Checked = true then
   begin
      export1.FileName := 'Planilha_'+ funcoes.SohNumeros(datetimeToStr(now)) +'.xls';
      export1.Execute;
      winexec( pchar('C:\Arquivos de programas\Microsoft Office\OFFICE11\EXCEL.EXE ' +  export1.FileName), SW_NORMAL )
   end;
   cb1.SetFocus;
   edit1.setfocus;
end;


function TForm1.GetUoCd(sender: tobject): String;
var
   query:tadoquery;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add(' Select top 01 is_uo from tbuo where tp_estoque = 1');
   query.Open;
   query.First;
   Result := query.Fields[0].AsString;
   query.Next;
   query.Destroy;
end;



function TForm1.GetNumLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('Select DS_TIPOPRECO, tp_preco from ttpco ');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(query.Fields[0].AsString+query.Fields[1].AsString );
      query.Next;
   end;

   aux.Add('Preco medio custo unico (5)                       5');
   aux.Add('Preco custo ultima compra (10)                    10');
   aux.Add('Preco custo loja  (1)                             1');
   aux.Add('Preco medio loja  (2)                             2');


   Result := aux;
   query.Destroy;
// descricao do 01 ao 50
//is_uo do 51 ao 58
end;
function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := ADOConnection1;
   query.SQL.Clear;
   query.SQL.Add('select ds_uo,is_uo from tbuo where TP_ESTOQUE in (1,2) order by ds_uo');
   query.Open;

   aux := TstringList.create();
   query.First;
   while query.Eof = false do
   begin
      aux.add(funcoes.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
   if not(query1.IsEmpty) then
   begin
      rvproject1.SetParam('loja', copy(cb2.Items[cb2.itemindex],01,30)) ;
      rvproject1.SetParam('TpVenda', copy(cb1.Items[cb1.itemindex],01,30)) ;
      rvproject1.SetParam('TPestoque', cb3.Items[cb3.itemindex]) ;
      rvproject1.SetParam('Ordenacao', cb4.Items[cb4.itemindex]) ;
      rvproject1.SetParam('codigo', edit1.text) ;
      if checkBox2.Checked = true then
         rvproject1.SetParam('estoqueCd', 'Estoque CD') ;
      rvproject1.ExecuteReport('Report2');
   end;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
   edit1.SetFocus;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case key of
      vk_return : FlatButton1Click(Sender);
      VK_F6:Bt_EntradasClick(Sender);
      VK_F7:Bt_SaidasClick(Sender);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   cb1.items := GetNumLojas(sender);
   cb2.items :=GetNomeLojas(sender);
   UO_CD  := GetUoCd(Sender);

   form1.Top := 50;
   form1.left := 200;

   if funcoes.RParReg('Estoque','loja') <> '' then
      cb2.itemindex := StrToInt(funcoes.RParReg('Estoque','loja'));

   if funcoes.RParReg('Estoque','venda') <> '' then
      cb1.itemindex := StrToInt(funcoes.RParReg('Estoque','venda'));

   if funcoes.RParReg('Estoque','estoque') <> '' then
      cb3.itemindex := StrToInt(funcoes.RParReg('Estoque','estoque'));

   if funcoes.RParReg('Estoque','ordem') <> '' then
      cb4.itemindex := StrToInt(funcoes.RParReg('Estoque','ordem'));

   if funcoes.RParReg('Estoque','MesDefault') <> '' then
     spedit.value := strToFloat( funcoes.RParReg('Estoque','MesDefault') );

   if funcoes.RParReg('Estoque','FormLeft') <> '' then
     Form1.Left := strToInt( funcoes.RParReg('Estoque','FormLeft'))
   else
     Form1.Left := 0;

   if funcoes.RParReg('Estoque','FormTop') <> '' then
     Form1.top := strToInt( funcoes.RParReg('Estoque','FormTop'))
   else
     Form1.top := 0;

   if funcoes.RParReg('Estoque','FormHeight') <> '' then
     Form1.Height := strToInt( funcoes.RParReg('Estoque','FormHeight'));

   if funcoes.RParReg('Estoque','FormWidth') <> '' then
     Form1.Width := strToInt( funcoes.RParReg('Estoque','FormWidth'));

   if funcoes.RParReg('Estoque','EhEstDisponivel') <> '' then
      if funcoes.RParReg('Estoque','EhEstDisponivel') = '1' then
         checkBox3.Checked := true;

   cb2Change(Sender);
   shortdateformat := 'dd/MM/yy';
   rvProject1.ProjectFile := 'PosicaoEstoquePorLojaPreco.rav';

   if fileExists('C:\Arquivos de programas\Microsoft Office\OFFICE11\EXCEL.EXE') then
   begin
      flatbutton3.Visible := true;
      checkBox1.visible := true;
   end;
   if fileExists('RelEstoque.ini') = false then
   begin
      funcoes.GravaLinhaEmUmArquivo( 'RelEstoque.ini', '00 Codigo interno do CD=10033674');
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   SalvaColDbgrid('Form1',softDbGrid1);
   funcoes.WParReg('Estoque','loja', inttoStr(cb2.ItemIndex));
   funcoes.WParReg('Estoque','venda', inttoStr(cb1.ItemIndex));
   funcoes.WParReg('Estoque','estoque', inttoStr(cb3.ItemIndex));
   funcoes.WParReg('Estoque','ordem', inttoStr(cb4.ItemIndex));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(Form1.left));
   funcoes.WParReg('Estoque','FormWidth', inttoStr(Form1.Width));
   funcoes.WParReg('Estoque','FormTop', inttoStr(Form1.top));
   funcoes.WParReg('Estoque','FormHeight', inttoStr(Form1.Height));
   funcoes.WParReg('Estoque','FormLeft', inttoStr(Form1.left));
   funcoes.WParReg('Estoque','MesDefault',FloatToStr(spedit.value)) ;

   if checkBox3.Checked = true then
      funcoes.WParReg('Estoque','EhEstDisponivel','1')
   else
      funcoes.WParReg('Estoque','EhEstDisponivel','0')
end;

procedure TForm1.ADOConnection1WillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
begin
   SCREEN.Cursor := CRHOURGLASS;
end;

procedure TForm1.ADOConnection1ExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   SCREEN.Cursor := CRdEFAULT;
end;
procedure TForm1.Bt_EntradasClick(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   if query1.IsEmpty = false then
   begin
      Application.CreateForm(TForm2, Form2);
      form2.show;
      form2.ConsultaDetalhesEntrada(sender, query1.FieldByName('Is_ref').AsString, query1.FieldByName('código').AsString, query1.FieldByName('descrição').AsString );
      Bt_Entradas.Enabled := false;
   end;
   screen.Cursor := crdefault;
end;

procedure TForm1.Bt_SaidasClick(Sender: TObject);
begin
   screen.Cursor := crHourGlass;
   if query1.IsEmpty = false then
   begin
      Application.CreateForm(TForm4, Form4);
      form4.show;
      Bt_Saidas.Enabled := false;
      form4.FlatButton1Click(Sender);
   end;
   screen.Cursor := crdefault;
end;

procedure TForm1.AJustaDbgridNaTela(sender: tobject);
begin
  with softdbgrid1 do
  begin
     Left := 5;
     width := form1.Width - 17;
     height := form1.height - 200;
     top := 124
  end;
  panel2.top := softdbgrid1.Top +softdbgrid1.Height + 2;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   AJustaDbgridNaTela(sender);
end;

procedure TForm1.speditChange(Sender: TObject);
begin
  if spedit.Value < 1 then
     spedit.Value := 1
end;

procedure TForm1.GerarMapaSeparacao(sender: tobject);
var
  Excel : Variant;
  q:TadoQuery;
  i,Linha:integer;
  aux:string;
begin
   q := TadoQuery.Create(query1);
   q.Connection := ADOConnection1;

   aux := '';
   aux := ' Exec dbo.Z_CF_MapaSeparacao ' + quotedstr(edit1.text)+ ','+ InttoStr(cb4.itemindex) + ', ';
   if checkBox3.Checked = true then
      aux := aux + '1'
   else
      aux := aux +'0';

   q.SQL.Clear;
   q.SQL.Add(aux);
   q.Open;

   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'MPD.xls');

   Linha:=3;
   While Q.Eof = false do
   Begin
      for i:=0 to Q.FieldCount -1 do
      begin
         Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+2]:= trim(Q.Fields[i].AsVariant);
      end;
      Q.Next;
      inc(Linha);
   end;
   Excel.Visible :=True;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   if length(edit1.text) > 2 then
     if FileExists(ExtractFilePath(ParamStr(0))+'MPD.xls') then
        GerarMapaSeparacao(sender)
     else
        application.MessageBox(pchar('Está faltando o arquivo '+ ExtractFilePath(ParamStr(0))+'MPD.xls'),pchar(form1.caption), mb_iconerror+mb_Ok);
end;

procedure TForm1.cb2Change(Sender: TObject);
begin
   if cb2.ItemIndex > 0 then
      checkBox2.Checked := true
   else
      checkBox2.Checked := false;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   animate.Visible := true;
   softdbgrid1.Visible := false;
   if length(edit1.text) > 2 then
   begin
      CalcularEstoque(sender);
      form1.LerColunasDbgrid('form1',softDbgrid1);
   end;
   softdbgrid1.Visible := true;
   animate.Visible := False;
   screen.Cursor := crdefault;
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
  if not(query1.IsEmpty) then
     MosraFormSaldos(sender);
end;

procedure TForm1.MosraFormSaldos(sender: TObject);
var
  EhDisponivel,programa:string;

begin
   screen.Cursor := crhourGlass;

   if checkBox3.Checked then
      EhDisponivel := '0'
   else
      EhDisponivel := '1';

   programa := ExtractFilePath(ParamStr(0)) + 'ResumoEstoque.exe "'+ 'ResumoDoEstoque" '+query1.FieldByName('código').asString+' "'+query1.FieldByName('descrição').asString+'" '+query1.FieldByName('is_ref').asString +' "'+ EhDisponivel;

   PostMessage(FindWindow(nil, 'ResumoDoEstoque'), WM_CLOSE,0,0);
   winExec(pchar(programa) , sw_normal);
   screen.Cursor := crDefault;
{
   Application.CreateForm(TForm5, Form5);
    if Form5 = nil then
     form5.Close;
    Application.CreateForm(TForm5, Form5);
   form5.show;
   if checkBox3.Checked = true then
      form5.Obterestoques(sender, query1.FieldByName('Is_ref').asString, '1' )
   else
      form5.Obterestoques(sender, query1.FieldByName('Is_ref').asString, '0' );

   form5.lbCod.caption := query1.FieldByname('código').asString ;
   form5.lbDesc.caption := copy(query1.FieldByname('Descrição').asString,01,30) ;
   screen.Cursor := crDefault;
}

//ResumoDoEstoque
//   PostMessage(FindWindow(nil, 'ResumoDoEstoque'), WM_CLOSE,0,0);
//c:\ProgramasDiversos\ResumoEstoque.exe ResumoDoEstoque cod desc 022
//   winExec(pchar(' ResumoDoEstoque ' +      ), sw_normal);
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
    animate.Visible := false;
    Application.MessageBox( pchar(' Houve um erro de execução, o erro foi ' +#13+ e.message), pchar(form1.Caption), mb_ok + mb_iconerror );
end;

end.  //#,###,###0.00



