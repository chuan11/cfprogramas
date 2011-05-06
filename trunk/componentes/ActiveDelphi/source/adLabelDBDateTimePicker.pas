//==============================================================================
// Unit........: adLabelDBDateTimePicker.pas
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

unit adLabelDBDateTimePicker;

interface

{$I ActiveDelphi.inc}

uses Windows, Messages, Classes, Controls, ComCtrls, DB, DBCtrls, SysUtils,
     {$IFDEF VERSION6_OR_HIGHER} Variants, {$ENDIF} CommCtrl,
     adBoundLabel;

const
   Esc = #27;
   KeyboardShiftStates = [ssShift, ssAlt, ssCtrl];
    
type

   //-----| Class: TadLabelDBDateTimePicker

   TadLabelDBDateTimePicker = class(TDateTimePicker)
  private
    FNullText       : string;
    FNullDate       : TDateTime;
    FDataLink       : TFieldDataLink;
    FBeepOnError    : Boolean;
    FTrimValue      : Boolean;
    FIsReadOnly     : Boolean;
    FPaintControl   : TPaintControl;
    FAbout          : string;
    FLabelDefs      : TadBoundLabel;
    FLabelPosition  : TadControlPosition;
    FLabelSpacing   : Integer;
    FColors         : TadColors;
    procedure SetColors(const Value : TadColors);
    procedure SetPosition(const Value: TadControlPosition);
    procedure SetSpacing(const Value: Integer);
    procedure SetNullText(const Value: string);
    procedure SetNullDate(const Value: TDateTime);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure SetDataField(Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure EditingChange(Sender: TObject);
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure CNNotify(var Msg: TWMNotify); message CN_NOTIFY;
  protected
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
    function IsDateAndTimeField: Boolean;
    procedure DataChange(Sender: TObject);
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Change; override;
    procedure UpdateData(Sender: TObject);
    procedure CalendarOnCloseUp(Sender: TObject);
    procedure CalendarOnDropDown(Sender: TObject);
    function CheckNullValue: Boolean; overload;
    function CheckNullValue(const ANullText, AFormat: string; AKind: TDateTimeKind; ADateTime, ANullDate: TDateTime): Boolean; overload; virtual;
    function WithinDelta(Val1, Val2: TDateTime): Boolean; virtual;
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure   SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
   published
    property Align;
    property NullText       : string              read  FNullText       write SetNullText;
    property NullDate       : TDateTime           read  FNullDate       write SetNullDate;
    property BeepOnError    : Boolean             read  FBeepOnError    write FBeepOnError default True;
    property DataField      : string              read  GetDataField    write SetDataField;
    property DataSource     : TDataSource         read  GetDataSource   write SetDataSource;
    property TrimValue      : Boolean             read  FTrimValue      write FTrimValue default True;
    property ReadOnly       : Boolean             read  GetReadOnly     write SetReadOnly default False;
    property LabelDefs      : TadBoundLabel       read  FLabelDefs;
    property About          : string              read  FAbout          write FAbout;
    property LabelPosition  : TadControlPosition  read  FLabelPosition  write SetPosition  default adAboveLeft;
    property LabelSpacing   : integer             read  FLabelSpacing   write SetSpacing   default 3;
    property Colors         : TadColors           read  FColors         write SetColors;
   end;

implementation

// TadLabelDBDateTimePicker ----------------------------------------------------

constructor TadLabelDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width                     := 145;
  FAbout                    := '';
  FLabelPosition            := adAboveLeft;
  FLabelSpacing             := 3;
  CreateLabelDefs(FLabelDefs, Self);
  FIsReadOnly               := True;
  ControlStyle              := ControlStyle + [csReplicatable];
  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := DataChange;
  FDataLink.OnUpdateData    := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  OnCloseUp                 := CalendarOnCloseUp;
  OnDropDown                := CalendarOnDropDown;
  FBeepOnError              := True;
  FTrimValue                := True;
  FPaintControl             := TPaintControl.Create(Self, DATETIMEPICK_CLASS);
  FColors                   := TadColors.Create;
end;

// -----------------------------------------------------------------------------

destructor TadLabelDBDateTimePicker.Destroy;
begin
  FreeAndNil(FColors);
   FreeAndNil(FLabelDefs);
   OnCloseUp := nil;
   OnDropDown := nil;
   FPaintControl.Free;
   FDataLink.OnDataChange := nil;
   FDataLink.OnUpdateData := nil;
   FDataLink.Free;
   FDataLink := nil;
   inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CalendarOnCloseUp(Sender: TObject);
begin
   FDataLink.Edit;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CalendarOnDropDown(Sender: TObject);
begin
    FDataLink.Edit;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.Change;
begin
    FDataLink.Edit;
    inherited Change;
    UpdateData(Self);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMGetDataLink(var Msg: TMessage);
begin
    Msg.Result := Integer(FDataLink);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.DataChange(Sender: TObject);
begin
    if FDataLink.Field <> nil then
    begin
         if Kind = dtkDate then
         begin
             if IsDateAndTimeField then
                  DateTime := FDataLink.Field.AsDateTime
             else
                  DateTime := Trunc(FDataLink.Field.AsDateTime);
         end
         else
         begin
             if IsDateAndTimeField then
                  DateTime := FDataLink.Field.AsDateTime
             else
                  DateTime := Frac(FDataLink.Field.AsDateTime);
         end;
    end
    else
    if csDesigning in ComponentState then
         DateTime := Now;
    CheckNullValue;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoEnter;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) and not Focused then begin
    Color       := Colors.WhenExitFocus.BackColor;
    Font.Color  := Colors.WhenExitFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.DoEnter;
