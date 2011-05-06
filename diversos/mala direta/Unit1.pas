unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, TFlatButtonUnit, RpBase, RpSystem, RpRave, RpDefine,
  RpCon, RpConDS;

type
  TForm1 = class(TForm)
    FlatButton1: TFlatButton;
    ADOConnection1: TADOConnection;
    Query: TADOQuery;
    RvDataSetConnection1: TRvDataSetConnection;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
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
begin
   query.close;
   query.Open;
end;

end.
