unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Mask, DBCtrls, ExtCtrls,
  Menus, ComCtrls, ToolWin, Edit1ColorFocus, ComboBoxColor, ADODB;
type
  TProdutosNaLista = class(TForm)
    DataSource2: TDataSource;
    BitBtn3: TBitBtn;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    DBGrid3: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    DataSource3: TDataSource;
    Popup1: TPopupMenu;
    InserirComprador1: TMenuItem;
    Delete1: TMenuItem;
    InserirProdutos1: TMenuItem;
    Panel2: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Label6: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    InserirComprador2: TMenuItem;
    query1: TADOQuery;
    query2: TADOQuery;
    Query3: TADOQuery;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Clic(Sender: TObject);
    procedure CarregaProdutos(NumLista,noiva,noivo:string;Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure IncluirItens(Sender:tobject;codigo,nome,tipo:string);
    procedure AjustaDbgrid(Sender: TObject);
    procedure InserirProdutos1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure InserirComprador1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure AlterarItem(sender:tobject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Delete1Click(Sender: TObject);
    procedure DeletarItemDalista(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure InsereComprador(sender:tobject);
    procedure InserirComprador2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProdutosNaLista: TProdutosNaLista;
  CodLista,status:string;

implementation

uses Unit1, Unit5, Unit4 , Unit6;

{$R *.DFM}

procedure TProdutosNaLista.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   form1.HabilitaMenu(sender);
   ProdutosNaLista := nil;
   action := cafree;
end;


procedure TProdutosNaLista.BitBtn3Click(Sender: TObject);
begin
   form1.msgderodape('');
   ProdutosNaLista.close;
end;


procedure TProdutosNaLista.BitBtn4Clic(Sender: TObject);
begin
   panel1.visible := false;
end;


procedure TProdutosNaLista.CarregaProdutos(NumLista,noiva,noivo:string;Sender: TObject);
begin
   if CodLista = '' then
      CodLista := NumLista;

   with query3.sql do
   begin
      clear;
      add('Select P.Codigo, T.tipo, P.NomeProduto, P.Convidado, P.ref');
      add('from produtos P, tiposprodutos T');
      add('where (numLista =' +#39+NumLista +#39+ ') and (T.num = P.tipo)');
      add('order by P.NomeProduto');
   end;
   label8.caption := noiva;
   label3.caption := noivo;
   query3.open;
   AjustaDbgrid(sender);
   popup1.AutoPopup := true;
end;


procedure TProdutosNaLista.IncluirItens(Sender:tobject;codigo,nome,tipo:string);
begin
   with query3.sql do
   begin
      clear;
      add('Insert produtos values('+#39+ dbgrid3.Fields[0].asString +#39+ ' , '+#39+codigo+#39+' , '+#39+''+#39+' , '+#39+copy(nome,01,40)+#39+  ' , '+#39+form1.ProximoValor(Sender,'Produtos','Ref')  +#39+ ' , '+#39+tipo +#39+ ')') ;
   end;
   query3.execSql;
   CarregaProdutos(dbgrid3.Fields[0].AsString,dbgrid3.Fields[2].AsString,dbgrid3.Fields[3].AsString,Sender);
end;


procedure TProdutosNaLista.AjustaDbgrid(Sender: TObject);
var
  i:integer;
begin
   dbgrid2.Columns[0].title.caption := 'Codigo';
   dbgrid2.Columns[1].title.caption := 'Tipo';
   dbgrid2.Columns[2].title.caption := 'Produto' ;
   dbgrid2.Columns[3].title.caption := 'Convidado';
   for i:=0 to DBGrid2.Columns.count-1 do
   begin
      DBGrid2.Columns[i].Title.Color := clBtnFace;
      DBGrid2.Columns[i].Title.Font.Color := clBlack;
      DBGrid2.Columns[i].Title.Font.Style := [fsBold];
      DBGrid2.Columns[i].Title.Font.Color := clnavy;
   end;
   DBGrid2.Columns[0].Width := 50;
   DBGrid2.Columns[1].Width := 120;
   DBGrid2.Columns[2].Width := 260;
   DBGrid2.Columns[3].Width := 260;
end;


procedure TProdutosNaLista.InserirProdutos1Click(Sender: TObject);
begin
   if dbgrid2.FieldCount = 0 then
      form1.msgderodape('Não existe ainda nenhuma lista aberta')
   else
   begin
      application.Createform(TForm5,Form5);
      form5.show;
      bitbtn3.enabled := false;
      popup1.AutoPopup := false;
   end;
end;


procedure TProdutosNaLista.BitBtn6Click(Sender: TObject);
begin
   edit1.text:='';
   panel2.visible:= false;
   cbox1.itemindex := -1
end;


procedure TProdutosNaLista.InserirComprador1Click(Sender: TObject);
var
  NaoAlterar:boolean;
  i:integer;
begin
   NaoAlterar := false;
   edit1.Enabled := true;
   edit2.enabled := false;
   edit3.enabled := false;
   cbox1.Enabled := false;
   status := 'comprador';

   if length(dbgrid2.Fields[3].AsString) > 1 then
      if application.messagebox(pchar('   Já Exite comprador para esse item!!  ' +#13+ '   Deseja mesmo Substitui-lo ??'),pchar(form1.caption), mb_yesno + mb_iconwarning) = mrno then
         NaoAlterar := true;

   if NaoAlterar = false then
   begin
      edit2.text := dbgrid2.fields[0].asString;
      edit3.text := dbgrid2.fields[2].asString;
      edit1.text := dbgrid2.fields[3].asString;

      panel2.visible := true; //abre o painel2
      edit1.setfocus;

      for i := 0 to cbox1.items.count -1 do
         if pos( dbgrid2.fields[1].asString, cbox1.items[i]) > 0 then
            cbox1.itemindex := i;

     if cbox1.itemindex = -1  then
        cbox1.enabled := true;
   end;
end;


procedure tprodutosNaLista.AlterarItem(sender:tobject);
begin
   with query1.SQL do
   begin
      clear;
      add('Update Produtos');
      add('Set Codigo = '    +#39 + edit2.text +#39+ ' , ');
      add('    nomeProduto ='+#39 + edit3.text +#39+ ' , ');
      add('    tipo ='       +#39 + copy (cbox1.Items[cbox1.itemindex],01,02) +#39 );
      add('where ref ='+#39+ dbgrid2.fields[4].AsString +#39);
   end;
   query1.execSql;

   CarregaProdutos(dbgrid3.Fields[0].AsString,dbgrid3.Fields[2].AsString,dbgrid3.Fields[3].AsString,Sender);
   edit3.text := '';
   edit2.text:='';
   edit1.text:='';
   panel2.Visible := false;
end;


procedure tprodutosNaLista.InsereComprador(sender:tobject);
begin
   with query1.SQL do
   begin
      clear;
      add('Update Produtos');
      add('set convidado = '+#39+ edit1.text +#39);
      add('where ref = '+#39+ dbgrid2.fields[4].AsString +#39);
   end;

   query1.execSql;
   CarregaProdutos(dbgrid3.Fields[0].AsString,dbgrid3.Fields[2].AsString,dbgrid3.Fields[3].AsString,Sender);
   edit3.text := '';
   edit2.text:='';
   edit1.text:='';
   panel2.Visible := false;
end;


procedure TProdutosNaLista.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
      if bitbtn5.enabled then
         bitbtn5.setfocus;
end;


procedure TProdutosNaLista.DeletarItemDalista(Sender: TObject);
begin
   with query1.SQL do
   begin
      clear;
      add('delete from Produtos');
      add('where ref = '+#39  + dbgrid2.fields[4].AsString+ #39);
   end;
   query1.execSql;
   CarregaProdutos(dbgrid3.Fields[0].AsString,dbgrid3.Fields[2].AsString,dbgrid3.Fields[3].AsString,Sender);
end;


procedure TProdutosNaLista.ToolButton1Click(Sender: TObject);
begin
   label8.caption := '';
   with query2.SQL do
   begin
      clear;
      if form1.lerParametro(form1.memo1.lines[3])= 'S' then
         add('Select Numlista, Loja, Noiva, noivo  from listas where tipo <> '+#39+'99'+#39+ ' order by noiva')
      else
         add('Select Numlista, Loja, Noiva, noivo  from listas where ( DataCasamento  >= '+#39+ form1.AjustaDataInicioDoMes('') +#39+ ') and (tipo <>'+#39+'99'+#39+') order by noiva')
   end;
   query2.open;
   dbgrid3.Columns[0].Width:= 40 ;
   dbgrid3.Columns[1].Width:= 25 ;
   dbgrid3.Columns[2].Width:= 200;

   label6.Caption := 'Abrir lista';
   panel1.visible:=true
end;


procedure TProdutosNaLista.ToolButton3Click(Sender: TObject);
begin
   label8.caption := '';
   query3.sql.clear;
   application.CreateForm(TFImpressao,FImpressao);
   FImpressao.Show;
   bitbtn3.enabled := false;
end;


procedure TProdutosNaLista.FormShow(Sender: TObject);
begin
   form1.desabilitaMenu(sender);
   panel2.top := 10;
   panel1.top := 1;
   label8.caption :='';
end;


procedure TProdutosNaLista.BitBtn2Click(Sender: TObject);
begin
   if (label6.Caption = 'Abrir lista') then
   begin
      Codlista := '';
      CarregaProdutos(dbgrid3.Fields[0].AsString,dbgrid3.Fields[2].AsString,dbgrid3.Fields[3].AsString,Sender);
      BitBtn4Clic(Sender);
   end;
end;


procedure TProdutosNaLista.BitBtn6Exit(Sender: TObject);
begin
   if panel2.visible then
      if edit2.enabled = true then
         edit2.setfocus;
end;


procedure TProdutosNaLista.Edit3Exit(Sender: TObject);
begin
   if edit1.enabled = true then
      edit1.setfocus;
end;


procedure TProdutosNaLista.BitBtn5Click(Sender: TObject);
var
   erro: string;
begin
   erro := 'Corrija antes o(s) seguinte(s) campo(s)' + #13;

   if edit2.text = '' then edit2.text := '0000000';
   if edit1.text = '' then erro := erro + ' - Digite o nome do Convidado para esse produto.' + #13;
   if cbox1.itemindex = -1 then erro := erro + ' - Selecione um tipo para o produto.';
   if    erro <> 'Corrija antes o(s) seguinte(s) campo(s)' + #13 then
      showmessage(erro)
   else
   begin
      if status = 'alterar' then
         AlterarItem(sender)
      else if status = 'comprador' then
         InsereComprador(sender);
   end;

end;


procedure TProdutosNaLista.InserirComprador2Click(Sender: TObject);
var
  NaoAlterar:boolean;
  i:integer;
begin
   NaoAlterar := false;

   edit1.Enabled := false;
   edit2.enabled := true;
   edit3.enabled := true;
   cbox1.Enabled := true;
   status := 'alterar';

   if dbgrid2.Fields[3].AsString <> '' then
      if application.messagebox(pchar('   Já Exite comprador para esse item!!  ' +#13+ '   Deseja alterar os dados do item ??'),pchar(form1.caption), mb_yesno + mb_iconwarning) = mrno then
         NaoAlterar := true;

     if NaoAlterar = false then
     begin
        edit2.text := dbgrid2.fields[0].asString;
        edit3.text := dbgrid2.fields[2].asString;
        edit1.text := dbgrid2.fields[3].asString;

        panel2.visible := true; //abre o painel2
        if edit1.text = '' then
           edit1.text := ' ';
        edit2.setfocus;

        for i := 0 to cbox1.items.count -1 do
           if pos( dbgrid2.fields[1].asString, cbox1.items[i]) > 0 then
             cbox1.itemindex := i;
     end;
end;


procedure TProdutosNaLista.Delete1Click(Sender: TObject);
begin
   if dbgrid2.fields[3].AsString <> '' then
   begin
      if application.messagebox(pchar('   ATENÇÃO!!!' +#13+ '   Esse item já tem comprador informado'+#13+'   Não é recomendável deleta-lo' +#13+'   Deseja mesmo exclui-lo???'),pchar(form1.caption),mb_yesno + mb_iconwarning ) = mryes then
         DeletarItemDalista(Sender);
   end
   else
      if application.messagebox(pchar('  Deseja excluir esse item???'),pchar(form1.caption),mb_yesno + mb_iconwarning ) = mryes then
         DeletarItemDalista(Sender);
end;


procedure TProdutosNaLista.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(Tfpesquisa, fpesquisa);
  fpesquisa.show;
  fpesquisa.Caption := 'Pesquisa para abrir lista';
end;

end.



