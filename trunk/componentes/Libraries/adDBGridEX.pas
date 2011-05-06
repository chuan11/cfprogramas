//==============================================================================
// Unit........: adDBGridEX.pas
// Created.....: 25/05/2005
// Type Unit...: Cross platform
// -----------------------------------------------------------------------------
// Author......: Dennys dos Santos Sobrinho
// E-Mail......: dennys@activedelphi.com.br
// Copyright...: Revista ActiveDelphi
// Distribuição: Licença pública GNU GPL
//               http://lie-br.conectiva.com.br/licenca_gnu.html
// Observação..: Qualquer modificação ou implementação, deverá ser enviada para
//               o autor a fim de atualizar os demais beneficiados.
// .............................................................................
// Histórico
// ---------
// 08/04/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit adDBGridEX;

interface

{$I ActiveDelphi.inc}
  
uses Classes, DB, SysUtils,
{$IFDEF LINUX}
     Qt, Libc, QGrids, QGraphics,
{$ELSE}
     Windows, Messages, Grids, Graphics,
{$ENDIF}
     DBGrids;
     
const

{$IFDEF FAESP}
  clHighlightColumnFocused  = TColor($00A4B0B7); //$00A4B0B7
  clRowColor1               = TColor($00AAA6A6);
  clRowColor2               = TColor($009D9999);
  clRowHighlight            = TColor($00FF9F9F); //TColor($00CEBBB5);
  clTitleColor              = clTeal;
  clTitleFontColor          = clYellow;
{$ELSE}
  clHighlightColumnFocused  = TColor($00A28D86); //$00927A72 
  clRowColor1               = TColor($00FFDDDD);
  clRowColor2               = TColor($00FFC4C4);
  clRowHighlight            = clHighlightColumnFocused; //TColor($00FF9F9F);
  clTitleColor              = clBtnFace{clSkyBlue};
  clTitleFontColor          = clWindowText;
{$ENDIF}
  
