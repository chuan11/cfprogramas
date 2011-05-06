//==============================================================================
// Unit........: adLabelNumericEdit.pas
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
// 09/05/2005 - Alteração feita por Dennys S. Sobrinho.
//              Foi necessário verificar se a variável RESUL estava diferente 
//              de "vazio" para corrigir um erro: Access Violation.
// 18/05/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit adLabelNumericEdit;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QControls, QTypes, QGraphics, QForms, Qt,{ Libc}
{$ELSE}
     StdCtrls, Controls, Messages, Graphics, Forms, Windows,
{$ENDIF}
     adLabelEdit, Clipbrd;

{$IFNDEF LINUX}
const
  PB_SETTINGCHANGE = WM_USER + 147;
{$ENDIF}

type

  TadNumberFormat = (nfStandard, nfThousands, nfScientific, nfEngineering);
  
  //-----| Class: TadCustomLabelNumericEdit
  
  TadCustomLabelNumericEdit = class(TadCustomLabelEdit)
  private
    { Private declarations }
    FAlignment      : TAlignment;
    FDecimals       : ShortInt;
    FEnter          : Boolean;
    FParentColor    : Boolean;
    FInvalidEntry   : TNotifyEvent;
    FMaxValue       : Extended;
    FMinValue       : Extended;
    FFormat         : TadNumberFormat;
    FDisabledColor  : TColor;
    FEnabledColor   : TColor;
    OldDecimalSep   : Char;
    OldThousandSep  : Char;
    FOnClear        : TNotifyEvent;
    function FormatText(Value: Extended): string;
    function GetAsCurrency: Currency;
    function GetAsFloat: Extended;
    function GetAsInteger: Integer;
    function GetValue: Extended;
    function RemoveThousands(Value : string): string;
    function ReplaceSeparators(Value : string) : string;
    procedure DeleteKey(Key: Word);
    procedure DeleteSelection;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAsCurrency(Value: Currency);
    procedure SetAsFloat(Value: Extended);
    procedure SetAsInteger(Value: Integer);
    procedure SetColor(Value : TColor);
    procedure SetDisabledColor(Value : TColor);
    procedure SetDecimals(Value: ShortInt);
    procedure SetMaxValue(Value: Extended);
    procedure SetMinValue(Value: Extended);
    procedure SetFormat(Value: TadNumberFormat);
    procedure SetParentColor(Value : Boolean);
    procedure SetValue(Value: Extended);
{$IFDEF LINUX}

