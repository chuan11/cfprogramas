{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPButton                                             }
{ Botão no estilo do Windows XP                            }
{                                                          }
{ Ultima atualização: 26/08/2003                           }
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

unit BmsXPButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, bmsXPUtils, Graphics, bmsXPConsts, Forms, StdCtrls, Dialogs;

type
  TBmsXPButton = class(TCustomControl)
  private
     FLayout       : TTextLayout;
     FShowAccelChar: Boolean;
     FWordWrap     : Boolean;
     FState        : TBmsState;
     FWasDown      : Boolean;
     FNormalImg    : TBitmap;
     FFocusImg     : TBitmap;
     FDownImg      : TBitmap;
     FHotImg       : TBitmap;
     FAlignment    : TAlignment;
     FModalResult  : TModalResult;

     procedure geraImagens;
     procedure AdjustBounds;
     procedure DoDrawText       (var Rect: TRect; Flags: Longint);
     procedure doModalResult    (const ModalResult: TModalResult);
     procedure HookMouseDown    (var Message: TMessage);   Message wm_lbuttondown;
     procedure HookMouseUp      (var Message: TMessage);   Message wm_lbuttonup;
     procedure hookFocusChanged (var Message: TMessage);   Message cm_focuschanged;
     procedure hookMouseEnter   (var Message: TMessage);   Message cm_mouseenter;
     procedure hookMouseLeave   (var Message: TMessage);   Message cm_mouseLeave;
     procedure hookKeyDown      (var Message: TWMKeyDown); Message wm_keyDown;
     procedure hookKeyUp        (var Message: TWMKeyUp);   Message wm_keyUp;
     procedure hookEnabled      (var Message: TMessage);   message CM_ENABLEDCHANGED;
     procedure hookResized      (var Message: TMessage);   message wm_size;
     procedure HookTextChange   (var Message: TMessage);   message CM_TEXTCHANGED;
     procedure HookDialogChar   (var Message: TCmDialogChar);   message CM_DIALOGCHAR;
     procedure setAlignment     (Value: TAlignment);
     procedure setModalResult   (Value: TModalResult);
     procedure setWordWrap      (Value: boolean);
     procedure setShowAccelChar (Value: boolean);
     procedure setLayout        (Value: TTextLayout);
    { Private declarations }
  protected
     procedure paint; override;
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;
    { Public declarations }
  published
     property Alignment: TAlignment read FAlignment Write setAlignment default taCenter;
     property Caption;
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
     property ModalResult: TModalResult read FModalResult Write setModalResult default mrNone;
     property Layout: TTextLayout read FLayout Write setLayout;
     property WordWrap: Boolean read FWordWrap Write setWordWrap;
     property ShowAccelChar: Boolean read FShowAccelChar Write setShowAccelChar;
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property TabOrder;

     property OnClick;
     property OnContextPopup;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnEnter;
     property OnExit;
     property OnKeyDown;
     property OnKeyPress;
     property OnKeyUp;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnStartDock;
     property OnStartDrag;
    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPButton.HookDialogChar(var Message: TCMDialogChar);
begin
   if Enabled and FShowAccelChar and IsAccel(Message.CharCode, Caption) then
   begin
      if CanFocus then
      begin
         SetFocus;
         Self.OnClick(Self);
         Message.Result := 1;
      end;
   end;
end;

procedure TBmsXPButton.setLayout(Value: TTextLayout);
begin
   if FLayout <> Value then
   begin
      FLayout := Value;
      Invalidate;
   end;
end;

procedure TBmsXPButton.setShowAccelChar(Value: boolean);
begin
   if FShowAccelChar <> Value then
   begin
      FShowAccelChar := Value;
      Invalidate;
   end;
end;

procedure TBmsXPButton.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Text: string;
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
    if sDown in FState then
    begin
       Inc(Rect.Left, 1);
       Inc(Rect.Top, 1);
    end;

    Canvas.Font := Self.Font;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);

  end;
end;

procedure TBmsXPButton.setWordWrap(Value: boolean);
begin
   if FWordWrap <> Value then
   begin
      FWordWrap := Value;
      AdjustBounds;
      Invalidate;
   end;
end;