type

  TadDBGridEX       = class;
  TadMouseWheelPos  = (wpUp, wpDown);
  TOnMoveRecords    = procedure(const Sender : TObject; const RecNo : longint) of object;
  TOnMouseWheel     = procedure(const Shift: TShiftState; const MousePos: TPoint; const WheelPos : TadMouseWheelPos; var Accept : boolean) of object;
  TOnHighlightCell  = procedure(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState) of object;
  
  //-----| Class: TadGridColumnsDefs
  
  TadGridColumnsDefs = class(TPersistent)
  private
    { Private declarations }
    Owner           : TComponent{TadDialogDefs};
    FAlignment      : TAlignment;
    FColor          : TColor;
    FFont           : TFont;
    FTitleAlignment : TAlignment;
    FTitleColor     : TColor;
    FTitleFont      : TFont;
    procedure SetFont(Value : TFont);
    procedure SetTitleFont(Value : TFont);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent{TadDialogDefs}); virtual;
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property Alignment      : TAlignment  read FAlignment       write FAlignment      default taLeftJustify;
    property Color          : TColor      read FColor           write FColor          default clWindow;
    property Font           : TFont       read FFont            write SetFont;
    property TitleAlignment : TAlignment  read FTitleAlignment  write FTitleAlignment default taCenter;
    property TitleColor     : TColor      read FTitleColor      write FTitleColor     default clTitleColor;
    property TitleFont      : TFont       read FTitleFont       write SetTitleFont;
  end;

  //-----| Class: TadHighlightColumnFocused
  
  TadHighlightColumnFocused = class(TadGridColumnsDefs)
  public
    { Public declarations }
    constructor Create(AOwner: TComponent{TadDialogDefs}); override;
  published
    { Published declarations }
    property TitleColor default clHighlightColumnFocused;
  end;
  
  //-----| Class: TadGridColumnsColors

  TadGridColumnsColors = class(TPersistent)
  private
    { Private declarations }
    FActive                 : boolean;
    FHighlightColumnFocused : TadHighlightColumnFocused;
    FGridColumnSelected     : TadGridColumnsDefs;
    FGridColumnUnSelected   : TadGridColumnsDefs;
    procedure SetHighlightColumnFocused(Value : TadHighlightColumnFocused);
    procedure SetGridColumnSelected(Value : TadGridColumnsDefs);
    procedure SetGridColumnUnSelected(Value : TadGridColumnsDefs);
    procedure SetActive(Value : boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TComponent{TadDBGridEX};
    constructor Create(AOwner : TComponent{TadDBGridEX});
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  Active                  : boolean                   read  FActive                 write SetActive                 default False;
    property  HighlightColumnFocused  : TadHighlightColumnFocused read  FHighlightColumnFocused write SetHighlightColumnFocused;
    property  GridColumnSelected      : TadGridColumnsDefs        read  FGridColumnSelected     write SetGridColumnSelected;
    property  GridColumnUnSelected    : TadGridColumnsDefs        read  FGridColumnUnSelected   write SetGridColumnUnSelected;
  end;
  
  //-----| Class: TadRowColors

  TadRowColors = class(TPersistent)
  private
    { Private declarations }
    FActive     : boolean;
    FRowColor1  : TColor;
    FRowColor2  : TColor;
    procedure SetRowColor1(Value : TColor);
    procedure SetRowColor2(Value : TColor); 
    procedure SetActive(Value : boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TComponent{TadDBGridEX};
    constructor Create(AOwner : TComponent{TadDBGridEX});
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  Active    : boolean read  FActive     write SetActive     default False;
    property  RowColor1 : TColor  read  FRowColor1  write SetRowColor1  default clRowColor1; 
    property  RowColor2 : TColor  read  FRowColor2  write SetRowColor2  default clRowColor2;
  end;

  //-----| Class: TadRowHighlight
  
  TadRowHighlight = class(TPersistent)
  private
    { Private declarations }
    FActive     : boolean;
    FBackColor  : TColor;
    FTextColor  : TColor;
    procedure SetBackColor(Value : TColor);
    procedure SetTextColor(Value : TColor);
    procedure SetActive(Value : boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TComponent{TadDBGridEX};
    constructor Create(AOwner : TComponent{TadDBGridEX});
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  Active    : boolean read  FActive     write SetActive     default False;
    property  BackColor : TColor  read  FBackColor  write SetBackColor  default clRowHighlight;
    property  TextColor : TColor  read  FTextColor  write SetTextColor  default clWindowText;
  end;
  
  //-----| Class: TadLocateOptions

  TadLocateOptions = class(TPersistent)
  private
    { Private declarations }
    FActive                   : boolean;
    FFieldName                : string;
    FOptions                  : TLocateOptions;
    FTickCount                : integer;
    FMaxLength                : integer;
    FHighlightWordFound       : boolean;
    FHighlightColorSelected   : TColor;
    FHighlightColorUnSelected : TColor;
    FAutoSetFieldName         : boolean;
    procedure SetFieldName(Value : string);
    procedure SetHighlightColorSelected(Value : TColor);
    procedure SetHighlightColorUnSelected(Value : TColor);
    procedure SetActive(Value : boolean);
    procedure SetAutoSetFieldName(Value : boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TComponent{TadDBGridEX};
    constructor Create(AOwner : TComponent{TadDBGridEX});
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  Active                    : boolean         read  FActive                   write SetActive                   default False;
    property  FieldName                 : string          read  FFieldName                write SetFieldName;
    property  Options                   : TLocateOptions  read  FOptions                  write FOptions                    default [loCaseInsensitive, loPartialKey];
    property  TickCount                 : integer         read  FTickCount                write FTickCount                  default 650;
    property  MaxLength                 : integer         read  FMaxLength                write FMaxLength                  default 32;
    property  HighlightWordFound        : boolean         read  FHighlightWordFound       write FHighlightWordFound         default True;
    property  HighlightColorSelected    : TColor          read  FHighlightColorSelected   write SetHighlightColorSelected   default clRed;
    property  HighlightColorUnSelected  : TColor          read  FHighlightColorUnSelected write SetHighlightColorUnSelected default clYellow;
    property  AutoSetFieldName          : boolean         read  FAutoSetFieldName         write SetAutoSetFieldName         default False;
  end;

  //-----| Class: TadGridDefs

  TadGridDefs = class(TPersistent)
  private
    { Private declarations }
    FLocateOptions            : TadLocateOptions;
    FRowColors                : TadRowColors;
    FRowHighlight             : TadRowHighlight;
    FHighlightColor           : TColor;
    FHighlightFontColor       : TColor;
    FGridColumnsColors        : TadGridColumnsColors;
    FChangeRowColOnMouseMove  : boolean;
    procedure SetLocateOptions(Value : TadLocateOptions);
    procedure SetRowColors(Value : TadRowColors);
    procedure SetRowHighlight(Value : TadRowHighlight);
    procedure SetHighlightColor(Value : TColor);
    procedure SetHighlightFontColor(Value : TColor);
    procedure SetGridColumnsColors(Value : TadGridColumnsColors);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TComponent{TadDBGridEX};
    constructor Create(AOwner : TComponent{TadDBGridEX});
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  LocateOptions           : TadLocateOptions      read  FLocateOptions            write SetLocateOptions;
    property  RowColors               : TadRowColors          read  FRowColors                write SetRowColors;
    property  RowHighlight            : TadRowHighlight       read  FRowHighlight             write SetRowHighlight;
    property  HighlightColor          : TColor                read  FHighlightColor           write SetHighlightColor         default clHighlight;
    property  HighlightFontColor      : TColor                read  FHighlightFontColor       write SetHighlightFontColor     default clHighlightText;
    property  ColumnsColors           : TadGridColumnsColors  read  FGridColumnsColors        write SetGridColumnsColors;
    property  ChangeRowColOnMouseMove : boolean               read  FChangeRowColOnMouseMove  write FChangeRowColOnMouseMove  default False;
  end;
  
  //-----| Class: TadDBGridEX

  TadDBGridEX = class(TDBGrid)
  private
     { Private declarations }
    FAbout            : string;
    FColumnsLoaded    : boolean;
    FActiveColumn     : longint;
    FInternalRecNo    : longint;
    FGridDefs         : TadGridDefs;
    FSearchText       : string;
    FField            : TField;
    FOnMoveRecords    : TOnMoveRecords;
    FOnMouseWheel     : TOnMouseWheel;
    FOnHighlightCell  : TOnHighlightCell;
{$IFDEF LINUX}
    FTimer            : TTimer;
    procedure SetFocus(AControl: TControl); override;
{$ELSE}     
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMVScroll(var Msg: TWMVScroll); message wm_VScroll;
{$ENDIF}
    procedure SetGridDefs(Value : TadGridDefs);
    procedure DoInternalRecno;
    procedure DoDefaultColumns;
    function  IndexLocateFieldName : longint;
    procedure DoPaintColorTitles;
  protected
    { Protected declarations }
    property  SearchText  : string  read  FSearchText write FSearchText;
    procedure ProcessSearchKey(Key: Char); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoEnter; override;
    procedure Scroll(Distance: Integer); override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Loaded; override;
    procedure   TitleClick(Column: TColumn); override;
    procedure   KeyPress(var Key: Char); override;
    procedure   DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;
    procedure   ColExit; override;
    procedure   ColEnter; override;
    function    HighlightCell(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState): boolean; override;
    procedure   SetGridColumn(oGridColumnsDefs : TadGridColumnsDefs; iIndex : longint); virtual;
    function    ActiveCol : longint; virtual;
    function    ActiveRow : longint; virtual;
    procedure   MouseMove(Shift: TShiftState; X, Y: Integer); override;
  published
    { Published declarations }
    property  Align;
    property  About           : string            read  FAbout            write FAbout;
    property  GridDefs        : TadGridDefs       read  FGridDefs         write SetGridDefs;
    property  OnMoveRecords   : TOnMoveRecords    read  FOnMoveRecords    write FOnMoveRecords;
    property  OnMouseWheel    : TOnMouseWheel     read  FOnMouseWheel     write FOnMouseWheel;
    property  OnHighlightCell : TOnHighlightCell  read  FOnHighlightCell  write FOnHighlightCell;
  end;
  
var
  SearchTickCount: Integer = 0;
   
implementation

// TadDBGridEX -----------------------------------------------------------------

constructor TadDBGridEX.Create(AOwner: TComponent); 
begin
  inherited Create(AOwner);
  FAbout          := '';
  FInternalRecNo  := 0;
  FColumnsLoaded  := False;
  FActiveColumn   := -1;
  FGridDefs       := TadGridDefs.Create(Self);
{$IFDEF LINUX}
  FTimer          := TTimer.Create(Self);
  FTimer.Enabled  := False;
  FTimer.Interval := 100;
  FTimer.OnTimer  := TimerEvent;
{$ENDIF}
end;

// -----------------------------------------------------------------------------

destructor TadDBGridEX.Destroy;
begin
  FreeAndNil(FGridDefs);
{$IFDEF LINUX}
  FTimer.Free;
  FTimer := nil;
{$ENDIF}
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.Loaded;
begin
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadDBGridEX.SetFocus(AControl: TControl);
{$ELSE}
procedure TadDBGridEX.WMSetFocus(var Message: TWMSetFocus);
{$ENDIF}
begin
  DoEnter;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.WMVScroll(var Msg: TWMVScroll);
begin
  try
    SearchText := '';
    if Msg.ScrollCode = sb_ThumbTrack then
      Perform(wm_VScroll, MakeLong(sb_ThumbPosition, Msg.Pos), Msg.ScrollBar);
  except
  end;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.DoEnter;
begin
  SearchText := '';
  DoInternalRecno;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.KeyPress(var Key: Char);
begin
  if (Ord(Key) = VK_BACK) then begin
    SearchText := '';
    Invalidate;
  end else
    ProcessSearchKey(Key);
  inherited KeyPress(Key);
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.Scroll(Distance: Integer);
begin
  SearchText := '';
  inherited;
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): boolean;
begin
  Result := True;
  if Assigned(FOnMouseWheel) then
    FOnMouseWheel(Shift, MousePos, wpUp, Result);
  if Result then begin
    Result := inherited DoMouseWheelUp(Shift, MousePos);
    Perform(WM_KeyDown, VK_UP, 0); 
  end;  
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): boolean;
begin
  Result := True;
  if Assigned(FOnMouseWheel) then
    FOnMouseWheel(Shift, MousePos, wpDown, Result);
  if Result then begin
    Result := inherited DoMouseWheelDown(Shift, MousePos);
    Perform(WM_KeyDown, VK_DOWN, 0);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.DoInternalRecno;
begin
  if Assigned(Datasource) and Assigned(Datasource.DataSet) and
    (FInternalRecNo <> TDataSet(Datasource.DataSet).RecNo) then begin
    Invalidate;
    FInternalRecNo := TDataSet(Datasource.DataSet).RecNo;
    if Assigned(FOnMoveRecords) then
      FOnMoveRecords(Self, FInternalRecNo);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  r1,r2   : TRect;
  s1,s2   : string;
begin
  BeginUpdate;
  inherited;
  try
    if (gdFocused in State) and not (gdFixed in State) then begin
      DoInternalRecno;
      if GridDefs.LocateOptions.AutoSetFieldName then
        GridDefs.LocateOptions.FieldName := Columns[DataCol].FieldName;
      if GridDefs.ColumnsColors.Active {and (Columns[Col].Index <> FActiveColumn)} then begin
        if GridDefs.LocateOptions.AutoSetFieldName then
          SetGridColumn(GridDefs.ColumnsColors.GridColumnSelected, FActiveColumn{Col-1})
        else if (FActiveColumn <> IndexLocateFieldName) then
          SetGridColumn(GridDefs.ColumnsColors.HighlightColumnFocused, FActiveColumn{Col-1});
      end;
    end;  
    if not (gdSelected in State) and not (gdFixed in State) then begin
      Canvas.FillRect(Rect);
      Canvas.Brush.Style    := bsSolid;
      if GridDefs.RowHighlight.Active and (FInternalRecNo = TDataSet(Datasource.DataSet).RecNo) then begin
        Canvas.Brush.Color  := GridDefs.RowHighlight.BackColor;
        Canvas.Font.Color   := GridDefs.RowHighlight.TextColor;
      end else if GridDefs.RowColors.Active then begin
        if ((Rect.Top div (Rect.Bottom - Rect.Top + 1)) mod 2) = 0 then
          Canvas.Brush.Color  := GridDefs.RowColors.RowColor2
        else
          Canvas.Brush.Color  := GridDefs.RowColors.RowColor1;
      end;  
      Canvas.FillRect(Rect);
    end else if ((gdFocused in State) or (gdSelected in State)) and not (gdFixed in State) then begin
      Canvas.FillRect(Rect);
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := GridDefs.HighlightColor;
      Canvas.Font.Color  := GridDefs.HighlightFontColor;
      Canvas.FillRect(Rect);
    end;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
    if GridDefs.LocateOptions.HighlightWordFound then begin
      if (SearchText = '') or (Pos(UpperCase(SearchText), UpperCase(Column.Field.AsString)) <> 1) then exit;
      r1 := Rect; 
      r2 := Rect;
      s1 := Copy(Column.Field.AsString, 1, Length(SearchText));
      Canvas.FillRect(Rect);
      Canvas.Font.Color := GridDefs.LocateOptions.HighlightColorSelected;;
      Canvas.Font.Style := [fsbold];
      DrawText(Canvas.Handle, PChar(s1), Length(s1), r1, DT_CALCRECT);
      Canvas.TextOut(r1.Left+2, r2.Top+2, s1);
      Canvas.Font.Assign(Font);
      if (gdFocused in State) and not (gdFixed in State) then
        Canvas.Font.Color := GridDefs.LocateOptions.HighlightColorUnSelected
      else if not Focused then begin
        Canvas.FillRect(Rect);
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := GridDefs.HighlightColor;
        Canvas.Font.Color  := GridDefs.HighlightFontColor;
        Canvas.FillRect(Rect);
        DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
      s2      := StringReplace(Column.Field.AsString, s1, '', []);
      r2.Left := r1.Right-1;
      r2.Left := r2.Left+2;
      r2.Top  := r2.Top+2;
      DrawText(Canvas.Handle, PChar(s2), Length(s2), r2, 0);
    end;
  finally
    EndUpdate;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.ColExit;
begin
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.ColEnter;
begin
  FActiveColumn := (Col-1);
  DoPaintColorTitles;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.DoPaintColorTitles;
var
  iIndex : longint;
begin
  BeginUpdate;
  if GridDefs.ColumnsColors.Active and (Columns.Count > 0) then begin
    for iIndex := 0 to (Columns.Count-1) do
      SetGridColumn(GridDefs.ColumnsColors.GridColumnUnSelected, iIndex);
    if not GridDefs.LocateOptions.AutoSetFieldName then begin
      if GridDefs.LocateOptions.Active then
        SetGridColumn(GridDefs.ColumnsColors.GridColumnSelected, IndexLocateFieldName);
      if (FActiveColumn <> IndexLocateFieldName) then
        SetGridColumn(GridDefs.ColumnsColors.HighlightColumnFocused, FActiveColumn);
    end else
      SetGridColumn(GridDefs.ColumnsColors.HighlightColumnFocused, FActiveColumn);
  end;
  EndUpdate;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.TitleClick(Column: TColumn);
begin
  Col := Column.Index+1;
  if not GridDefs.LocateOptions.AutoSetFieldName and
     GridDefs.LocateOptions.Active then
     GridDefs.LocateOptions.FieldName := Column.FieldName;
  ColEnter;
  inherited TitleClick(Column);
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.IndexLocateFieldName : longint;
var
  iIndex : longint;
begin
  Result := -1;
  for iIndex := 0 to (Columns.Count-1) do begin
    if (Columns[iIndex].FieldName = GridDefs.Locateoptions.FieldName) then begin
      Result := iIndex;
      Break;
    end;  
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.SetGridColumn(oGridColumnsDefs : TadGridColumnsDefs; iIndex : longint);
begin
  if (Columns.Count > 0) and (iIndex >= 0) and (iIndex <= (Columns.Count-1)) then begin
    Columns[iIndex].Alignment       := oGridColumnsDefs.Alignment;
    Columns[iIndex].Color           := oGridColumnsDefs.Color;
    Columns[iIndex].Font.Assign(oGridColumnsDefs.Font);
    Columns[iIndex].Title.Alignment := oGridColumnsDefs.TitleAlignment;
    Columns[iIndex].Title.Color     := oGridColumnsDefs.TitleColor;
    Columns[iIndex].Title.Font.Assign(oGridColumnsDefs.TitleFont);
  end;
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.ActiveCol : longint;
begin
  Result := FActiveColumn;
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.ActiveRow : longint;
begin
  Result := Row;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  RowCol  : TGridCoord;
begin
  if Focused and GridDefs.ChangeRowColOnMouseMove then begin
    RowCol := MouseCoord(X, Y);
    if (RowCol.X <> Col) and (RowCol.X in [1..ColCount]) then begin
      Col  := RowCol.X;
      ColEnter;
    end;  
    if (RowCol.Y <> Row) and (RowCol.Y in [1..RowCount]) then begin
      if (RowCol.Y < Row) then
        Perform(WM_KeyDown, VK_UP, 0)
      else if (RowCol.Y > Row) then
        Perform(WM_KeyDown, VK_DOWN, 0);
      DoInternalRecno;
    end; 
  end;
end;

// -----------------------------------------------------------------------------

function TadDBGridEX.HighlightCell(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState): boolean;
begin
  Result := inherited HighlightCell(ActiveCol, ActiveRow, Value, AState);
  if not FColumnsLoaded then begin
    FColumnsLoaded  := True;
    FActiveColumn   := DataCol;
    DoPaintColorTitles;
    DoInternalRecno;
    inherited ColEnter;
  end;  
  if Assigned(FOnHighlightCell) then
    FOnHighlightCell(ActiveCol, ActiveRow, Value, AState);
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.SetGridDefs(Value : TadGridDefs);
begin
  FGridDefs.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.ProcessSearchKey(Key: Char);
var
  TickCount : Integer;
  S         : string;
  {$IFNDEF LINUX}
  CharMsg   : TMsg;
  {$ENDIF}
begin
  case Key of
    #8, #27  : SearchText := '';
    #32..#255:
    begin
      if not Assigned(FField) and (GridDefs.LocateOptions.Active) and 
         (GridDefs.LocateOptions.FieldName <> '') and Assigned(DataSource) and 
         Assigned(DataSource.DataSet) then
        FField := DataSource.DataSet.FindField(GridDefs.LocateOptions.FieldName);
      if (not (dgEditing in Options) or ReadOnly) and Assigned(FField) and 
        (FField.FieldKind in [fkData, fkInternalCalc]) {and
        (FField.DataType in [ftString, ftWideString])} then begin
        if not (DataSource.DataSet.State in [dsEdit, dsInsert]) then begin
          TickCount := GetTickCount;
          if ((TickCount - SearchTickCount) > GridDefs.LocateOptions.TickCount) then 
            SearchText := '';
          SearchTickCount := TickCount;
          {$IFNDEF LINUX}
          //if SysLocale.FarEast and (Key in LeadBytes) then begin
            if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then begin
              if (CharMsg.Message = WM_Quit) then begin
                PostQuitMessage(CharMsg.wparam);
                Exit;
              end;
              SearchText := SearchText + Key;
              Key := Char(CharMsg.wParam);
            end;
          //end;  
          {$ELSE}
            SearchText := SearchText + Key;
          {$ENDIF}
          if (Length(SearchText) < GridDefs.LocateOptions.MaxLength) then begin
            {$IFDEF LINUX}
            FTimer.Enabled := False;
            {$ENDIF}
            S := SearchText + Key;
            try
              if DataSource.DataSet.Locate(GridDefs.LocateOptions.FieldName, S, GridDefs.LocateOptions.Options) then
                SearchText := S
              else begin
                SearchText := '';
                Invalidate;
              end;  
            except
              SearchText := S;
            end;
            {$IFDEF LINUX}
            FTimer.Enabled := True;
            {$ENDIF}
          end;
        end;
      end;  
    end;
  end;
end;

// TadLocateOptions ------------------------------------------------------------

constructor TadLocateOptions.Create(AOwner : TComponent{TadDBGridEX});
begin
  inherited Create;
  Owner                     := AOwner;
  FActive                   := False;
  FFieldName                := '';
  FOptions                  := [loCaseInsensitive, loPartialKey];
  FTickCount                := 650;
  FMaxLength                := 32;
  FHighlightWordFound       := True;
  FHighlightColorSelected   := clRed;
  FHighlightColorUnSelected := clYellow;
  FAutoSetFieldName         := False;
end;

// -----------------------------------------------------------------------------

destructor TadLocateOptions.Destroy;
begin
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadLocateOptions) then begin
    FActive                   := TadLocateOptions(Source).FActive;
    FFieldName                := TadLocateOptions(Source).FFieldName;
    FOptions                  := TadLocateOptions(Source).FOptions;
    FTickCount                := TadLocateOptions(Source).FTickCount;
    FMaxLength                := TadLocateOptions(Source).FMaxLength;
    FHighlightWordFound       := TadLocateOptions(Source).FHighlightWordFound;
    FHighlightColorSelected   := TadLocateOptions(Source).FHighlightColorSelected;
    FHighlightColorUnSelected := TadLocateOptions(Source).FHighlightColorUnSelected;
    FAutoSetFieldName         := TadLocateOptions(Source).FAutoSetFieldName;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.SetHighlightColorSelected(Value : TColor);
begin
  if (FHighlightColorSelected <> Value) then begin
    FHighlightColorSelected := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.SetHighlightColorUnSelected(Value : TColor);
begin
  if (FHighlightColorUnSelected <> Value) then begin
    FHighlightColorUnSelected := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.SetFieldName(Value : string);
begin
  if (FFieldName <> Value) then begin
    FFieldName      := Value;
    if Owner.InheritsFrom(TadDBGridEX) then begin
      with TadDBGridEX(Owner) do begin
        SearchText  := '';
        FField      := nil;
        if (Trim(FFieldName) = '') then
          Active := False
        else if (csDesigning in ComponentState) and (Trim(FFieldName) <> '') then
          Active := True;
        DoPaintColorTitles;
        Invalidate;    
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.SetAutoSetFieldName(Value : boolean);
begin
  if (FAutoSetFieldName <> Value) then begin
    FAutoSetFieldName := Value and FActive;
    if Owner.InheritsFrom(TadDBGridEX) then begin
      with TadDBGridEX(Owner) do begin
        DoPaintColorTitles;
        Invalidate;    
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLocateOptions.SetActive(Value : boolean);
begin
  if (FActive <> Value) then begin
    FActive := Value;
    if Owner.InheritsFrom(TadDBGridEX) then begin
      with TadDBGridEX(Owner) do begin
        if FActive then begin
          Options   := Options - [dgEditing];
          ReadOnly  := FActive;
          if (Trim(FieldName) = '') and (FActiveColumn >= 0) then
            FieldName := Columns[FActiveColumn].FieldName;
        end else
          FAutoSetFieldName := False;
        DoPaintColorTitles;
        Invalidate;    
      end;
    end;  
  end;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLocateOptions.TimerEvent(Sender: TObject);
begin
  SearchText      := '';
  FTimer.Enabled  := False;
end;
{$ENDIF}

// TadRowColors ----------------------------------------------------------------

constructor TadRowColors.Create(AOwner : TComponent{TadDBGridEX});
begin
  inherited Create;
  Owner       := AOwner;
  FActive     := False;
  FRowColor1  := clRowColor1;
  FRowColor2  := clRowColor2;
end;  

// -----------------------------------------------------------------------------

destructor TadRowColors.Destroy;
begin
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadRowColors.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadRowColors) then begin
    FActive     := TadRowColors(Source).FActive;
    FRowColor1  := TadRowColors(Source).FRowColor1;   
    FRowColor2  := TadRowColors(Source).FRowColor2;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowColors.SetRowColor1(Value : TColor);
