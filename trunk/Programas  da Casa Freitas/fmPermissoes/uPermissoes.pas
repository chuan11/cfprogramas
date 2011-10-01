unit uPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Menus,  Grids, DBGrids,
  SoftDBGrid, funcoes, funcsql, DB, ADODB, TFlatButtonUnit, ComCtrls,
  adLabelListBox, adLabelEdit, Buttons, fCtrls;

type
  TfmPermissoes = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    Tree: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    edUser: TadLabelEdit;
    btIncluiXML: TfsBitBtn;
    SoftDBGrid1: TSoftDBGrid;
    dsuser: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListarMenus(Sender: TObject;  item:TmenuItem);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    function liberaMenu(lst:Tstringlist; tag:string):boolean;
    procedure CarregaMenu(menu:TMenu);
    procedure InsertNodeChild(menuItem:TMenuItem; noPai:TTreeNode);
    function getMenuName(Str:String):String;
    procedure TreeClick(Sender: TObject);
    procedure criarTabela();
    procedure inserirGruposNaTabela();
    procedure mostraPermissoes(cod:String);
    procedure btIncluiXMLClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure ajustaPermisssaoAcessoTela();
    procedure ajustaPermisaoAcessoRestrito();
    procedure ajustaPermissaoSolicitaSenha();
    procedure ajustaPermissaoCampo(campo:String);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPermissoes: TfmPermissoes;
  LISTA:TStringList;
  MENU_SELECIONADO:String;
  TELAS_VISIVEIS:Tstringlist;

implementation
uses uMain, uAvarias, uCF;
{$R *.dfm}

procedure TfmPermissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmCadAvarias.Close();
   fmPermissoes := nil;
   action := caFree;
end;

procedure TfmPermissoes.ListarMenus(Sender: TObject;  item:TmenuItem);
var
   i:integer;
begin
   tb.Open;
   if item.Count > 0 then
   begin
      if item.parent = nil then
      begin
          tb.InsertRecord(['','',item.Caption,'']);
      end
      else
      begin
          tb.InsertRecord(['','',item.Caption,'']);
      end ;

      for i:=0 to item.Count -1 do
         ListarMenus(nil, item.Items[i]);
    end
    else
    begin
       if item.Tag <> 0 then
          tb.InsertRecord(['','x','',item.Caption, inttostr(item.Tag)]);
    end;
end;

procedure TfmPermissoes.gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.Field.FieldName = 'Menu' then
      column.Font.Style := [fsbold];

   if (Column.Field.FieldName = 'Acessa')
   or (Column.Field.FieldName = 'isAcessoRestrito')
   or (Column.Field.FieldName = 'isPedeAutorizacao')then
   begin
      column.Font.Style := [fsbold];
      Column.Font.Color := clred;
   end;
end;

function TfmPermissoes.liberaMenu(lst: Tstringlist; tag: string): boolean;
var
  i:integer;
  achou:boolean;
begin
   achou := false;
   for i:=0 to lst.Count-1 do
      if tag = lst[i] then
      begin
         achou := true;
         break;
      end;
    result := achou;
end;


procedure TfmPermissoes.InsertNodeChild( menuItem: TMenuItem; noPai: TTreeNode);
var
   i:integer;
   nodoFilho:TTreeNode;
begin
   for i:=0 to menuItem.Count-1 do
      if menuItem.Items[i].Count > 0 then
      begin
         if (TELAS_VISIVEIS.IndexOf(intToStr(menuItem.Items[i].Tag)) > -1) then
         begin
            nodoFilho := tree.Items.AddChild(noPai, getMenuName(menuItem.Items[i].Caption));
            InsertNodeChild(menuItem.Items[i], nodoFilho );
            LISTA.AddObject( intToStr(menuItem.Items[i].tag),  nodoFilho  )
         end
      end
      else
      begin
         if (TELAS_VISIVEIS.IndexOf(intToStr(menuItem.Items[i].Tag)) > -1) then
            LISTA.AddObject( intToStr( menuItem.Items[i].tag),  tree.Items.AddChild(noPai, getMenuName(  menuItem.Items[i].Caption) ) )
      end;
