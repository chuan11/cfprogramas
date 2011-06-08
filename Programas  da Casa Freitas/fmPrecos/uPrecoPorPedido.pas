unit uPrecoPorPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Grids, Buttons,Clipbrd, funcSQL,
  adLabelNumericEdit, mxExport, DB, ADODB, TFlatButtonUnit, DBGrids,
  SoftDBGrid, fCtrls;

type
  TfmPcporPedido = class(TForm)
    Edit1: TadLabelEdit;
    edit2: TadLabelNumericEdit;
    edit4: TadLabelNumericEdit;
    edit3: TadLabelNumericEdit;
    edIPI: TadLabelNumericEdit;
    FlatButton1: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    Edit5: TadLabelNumericEdit;
    tbPedido: TADOTable;
    DataSource1: TDataSource;
    gdPedido: TSoftDBGrid;
    CheckBox1: TfsCheckBox;
    FlatButton2: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimpaTabela(Sender:Tobject);
    procedure FlatButton4Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPcporPedido: TfmPcporPedido;

implementation

uses Uprecoswell, uMain, uCF, funcoes;

{$R *.dfm}
function FloatSqlToStr(str:string):string;
begin
   if pos(',',str) = 0 then str := str +',00';
   if pos(',',str) = length(str)-1 then str:= str + '0';
   if pos(',',str) = 0 then str:= str + ',00';
   FloatSqlToStr := str;

end;
procedure TfmPcporPedido.FormCreate(Sender: TObject);
var
  nmTabela:String;
  i:smallint;
begin
   screen.Cursor := crHourglass;

   nmTabela := '#Pedido'+ funcoes.SohNumeros(timeToStr(now));
   funcSQL.GetValorWell( 'E',
                        'Create Table ' + nmTabela + ' ( is_ref int, CODIGO varchar(08), DESCRICAO varchar(30), QUANT int, [PRECO UND] money, IPI int ) ',
                        '@@error', fmMain.Conexao);

   tbPedido.TableName := nmTabela;
   tbPedido.Active := true;

   gdPedido.Columns[0].Visible := false;
   gdPedido.Columns[1].Width := 50;
   gdPedido.Columns[2].Width := 200;
   gdPedido.Columns[3].Width := 50;
   gdPedido.Columns[4].Width := 80;
   gdPedido.Columns[5].Width := 50;


   for i:=0 to tbPedido.FieldCount -1 do
     gdPedido.Columns[i].Title.Font.Style := [fsBold];

   screen.Cursor := crDefault;
end;

procedure TfmPcporPedido.FlatButton3Click(Sender: TObject);
var
  ds:TDataSet;
begin
   ds := uCF.getDadosPedidoDeCompra(fmMain.Conexao, edit1.text);

   LimpaTabela(sender);
   while ds.Eof = false do
   begin
      tbPedido.AppendRecord([
                            ds.FieldByName('is_ref').AsString,
                            ds.FieldByName('CODIGO').AsString,
                            ds.FieldByName('DESCRICAO').AsString,
                            ds.FieldByName('QUANT').AsString,
                            FloatToStr(ds.FieldByName('UND').AsFloat) ,
                            ds.FieldByName('IPI').AsString
                           ]);
      ds.Next;
   end;
   ds.Free();
end;

procedure TfmPcporPedido.FlatButton1Click(Sender: TObject);
var
  i:integer;
  VlVenda,desconto,ipi,frete,margem01,margem02:real;
  arq:TstringList;
begin
   arq := tStringList.Create();

   tbPedido.First;
   while tbPedido.Eof = false do
   begin
      desconto :=  ( StrtoFloat(edit2.text)   * ( tbPedido.fieldByName('PRECO UND').asFloat ) / 100  );
      frete :=    ( ( StrtoFloat(edit3.text)  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  );
      ipi := ( ( tbPedido.FieldByName('IPI').asFloat )  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  ;

      margem01 :=   ( ( StrtoFloat(edit4.text)  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  );

      if StrtoFloat(edit5.text) <> 0 then
         margem02 :=   (  ( StrtoFloat(edit5.text) * margem01 ) - desconto )  / 100  ;

      VlVenda := ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) + frete + ipi + margem01 + margem02  ;

      FloatToStrF(vlvenda,ffFixed,18,02);

      arq.add( IntToStr(i+1)+ '- '+ tbPedido.fieldByName('codigo').AsString+' '+tbPedido.fieldByName('descricao').AsString );
      arq.add( '     PC Ped: ' + FloatToStrF( tbPedido.fieldByName('PRECO UND').asFloat ,ffFixed,18,02)  );
      arq.add( '     Desc: '+floatToStr(desconto) );
      arq.add( '     Frete: '+ floatToStr(frete) );
      arq.add( '     Margem01: '+ floatToStr(margem01) );
      arq.add( '     Margem02: '+ floatToStr(margem02) );
      arq.add( '     IPI: '+floatToStr(ipi)  );
      arq.add( '     PC Gerado: '+FloatToStrF(vlvenda,ffFixed,18,02));
      arq.add( '');

      fmLancaPrecos.Table.AppendRecord([
                                tbPedido.fieldByName('codigo').AsString,
                                tbPedido.fieldByName('DESCRICAO').AsString,
                                funcSQL.GetValorWell('O','Select dbo.funObterPrecoProduto('+ fmLancaPrecos.getCodigoPreco+ ' , '+ tbPedido.FieldByname('is_ref').AsString+ ' , ' +  funcoes.getNumUO(fmLancaPrecos.cbLoja)   + ' , 0   ) as pco ', 'pco', fmMain.Conexao),
                                FloatToStrF(vlvenda,ffFixed,18,02),
                                fmLancaPrecos.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+fmLancaPrecos.edVlMrg02.TEXT, false ),
                                fmLancaPrecos.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+fmLancaPrecos.edVlMrg03.TEXT, false ),
                                tbPedido.fieldByName('is_ref').AsString,
                                tbPedido.fieldByName('PRECO UND').AsString
                               ]);
      tbPedido.Next;
   end;

   if checkBox1.Checked = true then
   begin
      arq.SaveToFile(getDirLogs()+'memDeCaculo.txt');
      Winexec(pchar('notepad.exe '+getDirLogs()+ 'memDeCaculo.txt'),sw_normal);
   end;
   fmPcporPedido.Close;
end;

procedure TfmPcporPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
end;


procedure TfmPcporPedido.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_return then
      FlatButton3Click(Sender);
end;


procedure TfmPcporPedido.LimpaTabela(Sender: Tobject);
begin
   while tbPedido.IsEmpty = false do
      tbPedido.Delete;
end;

procedure TfmPcporPedido.FlatButton4Click(Sender: TObject);
begin
   tbPedido.First;
   while tbPedido.Eof = false do
   begin
     tbPedido.Edit;
     tbPedido.FieldByName('ipi').asFloat := strToFloat(edIPI.text);
     tbPedido.Post;
     tbPedido.Next;
   end;
end;

procedure TfmPcporPedido.FlatButton2Click(Sender: TObject);
begin
   fmPcporPedido.Close;
end;






end.