begin
  if (FRowColor1 <> Value) then begin
    FRowColor1 := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowColors.SetRowColor2(Value : TColor); 
begin
  if (FRowColor2 <> Value) then begin
    FRowColor2 := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowColors.SetActive(Value : boolean);
begin
  if (FActive <> Value) then begin
    FActive := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// TadRowHighlight -------------------------------------------------------------

constructor TadRowHighlight.Create(AOwner : TComponent{TadDBGridEX});
begin
  inherited Create;
  Owner       := AOwner;
  FActive     := False;
  FBackColor  := clRowHighlight;
  FTextColor  := clWindowText;
end;  

// -----------------------------------------------------------------------------

destructor TadRowHighlight.Destroy;
begin
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadRowHighlight.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadRowHighlight) then begin
    FActive     := TadRowHighlight(Source).FActive;
    FBackColor  := TadRowHighlight(Source).FBackColor;
    FTextColor  := TadRowHighlight(Source).FTextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowHighlight.SetBackColor(Value : TColor);
begin
  if (FBackColor <> Value) then begin
    FBackColor := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowHighlight.SetTextColor(Value : TColor);
begin
  if (FTextColor <> Value) then begin
    FTextColor := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadRowHighlight.SetActive(Value : boolean);
begin
  if (FActive <> Value) then begin
    FActive := Value;
    if Owner.InheritsFrom(TadDBGridEX) then begin
      with TadDBGridEX(Owner) do begin
        if (dgRowSelect in Options) then
          FActive := False;
        Invalidate;    
      end;
    end;  
  end;
