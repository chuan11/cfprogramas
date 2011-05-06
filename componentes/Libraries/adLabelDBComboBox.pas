//==============================================================================
// Unit........: adLabelDBComboBox.pas
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

unit adLabelDBComboBox;

interface

{$I ActiveDelphi.inc}
   
uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QControls, QTypes, QDBCtrls,
{$ELSE}
     StdCtrls, Controls, Messages, DBCtrls,
{$ENDIF}
     adBoundLabel;

type

   //-----| Class: TadLabelDBComboBox

  TadLabelDBComboBox = class(TDBComboBox)
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

// TadLabelDBComboBox ----------------------------------------------------------------

constructor TadLabelDBComboBox.Create(AOwner: TComponent); 
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

destructor TadLabelDBComboBox.Destroy;
begin
  FreeAndNil(FColors);
  FreeAndNil(FLabelDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

{$IFNDEF LINUX}
procedure TadLabelDBComboBox.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.BiDiMode := BiDiMode;
end;
{$ENDIF}

// -----------------------------------------------------------------------------
{$IFDEF LINUX}
procedure TadLabelDBComboBox.Visiblechanged;
{$ELSE}
procedure TadLabelDBComboBox.CMVisiblechanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Visible := Visible;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLabelDBComboBox.EnabledChanged;
{$ELSE}
procedure TadLabelDBComboBox.CMEnabledchanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Enabled := Enabled;
end;

// -----------------------------------------------------------------------------
{$IFDEF LINUX}
procedure TadLabelDBComboBox.MouseEnter(AControl: TControl);
{$ELSE}
procedure TadLabelDBComboBox.CMMouseEnter(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  DoEnter;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLabelDBComboBox.MouseLeave(AControl: TControl);
{$ELSE}
procedure TadLabelDBComboBox.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  DoExit;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.DoEnter;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) then begin
    Color       := Colors.WhenEnterFocus.BackColor;
    Font.Color  := Colors.WhenEnterFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.DoExit;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) and not Focused then begin
    Color       := Colors.WhenExitFocus.BackColor;
    Font.Color  := Colors.WhenExitFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.SetColors(const Value : TadColors);
begin
  if (FColors <> Value) then
    FColors.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLabelDefs) and (Operation = opRemove) then
    FLabelDefs := nil;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.SetPosition(const Value: TadControlPosition);
begin
  if Assigned(FLabelDefs) then
    FLabelDefs.AdjustPosition(Self, FLabelDefs, FLabelPosition, FLabelSpacing, Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.SetSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBComboBox.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  SetLabelDefsCaption(FLabelDefs, Self, Value);
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLabelDBComboBox.SetParent(const Value: TWidgetControl);
begin
  inherited SetParent(Value);
  if Assigned(FLabelDefs) then begin
    FLabelDefs.Parent  := Value;
    FLabelDefs.Visible := True;
  end;
end;
{$ELSE}
procedure TadLabelDBComboBox.SetParent(AParent: TWinControl);
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
 