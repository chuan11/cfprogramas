unit MEditColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask;

type
  tMeditColor = class(TMaskEdit)
  private
     FCorAoEntrar,FCorAoSair:TColor;
    { Private declarations }
  protected
     procedure doEnter; override;
     procedure DoExit; override;
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
     property CorAoEntrar: TColor read FcorAoEntrar write FcorAoEntrar default clNavy ;
     property CorAoSair: TColor read FcorAoSair write FcorAoSair default clNavy ;
  end;
  procedure Register;


implementation

procedure Register;
begin
  RegisterComponents('Additional', [tMeditColor]);
end;

procedure tMeditColor.DoEnter;
begin
   if FCorAoSair <> color then
      FCorAoSair := color;

   if Color <> CorAoEntrar then
      Color := CorAoEntrar;
   inherited;
end;


procedure tMeditColor.DoExit;
begin
   if Color <> CorAoSair then
      Color := CorAoSair;
   inherited;
end;

end.
