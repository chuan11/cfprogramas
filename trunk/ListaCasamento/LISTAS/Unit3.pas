unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Mask, DBCtrls, ExtCtrls,
  Menus, Edit1ColorFocus, ComboBoxColor, MEditColor, ADODB;

type
  TCadListas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    PopupMenu1: TPopupMenu;
    Incluirproduto1: TMenuItem;
    AlterarDados1: TMenuItem;
    Excluir1: TMenuItem;
    StaticText1: TStaticText;
    Label8: TLabel;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    ListBox2: TListBox;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label10: TLabel;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    DataSource1: TDataSource;
    Label9: TLabel;
    DataSource3: TDataSource;
    Label11: TLabel;
    DBGrid2: TDBGrid;
    edit1: TEdit1ColorFocus;
    cbox2: TComboBoxColor;
    edit2: TEdit1ColorFocus;
    MAskedit1: tMeditColor;
    edit3: TEdit1ColorFocus;
    edit4: TEdit1ColorFocus;
    edit5: TEdit1ColorFocus;
    Maskedit2: tMeditColor;
    edit6: TEdit1ColorFocus;
    Query3: TADOQuery;
    Query1: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure IncluirLista(sender:tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure DesabilitaEdit(sender:Tobject);
    procedure BitBtn6Click(Sender: TObject);
    procedure HabilitaEdit(sender:Tobject);
    procedure consultaLista;
    procedure AlteraCadastro(sender:Tobject);
    procedure ExcluirLista(sender:Tobject);
    procedure Incluirproduto1Click(Sender: TObject);
    procedure AlterarDados1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    function  VerificaPreenchimentodosCampos():String;
    Function  ValidaData(data:string):boolean;
    function  EhListaDestaLoja():boolean;
    procedure DialogoIncluirItens(sender:TObject; numlista:string);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CarregaListas(sender:Tobject);
    procedure cbox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  CadListas: TCadListas;
  status:string;
implementation

uses Unit1;

{$R *.DFM}

function  TCadListas.EhListaDestaLoja():boolean;
begin
  if dbgrid1.fields[01].asString <> form1.lerParametro (form1.memo1.lines[0]) then
     EhListaDestaLoja := false
  else
     EhListaDestaLoja := true;
  if form1.lerParametro (form1.memo1.lines[0]) = '00' then
     EhListaDestaLoja := true;
end;

function  TCadListas.VerificaPreenchimentodosCampos():String;
var
   erro:string;
begin
   erro := 'Falta(m) preencher o(s) seguinte(s) campo(s):' + #13 ;
   if edit1.text = '' then
      erro := erro + ' - Nome da noiva' + #13 ;
   if cbox2.itemindex = -1 then
      erro := erro + ' - Informe qual é o tipo da lista.' + #13 ;
   if (maskedit1.text = '  /  /    ')  or (validadata(maskedit1.text) = false ) then
      erro := erro + ' - A data da cerimonia é inválida ou já passou.' + #13 ;
   if edit2.text = '' then
     erro := erro + ' - Nome do noivo.' + #13 ;
   if edit3.text = '' then
     erro := erro + ' - Endereço de entrega.' + #13 ;
   if edit4.text = '' then
     erro := erro + ' - Bairro.' + #13 ;
   if edit5.text = '' then
      erro := erro + ' - Ponto de referencia.' + #13 ;
   if edit6.text = '' then
      erro := erro + ' - Coloque algo na observação.' + #13 ;
   if maskedit2.text = '    -    ' then
      erro := erro + ' - Telefone.         ' + #13 ;
   VerificaPreenchimentodosCampos := erro;
end;


Function TCadListas.ValidaData(data:string):boolean;
var
   hoje:tdatetime;
begin
   hoje := now;
   ValidaData:=true;
   try
      StrToDate(data);
   except
      on e:exception do
         ValidaData := false;
   end;
   if StrToDate(data) <= hoje then
      ValidaData := false;
end;

procedure TCadListas.DialogoIncluirItens(sender:TObject; numlista:string);
begin
   panel1.top := 05;
   panel1.visible := true;
   listbox1.itemindex:=0;
   listbox2.itemindex:=0;
   label8.caption := numlista;
   listbox1.items.clear;
   listbox2.items.clear;
   if cbox2.itemindex = 0 then
      listbox1.Items.LoadFromFile(PATH+'ItemsChadeCozinha.cfg')
   else
      listbox1.items.loadfromfile(PATH + 'listachadepanela.cfg');

end;


procedure TCadListas.DesabilitaEdit(sender:Tobject);
var
   i:integer;
begin
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = TEdit1ColorFocus ) then
      begin
         TEdit (components[i]).text := '';
         TEdit (components[i]).enabled := false;
      end;
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = Tlabel ) then
         Tlabel (components[i]).enabled := false;
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = tmEditColor ) then
      begin
         tmEditColor (components[i]).enabled := false;
         tmEditColor (components[i]).text := '';
      end;
   cbox2.Enabled:= false;
   cbox2.itemindex:= -1;
   bitbtn4.visible := false;
   bitbtn5.visible := false;
   dbgrid1.enabled:= TRUE;
