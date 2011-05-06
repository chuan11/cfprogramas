//==============================================================================
// Unit........: adLabelSpinEdit.pas
// Created.....: 18/05/2005
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

unit adLabelSpinEdit;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QControls, QTypes, QGraphics, QDialogs, QForms, {Qt, Libc}
{$ELSE}
     StdCtrls, Controls, Messages, Graphics, Dialogs, Forms, Windows,
{$ENDIF}
     adLabelNumericEdit, Spin;
     
type
  
  TadLabelSpinEdit = class(TadCustomLabelNumericEdit)
  private
    { Private declarations }
    FButton         : TSpinButton;
    FIncrement      : extended;
    TempIncrement   : extended;
    FEditorEnabled  : Boolean;
    FWrap           : Boolean;
    FRoundValues    : Boolean;
    ClickTime       : DWord;
    RepeatCount     : integer;
    function GetCursor : TCursor;
    function GetMinHeight: Integer;
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
    procedure SetCursor(Value : TCursor);
    procedure SetIncrement(Value : extended);
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure DoExit; override;
    procedure DownClick (Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure UpClick (Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DownStep;
    procedure RoundValue;
    procedure UpStep;
  published
    { Published declarations }
    property Value;
    property Cursor       : TCursor   read  GetCursor       write SetCursor;
    property EditorEnabled: Boolean   read  FEditorEnabled  write FEditorEnabled  default True;
    property Increment    : extended  read  FIncrement      write SetIncrement;
    property RoundValues  : Boolean   read  FRoundValues    write FRoundValues;
    property Wrap         : Boolean   read  FWrap           write FWrap;
  end;

implementation

// -----------------------------------------------------------------------------

constructor TadLabelSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpinButton.Create(Self);
  FButton.Parent := Self;
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  TempIncrement := 1;
  FEditorEnabled := True;
  FRoundValues := False;
  FWrap := False;
  ClickTime := 0;
  RepeatCount := 0;
end;

// -----------------------------------------------------------------------------

destructor TadLabelSpinEdit.Destroy;
begin
  FButton.Free;
  FButton := nil;
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (not ReadOnly) then
  begin
    if Key = VK_UP then UpClick (Self)
    else if Key = VK_DOWN then DownClick (Self);
    inherited KeyDown(Key, Shift);
  end
  else
  begin
    MessageBeep(0);
    Key := 0;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  TempIncrement := FIncrement;
  RepeatCount := 0;
  if (not ReadOnly) then inherited KeyUp(Key, Shift)
  else Key := 0;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.KeyPress(var Key: Char);
begin
  if FEditorEnabled then inherited KeyPress(Key)
  else
  begin
    MessageBeep(0);
    Key := #0;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.SetEditRect;
var
  Loc: TRect;
  BorderWidth, DX : integer;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  if (BorderStyle = bsSingle) and Ctl3D then BorderWidth := 2
  else if (BorderStyle = bsSingle) then BorderWidth := 1
  else BorderWidth := 0;
  if (BorderStyle = bsNone) then DX := -2
  else DX := 1;
  Loc.Right := ClientWidth - FButton.Width - BorderWidth + DX;
  Loc.Top := 2 - BorderWidth;
  Loc.Left := 2;
  SendMessage(Handle, EM_SETRECT, 0, LongInt(@Loc));
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight, BorderWidth, Delta : Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
    { text edit bug: if size is less than minheight, then edit ctrl does
      not display the text }
  if Height < MinHeight then Height := MinHeight
  else if FButton <> nil then
  begin
    Delta := 0;
    if (BorderStyle = bsSingle) then
    begin
      if Ctl3D then BorderWidth := 2
      else
      begin
        BorderWidth := 1;
        Delta := 1;
      end;
    end
    else BorderWidth := 0;
    FButton.SetBounds(ClientWidth - FButton.Width - Delta, Delta, FButton.Width, Height - BorderWidth * 2 - 1);
    SetEditRect;
  end;
end;

// -----------------------------------------------------------------------------

function TadLabelSpinEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.UpClick (Sender: TObject);
begin
  if ReadOnly and (Sender = FButton) then MessageBeep(0)
  else
  begin
    if GetTickCount - ClickTime > 200 then
    begin
      TempIncrement := FIncrement;
      RepeatCount := 0;
    end
    else if TempIncrement < (MaxValue - MinValue) / 5 then
    begin
      Inc(RepeatCount);
      if (RepeatCount > 4) and (RepeatCount mod 2 = 0) then TempIncrement := TempIncrement + FIncrement;
    end;
    ClickTime := GetTickCount;
    if (Value < MinValue) and ((MinValue <> 0) or (MaxValue <> 0)) then InvalidEntry
    else if (Value + TempIncrement <= MaxValue) or ((MinValue = 0) and (MaxValue = 0)) then Value := Value + TempIncrement
    else if FWrap then Value := MinValue
    else if (Value + FIncrement <= MaxValue) or ((MinValue = 0) and (MaxValue = 0)) then
    begin
      TempIncrement := FIncrement;
      Value := Value + TempIncrement;
    end
    else InvalidEntry;
    if FRoundValues then RoundValue;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly and (Sender = FButton) then MessageBeep(0)
  else
  begin
    if GetTickCount - ClickTime > 200 then
    begin
      TempIncrement := FIncrement;
      RepeatCount := 0;
    end
    else if TempIncrement < (MaxValue - MinValue) / 5 then
    begin
      Inc(RepeatCount);
      if (RepeatCount > 4) and (RepeatCount mod 2 = 0) then TempIncrement := TempIncrement + FIncrement;
    end;
    ClickTime := GetTickCount;
    if (Value > MaxValue) and ((MinValue <> 0) or (MaxValue <> 0)) then InvalidEntry
    else if (Value - TempIncrement >= MinValue) or ((MinValue = 0) and (MaxValue = 0)) then Value := Value - TempIncrement
    else if FWrap then Value := MaxValue
    else if (Value - FIncrement >= MinValue) or ((MinValue = 0) and (MaxValue = 0)) then
    begin
      TempIncrement := FIncrement;
      Value := Value - TempIncrement;
    end
    else InvalidEntry;
    if FRoundValues then RoundValue;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.DoExit;
begin
  if FRoundValues and (Value >= MinValue) and (Value <= MaxValue)
    or ((MinValue = 0) and (MaxValue = 0)) then RoundValue;
  inherited DoExit;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.RoundValue;
var
  X : extended;
begin
  X := Round((Value - MinValue) / FIncrement);
  Value := MinValue + X * FIncrement;
  if (Value > MaxValue) and ((MinValue <> 0) or (MaxValue <> 0)) then Value := Value - FIncrement;
end;

// -----------------------------------------------------------------------------

function TadLabelSpinEdit.GetCursor : TCursor;
begin
  Result := inherited Cursor;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.SetCursor(Value : TCursor);
begin
  if inherited Cursor <> Value then
  begin
    inherited Cursor := Value;
    FButton.Cursor := Value;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.SetIncrement(Value : extended);
begin
  if (FIncrement <> Value) then
  begin
    if (Value <= MaxValue - MinValue) or ((MinValue = 0) and (MaxValue = 0)) then
    begin
      FIncrement := Value;
      TempIncrement := Value;
      if FRoundValues then RoundValue;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.DownStep;
begin
  if (Value > MaxValue) and ((MinValue <> 0) or (MaxValue <> 0)) then InvalidEntry
  else if (Value - FIncrement >= MinValue) or ((MinValue = 0) and (MaxValue = 0)) then Value := Value - FIncrement
  else if FWrap then Value := MaxValue
  else InvalidEntry;
  if FRoundValues then RoundValue;
end;

// -----------------------------------------------------------------------------

procedure TadLabelSpinEdit.UpStep;
begin
  if (Value < MinValue) and ((MinValue <> 0) or (MaxValue <> 0)) then InvalidEntry
  else if (Value + FIncrement <= MaxValue) or ((MinValue = 0) and (MaxValue = 0))
    then Value := Value + FIncrement
  else if FWrap then Value := MinValue
  else InvalidEntry;
  if FRoundValues then RoundValue;
end;

// -----------------------------------------------------------------------------

end.

