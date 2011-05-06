unit uEentSai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, funcsql, funcoes,ExtCtrls;

type
  TfmEntSai = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    lbDesc: TLabel;
    lbis_ref: TLabel;
    lbTotEnt: TLabel;
    Label5: TLabel;
    lbTotVenda: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbPrimEnt: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure ListarEntrada(Sender:Tobject);
    procedure ObterTotalEntradas(Sender:Tobject);
    procedure ObtertotalVendas(Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEntSai: TfmEntSai;

implementation

uses Unit1;

{$R *.dfm}

{ TfmEntSai }

{ TfmEntSai }

procedure TfmEntSai.ListarEntrada(Sender: Tobject);
var
   aux:string;
begin
   form1.qrEnt.SQL.clear();
   form1.qrEnt.SQL.Add('Exec dbo.Z_CF_stoListaQtEntradaPorItem '+ lbIs_ref.caption);
   form1.qrEnt.open;
   form1.qrEnt.Last;
   if form1.qrEnt.IsEmpty = false then
   begin
      aux := form1.qrEnt.fieldByName('data').asString;
       insert('20',aux, length(aux)-1);
       lbPrimEnt.Caption := aux;

       // calcular a soma das entradas
       ObterTotalEntradas(nil);
       //calcular a venda
       ObtertotalVendas(nil);
   end
   else
   begin
       lbPrimEnt.Caption := 'Não há...';
   end;

  shortdateformat := 'dd/MM/yy';
end;

procedure TfmEntSai.ObterTotalEntradas(Sender: Tobject);
var
  uo:string;
  total:integer;
begin
   total := 0 ;
   uo := funcsql.getCodUo(form1.cb2);
   form1.qrEnt.First;
   while form1.qrEnt.Eof = false do
   begin
      if uo = UO_CD then
         total :=  total + form1.qrEnt.FieldByName('quant').AsInteger
      else
      begin
         if form1.qrEnt.FieldByName('is_uo').AsString = uo then
            total :=  total + form1.qrEnt.FieldByName('quant').AsInteger
      end;
      if total = 0 then
         lbTotEnt.Caption := 'Sem compras (consta em outras)'
      else
         lbTotEnt.Caption :=    floattostrf(total ,ffNumber,18,0);

      form1.qrEnt.next;
   end;
end;

procedure TfmEntSai.ObtertotalVendas(Sender: Tobject);
begin
   shortdateformat := 'dd/MM/yyyy';
   form1.CalculaVendaNoPeriodo(  nil,
                                 funcSQl.getCodUo(form1.cb2) ,
                                 lbis_ref.Caption,
                                 lbPrimEnt.Caption,
                                 dateToStr( now),
                                 '',
                                 ''
     );

    lbTotVenda.Caption :=   floattostrf( form1.qrTVenda.fieldByname('quantidade').asFloat ,ffNumber,18,2);

   shortdateformat := 'dd/MM/yy';    
end;

end.
