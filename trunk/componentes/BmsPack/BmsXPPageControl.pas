{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPPageControl                                        }
{ PageControl no estilo do windows XP                      }
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

unit BmsXPPageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ComCtrls, graphics, Forms, bmsXPUtils, dialogs, extctrls, bmsXPForm;

type
  TBmsXPPageControl = class(TPageControl)
  private
     FGrad: TBitmap;

     procedure paintTop (numTab: Integer; ativo: boolean);
     procedure hookFocus(var Msg: TMessage); Message cm_focuschanged;
     procedure hookMLeave(var Msg: TWmMouseMove); message CM_MOUSELEAVE;
     procedure hookMMove(var Msg: TWmMouseMove); message WM_MOUSEMOVE;
     procedure hookPaint(var Msg: TMessage); message WM_PAINT;
     procedure hookClick(var Msg: TMessage); message WM_LBUTTONDOWN;
     procedure paintTab(numTab: Integer);
     procedure hookChange(Sender: TObject);
    { Private declarations }
  protected
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;
    { Public declarations }
  published
     property TabStop;
    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPPageCOntrol.hookMLeave(var Msg: TWmMouseMove);
var
   nAux: Integer;
begin
   if Self.HotTrack then
   begin
      if not (csDesigning in ComponentState) then
      begin
         for nAux := 0 to Self.PageCount-1 do
         begin
            if Self.ActivePageIndex <> nAux then
               painttop(nAux, False);
         end;

         painttop(Self.ActivePageIndex, True);
      end;
   end;
end;

procedure TBmsXPPageControl.paintTop(numTab: Integer; ativo: boolean);
var
   r: TRect;
begin
   r := Self.TabRect(numTab);

   if numTab = Self.ActivePageIndex then
      InflateRect(r,3,2);

   with Self.Canvas do
   begin
      if ativo then
      begin
         InflateRect(r, -1, 0);

         Pen.Color := $002C8BE6;
         MoveTo(r.Left+2, r.Top);
         LineTo(r.Right-2, r.Top);

         Pen.Color := $003CC7FF;
         MoveTo(r.Left, r.Top+1);
         LineTo(r.Right, r.Top+1);

         MoveTo(r.Left, r.Top+2);
         LineTo(r.Right, r.Top+2);

         Pixels[r.Left  , r.Top  ] := Self.Color;
         Pixels[r.Left  , r.Top+1] := $008EC6E1;
         Pixels[r.Left  , r.Top+2] := $0053A1DD;
         Pixels[r.Left+1, r.Top  ] := $008EC6E1;
         Pixels[r.Left+1, r.Top+1] := $00319FEE;
         Pixels[r.Left+1, r.Top+2] := $0038B8F9;
         Pixels[r.Left+2, r.Top  ] := $003197E7;
         Pixels[r.Left+2, r.Top+1] := $0038B9F9;
         Pixels[r.Left+2, r.Top+2] := $003CC7FF;

         Pixels[r.Right-1, r.Top  ] := Self.Color;
         Pixels[r.Right-1, r.Top+1] := $008EC6E1;
         Pixels[r.Right-1, r.Top+2] := $0053A1DD;
         Pixels[r.Right-2, r.Top  ] := $008EC6E1;
         Pixels[r.Right-2, r.Top+1] := $00319FEE;
         Pixels[r.Right-2, r.Top+2] := $0038B8F9;
         Pixels[r.Right-3, r.Top  ] := $003197E7;
         Pixels[r.Right-3, r.Top+1] := $0038B9F9;
         Pixels[r.Right-3, r.Top+2] := $003CC7FF;
      end
      else
      begin
         Inc(r.Left,1);
         Pen.Color := $00B4A791;
         MoveTo(r.Left+2, r.Top);
         LineTo(r.Right-2, r.Top);

         Pen.Color := clWhite;
         MoveTo(r.Left, r.Top+1);
         LineTo(r.Right, r.Top+1);

         MoveTo(r.Left, r.Top+2);
         LineTo(r.Right, r.Top+2);

         Pixels[r.Left  , r.Top  ] := Self.Color;
         Pixels[r.Left  , r.Top+1] := $00D0D6D0;
         Pixels[r.Left  , r.Top+2] := $00BFB9A9;
         Pixels[r.Left+1, r.Top  ] := $00D0D6D0;
         Pixels[r.Left+1, r.Top+1] := $00CDC4B6;
         Pixels[r.Left+1, r.Top+2] := $00E2E9E3;

         if numTab-1 <> Self.ActivePageIndex then
         begin
            Pixels[r.Left+2, r.Top  ] := $00BFB9A9;
            Pixels[r.Left+2, r.Top+1] := $00ECE9E4;
         end
         else
         begin
            Pen.Color := $00B4A791;
            MoveTo(r.Left, r.Top);
            LineTo(r.Left, r.Bottom);
         end;

         Pixels[r.Right-1, r.Top  ] := Self.Color;
         Pixels[r.Right-1, r.Top+1] := $00D0D6D0;
         Pixels[r.Right-1, r.Top+2] := $00BFB9A9;
         Pixels[r.Right-2, r.Top  ] := $00D0D6D0;
         Pixels[r.Right-2, r.Top+1] := $00CDC4B6;
         Pixels[r.Right-2, r.Top+2] := $00E2E9E3;

         if numTab+1 <> Self.ActivePageIndex then
         begin
            Pixels[r.Right-3, r.Top  ] := $00BFB9A9;
            Pixels[r.Right-3, r.Top+1] := $00ECE9E4;
         end
         else
         begin
            Pen.Color := $00B4A791;
            MoveTo(r.Right-2, r.Top);
            LineTo(r.Right-2, r.Bottom);
         end;
      end;
   end;