end;

// TadGridDefs ----------------------------------------------------------------

constructor TadGridDefs.Create(AOwner : TComponent{TadDBGridEX});
begin
  inherited Create;
  Owner                     := AOwner;
  FLocateOptions            := TadLocateOptions.Create(AOwner);
  FRowColors                := TadRowColors.Create(AOwner);
  FRowHighlight             := TadRowHighlight.Create(AOwner);
  FHighlightColor           := clNavy;
  FHighlightFontColor       := clWhite;
  FGridColumnsColors        := TadGridColumnsColors.Create(AOwner);
  FChangeRowColOnMouseMove  := False;
end;  

// -----------------------------------------------------------------------------

destructor TadGridDefs.Destroy;
begin
  FreeAndNil(FLocateOptions);
  FreeAndNil(FRowColors);
  FreeAndNil(FRowHighlight);
  FreeAndNil(FGridColumnsColors);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadGridDefs) then begin
    FHighlightColor          := TadGridDefs(Source).FHighlightColor;
    FHighlightFontColor      := TadGridDefs(Source).FHighlightFontColor;
    FChangeRowColOnMouseMove := TadGridDefs(Source).FChangeRowColOnMouseMove;
    FLocateOptions.Assign(TadGridDefs(Source).FLocateOptions);
    FRowColors.Assign(TadGridDefs(Source).FRowColors);
    FRowHighlight.Assign(TadGridDefs(Source).FRowHighlight);
    FGridColumnsColors.Assign(TadGridDefs(Source).FGridColumnsColors);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.SetHighlightColor(Value : TColor);
