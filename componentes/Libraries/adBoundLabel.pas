//==============================================================================
// Unit........: adBoundLabel.pas
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
// 28/04/2005 - Foi implementado uma condição na procedure AdjustPosition para
//              que fosse possível ajustar a propriedade Align do SubLabel,
//              conforme objeto associado.
//==============================================================================

unit adBoundLabel;

interface

{$I ActiveDelphi.inc}

uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QGraphics, QForms, QControls, QTypes;
{$ELSE}
     StdCtrls, Graphics, Forms, Controls;
{$ENDIF}

{$IFDEF VERSION5}
const
   clSkyBlue = 15780518;
{$ENDIF}   
   
type

  {$IFDEF VERSION5}
  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code: Byte;
    Offset: Integer;
    case Integer of
      0: (Next: PObjectInstance);
      1: (Method: TWndMethod);
  end;

  PInstanceBlock = ^TInstanceBlock;
  TInstanceBlock = packed record
    Next: PInstanceBlock;
    Code: array[1..2] of Byte;
    WndProcPtr: Pointer;
    Instances: array[0..313] of TObjectInstance;
  end;
  {$ENDIF}
    

  TmyHackLabel        = class(TLabel);

  TadControlPosition  = (adNone, 
                         adAboveLeft, 
                         adAboveRight, 
                         adBelowLeft, 
                         adBelowRight, 
                         adLeft, 
                         adRight);

  //-----| Class: TadWhenDisabled
                         
  TadWhenDisabled = class(TPersistent)
  private
    { Private declarations }
    FBackColor : TColor;
    FTextColor : TColor;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  BackColor : TColor  read  FBackColor  write FBackColor  default clWindow;
    property  TextColor : TColor  read  FTextColor  write FTextColor  default clGrayText;
  end;

  //-----| Class: TadWhenEnterFocus
                         
  TadWhenEnterFocus = class(TPersistent)
  private
    { Private declarations }
    FBackColor : TColor;
    FTextColor : TColor;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  BackColor : TColor  read  FBackColor  write FBackColor  default {$IFDEF LINUX}clYellow{$ELSE}clSkyBlue{$ENDIF};
    property  TextColor : TColor  read  FTextColor  write FTextColor  default clWindowText;
  end;
                         
  //-----| Class: TadWhenExitFocus
                         
  TadWhenExitFocus = class(TPersistent)
  private
    { Private declarations }
    FBackColor : TColor;
    FTextColor : TColor;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  BackColor : TColor  read  FBackColor  write FBackColor  default clWindow;
    property  TextColor : TColor  read  FTextColor  write FTextColor  default clWindowText;
  end;
                         
  //-----| Class: TadColors
                         
  TadColors = class(TPersistent)
  private
    { Private declarations }
    FActive         : Boolean;
    FWhenDisabled   : TadWhenDisabled;
    FWhenEnterFocus : TadWhenEnterFocus;
    FWhenExitFocus  : TadWhenExitFocus;
    procedure SetWhenDisabled(const Value : TadWhenDisabled);
    procedure SetWhenEnterFocus(const Value : TadWhenEnterFocus);
    procedure SetWhenExitFocus(const Value : TadWhenExitFocus);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  Active          : Boolean           read  FActive         write FActive           default True;
    property  WhenDisabled    : TadWhenDisabled   read  FWhenDisabled   write SetWhenDisabled;
    property  WhenEnterFocus  : TadWhenEnterFocus read  FWhenEnterFocus write SetWhenEnterFocus;
    property  WhenExitFocus   : TadWhenExitFocus  read  FWhenExitFocus  write SetWhenExitFocus;
  end;
  
  //-----| Class: TadBoundLabel
  
  TadBoundLabel = class(TCustomLabel)
  private
    { Private declarations }
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
{$IFDEF LINUX}

{$ELSE}
    procedure Paint; override;
{$ENDIF}    
    procedure AdjustPosition(Sender : TControl; var FLabelDefs : TadBoundLabel; var FLabelPosition : TadControlPosition; FLabelSpacing : Integer; LabelPosition: TadControlPosition);
  published
    { Published declarations }
    property Align;
    property Caption;
    property Color;
    property Font;
    property Height : Integer read GetHeight  write SetHeight;
    property Left   : Integer read GetLeft;
    property Top    : Integer read GetTop;
    property Width  : Integer read GetWidth   write SetWidth;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF LINUX}

{$ELSE}
    property OnStartDock;
    property OnEndDock;
{$ENDIF}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDrag;
  end;

  procedure CreateLabelDefs(var FLabelDefs : TadBoundLabel; Sender : TControl);
  procedure SetLabelDefsCaption(var FLabelDefs : TadBoundLabel; Sender : TControl; const Value: TComponentName);

{$IFDEF VERSION5}
  function MakeObjectInstance(Method: TWndMethod): Pointer;
  procedure FreeObjectInstance(ObjectInstance: Pointer);
  
