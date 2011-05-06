unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid, DB, ADODB,
  TFlatButtonUnit,funcoes;

type
  TForm5 = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Panel1: TPanel;
    lbCod: TLabel;
    lbDesc: TLabel;
    QrEstoque: TADOQuery;
    DataSource1: TDataSource;
    Connection: TADOConnection;
    chsoPositivo: TCheckBox;
    Label1: TLabel;
    lbTotal: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Obterestoques(Sender:tobject;is_ref,EhDisponivel:string);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Obtertotal(Sender:Tobject);
    procedure chsoPositivoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
uses unit1;
procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action:= caFree
end;

procedure TForm5.ObterEstoques(Sender: tobject; is_ref, EhDisponivel:string);
begin
   qrestoque.SQL.Clear;
   qrestoque.SQL.Add('Exec Z_CF_ObterEstoqueProdutoNasFiliais ' + quotedStr(is_ref ) + ', '+
                      quotedStr(ehDisponivel)
                     );
   qrEstoque.open;
   if qrEstoque.IsEmpty = false then
   begin
      SoftDBGrid1.Columns[0].Visible := false;
      SoftDBGrid1.Columns[1].Visible := false;
      Obtertotal(nil);
   end;
end;

procedure TForm5.FormActivate(Sender: TObject);
begin
   form5.top := 150;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
   if ParamStr(1) = application.Title then
   begin
      connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini' );
      lbCod.Caption := ParamStr(2);
      lbdesc.Caption := ParamStr(3);
      ObterEstoques( Sender,
                     Paramstr(04),
                     Paramstr(05)
                    );
   end
   else
   begin
      showmessage('Falta o parâmentro');
      application.Terminate;
   end;
end;

procedure TForm5.Obtertotal(Sender: Tobject);
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

procedure TForm5.chsoPositivoClick(Sender: TObject);
begin
   Obtertotal(nil);
end;

end.
