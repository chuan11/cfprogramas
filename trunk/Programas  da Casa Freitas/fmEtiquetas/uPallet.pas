unit uPallet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, adLabelEdit,FUNCOES;

type
  TPallet = class(TForm)
    ednPallete: TadLabelEdit;
    fsBitBtn1: TfsBitBtn;
    Rg: TfsRadioGroup;
    procedure fsBitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imprimirPalletArgox(Sender:TObject);
    procedure imprimirPalletDynaPos(Sender:TObject);
    procedure ednPalleteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pallet: TPallet;

implementation

uses uEtiquetas;

{$R *.dfm}

procedure TPallet.imprimirPalletArgox(Sender:TObject);
var
  arq:string;
  tEAN,xEAN,yEAN:string;
  tFONTE, xFONTE, yFONTE:STRING;
begin
///  AORIENTACAO Y É DA ESQUERDA PARA A DIREITA
//   A ORIENTACAO X E DE BAIXO PARA CIMA
   if Rg.ItemIndex = 0 then
   begin
      tEAN:=  '4';
      xEAN:= '0030';
      yEAN := '0010';
      tFONTE:= '5';
      yFONTE := '0010';
      xfONTE := '0150';
   end
   else
   begin
      tEAN:=  '3';
      xEAN:= '0030';
      yEAN := '0010';
      tFONTE:= '3';
      yFONTE := '0075';
      xfONTE := '0020';
   end;

   arq:='Etiquetas.txt';
   DeleteFile(arq);
     funcoes.GravaLinhaEmUmArquivo(arq, 'L');
         funcoes.GravaLinhaEmUmArquivo(arq, '1F31025'+ '0005' + '0020' + ednPallete.text);
   funcoes.GravaLinhaEmUmArquivo(arq, '1'{Orientacao}+ {a}'a'+ '31'+ '060'{Altura} + yEAN {Y}+ xEAN {X}+ednPallete.Text{codigo});
   funcoes.GravaLinhaEmUmArquivo(arq, '1'{orientacao}+ tFonte+'2'{multHoriz}+'2'{multvert}+
                                     '000'{subFonte}+ yFONTE + xFONTE + ednPallete.Text );
                                                                //100
   funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   Winexec( pchar('cmd.exe /c print /d:'+ fmEtiquetas.EdLocalimp.text+' '+arq)  , sw_Hide);
end;

procedure TPallet.FormShow(Sender: TObject);
begin
   Pallet.Left := fmEtiquetas.Left+ 100;
end;


procedure TPallet.imprimirPalletDynaPos(Sender: TObject);
var
  arq:string;
  tEAN,xEAN,yEAN:STRING;
  tFONTE,xFONTE,yFONTE:STRING;

begin
   arq := 'Etiquetas.txt';
   DeleteFile(arq);

   if Rg.ItemIndex = 0 then
   begin
     tFONTE := '5';
     xFONTE := '405';
     yFONTE := '130';
     tEAN := '150';
     xEAN := '765';
     yEAN := '150';
   end
   else
   begin
     tFONTE := '4';
     xFONTE := '765';
     yFONTE := '230';
     tEAN := '100';
     xEAN := '765';
     yEAN := '150';
   end;
 {
    formato do comando texto : Ax,y,rotacao,fonte, multiplicador horizontal, multip verticao ,normal ou reverse, texto
 Barras : Bx,y, rotacao(2), tipoDeCodB, largbarra , altura, altura, imprimeOuNaoNumero, codigo
 }
   funcoes.GravaLinhaEmUmArquivo(arq, 'N');
   funcoes.GravaLinhaEmUmArquivo(arq, 'Q200,24');
   funcoes.GravaLinhaEmUmArquivo(arq, 'q800' );
   funcoes.GravaLinhaEmUmArquivo(arq, 'B'+ xEAN   +','+ yEAN +',2,1,3,1,'+ tEAN +',N,"'+ednPallete.Text+'"' );
   funcoes.GravaLinhaEmUmArquivo(arq, 'A'+ xFONTE +','+ yFONTE +',2,'+ tFONTE+ ',2,2,N,"' + ednPallete.Text + '"');

   funcoes.GravaLinhaEmUmArquivo(arq,'P1');
   funcoes.GravaLinhaEmUmArquivo(arq,'N');

   Winexec( pchar('cmd.exe /c print /d:'+ fmEtiquetas.EdLocalimp.text+' '+arq)  , sw_Hide);
end;

procedure TPallet.ednPalleteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
  begin
     fsBitBtn1Click(Sender);
     fsBitBtn1.SetFocus;
     ednPallete.setFocus;
  end;
end;

procedure TPallet.RgClick(Sender: TObject);
begin
   if rg.ItemIndex  = 0 then
   begin
      ednPallete.LabelDefs.Caption := 'Numero do pallet';
      ednPallete.MaxLength := 4;
   end
   else
   begin
      ednPallete.LabelDefs.Caption := 'Endereço';
      ednPallete.MaxLength := 12;
   end;
   ednPallete.Text :='';
end;

procedure TPallet.FormCreate(Sender: TObject);
begin
   RgClick(sender);
end;

procedure TPallet.fsBitBtn1Click(Sender: TObject);
begin
   case fmEtiquetas.cbTIpoImpressao.ItemIndex of
    0:imprimirPalletArgox(Sender);
    1:imprimirPalletDynaPos(Sender);
   end;
end;

end.
