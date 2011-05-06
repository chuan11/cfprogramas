unit UCalcEAN13;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, funcoes;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
  TabelaA: array [0..9] of string[7] = ('0001101', '0011001', '0010011', '0111101', '0100011', '0110001', '0101111', '0111011', '0110111', '0001011');
  TabelaB: array[0..9] of string[7] = ('0100111', '0110011', '0011011', '0011011', '0011101', '0111001', '0000101', '0010001', '0001001', '0010111');
  TabelaC: array[0..9] of string[7] = ('1110010', '1100110', '1101100', '1000010', '1011100', '1001110', '1010000', '1000100', '1001000', '1110100');
  TabAux: array[0..9] of string[6] = ('AAAAAA', 'AABABB', 'AABBAB', 'AABBBA', 'ABAABB', 'ABBAAB', 'ABBBAA', 'ABABAB', 'ABABBA', 'ABBABA');

}

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure GeraBarrasEAN13(CodBarras: string);
var
  Codigo: string;
  Formato: string;
  PegaDaTabela: string;
  DecimoTerceiroDig: Byte;
  Cont: Byte;
begin
  Formato := '';
  Codigo := CodBarras;
  DecimoTerceiroDig := StrToIntDef(CodBarras[1], 0);
  SHOWMeSSAGE ( cODIGO+  inttostr( DecimoTerceiroDig));
END;


 function Calcula_digito_de_control_EAN13(CodS:string):string;
 var
    i,r,rd: integer;
    CodN: array[1..12] of integer;
    b: boolean;
 begin
      // 1ª fase: calcula suma de digitos x 1 si impar, x 3 si par
      b := false; r := 0;
      for i := 1 to 12 do
      begin
           CodN[i] := 0;
           b := Not b;
           if b then
           begin
                CodN[i] := StrToInt(Copy(CodS,i,1)) * 1;
           end
           else
           begin
                CodN[i] := StrToInt(Copy(CodS,i,1)) * 3;
           end;
           r := r + CodN[i];
      end;
      rd := 0;
      // 2ª fase encuentra decena superior
      for i := r to r + 10 do
      begin
           if (i / 10) = Int(i / 10) then rd := i - r;
      end;
      if (rd = 10) then rd := 0;
      result := inttostr(rd);
 end;


procedure TForm1.Button1Click(Sender: TObject);
begin
   label1.Caption := 'Código: ' + edit1.text;
   edit2.text := funcoes.preencheCampo(12,'0','d',edit1.text) + Calcula_digito_de_control_EAN13(  funcoes.preencheCampo(12,'0','d',edit1.text))  ;
   edit1.text := '';
   edit1.setfocus;
end;

end.
