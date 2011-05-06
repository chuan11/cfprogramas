unit component1;

interface

uses
  SysUtils, Classes;

type
  tcomponent1 = class(TComponent)
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
  RegisterComponents('Samples', [tcomponent1]);
end;

end.
 