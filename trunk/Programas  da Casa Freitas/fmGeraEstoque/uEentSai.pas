unit uEentSai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB;

type
  TfmEntSai = class(TForm)
    Label1: TLabel;
    lbDesc: TLabel;
    lbis_ref: TLabel;
    lbTotEnt: TLabel;
    Label5: TLabel;
    lbTotVenda: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbPrimEnt: TLabel;
    Bevel1: TBevel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    procedure listaTotalEntSai(isref:String);
    procedure listaDadosEntrada(isref: String);
    procedure ObtertotalVendas(isRef:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEntSai: TfmEntSai;

implementation

uses uMain, funcsql, funcoes, uCF;

{$R *.dfm}

{ TfmEntSai }

{ TfmEntSai }



procedure TfmEntSai.listaDadosEntrada(isref: String);
var
   cmd:String;
begin
   cmd := 'Exec dbo.Z_CF_stoListaQtEntradaPorItem '+ isref;
//   funcsql.getQuery(fmMain.Conexao, qrEnt, cmd );

//   if (qrEnt.IsEmpty = false)then
   begin
//      cmd := qrEnt.fieldByName('data').asString;
      insert('20', cmd, length(cmd)-1);
      lbPrimEnt.Caption := cmd;


//       ObtertotalVendas(nil);
//   end
//   else
       lbPrimEnt.Caption := 'Não há...';
       end;
end;


procedure TfmEntSai.ObtertotalVendas(isRef:String);
begin
   if (lbPrimEnt.Caption <> '0') then
   begin
      lbTotVenda.Caption :=
      ucf.getVendaProduto(isRef, '10033674', '10033674', strToDate(lbPrimEnt.Caption), now-1);
   end;
end;

procedure TfmEntSai.listaTotalEntSai(isref: String);
begin //
    listaDadosEntrada(isref);
    obterTotalVendas(isref);
end;



end.
