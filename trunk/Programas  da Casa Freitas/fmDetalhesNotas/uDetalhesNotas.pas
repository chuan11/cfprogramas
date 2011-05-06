unit uDetalhesNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid, funcoes, funcsql,
  DB, ADODB;

type
  TfmDetalhesNota = class(TForm)
    grid: TSoftDBGrid;
    Panel1: TPanel;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    GroupBox1: TGroupBox;
    lbDestEmit: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbNota: TLabel;
    lbEmitente: TLabel;
    lbOperacao: TLabel;
    Label4: TLabel;
    lbEmissao: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbEntSai: TLabel;
    Label1: TLabel;
    lbCFO: TLabel;
    Label8: TLabel;
    lbValor: TLabel;
    qr: TADOQuery;
    DataSource1: TDataSource;
    Label9: TLabel;
    lbDEspExtra: TLabel;
    procedure carregarDadosNota(Sender: Tobject; is_nota: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridColExit(Sender: TObject);
    procedure gridTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetalhesNota: TfmDetalhesNota;

implementation

uses uMain;

{$R *.dfm}

{ TForm1 }

procedure TfmDetalhesNota.carregarDadosNota(Sender: Tobject; is_nota : String);
var
   lst2,lst:Tstrings;
   cmd:String;
begin
   lst := TStringList.Create();
// passar o is_nota da nota para consultar os dados da nota pela consulta do well

   cmd := ' select  dnota.is_estoque, dnota.nr_docf, dnota.sr_docf, topi.fl_entrada, VL_DSPEXTRA ' +
          ' from dnota(NOLOCK) ' +
          ' inner join toper (nolock) on dnota.is_oper = toper.is_oper ' +
          ' inner join topi (nolock) on toper.sq_opf = topi.sq_opf ' +
          ' where dnota.is_nota = ' + is_nota ;

   lst :=  funcsql.GetValoresSQL2(cmd, fmMain.conexao);

   cmd := ' exec StoListarNotasFiscais @FL_ENTRADA = ' + lst[3] + ' , ' +
          ' @DT_INI = ''2000-01-01'', @DT_FIM = ''2099-12-31'''    + ' , ' +
          ' @CD_LOJA = ' + lst[0]                                      + ' , ' +
          ' @NR_DOCF = ' + lst[1]                                 + ' , ' +
     		  ' @SR_DOCF = ' + quotedstr(lst[2]);

   lst2 :=  funcsql.GetValoresSQL2(cmd, fmMain.conexao);

// campos do cabeçalho
   if lst2[16] = '1' then
      lbDestEmit.Caption := 'Destinatário:'
   else
      lbDestEmit.Caption := 'Emitente:';

   lbNota.Caption := lst2[7]+'-'+lst2[6];
   lbEmitente.Caption := lst2[4];
   lbOperacao.Caption := lst2[0];
   lbEntSai.Caption := lst2[11];
   lbEmissao.Caption := lst2[22];
   lbCFO.Caption := lst2[13];
   lbValor.caption := funcoes.ValorSql(lst2[5]);
   lbDEspExtra.Caption := funcoes.ValorSql(lst[4]);

   cmd := ' Select crefe.is_ref, crefe.cd_ref, crefe.ds_ref, dmovi.qt_mov,' +
          ' dmovi.PrecoUnitarioLiquido, (dmovi.qt_mov * dmovi.PrecoUnitarioLiquido) as total_Item ' +
          ' from dmovi (nolock) inner join crefe (nolock) on dmovi.is_ref = crefe.is_ref '+
          ' where dmovi.is_nota =  ' + is_nota + ' order by  dmovi.nr_item ';

   qr.SQL.Clear;
   qr.sqL.add(cmd);

   QR.Connection := fmMain.Conexao;
   QR.Open;

   grid.Columns[0].Visible := false;
   grid.Columns[1].Width := 50;
   grid.Columns[1].Title.caption := 'Codigo';
   grid.Columns[2].Width := 340;
   grid.Columns[2].Title.caption := 'Descrição';
   grid.Columns[3].Width := 50;
   grid.Columns[3].Title.caption := 'quant';
   grid.Columns[4].Width := 50;
   grid.Columns[4].Title.caption := 'Pc Und';
   grid.Columns[5].Width := 50;
   grid.Columns[5].Title.caption := 'Total item';
end;

procedure TfmDetalhesNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmDetalhesNota := nil;
   action := caFree;
end;

procedure TfmDetalhesNota.gridColExit(Sender: TObject);
var
   i:integer;
begin
   deleteFile('c:\teste.txt');
   for i:=0 to grid.Columns.Count-1 do
      funcoes.GravaLinhaEmUmArquivo('c:\teste.txt', inttostr(grid.Columns[i].width))


end;

procedure TfmDetalhesNota.gridTitleClick(Column: TColumn);
begin
  funcSQL.OrganizarQuery(qr, Column);
end;

end.
