unit umColetor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, DB;

type
  TfmColetor = class(TForm)
    edCodigo: TadLabelEdit;
    lbCodigo: TLabel;
    lbDesc: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure consultaProduto();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmColetor: TfmColetor;

implementation

{$R *.dfm}
   uses uMain, uCF;


procedure TfmColetor.FormActivate(Sender: TObject);
begin
   edCodigo.SetFocus
end;

procedure TfmColetor.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) then
   begin
      consultaProduto();
   end;
end;

procedure TfmColetor.consultaProduto;
var
   ds:TdataSet;
begin
   lbCodigo.Caption := '';
   lbDesc.Caption := '';
   ds:= uCF.getDadosProd( fmMain.getUoLogada(), edCodigo.Text,  '101', true );

   if (ds.IsEmpty = false) then
   begin
      lbCodigo.Caption := ds.fieldBYName('ean').asString;
      lbDesc.caption := ds.fieldBYName('descricao').asString;
   end;
   ds.free();
   edCodigo.Text := '';

   edCodigo.SetFocus();
end;

end.
