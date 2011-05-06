unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, DB, ADODB, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelEdit, funcoes, ExtCtrls, adLabelComboBox,   funcsql,
  TFlatCheckBoxUnit, Menus, Spin ;

type
  TForm1 = class(TForm)
    EdCodigo: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    LBItens: TListBox;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Connection: TADOConnection;
    Query: TADOQuery;
    DataSource1: TDataSource;
    FlatButton3: TFlatButton;
    EdLocalImp: TadLabelEdit;
    Label2: TLabel;
    cbPrecos: TadLabelComboBox;
    cbLojas: TadLabelComboBox;
    chpesqPreco: TfsCheckBox;
    edQuant: TSpinEdit;
    Label3: TLabel;
    cbSegPreco: TadLabelComboBox;
    Button1: TButton;
    edMensagem: TadLabelEdit;
    Procedure ListaEansProduto(sender:tobject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure AdicionaProdutoParaImpressao(sender:tobject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LBItensDblClick(Sender: TObject);
    procedure EdCodigoKeyPress(Sender: TObject; var Key: Char);
    function QuantEtiquetas(sender:Tobject):integer;
//    procedure imprimeDynaPos(sender:Tobject);
//    procedure imprimeArgox(sender:Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  GetNomeLojas(sender: tobject): Tstrings;
    function  getPrecos(sender: tobject): Tstrings;
    procedure Palets1Click(Sender: TObject);
    procedure Endereco1Click(Sender: TObject);
    procedure imprimeGondolaArgox(sender: Tobject);
    procedure ConnectionWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure imprimeGondolaArgoxFreitas(sender: Tobject);
    procedure EdCodigoExit(Sender: TObject);

  private
//    procedure FlatButton2Click(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

uses upallet;

function TForm1.getPrecos(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := Connection;
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
   Result := aux;
   query.Destroy;
//   AUX.ADD('Preco de custo                                     1');
//   AUX.ADD('Custo ultima compra                               10');
// descricao do 01 ao 50
//is_uo do 51 ao 58
end;

function TForm1.GetNomeLojas(sender: tobject): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(query);
   query.Connection := Connection;
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


procedure TForm1.ListaEansProduto(sender: tobject);
var
  Cmd:string;
begin
   cmd := '';
   cmd := 'exec zcf_getDadosParaEtiqueta ' +
           QuotedStr( FUNCOES.SohNumeros(EdCodigo.text))  +' , '+
           funcoes.SohNumeros((copy(cbLojas.Items[cbLojas.ItemIndex],50,100))) +' , ' +
           funcsql.getCodPreco(cbPrecos) + ' , ' +
           funcsql.getCodPreco(cbSegPreco);

   query.SQL.clear;
   query.SQL.Add(cmd);

   query.Open;
   dbgrid.Columns[0].Width :=  50;
   dbgrid.Columns[1].Width :=  85;
   dbgrid.Columns[2].Width :=  200;
   dbgrid.Columns[3].Visible:= FALSE;
   dbgrid.Columns[4].Width := 50;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe' )) then
   begin
       winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_normal);
      application.terminate;
   end;

   connection.ConnectionString := funcoes.getDadosConexaoUDL( extractFilePath( ParamStr(0)) + 'ConexaoAoWell.ini' );
   connection.Connected := true;

   cbLojas.Items := form1.GetNomeLojas(Sender);
   cbPrecos.Items := FUNCSQL.getListaPrecos(Connection, FALSE, true, false);
//   form1.getPrecos(sender);
   cbSegPreco.Items := cbPrecos.Items;

   form1.top := 25 ;
   form1.Left := screen.Width - form1.Width;

   chpesqPreco.Checked :=true;
   funcoes.carregaCampos(Form1);
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.salvaCampos(form1);
   connection.Close;
end;


procedure TForm1.AdicionaProdutoParaImpressao(sender: tobject);
begin
   lbItens.Items.add(
                      funcoes.preencheCampo(08,' ', 'd', query.fieldByName('codigo').asString )+
                      funcoes.preencheCampo(20,' ', 'd', query.fieldByName('ean').asString )+
                      funcoes.preencheCampo(40,' ', 'd', copy(query.fieldByName('descricao').asString,01,40)) + ' '+
                      funcoes.preencheCampo(04,'0', 'E', inttoStr(edQuant.Value) ) +' '+
                      funcoes.preencheCampo(15,' ', 'E', floattostrf(Query.fieldByname('PcPrincipal').asfloat ,ffNumber,18,2)   )+ ' ' +
                      funcoes.preencheCampo(15,' ', 'E', floattostrf(Query.fieldByname('PcSecundario').asfloat ,ffNumber,18,2)   )
                    );
   edCodigo.Text:='';
   edCodigo.SetFocus;
   query.SQL.Clear;
end;


{
procedure TForm1.imprimeDynaPos(sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  arq:string;
begin
//--   arq:='Etiquetas.txt';
   ARQ := EdLocalImp.Text;
   DeleteFile(arq);

   itens := Tstringlist.Create();
   for i := 0 to LBItens.Count - 1 do
      for j:= 1 to StrToInt(copy(LBItens.items[i],69,05) ) do
         itens.Add(
                     copy(LBItens.items[i],09,13)+' '+  // eAN
                     copy(LBItens.items[i],29,55)+' '+  // dESCRICAO
                     copy(LBItens.items[i],01,07)+' '+  // CODIGO
                     copy(LBItens.items[i],80,11)+' '  // preco
                   );

   funcoes.GravaLinhaEmUmArquivo(arq, 'N');
   funcoes.GravaLinhaEmUmArquivo(arq, 'Q200,24');
   funcoes.GravaLinhaEmUmArquivo(arq, 'q800' );
   i:=0;
   while i <= itens.Count -1 do
   begin
      if i <= itens.Count -1 then
      begin
         // a é texto, b é codBarras  X, Y, o inicio é a direita,
         funcoes.GravaLinhaEmUmArquivo(arq, 'B265,180,2,E30,2,2,70,B,"' + copy(itens[i], 01,13));
         funcoes.GravaLinhaEmUmArquivo(arq, 'A265,088,2,2,1,1,N,"' + copy(itens[i], 15, 20) + '"');
         funcoes.GravaLinhaEmUmArquivo(arq, 'A265,070,2,2,1,1,N,"' + copy(itens[i], 35, 20) + '"');

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, 'A265,030,2,3,1,1,N,"  R$ '+ copy(itens[i],81,10) + '"');
      end;

      inc(i);
      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, 'B515,180,2,E30,2,2,70,B,"' + copy(itens[i], 01,13));
         funcoes.GravaLinhaEmUmArquivo(arq, 'A515,088,2,2,1,1,N,"' + copy(itens[i], 15, 20) + '"');
         funcoes.GravaLinhaEmUmArquivo(arq, 'A515,070,2,2,1,1,N,"' + copy(itens[i], 35, 20) + '"');

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, 'A515,030,2,3,1,1,N,"  R$ '+ copy(itens[i],81,10) + '"');
      end;

      inc(i);
      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, 'B775,180,2,E30,2,2,70,B,"' + copy(itens[i], 01,13));
         funcoes.GravaLinhaEmUmArquivo(arq, 'A775,088,2,2,1,1,N,"' + copy(itens[i], 15, 20) + '"');
         funcoes.GravaLinhaEmUmArquivo(arq, 'A775,070,2,2,1,1,N,"' + copy(itens[i], 35, 20) + '"');
         funcoes.GravaLinhaEmUmArquivo(arq, 'A775,040,2,2,1,1,N,"' + copy(itens[i], 61, 07) + '"');

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, 'A775,030,2,3,1,1,N,"  R$ '+ copy(itens[i],81,10) + '"');
      end;
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq,'P1');
      funcoes.GravaLinhaEmUmArquivo(arq,'N');
   end;
   Winexec( pchar('cmd.exe /c print /d:'+ EdLocalimp.text+' '+arq)  , sw_normal);
   lbitens.Clear;
   EdCodigo.SetFocus;
   EDqUANT.SetFocus;
   EdCodigo.SetFocus;
   EdCodigo.Text:='';
