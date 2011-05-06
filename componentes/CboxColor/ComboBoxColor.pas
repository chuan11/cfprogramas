unit ComboBoxColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TComboBoxColor = class(TComboBox)
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
  RegisterComponents('Standard', [TComboBoxColor]);
end;

procedure TComboBoxColor.DoEnter;
begin
   if FCorAoSair <> color then
      FCorAoSair := color;

   if Color <> CorAoEntrar then
      Color := CorAoEntrar;
   inherited;
end;


procedure tComboBoxColor.DoExit;
begin
   if Color <> CorAoSair then
      Color := CorAoSair;
   inherited;

end;
end.
