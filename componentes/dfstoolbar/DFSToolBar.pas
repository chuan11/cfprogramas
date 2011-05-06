unit DFSToolBar;

interface

uses
  SysUtils, Classes, Controls, ToolWin, ComCtrls;

type
  ttoolBar1 = class(TToolBar)
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
  RegisterComponents('Samples', [ttoolBar1]);
end;

end.