end;

procedure TfmPermissoes.carregaMenu(menu:TMenu);
var
  nod:TTreeNode;
begin
   nod := tree.Items.Add(nil,menu.Name);

//inserir na arvore
   InsertNodeChild(menu.Items, nod);
end;

function TfmPermissoes.getMenuName(Str: String): String;
begin
   while pos('&',str) > 0 do
      delete(str, pos('&',str) , 1);
   result := str;
end;

procedure TfmPermissoes.mostraPermissoes(cod: String);
var
  ds:TdataSet;
begin
   ds:= funcsql.getDataSetQ( 'Select grupo, isAcessoRestrito, codTela, isPedeAutorizacao from zcf_telasPermitidas where codTela = ' + cod,  fmMain.Conexao );
   grid.Visible := false;
   tb.First;
   while (tb.Eof = false) do
   begin
      ds.First();
      tb.Edit;
      tb.FieldByName('Acessa').asString := '';
      tb.FieldByName('isAcessoRestrito').asString := '';
      tb.post;

      while (ds.Eof = false) do
      begin
         if tb.FieldByName('codGrupo').asinteger = ds.FieldByName('grupo').AsInteger then
         begin
            tb.Edit;
            tb.FieldByName('Acessa').asString := 'X';

            if (ds.FieldByName('isAcessoRestrito').asInteger <> 0) then
               tb.FieldByName('isAcessoRestrito').asString := 'X'
            else
               tb.FieldByName('isAcessoRestrito').asString := '';

            if (ds.FieldByName('isPedeAutorizacao').asInteger <> 0) then
               tb.FieldByName('isPedeAutorizacao').asString := 'X'
            else
               tb.FieldByName('isPedeAutorizacao').asString := '';

            tb.post;
            break;
         end;
         ds.Next();
      end;
      tb.Next();
  end;
  ds.Free();
  grid.Visible := true;
end;


procedure TfmPermissoes.TreeClick(Sender: TObject);
begin
   if LISTA.IndexOfObject( tree.Selected ) > -1 then
   begin
      MENU_SELECIONADO := LISTA[LISTA.IndexOfObject(tree.Selected)];
      mostraPermissoes( MENU_SELECIONADO );
   end;
end;

procedure TfmPermissoes.criarTabela();
var
   cmd:String;
begin
   cmd := ' seq int primary key identity, Acessa varchar(02), Grupo varchar(50), codGrupo int, isAcessoRestrito varchar(02), isPedeAutorizacao varchar(02)';
   funcsql.getTable( fmMain.Conexao, tb, cmd );
   DataSource1.DataSet := tb;
end;

procedure TfmPermissoes.inserirGruposNaTabela();
var
   cmd : String;
