unit UetiquetaPallete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, adLabelEdit,funcoes;

type
  TFmpallete = class(TForm)
    ednPallete: TadLabelEdit;
    fsBitBtn1: TfsBitBtn;
    procedure ImprimeEtiquetaGrande(Sender:TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmpallete: TFmpallete;

implementation

{$R *.dfm}
uses unit1;

procedure TFmpallete.ImprimeEtiquetaGrande(Sender: TObject);
var
  arq:string;
begin
   arq:='Etiquetas.txt';
   funcoes.GravaLinhaEmUmArquivo(arq, 'L');
   funcoes.GravaLinhaEmUmArquivo(arq, 'H11');
   funcoes.GravaLinhaEmUmArquivo(arq, '1a5200000500100'+ednPallete.Text);
   funcoes.GravaLinhaEmUmArquivo(arq, '103300000100020'+ednPallete.Text);
   funcoes.GravaLinhaEmUmArquivo(arq, 'E');
   Winexec( pchar('cmd.exe /c print /d:'+ form1.EdLocalimp.text+' '+arq)  , sw_Hide);
end;

end.
