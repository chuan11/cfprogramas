unit uObterSaldoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, Spin, StdCtrls, Mask, adLabelComboBox, DB,
  ADODB, Grids, DBGrids, SoftDBGrid;

type
  TfmObterSaldoFiscal = class(TForm)
    cbLoja: TadLabelComboBox;
    GroupBox2: TGroupBox;
    edMesAno: TMaskEdit;
    SpinButton1: TSpinButton;
    FlatButton1: TFlatButton;
    tb: TADOTable;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure criarTabela();
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmObterSaldoFiscal: TfmObterSaldoFiscal;

implementation

uses uMain, uCF, funcSQL, funcoes, funcDatas;

{$R *.dfm}

procedure TfmObterSaldoFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.salvaCampos(fmObterSaldoFiscal);
   fmObterSaldoFiscal := nil;
   action := caFree;
end;

procedure TfmObterSaldoFiscal.criarTabela();
var
   cmd:String;
begin
   fmMain.MsgStatus('Selecionando produtos no cadastro de produtos...');
   cmd := ' is_ref int, entradas int, saidas int, saldoFim int, custo money ';

   if (tb.TableName <> '' )then
      tb.close;

   tb.TableName := funcSQL.criaTabelaTemporaria(fmMain.conexao, cmd );

   cmd :=  'insert ' + tb.TableName +
           ' select is_ref, 0, 0, 0, 0 from crefe order by is_ref';
   funcSQL.execSQL(cmd, fmMain.Conexao);
   
   tb.Open();
end;

procedure TfmObterSaldoFiscal.SpinButton1DownClick(Sender: TObject);
begin
   edMesAno.Text:= funcDatas.ajustaDataMes(edMesAno.Text, '-');
end;

procedure TfmObterSaldoFiscal.SpinButton1UpClick(Sender: TObject);
begin
   edMesAno.Text:= funcDatas.ajustaDataMes(edMesAno.text, '+');
end;

procedure TfmObterSaldoFiscal.FormCreate(Sender: TObject);
begin
//   cbLoja.Items :=  funcSQL.getNomeLojas(fmMain.Conexao, false, false, fmMain.getCDPESUsuario(), '');
   fmMain.getParametrosForm(fmObterSaldoFiscal);

   fmMain.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado() );
end;

procedure TfmObterSaldoFiscal.FlatButton1Click(Sender: TObject);
var
   ds:TdataSet;
   uo, mes, cmd:String;

begin
   mes := funcoes.getDatePart('a',strTodate('01/'+ edMesAno.text )) + funcoes.getDatePart('m', strTodate('01/'+ edMesAno.text ) );
   uo := funcoes.getCodUO(cbLoja);

   criarTabela();
   tb.First();

   while (tb.Eof = false) do
   begin
      fmMain.MsgStatus('Obtendo saldo do produto: ' + intToStr(tb.RecNo) +' de '+ intToStr(tb.RecordCount) );
      cmd := ' Select top 01 * from zcf_saldoFiscal (nolock) where is_uo = ' +
             funcoes.getCodUO(cbLoja)  + ' and ' +
             ' is_ref= ' + tb.fieldByName('is_ref').AsString  + ' and mes  <= ' + mes  +' order by mes desc';
      ds:= funcSQL.getDataSetQ(cmd, fmMain.Conexao);

      if (ds.IsEmpty = false) then
      begin
         tb.Edit();
         tb.FieldByName('entradas').AsInteger := ds.fieldByName('entradas').asinteger;
         tb.FieldByName('saidas').AsInteger := ds.fieldByName('saidas').asinteger;
         tb.FieldByName('saldoFim').AsInteger := ds.fieldByName('saldoFim').asinteger;
         tb.FieldByName('custo').AsFloat := ds.fieldByName('custo').AsFloat;
         tb.Post();
      end;
      ds.free();
      tb.next();
      sleep(10);
   end;
   tb.Close();

   cmd :=
   ' delete from '  + tb.TableName + ' where saidas = 0 and entradas = 0 and saldoFim = 0 ';
   funcSQL.execSQL(cmd, fmMain.Conexao);

   tb.Open();
   funcsql.exportaTable(tb);
   fmMain.MsgStatus('');
end;

end.
