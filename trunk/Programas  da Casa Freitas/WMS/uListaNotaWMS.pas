unit uListaNotaWMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, ExtCtrls, TFlatButtonUnit, DB,
  StdCtrls, Buttons, fCtrls, ADODB;

type
  TfmRecebeNota = class(TForm)
    Panel1: TPanel;
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    btOk: TfsBitBtn;
    btCancel: TfsBitBtn;
    qrNotas: TADOQuery;
    fsBitBtn2: TfsBitBtn;
    procedure listaNotasAReceber();
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure recebeItensNaDoca(sr_docf, nr_docf, str_pessoa:String);
    procedure SoftDBGrid1CellClick(Column: TColumn);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRecebeNota: TfmRecebeNota;

implementation

{$R *.dfm}
uses uMain, uCF, funcoes, funcSQL;

procedure TfmRecebeNota.SoftDBGrid1CellClick(Column: TColumn);
var
   i:integer;
begin
   for i := 0 to softdbGrid1.Columns.Count -1 do
     funcoes.gravalog( intToStr( softdbGrid1.Columns[i].width) );

end;

procedure TfmRecebeNota.FlatButton1Click(Sender: TObject);
begin
   if (qrNotas.IsEmpty = false) then
      ModalResult := mrOk;
end;

procedure TfmRecebeNota.btCancelClick(Sender: TObject);
begin
   modalResult := mrCancel;
end;


procedure TfmRecebeNota.listaNotasAReceber();
var
   cmd: String;
begin
   if (qrNotas <> nil) then
      qrNotas.Close();

   cmd := ' Select dtm_dataEntrada_nfe as [Data Ent], str_serie_nfe, ' +
          ' int_numero_nfe,' +
          ' rtrim(str_serie_nfe)+''/''+cast(int_numero_nfe as varchar(06))as [Nota], '+
          'str_razaosocial_pessoa as [Emissor], str_id_pessoa from wmsDocEntrada ' +
          'where (str_flagexp = ''SIM'') or (str_flagexp is null )';

   funcSQL.getQuery(fmMain.Conexao, qrNotas, cmd);
   SoftDBGrid1.Columns[ qrNotas.FieldByName('str_id_pessoa').Index ].Visible := false;
   SoftDBGrid1.Columns[ qrNotas.FieldByName('int_numero_nfe').Index ].Visible := false;
   SoftDBGrid1.Columns[ qrNotas.FieldByName('str_serie_nfe').Index ].Visible := false;

   if ( funcoes.ExisteParametro('-wms') = true) then
   begin
      SoftDBGrid1.Columns[ qrNotas.FieldByName('data Ent').Index ].Width := 65;
      SoftDBGrid1.Columns[ qrNotas.FieldByName('nota').Index ].Width := 50;
      SoftDBGrid1.Columns[ qrNotas.FieldByName('Emissor').Index ].Width := 70;
   end;
end;

procedure TfmRecebeNota.btOkClick(Sender: TObject);
begin
   listaNotasAReceber();
end;

procedure TfmRecebeNota.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
   action := caFree;
end;

procedure TfmRecebeNota.recebeItensNaDoca(sr_docf, nr_docf, str_pessoa: String);
var
   cmd:String;
begin
   cmd :=
   ' insert zcfWmsDoca' +
   ' select I.int_numero_nfe, I.str_serie_nfe, I.str_id_pessoa,' +
   ' e.STR_RAZAOSOCIAL_PESSOA, crefe.is_ref, I.flt_qtdepedido_itnfe, 0'+
   ' from '  +   ' wmsDocEntradaitem I (NOLOCK)'+   ' inner join crefe (NOLOCK) on crefe.cd_ref = i.str_id_sku '+   ' inner join wmsDocEntrada E (NOLOCK) on E.str_serie_nfe= i.str_serie_nfe ' +   ' and  I.str_id_pessoa = E.str_id_pessoa and E.int_numero_nfe = i.int_numero_nfe '+   ' where '+
   ' I.int_numero_nfe= '+ nr_docf +
   ' and I.str_serie_nfe= ' + QuotedStr(sr_docf) + ' and ' +
   ' I.str_id_pessoa= ' + str_pessoa;

   funcSQL.execSQL(cmd, fmMain.conexao);

   cmd := ' update wmsDocEntrada ' +
          ' set str_flagExp = ''SIM'' ' +
          ' where '+
          ' int_numero_nfe= '+ nr_docf +
          ' and str_serie_nfe= ' + QuotedStr(sr_docf) + ' and ' +
          ' str_id_pessoa= ' + str_pessoa;
//   funcSQL.execSQL(cmd, fmMain.conexao);

   funcoes.msgTela('','Nota liberada na doca', MB_ICONEXCLAMATION + mb_ok);
   listaNotasAReceber();
end;

end.