begin
  if (FHighlightColor <> Value) then begin
    FHighlightColor := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.SetHighlightFontColor(Value : TColor);
begin
  if (FHighlightFontColor <> Value) then begin
    FHighlightFontColor := Value;
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.SetGridColumnsColors(Value : TadGridColumnsColors);
begin
  if (FGridColumnsColors <> Value) then begin
    FGridColumnsColors.Assign(Value);
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------
    
procedure TadGridDefs.SetLocateOptions(Value : TadLocateOptions);
begin
  FLocateOptions.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.SetRowColors(Value : TadRowColors);
begin
  FRowColors.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadGridDefs.SetRowHighlight(Value : TadRowHighlight);
begin
  FRowHighlight.Assign(Value);
end;
    
// TadGridColumnsDefs --------------------------------------------------------

constructor TadGridColumnsDefs.Create(AOwner: TComponent{TadDialogDefs});
begin
  inherited Create;
  Owner             := AOwner;
  FAlignment        := taLeftJustify;
  FColor            := clWindow;
  FFont             := TFont.Create;
  FTitleAlignment   := taCenter;
  FTitleColor       := clTitleColor;
  FTitleFont        := TFont.Create;
  FTitleFont.Style  := [fsBold];
end;

// -----------------------------------------------------------------------------