procedure TBmsXPButton.AdjustBounds;
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
      Inc(Rect.Left,4);
      Dec(Rect.Right,4);

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
         Inc(X, Width - Rect.Right - 4);

      SetBounds(X, Top, Rect.Right, Rect.Bottom);
   end;
end;

procedure TBmsXPButton.doModalResult(const ModalResult: TModalResult);
begin
   if (Parent <> nil) and (ModalResult <> mrNone) then
      GetParentForm(self).ModalResult := FModalResult;
end;

procedure TBmsXPButton.setModalResult(Value: TModalResult);
begin
   if FModalResult <> Value then
      FModalResult := Value;
end;

procedure TBmsXPButton.setAlignment(Value: TAlignment);
begin
   if FAlignment <> Value then
   begin
      FAlignment := Value;
      Invalidate;
   end;
end;

procedure TBmsXPButton.geraImagens;

   procedure geraBorda(var img: TBitmap; bdClara, bdEscura: TColor; Enabled: Boolean);
   begin
      with img.Canvas do
      begin
         if Enabled then
         begin
            Pixels[0,1]                      := bdClara;
            Pixels[1,1]                      := $00A67E56; // Borda 3
            Pixels[1,0]                      := bdClara;
            Pixels[1,2]                      := $00D9CBBE; // Borda 4
            Pixels[2,1]                      := $00D9CBBE; // Borda 4

            Pixels[img.Width-2,0]            := bdClara;
            Pixels[img.Width-1,1]            := bdClara;
            Pixels[img.Width-2,1]            := $00A67E56; // Borda 3
            Pixels[img.Width-3,1]            := $00D9CBBE; // Borda 4
            Pixels[img.Width-2,2]            := $00D9CBBE; // Borda 4

            Pixels[0,img.Height-2]           := bdClara;
            Pixels[1,img.Height-1]           := bdClara;
            Pixels[1,img.Height-2]           := $00A67E56; // Borda 3
            Pixels[1,img.Height-3]           := $00D9CBBE; // Borda 4
            Pixels[2,img.Height-2]           := $00D9CBBE; // Borda 4

            Pixels[img.Width-2,img.Height-1] := bdClara;
            Pixels[img.Width-1,img.Height-2] := bdClara;
            Pixels[img.Width-2,img.Height-2] := $00A67E56; // Borda 3
            Pixels[img.Width-3,img.Height-2] := $00D9CBBE; // Borda 4
            Pixels[img.Width-2,img.Height-3] := $00D9CBBE; // Borda 4

            Pen.Color := bdEscura;
            MoveTo(2, 0);
            LineTo(Width-2,0);

            MoveTo(0, 2);
            LineTo(0,Height-2);

            MoveTo(Width-1, 2);
            LineTo(Width-1, Height-2);

            MoveTo(2,Height-1);
            LineTo(Width-2,Height-1);
         end
         else
         begin
            Pixels[0,1]                      := $00BEC6CE;
            Pixels[1,1]                      := $00BEC6CE; // Borda 3
            Pixels[1,0]                      := $00BEC6CE;
            Pixels[1,2]                      := $00BEC6CE; // Borda 4
            Pixels[2,1]                      := $00BEC6CE; // Borda 4

            Pixels[img.Width-2,0]            := $00BEC6CE;
            Pixels[img.Width-1,1]            := $00BEC6CE;
            Pixels[img.Width-2,1]            := $00BEC6CE; // Borda 3
            Pixels[img.Width-3,1]            := $00BEC6CE; // Borda 4
            Pixels[img.Width-2,2]            := $00BEC6CE; // Borda 4

            Pixels[0,img.Height-2]           := $00BEC6CE;
            Pixels[1,img.Height-1]           := $00BEC6CE;
            Pixels[1,img.Height-2]           := $00BEC6CE; // Borda 3
            Pixels[1,img.Height-3]           := $00BEC6CE; // Borda 4
            Pixels[2,img.Height-2]           := $00BEC6CE; // Borda 4

            Pixels[img.Width-2,img.Height-1] := $00BEC6CE;
            Pixels[img.Width-1,img.Height-2] := $00BEC6CE;
            Pixels[img.Width-2,img.Height-2] := $00BEC6CE; // Borda 3
            Pixels[img.Width-3,img.Height-2] := $00BEC6CE; // Borda 4
            Pixels[img.Width-2,img.Height-3] := $00BEC6CE; // Borda 4

            Pen.Color := $00BEC6CE;
            MoveTo(2, 0);
            LineTo(Width-2,0);

            MoveTo(0, 2);
            LineTo(0,Height-2);

            MoveTo(Width-1, 2);
            LineTo(Width-1, Height-2);

            MoveTo(2,Height-1);
            LineTo(Width-2,Height-1);
         end;
      end;
   end;

