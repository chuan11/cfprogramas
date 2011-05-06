unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TFlatEditUnit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FlatEdit1: TFlatEdit;
    procedure Button1Click(Sender: TObject);
    procedure FlatEdit1Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


function CalculaCnpjCpf(Numero : String) : String;
var
  i,j,k, Soma, Digito : Integer;
  CNPJ : Boolean;
begin
    Result := Numero;
    case Length(Numero) of
       9:CNPJ := False;
      12:CNPJ := True;
    else
      Exit;
    end;
    for j := 1 to 2 do
    begin
       k := 2;
       Soma := 0;
       for i := Length(Result) downto 1 do
       begin
          Soma := Soma + (Ord(Result[i])-Ord('0'))*k;
          Inc(k);
          if (k > 9) and CNPJ then
             k := 2;
       end;
       Digito := 11 - Soma mod 11;
       if Digito >= 10 then
          Digito := 0;
       Result := Result + Chr(Digito + Ord('0'));
   end;
end;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   aux:string;
begin
   randomize;
   aux := InttoStr( random(999999999) );
   while length(aux) < 09 do
      aux := aux + InttoStr( random(9));
   aux:= CalculaCnpjCpf (aux);

   insert('-',aux, length(aux)-1);
   insert('.',aux, length(aux)-5);
   insert('.',aux, length(aux)-9);
   flatedit1.text := aux;
end;

procedure TForm1.FlatEdit1Enter(Sender: TObject);
begin
   button1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Button1Click(Sender)
end;

end.