destructor TadGridColumnsDefs.Destroy;
begin
  if Assigned(FFont)      then FreeAndNil(FFont);
  if Assigned(FTitleFont) then FreeAndNil(FTitleFont);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsDefs.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadGridColumnsDefs) then begin
    FAlignment      := TadGridColumnsDefs(Source).FAlignment;
    FColor          := TadGridColumnsDefs(Source).FColor;
    FFont.Assign(TadGridColumnsDefs(Source).FFont);
    FTitleAlignment := TadGridColumnsDefs(Source).FTitleAlignment;
    FTitleColor     := TadGridColumnsDefs(Source).FTitleColor;
    FTitleFont.Assign(TadGridColumnsDefs(Source).FTitleFont);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsDefs.SetFont(Value : TFont);
begin
  FFont.Assign(Value);
  if Owner.InheritsFrom(TadDBGridEX) then begin
    with TadDBGridEX(Owner) do begin
      DoPaintColorTitles;
      Invalidate;    
    end;  
  end;  
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsDefs.SetTitleFont(Value : TFont);
begin
  FTitleFont.Assign(Value);
  if Owner.InheritsFrom(TadDBGridEX) then begin
    with TadDBGridEX(Owner) do begin
      DoPaintColorTitles;
      Invalidate;    
    end;  
  end;  
