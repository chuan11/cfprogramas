{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPProgressBar                                        }
{ Barra de progresso no estilo do XP                       }
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

unit BmsXPProgressBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, bmsXPUtils, Forms, bmsXPConsts;

type
  TBmsXPProgressBarOnProgress = procedure(Percent, Position: Integer) of object;

  TBmsXPProgressBar = class(TCustomControl)
  private
    FMin: Integer;
    FMax: Integer;
    FPosition: Integer;
    FPercent: Integer;
    FProgressBackImage: TBitmap;
    FProgressImage: TBitmap;
    FGradientKind: TGradientKind;
    FBackColors: TBmsXPGradientColors;
    FBarColors: TBmsXPGradientColors;
    FOnProgress: TBmsXPProgressBarOnProgress;

    procedure setMin(Value: Integer);
    procedure setMax(Value: Integer);
    procedure setPosition(Value: Integer);
    procedure setGradientKind(Value: TGradientKind);
    procedure setBackColors(Value: TBmsXPGradientColors);
    procedure setBarColors(Value: TBmsXPGradientColors);
    procedure setOnProgress(Value: TBmsXPProgressBarOnProgress);
    procedure hookResize(var Message: TMessage); message wm_size;
    { Private declarations }
  protected
    procedure Paint; override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  published
    property Align;
    property Anchors;
    property BackColors: TBmsXPGradientColors read FBackColors Write setBackColors;
    property BarColors: TBmsXPGradientColors read FBarColors Write setBarColors;
    property BorderWidth;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property GradientKind: TGradientKind read FGradientKind write setGradientKind default gkHorizontal;
    property Hint;
    property Constraints;
    property Min: Integer read FMin write SetMin default 0;
    property Max: Integer read FMax write SetMax default 100;
    property ParentShowHint;
    property PopupMenu;
    property Position: Integer read FPosition write SetPosition default 0;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnContextPopup;
    property OnDragDrop;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnProgress: TBmsXPProgressBarOnProgress read FOnProgress Write setOnProgress;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnStartDock;
    property OnStartDrag;
    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPProgressBar.setOnProgress(Value: TBmsXPProgressBarOnProgress);
begin
   FOnProgress := Value;
end;

procedure TBmsXPProgressBar.setBackColors(Value: TBmsXPGradientColors);
begin
   if FBackColors <> Value then
   begin
      FBackColors := Value;
      invalidate;
   end;
end;

procedure TBmsXPProgressBar.setBarColors(Value: TBmsXPGradientColors);
begin
   if FBarColors <> Value then
   begin
      FBarColors := Value;
      invalidate;
   end;
end;

procedure TBmsXPProgressBar.setGradientKind(Value: TGradientKind);
begin
   if FGradientKind <> Value then
   begin
      FGradientKind := Value;
      invalidate;
   end;
end;

procedure TBmsXPProgressBar.hookResize(var Message: TMessage);
var
   nAux: Integer;
   imAux: TBitmap;
begin
   if Message.Msg = wm_size then
   begin
      Application.ProcessMessages;
      FProgressBackImage.Width  := 2;
      FProgressBackImage.Height := Height - 3;

      FProgressImage.Width  := Width  - 6;
      FProgressImage.Height := Height - 6;

      imAux := TBitmap.Create;
      imAux.Width := Width - 6;
      imAux.Height := FProgressImage.Height div 2;

      criaGradient(2, Height, FBackColors.StartColor, FBackColors.EndColor, 15, gkHorizontal , False, FProgressBackImage);
      criaGradient(FProgressImage.Width, FProgressImage.Height div 2, FBarColors.StartColor , FBarColors.EndColor , 15, FGradientKind, False, FProgressImage    );
      criaGradient(imAux.Width, imAux.Height, FBarColors.EndColor , FBarColors.StartColor , 15, FGradientKind, False, imAux             );

      FProgressImage.Canvas.Draw(0, FProgressImage.Height div 2, imAux);

      nAux := -1;
      while nAux < width-3 do
      begin
         FProgressImage.Canvas.StretchDraw(Rect(nAux,0,nAux+2,height), FProgressBackImage);
         inc(nAux, Height);
      end;

      Invalidate;
   end;
end;

constructor TBmsXPProgressBar.Create(AOwner: TComponent);
begin
   Inherited;
   FPosition := 0;
   FMin := 0;
   FMax := 100;
   Height := 16;
   Width := 150;
   FPercent := 0;
   FProgressbackImage := TBitmap.Create;
   FProgressImage := TBitmap.Create;
   FGradientKind := gkHorizontal;

   FBackColors := TBmsXPGradientColors.Create(Self);
   FBackColors.StartColor := pbBgStartColor;
   FBackColors.EndColor   := pbBgEndColor;

   FBarColors := TBmsXPGradientColors.Create(Self);
   FBarColors.StartColor := pbBarStartColor;
   FBarColors.EndColor   := pbBarEndColor  ;

   invalidate;
end;

destructor TBmsXPProgressBar.Destroy;
begin
   FProgressBackImage.free;
   FProgressImage.free;
   Inherited;
end;

procedure TBmsXPProgressBar.setMin(Value: Integer);
begin
   if FMin <> Value then
   begin
      FMin := Value;
      FPercent := Trunc((FPosition / (FMax - FMin)) * 100);
      Invalidate;
   end;
end;

procedure TBmsXPProgressBar.setMax(Value: Integer);
begin
   if FMax <> Value then
   begin
      FMax := Value;
      FPercent := Trunc((FPosition / (FMax - FMin)) * 100);
      Invalidate;
   end;
end;

procedure TBmsXPProgressBar.setPosition(Value: Integer);
var
   b: TRect;
begin
   if FPosition <> Value then
   begin
      if Value > FMax then
         Value := FMax
      else if Value < FMin then
         Value := FMin;

      FPosition := Value;

      b := Rect(Trunc(FPercent / 100 * width-6), 3, Width-3, Height-3);
      FPercent := Trunc((FPosition / (FMax - FMin)) * 100);

      InvalidateRect(Handle, @b, False);

      if Assigned (FOnProgress) then
         FOnProgress(FPercent, FPosition);
   end;
end;

procedure TBmsXPProgressBar.paint;
begin
   with Canvas do
   begin
      Brush.Style := bsClear;
      pen.width := 0;
      StretchBlt(Canvas.Handle, 2, 2, Width-3, Height-3, FProgressBackImage.Canvas.Handle, 0, 0, 2, Height-3, SRCCOPY);

      Pen.Color := $006F676F;
      RoundRect(0,0,Width,Height, 7, 7);

      Pen.Color := clSilver;
      MoveTo(2,1);
      LineTo(Width-2, 1);
      MoveTo(1,2);
      LineTo(1, Height-2);
      Pixels[2,2] := clSilver;

      pen.width := 1;

      if Round(FPercent / 100 * width-6) > 3 then
         BitBlt(Canvas.Handle, 3, 3, Round(FPercent / 100 * width-6)+3, Height-6, FProgressImage.Canvas.Handle, 0, 0, SRCCOPY)
      else
         BitBlt(Canvas.Handle, 3, 3, 1, Height -6, FProgressImage.Canvas.Handle, 0, 0, SRCCOPY)
   end;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPProgressBar]);
end;

end.