begin
  inherited;
  if Colors.Active and not (csDesigning in ComponentState) then begin
    Color       := Colors.WhenEnterFocus.BackColor;
    Font.Color  := Colors.WhenEnterFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.DoExit;
begin
    try
         FDataLink.UpdateRecord;
    except
         SetFocus;
    end;
    inherited DoExit;
  if Colors.Active and not (csDesigning in ComponentState) and not Focused then begin
    Color       := Colors.WhenExitFocus.BackColor;
    Font.Color  := Colors.WhenExitFocus.TextColor;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetColors(const Value : TadColors);
begin
  if (FColors <> Value) then
    FColors.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.EditingChange(Sender: TObject);
begin
    FIsReadOnly := not FDataLink.Editing;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.GetDataField: string;
begin
    Result := FDataLink.FieldName;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.GetDataSource: TDataSource;
begin
    Result := FDataLink.DataSource;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.GetReadOnly: Boolean;
begin
    Result := FDataLink.ReadOnly;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.IsDateAndTimeField: Boolean;
begin
    with FDataLink do
         Result := (Field <> nil) and
             (Field.DataType in [ftDateTime, {$IFDEF VERSION5}ftDateTime{$ELSE}ftTimeStamp{$ENDIF}]) and
             not TrimValue;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.KeyDown(var Key: Word; Shift: TShiftState);
const
    cAllowedKeysWhenReadOnly = [VK_LEFT, VK_RIGHT];
begin
    if not (Key in cAllowedKeysWhenReadOnly) and FIsReadOnly and not FDataLink.CanModify then
    begin
         if BeepOnError then
             Beep;
         Key := 0;
         Exit;
    end;

    inherited KeyDown(Key, Shift);
    case Key of
         VK_DELETE:
             if Shift * KeyboardShiftStates = [] then
             begin
                  FDataLink.Edit;
                  if Kind = dtkDate then
                  begin
                      if IsDateAndTimeField then
                           DateTime := NullDate
                      else
                           DateTime := Trunc(NullDate);
                  end
                  else
                  begin
                      if IsDateAndTimeField then
                           DateTime := NullDate
                      else
                           DateTime := Frac(NullDate);
                  end;
                  CheckNullValue;
                  UpdateData(Self);
             end;
         VK_INSERT:
             if (Shift * KeyboardShiftStates = [ssShift]) then
                  FDataLink.Edit;
         else
             FDataLink.Edit;
    end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.KeyPress(var Key: Char);