end;

// TadHighlightColumnFocused ---------------------------------------------------

constructor TadHighlightColumnFocused.Create(AOwner: TComponent{TadDialogDefs});
begin
  inherited Create(AOwner);
  TitleColor := clHighlightColumnFocused;
end;

// TadGridColumnsColors ----------------------------------------------------------------

constructor TadGridColumnsColors.Create(AOwner : TComponent{TadDBGridEX});
begin
  inherited Create;
  Owner                                 := AOwner;
  FActive                               := False;
  FHighlightColumnFocused               := TadHighlightColumnFocused.Create(AOwner);
  FHighlightColumnFocused.TitleColor    := clHighlightColumnFocused;
  FGridColumnSelected                   := TadGridColumnsDefs.Create(AOwner);
  FGridColumnSelected.TitleColor        := clYellow;
  FGridColumnUnSelected                 := TadGridColumnsDefs.Create(AOwner);
  FGridColumnUnSelected.TitleColor      := clTitleColor;
  FGridColumnUnSelected.TitleFont.Color := clTitleFontColor;
end;  

// -----------------------------------------------------------------------------

destructor TadGridColumnsColors.Destroy;
begin
  FreeAndNil(FHighlightColumnFocused);
  FreeAndNil(FGridColumnSelected);
  FreeAndNil(FGridColumnUnSelected);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsColors.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadGridColumnsColors) then begin
    FActive := TadGridColumnsColors(Source).FActive;
    FHighlightColumnFocused.Assign(TadGridColumnsColors(Source).FHighlightColumnFocused);
    FGridColumnSelected.Assign(TadGridColumnsColors(Source).FGridColumnSelected);
    FGridColumnUnSelected.Assign(TadGridColumnsColors(Source).FGridColumnUnSelected);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsColors.SetHighlightColumnFocused(Value : TadHighlightColumnFocused);
