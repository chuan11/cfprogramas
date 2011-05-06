//==============================================================================
// Unit........: adLabelDBNumericEdit.pas
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
// 18/05/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit adLabelDBNumericEdit;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QControls, QTypes, {Qt, Libc}
{$ELSE}
     Controls, Messages, Windows, 
{$ENDIF}
     adLabelNumericEdit, DB, DBCtrls;

type

  //-----| Class: TadLabelDBNumericEdit
  
  TadLabelDBNumericEdit = class(TadCustomLabelNumericEdit)
  private
    { Private declarations }
    FDataLink: TFieldDataLink;
    FReadOnly: Boolean;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    function  GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure ResetMaxLength;
  protected
    { Protected declarations }
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    { Published declarations }
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;
  
implementation

// TadLabelDBNumericEdit -------------------------------------------------------

constructor TadLabelDBNumericEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly        := True;
  ControlStyle              := ControlStyle + [csReplicatable];
  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData    := UpdateData;
  FDataLink.OnActiveChange  := ActiveChange;
end;

// -----------------------------------------------------------------------------

destructor TadLabelDBNumericEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) {and (FDataLink <> nil)} and
    (AComponent = DataSource) then DataSource := nil;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) and Assigned(FDataLink) then
    FDataLink.Edit;
  inherited KeyDown(Key, Shift);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.KeyPress(var Key: Char);
begin
  if Assigned(FDataLink) then begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        begin
          FDataLink.Reset;
          Key := #0;
        end;
    end;
  end;
  inherited KeyPress(Key);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.Change;
begin
  if Assigned(FDataLink) then
    FDataLink.Modified;
  inherited Change;
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.GetDataSource: TDataSource;
begin
  if Assigned(FDataLink) then
    Result  := FDataLink.DataSource
  else
    Result  := Nil;  
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) and Assigned(FDataLink) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.GetDataField: string;
begin
  if Assigned(FDataLink) then begin
    Result    := FDataLink.FieldName;
    FReadOnly := FDataLink.ReadOnly;
  end else
    Result := '';
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  if Assigned(FDataLink) then
  FDataLink.FieldName := Value;
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.SetReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
  if Assigned(FDataLink) then
    FDataLink.ReadOnly := Value;
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.GetField: TField;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.Field
  else
    Result := Nil;  
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.DataChange(Sender: TObject);
begin
  if Assigned(FDataLink) then begin
    if FDataLink.Field = nil then begin
      Self.Value := 00;
      Exit;
    end;
    with FDataLink.Field do begin
      if IsNull then begin
        Self.Value := 00;
      end else begin
        Self.Value := AsFloat;
      end;
    end;  
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.UpdateData(Sender: TObject);
begin
  if Assigned(FDataLink) and (FDataLink.DataSource.State in [dsEdit, dsInsert]) then begin
    if not FDataLink.Editing then
      FDataLink.Edit;
    FDataLink.Field.AsString := FloatToStr(Value);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.WMPaste(var Message: TMessage);
begin
  if Assigned(FDataLink) then
    FDataLink.Edit;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.WMCut(var Message: TMessage);
begin
  if Assigned(FDataLink) then
    FDataLink.Edit;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.CMExit(var Message: TCMExit);
begin
  try
    if Assigned(FDataLink) then
      FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(FDataLink) then
    Message.Result := Integer(FDataLink);
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  if Assigned(FDataLink) then
    Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and FDataLink.ExecuteAction(Action)
  else
    Result := False;
end;

// -----------------------------------------------------------------------------

function TadLabelDBNumericEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  if Assigned(FDataLink) then
    Result := inherited UpdateAction(Action) or (FDataLink <> nil) and FDataLink.UpdateAction(Action)
  else
    Result := False;    
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBNumericEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// -----------------------------------------------------------------------------

end.