end;

procedure TCadListas.HabilitaEdit(sender:Tobject);
var
   i:integer;
begin
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = TEdit1ColorFocus ) then
      begin
         TEdit (components[i]).text := '';
         TEdit (components[i]).enabled := true;
      end;
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = Tlabel ) then
         Tlabel (components[i]).enabled := true;
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = TmEditColor ) then
         tmaskedit (components[i]).enabled := true;
   cbox2.Enabled:= true;
   bitbtn4.visible := true;
   bitbtn5.visible := true;
end;


procedure TCadListas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=cafree;
   CadListas := nil;
   form1.HabilitaMenu(sender);
end;


procedure TCadListas.CarregaListas(sender:Tobject);
begin
   screen.Cursor := crhourglass;
   with query3.sql do
   begin
      Clear;
      if form1.rg.itemindex = 0 {somente listas desse mes pra frente} then
         add('Select NumLista, Loja, noiva, noivo, dataLista from listas where (tipo <> 99) and( DataCasamento  >='+#39+ Form1.AjustadataInicioDoMes('')+#39+ ' )order by noiva')
      else
         add('Select NumLista, Loja, noiva, noivo, dataLista from listas where (tipo <> 99) order by noiva')
   end;
   query3.open;
   screen.Cursor := crDefault;
end;


procedure TCadListas.FormShow(Sender: TObject);
var
   i:integer;
begin
   form1.DesabilitaMenu(sender);
   dbgrid1.Columns[0].title.caption := 'NUM';
   dbgrid1.Columns[1].title.caption := 'LOJA';
   dbgrid1.Columns[2].title.caption := 'NOIVA';
   dbgrid1.Columns[3].title.caption := 'NOIV0';
   dbgrid1.Columns[4].title.caption := 'DATA CADASTRO';

   DBGrid1.Columns[0].Width := 40;
   DBGrid1.Columns[1].Width := 35;
   DBGrid1.Columns[2].Width := 240;
   DBGrid1.Columns[3].Width := 200;

   for i:=0 to DBGrid1.Columns.count-1 do
   begin
      DBGrid1.Columns[i].Title.Color := clBtnFace;
      DBGrid1.Columns[i].Title.Font.Size:= 08;
      DBGrid1.Columns[i].Title.Font.Color := clBlack;
      DBGrid1.Columns[i].Title.Font.Style := [fsBold];
      DBGrid1.Columns[i].Title.Font.Color := clnavy;
   end;
   for i := 0 to ( ComponentCount - 1 ) do
      if ( components[i].ClassType = TEdit1ColorFocus ) then
        TEdit (components[i]).text := '';
   DesabilitaEdit(sender);
   status := 'normal';
   CarregaListas(sender);
end;

procedure TCadListas.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   if key= VK_return then
   begin
      Perform (CM_DialogKey, VK_TAB, 0);
      key := 0
   end;
end;


procedure   TCadListas.AlteraCadastro(sender:Tobject);
begin
   with query1 do
   begin
      sql.clear;
      sql.add('update listas');
      sql.add('set Noiva = '+#39       + edit1.text  +#39' , ');
      sql.add('    Noivo = '+#39       + edit2.text +#39+ ' ,');
      sql.add('    EndEntrega = '+#39  + edit3.text +#39+ ' ,');
      sql.add('    Bairro    ='+#39    + edit4.text +#39+ ' ,');
      sql.add('    FoneRes   ='+#39    + maskedit2.text+#39+ ' , ');
      sql.add('    DataCasamento ='+#39+ Form1.ajustadata(maskedit1.text) +#39+ ' , ');
      sql.add('    EndReferencia ='+#39+ edit5.text +#39+ ' , ');
      sql.add('    Observacao = '+#39  + edit6.text +#39+ ' , ');
      sql.add('    Tipo = '+#39+copy(cbox2.items[cbox2.itemindex],01,02)+#39 );    //casamento;

      sql.add(' where numlista ='+#39  + label8.caption + #39 )
   end;
   query1.execsql;
   BitBtn5Click(Sender);
   form1.msgderodape('Alteração feita com sucesso!!!!');
   status := 'normal';
end;


procedure TCadListas.ExcluirLista(sender:Tobject);
begin
{   with query1 do
   begin
      sql.clear;
      sql.add('delete from produtos');
      sql.add('where Numlista = "'+ dbgrid1.Fields[0].asstring + '"');
      execSql;
   end;
}
   with query1 do
   begin
      sql.clear;
      sql.add('update listas set tipo =' +#39+ '99' +#39);
      sql.add('where Numlista ='+#39+ dbgrid1.Fields[0].asstring +#39);
      execSql;
   end;
   bitbtn5Click(sender);
end;


procedure TCadListas.IncluirLista(sender:tobject);
var
  numLista:string;
begin
   query1.sql.clear;
   numLista := form1.ProximoValor(sender,'listas','Numlista');
   with query1.sql do
   begin
      clear;
      add('INSERT LISTAS VALUES ('+#39+ numLista +#39+' , '+#39+ edit1.text +#39+ ' , '+#39+ edit2.text +#39+' , '+#39+ edit3.text +#39+ ' , '+#39+ edit4.text+#39+' , '+#39+  maskedit2.text +#39+' , '+#39+ Form1.ajustadata(maskedit1.text)+#39+ ' , '+#39+  edit5.text +#39+' , ' +#39+ Form1.AjustaData(DateToStr(now)) +#39+' , '+#39+ copy(form1.statusbar1.Panels[1].text,07,02) +#39+' , ' +#39+ edit6.text +#39+' , ');

      if cbox2.itemindex = 0 then
         add(#39+'01'+#39+')' )    //casamento
      else
         add(#39+'02'+#39+')' );   //cozinha
   end;
   query1.ExecSQL;
   if application.messagebox(pchar('  Inclusão da lista feita com sucesso' +#13+'Gostaria de escolher os produtos agora ???' ),TITULO , MB_YESNO + MB_ICONQUESTION) = MRYES THEN
      DialogoIncluirItens(sender,numlista);
   BitBtn5Click(Sender);
end;


procedure TCadListas.BitBtn5Click(Sender: TObject);
begin
  if status  = 'incluir' then
  begin
     DesabilitaEdit(sender);
     dbgrid1.enabled := true;
  end;
   DesabilitaEdit(sender);
   status := 'normal';
   CarregaListas(sender);
end;


procedure TCadListas.BitBtn6Click(Sender: TObject);
begin
   if status <> 'normal' then
   begin
      if application.messagebox(pchar( #13 +'Deseja abandonar a operação corrente ??'+ #13),TITULO , MB_yesno + MB_ICONquestion) = mryes then
         CadListas.close;
   end
   else
     CadListas.close;
end;


procedure TCadListas.consultaLista;
begin
   with query1 do
   begin
      sql.clear;
      sql.add('SELECT * FROM LISTAS WHERE NUMLISTA =' +#39+ dbgrid1.Fields[0].AsString + #39 );
      open;
   end;
   edit1.text := dbgrid2.Fields[1].asstring;
   edit2.text := dbgrid2.Fields[2].asstring;
   edit3.text := dbgrid2.Fields[3].asstring;
   edit4.text := dbgrid2.Fields[4].asstring;
   edit5.text := dbgrid2.Fields[7].asstring;
   maskedit2.text := dbgrid2.Fields[5].asstring;
   maskedit1.text := dbgrid2.Fields[6].asstring;
   edit6.text := dbgrid2.Fields[10].asstring;

   if dbgrid2.Fields[11].asString = '01' then
      cbox2.itemindex:=00
   else
     cbox2.itemindex :=01;
end;


procedure TCadListas.Incluirproduto1Click(Sender: TObject);
begin
   habilitaEdit(sender);
   edit1.setfocus;
   dbgrid1.enabled := false;
   status := 'incluir';
end;


procedure TCadListas.AlterarDados1Click(Sender: TObject);
var
   i:integer;
begin
      status := 'alterar';
      for i := 0 to ( ComponentCount - 1 ) do
         if ( components[i].ClassType = TEdit1ColorFocus ) then
            TEdit (components[i]).enabled := true;
      for i := 0 to ( ComponentCount - 1 ) do
         if ( components[i].ClassType = Tlabel ) then
           Tlabel (components[i]).enabled := true;
      for i := 0 to ( ComponentCount - 1 ) do
         if ( components[i].ClassType = tmeditColor ) then
           tmaskedit (components[i]).enabled := true;

      cbox2.enabled:= true;
      ConsultaLista;
      label8.caption := dbgrid1.fields[0].asstring;
      edit1.setfocus;
      bitbtn4.Visible := true;
      bitbtn5.Visible := true;
      dbgrid1.Enabled := false;
end;


procedure TCadListas.Excluir1Click(Sender: TObject);
begin
  if EhListaDestaLoja = False then
     application.MessageBox('Você não pode excluir esta lista porque ela não pertence a esta loja.'+#13+'Somente a loja que a cadastrou pode excluí-la.',TITULO,MB_OK + MB_ICONERROR)
  else
  if  application.messagebox(pchar('   ATENÇÃO!!!' +#13+'   Se existirem produtos cadastrados para essa lista eles também serão excluídos.' +#13+ '   Deseja realmente Exclui-la ??? '), TITULO, MB_yesno + mb_iconWarning) = mryes then
      ExcluirLista(sender);
end;


procedure TCadListas.PopupMenu1Popup(Sender: TObject);
begin
   form1.msgderodape('');
end;

procedure TCadListas.BitBtn3Click(Sender: TObject);
var
   i:integer;
begin
    i := listbox1.itemindex;
    if listbox1.itemindex > -1 then
    begin
       listbox2.Items.add(listbox1.items[listbox1.itemindex]);
       listbox1.items.delete(i);
    end;
    listbox1.itemindex := i;
    listbox1.setfocus;
end;

procedure TCadListas.BitBtn7Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to listbox1.items.count - 1 do
      listbox2.Items.add(listbox1.items[i]);
   listbox1.items.clear;
   listbox1.setfocus;
end;


procedure TCadListas.BitBtn1Click(Sender: TObject);
begin
   listbox1.Items.clear;
   listbox2.Items.clear;
   panel1.visible:= false;
end;


procedure TCadListas.BitBtn8Click(Sender: TObject);
var
   i:integer;
begin
    i := listbox2.itemindex;
    if listbox2.itemindex > -1 then
    begin
       listbox1.Items.add(listbox2.items[listbox2.itemindex]);
       listbox2.items.delete(i);
    end;
    listbox2.itemindex := i;
    listbox2.setfocus;
end;


procedure TCadListas.BitBtn9Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to listbox2.items.count - 1 do
      listbox1.Items.add(listbox2.items[i]);
   listbox2.items.clear;
   listbox2.setfocus;
end;


procedure TCadListas.BitBtn4Click(Sender: TObject);
begin
  if status = 'incluir' then
  begin
     if VerificaPreenchimentodosCampos() <> 'Falta(m) preencher o(s) seguinte(s) campo(s):' + #13 then
        appliCation.messagebox(pchar( VerificaPreenchimentodosCampos() ),TITULO , MB_OK + MB_ICONERROR)
     else
        IncluirLista(sender);
  end;

  if status = 'normal' then
      BitBtn5Click(Sender);

  if (status = 'alterar') then
  begin
     if ( EhListaDestaLoja() = true ) then
     begin
         if VerificaPreenchimentodosCampos() <> 'Falta(m) preencher o(s) seguinte(s) campo(s):' + #13 then
            appliCation.messagebox(pchar( VerificaPreenchimentodosCampos() ),TITULO , MB_OK + MB_ICONERROR)
         else
            if  application.messagebox('      Confirma Alteracao ?? ', TITULO, MB_yesno + mb_iconquestion) = mryes then
               AlteraCadastro(sender);
     end
     else
        application.MessageBox('Você não pode alterar  esta lista porque ela não pertence a esta loja.'+#13+'Somente a loja que a cadastrou pode altera-la.',TITULO,MB_OK + MB_ICONERROR)
  end;
end;


procedure TCadListas.BitBtn2Click(Sender: TObject);
var
   numItem,i:integer;
begin
   if listbox2.items.count < 1 then
      appliCation.messagebox(pchar( ' Sem items para incluir !!!' ),TITULO , MB_OK + MB_iconerror)
   else
   begin
      numItem := StrToInt(form1.ProximoValor(sender,'produtos','ref'));
      query1.SQL.clear;
      for i := 0 to listbox2.items.count -1 do
      begin
         query1.sql.Add('Insert produtos values('+#39+ label8.caption +#39+' , '+#39+'0000000'+#39+' , '+#39+''+#39+' , '+#39+ copy(listbox2.Items[i],(pos('- ',listbox2.Items[i])+1),40) +#39+ ' , '+#39+  inttostr(numItem) +#39+ ' , '+#39+ copy(listbox2.Items[i],01,02)+#39+')');
         numItem := numItem + 1;
      end;
      query1.execSQL;
      BitBtn1Click(Sender);
      appliCation.messagebox(pchar( ' Os itens foram incluidos com sucesso!!!' ),TITULO , MB_OK + MB_iconexclamation);
   end;
end;


procedure TCadListas.cbox2Change(Sender: TObject);
begin
   if cbox2.itemindex = 1 then
   begin
      edit2.text:='-';
      edit2.enabled:=false;
      maskedit1.setfocus;
   end
   else
   begin
      edit2.text:='';
      edit2.enabled:=true;
      edit2.setfocus;
  end
end;

end.