end;

procedure TBmsXPPageControl.hookMMove(var Msg: TWMMouseMove);
var
   nAux: Integer;
   rAux: TRect;
begin
   if Self.HotTrack then
   begin
      if not (csDesigning in ComponentState) then
      begin
         for nAux := 0 to Self.PageCount-1 do
         begin
            if (Self.ActivePageIndex <> nAux) then
            begin
               rAux := TabRect(nAux);

               if (Msg.xPos > rAux.Left) and (Msg.xPos < rAux.Right) and (Msg.yPos > rAux.Top) and (Msg.yPos < rAux.Bottom) then
                  paintTop(nAux, True)
               else
                  paintTop(nAux, False);
            end
         end;

         paintTop(Self.ActivePageIndex, True);
      end;
   end;
end;

procedure TBmsXPPageControl.hookClick(var Msg: TMessage);
var
   r: TRect;
begin
   if not (csDesigning in ComponentState) then
      Self.SetFocus;

   r := Self.TabRect(Self.ActivePageIndex);
   InvalidateRect(Self.Handle, @r, False);
   inherited;
end;

procedure TBmsXPPageControl.hookFocus(var Msg: TMessage);
var
   r: TRect;
begin
   r := Self.TabRect(Self.ActivePageIndex);
   InvalidateRect(Self.Handle, @r, False);
   inherited;
end;

procedure TBmsXPPageControl.hookChange(Sender: TObject);
var
   r: TRect;
begin
   r := Self.TabRect(Self.ActivePageIndex);
   InvalidateRect(Self.Handle, @r, False);
   inherited;
end;

procedure TBmsXPPageControl.paintTab(numTab: Integer);
var
   bAtivo: Boolean;
   r: TRect;
   sTexto: string;
begin
   bAtivo := numTab = Self.ActivePageIndex;
   r := Self.TabRect(numTab);
   sTexto := Self.Pages[numTab].Caption;

   with Self.Canvas do
   begin
      if bAtivo then
      begin
         InflateRect(r,2,2);
         Pen.Color := $00B4A791;
         Brush.Color := clWhite;

         Inc(r.Bottom);
         Rectangle(r);

         Pen.Color := $002C8BE6;
         MoveTo(r.Left+2, r.Top);
         LineTo(r.Right-2, r.Top);

         Pen.Color := $003CC7FF;
         MoveTo(r.Left, r.Top+1);
         LineTo(r.Right, r.Top+1);

         MoveTo(r.Left, r.Top+2);
         LineTo(r.Right, r.Top+2);

         Pixels[r.Left  , r.Top  ] := Self.Color;
         Pixels[r.Left  , r.Top+1] := $008EC6E1;
         Pixels[r.Left  , r.Top+2] := $0053A1DD;
         Pixels[r.Left+1, r.Top  ] := $008EC6E1;
         Pixels[r.Left+1, r.Top+1] := $00319FEE;
         Pixels[r.Left+1, r.Top+2] := $0038B8F9;
         Pixels[r.Left+2, r.Top  ] := $003197E7;
         Pixels[r.Left+2, r.Top+1] := $0038B9F9;
         Pixels[r.Left+2, r.Top+2] := $003CC7FF;

         Pixels[r.Right-1, r.Top  ] := Self.Color;
         Pixels[r.Right-1, r.Top+1] := $008EC6E1;
         Pixels[r.Right-1, r.Top+2] := $0053A1DD;
         Pixels[r.Right-2, r.Top  ] := $008EC6E1;
         Pixels[r.Right-2, r.Top+1] := $00319FEE;
         Pixels[r.Right-2, r.Top+2] := $0038B8F9;
         Pixels[r.Right-3, r.Top  ] := $003197E7;
         Pixels[r.Right-3, r.Top+1] := $0038B9F9;
         Pixels[r.Right-3, r.Top+2] := $003CC7FF;

         Pen.Color := clWhite;
         MoveTo(r.Left+1, Self.DisplayRect.Top-4);
         LineTo(r.Right-1, Self.DisplayRect.Top-4);

         Dec(r.Top,2);
      end
      else
      begin
         r.Left := r.Left + 1;

         Pen.Color := $00B4A791;
         StretchBlt(Self.Canvas.Handle, r.Left, r.Top, r.Right-r.Left,r.Bottom, FGrad.Canvas.Handle, 0, 0, 2, 21, SRCCOPY);
         Brush.Style := bsClear;
         Inc(r.Bottom);
         Rectangle(r);

         Pixels[r.Left  , r.Top  ] := Self.Color;
         Pixels[r.Left  , r.Top+1] := $00D0D6D0;
         Pixels[r.Left  , r.Top+2] := $00BFB9A9;
         Pixels[r.Left+1, r.Top  ] := $00D0D6D0;
         Pixels[r.Left+1, r.Top+1] := $00CDC4B6;
         Pixels[r.Left+1, r.Top+2] := $00E2E9E3;
         Pixels[r.Left+2, r.Top  ] := $00BFB9A9;
         Pixels[r.Left+2, r.Top+1] := $00ECE9E4;

         Pixels[r.Right-1, r.Top  ] := Self.Color;
         Pixels[r.Right-1, r.Top+1] := $00D0D6D0;
         Pixels[r.Right-1, r.Top+2] := $00BFB9A9;
         Pixels[r.Right-2, r.Top  ] := $00D0D6D0;
         Pixels[r.Right-2, r.Top+1] := $00CDC4B6;
         Pixels[r.Right-2, r.Top+2] := $00E2E9E3;
         Pixels[r.Right-3, r.Top  ] := $00BFB9A9;
         Pixels[r.Right-3, r.Top+1] := $00ECE9E4;
      end;

      Canvas.Font := Self.Font;
      Brush.Style := bsClear;

      TextOut(r.Left + (((r.Right  - r.Left) div 2) - (TextWidth (sTexto) div 2)),
              r.Top  + (((r.Bottom - r.Top ) div 2) - (TextHeight(sTexto) div 2)),
              sTexto);

      Brush.Style := bsSolid;

      if (Self.Focused) and (bAtivo) then
      begin
         InflateRect(r,-4,-5);
         DrawFocusRect(r);
      end;
   end;