begin
   cmd := 'insert ' + tb.TableName + ' Select '''', nm_grusu, cd_grusu, '''', '''' from dsgrusu order by nm_grusu';
   funcsql.execSQL(cmd,fmMain.Conexao);
   tb.Close();
   tb.open();

   grid.Columns[ tb.FieldByName('isPedeAutorizacao').Index ].Title.Caption := 'Pede autorização';
   grid.Columns[ tb.FieldByName('isAcessoRestrito').Index ].Title.Caption := 'Acesso restrito';
   grid.Columns[ tb.FieldByName('seq').Index ].Visible := false;
   grid.Columns[ tb.FieldByName('Codgrupo').Index ].Visible := false;
   grid.Columns[ tb.FieldByName('grupo').Index ].Width := 150;
   grid.Columns[ tb.FieldByName('acessa').Index ].Width := 50;
   grid.Columns[ tb.FieldByName('acessa').Index ].Alignment := taCenter;
   grid.Columns[ tb.FieldByName('isPedeAutorizacao').Index ].Alignment := taCenter;
   grid.Columns[ tb.FieldByName('isAcessoRestrito').Index ].Alignment := taCenter;
end;


procedure TfmPermissoes.FormCreate(Sender: TObject);
begin
   criarTabela();
   inserirGruposNaTabela();
   lista := TStringList.Create();

   TELAS_VISIVEIS := uCF.getTelasPrograma();

// carrega o menu principal
   carregaMenu(fmMain.menuPrincipal);

// inica o menu de avarias para aplicar as permissoes a ele
   Application.CreateForm( TfmCadAvarias  , fmCadAvarias);
   fmCadAvarias.Enabled := false;

   carregaMenu(fmCadAvarias.menuAvarias);
end;
                             
procedure TfmPermissoes.btIncluiXMLClick(Sender: TObject);
var
   cmd:String;
begin
   cmd :=
   ' select dsusu.nm_usu, dsgrusu.nm_grusu from dsusu inner join dsgrusu on dsgrusu.cd_grusu = dsusu.cd_grusu ' +
   ' where nm_usu like ' + quotedStr(edUser.Text + '%');
   dsuser.DataSet := funcSql.getDataSetQ(cmd, fmMain.Conexao);
end;

procedure TfmPermissoes.ajustaPermisssaoAcessoTela();
begin
   tb.Edit();
   if(tb.FieldByName('Acessa').asString = '') then
   begin
      funcsql.execSQL( ' if not exists( select * from zcf_telasPermitidas where grupo = ' + tb.fieldByname('codGrupo').asString + ' and codTela = ' + MENU_SELECIONADO  +')'+
                       #13+ ' insert zcf_telasPermitidas (codTela, grupo) values ( '+
                       MENU_SELECIONADO + ', ' +
                       tb.fieldByname('codGrupo').asString + ')'
                     , fmMain.Conexao);
      tb.FieldByName('Acessa').asString := 'X'
   end
   else
   begin
      funcsql.execSQL( 'delete from zcf_telasPermitidas where codTela  =  ' +  MENU_SELECIONADO +
                      ' and grupo = ' + tb.FieldByName('codGrupo').AsString, fmMain.Conexao);
      tb.FieldByName('Acessa').asString := ''
   end;
   tb.Post();
end;

procedure TfmPermissoes.ajustaPermissaoCampo(campo:String);
var
   cmd:String;
begin
  tb.Edit();
   cmd := ' update zcf_telasPermitidas '+
          ' set '+
          ' ' + campo +'= ' + boolToStr( not(tb.fieldByname(campo).asString <> '') ) +
          ' where '+
          ' codTela= '+ MENU_SELECIONADO + ' and ' +
          ' grupo= ' + tb.fieldByname('codGrupo').asString;

   funcSQL.execSQL(cmd, fmMain.conexao);

   if(tb.FieldByName(campo).asString = '') then
      tb.FieldByName(campo).asString := 'X'
   else
      tb.FieldByName(campo).asString := '';

   tb.post();
end;

procedure TfmPermissoes.ajustaPermisaoAcessoRestrito();
begin
   ajustaPermissaoCampo('isAcessoRestrito');
end;

procedure TfmPermissoes.ajustaPermissaoSolicitaSenha();
begin
   ajustaPermissaoCampo('isPedeAutorizacao');
end;

procedure TfmPermissoes.gridCellClick(Column: TColumn);
begin
   if (tb.IsEmpty = false) and (tree.Selected <> nil) then
   begin
      if (Column.FieldName = 'Acessa') or (Column.FieldName = 'isAcessoRestrito') or (Column.FieldName = 'isPedeAutorizacao') then
      begin
          if (Column.FieldName = 'Acessa')then
             ajustaPermisssaoAcessoTela();

          if (tb.FieldByName('Acessa').asString = 'X') and (Column.FieldName = 'isAcessoRestrito') then
             ajustaPermisaoAcessoRestrito();

          if (tb.FieldByName('Acessa').asString = 'X') and (Column.FieldName = 'isPedeAutorizacao') then
             ajustaPermissaoSolicitaSenha();
      end;
   end;
end;


end.
