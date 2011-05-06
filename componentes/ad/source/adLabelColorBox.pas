//==============================================================================
// Unit........: adLabelColorBox.pas
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

unit adLabelColorBox;

interface

{$I ActiveDelphi.inc}
  
uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
     StdCtrls, Controls, Messages, ExtCtrls,
     adBoundLabel;

type

  //-----| Class: TadLabelColorBox

  TadLabelColorBox = class(TColorBox)
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
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMVisiblechanged(var Message: TMessage);  message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);  message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DoEnter; override;
    procedure DoExit; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  published
    { Published declarations }
    property Align;
    property LabelDefs      : TadBoundLabel       read  FLabelDefs;
    property About          : string              read  FAbout          write FAbout;
    property LabelPosition  : TadControlPosition  read  FLabelPosition  write SetPosition  default adAboveLeft;
    property LabelSpacing   : integer             read  FLabelSpacing   write SetSpacing   default 3;
    property Colors         : TadColors           read  FColors         write SetColors;
  end;
   
implementation

// TadLabelColorBox ----------------------------------------------------------------

constructor TadLabelColorBox.Create(AOwner: TComponent); 
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

destructor TadLabelColorBox.Destroy;
begin
  FreeAndNil(FColors);
  FreeAndNil(FLabelDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------
procedure TadLabelColorBox.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.BiDiMode := BiDiMode;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Enabled := Enabled;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Visible := Visible;
end;

// -----------------------------------------------------------------------------
procedure TadLabelColorBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoEnter;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  DoExit;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.DoEnter;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) then begin
    Color       := Colors.WhenEnterFocus.BackColor;
    Font.Color  := Colors.WhenEnterFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.DoExit;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) and not Focused then begin
    Color       := Colors.WhenExitFocus.BackColor;
    Font.Color  := Colors.WhenExitFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetColors(const Value : TadColors);
begin
  if (FColors <> Value) then
    FColors.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLabelDefs) and (Operation = opRemove) then
    FLabelDefs := nil;
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetPosition(const Value: TadControlPosition);
begin
  if Assigned(FLabelDefs) then
    FLabelDefs.AdjustPosition(Self, FLabelDefs, FLabelPosition, FLabelSpacing, Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  SetLabelDefsCaption(FLabelDefs, Self, Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelColorBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FLabelDefs) then begin
    FLabelDefs.Parent  := AParent;
    FLabelDefs.Visible := True;
  end;
end;

// -----------------------------------------------------------------------------

end.
 