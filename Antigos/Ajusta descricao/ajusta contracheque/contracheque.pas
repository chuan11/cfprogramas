unit contracheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,funcoes, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Edit1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1DblClick(Sender: TObject);
begin
  edit1.text :=  funcoes.DialogAbrArq('c:\');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   arq,des:tstringlist;
   i:integer;
   aux:String;
begin
   arq := tstringlist.Create;
   des := tstringlist.Create;

   arq.LoadFromFile(edit1.text);


   for i:=0 to arq.Count -1 do
   begin
      if copy(arq[i],10,01) = '' then
      begin
         des.add(arq[i]);
         des.add('     ');
      end
      else
         des.add(arq[i]);
   end;

   aux:= edit1.text;
   insert('_ajustado',aux, length(edit1.text)-3);


   des.savetoFIle(aux);
end;

end.
