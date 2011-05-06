//==============================================================================
// Unit........: adLabelEdit.pas
// Created.....: 08/04/2005
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

unit adLabelEdit;

interface

{$I ActiveDelphi.inc}
   
uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QControls, QTypes, QGraphics,
{$ELSE}
     StdCtrls, Controls, Messages, Graphics,
{$ENDIF}
     adBoundLabel;

type

  //-----| Class: TadCustomLabelEdit

  TadCustomLabelEdit = class(TCustomEdit)
  private
    { Private declarations }
    FAbout          : string;
    FLabelDefs      : TadBoundLabel;
    FLabelPosition  : TadControlPosition;
    FLabelSpacing   : Integer;
    FColors         : TadColors;
    procedure SetColors(const Value : TadColors);
    procedure SetPosition(const Value: TadControlPosition);
    procedure SetSpacing(const Value: Integer);
  protected
    { Protected declarations }
{$IFDEF LINUX}
    procedure SetParent(const Value: TWidgetControl); override;
{$ELSE}     
    procedure SetParent(AParent: TWinControl); override;
{$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
{$IFDEF LINUX}
    procedure Visiblechanged; override;
    procedure EnabledChanged; override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
{$ELSE}     
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMVisiblechanged(var Message: TMessage);  message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);  message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$ENDIF}
    procedure DoEnter; override;
    procedure DoExit; override;
   public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetBounds(ALeft: integer; ATop: integer; AWidth: integer; AHeight: integer); override;
  published
    { Published declarations }
    property Align;
    {$IFNDEF VERSION3} 
    property Anchors; 
    {$ENDIF}
    property LabelDefs      : TadBoundLabel       read  FLabelDefs;
    property About          : string              read  FAbout          write FAbout;
    property LabelPosition  : TadControlPosition  read  FLabelPosition  write SetPosition  default adAboveLeft;
    property LabelSpacing   : integer             read  FLabelSpacing   write SetSpacing   default 3;
    property Colors         : TadColors           read  FColors         write SetColors;
  end;

  //-----| Class: TadLabelEdit

  TadLabelEdit = class(TadCustomLabelEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
   public
    { Public declarations }
  published
    { Published declarations }
    property AutoSelect;
    property AutoSize;
    {$IFNDEF VERSION3} 
    property Anchors;
    {$ENDIF}
    {$IFNDEF LINUX}
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property ImeMode;
    property ImeName;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentCtl3D;
    property PasswordChar;
    property OnEndDock;
    property OnStartDock;
    {$ELSE}
    property Alignment;
    property EchoMode;
    property OnKeyString;
    property OnReturnPressed;
    {$ENDIF}
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;
   
implementation

// TadCustomLabelEdit ----------------------------------------------------------------

constructor TadCustomLabelEdit.Create(AOwner: TComponent); 
begin
  inherited Create(AOwner);
  Width           := 145;
  FAbout          := '';
  FLabelPosition  := adAboveLeft;
  FLabelSpacing   := 3;
  FColors         := TadColors.Create;
  CreateLabelDefs(FLabelDefs, Self);
end;

// -----------------------------------------------------------------------------

destructor TadCustomLabelEdit.Destroy;
begin
  FreeAndNil(FColors);
  FreeAndNil(FLabelDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

{$IFNDEF LINUX}
procedure TadCustomLabelEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.BiDiMode := BiDiMode;
end;
{$ENDIF}

// -----------------------------------------------------------------------------
{$IFDEF LINUX}
procedure TadCustomLabelEdit.Visiblechanged;
{$ELSE}
procedure TadCustomLabelEdit.CMVisiblechanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Visible := Visible;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomLabelEdit.EnabledChanged;
{$ELSE}
procedure TadCustomLabelEdit.CMEnabledchanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Enabled := Enabled;
end;

// -----------------------------------------------------------------------------
{$IFDEF LINUX}
procedure TadCustomLabelEdit.MouseEnter(AControl: TControl);
{$ELSE}
procedure TadCustomLabelEdit.CMMouseEnter(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  DoEnter;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomLabelEdit.MouseLeave(AControl: TControl);
{$ELSE}
procedure TadCustomLabelEdit.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  DoExit;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.DoEnter;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) then begin
    Color       := Colors.WhenEnterFocus.BackColor;
    Font.Color  := Colors.WhenEnterFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.DoExit;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) and not Focused then begin
    Color       := Colors.WhenExitFocus.BackColor;
    Font.Color  := Colors.WhenExitFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.SetColors(const Value : TadColors);
begin
  if (FColors <> Value) then
    FColors.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLabelDefs) and (Operation = opRemove) then
    FLabelDefs := nil;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.SetPosition(const Value: TadControlPosition);
begin
  if Assigned(FLabelDefs) then
    FLabelDefs.AdjustPosition(Self, FLabelDefs, FLabelPosition, FLabelSpacing, Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.SetSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelEdit.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  SetLabelDefsCaption(FLabelDefs, Self, Value);
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomLabelEdit.SetParent(const Value: TWidgetControl);
begin
  inherited SetParent(Value);
  if Assigned(FLabelDefs) then begin
    FLabelDefs.Parent  := Value;
    FLabelDefs.Visible := True;
  end;
end;
{$ELSE}
procedure TadCustomLabelEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FLabelDefs) then begin
    FLabelDefs.Parent  := AParent;
    FLabelDefs.Visible := True;
  end;
end;
{$ENDIF}

// -----------------------------------------------------------------------------

end.
 