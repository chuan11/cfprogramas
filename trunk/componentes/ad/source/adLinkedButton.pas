//==============================================================================
// Unit........: adLinkedButton.pas
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

unit adLinkedButton;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
     StdCtrls, Controls, Messages, Buttons, Windows,
     adBoundLabel;

type

   //-----| Class: TadCustomLinkedButton

  TadCustomLinkedButton = class(TBitBtn)
  private
    FAbout            : string;
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
    procedure Resize; override;
    procedure MoveToPos; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure Click; override;
    property Height         : integer           read GetHeight        write SetHeight;
    property Width          : integer           read GetWidth         write SetWidth;
    property Left           : integer           read GetLeft;
    property Top            : integer           read GetTop;
    property LinkedControl  : TWinControl       read  FWinControl     write SetLinkedControl;
  published
    property Align;
    property About          : string            read   FAbout         write FAbout;
    property LinkedPosition : TadControlPosition  read  FLabelPosition  write SetPosition  default adAboveLeft;
    property LinkedSpacing  : integer           read  FSpacing        write SetSpacing        default 2;
  end;

   //-----| Class: TadLinkedButton
  
  TadLinkedButton = class(TadCustomLinkedButton)
  published
    property LinkedControl;
  end;
  
  procedure CreateLinkedButtonDefs(var FLinkedButtonDefs : TadCustomLinkedButton; Sender : TControl);

implementation

// TadCustomLinkedButton --------------------------------------------------------------

constructor TadCustomLinkedButton.Create(AOwner: tComponent);
begin
  inherited;
  FAbout            := '';
  FObjectInstance   := MakeObjectInstance(ControlWindowProc);
  FSpacing          := 3;
  FLabelPosition    := adAboveLeft;
  FOldLabelPosition := FLabelPosition;
end;

// -----------------------------------------------------------------------------

destructor TadCustomLinkedButton.Destroy;
begin
  if Assigned(FWinControl) then
    SetWindowLong(TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FOldWindowProc));
  FreeObjectInstance(FObjectInstance);
  FObjectInstance := nil;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.MoveToPos;
var
  pPoint : TPoint;
  //............................................................................  
  procedure CalculatePosition(FLinkedPosition : TadControlPosition);
  begin
    with FWinControl do begin
      Self.Visible   := (FLabelPosition <> adNone);
      if Self.Visible then begin
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
    CalculatePosition(FLabelPosition)
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FWinControl) then
    FWinControl := nil;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.ControlWindowProc(var msg: TMessage);
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

procedure TadCustomLinkedButton.SetLinkedControl(const Value: TWinControl);
begin
  if (Value <> Self) then begin
    if Assigned(FWinControl) then
      SetWindowLong(TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FOldWindowProc));
    FWinControl  := Value;
    if Assigned(FWinControl) then begin
      FWinControl.FreeNotification(Self);
      FOldWindowProc := TfnWndProc(SetWindowLong (TWinControl(FWinControl).Handle, GWL_WNDPROC, integer(FObjectInstance)));
      MoveToPos;                             
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.SetPosition(const Value: TadControlPosition);
begin
  if (FLabelPosition <> Value) then begin
    FOldLabelPosition := FLabelPosition;
    FLabelPosition    := Value;
    if Assigned(FWinControl) then
      MoveToPos;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.SetSpacing(const Value: integer);
begin
  if (FSpacing <> Value) then begin
    FSpacing := Value;
    if Assigned(FWinControl) then
      MoveToPos;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.Click;
begin
  inherited;
  if Assigned(FWinControl) then begin
    if FWinControl.CanFocus then
      FWinControl.SetFocus;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.Resize;
begin
  inherited;
  MoveToPos;
end;

procedure TadCustomLinkedButton.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg = WM_MOVE) then
    MoveToPos;
end;

// -----------------------------------------------------------------------------

function TadCustomLinkedButton.GetHeight: Integer;
begin
  Result := inherited Height;
end;

// -----------------------------------------------------------------------------

function TadCustomLinkedButton.GetLeft: Integer;
begin
  Result := inherited Left;
end;

// -----------------------------------------------------------------------------

function TadCustomLinkedButton.GetTop: Integer;
begin
  Result := inherited Top;
end;

// -----------------------------------------------------------------------------

function TadCustomLinkedButton.GetWidth: Integer;
begin
  Result := inherited Width;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLinkedButton.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

// -----------------------------------------------------------------------------

procedure CreateLinkedButtonDefs(var FLinkedButtonDefs : TadCustomLinkedButton; Sender : TControl);
begin
  if not Assigned(FLinkedButtonDefs) then begin
    FLinkedButtonDefs := TadCustomLinkedButton.Create(Sender);
    with FLinkedButtonDefs do begin
      Name        := 'Button';
      {$IFDEF VERSION6_OR_HIGHER}
      SetSubComponent(True);
      {$ENDIF}
      if Assigned(Sender) then
        Caption   := Sender.Name;
      FreeNotification(Sender);
      LinkedControl := TWinControl(Sender);
    end;
  end;
end;

end.
