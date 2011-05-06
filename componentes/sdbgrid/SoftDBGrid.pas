unit SoftDBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Grids,
  DBGrids, db;

type
  TSoftDBGrid = class(TDBGrid)
  private
  	FAlternateColor: Boolean;
  	FLowColor: TColor;
    FHighColor: TColor;
    procedure SetHighColor(Value: TColor);
    procedure SetLowColor(Value: TColor);
    procedure SetAlternateColor(Value: Boolean);
  protected
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
    property SelectedRows;
  published
    property Align;
    property AlternateColor: Boolean read FAlternateColor write SetAlternateColor;
    property BorderStyle;
    property Color;
    property ColorLow: TColor read FLowColor write SetLowColor;
    property ColorHigh: TColor read FHighColor write SetHighColor;
    property Columns stored False; //StoreColumns;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnTitleClick;
  end;

	procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FTD', [TSoftDBGrid]);
end;


constructor TSoftDBGrid.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
  FHighColor := $00F0F0F2;
  FLowColor := $00E3E9E0;
end;


procedure TSoftDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
	if FAlternateColor then begin
		// alterna a cor das linhas
	  if DataLink.ActiveRecord <> Row - 1 then begin
			if (DataSource.DataSet.RecNo mod 2) = 0 then Canvas.Brush.Color := FLowColor
			else Canvas.Brush.Color := FHighColor;
	  end;
		DefaultDrawColumnCell(Rect, DataCol, Column, State);
		// executa o evento definido
	  if Assigned(OnDrawColumnCell) then
	    OnDrawColumnCell(Self, Rect, DataCol, Column, State);
  end else
  	inherited DrawColumnCell(Rect, DataCol, Column, State);
end;


procedure TSoftDBGrid.SetHighColor(Value: TColor);
begin
	if Value <> FHighColor then begin
  	FHighColor := Value;
    invalidate;
  end;
end;


procedure TSoftDBGrid.SetLowColor(Value: TColor);
begin
	if Value <> FLowColor then begin
  	FLowColor := Value;
    invalidate;
  end;
end;


procedure TSoftDBGrid.SetAlternateColor(Value: Boolean);
begin
	if Value <> FAlternateColor then begin
  	FAlternateColor := Value;
  	invalidate;
  end;
end;


end.
