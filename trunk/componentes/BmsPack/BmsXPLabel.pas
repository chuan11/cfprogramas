{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPLabel                                              }
{ Label com sombra, podendo escolher direcao e tamanho     }
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

unit BmsXPLabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, stdCtrls, Graphics, bmsXPUtils;

type

  TBmsXPLabel = class(TGraphicControl)
  private
     FAlignment    : TAlignment;
     FWordWrap     : Boolean;
     FShowAccelChar: Boolean;
     FTransparent  : Boolean;
     FLayout       : TTextLayout;
     FShadow       : TBmsXPShadow;
     FAutoSize     : Boolean;

     procedure HookTextChange (var message: TMessage); message CM_TEXTCHANGED;
     procedure _setAutoSize(Value: Boolean);
     procedure setWordWrap(Value: boolean);
     procedure setTransparent(Value: boolean);
     procedure setShowAccelChar(Value: boolean);
     procedure setAlignment(Value: TAlignment);
     procedure setLayout(Value: TTextLayout);
     procedure AdjustBounds;
     procedure DoDrawText(var Rect: TRect; Flags: Longint);
    { Private declarations }
  protected
     procedure paint; override;
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;
    { Public declarations }
  published
     property Alignment: TAlignment read FAlignment Write setAlignment;
     property Caption;
     property Color;
     property AutoSize: Boolean read FAutoSize Write _setAutoSize;
     property Font;
     property Enabled;
     property Shadow: TBmsXPShadow read FShadow Write FShadow;
     property Transparent: Boolean read FTransparent Write SetTransparent default False;
     property Layout: TTextLayout read FLayout Write setLayout;
     property WordWrap: Boolean read FWordWrap Write setWordWrap;
     property ShowAccelChar: Boolean read FShowAccelChar Write setShowAccelChar;

     property OnClick;
     property OnMouseMove;
     property OnMouseDown;
     property OnMouseUP;

    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPLabel.HookTextChange(var message: TMessage);
begin
   Invalidate;
   inherited;
end;

procedure TBmsXPLabel._setAutoSize(Value: Boolean);
begin
   if FAutoSize <> Value then
   begin
      FAutoSize := Value;
      Invalidate;
   end;
end;


procedure TBmsXPLabel.setTransparent(Value: boolean);
begin
   if FTransparent <> Value then
   begin
      FTransparent := Value;
      Invalidate;
   end;
end;

procedure TBmsXPLabel.setLayout(Value: TTextLayout);
begin
   if FLayout <> Value then
   begin
      FLayout := Value;
      Invalidate;
   end;
end;

procedure TBmsXPLabel.setAlignment(Value: TAlignment);
begin
   if FAlignment <> Value then
   begin
      FAlignment := Value;
      Invalidate;
   end;
end;

procedure TBmsXPLabel.setShowAccelChar(Value: boolean);
begin
   if FShowAccelChar <> Value then
   begin
      FShowAccelChar := Value;
      Invalidate;
   end;
end;

procedure TBmsXPLabel.DoDrawText(var Rect: TRect; Flags: Longint);
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

procedure TBmsXPLabel.AdjustBounds;
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

procedure TBmsXPLabel.setWordWrap(Value: boolean);
begin
   if FWordWrap <> Value then
   begin
      FWordWrap := Value;
      AdjustBounds;
      Invalidate;
   end;
end;

procedure TBmsXPLabel.paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    if FLayout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if FLayout = tlBottom then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;

  if FAutoSize then
  begin
     Self.Width := Self.Canvas.TextWidth(Caption) + 2;
     Self.Height := Self.Canvas.TextHeight(Caption) + 2;
  end;
end;

constructor TBmsXPLabel.Create(aOwner: TComponent);
begin
   inherited;
   FShadow := TBmsXPShadow.Create(Self);
   FShadow.OffSet := 1;
   FShadow.Color := clWhite;
   FShadow.Style := ssBottomRight;
   FShowAccelChar := True;

   _SetAutoSize(True);
   Invalidate;
end;

destructor TBmsXPLabel.Destroy;
begin
   inherited;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPLabel]);
end;

end.
