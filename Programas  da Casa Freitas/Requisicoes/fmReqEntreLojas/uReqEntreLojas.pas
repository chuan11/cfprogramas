unit uReqEntreLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, Buttons, fCtrls,funcoes,funcsql,
  adLabelEdit, adLabelComboBox, Mask, adLabelMaskEdit, TFlatButtonUnit,
  mxOneInstance, ExtCtrls;

type
  TfmReqLojas = class(TForm)
    DataSource1: TDataSource;
    Table: TADOTable;
    dbGrid: TSoftDBGrid;
    fsGroupBox1: TfsGroupBox;
    edCodigo: TadLabelEdit;
    edDescricao: TadLabelEdit;
    edSaldo: TadLabelEdit;
    fsLabel3: TfsLabel;
    cbOrigem: TadLabelComboBox;
    edQuant: TadLabelMaskEdit;
    btImprime: TFlatButton;
    FlatButton1: TFlatButton;
    Panel1: TPanel;
    edObs: TadLabelEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbOrigemChange(Sender: TObject);
    procedure edDescricaoEnter(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BuscarDadosProduto(Sender:TObject);
    procedure iniciarRequisicao(Sender: TObject);
    procedure edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function MontarRelatorioImpressao(Sender:tobject;EhImpressao:boolean):String;
    procedure btImprimeClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure LimparEdits(Sender:Tobject);
    procedure dbGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReqLojas: TfmReqLojas;
  FinalizarPrograma:Boolean;
implementation
uses umain, uEmail;

{$R *.dfm}

procedure TfmReqLojas.iniciarRequisicao(Sender: TObject);
var
  nTable:string;
begin
   Table.Close;
   ntable := '#'+funcoes.SohNumeros(TimeToStr(now));
   funcSQL.GetValorWell('E','create table '+ nTable  + ' ( cod varchar(08), descricao varchar(50), quant int )', '',fmMain.Conexao);
   Table.TableName := nTable;
   Table.Open;
   dbGrid.Columns[0].Title.caption := 'Codigo';
   dbGrid.Columns[1].Title.caption := 'Descricao';
   dbGrid.Columns[2].Title.caption := 'Quantidade';
   dbGrid.Columns[0].Title.Font.Style := [fsbold];
   dbGrid.Columns[1].Title.Font.Style := [fsbold];
   dbGrid.Columns[2].Title.Font.Style := [fsbold];
   edCodigo.Enabled := true;
   edQuant.Enabled := true;
   edcodigo.SetFocus;
end;

procedure TfmReqLojas.FormCreate(Sender: TObject);
begin
   fmMain.getListaLojas( cbOrigem, true, false, '' );
end;

procedure TfmReqLojas.edDescricaoEnter(Sender: TObject);
begin
   if edCodigo.Enabled = true then
      edCodigo.SetFocus;
end;


procedure TfmReqLojas.BuscarDadosProduto(Sender: TObject);
var
  Cmd:string;
  Query:TADOQuery;
begin
   cmd := '';
   cmd := 'exec Z_CF_GetInformacoesProduto ' +
           QuotedStr( FUNCOES.SohNumeros(EdCodigo.text))  +' , '+
           funcoes.SohNumeros((copy(cbOrigem.Items[cbOrigem.ItemIndex],40,100))) +' , '+
           '-1 ';
   Query := TAdoQUery.Create(query);
   Query.Connection := fmMain.Conexao;
   Query.SQL.clear;
   query.SQL.add(cmd);
   Query.Open;

   if query.IsEmpty = false then
   begin
      edDescricao.text := query.fieldByName('descricao').AsString;
      edSaldo.Text := query.fieldByName('EstoqueDisponivel').AsString;
      edQuant.SetFocus;
   end
   else
   begin
      funcoes.MsgTela('', ' Produto não cadastrado' +#13, mb_OK + mb_IconError  );
      edQuant.SetFocus;
      edCodigo.SetFocus;
   end;
end;

procedure TfmReqLojas.cbOrigemChange(Sender: TObject);
begin
   if (cbOrigem.itemindex > -1) then
      iniciarRequisicao(sender);
end;


procedure TfmReqLojas.edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_return) and (funcoes.SohNumeros(edQuant.Text) <> '' ) then
   begin
      table.AppendRecord([edCodigo.Text, edDescricao.Text, funcoes.SohNumeros(edQuant.Text)]);
      LimparEdits(Sender);      
   end;
end;

procedure TfmReqLojas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if table.IsEmpty = false then
     if msgtela('',' Abandona a requisição  ', mb_yesNo + mb_Iconquestion) = mrYes then
        Canclose := true
      else
        Canclose :=false;
end;

function TfmReqLojas.MontarRelatorioImpressao(Sender:tobject;EhImpressao:boolean):String;
var
   dest:TstringList;
   nArquivo,linha:string;
   i,l,Fl:integer;
begin
   screen.Cursor := crHourGlass;
   nArquivo :=  funcoes.TempDir() +  'Req_' + trim( copy(cbOrigem.Items[cbOrigem.itemIndex],01,30) ) +' '+
               copy(dateToStr(now),01,02) +'-'+ copy(dateToStr(now),04,02) +'-'+ copy(dateToStr(now),07,04)+ '_'+
               copy(dateTimeToStr(now),12,02) +'-'+ copy(dateTimeToStr(now),15,02) +
               '.rtf' ;

   dest:=  TStringList.create();
   Fl := 0; l := 0;

   table.First;
   while table.Eof = false do
   begin
      inc(fl);
      Dest.Add('');
      Dest.Add('');
      Dest.Add('                          *** REQUISICAO DE PRODUTOS  ***                                     FL:' + funcoes.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('');
      Dest.Add('Data: ' + DateTimeToStr(now)  );
      Dest.Add('Loja Requisitada: ' + copy(cbOrigem.Items[cbOrigem.itemindex],01,30) ) ;
      Dest.Add('Loja Requisitante : ' + FmMain.StatusBar1.Panels[0].Text ) ;
      Dest.Add('');
      Dest.Add('------------------------------------------------------------------------------');
      Dest.Add('CODIGO    DESCRICAO                                                QUANTIDADE ');
      Dest.Add('------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < 15 ) and ( table.eof = false ) do
      begin
         inc(l);
         linha :=
            funcoes.preencheCampo(10,' ', 'd', table.fieldByname('cod').Asstring) +
            funcoes.preencheCampo(60,' ', 'd', copy(table.fieldByname('descricao').Asstring,01,45 )) +
            funcoes.preencheCampo(04,'0', 'e', table.fieldByname('quant').Asstring);
         dest.Add(linha);
         table.next;
      end;
      if ( table.eof = false ) then
      begin
         Dest.Add('Observação: ' + edObs.Text);
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         for i:=0 to 8 do
         begin
            inc(l);
            Dest.Add('');
         end;
         Dest.Add('                           -----------------------------------  ');
         Dest.Add('                                         Visto                  ');

         while ( l < 40 ) do
         begin
            Dest.Add('');
            inc(l);
        end;
      end;
   end;
   Dest.SaveToFile( nArquivo);
   table.First;
   screen.Cursor := crDefault;

 {     if EhImpressao = true then
          funcoes.imprimeArquivo( fmReqLojas,ExtractFilePath(ParamStr(0)) + nArquivo, false, 09, 'Requisicao de Mercadorias', 1);
}
   result := nArquivo;
end;

procedure TfmReqLojas.FlatButton1Click(Sender: TObject);
begin
   if table.IsEmpty = false then
   begin
      cbOrigem.ItemIndex := -1;
      table.Close;
      IniciarRequisicao(Sender);
      LimparEdits(Sender);
   end;
end;

procedure TfmReqLojas.LimparEdits(Sender: Tobject);
begin
   edCodigo.Text := '';
   edQuant.Text := '';
   edDescricao.Text := '';
   edSaldo.Text := '';
   edCodigo.setfocus;
end;

procedure TfmReqLojas.dbGridDblClick(Sender: TObject);
begin
   table.Delete();
end;

procedure TfmReqLojas.edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      BuscarDadosProduto(Sender);
end;

procedure TfmReqLojas.btImprimeClick(Sender: TObject);
var
   corpoMsg:Tstringlist;
   arq:string;
begin
   arq := MontarRelatorioImpressao(Sender,false );
   corpoMsg := TStringList.Create();
   corpoMsg.LoadFromFile( arq );
   corpoMsg.Add('Gerada por: ' + fmMain.StatusBar1.Panels[1].text);
   corpoMsg.Add('A partir da loja: ' + fmMain.StatusBar1.Panels[0].text);

// enviar email para a loja requisitada
   fmMain.EnviarEmail( funcsql.getEmail(funcoes.getNumUO(cbOrigem),fmMain.Conexao) ,  ' Requisicao de mercadorias da loja '+ fmMain.StatusBar1.Panels[0].Text,'',corpoMsg, 'Enviando email para a loja requisitada...');
   corpoMsg.Add('');

// email para a loja que ta pedindo
   fmMain.EnviarEmail(  funcsql.getEmail(fmMain.getUoLogada(), fmMain.Conexao),  'Copia da Requisicao de mercadorias da loja '+ fmMain.StatusBar1.Panels[0].Text,'',corpoMsg, 'Copia da requisição para a loja que pediu...');
   FlatButton1Click(nil);
end;

procedure TfmReqLojas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmReqLojas := nil;
end;

end.