{$ELSE}
    function HookMainProc(var Message: TMessage) : Boolean;
    procedure WMClear(var Msg : TMessage); message WM_CLEAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMCopy(var Message: TMessage); message WM_COPY;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSettingchange(var Message: TMessage); message PB_SETTINGCHANGE;
    procedure CMPARENTCOLORCHANGED(var M:TMessage); message CM_PARENTCOLORCHANGED;
{$ENDIF}    
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure InvalidEntry;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Keyup(var Key: Word; Shift: TShiftState); override;
    {$IFDEF LINUX}
    procedure SetEnabled(const Value : Boolean); override;
    {$ELSE}
    procedure SetEnabled(Value : Boolean); override;
    {$ENDIF}
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFNDEF LINUX}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF}
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsFloat: Extended read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property Value: Extended read GetValue write SetValue;
  published
    { Published declarations }
    property Alignment: TAlignment read FAlignment write SetAlignment default taRightJustify;
    {$IFNDEF VERSION3} 
    property Anchors; 
    {$ENDIF}
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color : TColor read FEnabledColor write SetColor default clWindow;
    property DisabledColor : TColor read FDisabledColor write SetDisabledColor default clBtnFace;
    property Enabled : Boolean read GetEnabled write SetEnabled default True;
    {$IFNDEF LINUX}
    property Ctl3D;
    property DragCursor;
    property ParentCtl3D;
    {$ENDIF}
    property Decimals: ShortInt read FDecimals write SetDecimals  default 2;
    property DragMode;
    property Font;
    property HideSelection;
    property MaxLength;
    property MaxValue: Extended read FMaxValue write SetMaxValue;
    property MinValue: Extended read FMinValue write SetMinValue;
    property Format: TadNumberFormat read FFormat write SetFormat default nfThousands;
    property OnChange;
    property OnClear : TNotifyEvent read FOnClear write FOnClear;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnInvalidEntry: TNotifyEvent read FInvalidEntry write FInvalidEntry;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property ParentColor : Boolean read FParentColor write SetParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
  end;

  //-----| Class: TadLabelNumericEdit
  
  TadLabelNumericEdit = class(TadCustomLabelNumericEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Value;
  end;
  
implementation

// TadCustomLabelNumericEdit ---------------------------------------------------------

constructor TadCustomLabelNumericEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width             := 145;
  FAlignment        := taRightJustify;
  FDecimals         := 2;
  FEnter            := False;
  FMaxValue         := 0;
  FMinValue         := 0;
  FFormat           := nfThousands;
  OldDecimalSep     := DecimalSeparator;
  OldThousandSep    := ThousandSeparator;
  Value             := 0;
  Text              := FormatText(Value);
  inherited Enabled := True;
  inherited Color   := clWindow;
  FEnabledColor     := clWindow;
  FDisabledColor    := clBtnFace;
  {$IFNDEF LINUX}
  Application.HookMainWindow(HookMainProc);
  {$ENDIF}
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.Loaded;
begin
  inherited;
  if Enabled then inherited Color := FEnabledColor
  else inherited Color := FDisabledColor;
end;

// -----------------------------------------------------------------------------

{$IFNDEF LINUX}
procedure TadCustomLabelNumericEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Word = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or Alignments[FAlignment];
end;
{$ENDIF}

// -----------------------------------------------------------------------------

destructor TadCustomLabelNumericEdit.Destroy;
begin
  {$IFNDEF LINUX}
  Application.UnHookMainWindow(HookMainProc);
  {$ENDIF}
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) or (ssLeft in Shift) then
  begin
    if FEnter = True then
    begin
      FEnter := False;
      if AutoSelect then SelectAll;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.DoEnter;
begin
  inherited DoEnter;
  if csLButtonDown in ControlState then FEnter := True;
  if AutoSelect then SelectAll;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.DoExit;
begin
  Text := FormatText(Value);
  if ((FMinValue <> 0) or (FMaxValue <> 0))
    and ((Value < FMinValue) or (Value > FMaxValue)) then InvalidEntry
  else inherited DoExit;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  FEnter := False;
  if not ReadOnly then
  begin
    {$IFDEF LINUX}
    if (Key = Key_Delete) or (Key = Key_Backspace) then
    {$ELSE}
    if Key in [VK_DELETE, VK_BACK] then
    {$ENDIF}  
    begin
      if SelLength > 0 then DeleteSelection
      else DeleteKey(Key);
      Key := 0;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.KeyPress(var Key: Char);
var
  P, D, E : Integer;
  N, NE : Boolean;