end;


procedure TForm1.imprimeArgox(sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  cmd,arq:string;
  x01,x02,x03,y01,y02,y03,y04:string;
begin

   arq:=   funcoes.TempDir() + '_Etiquetas.txt';

   DeleteFile(arq);

   itens := Tstringlist.Create();
   for i := 0 to LBItens.Count - 1 do
      for j:= 1 to StrToInt(copy(LBItens.items[i],69,05) ) do
         itens.Add(
                     copy(LBItens.items[i],09,13)+' '+  // eAN
                     copy(LBItens.items[i],29,55)+' '+  // dESCRICAO
                     copy(LBItens.items[i],01,07)+' '+  // CODIGO
                     copy(LBItens.items[i],80,11)+' '  // preco
                   );
   itens.saveToFile( funcoes.TempDir() + '_itenscodigoBarras.txt');

   i:=0;

   x01 := '0010';
   x02 := '0140';
   x03 := '0265';

   y01 := '0050';
   y02 := '0035';
   y03 := '0020';
   y04 := '0005';

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');

      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, '2F31025'+ y01 + '0020' + copy(itens[i], 01,13));
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y02 + x01 + copy(itens[i], 15, 20));
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y03 + x01 + copy(itens[i], 35, 20) );

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, '1012000' + y04 + x01 + '   R$ '+ copy(itens[i],81,10)  );
      end;

      inc(i);
      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, '1F31025'+ y01 + '0150' + copy(itens[i], 01,13));
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y02 + x02 + copy(itens[i], 15, 20) );
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y03 + x02 + copy(itens[i], 35, 20) );

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
         funcoes.GravaLinhaEmUmArquivo(arq, '1012000' + y04  + x02 + '   R$ '+ copy(itens[i],81,10)  );

      end;

      inc(i);
      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, '1F31025'+ y01 + '0280' + copy(itens[i], 01, 13) );
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y02 + x03 + copy(itens[i], 15, 20) );
         funcoes.GravaLinhaEmUmArquivo(arq, '1011000'+ y03 + x03 + copy(itens[i], 35, 20) );

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, '1012000'+ y04 + x03 + '   R$ '+ copy(itens[i],81,10)  );

      end;
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   end;

   cmd := 'Print /d:'+ EdLocalimp.text+' '+arq;
   Winexec( pchar(cmd)  , sw_normal);
