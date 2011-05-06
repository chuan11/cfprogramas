unit ucracha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RLReport, Mask, RLBarcode, jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;


///    RLAngleLabel2: TRLAngleLabel;

    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;

    RLReport1: TRLReport;
    RLImage1: TRLImage;
    RLLabel1: TRLLabel;
    RLBarcode1: TRLBarcode;
    RLLabel2: TRLLabel;
    RLAngleLabel1: TRLAngleLabel;
    Edit3: TEdit;
    Label3: TLabel;
    RLAngleLabel2: TRLAngleLabel;
    procedure Button1Click(Sender: TObject);
    procedure cracha(sender:TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure TForm1.Button1Click(Sender: TObject);
var
   ok:boolean;
   erro:string;
begin
   ok:= true;
   erro:=' Falta(m) preencher o(s) campo(s): ' +#13;
   if edit1.text = '' then
   begin
      ok := false;
      erro:= erro + '   Nome' +#13;
   end;
   if edit2.text = '' then
   begin
      ok := false;
      erro:= erro + '   Nome Completo' +#13;
   end;
   if edit3.text = '' then
   begin
      ok := false;
      erro:= erro + '   Funcao' +#13;
   end;


   if ok = true then
      cracha(sender)
   else
      showmessage(erro);


end;
procedure tform1.cracha(sender : TObject);
begin

   rllabel2.caption:=edit1.text;
   rlanglelabel1.Caption := edit2.text;
   rlanglelabel2.Caption := maskedit1.text;
   rlbarcode1.caption := maskedit1.text;
   rllabel1.caption := EDIT3.TEXT;
   if maskedit1.text = '' then
   begin
      rlbarcode1.visible:= false;
      rlanglelabel2.visible := false;
   end;
   rlReport1.Preview;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    form1.height:=121;
end;

end.