begin
    if FIsReadOnly and not FDataLink.CanModify then
    begin
         if BeepOnError then
             Beep;
         Key := #0;
         Exit;
    end;

    inherited KeyPress(Key);
    if (Key in [#32..#255]) and ((FDataLink.Field <> nil) and
         not (FDataLink.Field.IsValidChar(Key))) then
    begin
         if BeepOnError then
             Beep;
         Key := #0;
    end;
    case Key of
         #32..#255:
             FDataLink.Edit;
         Esc:
             begin
                  FDataLink.Reset;
                  SetFocus;
             end;
    end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.Notification(AComponent: TComponent;
    Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);
   if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then
      DataSource := nil;
   if (AComponent = FLabelDefs) and (Operation = opRemove) then
      FLabelDefs := nil;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetDataField(Value: string);
begin
    FDataLink.FieldName := Value;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetDataSource(Value: TDataSource);
begin
    FDataLink.DataSource := Value;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetReadOnly(Value: Boolean);
begin
    FDataLink.ReadOnly := Value;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.UpdateData(Sender: TObject);
begin
  if not FDataLink.Editing then
    Exit;
  if Kind = dtkDate then begin
    if Trunc(NullDate) = Trunc(DateTime) then
      FDataLink.Field.Value := Null
    else if IsDateAndTimeField then
      FDataLink.Field.AsDateTime := DateTime
    else
      FDataLink.Field.AsDateTime := Trunc(DateTime);
  end else begin
    if Frac(NullDate) = Frac(DateTime) then
      FDataLink.Field.Value := Null
    else if IsDateAndTimeField then
      FDataLink.Field.AsDateTime := DateTime
    else
      FDataLink.Field.AsDateTime := Frac(DateTime);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.WMPaint(var Msg: TWMPaint);
var
    D: TDateTime;
    ST: TSystemTime;
begin
    if not (csPaintCopy in ControlState) then
         inherited
    else
    begin
         if Kind = dtkDate then
         begin
             if IsDateAndTimeField then
                  D := FDataLink.Field.AsDateTime
             else
                  D := Trunc(FDataLink.Field.AsDateTime);
         end
         else
         begin
             if IsDateAndTimeField then
                  D := FDataLink.Field.AsDateTime
             else
                  D := Frac(FDataLink.Field.AsDateTime);
         end;

         DateTimeToSystemTime(D, ST);
         DateTime_SetSystemTime(FPaintControl.Handle, GDT_VALID, ST);
         SendMessage(FPaintControl.Handle, WM_ERASEBKGND, Msg.DC, 0);
         SendMessage(FPaintControl.Handle, WM_PAINT, Msg.DC, 0);
    end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.WMLButtonDown(var Msg: TWMLButtonDown);
begin
    if FIsReadOnly and not FDataLink.CanModify then
    begin
         SendCancelMode(Self);
         SetFocus;
    end
    else
         inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CNNotify(var Msg: TWMNotify);
begin
    case Msg.NMHdr^.code of
         MCN_LAST:
             FDataLink.Edit;
    end;
    inherited;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.CheckNullValue: Boolean;
begin
   Result := Self.CheckNullValue(NullText, {$IFDEF VERSION5}''{$ELSE}Format{$ENDIF}, Kind, DateTime, NullDate);
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.CheckNullValue(const ANullText, AFormat: string;
   AKind: TDateTimeKind; ADateTime, ANullDate: TDateTime): Boolean;
begin
   if ANullText = '' then
      Result := False
   else
      Result := ((AKind = dtkDate) and (Trunc(ADateTime) = Trunc(ANullDate)) or
         ((AKind = dtkTime) and WithinDelta(ADateTime, ANullDate)));

   if Result then
      SendMessage(Handle, DTM_SETFORMAT, 0, Integer(PChar('''' + ANullText + '''')))
   else
      SendMessage(Handle, DTM_SETFORMAT, 0, Integer(PChar(AFormat)));
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetNullDate(const Value: TDateTime);
begin
   FNullDate := Trunc(Value);
   CheckNullValue;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetNullText(const Value: string);
begin
   if FNullText <> Value then
   begin
      FNullText := Value;
      CheckNullValue;
   end;
end;

// -----------------------------------------------------------------------------

function TadLabelDBDateTimePicker.WithinDelta(Val1, Val2: TDateTime): Boolean;
const
   cOneSecond = 1 / 86400;
begin
   Result := Abs(Frac(Val1) - Frac(Val2)) <= cOneSecond;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.BiDiMode := BiDiMode;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Enabled := Enabled;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FLabelDefs) then
    FLabelDefs.Visible := Visible;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetPosition(const Value: TadControlPosition);
begin
  if Assigned(FLabelDefs) then
    FLabelDefs.AdjustPosition(Self, FLabelDefs, FLabelPosition, FLabelSpacing, Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetPosition(FLabelPosition);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  if ((FLabelDefs.GetTextLen = 0) or (CompareText(FLabelDefs.Caption, Name) = 0))
    and (csDesigning in ComponentState) then
    FLabelDefs.Caption := Value;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBDateTimePicker.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FLabelDefs) then begin
    FLabelDefs.Parent  := AParent;
    FLabelDefs.Visible := True;
  end;
end;

// -----------------------------------------------------------------------------

end.

