unit uEtiquetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, DB, ADODB, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelEdit, funcoes, ExtCtrls, adLabelComboBox, funcsql,
  Menus, RpBase, RpSystem, RpRave, RpDefine, RpCon, Spin, verificaSenhas,
  TFlatCheckBoxUnit;

type
  TfmEtiquetas = class(TForm)
    EdCodigo: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    LBItens: TListBox;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Query: TADOQuery;
    DataSource1: TDataSource;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    Label2: TLabel;
    cbPrecos: TadLabelComboBox;
    cbLojas: TadLabelComboBox;
    Panel1: TPanel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Label5: TLabel;
    SpinEdit2: TSpinEdit;
    MainMenu1: TMainMenu;
    Palets1: TMenuItem;
    chpesqPreco: TfsCheckBox;
    edQuant: TSpinEdit;
    Label3: TLabel;
    NotaFiscal1: TMenuItem;
    tb: TADOTable;
    rgTpImp: TadLabelComboBox;
    rgTpImpressora: TadLabelComboBox;
    rgTamEtiqueta: TadLabelComboBox;
    Panel2: TPanel;
    EdLocalImp: TadLabelEdit;
    Procedure ListaEansProduto(sender:tobject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure edQuantKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure AdicionaProdutoParaImpressao(sender:tobject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LBItensDblClick(Sender: TObject);
    procedure EdCodigoKeyPress(Sender: TObject; var Key: Char);
    function QuantEtiquetas(sender:Tobject):integer;
    procedure imprimeDynaPos(sender:Tobject);
    procedure imprimeArgox(sender:Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imprimeDeskjet(Sender:Tobject);
    procedure Palets1Click(Sender: TObject);
    procedure Endereco1Click(Sender: TObject);
    procedure imprimeGondolaArgox(sender: Tobject);
    procedure imprimeGondolaArgoxGrande(sender: Tobject);
    procedure ConnectionWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure NotaFiscal1Click(Sender: TObject);
    function preparaListaDeItens(Sender: Tobject):TStringList;
    procedure imprimeELimpaCampos(Sender: TObject; arq:String);
    procedure rgTpImpressoraChange(Sender: TObject);
    procedure Panel2DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
//    procedure FlatButton2Click(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEtiquetas: TfmEtiquetas;

implementation
{$R *.dfm}

uses upallet, uMain, uetqNotas;

procedure TfmEtiquetas.ListaEansProduto(sender: tobject);
var
  Cmd:string;
begin
   cmd := '';
   cmd := 'exec Z_CF_GetInformacoesProduto ' +
           QuotedStr( FUNCOES.SohNumeros(EdCodigo.text))  +' , '+
           funcSql.getCodUo(cbLojas) + ' , ' ;

    if chpesqPreco.Checked = true then
       cmd := cmd + funcoes.SohNumeros((copy(cbPrecos.Items[cbPrecos.ItemIndex],00,100)))
    else
       cmd := cmd + ' -1';

   query.SQL.clear;
   query.SQL.Add(cmd);

   query.Open;
   dbgrid.Columns[0].Width :=  50;
   dbgrid.Columns[1].Width :=  85;
   dbgrid.Columns[2].Width :=  200;
   dbgrid.Columns[3].Visible:= FALSE;
   dbgrid.Columns[4].Width := 50;
end;

procedure TfmEtiquetas.FormCreate(Sender: TObject);
begin
   cbLojas.Items := funcsql.GetNomeLojas( fmMain.Conexao, false, false, fmMain.lbPes.caption,'');//  fmEtiquetas.GetNomeLojas(Sender);
   cbPrecos.Items := funcsql.getListaPrecos(fmMain.Conexao,false,false,false);
   funcoes.carregaCampos(fmEtiquetas);
end;


procedure TfmEtiquetas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmMain.fecharForm(fmEtiquetas, action);
  fmEtiquetas := nil;
end;


procedure TfmEtiquetas.AdicionaProdutoParaImpressao(sender: tobject);
begin
   lbItens.Items.add(
                      funcoes.preencheCampo(08,' ', 'd', query.fieldByName('codigo').asString )+
                      funcoes.preencheCampo(20,' ', 'd', query.fieldByName('ean').asString )+
                      funcoes.preencheCampo(40,' ', 'd', copy(query.fieldByName('descricao').asString,01,40)) + ' '+
                      funcoes.preencheCampo(04,'0', 'E', inttoStr(edQuant.Value) ) +' '+
                      funcoes.preencheCampo(15,' ', 'E', floattostrf(Query.fieldByname('preco').asfloat ,ffNumber,18,2)   )
                    );
   edCodigo.Text:='';
   edCodigo.SetFocus;
   query.SQL.Clear;
end;



procedure TfmEtiquetas.edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      FlatButton4Click(Sender);
end;



procedure TfmEtiquetas.imprimeDynaPos(sender: Tobject);
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

procedure TfmEtiquetas.imprimeArgox(sender: Tobject);
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
   lbitens.Clear;
   EdCodigo.SetFocus;
   EDqUANT.SetFocus;
   EdCodigo.SetFocus;
   EdCodigo.Text:='';
end;

procedure TfmEtiquetas.LBItensDblClick(Sender: TObject);
begin
   LBiTENS.DeleteSelected;
end;

procedure TfmEtiquetas.EdCodigoKeyPress(Sender: TObject; var Key: Char);
begin
   if (key = #13) then
      FlatButton3Click(Sender);
end;

function TfmEtiquetas.QuantEtiquetas(sender: Tobject):integer;
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
procedure TfmEtiquetas.FlatButton3Click(Sender: TObject);
begin
   ListaEansProduto(Sender);

   if query.IsEmpty = true then
   begin
      application.MessageBox(' Este produto não tem Codigo de barras cadastrado. ', '', mb_ok+ mb_iconerror);
      edQuant.SetFocus;
      EdCodigo.SetFocus;
   end
   else
      edQuant.SetFocus;
end;


procedure TfmEtiquetas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IF (KEY = VK_F7) AND (ssCtrl in Shift ) then
      EdLocalImp.Visible :=  not(EdLocalImp.Visible);
end;

procedure TfmEtiquetas.FlatButton4Click(Sender: TObject);
begin
   if query.IsEmpty = false then
      AdicionaProdutoParaImpressao(sender);
end;

procedure TfmEtiquetas.imprimeDeskjet(Sender: Tobject);
var
   seq,i,j,qtItens:integer;
   nTable,auxPreco:String;
begin
   nTable := getNomeTableTemp();
   execSQL( 'create table ' + nTable + ' ( seq int primary key, ean varchar(13), cd_ref varchar(07), ds_ref varchar(25), pc varchar(12) ) ', fmMain.Conexao);

   tb.TableName := nTable;
   tb.Open;

   seq := 0;

   for i:=1 to spinedit1.value * 6 - 6 + spinedit2.value-1 DO
   begin
      inc(seq);
      tb.AppendRecord([ intToStr(seq) , '' , '', '', '' ]);
   end;

   for i:=0 to  lbItens.Items.count -1 do
   begin
      qtItens := strToInt(  copy(lbItens.Items[i],70,04));
      for j:=1 to  qtItens do
      begin
         inc(seq);
         if chpesqPreco.Checked = true then
           auxPreco := 'R$' +trim(copy(lbItens.Items[i],79,12))
         else
           auxPreco := '';

         tb.AppendRecord([ intToStr(seq) , copy(lbItens.Items[i],09,13) , copy(lbItens.Items[i],01,07), copy(lbItens.Items[i],29,25),  auxPreco  ]);
      end;
   end;
   fmMain.impressaoRave(TB, 'rpEtiquetas', NIL);

   tb.Close;
   LBItens.Clear();
end;


function TfmEtiquetas.preparaListaDeItens(Sender: Tobject):TStringList;
var
  i:integer;
  lst:TstringList;
begin
   lst:= TStringList.Create();
   for i := 0 to LBItens.Count - 1 do
         lst.Add(
                     copy(LBItens.items[i],09,13)+' '+  // eAN
                     copy(LBItens.items[i],29,55)+' '+  // dESCRICAO
                     copy(LBItens.items[i],01,07)+' '+  // CODIGO
                     copy(LBItens.items[i],80,11)+' '  // preco
                   );
    result := lst;
   lst.saveToFile( funcoes.TempDir() + '_itensCodigoBarras.txt');
end;

procedure TfmEtiquetas.imprimeGondolaArgoxGrande(sender: Tobject);
var
  Itens:TstringList;
  i:integer;
  cmd,arq:string;
  x01,x02,y01,y02:string;
begin
   arq:=   funcoes.TempDir() + '_Etiquetas.txt';
   DeleteFile(arq);
   itens := Tstringlist.Create();
   i:=0;
   x01 := '0010';
   x02 := '0005';
   y01 := '0065';
   y02 := '0050';

   itens := preparaListaDeItens(nil);

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');
//                                           +----- Orientacao
//                                           |+-----Fonte
//                                           ||+-----multiplicador horzontal
//                                           |||+----- mult verticcal
//                                           |||| +---subtipo da fonte
//                                           ||||_|__
         funcoes.GravaLinhaEmUmArquivo(arq, '1211000'+ y01 + x01 + copy(itens[i], 15, 40)); // descricao
         funcoes.GravaLinhaEmUmArquivo(arq, '1F21025'+ '0010' + '0000' + copy(itens[i], 01,13));

         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, '1212000' +  '0000' + '0200' +  'R$ '+ copy(itens[i],81,10) );

         funcoes.GravaLinhaEmUmArquivo(arq, '2100000'+ '0080' + '0370' + copy(itens[i],71,07)  ); // codigo da loja no cantinho
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   end;
   imprimeELimpaCampos(nil, arq);
end;


procedure TfmEtiquetas.imprimeGondolaArgox(sender: Tobject);
var
  Itens:TstringList;
  i:integer;
  cmd,arq:string;
  x01,x02,y01,y02:string;
begin
   arq:=   funcoes.TempDir() + '_Etiquetas.txt';
   DeleteFile(arq);
   itens := Tstringlist.Create();
   i:=0;
   x01 := '0010';
   x02 := '0140';
   y01 := '0065';
   y02 := '0000';

   itens := preparaListaDeItens(nil);

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');
//                                           +----- Orientacao
//                                           |+-----Fonte
//                                           ||+-----multiplicador horzontal
//                                           |||+----- mult verticcal
//                                           |||| +---subtipo da fonte
//                                           ||||_|__
         funcoes.GravaLinhaEmUmArquivo(arq, '1211000'+ y01 + x01 + copy(itens[i], 15, 25));
         funcoes.GravaLinhaEmUmArquivo(arq, '1F21025'+ '0010' + '0000' + copy(itens[i], 01,13));
         if StrToInt(funcoes.SohNumeros(copy(itens[i],80,10))) > 0 then
            funcoes.GravaLinhaEmUmArquivo(arq, '1212000' +  y02 + x02 +  'R$ '+ copy(itens[i],81,10) );
      inc(i);
      funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   end;
   imprimeELimpaCampos(nil, arq);
end;


procedure TfmEtiquetas.imprimeELimpaCampos(Sender: TObject; arq:String);
begin //
   Winexec( pchar(  'Print /d:'+ EdLocalimp.text+' '+arq )  , sw_normal);
   lbitens.Clear;
   EdCodigo.SetFocus;
   EDqUANT.SetFocus;
   EdCodigo.SetFocus;
   EdCodigo.Text:='';
end;



procedure TfmEtiquetas.FlatButton1Click(Sender: TObject);
begin
   case rgTpImp.ItemIndex of
   0:begin
        Case rgTpImpressora.ItemIndex of
           0: imprimeDynaPos(sender);
           1: imprimeArgox(sender);
           2: imprimeDeskjet(Sender);
        end;
     end;
   1:begin
        Case rgTpImpressora.ItemIndex of
           0: showMessage('Para gondola, só está ativa a impressão argox');
           1: begin
                 case rgTamEtiqueta.ItemIndex of
                    0:imprimeGondolaArgox(sender);
                    1:imprimeGondolaArgoxGrande(Sender);
                 end;
              end;
           2: showMessage('Para gondola, só está ativa a impressão argox');
        end;
     end;
  end;


end;

procedure TfmEtiquetas.Palets1Click(Sender: TObject);
begin
   Application.CreateForm(TPallet, Pallet);
   Pallet.show;
end;

procedure TfmEtiquetas.Endereco1Click(Sender: TObject);
begin
   Palets1Click(Sender);
end;


procedure TfmEtiquetas.ConnectionWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.GravaLinhaEmUmArquivo(funcoes.TEmpDir() + '_'+ application.Title + '.txt', CommandText );
end;

procedure TfmEtiquetas.NotaFiscal1Click(Sender: TObject);
begin
   if fmEtq = nil then
   begin
      Application.CreateForm(TfmEtq, fmEtq);
      fmEtq.Show;
   end;
end;


procedure TfmEtiquetas.FormActivate(Sender: TObject);
begin
   panel1.Top := panel2.Top;
   rgTpImpressora.OnChange(nil);
end;

procedure TfmEtiquetas.rgTpImpressoraChange(Sender: TObject);
begin
    if rgTpImpressora.ItemIndex < 2 then
    begin
      panel1.Visible := false;
      panel2.Visible := true
    end
    else
    begin
      panel1.Visible := true;
      panel2.Visible := false;
    end;

    if rgTpImpressora.ItemIndex = 1 then
       rgTamEtiqueta.Visible := true
    else
       rgTamEtiqueta.Visible := false;
end;
procedure TfmEtiquetas.Panel2DblClick(Sender: TObject);
var
   strGrupo:String;
begin
   strGrupo := fmMain.GetParamBD('AutPathImpressao','');

    if EdLocalImp.Enabled = false then
    begin
       if verificaSenhas.TelaAutorizacao2(fmMain.Conexao,'13, ' + strGrupo,'10000031') <> '' then
         EdLocalImp.Enabled := true
    end
    else
       EdLocalImp.Enabled := false;
end;



procedure TfmEtiquetas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  funcoes.salvaCampos(fmEtiquetas);
end;

end.


// CMD /C EXECUTA E E ENCERRADO
// CMD /D EXECUTA E MANTEM