begin
   FNormalImg.Width  := Self.Width;
   FNormalImg.Height := Self.Height;
   FFocusImg.Width   := Self.Width;
   FFocusImg.Height  := Self.Height;
   FHotImg.Width     := Self.Width;
   FHotImg.Height    := Self.Height;
   FDownImg.Width    := Self.Width;
   FDownImg.Height   := Self.Height;

   // Normal
   if Self.Enabled then
      criaGradient(Self.Width, Self.Height, clWhite  , $00C7D6D6, 20, gkHorizontal, False, FNormalImg)
   else
   begin
      FNormalImg.Canvas.Brush.Color := $00EEF6F6;
      FNormalImg.Canvas.FillRect(FNormalImg.Canvas.ClipRect);
   end;
   geraBorda(FNormalImg, $00AF9F70, $006F3700, Self.Enabled);

   // Focus
   criaGradient(Self.Width, Self.Height, $00FFE7CF, $00F08770, 20, gkHorizontal, False, FFocusImg);
   geraBorda(FFocusImg, $00AF9F70, $006F3700, Self.Enabled);
   BitBlt(FFocusImg.Canvas.Handle, 3, 3, Self.Width -6, Self.Height -6, FNormalImg.Canvas.Handle, 2, 2, SRCCOPY);

   // Hot (mosueover)
   criaGradient(Self.Width, Self.Height, $00CFF0FF, $000098EF, 20, gkHorizontal, False, FHotImg);
   geraBorda(FHotImg, $00AF9F70, $006F3700, Self.Enabled);
   BitBlt(FHotImg.Canvas.Handle, 3, 3, Self.Width -6, Self.Height -6, FNormalImg.Canvas.Handle, 2, 2, SRCCOPY);
   // Down
   criaGradient(Self.Width, Self.Height, $00C0CFD0, $00EFF0F0, 20, gkHorizontal, False, FDownImg);
   geraBorda(FDownImg, $00AF9F70, $006F3700, Self.Enabled);
end;

procedure TBmsXPButton.HookTextChange(var Message: TMessage);
begin
   Invalidate;
   inherited;
end;

procedure TBmsXPButton.hookResized(var Message: TMessage);
begin
   geraImagens;
   inherited;
end;

procedure TBmsXPButton.hookEnabled(var Message: TMessage);
begin
   geraImagens;
   Invalidate;
   inherited;
end;

procedure TBmsXPButton.hookKeyUp(var Message: TWMKeyUp);
begin
   if Message.CharCode = 32 then
   begin
      Exclude(FState, sDown);
      Invalidate;

      if Assigned(Self.onClick) then
         Self.OnClick(Self);

      doModalResult(FModalResult);
   end;
   inherited;
end;

procedure TBmsXPButton.hookKeyDown(var Message: TWMKeyDown);
begin
   if (Message.CharCode = 32) and not (sDown in FState) then
   begin
      Include(FState, sDown);
      Invalidate;
   end
   else if Message.CharCode = 13 then
   begin
      if Assigned(Self.OnClick) then
         Self.OnClick(Self);

      doModalResult(FModalResult);
   end;
   inherited;
end;

procedure TBmsXPButton.HookMouseDown(var Message: TMessage);
begin
   if not (sDown in FState) then
   begin
      Self.SetFocus;
      Include(FState,sDown);
      Invalidate;
   end;
   inherited;
end;

procedure TBmsXPButton.HookMouseUp(var Message: TMessage);
begin
   Exclude(FState, sDown);
   FWasDown := False;

   Invalidate;
   inherited;

   if sMouseOver in FState then
      doModalResult(FModalResult);