begin
  if (FHighlightColumnFocused <> Value) then begin
    FHighlightColumnFocused.Assign(Value);
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsColors.SetGridColumnSelected(Value : TadGridColumnsDefs);
begin
  if (FGridColumnSelected <> Value) then begin
    FGridColumnSelected.Assign(Value);
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsColors.SetGridColumnUnSelected(Value : TadGridColumnsDefs);
begin
  if (FGridColumnUnSelected <> Value) then begin
    FGridColumnUnSelected.Assign(Value);
    if Owner.InheritsFrom(TadDBGridEX) then
      TadDBGridEX(Owner).Invalidate;    
  end;
end;

// -----------------------------------------------------------------------------

procedure TadGridColumnsColors.SetActive(Value : boolean);
begin
  if (FActive <> Value) then begin
    FActive := Value;
    if Owner.InheritsFrom(TadDBGridEX) then begin
      with TadDBGridEX(Owner) do begin
        if FActive then
          DoPaintColorTitles
        else if not FActive then
          DoDefaultColumns;
        Invalidate;    
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDBGridEX.DoDefaultColumns;
var
  iIndex : longint;
begin
  for iIndex := 0 to Columns.Count-1 do begin
    Columns[iIndex].Alignment       := taLeftJustify;
    Columns[iIndex].Color           := Columns[iIndex].DefaultColor;
    Columns[iIndex].Font.Assign(Columns[iIndex].DefaultFont);
    Columns[iIndex].Title.Alignment := taLeftJustify;
    Columns[iIndex].Title.Color     := Columns[iIndex].Title.DefaultColor;
    Columns[iIndex].Title.Font.Assign(Columns[iIndex].Title.DefaultFont);
  end;
end;

// -----------------------------------------------------------------------------

end.
 