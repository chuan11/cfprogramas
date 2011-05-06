{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPCheckBox                                           }
{ CheckBox no estilo do Windows XP                         }
{                                                          }
{ Ultima atualização: 10/09/2003                           }
{                                                          }
{ Versão: 1.0                                              }
{                                                          }
{ Obs.: O Pacote ainda está em fase de desenvolvimento.    }
{       Qualquer BUG ou atualização, favor me enviar por   }
{       email.                                             }
{                                                          }
{ ------------------------ AUTOR ------------------------- }
{                                                          }
{ Bruno Martins Stuani ( Nildo )                           }
{ Email: brunildo.st@ig.com.br                             }
{                                                          }
{ -------------------------------------------------------- }
{                           LEIA                           }
{                                                          }
{  - O Bms PACK é um pacote de componentes, visando se     }
{    igualar ao máximo com o Windows XP.                   }
{  - Este é um pacote Freeware, e não poderá ser vendido.  }
{  - O Código-Fonte pode ser alterado livremente. E por    }
{    favor notificar-me da alteração para que eu possa     }
{    utilizá-la nas próximas versões.                      }
{  - Se você gostou desse pacote demonstre seu interesse   }
{    em receber futuras implementações enviando-me um      }
{    email. Você pode também colaborar com uma quantia     }
{    simbólica para motivar o programador (eu). Obrigado e }
{    faça bom proveito do pacote!                          }
{                                                          }
{ -------------------------------------------------------- }

unit BmsXPCheckBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, bmsXPUtils, Graphics, bmsXPConsts, stdCtrls;

type
  TBmsXPCheckBox = class(TCustomControl)
  private
     FWasDown: Boolean;
     FWordWrap: Boolean;
     FShowAccelChar: Boolean;
     FLayout: TTextLayout;
     FShadow: TBmsXPShadow;
     FAutoSize: Boolean;
     FAlignment: TAlignment;

     FImgNormal: TBitmap;
     FImgMouseOver: TBitmap;
     FImgMouseDown: TBitmap;
     FState: TBmsState;
     FChecked: Boolean;
     FOnCheck: TNotifyEvent;

     procedure setChecked    (Value: Boolean);
     procedure setOnCheck    (Value: TNotifyEvent);

     procedure hookMouseClick  (Sender: TObject);
     procedure HookTextChange  (var message: TMessage);   message CM_TEXTCHANGED;
     procedure HookMouseDown   (var Message: TMessage);   Message wm_lbuttondown;
     procedure HookMouseUp     (var Message: TMessage);   Message wm_lbuttonup;
     procedure hookFocusChanged(var Message: TMessage);   Message cm_focuschanged;
     procedure hookMouseEnter  (var Message: TMessage);   Message cm_mouseenter;
     procedure hookMouseLeave  (var Message: TMessage);   Message cm_mouseLeave;
     procedure hookKeyDown     (var Message: TWMKeyDown); Message wm_keyDown;
     procedure hookKeyUp       (var Message: TWMKeyUp);   Message wm_keyUp;
     procedure hookEnabled     (var Message: TMessage);   message CM_ENABLEDCHANGED;
     procedure DoDrawText      (var Rect: TRect; Flags: Longint);

     procedure _setAutoSize(Value: Boolean);
     procedure setWordWrap(Value: boolean);
     procedure setShowAccelChar(Value: boolean);
     procedure setAlignment(Value: TAlignment);
     procedure setLayout(Value: TTextLayout);
     procedure AdjustBounds;

    { Private declarations }
  protected
     procedure paint; override;
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;
    { Public declarations }
  published
     property WordWrap: Boolean read FWordWrap Write setWordWrap;
     property ShowAccelChar: Boolean read FShowAccelChar Write setShowAccelChar;
     property Layout: TTextLayout read FLayout Write setLayout;
     property AutoSize: Boolean read FAutoSize Write _setAutoSize;
     property Alignment: TAlignment read FAlignment Write setAlignment;
     property Shadow: TBmsXPShadow read FShadow Write FShadow;

     property Caption;
     property Checked:     Boolean read FChecked     Write setChecked default False;
     property Color;
     property Enabled;
     property ShowHint;
     property Anchors;
     property BiDiMode;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Font;
     property HelpContext;
     {$IFDEF VER140}
     property HelpKeyword;
     property HelpType;
     {$ENDIF}
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property TabOrder;

     property onCheck: TNotifyEvent read FOnCheck Write setOnCheck;
     property onContextPopup;
     property onDragDrop;
     property onDragOver;
     property onEndDock;
     property onEndDrag;
     property onEnter;
     property onExit;
     property onKeyDown;
     property onKeyPress;
     property onKeyUp;
     property onMouseDown;
     property onMouseMove;
     property onMouseUp;
     property onStartDock;
     property onStartDrag;
    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPCheckBox.setWordWrap(Value: boolean);
