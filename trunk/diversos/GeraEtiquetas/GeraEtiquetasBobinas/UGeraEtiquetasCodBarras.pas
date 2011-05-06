unit UGeraEtiquetasCodBarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, DB, ADODB, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelEdit, funcoes, ExtCtrls, adLabelComboBox,
  TFlatCheckBoxUnit, RpBase, RpSystem, RpRave, RpDefine, RpCon, Spin, Menus;

type
  TForm1 = class(TForm)
    EdCodigo: TadLabelEdit;
    edQuant: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    LBItens: TListBox;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Connection: TADOConnection;
    Query: TADOQuery;
    DataSource1: TDataSource;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    EdLocalImp: TadLabelEdit;
    Label2: TLabel;
    rgTpImpressora: TRadioGroup;
    Label3: TLabel;
    FlatButton2: TFlatButton;
    cbPrecos: TadLabelComboBox;
    cbLojas: TadLabelComboBox;
    chPesqPreco: TCheckBox;
    Panel1: TPanel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Label5: TLabel;
    SpinEdit2: TSpinEdit;
    RvCustomConnection1: TRvCustomConnection;
    Raveproject: TRvProject;
    RvSystem1: TRvSystem;
    MainMenu1: TMainMenu;
    Palets1: TMenuItem;
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
    function  GetNomeLojas(sender: tobject): Tstrings;
    function  getPrecos(sender: tobject): Tstrings;
    procedure imprimeDeskjet(Sender:Tobject);
    procedure rgTpImpressoraClick(Sender: TObject);
    procedure Palets1Click(Sender: TObject);
  private
//    procedure FlatButton2Click(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit1;

{$R *.dfm}

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
   cmd := 'exec Z_CF_GetInformacoesProduto ' +

           QuotedStr( FUNCOES.SohNumeros(EdCodigo.text))  +' , '+
           funcoes.SohNumeros((copy(cbLojas.Items[cbLojas.ItemIndex],00,100))) +' , ';

    if chpesqPreco.Checked = true then
       cmd := cmd + funcoes.SohNumeros((copy(cbPrecos.Items[cbPrecos.ItemIndex],00,100)))
    else
       cmd := cmd + '-1 ';


   query.SQL.clear;
   query.SQL.Add(cmd);
//   query.SQL.SaveToFile( funcoes.TempDir() + 'itenscodigoBarras.txt');
   query.Open;
   dbgrid.Columns[0].Width :=  50;
   dbgrid.Columns[1].Width :=  85;
   dbgrid.Columns[2].Width :=  200;
   dbgrid.Columns[3].Visible:= FALSE;
   dbgrid.Columns[4].Width := 50;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//   connection.Connected := false;
   connection.ConnectionString := funcoes.getDadosConexaoUDL( extractFilePath( ParamStr(0)) + 'ConexaoAoWell.ini' );
   connection.Connected := true;


   cbLojas.Items := form1.GetNomeLojas(Sender);
   cbPrecos.Items := form1.getPrecos(sender);

   if funcoes.RParReg('ProgramasCF\ImpEtiquetas','PortaImpressora')<> '' then
     EdLocalImp.Text := funcoes.RParReg('ProgramasCF\ImpEtiquetas','PortaImpressora');

   if funcoes.RParReg('ProgramasCF\ImpEtiquetas','TipoImpressora')<> '' then
     rgTpImpressora.ItemIndex:= strtoInt(funcoes.RParReg('ProgramasCF\ImpEtiquetas','TipoImpressora'));

   if funcoes.RParReg('ProgramasCF\ImpEtiquetas','loja')<> '' then
     cbLojas.ItemIndex:= strtoInt(funcoes.RParReg('ProgramasCF\ImpEtiquetas','loja'));

   if funcoes.RParReg('ProgramasCF\ImpEtiquetas','preco') <> '' then
     cbPrecos.ItemIndex:= strtoInt(funcoes.RParReg('ProgramasCF\ImpEtiquetas','preco'));

   if funcoes.RParReg('ProgramasCF\ImpEtiquetas','impPreco')<> '' then
     chPesqPreco.Checked := true;

   form1.top := 25 ;
   form1.Left := screen.Width - form1.Width;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.WParReg('ProgramasCF\ImpEtiquetas','PortaImpressora', EdLocalImp.Text );
   funcoes.WParReg('ProgramasCF\ImpEtiquetas','TipoImpressora', IntToStr(rgtpImpressora.itemIndex) );

   funcoes.WParReg('ProgramasCF\ImpEtiquetas','loja', IntToStr( cbLojas.ItemIndex) );
   funcoes.WParReg('ProgramasCF\ImpEtiquetas','preco', IntToStr( cbPrecos.ItemIndex) );

   if chPesqPreco.Checked = true then
      funcoes.WParReg('ProgramasCF\ImpEtiquetas','impPreco', '1' )
   else
      funcoes.WParReg('ProgramasCF\ImpEtiquetas','impPreco', '' );

   connection.Close;
end;