begin
  inherited KeyPress(Key);
  if ReadOnly or (Key in [#3, #22, #24]) then exit;
  if not (Key in ['0'..'9', DecimalSeparator, '-', 'e', 'E'])
    or ((Key = DecimalSeparator) and (FDecimals = 0)) then
  begin
    {$IFNDEF LINUX}
    MessageBeep(0);
    {$ELSE}
    Beep;
    {$ENDIF}
    Key := #0;
    Exit;
  end;
  P := SelStart;
  D := pos(DecimalSeparator, Text);
  E := pos('E', Text);
  if Key = 'e' then Key := 'E';
  if Key in [DecimalSeparator, 'E'] then SelLength := 0
  else DeleteSelection;
  N := (Text[1] = '-');
  NE := (pos('-', copy(Text, E + 1, Length(Text) - E)) <> 0) and (E <> 0);
  if N and (SelStart = 0) then SelStart := 1;
  if NE and (Selstart = E + 1) then SelStart := SelStart + 1;
  if Key = '-' then
  begin
    if (P < E) or (E = 0) then
    begin
      if not N then
      begin
        Text := '-' + Text;
        SelStart := P + 1;
      end
      else
      begin
        Text := Copy(Text, 2, Length(Text) - 1);
        SelStart := P - 1;
      end;
    end
    else
    begin
      if not NE then
      begin
        Text := copy(Text, 1, E) + '-' + copy(Text, E + 1, Length(Text) - E);
        SelStart := P + 1;
      end
      else
      begin
        Text := copy(Text, 1, E) + copy(Text, E + 2, Length(Text) - E - 1);
        SelStart := P - 1;
      end;
    end;
    Key := #0;
    exit;
  end;
  if Key = DecimalSeparator then
  begin
    if D <> 0 then
    begin
      Selstart := D;
      Key := #0;
    end
    else if FDecimals < 0 then
    begin
      if E <> 0 then Selstart := E - 1
      else Selstart := Length(Text);
    end;
    exit;
  end
  else if Key = 'E' then
  begin
    if E = 0 then SelStart := Length(Text)
    else
    begin
      SelStart := E;
      Key := #0;
    end;
    Exit;
  end;
  if (SelStart <= 2) and (Copy(Text, 2, 1) = '0') and N then
  begin
    SelStart := 1;
    SelLength := 1;
  end
  else if (SelStart <= 1) and (Copy(Text, 1, 1) = '0') then
  begin
    SelStart := 0;
    SelLength := 1;
  end
  else if (SelStart = E) and (E <> 0) and (copy(Text,E + 1, 1) = '0')
    then SelLength := 1
  else if (SelStart >= E) and (E <> 0) then
  begin
    if  Abs(StrToInt(Copy(Text, E + 1, SelStart - E) + Key + Copy(Text, SelStart + 1, 99))) > 4932 then
    begin
      {$IFNDEF LINUX}
      MessageBeep(0);
      {$ELSE}
      Beep;
      {$ENDIF}
      Key := #0;
    end;
  end
  else if FDecimals > 0 then
  begin
    if (SelStart = D + FDecimals) then
    begin
      {$IFNDEF LINUX}
      MessageBeep(0);
      {$ELSE}
      Beep;
      {$ENDIF}
      Key := #0;
    end
    else if SelStart >= D then SelLength := 1
    else if SelStart < D - 1 then SelLength := 0;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.Keyup(var Key: Word; Shift: TShiftState);
var
  Numsep, NumSep0, SelStart0, X, D, N, N0 : integer;
  Text0 : string;
begin
  inherited KeyUp(Key, Shift);
  if (SelLength > 0) then exit;
  if Format <> nfThousands then exit;
  D := pos(DecimalSeparator, Text);
  SelStart0 := SelStart;
  NumSep := 0;
  NumSep0 := 0;
  Text0 := FormatText(AsFloat);
  for X := 1 to Length(Text0) do
    if Text0[X] = ThousandSeparator then inc(NumSep0);
  for X := 1 to Length(Text) do
    if Text[X] = ThousandSeparator then inc(NumSep);
  N := pos(ThousandSeparator, Text);
  N0 := pos(ThousandSeparator, Text0);
  if (NumSep <> NumSep0) or (N <> N0) or (Key in [32, 13]) then
  begin
    Text := Text0;
    Selstart := SelStart0 + NumSep0 - NumSep;
    if (pos(DecimalSeparator, Text) <> 0) and (D = 0) then Selstart := Selstart + 1
    else if (D <> 0) and (pos(DecimalSeparator, Text) = 0) then Selstart := Selstart - 1;
    if Copy(Text, Selstart + 1, 1) = ThousandSeparator then Selstart := Selstart + 1;
  end;
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.GetAsCurrency: Currency;
begin
  Result := StrToCurr(RemoveThousands(Text));
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.GetAsFloat: Extended;
begin
  Result := StrToFloat(RemoveThousands(Text));
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.GetAsInteger: Integer;
begin
  Result := Trunc(StrToFloat(RemoveThousands(Text)));
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.GetValue: Extended;
begin
  Result := StrToFloat(RemoveThousands(Text));
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetAsCurrency(Value: Currency);
begin
  if Text <> FormatText(Value) then Text := FormatText(Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetAsFloat(Value: Extended);
begin
  if Text <> FormatText(Value) then Text := FormatText(Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetAsInteger(Value: Integer);
begin
  if Text <> FormatText(Value) then Text := FormatText(Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetAlignment(Value: TAlignment);
var
  SelSt, SelLe : integer;
begin
  if FAlignment <> Value then
  begin
    SelSt := SelStart;
    SelLe := SelLength;
    FAlignment := Value;
    RecreateWnd;
    SelStart := SelSt;
    SelLength := SelLe;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetColor(Value : TColor);
begin
  if FEnabledColor <> Value then
  begin
    FEnabledColor := Value;
    if Enabled then inherited Color := Value;
    if (Parent <> nil) and (FEnabledColor <> Parent.Brush.Color)
      then FParentColor := False;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetDisabledColor(Value : TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if (not Enabled) then inherited Color := Value;
  end;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomLabelNumericEdit.SetEnabled(const Value : Boolean);
{$ELSE}
procedure TadCustomLabelNumericEdit.SetEnabled(Value : Boolean);
{$ENDIF}
begin
  inherited;
  if Enabled then inherited Color := FEnabledColor
  else inherited Color := FDisabledColor;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetMaxValue(Value: Extended);
begin
  if (FMaxValue <> Value) and (Value >= FminValue) then
  begin
    FMaxValue := Value;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetMinValue(Value: Extended);
begin
  if (FMinValue <> Value) and (Value <= FmaxValue) then
  begin
    FMinValue := Value;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetParentColor(Value : Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    if FParentColor and (Parent <> nil) then FEnabledColor := Parent.Brush.Color;
    SetEnabled(Enabled);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetValue(Value: Extended);
begin
  if csDesigning in ComponentState then
  begin
    if (Value > FMaxValue) and ((FMaxValue <> 0) or (FMinValue <> 0)) then InvalidEntry;
    if (Value < FMinValue) and ((FMaxValue <> 0) or (FMinValue <> 0)) then InvalidEntry;
  end;
  if Text <> FormatText(Value) then Text := FormatText(Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.DeleteKey(Key: Word);
var
  P, D, E: Integer;
  N: Boolean;
  str0 : string;
begin
  D := pos(DecimalSeparator, Text);
  E := pos('E', Text);
  if E = 0 then E := Length(Text) + 1;
  {$IFDEF LINUX}
  if (Key = Key_Delete) then
  {$ELSE}
  if Key = VK_DELETE then
  {$ENDIF}
  begin
    P := SelStart + 1;
    if P > Length(Text) then Exit;
    if Text[P] in [ThousandSeparator, DecimalSeparator, 'E'] then inc(P);
  end
  else
  begin
    P := SelStart;
    if P = 0 then Exit;
    if Text[P] in [ThousandSeparator, DecimalSeparator, 'E'] then dec(P);
  end;
  N := (Pos('-', Text) > 0);
  if (P = 0) or (P > Length(Text)) then exit;
  str0 := '';
  if (P > D) and (D <> 0) and ((P < E) or (E = 0)) then
  begin
    if FDecimals > 0 then str0 := '0';
    Text := Copy(Text, 1, P - 1) + Copy(Text, P + 1,E - P - 1)
      + str0 + Copy(Text, E, Length(Text) - E + 1);
    SelStart := P - 1;
  end
  else if (P = 1) and N then
  begin
    Text := Copy(Text, 2, Length(Text) - 1);
    if Text = '' then Text := '0';
  end
  else if (P = 1) and ((P = D - 1) or (P = E - 1) or (P = Length(Text))) then
  begin
    Text := '0' + Copy(Text, 2, Length(Text) - 1);
    SelStart := 1;
    if N then Text := '-' + Text;
  end
  else if P > 0 then
  begin
    Text := Copy(Text, 1, P - 1) + Copy(Text, P + 1, Length(Text) - P);
    SelStart := P - 1;
    if ((FFormat = nfScientific) or (FFormat = nfEngineering))
      and (Text[Length(Text)] = 'E') then Text := Text + '0';
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.DeleteSelection;
var
  X, Y, Z: Integer;
begin
  if SelLength = 0 then exit;
  if SelText = Text then
  begin
    Text := FormatText(0);
    exit;
  end;
  Y := Length(RemoveThousands(SelText));
  if pos(DecimalSeparator, SelText) <> 0 then dec(Y);
  Z := Length(SelText);
  SelStart := SelStart + Z;
  for X:= 1 to Y do
  begin
    {$IFDEF LINUX}
    DeleteKey(Key_Backspace);
    {$ELSE} 
    DeleteKey(VK_BACK);
    {$ENDIF}
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.InvalidEntry;
begin
  if not (csLoading in ComponentState) then
  begin
    if Assigned(FInvalidEntry) then FInvalidEntry(Self)
    else
    begin
      if Value < FMinValue then Value := FMinValue
      else if Value > FMaxValue then Value := FMaxValue;
      MessageBeep(0);
      if CanFocus and (not (csDesigning in ComponentState)) then SetFocus;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMCopy(var Message: TMessage);
begin
  ClipBoard.AsText := RemoveThousands(Seltext);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMCut(var Message: TMessage);
begin
  ClipBoard.AsText := RemoveThousands(Seltext);
  DeleteSelection;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMPaste(var Message: TMessage);
var
  X: integer;
  S: String;
  W: Word;
begin
  DeleteSelection;
  S := Clipboard.AsText;
  for X := 1 to Length(S) do
  begin
    W := Ord(S[X]);
    Perform(WM_CHAR, W, 0);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetDecimals(Value: ShortInt);
var Value0 : ShortInt;
begin
  if (Format in [nfStandard, nfScientific, nfEngineering]) then
    Value := -1;
  Value0 := Value;
  if FDecimals <> Value0 then
  begin
    if Value0 < 0 then Value0 := -1
    else if Value0 > 14 then Value0 := 14;
    if (Value0 > MaxLength - 2) and (MaxLength > 0) then Value0 := maxlength - 2;
    FDecimals := Value0;
    Text := FormatText(AsFloat);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.SetFormat(Value: TadNumberFormat);
begin
  if (FFormat = nfThousands) and (Value in [nfStandard, nfScientific, nfEngineering]) then
    Self.Value := Round(Self.Value);
  if FFormat <> Value then FFormat := Value;
  if (FFormat in [nfStandard, nfScientific, nfEngineering]) then
    Decimals := -1;
  Text := FormatText(AsFloat);
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.ReplaceSeparators(Value : string) : string;
var
  t : integer;
begin
  Result := Value;
  // Alteração feita em 09/06/2005 por Dennys S. Sobrinho.
  // Foi necessário verificar se a variável RESUL estava diferente de "vazio"
  // para corrigir um erro: Access Violation.
  if (Trim(Result) <> '') then begin
    for t := 1 to Length(Result) do begin
      if Result[t] = OldDecimalSep then Result[t] := DecimalSeparator
      else if Result[t] = OldThousandSep then Result[t] := ThousandSeparator;
    end;
  end;
  OldDecimalSep := DecimalSeparator;
  OldThousandSep := ThousandSeparator;
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.RemoveThousands(Value : string): string;
var
  t : integer;
begin
  // Alteração feita em 09/06/2005 por Dennys S. Sobrinho.
  // Foi necessário verificar se a variável RESUL estava diferente de "vazio"
  // para corrigir um erro: Access Violation.
  if (Trim(Value) <> '') and 
    ((OldDecimalSep <> DecimalSeparator)
    or (OldThousandSep <> ThousandSeparator))
    then Value := ReplaceSeparators(Value);
  Result := '';
  for t :=1 to Length(Value) do begin
    if Value[t] <> ThousandSeparator then 
      Result := Result + Value[t];
  end;
  if Result = '' then Result := '0';
  if Result = '-' then Result := '-0';
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.FormatText(Value: Extended) : string;
var
  e0, E, D, NN, t, FD : integer;
  a : extended;
  Formatmask : string;
begin
  if (FFormat = nfEngineering) and (Value <> 0) then begin
    e0 := trunc(ln(abs(Value)) / ln(10) / 3) * 3;
    Result := 'E' + inttostr(e0);
    a := Value / StrToFloat('1' + Result);
    FD := 14;
    if a > 9 then dec(FD);
    if a > 99 then dec(FD);
    if (FD > FDecimals) and (FDecimals <> -1) then FD := FDecimals;
    if FDecimals < 0 then Result := formatfloat('0.' + StringOfChar('#',FD), a) + Result
    else if FDecimals = 0 then Result := formatfloat('0', a) + Result
    else Result := formatfloat('0.' + StringOfChar('0',FD), a) + Result;
  end else begin
    FormatMask := '0';
    if FFormat = nfThousands then FormatMask := ',' + FormatMask;
    if FDecimals > 0 then FormatMask := FormatMask + '.' + StringOfChar('0', FDecimals)
    else if FDecimals < 0 then FormatMask := FormatMask + '.' + StringOfChar('#', 14);
    if FFormat > nfThousands then FormatMask := FormatMask + 'E-';
    Result := FormatFloat(FormatMask, Value);
    E := pos('E',Result);
    if E = 0 then
    begin
      D := pos(DecimalSeparator, Result);
      if (D <> 0) then
      begin
        NN := 0;
        for t := 1 to D do if (Result[t] in ['0'..'9'] = True) then inc(NN);
        if (FDecimals = -1) then
        begin
          if FFormat = nfThousands then Result := FormatFloat(',0.' + StringOfChar('#',15 - NN),Value)
          else if FDecimals <> -1 then Result := FormatFloat('0.' + StringOfChar('#',15 - NN),Value);
        end
        else if (FDecimals > 15 - NN) then
        begin
          if FFormat = nfThousands then Result := FormatFloat(',0.' + StringOfChar('0',15 - NN),Value)
          else if FDecimals <> -1 then Result := FormatFloat('0.' + StringOfChar('0',15 - NN),Value);
          Result := Result + StringOfChar('0', Fdecimals -15 + NN);
        end;
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

function TadCustomLabelNumericEdit.HookMainProc(var Message: TMessage) : Boolean;
begin
  Result := False;
  if Message.Msg = WM_SETTINGCHANGE
    then PostMessage(Self.Handle, PB_SETTINGCHANGE, 0, 0);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMSettingchange(var Message: TMessage);
begin
  Text := ReplaceSeparators(Text);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.CMPARENTCOLORCHANGED(var M:TMessage);
begin
  if FParentColor and (Parent <> nil) then FEnabledColor := Parent.Brush.Color;
  if Parent <> nil then Invalidate;
  SetEnabled(Enabled);
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMClear(var Msg : TMessage);
begin
  if Assigned(FOnClear) then FOnClear(Self)
  else DeleteSelection;
end;

// -----------------------------------------------------------------------------

procedure TadCustomLabelNumericEdit.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTCHARS or DLGC_WANTARROWS;
end;

// -----------------------------------------------------------------------------

end.
