unit uFmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls;
  //funcsql, funcoes,

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure timerTimer(Sender: TObject);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
   timer.Interval := (1000 * 60 );
   timerTimer(nil);
end;

procedure TForm1.timerTimer(Sender: TObject);
begin
    statusBar1.Panels[0].Text := DateTimeToStr(now);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lojas:Tstringlist;
begin
   lojas := funcsql.get


end;

end.
