unit uResumoEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid, DB, ADODB, funcsql,
  TFlatButtonUnit,funcoes;

type
  TfmResEstoque = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Panel1: TPanel;
    lbCod: TLabel;
    lbDesc: TLabel;
    QrEstoque: TADOQuery;
    DataSource1: TDataSource;
    chsoPositivo: TCheckBox;
    Label1: TLabel;
    lbTotal: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Obterestoques(Sender:tobject;is_ref,EhDisponivel:string);
    procedure Obtertotal(Sender:Tobject);
    procedure chsoPositivoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResEstoque: TfmResEstoque;

implementation
uses umain;
{$R *.dfm}

procedure TfmResEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action:= caFree;
   fmResEstoque := nil;
end;

procedure TfmResEstoque.ObterEstoques(Sender: tobject; is_ref, EhDisponivel:string);
var
   lst:Tstrings;
begin
   lst := funcsql.GetValoresSQL(lst, ' Select cd_ref, ds_ref from crefe (nolock) where is_ref = ' + is_ref, fmMain.Conexao);

   lbCod.Caption := lst[0];
   lbDesc.Caption := lst[1];

   qrestoque.SQL.Clear;
   qrestoque.SQL.Add('Exec Z_CF_ObterEstoqueProdutoNasFiliais ' + quotedStr(is_ref ) + ', '+
                      quotedStr(ehDisponivel)
                     );
   qrEstoque.open;
end;

procedure TfmResEstoque.Obtertotal(Sender: Tobject);
var
  total:real;
begin
   total := 0;
   QrEstoque.First;
   while QrEstoque.Eof = false do
   begin
      if chsoPositivo.Checked = true then
      begin
         if qrEstoque.fieldByName('Estoque').asfloat > 0 then
            total := Total + qrEstoque.fieldByName('Estoque').asfloat;
      end
      else
         total := Total + qrEstoque.fieldByName('Estoque').asfloat;
         qrEstoque.Next;
   end;
   lbtotal.caption := floatToStr(Total);
   QrEstoque.First;
end;

procedure TfmResEstoque.chsoPositivoClick(Sender: TObject);
begin
   Obtertotal(nil);
end;

end.
