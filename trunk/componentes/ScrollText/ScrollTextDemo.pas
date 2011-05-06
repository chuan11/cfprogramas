unit ScrollTextDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CRLabel, ScrollText, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TColorArray = array[0..9] of TColor;
const
  TTextColor: TColorArray = (clBlack, clRed, clYellow, clLime, clGreen, clAqua,
    clNavy, clBlue, clPurple, clFuchsia);
type
  TForm1 = class(TForm)
    ScrollText1: TScrollText;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StopStartBtn: TSpeedButton;
    Continuous: TCheckBox;
    TextStyle: TRadioGroup;
    ScrollDirection: TRadioGroup;
    TextColors: TRadioGroup;
    Speed: TTrackBar;
    TextAlignment: TRadioGroup;
    Label1: TLabel;
    procedure ScrollText1End(Sender: TObject);
    procedure StopStartBtnClick(Sender: TObject);
    procedure ContinuousClick(Sender: TObject);
    procedure SpeedChange(Sender: TObject);
    procedure ScrollDirectionClick(Sender: TObject);
    procedure TextStyleClick(Sender: TObject);
    procedure TextAlignmentClick(Sender: TObject);
    procedure TextColorsClick(Sender: TObject);
    procedure ScrollText1Step(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation
var CurrentColor: Integer;
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurrentColor := 0;
  ScrollText1.Speed := Speed.Max + Speed.Min - Speed.Position;
end;

procedure TForm1.ScrollText1End(Sender: TObject);
begin
  if ScrollDirection.ItemIndex = 0 then
    with ScrollText1 do
      case ScrollDirection of
        sdBottomToTop, sdRightToLeft: ReverseDirection;
        sdLeftToRight: ScrollDirection := sdBottomToTop;
        sdTopToBottom: ScrollDirection := sdRightToLeft;
        sdStatic: ScrollDirection := sdBottomToTop;
      end;
  if StopStartBtn.Caption = 'Start' then ScrollText1.ScrollStop
end;

procedure TForm1.StopStartBtnClick(Sender: TObject);
begin
  with StopStartBtn do
    if Caption = 'Start' then begin
      ScrollText1.ScrollStart(ScrollText1.CurrentStep);
      Caption := 'Stop';
      Font.Color := clRed;
    end else begin
      ScrollText1.ScrollStop;
      Caption := 'Start';
      Font.Color := clLime;
    end;
end;

procedure TForm1.ContinuousClick(Sender: TObject);
begin
  ScrollText1.Continuous := Continuous.Checked;
  if StopStartBtn.Caption = 'Stop' then
    ScrollText1.ScrollStart(ScrollText1.CurrentStep);
end;

procedure TForm1.SpeedChange(Sender: TObject);
begin
  ScrollText1.Speed := Speed.Max + Speed.Min - Speed.Position;
end;

procedure TForm1.ScrollDirectionClick(Sender: TObject);
begin
  case ScrollDirection.ItemIndex of
    0: ScrollText1.ScrollDirection := sdBottomToTop;
    1: ScrollText1.ScrollDirection := sdBottomToTop;
    2: ScrollText1.ScrollDirection := sdLeftToRight;
    3: ScrollText1.ScrollDirection := sdRightToLeft;
    4: ScrollText1.ScrollDirection := sdStatic;
    5: ScrollText1.ScrollDirection := sdTopToBottom;
  end;
  if (StopStartBtn.Caption = 'Start') then ScrollText1.ScrollStop
  else if (StopStartBtn.Caption = 'Stop') and
    (ScrollText1.ScrollDirection = sdStatic) then
    ScrollText1.ScrollStart(ScrollText1.CurrentStep);
end;

procedure TForm1.TextStyleClick(Sender: TObject);
begin
  case TextStyle.ItemIndex of
    0: ScrollText1.TextStyle := tsLowered;
    1: ScrollText1.TextStyle := tsNormal;
    2: ScrollText1.TextStyle := tsRaised;
    3: ScrollText1.TextStyle := tsShaddow;
  end;
end;

procedure TForm1.TextAlignmentClick(Sender: TObject);
begin
  case TextAlignment.ItemIndex of
    0: ScrollText1.Alignment := taCenter;
    1: ScrollText1.Alignment := taLeftJustify;
    2: ScrollText1.Alignment := taRightJustify;
  end;
end;

procedure TForm1.TextColorsClick(Sender: TObject);
begin
  case TextColors.ItemIndex of
    0: ScrollText1.Font.Color := clAqua;
    1: ScrollText1.Font.Color := clBlack;
    2: ScrollText1.Font.Color := clRed;
  end;
end;

procedure TForm1.ScrollText1Step(Sender: TObject);
begin
{ Change text color if "Ugly Mess" selected and on every 5th step. }
  if (TextColors.ItemIndex = 3) and (ScrollText1.CurrentStep mod 5 = 0) then begin
    CurrentColor := (CurrentColor + 1) mod 10;
    ScrollText1.Font.Color := TTextColor[CurrentColor];
  end;
end;

end.

