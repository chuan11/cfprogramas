unit uEtiquetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, DB, ADODB, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelEdit,  ExtCtrls, adLabelComboBox,
  Menus, RpBase, RpSystem, RpRave, RpDefine, RpCon, Spin, verificaSenhas,
  TFlatCheckBoxUnit;

type
  TfmEtiquetas = class(TForm)
    EdCodigo: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    LBItens: TListBox;
    Label1: TLabel;
    DataSource1: TDataSource;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    Label2: TLabel;
    cbPrecos: TadLabelComboBox;
    cbLojas: TadLabelComboBox;
    MainMenu1: TMainMenu;
    Palets1: TMenuItem;
    edQuant: TSpinEdit;
    Label3: TLabel;
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    cbTIpoImpressao: TadLabelComboBox;
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
    function preparaListaDeItens(Sender: Tobject):TStringList;
    procedure imprimeELimpaCampos(Sender: TObject; arq:String);
    procedure imprimeGondolaDynapos(Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEtiquetas: TfmEtiquetas;
  ds:TDataSet;
implementation
{$R *.dfm}

uses upallet, uMain, uCF, funcsql, funcoes;

procedure TfmEtiquetas.imprimeGondolaDynapos(Sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  arq:string;
begin
   ARQ :=  FUNCOES.TempDir()+ 'ETIQUETEAS.TXT'; //    EdLocalImp.Text;
   DeleteFile(arq);

   for i := 0 to LBItens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq, 'N');
      funcoes.GravaLinhaEmUmArquivo(arq, 'Q200,24');
      funcoes.GravaLinhaEmUmArquivo(arq, 'q800' );
      funcoes.GravaLinhaEmUmArquivo(arq, 'A700,188,2,3,2,2,N,"' + trim( copy(LBItens.items[i], 29, 20)) + '"');
      funcoes.GravaLinhaEmUmArquivo(arq, 'A700,150,2,3,2,2,N,"' + trim(copy(LBItens.items[i], 49, 20)) + '"');
      funcoes.GravaLinhaEmUmArquivo(arq, 'A700,100,2,3,1,1,N,"' + 'CODIGO: '+copy(LBItens.items[i], 01,07)   + '"');
      funcoes.GravaLinhaEmUmArquivo(arq, 'A600,050,2,4,2,2,N,"R$ '+ copy(LBItens.items[i],82,10) + '"');
      funcoes.GravaLinhaEmUmArquivo(arq,'P1');
      funcoes.GravaLinhaEmUmArquivo(arq,'N');
   end;
   imprimeELimpaCampos(nil, arq);
end;


procedure TfmEtiquetas.ListaEansProduto(sender: tobject);
var
  cmd:string;
begin
   if (ds <> nil) then
      ds.Free();

   ds:= uCF.getDadosProd( funcoes.getCodUo(cbLojas), EdCodigo.Text, fmMain.getCodPreco(cbPrecos), true  );
   if (ds.IsEmpty = false ) then
   begin
      DataSource1.DataSet := ds;



      dbgrid.Columns[0].Width :=  50;
      dbgrid.Columns[1].Width :=  85;
      dbgrid.Columns[2].Width :=  200;
      dbgrid.Columns[3].Visible:= FALSE;
      dbgrid.Columns[4].Width := 50;

      DBGrid.Columns[ ds.FieldByName('codigo').Index].Width := 50;
      DBGrid.Columns[ ds.FieldByName('fornecedor').Index].Visible := false;
      DBGrid.Columns[ ds.FieldByName('categoria').Index].Visible := false;


      edQuant.SetFocus;
   end
   else
   begin
      edQuant.SetFocus;
      EdCodigo.SetFocus;
   end
end;

procedure TfmEtiquetas.FormCreate(Sender: TObject);
var
  str:String;
begin
   cbPrecos.Items := funcsql.getListaPrecos(fmMain.Conexao,false,false,false, fmMain.getGrupoLogado());
   fmMain.getParametrosForm(fmEtiquetas);

   str := funcSql.getParamBD( 'impCodBarras', fmMain.getUoLogada(), fmMain.Conexao );
   if str <> '' then
      edLocalImp.Text := str;

   fmMain.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado() );
end;


procedure TfmEtiquetas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  funcoes.salvaCampos(fmEtiquetas);
  fmMain.fecharForm(fmEtiquetas, action);
  fmEtiquetas := nil;
end;


procedure TfmEtiquetas.AdicionaProdutoParaImpressao(sender: tobject);
begin
   lbItens.Items.add(
                      funcoes.preencheCampo(08,' ', 'd', ds.fieldByName('codigo').asString )+
                      funcoes.preencheCampo(20,' ', 'd', ds.fieldByName('ean').asString )+
                      funcoes.preencheCampo(40,' ', 'd', copy(ds.fieldByName('descricao').asString,01,40)) + ' '+
                      funcoes.preencheCampo(04,'0', 'E', inttoStr(edQuant.Value) ) +' '+
                      funcoes.preencheCampo(15,' ', 'E', floattostrf(ds.fieldByname('preco').asfloat ,ffNumber,18,2)   )
                    );
   edCodigo.Text:='';
   edCodigo.SetFocus;
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
   funcoes.imprimeArquivoPorta(arq, EdLocalImp.Text);
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
 //     funcoes.GravaLinhaEmUmArquivo(arq,'E'); //sensor
      funcoes.GravaLinhaEmUmArquivo(arq,'H15');

      if i <= itens.Count -1 then
      begin
         funcoes.GravaLinhaEmUmArquivo(arq, '1F31025'+ y01 + '0020' + copy(itens[i], 01,13));
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


procedure TfmEtiquetas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IF (KEY = VK_F7) AND (ssCtrl in Shift ) then
      EdLocalImp.Visible :=  not(EdLocalImp.Visible);
end;

procedure TfmEtiquetas.FlatButton4Click(Sender: TObject);
begin
   if (ds.IsEmpty = false) then
      AdicionaProdutoParaImpressao(sender);
end;

procedure TfmEtiquetas.imprimeDeskjet(Sender: Tobject);
var
   seq,i,j,qtItens:integer;
   nTable,auxPreco:String;
begin

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
      funcoes.GravaLinhaEmUmArquivo(arq,'H15');
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
      funcoes.GravaLinhaEmUmArquivo(arq,'H15');
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
begin
   gravaLog( pchar('Print /d:'+ EdLocalimp.text+' '+arq) );
   Winexec( pchar('Print /d:'+ EdLocalimp.text+' '+arq )  , sw_normal);
   lbitens.Clear;
   EdCodigo.SetFocus;
   EDqUANT.SetFocus;
   EdCodigo.SetFocus;
   EdCodigo.Text:='';
end;

procedure TfmEtiquetas.FlatButton1Click(Sender: TObject);
begin
   case cbTIpoImpressao.ItemIndex of
      0:imprimeArgox(sender);
      1:imprimeDynaPos(sender);
      2: imprimeGondolaArgoxGrande(Sender);
      3: imprimeGondolaDynapos(Sender);
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


procedure TfmEtiquetas.FlatButton3Click(Sender: TObject);
begin
   ListaEansProduto(Sender);
end;



end.


// CMD /C EXECUTA E E ENCERRADO
// CMD /D EXECUTA E MANTEM