begin
   if FWordWrap <> Value then
   begin
      FWordWrap := Value;
      AdjustBounds;
      Invalidate;
   end;
end;

procedure TBmsXPCheckBox._setAutoSize(Value: Boolean);
begin
   if FAutoSize <> Value then
   begin
      FAutoSize := Value;
      Invalidate;
   end;
end;


procedure TBmsXPCheckBox.setLayout(Value: TTextLayout);
begin
   if FLayout <> Value then
   begin
      FLayout := Value;
      Invalidate;
   end;
end;

procedure TBmsXPCheckBox.setAlignment(Value: TAlignment);
begin
   if FAlignment <> Value then
   begin
      FAlignment := Value;
      Invalidate;
   end;
end;

procedure TBmsXPCheckBox.setShowAccelChar(Value: boolean);
begin
   if FShowAccelChar <> Value then
   begin
      FShowAccelChar := Value;
      Invalidate;
   end;
end;

procedure TBmsXPCheckBox.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Text: string;
  i: Integer;
begin
  Text := Caption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or FShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not FShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Canvas.Font := Font;
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end
  else
  begin
    i := FShadow.OffSet;

    if FShadow.Style = ssBottomRight then
       OffsetRect(Rect, 1*i, 1*i)
    else if FShadow.Style = ssBottom then
       OffsetRect(Rect, 0*i, 1*i)
    else if FShadow.Style = ssBottomLeft then
       OffsetRect(Rect,-1*i, 1*i)
    else if FShadow.Style = ssRight then
       OffsetRect(Rect,-1*i, 0*i)
    else if FShadow.Style = ssLeft then
       OffsetRect(Rect,1*i, 0*i)
    else if FShadow.Style = ssTopLeft then
       OffsetRect(Rect,-1*i, -1*i)
    else if FShadow.Style = ssTop then
       OffsetRect(Rect,0*i, -1*i)
    else if FShadow.Style = ssTopRight then
       OffsetRect(Rect,1*i, -1*i);

    Canvas.Font.Color := FShadow.Color;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);

    if FShadow.Style = ssBottomRight then
       OffsetRect(Rect, -1*i, -1*i)
    else if FShadow.Style = ssBottom then
       OffsetRect(Rect, 0*i, -1*i)
    else if FShadow.Style = ssBottomLeft then
       OffsetRect(Rect, 1*i,-1*i)
    else if FShadow.Style = ssRight then
       OffsetRect(Rect,1*i, 0*i)
    else if FShadow.Style = ssLeft then
       OffsetRect(Rect,-1*i, 0*i)
    else if FShadow.Style = ssTopLeft then
       OffsetRect(Rect, 1*i,  1*i)
    else if FShadow.Style = ssTop then
       OffsetRect(Rect,0*i, 1*i)
    else if FShadow.Style = ssTopRight then
       OffsetRect(Rect,-1*i, 1*i);

    Canvas.Font := Self.Font;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end;
end;

procedure TBmsXPCheckBox.AdjustBounds;
const
   WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
   DC: HDC;
   X: Integer;
   Rect: TRect;
   AAlignment: TAlignment;
begin
   if not (csReading in ComponentState) and AutoSize then
   begin
      Rect := ClientRect;
      Inc(Rect.Left,19);

      DC := GetDC(0);
      Canvas.Handle := DC;
      DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[FWordWrap]);
      Canvas.Handle := 0;
      ReleaseDC(0, DC);
      X := Left;
      AAlignment := FAlignment;

      if UseRightToLeftAlignment then
         ChangeBiDiModeAlignment(AAlignment);

      if AAlignment = taRightJustify then
         Inc(X, Width - Rect.Right);

      SetBounds(X, Top, Rect.Right, Rect.Bottom);
   end;
end;

