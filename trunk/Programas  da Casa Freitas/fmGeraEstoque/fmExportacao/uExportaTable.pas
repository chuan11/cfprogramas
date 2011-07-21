unit uExportaTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, mxExport;

type
  TfmExportaTable = class(TForm)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExportaTable: TfmExportaTable;

implementation

{$R *.dfm}
uses uMain, funcoes, funcSQL, uGeraEstoque;

procedure TfmExportaTable.Button1Click(Sender: TObject);
var
   arq:String;
   msgEmail:TStringlist;
begin
   if (radioGroup1.ItemIndex = 0) then
      funcSQl.exportacaoDeTabela( fmGeraEstoque.tbGE, xtExcel, xsView, '')
   else
   begin
      arq:= funcSQl.exportacaoDeTabela( fmGeraEstoque.tbGE, xtExcel, xsFile,' ');
      if (fileExists(arq) = true) then
      begin
         msgEmail := TStringList.Create();
         msgEmail.Add('Arquivo  enviado pelo geraEstoque:');
         msgEmail.Add('Gerado por:' + fmMain.getNomeUsuario());
         msgEmail.Add('Em:' + dateTimeToStr(now) );
         fmMain.EnviarEmail( '', 'Exportação do gera estoque', arq, msgEmail, 'Envio de email do gera estoque' );
      end;
   end;
   fmExportaTable.Close();
end;

procedure TfmExportaTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
    fmExportaTable := nil;
end;

end.