end;

procedure TBmsXPPageControl.hookPaint(var Msg: TMessage);
var
   p: TPaintStruct;
   nAux: Integer;
   rAux, rLin: TRect;
begin
   BeginPaint(Self.Handle, p);
   EndPaint(Self.Handle, p);

   // Pinta as tabulações

   Canvas.Brush.Color := TPanel(Parent).Color;

   Canvas.FillRect(Rect(0, 0, Self.Width, 21));
   Canvas.Pen.Width := 1;

   for nAux := 0 to Self.PageCount-1 do
   begin
      if Self.ActivePageIndex <> nAux then
      begin
         PaintTab(nAux);
         Self.Pages[nAux].Brush.Color := clWhite;
         Self.Pages[nAux].Repaint;
      end;
   end;
   
   if Self.ActivePageIndex <> -1 then
   begin
      nAux := Self.ActivePageIndex;
      PaintTab(nAux);
      Self.Pages[nAux].Brush.Color := clWhite;
      Self.Pages[nAux].Repaint;
   end;

   rLin := tabRect(nAux);

   Self.Color := TForm(Parent).Color;
   // Pinta o corpo
   Self.Canvas.Brush.Color := $00B4A791;

   rAux := Self.DisplayRect;
   InflateRect(rAux, 4, 4);
   Self.Canvas.FrameRect(rAux);
   Self.Canvas.Brush.Color := clWhite;

   if Self.PageCount <> 0 then
   begin
      InflateRect(rAux, -1, -1);
      Self.Canvas.FrameRect(rAux);
      InflateRect(rAux, -1, -1);
      Self.Canvas.FrameRect(rAux);
      InflateRect(rAux, -1, -1);
      Self.Canvas.FrameRect(rAux);
      InflateRect(rAux, -1, -1);
      Self.Canvas.FrameRect(rAux);
   end
   else
   begin
      InflateRect(rAux, -1, -1);
      Self.Canvas.FillRect(rAux);
   end;
   
   Self.Canvas.Pen.Width := 1;
   Self.Canvas.Pen.Color := clWhite;
   Self.Canvas.MoveTo(rLin.Left-1, rLin.Bottom);
   Self.Canvas.LineTo(rLin.Right+1, rLin.Bottom);
   Msg.Result := 0;

   if Self.ActivePageIndex <> -1 then
      Self.Pages[Self.ActivePageIndex].Brush.Color := clWhite;
end;

constructor TBmsXPPageControl.Create(aOwner: TComponent);
begin
   inherited;

   DoubleBuffered := True;
   Self.HotTrack := True;
   Self.OnChange := hookChange;
   Self.TabStop := True;

   FGrad := TBitmap.Create;
   FGrad.Width := 2;
   FGrad.Height := 21;
   criaGradient(FGrad.Width, FGrad.Height, $00FEFEFE, $00E6EBEC, 10, gkHorizontal, False, FGrad);

end;

destructor TBmsXPPageControl.Destroy;
begin
   FGrad.Free;
   inherited;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPPageControl]);
end;

end.
