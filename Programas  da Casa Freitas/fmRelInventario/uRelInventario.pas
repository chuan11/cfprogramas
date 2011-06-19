unit uRelInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, db, ADOdb;

type
  TfmRelInventario = class(TForm)
    fsBitBtn1: TfsBitBtn;
    tb: TADOTable;
    procedure fsBitBtn1Click(Sender: TObject);
    procedure relatorioContagem(arq:String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelInventario: TfmRelInventario;

implementation

{$R *.dfm}
uses uMain, funcoes, funcSQL, uCF;

procedure TfmRelInventario.fsBitBtn1Click(Sender: TObject);
var
  arq:String;
begin
    arq:= funcoes.DialogAbrArq('txt','c:\');
    if (fileExists(arq) = true ) then
       relatorioContagem(arq);
end;

procedure TfmRelInventario.relatorioContagem(arq: String);
const
   EAN_POS_INI = 1;
   EAN_TAM = 13;

   QT_POS_INI = 15;
   QT_TAM = 06;

   END_POS_INI =22;
   END_TAM = 12;

   PAL_POS_INI = 35;
   PAL_TAM = 4;
var
   lst:TStringList;
   cmd:String;
   i:integer;
   dsItem:TDataSet;
   params:TStringlist;
begin
   if (tb.TableName <> '') then
      tb.close();


   lst := TStringList.create();
   lst.LoadFromFile(arq);

 //  tb := TADOTAble.Create(nil);
 //  tb.Connection := fmMain.conexao;

   funcSQL.getTable(fmMain.Conexao, tb, 'codigo varchar(08), descricao varchar(50), endereco varchar(12), qt varchar(06), pallet varchar(04)' );

   for i:=0 to lst.Count -1 do
   begin
      dsItem:= uCF.getDadosProd( fmMain.getUoLogada, copy(lst[i], EAN_POS_INI, EAN_TAM), '101');

      if ( dsItem.IsEmpty = false) then
      begin
         tb.AppendRecord([
                    dsItem.fieldByName('codigo').asString,
                    dsItem.fieldByName('descricao').asString,
                    copy( lst[i], END_POS_INI, END_TAM),
                    copy( lst[i], QT_POS_INI, QT_TAM),
                    copy( lst[i], PAL_POS_INI, PAL_TAM)
                  ]);
      end;
     dsItem.Free();
   end;
  params := TStringList.create();
  params.add(arq);
  fmMain.impressaoRaveQr2(tb, nil, 'rpInvContagem', params );
end;

end.
