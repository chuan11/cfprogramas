unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, fCtrls, FUNCOES, ExtCtrls;

type
  TForm1 = class(TForm)
    edLoja: TfsEdit;
    edTotal: TfsEdit;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    rgContagem: TRadioGroup;
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   i,contador,tFicha:integer;
   fc:Tstringlist;
   nContagem:String;
begin
   fc := TStringList.create();

   if rgContagem.ItemIndex = 0 then
      nContagem := '1§ CONTAGEM'
   else
      nContagem := '2§ CONTAGEM';


   contador := 1;
   for i:=1 to StrToint( edTotal.Text ) do
   begin
      fc.Add('');
      fc.Add('      '+nContagem + '                      LOJA - '+Funcoes.preencheCampo(30,' ','d', edLoja.TEXT)+ '      FICHA ' + FUNCOES.preencheCampo(4,'0', 'E', intToStr(i)) );
      fc.Add('');
      fc.Add('');
      fc.Add('      DESC PROD________________________________________________ REF PRODUTO______________');
      fc.Add('');
      fc.Add('');
      fc.Add('      COD BARRAS__|__|__|__|__|__|__|__|__|__|__|__|__ COD PROD___|__|__|__|__|__|__|___ ' );
      fc.Add('');
      fc.Add('');
      fc.Add('      FORNECEDOR__________________________________  QUANTIDADE____|___|___|___|__|_______');
      fc.Add('');
      fc.Add('      EQUIPE_____________________________________________________________________________');
      fc.Add('');
      fc.Add('');
      fc.Add('-------------------------------------------------------------------------------------------------');

      inc(contador);
      if contador > 5 then
      begin
         contador :=1;
         fc.add('');
      end;
    end;
    fc.SaveToFile('c:\ficha.txt');
   FUNCOES.imprimeArquivo(FORM1,'C:\FICHA.TXT',TRUE, 10, 'FICHA '+ edLoja.text +' ' +rgContagem.items[rgContagem.itemIndex] );
end;

end.
