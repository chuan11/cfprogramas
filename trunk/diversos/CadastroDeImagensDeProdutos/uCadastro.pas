unit uCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, funcoes, funcsql, StdCtrls, Grids, DBGrids,
  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, adLabelEdit,
  TFlatButtonUnit, TFlatCheckBoxUnit, jpeg, FileCtrl;

type
  TfmCadastro = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
    edCodigo: TadLabelEdit;
    edDescricao: TadLabelEdit;
    pnBotoes: TPanel;
    lbIs_ref: TLabel;
    btConsultar: TFlatButton;
    btIncluir: TFlatButton;
    btAlterar: TFlatButton;
    btExcluir: TFlatButton;
    CheckBox1: TFlatCheckBox;
    Panel1: TPanel;
    lbDiretorios: TDirectoryListBox;
    cbUnidades: TDriveComboBox;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    lbArquivos: TFileListBox;
    Label1: TLabel;
    procedure btConsultarClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimparCampos();
    procedure btIncluirClick(Sender:Tobject);
    procedure incluirImgagem(mostraMsg:Boolean);
    function getCodProduto(str:String):String;
    procedure cadastraProduto(is_ref:String);
    procedure btAlterarClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function ConverterJPegParaBmp(Arquivo: string):String;
    procedure FlatButton2Click(Sender: TObject);
    procedure lbDiretoriosChange(Sender: TObject);
    procedure carregaimagem(narquivo:String);
    procedure ajustaDimensaoBitmap(arq:String);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure contaArquivos();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadastro: TfmCadastro;

implementation

uses uMain;

{$R *.dfm}

function TfmCadastro.ConverterJPegParaBmp(Arquivo: string):String;
var
  JPeg: TJPegImage;
  Bmp: TBitmap;
  nArquivo:String;
begin
  JPeg := TJPegImage.Create;
  try
    JPeg.LoadFromFile(Arquivo);
    Bmp := TBitmap.Create;
    try
      Bmp.Assign(JPeg);
      nArquivo := ChangeFileExt(Arquivo, '.bmp');
      Bmp.SaveToFile(nArquivo);
    finally
      Bmp.Free;
    end;
  finally
    JPeg.Free;
    result :=nArquivo;
  end;
end;

function TfmCadastro.getCodProduto(str: String): String;
var
  cmd:String;
begin
   if (str= '' )then
   begin
      msgTela('', 'Informe um código.',MB_ICONERROR+ MB_OK);
      result := '';
   end
   else
   begin
      cmd := ' Select top 01 crefe.is_ref from crefe where cd_ref = ' + quotedStr(str) +
             ' union '+
             ' select top 01 dscbr.is_ref from dscbr where cd_pesq= ' + quotedStr(str) ;
      str := funcSQl.openSQL(cmd, 'is_ref', fmMain.conn);
      if str = '' then
        msgTela('', 'Esse código não é cadastrado.',MB_ICONERROR+ MB_OK);
      result :=  str;
   end
end;


procedure TfmCadastro.btConsultarClick(Sender: TObject);
var
  cmd,is_ref:String;
  ds:TdataSet;
begin
   screen.Cursor := crHourglass;
   image1.Picture := nil;
   is_ref := getCodProduto(edCodigo.Text);
   if (is_ref <> '') then
   begin
     cmd := ' select c.is_ref, c.cd_ref, c.ds_ref , i.imagem from crefe c left join zcf_crefe_imagens i  on c.is_ref = i.is_ref' +
            ' where c.is_ref = ' + is_ref;

     ds:= funcSQl.getDataSetQ(cmd, fmMain.conn);
     funcsql.execSQL(cmd, fmMain.conn);
     edCodigo.Text := ds.fieldByname('cd_ref').asString;
     lbIs_ref.Caption := ds.fieldByname('is_ref').asString;
     edDescricao.Text := ds.fieldByname('ds_ref').asString;
     Image1.Picture.Assign( ds.fieldByname('imagem') );
     ds.Destroy();
   end
   else
   begin
      edDescricao.Text := '';
      Image1.Picture := nil;
   end;
   edCodigo.SetFocus();
   screen.Cursor := crDefault;
