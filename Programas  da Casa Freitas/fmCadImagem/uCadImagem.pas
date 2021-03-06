unit uCadImagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, funcoes, funcsql, StdCtrls, Grids, DBGrids,
  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, adLabelEdit,
  TFlatButtonUnit, TFlatCheckBoxUnit, jpeg, FileCtrl;

type
  TfmCadastro = class(TForm)
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
    lbTotalArquivos: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    procedure btConsultarClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimparCampos();
    procedure btIncluirClick(Sender:Tobject);
    procedure incluirImgagem(mostraMsg:Boolean);
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
    procedure chamaAlteracaoProduto(mostraMsg:boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadastro: TfmCadastro;

implementation

uses uMain, cf;

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
//      nArquivo := SysUtils.ChangeFileExt(Arquivo, '_.bmp');
      nArquivo := funcoes.getDirLogs() + 'arq.bmp';

      Bmp.SaveToFile(nArquivo);
    finally
      Bmp.Free;
    end;
  finally
    JPeg.Free;
    result :=nArquivo;
  end;
end;

procedure TfmCadastro.btConsultarClick(Sender: TObject);
var
  cmd,is_ref:String;
  dsImagem, dsProduto:TdataSet;
begin
   image1.Picture.Assign(nil);
   image1.Refresh();

   screen.Cursor := crHourglass;
   dsProduto := cf.getDadosProd( fmMain.getUoLogada(), edCodigo.Text, '', '101', true );

   if (dsProduto.IsEmpty = false ) then
   begin
     edCodigo.Text := dsProduto.fieldByname('codigo').asString;
     lbIs_ref.Caption := dsProduto.fieldByname('is_ref').asString;
     edDescricao.Text := dsProduto.fieldByname('DESCRICAO').asString;

     dsImagem := cf.getImagemProduto(lbIs_ref.Caption);
     Image1.Picture.Assign( dsImagem.FieldByName('imagem'));
   end
   else
   begin
      edDescricao.Text := '';
      lbIs_ref.Caption := '';
   end;
   if (edCodigo.Visible = true) then
      edCodigo.SetFocus();
   screen.Cursor := crDefault;
   dsProduto.Free();

end;

procedure TfmCadastro.carregaImagem(nArquivo:String);
var
   delTemp:boolean;
begin
   if (nArquivo <> '') then
   begin
     funcoes.gravaLog('carregando arquivo:' + nArquivo);
     if ( pos('.JPG', nArquivo)  > 0) then
     begin
        fmMain.msgStatus('Imagem carregada � jpg, convertendo...');
        nArquivo :=  ConverterJPegParaBmp(nArquivo);
        delTemp := true;
     end
     else

     if ( tamArquivo(nArquivo) > 25000000 ) then
        ajustaDimensaoBitmap(nArquivo);

     begin
        Image1.Picture.LoadFromFile( nArquivo );
        if (delTemp = true )then
           deleteFile(nArquivo);
     end;
  end;
  fmMain.msgStatus('');  
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
   if (edCodigo.Visible = true) then
      edCodigo.SetFocus();
end;

procedure TfmCadastro.btAlterarClick(Sender: TObject);
begin
   chamaAlteracaoProduto(true);
end;

procedure TfmCadastro.CheckBox1Click(Sender: TObject);
begin
   Image1.Stretch := CheckBox1.Checked ;
end;

procedure TfmCadastro.btExcluirClick(Sender: TObject);
begin
   if (lbIs_ref.Caption <> '') then
      if (msgTela('', 'Deseja excluir a imagem ?', MB_ICONQUESTION + MB_YESNO) = mrYes ) then
      begin
         funcSQl.execSQL('Delete from zcf_crefe_imagens where is_ref = ' + lbIs_ref.Caption, fmMain.Conexao );
         LimparCampos();
         msgTela('', 'Imagem Exclu�da.',MB_OK + MB_ICONEXCLAMATION);
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
// pega o codigo do produto no nome do arquivo e tenta incluir.
   nArquivos := 0;
   for i:=0 to lbArquivos.Items.Count -1 do
      if (pos('.JPG', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) or (pos('.BMP', UPPERCASE(lbArquivos.Items.Strings[i]) ) > 0) then
      begin
          fmMain.msgStatus('Processando ' + intToStr(i+1) +' de '+ intToStr( lbArquivos.Items.Count) );
          nArquivos := nArquivos+1;
          nArquivo := ExtractFileName(lbArquivos.Items.Strings[i]);
          delete(nArquivo, length(nArquivo)-3,04);
          edCodigo.Text := funcoes.SohNumeros(nArquivo);

          btConsultarClick(nil);

          if (Image1.Picture.Width <= 1 ) and (edDescricao.Text <> '') then
          begin
             fmMain.msgStatus(edCodigo.Text + ' ' + edDescricao.Text + #13+ 'Imagem n�o cadastrada, incluir');
             carregaimagem( lbArquivos.Items.Strings[i]  );
             incluirImgagem(false);
          end
          else
          begin
             fmMain.msgStatus(edCodigo.Text + ' ' + edDescricao.Text + #13+ 'Imagem j� cadastrada, alterar' );
             carregaimagem( lbArquivos.Items.Strings[i] );
             chamaAlteracaoProduto(false);
          end;
     end;
     if nArquivos > 0 then
       MsgTela('','Processo concluido',0 + MB_ICONWARNING )
     else
       MsgTela('','N�o encontrei nenhum arquivo para processar.',0 + MB_ICONWARNING );
   FlatButton1Click(nil);
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
   pnBotoes.Visible :=true;
   edCodigo.Visible := true;
   edDescricao.Visible := true;
end;

procedure TfmCadastro.FlatButton3Click(Sender: TObject);
begin
   LimparCampos();
   pnBotoes.Visible := false;
   edCodigo.Visible := false;
   edDescricao.Visible := false;
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
   lbTotalArquivos.Caption := 'Arq bmp/jpg: ' + intToStr(j);
end;

procedure TfmCadastro.cadastraProduto(is_ref: String);
var
   tb:TADOTable;
   cmd:String;
begin
   funcSQl.getTable(fmMain.Conexao, tb, 'is_ref int, imagem image');
   tb.Open();
   tb.Append();
   tb.fieldByName('is_ref').AsString := is_ref;
   tb.fieldByName('imagem').Assign( Image1.Picture );
   tb.Post();
   tb.Close();
   cmd := 'insert zcf_crefe_imagens select is_ref, imagem from ' + tb.TableName;
   fmMain.execSQL(cmd);
   tb.Free();
end;

procedure TfmCadastro.incluirImgagem(mostraMsg: Boolean);
var
  is_ref:String;
  erro: String;
begin
   screen.Cursor := crHourglass;
   erro := '';
   is_ref := lbIs_ref.Caption;

   if  (edCodigo.Text = '') then
      erro := erro+' - Informe um c�digo.'+#13;

   if (is_ref = '') then
      erro := erro+' - Esse produto n�o � cadastrado.'+#13
   else
      if (edCodigo.Text <> '') then
         if ( funcSql.openSQL('Select is_ref from zcf_crefe_imagens where is_ref = ' + is_ref, 'is_ref', fmMain.Conexao ) <> '' )then
           erro := erro+' - Esse c�digo j� tem uma imagem cadastrada.'+#13;

   if (Image1.Picture = nil) then
      erro := erro+' - Selecione uma imagem.'+#13;

   if erro <> '' then
      msgTela('', erro,  MB_ICONERROR +  mb_ok)
   else
   begin
     cadastraProduto(is_ref);
     if (mostraMsg = true) then
        msgTela('', 'Inclus�o efetuada.',MB_OK + MB_ICONEXCLAMATION);
     LimparCampos();
   end;
   screen.Cursor := crdefault;
end;

procedure TfmCadastro.btIncluirClick(Sender:TObject);
begin
   incluirImgagem(true);
end;


procedure TfmCadastro.chamaAlteracaoProduto(mostraMsg: boolean);
var
  altera:boolean;
begin
   altera := true;

   if (mostraMsg = true) then
      if( MsgTela('','Deseja alterar a imagem desse produto? ', MB_YESNO + MB_ICONQUESTION) = mrNo ) then
         altera := false;

   if (altera = true) then
      if (lbIs_ref.Caption <> '') then
      begin
         funcSQl.execSQL('Delete from zcf_crefe_imagens where is_ref = ' + lbIs_ref.Caption, fmMain.Conexao );
         incluirImgagem(false);
         LimparCampos();

         if (mostraMsg = true) then
            msgTela('', 'Altera��o efetuada.',MB_OK + MB_ICONEXCLAMATION);
      end;

end;

end.