var
  InstBlockList: PInstanceBlock;
  InstFreeList: PObjectInstance;
{$ENDIF}
  
implementation

{$IFDEF VERSION5}
function StdWndProc(Window: HWND; Message, WParam: Longint; LParam: Longint): Longint; stdcall; assembler;
asm
  XOR     EAX,EAX
  PUSH    EAX
  PUSH    LParam
  PUSH    WParam
  PUSH    Message
  MOV     EDX,ESP
  MOV     EAX,[ECX].Longint[4]
  CALL    [ECX].Pointer
  ADD     ESP,12
  POP     EAX
end;
  
function CalcJmpOffset(Src, Dest: Pointer): Longint;
begin
  Result := Longint(Dest) - (Longint(Src) + 5);
end;
  
function MakeObjectInstance(Method: TWndMethod): Pointer;
const
  BlockCode: array[1..2] of Byte = (
    $59,       { POP ECX }
    $E9);      { JMP StdWndProc }
  PageSize = 4096;
var
  Block: PInstanceBlock;
  Instance: PObjectInstance;
begin
  if InstFreeList = nil then
  begin
    Block := VirtualAlloc(nil, PageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Block^.Next := InstBlockList;
    Move(BlockCode, Block^.Code, SizeOf(BlockCode));
    Block^.WndProcPtr := Pointer(CalcJmpOffset(@Block^.Code[2], @StdWndProc));
    Instance := @Block^.Instances;
    repeat
      Instance^.Code := $E8;  { CALL NEAR PTR Offset }
      Instance^.Offset := CalcJmpOffset(Instance, @Block^.Code);
      Instance^.Next := InstFreeList;
      InstFreeList := Instance;
      Inc(Longint(Instance), SizeOf(TObjectInstance));
    until Longint(Instance) - Longint(Block) >= SizeOf(TInstanceBlock);
    InstBlockList := Block;
  end;
  Result := InstFreeList;
  Instance := InstFreeList;
  InstFreeList := Instance^.Next;
  Instance^.Method := Method;
end;
  
procedure FreeObjectInstance(ObjectInstance: Pointer);
begin
  if ObjectInstance <> nil then
  begin
    PObjectInstance(ObjectInstance)^.Next := InstFreeList;
    InstFreeList := ObjectInstance;
  end;
end;
{$ENDIF}

// TadBoundLabel ---------------------------------------------------------------

constructor TadBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name        := 'Label';
  Layout      := tlCenter;
  {$IFDEF VERSION6_OR_HIGHER}
  SetSubComponent(True);
  {$ENDIF}
  if Assigned(AOwner) then
    Caption   := AOwner.Name;
  // As 3 linhas abaixo não são obrigatórias...
  Font.Name   := TForm(AOwner.Owner).Font.Name;
  Font.Style  := TForm(AOwner.Owner).Font.Style;
  Font.Color  := {$IFDEF FAESP} clNavy {$ELSE} clWindowText {$ENDIF};
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}

{$ELSE}
procedure TadBoundLabel.Paint;
begin
  if Visible then
    inherited Paint;
end;
{$ENDIF}
// -----------------------------------------------------------------------------

function TadBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

// -----------------------------------------------------------------------------

function TadBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

// -----------------------------------------------------------------------------

function TadBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

// -----------------------------------------------------------------------------

function TadBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

// -----------------------------------------------------------------------------

procedure TadBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

// -----------------------------------------------------------------------------

procedure TadBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

// -----------------------------------------------------------------------------

procedure TadBoundLabel.AdjustPosition(Sender : TControl; var FLabelDefs : TadBoundLabel; var FLabelPosition : TadControlPosition; FLabelSpacing : Integer; LabelPosition: TadControlPosition);
var
  P: TPoint;
