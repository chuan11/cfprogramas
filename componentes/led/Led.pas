unit Led;

interface

uses
  WinTypes, Classes, Graphics, Controls, Menus, ExtCtrls;

type
  TLedBorderStyle = ( bsFlat, bsCtl3D, bsStatusControl );
  TLedChangeEvent = procedure(Sender: TObject) of object;

  TBSLed = class( TGraphicControl )
  private
    FBackColor : TColor;
    FColor : TColor;
    FBorderWidth : TBorderWidth;
    FBorderStyle : TLedBorderStyle;
    FOn : Boolean;
    FOnChange : TLedChangeEvent;

    procedure SetBackColor( Value : TColor );
    procedure SetColor( Value : TColor );
    procedure SetBorderWidth( Value : TBorderWidth );
    procedure SetBorderStyle( Value : TLedBorderStyle );
    function GetCtl3D : Boolean;
    procedure SetCtl3D( Value : Boolean );
    procedure SetLight( Value : Boolean );
    procedure DrawCtl3dBorder( Bounds : TRect );
    procedure DrawBorder( Bounds : TRect );
    procedure Change;
  protected
    procedure Paint; override;
  public
    constructor Create( AOwner : TComponent ); override;
  published
    property BackColor : TColor read FBackColor write SetBackColor
      default clWhite;
    property Color : TColor read FColor write SetColor
      default clRed;
    property BorderStyle : TLedBorderStyle read FBorderStyle write SetBorderStyle
      default bsCtl3D;
    property BorderWidth : TBorderWidth read FBorderWidth write SetBorderWidth;
    property Ctl3D : Boolean read GetCtl3D write SetCtl3D
      default True;
    property LightOn : Boolean read FOn write SetLight
      default False;
    property OnChange : TLedChangeEvent read FOnChange write FOnChange;

    { Inherited Properties & Events }
    property Align;
    property Hint;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

uses
  SysUtils, WinProcs;


constructor TBSLed.Create( AOwner : TComponent );
begin
  inherited Create( AOwner );
  ControlStyle := ControlStyle + [ csOpaque ];
  FBackColor := clWhite;
  FColor := clRed;
  FBorderWidth := 0;
  FBorderStyle := bsCtl3D;
  FOn := False;
  Width := 15;
  Height := 15;
end;


procedure TBSLed.SetBackColor( Value : TColor );
begin
  if Value <> FBackColor then begin
    FBackColor := Value;
    Invalidate;
    Change;
  end;
end;


procedure TBSLed.SetColor( Value : TColor );
begin
  if Value <> FColor then begin
    FColor := Value;
    Invalidate;
    Change;
  end;
end;


procedure TBSLed.SetBorderWidth( Value : TBorderWidth );
begin
  if Value <> FBorderWidth then begin
    FBorderWidth := Value;
    Invalidate;
    Change;
  end;
end;


procedure TBSLed.SetBorderStyle( Value : TLedBorderStyle );
begin
  if Value <> FBorderStyle then begin
    FBorderStyle := Value;
    if ( FBorderStyle = bsStatusControl ) and ( FBorderWidth = 0 ) then
      FBorderWidth := 2
    else if FBorderWidth = 2 then
      FBorderWidth := 0;
    Invalidate;
    Change;
  end;
end;


function TBSLed.GetCtl3D : Boolean;
begin
  Result := FBorderStyle = bsCtl3D;
end;


procedure TBSLed.SetCtl3D( Value : Boolean );
begin
  if Value <> Ctl3D then begin
    if Value then
      FBorderStyle := bsCtl3D
    else
      FBorderStyle := bsFlat;
    Invalidate;
    Change;
  end;
end;


procedure TBSLed.SetLight( Value : Boolean );
begin
  if Value <> FOn then begin
    FOn := Value;
    Invalidate;
    Change;
  end;
end;

procedure TBSLed.Paint;
var
  Offset : Integer;
  DrawRct : TRect;
begin
  DrawRct := ClientRect;
  if FBorderWidth = 0 then
    OffSet := 1
  else
    OffSet := FBorderWidth;
  Inc(OffSet);
  with DrawRct, Canvas do
  begin

    case FBorderStyle of
      bsCtl3D:
      begin
        DrawCtl3DBorder( DrawRct );
      end;

      bsStatusControl:
        DrawBorder( DrawRct );

      bsFlat:
        DrawBorder( DrawRct )
    end; 

    InflateRect( DrawRct, -OffSet, -OffSet);
    if FOn then
      Brush.Color := FColor
    else
      Brush.Color := FBackColor;
    Pen.Style := psClear;
    Brush.Style := bsSolid;
    Ellipse(Left, Bottom, Right, Top);
  end;
end; 

procedure TBSLed.DrawCtl3DBorder( Bounds : TRect );
begin
  with Bounds, Canvas do
  begin
    Pen.Color := clBtnShadow;
    Pen.Style := psSolid;
    Pen.Width := FBorderWidth;
    Arc( Left, Bottom, Right, Top, Right, Top, Left, Bottom );

    Pen.Color := clBtnHighlight;
    Arc( Left, Bottom, Right, Top, Left, Bottom, Right, Top );
    Pen.Width := 1;
  end;
end;

procedure TBSLed.DrawBorder( Bounds : TRect );
begin
  with Bounds, Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := FBorderWidth;
    Ellipse( Left, Bottom, Right, Top );
  end;
end;

procedure TBSLed.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;
    
procedure Register;
begin
  RegisterComponents( 'BSComps' , [ TBSLed ] );
end;


end.