procedure TBmsXPCheckBox.HookTextChange(var message: TMessage);
begin
   Invalidate;
   inherited;
end;

procedure TBmsXPCheckBox.hookEnabled(var Message: TMessage);
begin
   inherited;
   Invalidate;
end;

procedure TBmsXPCheckBox.hookKeyUp(var Message: TWMKeyUp);
var
   rRect: TRect;
begin
   inherited;
   
   if Message.CharCode = 32 then
   begin
      FChecked := not FChecked;
      Exclude(FState, sDown);
      rRect := Rect(0,0,14,height);
      InvalidateRect(Handle, @rRect, True);
   end;
end;

procedure TBmsXPCheckBox.hookKeyDown(var Message: TWMKeyDown);
var
   rRect: TRect;
begin
   inherited;
   
   if Message.CharCode = 32 then
   begin
      if not (sDown in FState) then
      begin
         Include(FState, sDown);
         rRect := Rect(0,0,14,Height);
         InvalidateRect(Handle, @rRect, True);
      end;
   end
   else if Message.CharCode = 13 then
   begin
      rRect := Rect(0,0,14,height);
      FChecked := not FChecked;
      InvalidateRect(Handle, @rRect, True);
   end;
end;

procedure TBmsXPCheckBox.setOnCheck(Value: TNotifyEvent);
begin
   FOnCheck := Value;
end;

procedure TBmsXPCheckBox.hookMouseClick(Sender: TObject);
begin
   FChecked := not FChecked;
   Invalidate;

   if Assigned(FOnCheck) then
      FOnCheck(Self);
end;

procedure TBmsXPCheckBox.setChecked(Value: Boolean);
var
   rRect: TRect;
begin
   if FChecked <> Value then
   begin
      FChecked := Value;

      rRect := Rect(0,0,14,Height);
      InvalidateRect(Handle, @rRect, True);
   end;
end;

procedure TBmsXPCheckBox.HookMouseDown(var Message: TMessage);
var
   rRect: TRect;
begin
   inherited;
   
   Self.SetFocus;
   Include(FState,sDown);

   rRect := Rect(0,0,14,Height);
   InvalidateRect(Handle, @rRect, True);
end;

procedure TBmsXPCheckBox.HookMouseUp(var Message: TMessage);
var
   rRect: TRect;
begin
   inherited;

   Exclude(FState, sDown);
   FWasDown := False;

   rRect := Rect(0,0,14,Height);
   InvalidateRect(Handle, @rRect, True);
end;

procedure TBmsXPCheckBox.hookFocusChanged(var Message: TMessage);
begin
   inherited;
   
   if Focused then
      Include(FState,sFocused)
   else
      Exclude(FState,sFocused);

   Invalidate;
end;

procedure TBmsXPCheckBox.hookMouseEnter(var Message: TMessage);
var
   rRect: TRect;
begin
   Include(FState,sMouseOver);

   if FWasDown then
   begin
      Include(FState,sDown);
      FWasDown := False;
   end;

   rRect := Rect(0,0,14,Height);
   InvalidateRect(Handle, @rRect, True);
end;

procedure TBmsXPCheckBox.hookMouseLeave(var Message: TMessage);
var
   rRect: TRect;
begin
   Exclude(FState,sMouseOver);

   if sDown in FState then
   begin
      FWasDown := True;
      Exclude(FState,sDown);
   end
   else
      FWasDown := False;

   rRect := Rect(0,0,14,Height);
   InvalidateRect(Handle, @rRect, True);
end;

procedure TBmsXPCheckBox.paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
   Rect1, CalcRect: TRect;
   DrawStyle: Longint;
   nTop: Integer;
