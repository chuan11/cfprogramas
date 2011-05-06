unit Ledr;

interface

uses
  SysUtils, Classes, QControls, QStdCtrls;

type
  TLabel1 = class(TLabel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FTD', [TLabel1]);
end;

end.