end;
}

procedure TForm1.LBItensDblClick(Sender: TObject);
begin
   LBiTENS.DeleteSelected;
end;

procedure TForm1.EdCodigoKeyPress(Sender: TObject; var Key: Char);
begin
   if (key = #13) then
      FlatButton3Click(Sender);
end;

function TForm1.QuantEtiquetas(sender: Tobject):integer;
var
   som,i:integer;
   linha:String;
begin
   som :=0;
   for i:= 0 to lbitens.Count - 1 do
   begin
      linha := lbitens.Items[i];
      som := som +StrToint(copy(linha,69,05));
   end;
   QuantEtiquetas := som;
end;
procedure TForm1.FlatButton3Click(Sender: TObject);
begin
   ListaEansProduto(Sender);
   if query.IsEmpty = true then
   begin
      application.MessageBox(' Este produto não tem Codigo de barras cadastrado. ', pchar(Form1.caption), mb_ok+ mb_iconerror);
      EdCodigo.SetFocus;
   end
   else
    Button1.SetFocus();
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IF (KEY = vk_return) AND (ssCtrl in Shift ) then
      Winexec( pchar('cmd.exe /c print /d:'+ EdLocalimp.text+' '+'Etiquetas.txt')  , sw_normal);
end;

procedure TForm1.imprimeGondolaArgox(sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  cmd,arq:string;
  x01,x02,x03,y01,y02,y03,y04:string;
begin

   arq:=   funcoes.TempDir() + '_Etiquetas.txt';

   DeleteFile(arq);

   itens := Tstringlist.Create();
   for i := 0 to LBItens.Count - 1 do
      for j:= 1 to StrToInt(copy(LBItens.items[i],69,05) ) do
         itens.Add(
                     copy(LBItens.items[i],09,13)+' '+  // eAN
                     copy(LBItens.items[i],29,55)+' '+  // dESCRICAO
                     copy(LBItens.items[i],01,07)+' '+  // CODIGO
                     copy(LBItens.items[i],80,11)+' '  // preco
                   );
   itens.saveToFile( funcoes.TempDir() + '_itenscodigoBarras.txt');

   i:=0;

   x01 := '0010';
   x02 := '0170';
   y01 := '0065';

   y02 := '0050';
   x03 := '0265';


   y03 := '0050';

   y04 := '0005';

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');

      if i <= itens.Count -1 then
      begin
//                                           +----- Orientacao
//                                           |+-----Fonte
//                                           ||+-----multiplicador horzontal
//                                           |||+----- mult verticcal
//                                           |||| +---subtipo da fonte
//                                           ||||_|__
         funcoes.GravaLinhaEmUmArquivo(arq, '1211000'+ y01 + x01 + copy(itens[i], 15, 25));
         funcoes.GravaLinhaEmUmArquivo(arq, '1111000'+ y03 + x01 + 'Cod: '+ copy(itens[i], 01, 13) ) ; //copy(itens[i], 71, 07) );

         funcoes.GravaLinhaEmUmArquivo(arq, '1F21025'+ '0000' + '0000' + copy(itens[i], 01,13));


         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
         begin
            funcoes.GravaLinhaEmUmArquivo(arq, '1212000' +  y04 + x02 +  'R$ '+ copy(itens[i],81,10) ) ;  //funcoes.preencheCampo(0,' ','d', trim( copy(itens[i],81,10)))  );
         end;
      end;
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   end;

   cmd := 'Print /d:'+ EdLocalimp.text+' '+arq;
   Winexec( pchar(cmd)  , sw_normal);
end;


procedure TForm1.imprimeGondolaArgoxFreitas(sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  cmd,arq:string;
  x01,x02,x03,x04,y01,y02,y03,y04,x05,y05,x06,y06:string;
begin

   arq:=   funcoes.TempDir() + '_Etiquetas.txt';

   DeleteFile(arq);

   itens := Tstringlist.Create();
   for i := 0 to LBItens.Count - 1 do
      for j:= 1 to StrToInt(copy(LBItens.items[i],69,05) ) do
         itens.Add(
                     copy(LBItens.items[i],09,13)+' '+  // eAN
                     copy(LBItens.items[i],29,55)+' '+  // dESCRICAO
                     copy(LBItens.items[i],01,07)+' '+  // CODIGO
                     copy(LBItens.items[i],80,11)+' '+  // preco
                     copy(LBItens.items[i],95,11)+' '  // preco02
                   );

   itens.saveToFile( funcoes.TempDir() + '_itenscodigoBarras.txt');
{ LAYOUT DO ARQUIVO DE IMPRESSAO
1620011 7891017000021       COPO ACCENT ROCKS 374-30                 0001            2,49            1,83
}
   i:=0;

   y04 := '0005';

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');

      if i <= itens.Count -1 then
      begin
//                                           +----- Orientacao
//                                           |+-----Fonte
//                                           ||+-----multiplicador horzontal
//                                           |||+----- mult verticcal
//                                           |||| +---subtipo da fonte
//                                           ||||_|__
         x01 := '0005';
         y01 := '0080';
         funcoes.GravaLinhaEmUmArquivo(arq, '1211000'+ y01 + x01 + copy(itens[i], 15, 25));   // dfescricao do produto
{  linha  dos itens
7891017000137 COPO LONGO LIVERPOOL 405-30              0001           1620001       1,99         1,65
}
         x02 := '0320';
         y02 := '0080';
         funcoes.GravaLinhaEmUmArquivo(arq, '1111000'+ y02 + x02 + copy(itens[i], 71, 07));  // codigo produto

         x03 := '0005';
         y03 := '0020';
         funcoes.GravaLinhaEmUmArquivo(arq, '1312000' +  y03 + x03 +  'R$ '+ trim( copy(itens[i],81,10) ) ) ; // preco principal

         x04 :='0005';
         y04 :='0001';
         funcoes.GravaLinhaEmUmArquivo(arq, '1111000'+ y04 + x04 +  trim(edMensagem.Text) ); // mensagem


         if funcoes.getCodPc(cbSegPreco) <> '-1' then
         begin
            x05 :='0250';
            y05 :='0050';
            funcoes.GravaLinhaEmUmArquivo(arq, '1111000'+ y05 + x05 + copy( cbSegPreco.Items[cbSegPreco.itemIndex],01,20)  ); //

            x06 := '0250';
            y06 := '0020';
            funcoes.GravaLinhaEmUmArquivo(arq, '1112000' +  y06 + x06 +  funcoes.preencheCampo(15,' ','E', 'R$ '+ trim( copy(itens[i],95,10) ) ) ) ; // preco secundario
         end;
      end;
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   end;

   cmd := 'Print /d:'+ EdLocalimp.text+' '+arq;
   Winexec( pchar(cmd)  , sw_normal);
end;


procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   imprimeGondolaArgoxFreitas(nil);
   lbitens.Clear;
   EdCodigo.Text:='';
   EdCodigo.SetFocus;
end;

procedure TForm1.Palets1Click(Sender: TObject);
begin
   Application.CreateForm(TPallet, Pallet);
   Pallet.show;
end;

procedure TForm1.Endereco1Click(Sender: TObject);
begin
   Palets1Click(Sender);
end;


procedure TForm1.ConnectionWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.GravaLinhaEmUmArquivo(funcoes.TEmpDir() + '_'+ application.Title + '.txt', CommandText );
end;

procedure TForm1.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_return then
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if query.IsEmpty = false then
      AdicionaProdutoParaImpressao(sender);
end;

procedure TForm1.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
      Button1Click(nil);
end;

procedure TForm1.EdCodigoExit(Sender: TObject);
begin
   if EdCodigo.Text <> ''then
      FlatButton3Click(nil);
end;

end.


// CMDMesage( /C EXECUTA E E ENCERRADO
// CMD /D EXECUTA E MANTEM