begin

   Canvas.Brush.Color := Color;
   Canvas.Pen.Color := Color;
   Canvas.FillRect(Rect(0,0,Width,Height));

   nTop := (Height div 2) - 6;

   Canvas.Pen.Color := cbBorderColor;
   Canvas.Rectangle(0,nTop,13,nTop + 13);

   if FState = [] then
      BitBlt(Canvas.Handle, 1, nTop+1, 11, 11, FImgNormal.Canvas.Handle, 0, 0, SRCCOPY);
   if (sMouseOver in FState) or (sFocused in FState) then
      BitBlt(Canvas.Handle, 1, nTop+1, 11, 11, FImgMouseOver.Canvas.Handle, 0, 0, SRCCOPY);
   if sDown in FState then
      BitBlt(Canvas.Handle, 1, nTop+1, 11, 11, FImgMouseDown.Canvas.Handle, 0, 0, SRCCOPY);

   Canvas.Font := Self.Font;
   Canvas.Brush.Color := Color;

  with Canvas do
  begin
    Brush.Style := bsClear;
    Rect1 := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    if FLayout <> tlTop then
    begin
      CalcRect := Rect1;
      Inc(CalcRect.Left, 19);
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if FLayout = tlBottom then OffsetRect(Rect1, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect1, 0, (Height - CalcRect.Bottom) div 2);
    end;
    Inc(Rect1.Left, 19);
    DoDrawText(Rect1, DrawStyle);
  end;

  if FAutoSize then
  begin
     Self.Width := Self.Canvas.TextWidth(Caption) + 19;
     Self.Height := Self.Canvas.TextHeight(Caption) + 2;
  end;

{   if Self.Enabled then
      Canvas.TextOut(19, (Height div 2) - (Canvas.TextHeight(Caption) div 2), Caption)
   else
   begin
      Canvas.Font.Color := clBtnHighlight;
      Canvas.TextOut(20, (Height div 2) - (Canvas.TextHeight(Caption) div 2)+1, Caption);
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Color := clBtnShadow;
      Canvas.TextOut(19, (Height div 2) - (Canvas.TextHeight(Caption) div 2), Caption)
   end;}

   if FChecked then
   begin
      Canvas.Pen.Color := cbCheckColor;
      Canvas.MoveTo(3, nTop + 5);
      Canvas.LineTo(7, nTop + 9);

      Canvas.MoveTo(3, nTop + 6);
      Canvas.LineTo(6, nTop + 9);

      Canvas.MoveTo(3, nTop + 7);
      Canvas.LineTo(6, nTop + 10);

      Canvas.MoveTo(6, nTop + 6);
      Canvas.LineTo(10,nTop + 2);

      Canvas.MoveTo(6, nTop + 7);
      Canvas.LineTo(10,nTop + 3);

      Canvas.MoveTo(7, nTop + 7);
      Canvas.LineTo(10,nTop + 4);

   end;

   Canvas.Brush.Color := clNone;

   if sFocused in FState then
      Canvas.DrawFocusRect(Rect(17, 0, Canvas.TextWidth(Caption)+21, Height));
end;

constructor TBmsXPCheckBox.Create(aOwner: TComponent);
begin
   inherited;

   FShadow := TBmsXPShadow.Create(Self);
   FShadow.Color := Self.Color;
   FShadow.OffSet := 0;

   Self.onClick := hookMouseClick;
   Self.TabStop := True;

   FWasDown := False;
   FChecked := False;
   FShowAccelChar := True;

   Height := 13;
   Width := 100;

   // Estado normal
   FImgNormal    := TBitmap.Create;
   FImgNormal.Width  := 11;
   FImgNormal.Height := 11;
   criaGradient(11, 11, cbBgStartColor, cbBgEndColor, 10, gkHorizontal, False, FImgNormal);

   // Quando passar o mouse por cima
   FImgMouseOver := TBitmap.Create;
   FImgMouseOver.Width  := 11;
   FImgMouseOver.Height := 11;
   criaGradient(11, 11, cbEnterStartColor, cbEnterEndColor, 10, gkHorizontal, False, FImgMouseOver);
   FImgMouseOver.Canvas.Pen.Color := clWhite;
   FImgMouseOver.Canvas.Brush.Color := clWhite;
   FImgMouseOver.Canvas.Rectangle(2,2,9,9);

   // Qaundo clicado
   FImgMouseDown := TBitmap.Create;
   FImgMouseDown.Width  := 11;
   FImgMouseDown.Height := 11;
   criaGradient(11, 11, cbDownStartColor, cbDownEndColor, 10, gkHorizontal, False, FImgMouseDown);
end;

destructor TBmsXPCheckBox.Destroy;
begin
   inherited;
   FImgNormal.FreeImage;
   FImgNormal.Free;
   FImgMouseOver.FreeImage;
   FImgMouseOver.Free;
   FImgMouseDown.FreeImage;
   FImgMouseDown.Free;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPCheckBox]);
end;

end.
