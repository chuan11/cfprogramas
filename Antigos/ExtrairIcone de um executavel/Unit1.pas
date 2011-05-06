unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,Shellapi ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
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
begin
   if opendialog1.Execute then
   begin
      Image1.Picture.Icon.Handle:= ExtractIcon(Handle,PChar(opendialog1.filename),0);
      image1.Picture.SaveTofile('c:\Icone.bmp');
      showmessage('Salvo em c:\icone.bmp');
   end;
end;

end.
