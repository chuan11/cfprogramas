//==============================================================================
// Unit........: adLinkedLabel.pas
// Created.....: 08/04/2005
// Type Unit...: Windows Only
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

unit adLinkedLabel;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
     StdCtrls, Controls, Messages, Windows,
     adBoundLabel;

type

  //-----| Class: TadLinkedLabel

  TadLinkedLabel = class(TLabel)
  private
    FAbout              : string;
    FLabelPosition    : TadControlPosition;
    FOldLabelPosition : TadControlPosition;
    FWinControl       : TWinControl;
    FObjectInstance   : Pointer;
    FOldWindowProc    : Pointer;
    FSpacing          : integer;
    procedure SetSpacing(const Value : integer);
    procedure SetPosition(const Value: TadControlPosition);
    procedure ControlWindowProc(var msg: TMessage);
    procedure SetLinkedControl(const Value : TWinControl);
    function  GetTop: Integer;
    function  GetLeft: Integer;
    function  GetWidth: Integer;
    function  GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Click; override;
    procedure Resize; override;
    procedure MoveToPos; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    property Height         : integer           read GetHeight      write SetHeight;
    property Width          : integer           read GetWidth       write SetWidth;
    property Left           : integer           read GetLeft;
    property Top            : integer           read GetTop;
  published
    property Align;
    property About          : string            read   FAbout          write FAbout;
    property LinkedControl  : TWinControl        read  FWinControl       write SetLinkedControl;
    property LinkedPosition : TadControlPosition   read  FLabelPosition write SetPosition default adAboveLeft;
    property LinkedSpacing  : integer            read  FSpacing          write SetSpacing  default 2;
  end;

implementation

// TadLinkedLabel --------------------------------------------------------------

constructor TadLinkedLabel.Create(AOwner: tComponent);
begin
  inherited;
  FAbout             := '';
  Layout            := tlCenter;
  FObjectInstance   := MakeObjectInstance(ControlWindowProc);
  FSpacing          := 3;
  FLabelPosition    := adAboveLeft;
  FOldLabelPosition := FLabelPosition;
end;

// -----------------------------------------------------------------------------

destructor TadLinkedLabel.Destroy;
begin
  if Assigned(FWinControl) then
    SetWindowLong(TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FOldWindowProc));
  FreeObjectInstance(FObjectInstance);
  FObjectInstance := nil;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.Paint;
begin
  if Self.Visible then
    inherited Paint;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.MoveToPos;
var
  pPoint : TPoint;
  //............................................................................  
  procedure CalculatePosition(FLinkedPosition : TadControlPosition);
  begin
    with FWinControl do begin
      Self.Visible   := (FLabelPosition <> adNone);
      if Self.Visible then begin
        if (FLinkedPosition in [adLeft, adAboveRight, adBelowRight]) then
          Alignment := taRightJustify
        else
          Alignment := taLeftJustify;
        case FLinkedPosition of
          adAboveLeft : pPoint := Point(Left, Top - Self.Height - FSpacing);
          adAboveRight: pPoint := Point((Left+Width)-Self.Width, Top - Self.Height - FSpacing);
          adBelowLeft : pPoint := Point(Left, Top + Height + FSpacing);
          adBelowRight: pPoint := Point((Left+Width)-Self.Width, Top + Height + FSpacing);
          adLeft      : pPoint := Point(Left - Self.Width - FSpacing, Top + ((Height - Self.Height) div 2));
          adRight     : pPoint := Point(Left + Width + FSpacing, Top + ((Height - Self.Height) div 2));
        end;
        Self.SetBounds(pPoint.x, pPoint.y, Self.Width, Self.Height);
      end;
    end;
  end;
  //............................................................................  
begin
  if Assigned(FWinControl) then
    CalculatePosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FWinControl) then
    FWinControl := nil;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.ControlWindowProc(var msg: TMessage);
begin
  if (msg.Msg = WM_ENABLE) then
      Enabled := FWinControl.Enabled;
  if (msg.Msg = WM_MOVE) then
    MoveToPos;
  if (msg.Msg = WM_SIZE) then
    MoveToPos;
  if (msg.Msg = WM_DESTROY) then
    SetWindowLong (TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FOldWindowProc));
  msg.result := CallWindowProc (fOldWindowProc, TWinControl(FWinControl).Handle, msg.msg, msg.wParam, msg.lParam);
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.SetLinkedControl(const Value: TWinControl);
begin
  if (Value <> FWinControl) then begin
    if Assigned(FWinControl) then
      SetWindowLong(TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FOldWindowProc));
    FWinControl  := Value;
    FocusControl    := Value;
    if Assigned(FWinControl) then begin
      FWinControl.FreeNotification(Self);
      FOldWindowProc := TfnWndProc(SetWindowLong (TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FObjectInstance)));
      MoveToPos;                             
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.SetPosition(const Value: TadControlPosition);
begin
   FOldLabelPosition := FLabelPosition;
   FLabelPosition    := Value;
   if Assigned(FWinControl) then
      MoveToPos;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.SetSpacing(const Value: integer);
begin
  if (FSpacing <> Value) then begin
    FSpacing := Value;
    if Assigned(FWinControl) then
      MoveToPos;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.Click;
begin
  inherited;
  if Assigned(FWinControl) then begin
    if FWinControl.CanFocus then
      FWinControl.SetFocus;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.Resize;
begin
  inherited;
  MoveToPos;
end;

// -----------------------------------------------------------------------------

function TadLinkedLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

// -----------------------------------------------------------------------------

function TadLinkedLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

// -----------------------------------------------------------------------------

function TadLinkedLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

// -----------------------------------------------------------------------------

function TadLinkedLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

// -----------------------------------------------------------------------------

procedure TadLinkedLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

// -----------------------------------------------------------------------------

end.
