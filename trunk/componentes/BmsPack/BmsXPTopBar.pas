{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPTopBar                                             }
{ Componente que implemente seu formul�rio com um efeito   }
{ gradiente utilizado no Windows XP.                       }
{                                                          }
{ Ultima atualiza��o: 26/08/2003                           }
{                                                          }
{ Vers�o: 1.0                                              }
{                                                          }
{ Obs.: O Pacote ainda est� em fase de desenvolvimento.    }
{       Qualquer BUG ou atualiza��o, favor me enviar por   }
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
{  - O Bms PACK � um pacote de componentes, visando se     }
{    igualar ao m�ximo com o Windows XP.                   }
{  - Este � um pacote Freeware, e n�o poder� ser vendido.  }
{  - O C�digo-Fonte pode ser alterado livremente. E por    }
{    favor notificar-me da altera��o para que eu possa     }
{    utiliz�-la nas pr�ximas vers�es.                      }
{  - Se voc� gostou desse pacote demonstre seu interesse   }
{    em receber futuras implementa��es enviando-me um      }
{    email. Voc� pode tamb�m colaborar com uma quantia     }
{    simb�lica para motivar o programador (eu). Obrigado e }
{    fa�a bom proveito do pacote!                          }
{                                                          }
{ -------------------------------------------------------- }

unit BmsXPTopBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, bmsXPUtils, Graphics, ExtCtrls;

type
  TBmsXPTopBar = class(TPanel)
  private
     FGradientColors: TBmsXPGradientColors;
     FGradientKind: TGradientKind;
     FGradientDithered: Boolean;
     FGradientCount: Integer;
     FImg: TBitmap;

     procedure setGradientColors(Value: TBmsXPGradientColors);
     procedure setGradientKind(Value: TGradientKind);
     procedure setGradientDithered(Value: Boolean);
     procedure setGradientCount(Value: Integer);
     procedure geraImagens;

     procedure hookResised(var Msg: TMessage); message wm_size;
    { Private declarations }
  protected
     procedure paint; override;
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor Destroy; override;
    { Public declarations }
  published
     property Align;
     property ShowHint;
     property Anchors;
     property BiDiMode;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property GradientColors: TBmsXPGradientColors read FGradientColors Write setGradientColors;
     property GradientKind: TGradientKind read FGradientKind Write setGradientKind default gkVertical;
     property GradientCount: Integer read FGradientCount Write setGradientCount default 30;
     property GradientDithered: Boolean read FGradientDithered Write setGradientDithered default True;     
     property HelpContext;
     {$IFDEF VER140}
     property HelpKeyword;
     property HelpType;
     {$ENDIF}
     property ParentBiDiMode;
     property ParentFont;
     property ParentShowHint;

     property OnClick;
     property OnContextPopup;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnStartDock;
     property OnStartDrag;
    { Published declarations }
  end;

procedure Register;

implementation

procedure TBmsXPTopBar.paint;
begin
   BitBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height, FImg.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TBmsXPTopbar.hookResised(var Msg: TMessage);
begin
   geraImagens;
   inherited;
end;

procedure TBmsXPTopbar.setGradientDithered(Value: Boolean);
begin
   if FGradientDithered <> Value then
   begin
      FGradientDithered := Value;
      geraImagens;
      Invalidate;
   end;
end;

procedure TBmsXPTopBar.setGradientCount(Value: Integer);
begin
   if FGradientCount <> Value then
   begin
      FGradientCount := Value;
      geraImagens;
      Invalidate;
   end;
end;

procedure TBmsXPTopBar.geraImagens;
begin
   FImg.Width := Self.Width;
   FImg.Height := Self.Height;
   criaGradient(Self.Width, Self.Height, GradientColors.StartColor, GradientColors.EndColor, FGradientCount, FGradientKind, FGradientDithered, FImg);
end;

procedure TBmsXPTopBar.setGradientKind(Value: TGradientKind);
begin
   if FGradientKind <> Value then
   begin
      FGradientKind := Value;
      geraImagens;
      Invalidate;
   end;
end;

procedure TBmsXPTopBar.setGradientColors(Value: TBmsXPGradientColors);
begin
   if FGradientColors <> Value then
   begin
      FGradientColors.Assign(Value);
      geraImagens;
      Invalidate;
   end;
end;

constructor TBmsXPTopBar.Create(aOwner: TComponent);
begin
   inherited;
   FGradientColors := TBmsXPGradientColors.Create(Self);
   FGradientKind := gkVertical;
   FGradientCount := 30;
   Self.Align := alTop;
   Self.Height := 70;
   FGradientColors.StartColor := $00E1CFC0;
   FGradientColors.EndColor := $00DF472F;
   FGradientDithered := True;

   FImg := TBitmap.Create;
end;

destructor TBmsXPTopBar.Destroy;
begin
   FGradientColors.Free;
   FImg.Free;
   inherited;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPTopBar]);
end;

end.
