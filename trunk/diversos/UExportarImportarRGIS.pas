unit UExportarImportarRGIS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, TFlatButtonUnit, ComCtrls,funcoes, StdCtrls,
  adLabelEdit,ShellAPI;

type
  TForm1 = class(TForm)
    FlatButton1: TFlatButton;
    Connection: TADOConnection;
    Query: TADOQuery;
    SB: TStatusBar;
    FlatButton2: TFlatButton;
    EdNumeroLoja: TadLabelEdit;
    b3: TFlatButton;
    FlatButton3: TFlatButton;
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    Procedure ReceberArquivoRGIS(sender:Tobject;arquivo:string);
    procedure FormCreate(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FlatButton1Click(Sender: TObject);
var
  arq:TstringList;
  i:integer;
begin
   i:=0;
   screen.Cursor := crHourGlass;
   sb.SimpleText := 'Obtendo a relação dos produtos...';
   form1.Refresh;

   query.SQL.Clear;
   query.SQL.Add(' select cd_pesq, cd_ref, ds_ref, 1 as preco from dscbr inner join crefe on dscbr.is_ref = crefe.is_ref and dscbr.tp_Cdpesq = 1 '+
                 ' union ' +
                 ' Select ' + quotedstr('0')+ ' as cd_pesq, cd_ref, ds_ref, 1as preco from crefe where dbo.Z_CF_obterEAn( crefe.is_ref ) is null ');
   Query.Open;
{
   select cd_pesq as cd_pesq, cd_ref, ds_ref, 1 as preco from dscbr inner join crefe on dscbr.is_ref = crefe.is_ref and dscbr.tp_Cdpesq = 1 order by cd_pesq' );
   Query.Open;

 }
   arq:= TStringList.Create();
   query.First;
   while query.Eof = false do
   begin
      inc(i);
      arq.Add(
                funcoes.preencheCampo(13,'0','e', funcoes.SohNumeros( query.fieldByName('cd_pesq').AsString ) ) +' '+
                funcoes.preencheCampo(09,'0','e', funcoes.SohNumeros( query.fieldByName('cd_ref').AsString )  ) +' '+
                funcoes.preencheCampo(50,' ','D', query.fieldByName('ds_ref').AsString ) +' '+
                funcoes.preencheCampo(08,'0','e', query.fieldByName('preco').AsString )
             );
      if i mod 100 = 0 then
         sb.SimpleText := 'Montando o arquivo...   ' + IntToStr(i) + ' de ' +  inttoStr(query.RecordCount) +  '  Eans ';
      query.next;
   end;
   arq.SaveToFile('c:\invent.txt');
   ShellExecute(0,nil,'WinRar.exe','a c:\Invent.zip C:\invent.txt' ,nil,sw_show);

   sb.SimpleText := 'Terminei !!!   ';
   form1.Refresh;

   screen.Cursor := crDefault;
end;


procedure TForm1.ReceberArquivoRGIS(sender: Tobject; arquivo:string);
var
  ent,sai:Tstringlist;
  i:integer;
begin
   ent := Tstringlist.Create();
   ent.LoadFromFile(Arquivo);

   Sai := Tstringlist.Create();

   for i:=0 to Ent.Count -1 do
      sai.Add(
                funcoes.preencheCampo(04,'0','e', EdNumeroLoja.text)   +
                funcoes.preencheCampo(13,' ','d', Copy(ent[i],28,07) ) +
                Copy(ent[i],44,05)
             );
   sai.SaveToFile('Contagem_RGIS_Loja_'+ funcoes.preencheCampo(04,'0','e',EdNumeroLoja.text) + '.txt');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    b3.Hint := 'Gerar para o coletor '+ #13+ ' no formato EAN + "S"';
    FlatButton2.Hint:= 'Recebe o arquivo da RGIS e salva no formato well' + #13+ 'com o nome  Contagem_RGIS_Loja_ + o numero da loja';

  
   connection.Connected := false;
   connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   connection.Connected := true;
end;

procedure TForm1.b3Click(Sender: TObject);
var
   arq:TstringList;
   i:integer;
begin
   i:=0;
   screen.Cursor := crHourGlass;
   sb.SimpleText := 'Obtendo a relação dos produtos...';
   form1.Refresh;

   query.SQL.Clear;
   query.SQL.Add(' Select cd_pesq, ''S'' as S from dscbr where tp_cdpesq = ''1'' order by cd_pesq ');
   Query.Open;

   arq:= TStringList.Create();
   query.First;
   while query.Eof = false do
   begin
      inc(i);
      arq.Add(
                funcoes.preencheCampo(13,'0','e', funcoes.SohNumeros( query.fieldByName('cd_pesq').AsString ) ) +
                query.fieldByName('S').AsString
             );
      if i mod 100 = 0 then
         sb.SimpleText := 'Montando o arquivo...   ' + IntToStr(i) + ' de ' +  inttoStr(query.RecordCount) +  '  Eans ';

      query.next;
   end;
   arq.SaveToFile('c:\CadastroCodigosDeBarras.TXT');
   screen.Cursor := crDefault;
   sb.SimpleText := 'Exportado ' + inttoStr(query.RecordCount) +  '  Eans para c:\CadastroCodigosDeBarras.TXT' ;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
var
   qr:TADOQuery;
begin
   sb.SimpleText := 'Exportando zcontloja';
   qr := TADOQuery.Create(nil);
   qr.Connection := Connection;
   qr.sql.clear;
   qr.SQL.Add('Select * from zcontloja where loja = ' + quotedstr( EdNumeroLoja.Text));
   qr.Open;

   qr.First;
   while qr.Eof = false do
   begin
     funcoes.GravaLinhaEmUmArquivo('C:\Comum\Contagens brinquedos\Contagem_loja_'+EdNumeroLoja.Text+ '.txt',
                                   qr.fieldByName('loja').AsString +
                                   qr.fieldByName('cd_ref').AsString +'  '+
                                   funcoes.preencheCampo(05,'0','e', qr.fieldByName('qt').AsString )
                                  );
     qr.Next;
   end;
   sb.SimpleText := 'Exportação concluida';
end;
procedure TForm1.FlatButton2Click(Sender: TObject);
var
   Open:TOpendialog;
begin
   Open := TOpenDialog.Create(open);
   Open.Title := 'Informe o arquivo OutPut da RGIS';
   Open.title := 'Definir o arquivo RGIS';
   Open.filter := 'Arquivos de Texto|*.txt';
   Open.initialDir := 'c:\';

   if (Open.Execute ) then
      ReceberArquivoRGIS(sender,Open.FileName);
end;


end.
