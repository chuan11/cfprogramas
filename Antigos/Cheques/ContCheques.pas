unit ContCheques;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,  Dialogs, Grids, DBGrids, DB, ComCtrls, StdCtrls, Buttons,
  adLabelComboBox, Mask, adLabelMaskEdit, adLabelEdit, ExtCtrls, adLabelNumericEdit, DBXpress, FMTBcd, SqlExpr, DBTables, mxExport,funcoes,
  Menus;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    Cbox1: TadLabelComboBox;
    UpDown1: TUpDown;
    maskedit1: TadLabelMaskEdit;
    Cbox2: TadLabelComboBox;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    edit1: TadLabelEdit;
    edit2: TadLabelEdit;
    Memo1: TMemo;
    medit1: TadLabelMaskEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    StaticText1: TStaticText;
    cbox3: TadLabelComboBox;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    edit3: TLabeledEdit;
    Database1: TDatabase;
    Query1: TQuery;
    Query2: TQuery;
    Label1: TLabel;
    Export1: TmxDBGridExport;
    MEdit2: TMaskEdit;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    Imprimir1: TMenuItem;
    osdestatela1: TMenuItem;
    MEdit3: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    ImpressaoPordatadelancamento1: TMenuItem;
    Query1Ref: TAutoIncField;
    Query1loja: TStringField;
    Query1cliente: TStringField;
    Query1Numcheque: TStringField;
    Query1Vencimento: TDateTimeField;
    Query1Valor: TFloatField;
    Query1porconta: TFloatField;
    Query1Observacao: TStringField;
    Query1lancamento: TDateTimeField;
    function AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure CarregaQuery(sender:tobject);
    function  AjustaData(data:string):String;
    procedure CarregaCampos(sender:tobject);
    procedure Cbox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    function  Erro(sender:Tobject):string;
    procedure IncluirItem(sender:tobject);
    procedure MaskEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure AlterarItem(sender:tobject);
    procedure BitBtn3Exit(Sender: TObject);
    Function  ValidaData(data:string):boolean;
    procedure FormCreate(Sender: TObject);
    function  SomaValores(sender:tobject):string;
    function  ajustaValor2(vlr:string):string;
    function  AjustaValor(Str:string):String;
    function  TiraPontos(s:String):real;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure MEdit2KeyPress(Sender: TObject; var Key: Char);
    function  FloatSqlToStr(str:string):string;
    function  strTofloatSql(str:string):string;
    procedure osdestatela1Click(Sender: TObject);
    procedure AjustaCampos(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure ImpressaoPordatadelancamento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
   TITULO = 'Controle de Cheques';
   PATH = 'C:\CHEQUES\';
   BASE = 'CONT_CHEQUES';
   ARQ_INI = PATH + 'ccd.ini';
var
  Form1: TForm1;

implementation

uses Uimpressao, Unit3;

{$R *.dfm}
function tform1.FloatSqlToStr(str:string):string;
begin
  if pos(',',str) = length(str)-1 then str:= str + '0';
  if pos(',',str) = 0 then str:= str + ',00';
  FloatSqlToStr := str;
end;

function tform1.strTofloatSql(str:string):string;
begin
   insert('.',str,pos(',',str));
   delete(str,pos(',',str),01);
   strTofloatSql := str;
end;

function tform1.ajustaValor2(vlr:string):string;
var
   i:integer;
begin
  while pos('R$',vlr) > 0 do
     delete(vlr, pos('R$',vlr),02);

  while pos(' ',vlr) > 0 do
     delete(vlr, pos(' ',vlr),01);

  if pos(',',vlr) = 0 then
     insert(',00',vlr,length(vlr)+1);

  if pos(',',vlr) = (length(vlr)-1) then
     insert('0',vlr, pos(',',vlr)+1);

  while length(vlr) < 15 do
  insert(' ',vlr,01);
  ajustaValor2 := vlr;

end;

Function tform1.ValidaData(data:string):boolean;
begin
   ValidaData:=true;
   try
      StrToDate(data)
   except
      on e:exception do
         ValidaData := false;
   end;
end;


function JustString(str:string):string;
var
   i:integer;
begin
   while pos(' ',str) > 0 do
      delete(str,pos(' ',str),01);
   JustString := Str;
end;

function tform1.TiraPontos(s:String):real;
begin
  if s <> '' then
  begin
      while pos( ' ',s ) > 0 do
         delete( s ,pos(' ', s ),1);

      while pos( 'R$',s ) > 0 do
         delete( s ,pos('R$', s ),02);

      while pos( '.',s ) > 0 do
         delete( s ,pos('.', s ),1);
   end;
   TiraPontos := strtoFloat(s);
end;

function tform1.AjustaValor(Str:string):String;
var
   i:integer;
begin
   while pos(',',str) > 0 do delete(Str,pos(',',str),01);
   while pos(' ',str) > 0 do delete(Str,pos(' ',str),01);

   if pos(',',str) = 0 then
      insert('.',str,length(str)+1);

    while pos('.',str) < length(str)-3 do
      insert('0',str,length(str)+1);

   AjustaValor :=floattostrf(StrToFloat(funcoes.filtranum(str,02)),ffNumber,18,2);
end;

function TForm1.AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
var
  mes,ano:integer;
  data:string[6];
begin
   mes := strtoint(copy (text,01,02));
   ano := strtoint(copy (text,03,04));
   data := copy (text,01,02) + (copy (text,03,04));
   if button = btnext then
      mes := mes + 1
   else  if button = btprev then
    mes := mes - 1;
   if mes = 13 then
   begin
      mes := 01;
      inc(ano);
   end;
   if mes = 0 then
   begin
      mes := 12;
      dec(ano);
   end;
   data:= ( inttostr(mes) + inttostr(ano));
   while length(data) < 6 do insert('0',data,01);
      AjustaMesANo:=data;
end;

procedure TFORM1.IncluirItem(sender:tobject);
begin
   carregaquery(sender);
   query2.sql.Clear;
   query2.Sql.add(' Insert cheques values ("'+ edit1.text +'" , "'+edit2.text+'" , "'+ ajustadata(medit1.text) +'" , ' + strtoFloatSQl(medit2.text)+ ' , "'+ edit3.text + '" , "'+ cbox3.Items[cbox3.itemindex] + '" , "A"  , "'+ ajustadata(DateToStr(now)) +  '" , '+strtoFloatSQl(medit3.text) +')');
   query2.Sql.savetofile('c:\zteste.txt');
   query2.execsql;
   form1.CarregaQuery(sender);
end;

procedure Tform1.AlterarItem(sender:tobject);
begin
   query2.SQL.Clear;
   query2.SQL.add('update cheques');
   query2.SQL.add('Set loja = ' +#39+  cbox3.Items[cbox3.ItemIndex] +#39+ ', ');
   query2.SQL.add('Cliente = '+#39+ edit1.text +#39+ ', ');
   query2.SQL.add('Numcheque  = '+#39+ edit2.text +#39+ ', ');
   query2.SQL.add('Vencimento = '+#39+ ajustadata(medit1.text) +#39+ ', ');
   query2.SQL.add('Valor = '+ strTofloatSql(medit2.text) + ' , ' );
   query2.sql.add('Porconta = '+ strTofloatSql(medit3.text) + ' , ' );
   query2.SQL.add('Observacao = '+#39+ edit3.text +#39 );
   query2.SQL.add('Where Ref ='+#39+  dbgrid1.Fields[0].asString +#39 );
   memo1.lines:=   query2.SQL;
   query2.ExecSQL;
   carregaQuery(sender);
end;

function Tform1.AjustaData(data:string):String;
begin
   ajustadata := copy(data,04,02)+'/'+copy(data,01,02)+ '/' + copy(data,07,04);
end;


procedure tform1.CarregaCampos(sender:tobject);
begin
   cbox1.Items.LoadFromFile('NumLojas.cfg');
   cbox2.Items.LoadFromFile('organizacao.cfg');
   cbox1.ItemIndex:= StrToInt(funcoes.lerParam(ARQ_INI,00));
   cbox2.ItemIndex:= StrToInt(funcoes.lerParam(ARQ_INI,02));
   maskedit1.text:=funcoes.lerParam(ARQ_INI,01)
end;

function Tform1.SomaValores(sender:tobject):string;
var
   arq:Textfile;
   str:string;
   soma:real;
begin
   soma :=0 ;
   export1.FileName := PATH + 'soma.txt';   
   if fileExists(export1.filename) then
      deletefile(export1.filename);
   export1.Execute;
   assignFile(arq, export1.FileName);
   reset(arq);
   while eof(arq) = false do
   begin
      readln(arq,str);
      if length(str) >10 then
      soma := soma + TiraPontos(( copy(str,112,23) ));
   end;
   CloseFile(arq);
   SomaValores := floattostrf(soma,ffNumber,18,2);//FloatTostr(soma);

end;


procedure tform1.CarregaQuery(sender:tobject);
begin
   query1.SQL.clear;
   query1.SQL.add('Select Ref, loja, cliente, Numcheque, Vencimento, Valor, porconta, Observacao, lancamento from cheques');
   if cbox1.Items[cbox1.ItemIndex] <>  'Todos' then
      query1.SQL.add('where (loja =' +#39+ cbox1.Items[cbox1.ItemIndex] +#39+') and ')
   else
      query1.SQL.add('where');
   query1.SQL.add('( vencimento >= '+#39+ Ajustadata('01/'+ copy(maskedit1.text,01,02)+'/'+copy(maskedit1.text,03,04)) + #39+')');
   query1.SQL.add('and ( status = ' +#39+'A'+#39+')');
   query1.SQL.add('order by ' + cbox2.items[cbox2.itemindex]);
   memo1.Lines := query1.SQL;
//   memo1.lines.SaveToFile('c:\Zteste.txt');
   query1.open;
   label1.caption:='';
   label1.caption := 'Total: ' + SomaValores(sender);
   AjustaCampos(Sender);
end;


procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
   maskedit1.text:= form1.AjustaMesANo(sender, button ,maskedit1.text);
   CarregaQuery(sender);
end;


procedure TForm1.Cbox1Click(Sender: TObject);
begin
  CarregaQuery(sender);
  funcoes.gravaParam(ARQ_INI,IntToStr(cbox1.ItemIndex),00);
  funcoes.gravaParam(ARQ_INI,IntToStr(cbox2.ItemIndex),02);
  funcoes.gravaParam(ARQ_INI,maskedit1.text,01);
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
   statictext1.Caption:= 'Adicionar';
   cbox3.Items := cbox1.Items;
   cbox3.items.Delete(0);
   panel1.visible:= true;
   edit1.setfocus;
   medit2.Text:= '0,00';
   medit3.Text:= '0,00';
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  panel1.Visible := false;
  edit1.Text:='';
  edit2.text:='';
  medit2.Text:='';;
  edit3.text:='';
  medit1.Text:='';
  cbox3.Items.Clear;
  statictext1.Caption:='';
end;


function tform1.Erro(sender:Tobject):string;
var
   msg:string;
begin
   erro := '';
   if edit1.text = '' then
      msg := msg +  #13 +' - Nome do cliente';
   if cbox3.ItemIndex = -1 then
      msg := msg +  #13 +' - Falta a loja';
   if edit2.text = '' then
      msg := msg +  #13 +' - Numero do cheque';
   if (medit1.text = '  /  /    ') or (validaDAta(medit1.text) = false)  then
      msg := msg +  #13 +' - Data de vencimento';
   if msg <> '' then
      msg :=  'Falta Preencher ou está(ão) incorreto(s) o(s) seguinte(s) item(ns) ' + Msg;
   erro := Msg;
end;


procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   if erro(Sender) <>'' then
      application.MessageBox(Pchar(erro(sender)), pchar(TITULO), Mb_ok + MB_Iconerror)
   else
   begin
      if statictext1.Caption = 'Adicionar' then
         IncluirItem(sender);
      if statictext1.Caption = 'Alterar' then
         AlterarItem(sender);
      BitBtn3Click(Sender);
   end;
end;


procedure TForm1.MaskEdit3KeyPress(Sender: TObject; var Key: Char);
begin
   if Key in [',','.'] then Key := '.';
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
   tam:integer;
begin
  tam:=250;
   if bitbtn4.Caption = 'Expande' then
   begin
      form1.height := form1.height + tam;
      dbgrid1.Height:= dbgrid1.Height + tam;
      bitbtn4.caption := 'Retrair';
      bitbtn1.Top:= bitbtn1.Top + tam;
      bitbtn4.Top:= bitbtn4.Top + tam;
      bitbtn5.Top:= bitbtn5.Top + tam;
      bitbtn6.Top:= bitbtn6.Top + tam;
      label1.top:= label1.top + tam;
   end
   else
   begin
      form1.height := form1.height - tam;
      dbgrid1.Height:= dbgrid1.Height - tam;
      bitbtn4.Caption := 'Expande';
      bitbtn1.Top:= bitbtn1.Top - tam;
      bitbtn4.Top:= bitbtn4.Top - tam;
      bitbtn5.Top:= bitbtn5.Top - tam;
      bitbtn6.Top:= bitbtn6.Top - tam;
      label1.top:= label1.top - tam;
   end
end;


procedure TForm1.BitBtn5Click(Sender: TObject);
var
   i:integer;
   a,b:string;
begin
   panel1.visible:= true;
   edit1.text :=dbgrid1.Fields[2].asString;
   edit2.text :=JustString(dbgrid1.Fields[3].asString);

   medit1.text :=JustString(dbgrid1.Fields[4].asString);
   medit2.text := FloatSqltoStr(dbgrid1.Fields[5].asString);
   medit3.text := FloatSqltoStr(dbgrid1.Fields[6].asString);
   edit3.text :=(dbgrid1.Fields[7].asString);   
   cbox3.Items := cbox1.Items;


   for i:=0 to cbox3.Items.Count-1 do
      if JustString(cbox3.Items[i]) = JustString(dbgrid1.Fields[1].asString) then
         cbox3.ItemIndex:= i;
   Statictext1.caption:= 'Alterar';
   edit1.SetFocus;
end;


procedure TForm1.BitBtn6Click(Sender: TObject);
begin
   if application.MessageBox(pchar('Tem certeza que deseja exluir este registro ???'+#13),pchar(TITULO),MB_YESNO + MB_ICONQUESTION) = MRYES then
   begin
      query2.SQL.Clear;
      query2.sql.add('update cheques set status = '+#39+'E'+#39+ 'where Ref ='+#39+  dbgrid1.Fields[0].asString +#39 );
      memo1.lines:= query2.sql;
      query2.execSql;
      Carregaquery(sender);
   end;
end;


procedure TForm1.BitBtn3Exit(Sender: TObject);
begin
   if panel1.Visible then edit1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MyList: TStringList;
begin
  MyList :=TStringList.Create;
  if not Session.IsAlias(BASE) then
  begin
     session.DeleteAlias(base);
     try
       with MyList do
       begin
         Add('SERVER NAME=125.4.4.200');
         Add('USER NAME=ADM');
         Add('DATABASE NAME=CCD')
       end;
       Session.AddAlias((Base), 'MSSQL', MyList);
     finally
       MyList.Free;
     end;
  end;
  database1.DatabaseName := Base;
  query1.databasename:= database1.databasename;
  query2.databasename:= database1.databasename;
  Form1.Caption := TITULO;
  form1.Top :=-3;
  form1.Left:= screen.Width - form1.Width;
  CarregaCampos(sender);
  CarregaQuery(sender);
  BitBtn4Click(Sender);
end;


procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
   BitBtn5Click(Sender);
end;

procedure TForm1.MEdit2KeyPress(Sender: TObject; var Key: Char);
var
  aux :string;
begin
   if (key = ',') {or{(key = '.')} then
   begin
      aux :=medit2.text;
      while pos('_',aux) > 0 do delete(aux,pos('_',aux),01);
      while pos(' ',aux) > 0 do delete(aux,pos(' ',aux),01);
      while length(aux) < 5 do
         insert(' ',aux,01);
      medit2.text := aux;
   end;
end;

procedure TForm1.AjustaCampos(Sender: TObject);
var
  i:integer;
begin
   for i:=0 to DBGrid1.Columns.count-1 do
   begin
      DBGrid1.Columns[i].Title.Color := clBtnFace;
      DBGrid1.Columns[i].Title.Font.Size:= 08;
      DBGrid1.Columns[i].Title.Font.Color := clBlack;
      DBGrid1.Columns[i].Title.Font.Color := clnavy;
   end;

   dbgrid1.Columns[0].title.caption := 'REF';
   dbgrid1.Columns[1].title.caption := 'Lj';
   dbgrid1.Columns[2].title.caption := 'Cliente';
   dbgrid1.Columns[3].title.caption := 'Cheque';
   dbgrid1.Columns[4].title.caption := 'Venc';
   dbgrid1.Columns[5].title.caption := 'Valor';
   dbgrid1.Columns[6].title.caption := 'Por conta';
   dbgrid1.Columns[7].title.caption := 'Observ';
   dbgrid1.Columns[8].title.caption := 'lancamento';


   DBGrid1.Columns[0].Width := 10;
   DBGrid1.Columns[1].Width := 30;
   DBGrid1.Columns[2].Width := 150;
   DBGrid1.Columns[3].Width := 60;
   DBGrid1.Columns[4].Width := 60;
   DBGrid1.Columns[5].Width := 45;
   DBGrid1.Columns[6].Width := 45;
   DBGrid1.Columns[7].Width := 150;
   DBGrid1.Columns[6].Width := 45;
   export1.Execute;
end;

procedure TForm1.osdestatela1Click(Sender: TObject);
begin
   Application.CreateForm(TForm2, Form2);
   FORM2.Show;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   AjustaCampos(Sender);
end;

procedure TForm1.MEdit3KeyPress(Sender: TObject; var Key: Char);
var
  aux :string;
begin
   if (key = ',') {or{(key = '.')} then
   begin
      aux :=medit3.text;
      while pos('_',aux) > 0 do delete(aux,pos('_',aux),01);
      while pos(' ',aux) > 0 do delete(aux,pos(' ',aux),01);
      while length(aux) < 5 do
         insert(' ',aux,01);
      medit3.text := aux;
   end;
end;

procedure TForm1.ImpressaoPordatadelancamento1Click(Sender: TObject);
begin
   Application.CreateForm(TForm3, Form3);
   form3.show;
end;

end.