end;

procedure TfmCadastro.carregaImagem(nArquivo:String);
var
   delTemp:boolean;
begin
   if (nArquivo <> '') then
   begin
     if ( pos('.jpg',nArquivo)  > 0) then
     begin
        nArquivo :=  ConverterJPegParaBmp(nArquivo);
        delTemp := true;
     end;

     if ( tamArquivo(nArquivo) > 25000000 ) then
        ajustaDimensaoBitmap(nArquivo);

     begin
        Image1.Picture.LoadFromFile( nArquivo );
        if (delTemp = true )then
           deleteFile(nArquivo);
     end;
  end;
end;

procedure TfmCadastro.Image1DblClick(Sender:TObject);
var
   nArquivo:String;
begin
   nArquivo := funcoes.DialogAbrArq('Arquivos bmp,jpg |*.bmp;*.jpg','c:\');
   if (nArquivo <> '') then
     carregaimagem(nArquivo);
end;



procedure TfmCadastro.edCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if (key = VK_RETURN) then
      btConsultarClick(nil);
end;

procedure TfmCadastro.LimparCampos;
begin
   image1.Picture := nil;
   image1.Refresh();
   edCodigo.Text := '';
   edDescricao.Text := '';
   lbIs_ref.Caption := '';
   edCodigo.SetFocus();
end;

procedure TfmCadastro.incluirImgagem(mostraMsg: Boolean);
var
  is_ref:String;
  erro: String;
begin
   screen.Cursor := crHourglass;
   erro := '';
   is_ref := getCodProduto(edCodigo.Text);

   if  (edCodigo.Text = '') then
      erro := erro+' - Informe um código.'+#13;

   if (is_ref = '') then
      erro := erro+' - Esse produto não é cadastrado.'+#13
   else
      if (edCodigo.Text <> '') then
         if ( funcSql.openSQL('Select is_ref from zcf_crefe_imagens where is_ref = ' + is_ref, 'is_ref', fmMain.conn ) <> '' )then
           erro := erro+' - Esse código já tem uma imagem cadastrada.'+#13;

   if (Image1.Picture = nil) then
      erro := erro+' - Selecione uma imagem.'+#13;

   if erro <> '' then
      msgTela('', erro,  MB_ICONERROR +  mb_ok)
   else
   begin
     cadastraProduto(is_ref);
     if (mostraMsg = true) then
        msgTela('', 'Inclusão efetuada.',MB_OK + MB_ICONEXCLAMATION);
     LimparCampos();
   end;
   screen.Cursor := crdefault;
end;

procedure TfmCadastro.btIncluirClick(Sender:TObject);
begin
   incluirImgagem(true);
end;


procedure TfmCadastro.cadastraProduto(is_ref: String);
var
   tb:TADOTable;
begin
  tb :=  TADOTable.Create(nil);
  tb.TableName := 'zcf_crefe_imagens';
  tb.Filter := 'is_ref = ' + is_ref;
  tb.Filtered := true;
  tb.connection := fmMain.conn;
  tb.Open();
  tb.Append();
  tb.fieldByName('is_ref').AsString := is_ref;
  tb.fieldByName('imagem').Assign( Image1.Picture );
  tb.Post();
  tb.Close();
end;

procedure TfmCadastro.btAlterarClick(Sender: TObject);
begin
   if (lbIs_ref.Caption <> '') then
      if( MsgTela('','Deseja alterar a imagem desse produto? ', MB_YESNO + MB_ICONQUESTION) = mrYes ) then
      begin
         funcSQl.execSQL('Delete from zcf_crefe_imagens where is_ref = ' + lbIs_ref.Caption, fmMain.conn );
         incluirImgagem(false);
         LimparCampos();
         msgTela('', 'Alteração efetuada.',MB_OK + MB_ICONEXCLAMATION);
      end;
end;

procedure TfmCadastro.CheckBox1Click(Sender: TObject);
begin
   Image1.Stretch := CheckBox1.Checked ;
end;

procedure TfmCadastro.btExcluirClick(Sender: TObject);
begin
   if (lbIs_ref.Caption <> '') then
      if (msgTela('', 'Deseja escluir a imagem ?', MB_ICONQUESTION + MB_YESNO) = mrYes ) then
      begin
         funcSQl.execSQL('Delete from zcf_crefe_imagens where is_ref = ' + lbIs_ref.Caption, fmMain.conn );
         LimparCampos();
         msgTela('', 'Imagem Excluída.',MB_OK + MB_ICONEXCLAMATION);
         LimparCampos();
      end;
end;


procedure TfmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmCadastro := nil;
   action := caFree;
end;

procedure TfmCadastro.FlatButton2Click(Sender: TObject);
var
  nArquivos,i:integer;
  nArquivo:String;
begin
   nArquivos := 0;
   for i:=0 to lbArquivos.Items.Count -1 do
      if (pos('.JPG', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) or (pos('.BMP', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) then
      begin
          nArquivos := nArquivos+1;
          nArquivo := ExtractFileName(lbArquivos.Items.Strings[i]);
          delete(nArquivo, length(nArquivo)-3,04);
          edCodigo.Text := funcoes.SohNumeros(nArquivo);
          btConsultarClick(nil);
          if (Image1.Picture.Width <= 1 ) and (edDescricao.Text <> '') then
          begin
             MsgTela('',edCodigo.Text + ' ' + edDescricao.Text + #13+ 'Imagem não cadastrada, incluir', MB_OK + MB_ICONWARNING );
             carregaimagem( lbArquivos.Items.Strings[i]  );
             incluirImgagem(true);
          end
          else
          begin
             MsgTela('',edCodigo.Text + ' ' + edDescricao.Text + #13+ 'Imagem já cadastrada, alterar', MB_OK + MB_ICONEXCLAMATION );
             carregaimagem( lbArquivos.Items.Strings[i] );
             btAlterarClick(nil);
          end;
     end;
     if nArquivos > 0 then
       MsgTela('','Processo concluido',0 + MB_ICONWARNING )
     else
       MsgTela('','Não encontrei nenhum arquivo para processar.',0 + MB_ICONWARNING );
     panel1.Visible := false;
end;

procedure TfmCadastro.lbDiretoriosChange(Sender: TObject);
begin
   lbArquivos.Directory := lbDiretorios.Directory;
   contaArquivos();   
end;

procedure TfmCadastro.ajustaDimensaoBitmap(arq:String);
var
bitmap, resizedbitmap : tbitmap;  newheight, newwidth : integer; stretchrect : trect;
begin
  bitmap := tbitmap.create;
  resizedbitmap := tbitmap.create;
  bitmap.loadfromfile( arq );
  if bitmap.Width <> bitmap.height then begin
     if bitmap.height > bitmap.width then begin
        newheight := 768;
        newwidth := (newheight * bitmap.width) div bitmap.height;
     end
     else begin
        newwidth := 1024;
        newheight := (newwidth * bitmap.height) div bitmap.width;
     end;
   end
   else begin
        newheight := 1024;
        newwidth := 768;
   end;

   if (bitmap.Width > 1024) or (bitmap.Height > 768) then
   begin
      stretchrect.left := 0;
      stretchrect.Top := 0;
      stretchrect.right := newwidth;
      stretchrect.bottom := newheight;
      resizedbitmap.Width := newwidth;
      resizedbitmap.height := newheight;
      resizedbitmap.Canvas.StretchDraw(stretchrect, bitmap);
      resizedbitmap.SaveToFile(arq);
   end;
end;


procedure TfmCadastro.FlatButton1Click(Sender: TObject);
begin
   Panel1.Visible := false;
end;

procedure TfmCadastro.FlatButton3Click(Sender: TObject);
begin
   Panel1.Visible := true;
   cbUnidades.Refresh;
end;

procedure TfmCadastro.contaArquivos;
var
   i,j:integer;
begin
   j:=0;
   for i:=0 to lbArquivos.Items.Count -1 do
      if (pos('.JPG', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) or
         (pos('.BMP', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) then
         inc(j);
   label1.Caption := 'Arq bmp/jpg: ' + intToStr(j);
end;

end.