procedure TForm1.AdicionaProdutoParaImpressao(sender: tobject);
begin
   if edQuant.Text = '' then edQuant .text := '03';
   lbItens.Items.add(
                      funcoes.preencheCampo(08,' ', 'd', query.fieldByName('codigo').asString )+
                      funcoes.preencheCampo(20,' ', 'd', query.fieldByName('ean').asString )+
                      funcoes.preencheCampo(40,' ', 'd', copy(query.fieldByName('descricao').asString,01,40)) + ' '+
                      funcoes.preencheCampo(04,'0', 'E', edQuant.text ) +' '+
                      funcoes.preencheCampo(15,' ', 'E', floattostrf(Query.fieldByname('preco').asfloat ,ffNumber,18,2)   )
                    );
   edQuant.Text := '03';
   edCodigo.Text:='';
   edCodigo.SetFocus;
//   lbItens.Items.SaveToFile( funcoes.TempDir() + 'itenscodigoBarras.txt');
   query.SQL.Clear;
end;



procedure TForm1.edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
   begin
      FlatButton4Click(Sender);
         EDqUANT.TEXT:='03';
   end;
end;



procedure TForm1.imprimeDynaPos(sender: Tobject);
var
  Itens:TstringList;
  j,i:integer;
  arq:string;
begin
   arq:='Etiquetas.txt';
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

 //    itens.saveToFile( funcoes.TempDir() + 'itenscodigoBarras.txt');


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
   Winexec( pchar('cmd.exe /c print /d:'+ EdLocalimp.text+' '+arq)  , sw_Hide);

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
  arq:string;
  x01,x02,x03,y01,y02,y03,y04:string;
begin
   arq:='Etiquetas.txt';
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
 //  itens.saveToFile( funcoes.TempDir() + 'itenscodigoBarras.txt');

   i:=0;

   x01 := '0010';
   x02 := '0140';
   x03 := '0265';

   y01 := '0050';
   y02 := '0035';
   y04 := '0005';

   while i <= itens.Count -1 do
   begin
      funcoes.GravaLinhaEmUmArquivo(arq,'L');
      funcoes.GravaLinhaEmUmArquivo(arq,'H11');

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
   Winexec( pchar('cmd.exe /c print /d:'+ EdLocalimp.text+' '+arq)  , sw_Hide);

   lbitens.Clear;
   EdCodigo.SetFocus;
   EDqUANT.SetFocus;
   EdCodigo.SetFocus;
   EdCodigo.Text:='';
end;

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
      edQuant.SetFocus;
      EdCodigo.SetFocus;
   end
   else
      edQuant.SetFocus;
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IF (KEY = vk_return) AND (ssCtrl in Shift ) then
      Winexec( pchar('cmd.exe /c print /d:'+ EdLocalimp.text+' '+'Etiquetas.txt')  , sw_Hide);
end;

procedure TForm1.FlatButton4Click(Sender: TObject);
begin
   if query.IsEmpty = false then
      AdicionaProdutoParaImpressao(sender);
end;

procedure TForm1.imprimeDeskjet(Sender: Tobject);
var
   linha,i:integer;
begin
   RaveProject.ProjectFile := ExtractFilePath(ParamStr(0) ) + 'Etiquetas.rav';
   linha := 0;
   linha := spinedit1.value * 6 - 6 + spinedit2.value-1;
   while lbItens.Items.count  > 0 do
   begin
      Raveproject.ClearParams;

      if lbItens.Items.count  > 95 then
      begin
        for i:= 0  to 95 do
        begin
           Raveproject.SetParam('e'+intToStr(linha+i), copy(lbItens.items[i], 09, 13));
           Raveproject.SetParam('c'+intToStr(linha+i), copy(lbItens.Items[i], 01, 07 ) );
           Raveproject.SetParam('d'+intToStr(linha+i), copy(lbItens.Items[i], 29, 18 ) );
           Raveproject.SetParam('p'+intToStr(linha+i), 'R$  '+ funcoes.tiraEspaco(copy(lbItens.Items[i], 76, 15)) );
        end;
      end
      else
      begin
         for i:= 0  to lbItens.Items.count -1 do
         begin
            Raveproject.SetParam('e'+intToStr(linha+i), copy(lbItens.items[i], 09, 13));
            Raveproject.SetParam('c'+intToStr(linha+i), copy(lbItens.Items[i], 01, 07 ) );
            Raveproject.SetParam('d'+intToStr(linha+i), copy(lbItens.Items[i], 29, 18 ) );
            Raveproject.SetParam('p'+intToStr(linha+i), 'R$  '+ funcoes.tiraEspaco(copy(lbItens.Items[i],76,15 )) );
         end;
      end;
      if lbItens.Items.Count > 0 then
         Raveproject.ExecuteReport('report1');
      for i:=0 to 95 do
         lbItens.Items.Delete(0);
   end;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   Case rgTpImpressora.ItemIndex of
      0: imprimeDynaPos(sender);
      1: imprimeArgox(sender);
      2: imprimeDeskjet(Sender);
   end;
end;

procedure TForm1.rgTpImpressoraClick(Sender: TObject);
begin
    if rgTpImpressora.ItemIndex < 2 then
      panel1.Visible := false
    else
      panel1.Visible := true;
end;

procedure TForm1.Palets1Click(Sender: TObject);
begin
  Application.CreateForm(TFmpallete, Fmpallete);
  FmPallete.show;
end;

end.