begin
  with Sender do begin
    FLabelDefs.Visible        := (LabelPosition <> adNone);
    if (FLabelDefs <> nil) and Visible then begin
      FLabelPosition          := LabelPosition;
      if (FLabelPosition in [adLeft, adAboveRight, adBelowRight]) then
        FLabelDefs.Alignment  := taRightJustify
      else
        FLabelDefs.Alignment  := taLeftJustify;
        
      // Implementação feita em 28/04/2005 por Dennys S. Sobrinho.
      // Sua finalidade é de ajustar corretamente a propriedade Align da 
      // instância FLabelDefs, conforme objeto associado.
      if (Align = alNone) then
        FLabelDefs.Align := alNone
      else if (Align in [alClient, alTop, alBottom]) then begin
        case FLabelPosition of
          adLeft: 
          begin
            if (Align = alClient) then 
              FLabelDefs.Align := alLeft
            else  
              FLabelDefs.Align := alNone;
          end;    
          adRight:
          begin
            if (Align = alClient) then 
              FLabelDefs.Align := alRight
            else
              FLabelDefs.Align := alNone;
          end;  
          adAboveLeft,
          adAboveRight: FLabelDefs.Align := alTop;
          adBelowLeft,
          adBelowRight: FLabelDefs.Align := alBottom;
        else  
          FLabelDefs.Align := alNone;
        end;
      end;
      // Final da implementação.
      
      case LabelPosition of
        adAboveLeft  : P := Point(Left, Top - FLabelDefs.Height - FLabelSpacing);
        adAboveRight : P := Point((Left+Width)-FLabelDefs.Width, Top - FLabelDefs.Height - FLabelSpacing);
        adBelowLeft  : P := Point(Left, Top + Height + FLabelSpacing);
        adBelowRight : P := Point((Left+Width)-FLabelDefs.Width, Top + Height + FLabelSpacing);
        adLeft       : P := Point(Left - FLabelDefs.Width - FLabelSpacing, Top + ((Height - FLabelDefs.Height) div 2));
        adRight      : P := Point(Left + Width + FLabelSpacing, Top + ((Height - FLabelDefs.Height) div 2));
      end;
      FLabelDefs.SetBounds(P.x, P.y, FLabelDefs.Width, FLabelDefs.Height);
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure CreateLabelDefs(var FLabelDefs : TadBoundLabel; Sender : TControl);
begin
  if not Assigned(FLabelDefs) then begin
    FLabelDefs := TadBoundLabel.Create(Sender);
    FLabelDefs.FreeNotification(Sender);
    TmyHackLabel(FLabelDefs).FocusControl := TWinControl(Sender);
  end;
end;

// -----------------------------------------------------------------------------

procedure SetLabelDefsCaption(var FLabelDefs : TadBoundLabel; Sender : TControl; const Value: TComponentName);
begin 
  with Sender do begin
{$IFDEF LINUX}
    if ((FLabelDefs.Caption = '') or (CompareText(FLabelDefs.Caption, Name) = 0))
      and (csDesigning in ComponentState) then
{$ELSE}
    if ((FLabelDefs.GetTextLen = 0) or (CompareText(FLabelDefs.Caption, Name) = 0))
      and (csDesigning in ComponentState) then
{$ENDIF}    
      FLabelDefs.Caption := Value;
  end;
end;  

// TadColors -------------------------------------------------------------------

constructor TadColors.Create;
begin
  inherited Create;
  FActive                   := True;
  
  FWhenDisabled             := TadWhenDisabled.Create;
  FWhenDisabled.BackColor   := clWindow;
  FWhenDisabled.TextColor   := clGrayText;
  
  FWhenEnterFocus           := TadWhenEnterFocus.Create;
  FWhenEnterFocus.BackColor := {$IFDEF LINUX}clYellow{$ELSE}clSkyBlue{$ENDIF};
  FWhenEnterFocus.TextColor := clWindowText;
  
  FWhenExitFocus            := TadWhenExitFocus.Create;
  FWhenExitFocus.BackColor  := clWindow;
  FWhenExitFocus.TextColor  := clWindowText;
end;

// -----------------------------------------------------------------------------

procedure TadColors.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadColors) then begin
    FActive := TadColors(Source).FActive;
    FWhenDisabled.Assign(TadColors(Source).FWhenDisabled);
    FWhenEnterFocus.Assign(TadColors(Source).FWhenEnterFocus);
    FWhenExitFocus.Assign(TadColors(Source).FWhenExitFocus);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadColors.SetWhenDisabled(const Value : TadWhenDisabled);
begin
  if (FWhenDisabled <> Value) then
    FWhenDisabled.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadColors.SetWhenEnterFocus(const Value : TadWhenEnterFocus);
begin
  if (FWhenEnterFocus <> Value) then
    FWhenEnterFocus.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadColors.SetWhenExitFocus(const Value : TadWhenExitFocus);
begin
  if (FWhenExitFocus <> Value) then
    FWhenExitFocus.Assign(Value);
end;

// TadWhenDisabled -----------------------------------------------------------

procedure TadWhenDisabled.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadWhenDisabled) then begin
    FBackColor  := TadWhenDisabled(Source).FBackColor;
    FTextColor  := TadWhenDisabled(Source).FTextColor;
  end;
end;

// TadWhenEnterFocus ----------------------------------------------------------

procedure TadWhenEnterFocus.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadWhenEnterFocus) then begin
    FBackColor  := TadWhenEnterFocus(Source).FBackColor;
    FTextColor  := TadWhenEnterFocus(Source).FTextColor;
  end;
end;

// TadWhenExitFocus -----------------------------------------------------------

procedure TadWhenExitFocus.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadWhenExitFocus) then begin
    FBackColor  := TadWhenExitFocus(Source).FBackColor;
    FTextColor  := TadWhenExitFocus(Source).FTextColor;
  end;
end;

// -----------------------------------------------------------------------------

end.
 