end;

procedure TBmsXPButton.hookFocusChanged(var Message: TMessage);
begin
   inherited;

   if Focused then
      Include(FState,sFocused)
   else
      Exclude(FState,sFocused);

   Invalidate;
end;

procedure TBmsXPButton.hookMouseEnter(var Message: TMessage);
begin
   if not (sMouseOver in FState) then
   begin
      Include(FState,sMouseOver);

      if FWasDown then
         Include(FState,sDown);

      Invalidate;
   end;
end;

procedure TBmsXPButton.hookMouseLeave(var Message: TMessage);
begin
   Exclude(FState,sMouseOver);

   if sDown in FState then
   begin
      FWasDown := True;
      Exclude(FState, sDown);
   end
   else
      FWasDown := False;

   Invalidate;
end;

procedure TBmsXPButton.paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
   Rect1, CalcRect: TRect;
   DrawStyle: Longint;
   txtPos: TPoint;
begin

   if FState = [] then
      BitBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height, FNormalImg.Canvas.Handle, 0, 0, SRCCOPY);
   if sFocused in FState then
      BitBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height, FFocusImg.Canvas.Handle, 0, 0, SRCCOPY);
   if sMouseOver in FState then
      BitBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height, FHotImg.Canvas.Handle, 0, 0, SRCCOPY);
   if sDown in FState then
      BitBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height, FDownImg.Canvas.Handle, 0, 0, SRCCOPY);

   Canvas.Font := Self.Font;
   Canvas.Brush.Style := bsClear;

   if FAlignment = taLeftJustify then
      txtPos.X := 5
   else if FAlignment = taCenter then
      txtPos.X := (Self.Width div 2) - (Canvas.TextWidth(Self.Caption) div 2)
   else if FAlignment = taRightJustify then
      txtPos.X := Self.Width - Canvas.TextWidth(Self.Caption) - 5;

   txtPos.Y := (Self.Height div 2) - (Canvas.TextHeight(Self.Caption) div 2);

   if sDown in FState then
   begin
      txtPos.X := txtPos.X + 1;
      txtPos.Y := txtPos.Y + 1;
   end;

{   if Enabled then
      Self.Canvas.TextOut(txtPos.X, txtPos.Y, Self.Caption)
   else
   begin
      Canvas.Font.Color := clBtnHighlight;
      Canvas.TextOut(txtPos.X+1, txtPos.Y+1, Caption);
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Color := clBtnShadow;
      Canvas.TextOut(txtPos.X, txtPos.Y, Caption)
   end;}

  with Canvas do
  begin
    Brush.Style := bsClear;
    Rect1 := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    if FLayout <> tlTop then
    begin
      CalcRect := Rect1;
      Inc(CalcRect.Left, 4);
      Dec(CalcRect.Right, 4);
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if FLayout = tlBottom then OffsetRect(Rect1, 0, Height - CalcRect.Bottom - 4)
      else OffsetRect(Rect1, 0, (Height - CalcRect.Bottom) div 2);
    end
    else
    begin
       Inc(Rect1.Top, 4);
       Dec(Rect1.Bottom,4);
    end;

    Inc(Rect1.Left, 4);
    Dec(Rect1.Right, 4);
    DoDrawText(Rect1, DrawStyle);
  end;

   Canvas.Brush.Style := bsSolid;
   if sFocused in FState then
      Canvas.DrawFocusRect(Rect(3,3,Self.Width-3,Self.Height-3));

end;

constructor TBmsXPButton.Create(aOwner: TComponent);
begin
   inherited;
   FNormalImg     := TBitmap.Create;
   FHotImg        := TBitmap.Create;
   FFocusImg      := TBitmap.Create;
   FDownImg       := TBitmap.Create;
   FAlignment     := taCenter;
   FWasDown       := False;
   FShowAccelChar := True;

   Self.Height := 21;
   Self.Width := 80;

   Self.TabStop := True;
end;

destructor TBmsXPButton.Destroy;
begin
   FNormalImg.Free;
   FHotImg.Free;
   FFocusImg.Free;
   FDownImg.Free;

   inherited;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPButton]);
end;

end.
