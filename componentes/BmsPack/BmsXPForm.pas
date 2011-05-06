{ ----------------- BMS PACK (Xp version) ---------------- }
{                                                          }
{ TBmsXPForm                                               }
{ Componente que deixará seu formulário com cara de        }
{ Windows XP                                               }
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

unit BmsXPForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Graphics, dialogs, ExtCtrls, StdCtrls, bmsXPUtils;

type
  TBmsXPFormWindowState = (bwsMaximized, bwsNormal);
  TBmsXPFormButtons = set of (bfbHelp,bfbClose, bfbMinimize, bfbMaximize);

  TBmsXPFormButton = class(TCustomControl)
  private
     FBitmap: TBitmap;
     FBitmapOver: TBitmap;
     FBitmapPressed: TBitmap;
     FBitmapBack: TBitmap;
     FBitmapPressedback: TBitmap;
     FPressed: Boolean;
     FOver: Boolean;

     procedure setBitmap(Value: TBitmap);
     procedure setBitmapOver(Value: TBitmap);
     procedure setBitmapPressed(Value: TBitmap);
     procedure setBitmapBack(Value: TBitmap);
     procedure setBitmapPressedBack(Value: TBitmap);
     procedure BmsXPFormButton_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
     procedure BmsXPFormButton_MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

     procedure hookMouseOver(var Message: TMessage); message cm_mouseEnter;
     procedure hookMouseOut(var Message: TMessage); message cm_mouseLeave;
    { Private declarations }
  protected
     procedure Paint; override;
    { Protected declarations }
  public
     constructor Create(aOwner: TComponent); override;
     destructor destroy; override;
    { Public declarations }
  published
     property bitmap: TBitmap read FBitmap Write setBitmap;
     property bitmapPressed: TBitmap read FBitmapPressed Write setBitmapPressed;
     property bitmapBack: TBitmap read FBitmapBack Write setBitmapBack;
     property bitmapOver: TBitmap read FBitmapover Write setBitmapOver;
     property bitmapPressedBack: TBitmap read FBitmapPressedBack Write setBitmapPressedBack;
    { Published declarations }
  end;

  TBmsXPForm = class(TCustomPanel)
  private
    FMovable: Boolean;
    FBody: TPanel;
    FIcon: TBitmap;
    FButtons: TBmsXPFormButtons;
    FButtonClose: TBmsXPFormButton;
    FButtonHelp: TBmsXPFormButton;
    FButtonMaximize: TBmsXPFormButton;
    FButtonMinimize: TBmsXPFormButton;
    FCaption: string;
    FColor: TColor;
    FLastWindowPos: TPoint;
    FLastWindowSize: TPoint;

    FTopImage: TBitmap;
    FTopLeftImage: TBitmap;
    FTopRightImage: TBitmap;

    FTopImageBack: TBitmap;
    FTopLeftImageBack: TBitmap;
    FTopRightImageBack: TBitmap;
    FWindowState: TBmsXPFormWindowState;

    MouseDownSpot : TPoint;
    Capturing : BOOL;
    Resizing: BOOL;

    procedure RemoldarJanela;
    procedure setCaption(Value: string);
    procedure setColor(Value: TColor);
    procedure setIcon(Value: TBitmap);
    procedure setWindowState(Value: TBmsXPFormWindowState);
    procedure setButtons(Value: TBmsXPFormButtons);
    procedure TituloDoubleClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ButtonMaximizeClick(Sender: TObject);
    procedure ButtonMinimizeClick(Sender: TObject);
    procedure TituloMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TituloMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TituloMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClientWndProc(var Message: TMessage);
    { Private declarations }
  protected
    procedure Loaded; override;
    procedure Paint; override;
    { Protected declarations }
  public
     constructor Create(AOwner: TComponent); overload; override;
     destructor Destroy; override;
     procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    { Public declarations }
  published
    property Constraints;
    property Movable: Boolean read FMovable write FMovable default True;
    property Icon: TBitmap read FIcon write setIcon;
    property Buttons: TBmsXPFormButtons read FButtons Write setButtons default [bfbClose, bfbHelp];
    property Caption: string read FCaption Write setCaption;
    property Color: TColor read FColor Write setColor default $00DEE7E7;
    property WindowState: TBmsXPFormWindowState read FWindowState Write setWindowState default bwsNormal;
    { Published declarations }
  end;

procedure Register;
function XPMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): Integer;

implementation
uses
   BmsXPButton;
   
{$R IMAGENS.RES}
{$IFDEF VER140}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

var
  NewClient, OldClient: TFarProc;

function XPMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): Integer;
var
   b:TForm;
   i: Integer;
   sName: string;
   bmsForm: TBmsXPForm;
begin
   b := CreateMessageDialog(Msg, DlgType, Buttons);
   i := 0;

   BmsForm := TBmsXPForm.Create(b);
   bmsForm.Parent := b;
   bmsForm.Buttons := [bfbClose];

   while i < b.ComponentCount-1 do
   begin
      if b.Components[i].ClassType = TButton then
      begin
         with TBmsXPButton.Create(b) do
         begin
            Left        := TButton(b.Components[i]).Left;
            Top         := TButton(b.Components[i]).Top;
            Width       := TButton(b.Components[i]).Width;
            Height      := TButton(b.Components[i]).Height;
            Caption     := TButton(b.Components[i]).Caption;
            OnClick     := TButton(b.Components[i]).onClick;
            ModalResult := TButton(b.Components[i]).ModalResult;
            Parent      := TWinControl(bmsForm.Controls[0]);
            sName       := TButton(b.Components[i]).Name;
            TButton(b.Components[i]).Free;
            Name        := sName;
         end;
      end
      else if b.Components[i].ClassType <> TBmsXPForm then
      begin
         TWinControl(b.Components[i]).Parent := TWinControl(bmsForm.Controls[0]);
         Inc(i);
      end
      else
         Inc(i);
   end;

   Result := b.ShowModal;
   b.Free;
end;

procedure TBmsXPForm.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
   i: integer;
begin
   inherited;
   for i := 0 to FBody.ControlCount-1 do
      Proc(FBody.Controls[i]);
end;

procedure TBmsXPForm.Loaded;
var
   i: integer;
begin
   for i := ControlCount - 1 downto 0 do
      if (Controls[i] <> FBody) and not (Controls[i] is TBmsXPFormButton) then
         Controls[i].Parent := FBody;

   inherited;
end;

procedure TBmsXPFormButton.hookMouseOver(var Message: TMessage);
begin
   FOver := True;
   Invalidate;
end;

procedure TBmsXPFormButton.hookMouseOut(var Message: TMessage);
begin
   FOver := False;
   Invalidate;
end;

procedure TBmsXPFormButton.Paint;
begin
   if (TForm(Parent.Parent).Active) or (csDesigning in componentState) then
   begin
      if (FPressed) and (FOver) then Canvas.Draw(0,0,FBitmapPressed)
      else if FOver then             Canvas.Draw(0,0,FBitmapOver)
      else                           Canvas.Draw(0,0,FBitmap);
   end
   else
      Canvas.Draw(0,0,FBitmapBack);
end;

procedure TBmsXPFormButton.setBitmapOver(Value: TBitmap);
begin
   if FBitmapOver <> Value then
   begin
      FBitmapOver.Assign(Value);
      Invalidate;
   end;
end;

procedure TBmsXPFormButton.setBitmap(Value: TBitmap);
begin
   if FBitmap <> Value then
   begin
      FBitmap.Assign(Value);
      Invalidate;
   end;
end;

procedure TBmsXPFormButton.setBitmapBack(Value: TBitmap);
begin
   if FBitmapBack <> Value then
   begin
      FBitmapBack.Assign(Value);
      Invalidate;
   end;
end;

procedure TBmsXPFormButton.setBitmapPressedBack(Value: TBitmap);
begin
   if FBitmapPressedBack <> Value then
   begin
      FBitmapPressedBack.Assign(Value);
      Invalidate;
   end;
end;

procedure TBmsXPFormButton.setBitmapPressed(Value: TBitmap);
begin
   if FBitmapPressed <> Value then
   begin
      FBitmapPressed.Assign(Value);
      Invalidate;
   end;
end;

procedure TBmsXPFormButton.BmsXPFormButton_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   FPressed := True;
   Invalidate;
end;

procedure TBmsXPFormButton.BmsXPFormButton_MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   FPressed := False;
   Invalidate;
end;

constructor TBmsXPFormButton.Create(aOwner: TComponent);
begin
   inherited;
   
   Parent := TWinControl(aOwner);
   FBitmap := TBitmap.Create;
   FBitmapOver := TBitmap.Create;
   FBitmapPressed := TBitmap.Create;
   FBitmapBack := TBitmap.Create;
   FBitmapPressedBack := TBitmap.Create;
   Self.OnMouseDown := BmsXPFormButton_MouseDown;
   Self.OnMouseUp := BmsXPFormButton_MouseUp;
   FPressed := False;
   FOver := False;

   Width := 21;
   Height := 21;
   Paint;
end;

destructor TBmsXPFormButton.destroy;
begin
   FBitmap.Free;
   FBitmapOver.Free;
   FBitmapPressed.Free;
   FBitmapBack.Free;
   FBitmapPressedBack.Free;
   inherited;
end;

procedure TBmsXPForm.setIcon(Value: TBitmap);
var
   rArea: TRect;
begin
   if FIcon <> Value then
   begin
      FIcon.Assign(Value);

      rArea := Rect(0,0,Width, FTopImage.Height);
      InvalidateRect(Handle, @rArea, False);
   end;
end;

procedure TBmsXPForm.RemoldarJanela;
var
   Region, Region2 : hrgn;
begin
   if not (csDesigning in ComponentState) then
   begin
      Region := CreaterectRgn(0,0,TForm(Parent).width,TForm(Parent).height);
      Region2 := CreateRoundRectRgn(0,0,TForm(Parent).Width+1,TForm(Parent).Height, 17, 17);
      CombineRgn(region, region, region2, RGN_AND);
      Region2 := CreateRectRgn(0,20,TForm(Parent).Width,TForm(Parent).Height);
      CombineRgn(Region, Region, Region2, RGN_OR);
      SetWindowRgn(TForm(Parent).handle, region, true);
   end;
end;

procedure TBmsXPForm.TituloMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if FMovable then
   begin
      if (X > 0) and (X < Width) and (Y > 0) and (Y < FTopImage.Height) then
      begin
         SetCaptureControl( Self );
         Capturing := True;
      end;

      MouseDownSpot := TWinControl(Sender).ClientToScreen( Point(X, Y));
   end;

   Resizing :=  (((X > 0) and (X < 5)) or ((X < Width) and (X > Width-5))) and ((Y > FTopImage.Height) and (Y < Height -2)) or
                (Y > Height-5) and (Y < Height) or
                ((Y > Height-8) and (Y < Height)) and ((X > 0) and (X < 8)) or
                ((Y > Height-8) and (Y < Height)) and ((X < Width) and (X > Width-8));

end;

procedure TBmsXPForm.TituloMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   Pos: TPoint;
begin
   pos:= Self.ClientToScreen( Point(X, Y));

   If Capturing Then
   Begin
      If (pos.X <> MouseDownSpot.X) or (pos.Y <> MouseDownSpot.Y) Then
      Begin
         (Parent as TForm).SetBounds( (Parent as TForm).Left + (Pos.X - MouseDownSpot.X),
                 (Parent as TForm).Top  + (Pos.Y - MouseDownSpot.Y),
                 (Parent as TForm).Width, (Parent as TForm).Height );
         MouseDownSpot := Pos;
      End;
   End;
end;

procedure TBmsXPForm.TituloMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   If Capturing Then
   Begin
      Capturing := False;
      SetCaptureControl( nil );
   end;

   Resizing := False;
end;

procedure TBmsXPForm.ButtonCloseClick(Sender: TObject);
begin
   TForm(Parent).Close;
end;

procedure TBmsXPForm.ButtonMinimizeClick(Sender: TObject);
begin
   Application.Minimize;
end;

procedure TBmsXPForm.ButtonMaximizeClick(Sender: TObject);
begin
   with TForm(Parent) do
   begin
      if FWindowState = bwsNormal then
         setWindowState(bwsMaximized)
      else if FWindowState = bwsMaximized then
         setWindowState(bwsNormal);
   end;

   RemoldarJanela;
end;

procedure TBmsXPForm.ButtonHelpClick(Sender: TObject);
begin
   //
end;

procedure TBmsXPForm.TituloDoubleCLick(Sender: TObject);
var
   mPos: TPoint;
begin
   GetCursorPos(mPos);

   if (mPos.Y > Parent.Top) and (mPos.Y < Parent.Top+FTopImage.Height) then
   begin
      if bfbMaximize in FButtons then
      begin
         with TForm(Parent) do
         begin
            if FWindowState = bwsNormal then
               setWindowState(bwsMaximized)
            else if FWindowState = bwsMaximized then
               setWindowState(bwsNormal);
         end;

         RemoldarJanela;
      end;
   end;
end;

procedure TBmsXPForm.setButtons(Value: TBmsXPFormButtons);
begin
   if FButtons <> Value then
   begin
      FButtons := Value;
      Paint;
   end;
end;

procedure TBmsXPForm.setWindowState(Value: TBmsXPFormWindowState);
begin
   if FWindowState <> Value then
   begin
      FWindowState := Value;

      if FWindowState = bwsNormal then
      begin
         Parent.Align := alNone;
         Parent.SetBounds(FLastWindowPos.X, FLastWindowPos.Y, FLastWindowSize.X, FLastWindowSize.Y);
         FButtonMaximize.Bitmap.Handle        := loadBitmap(HInstance, 'buttonMaximize');
         FButtonMaximize.BitmapOver.Handle    := loadBitmap(HInstance, 'buttonMaximizeOver');
         FButtonMaximize.BitmapPressed.Handle := loadBitmap(HInstance, 'buttonMaximizePressed');
         FButtonMaximize.BitmapBack.Handle    := loadBitmap(HInstance, 'buttonMaximizeBack');
      end
      else
      begin
         FLastWindowPos.X  := Parent.Left;
         FLastWindowPos.Y  := Parent.Top;
         FLastWindowSize.X := Parent.Width;
         FLastWindowSize.Y := Parent.Height;
         
         FButtonMaximize.Bitmap.Handle        := loadBitmap(HInstance, 'buttonRestore');
         FButtonMaximize.BitmapOver.Handle    := loadBitmap(HInstance, 'buttonRestoreOver');
         FButtonMaximize.BitmapPressed.Handle := loadBitmap(HInstance, 'buttonRestorePressed');
         FButtonMaximize.BitmapBack.Handle    := loadBitmap(HInstance, 'buttonRestoreBack');

         Parent.Align := alClient;
      end
   end;
end;


procedure TBmsXPForm.setColor(Value: TColor);
begin
   if FColor <> Value then
   begin
      FColor := Value;
      Color := Value;
      Invalidate;
   end;
end;

procedure TBmsXPForm.setCaption(Value: string);
var
   rArea: TRect;
begin
   if FCaption <> Value then
   begin
      FCaption := Value;

      rArea := Rect(0,0,Width, FTopImage.Height);
      InvalidateRect(Handle, @rArea, False);
   end;
end;

procedure TBmsXPForm.Paint;
var
   ButtonTop: Integer;
   corBordas: array [0..8] of TColor;
   leftText: Integer;
begin
   ButtonTop := (FTopImage.Height div 2) - (FButtonClose.Height div 2);
   FButtonClose.Top := ButtonTop;
   FButtonHelp.Top := ButtonTop;
   FButtonMinimize.Top := ButtonTop;
   FButtonMaximize.Top := ButtonTop;

   if FButtons = [bfbHelp, bfbClose, bfbMinimize, bfbMaximize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := Width - (21*2) - 9;
      FButtonMinimize.Left := Width - (21*3) - 13;
      FButtonHelp.Left     := Width - (21*4)-  17;
   end
   else if FButtons = [bfbClose, bfbMinimize, bfbMaximize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := Width - (21*2) - 9;
      FButtonMinimize.Left := Width - (21*3) - 13;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbHelp, bfbMinimize, bfbMaximize] then
   begin
      FButtonClose.Left    := -100;;
      FButtonMaximize.Left := Width -  21    - 5;
      FButtonMinimize.Left := Width - (21*2) - 9;
      FButtonHelp.Left     := Width - (21*3) - 13;
   end
   else if FButtons = [bfbHelp, bfbClose, bfbMinimize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := Width - (21*2) - 9;
      FButtonHelp.Left     := Width - (21*3) - 13;
   end
   else if FButtons = [bfbHelp, bfbClose, bfbMaximize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := Width - (21*2) - 9;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := Width - (21*3) - 13;
   end
   else if FButtons = [bfbMinimize, bfbMaximize] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := Width -  21    - 5;
      FButtonMinimize.Left := Width - (21*2) - 9;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbClose, bfbMinimize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := Width - (21*2) - 9;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbClose, bfbMaximize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := Width - (21*2) - 9;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbHelp, bfbClose, bfbMaximize] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := Width - (21*2) - 9;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbHelp, bfbClose] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := Width - (21*2) - 9;
   end
   else if FButtons = [bfbHelp, bfbMaximize] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := Width -  21    - 5;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := Width - (21*2) - 9;
   end
   else if FButtons = [bfbHelp, bfbMinimize] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := Width -  21    - 5;
      FButtonHelp.Left     := Width - (21*2) - 9;
   end
   else if FButtons = [bfbHelp] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := Width -  21    - 5;
   end
   else if FButtons = [bfbMinimize] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := Width -  21    - 5;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbMaximize] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := Width -  21    - 5;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [bfbClose] then
   begin
      FButtonClose.Left    := Width -  21    - 5;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := -100;
   end
   else if FButtons = [] then
   begin
      FButtonClose.Left    := -100;
      FButtonMaximize.Left := -100;
      FButtonMinimize.Left := -100;
      FButtonHelp.Left     := -100;
   end;

   FButtonHelp.Paint;
   FButtonClose.Paint;
   FButtonMinimize.Paint;
   FButtonMaximize.Paint;

   if (TForm(Parent).Active) or (csDesigning in ComponentState) then
   begin
      Canvas.Draw(0,0, FTopLeftImage);
      Canvas.StretchDraw(Rect(FTopLeftImage.Width,0,Width,FTopImage.Height), FTopImage);
      Canvas.Draw(Width - FTopRightImage.Width,0, FTopRightImage);
   end
   else
   begin
      Canvas.Draw(0,0, FTopLeftImageBack);
      Canvas.StretchDraw(Rect(FTopLeftImageback.Width,0,Width,FTopImageBack.Height), FTopImageback);
      Canvas.Draw(Width - FTopRightImageback.Width,0, FTopRightImageBack);
   end;

   if not FIcon.Empty then
   begin
      FIcon.Transparent := True;
      Canvas.StretchDraw(Rect(5, FTopImage.Height div 2 - 8, 21, FTopImage.Height div 2 + 8), FIcon);
      leftText := 26;
   end
   else
      leftText := 10;

   Canvas.Font.Name := 'Verdana';
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Brush.Style := bsClear;

   if TForm(Parent).Active then
   begin
      Canvas.Font.Color := clBlack;
      Canvas.TextOut(leftText, (FTopImage.Height div 2)-(canvas.TextHeight('A') div 2)+1, FCaption);
   end;

   Canvas.Font.Color := clWhite;
   Canvas.TextOut(leftText-1, (FTopImage.Height div 2) - (canvas.TextHeight('A') div 2), FCaption);

   Canvas.Brush.Color := FColor;
   Canvas.Pen.Color := FColor;

   if Assigned(FBody) then
   begin
      FBody.Left := 3;
      FBody.Top := FTopImage.Height;
      FBody.Width := Width -6;
      FBody.Height := Height-FTopImage.Height-3;
      FBody.Color := Self.Color;
   end;
//   Canvas.Rectangle(3, FTopImage.Height, Width-6, Height-3);

   if (TForm(Parent).Active) or (csDesigning in ComponentState) then
   begin
      corBordas[0] := $00DE3100;
      corBordas[1] := $00EF6B10;
      corBordas[2] := $00DE5208;
      corBordas[3] := $00EF4A00;
      corBordas[4] := $009C1000;
      corBordas[5] := $008C1000;
      corBordas[6] := $00EF4A00;
      corBordas[7] := $009C1000;
      corBordas[8] := $008C1000;
   end
   else
   begin
      corBordas[0] := $00C25D4D;
      corBordas[1] := $00D47565;
      corBordas[2] := $00B17E65;
      corBordas[3] := $00B17E65;
      corBordas[4] := $00C2655D;
      corBordas[5] := $00B1453D;
      corBordas[6] := $00B17E65;
      corBordas[7] := $00C2655D;
      corBordas[8] := $00B1453D;
   end;

   with Canvas do
   begin
      {Borda esquerda}
      {--------------}
      Pen.Color := corBordas[0];
      MoveTo(0,FTopImage.Height);
      LineTo(0,Height);
      Pen.Color := corBordas[1];
      MoveTo(1,FTopImage.Height);
      LineTo(1,Height);
      Pen.Color := corBordas[2];
      MoveTo(2,FTopImage.Height);
      LineTo(2,Height);

      {Borda de baixo}
      {--------------}
      Pen.Color := corBordas[3];
      MoveTo(0,Height-3);
      LineTo(width,Height-3);
      Pen.Color := corBordas[4];
      MoveTo(0,Height-2);
      LineTo(width,Height-2);
      Pen.Color := corBordas[5];
      MoveTo(0,Height-1);
      LineTo(width,Height-1);

      {Borda da direita}
      {--------------}
      Pen.Color := corBordas[6];
      MoveTo(Width-3,Height-3);
      LineTo(Width-3,FTopImage.Height-1);
      Pen.Color := corBordas[7];
      MoveTo(Width-2,Height-2);
      LineTo(Width-2,FTopImage.Height-1);
      Pen.Color := corBordas[8];
      MoveTo(Width-1,Height-1);
      LineTo(Width-1,FTopImage.Height-1);
   end;

   RemoldarJanela;
end;

procedure TBmsXPForm.ClientWndProc(var Message: TMessage);
begin
  if Message.Msg = wm_activate then
     Invalidate;

  Message.Result := CallWindowProc(OldClient, TFOrm(Parent).handle, Message.Msg, Message.wParam, Message.lParam);
end;


constructor TBmsXPForm.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   ControlStyle := ControlStyle + [csAcceptsControls];

   Parent := TForm(AOwner);
   TForm(Parent).Color := clWhite;
   SendToBack;

   FBody := TPanel.Create(self);
   with FBody do
   begin
      Parent := self;
      Name := 'BmsXPFormBody';
      BevelOuter := bvNone;
      Color := Self.Color;
      Caption := '';
   end;

   FMovable := True;
   FTopImage := TBitmap.Create;
   FTopLeftImage := TBitmap.Create;
   FTopRightImage := TBitmap.Create;
   FTopImageback := TBitmap.Create;
   FTopLeftImageBack := TBitmap.Create;
   FTopRightImageBack := TBitmap.Create;
   FIcon := TBitmap.Create;

   FButtons := [bfbClose, bfbMinimize, bfbMaximize];

   // Carrega os BitMaps ***
   FButtonClose := TBmsXPFormButton.Create(Self);
   FButtonClose.bitmap.LoadFromResourceName       (HInstance, 'buttonClose');
   FButtonClose.bitmapPressed.LoadFromResourceName(HInstance, 'buttonClosePressed');
   FButtonClose.bitmapOver.LoadFromResourceName   (HInstance, 'buttonCloseOver');
   FButtonClose.bitmapBack.LoadFromResourceName   (HInstance, 'buttonCloseBack');
   FButtonClose.OnClick := ButtonCloseClick;

   FButtonMaximize := TBmsXPFormButton.Create(Self);
   FButtonMaximize.bitmap.LoadFromResourceName       (HInstance, 'buttonMaximize');
   FButtonMaximize.bitmapPressed.LoadFromResourceName(HInstance, 'buttonMaximizePressed');
   FButtonMaximize.bitmapOver.LoadFromResourceName   (HInstance, 'buttonMaximizeOver');
   FButtonMaximize.bitmapBack.LoadFromResourceName   (HInstance, 'buttonMaximizeBack');
   FButtonMaximize.OnClick := ButtonMaximizeClick;

   FButtonMinimize := TBmsXPFormButton.Create(Self);
   FButtonMinimize.bitmap.LoadFromResourceName       (HInstance, 'buttonMinimize');
   FButtonMinimize.bitmapPressed.LoadFromResourceName(HInstance, 'buttonMinimizePressed');
   FButtonMinimize.bitmapOver.LoadFromResourceName   (HInstance, 'buttonMinimizeOver');
   FButtonMinimize.bitmapBack.LoadFromResourceName   (HInstance, 'buttonMinimizeBack');
   FButtonMinimize.OnClick := ButtonMinimizeClick;

   FButtonHelp := TBmsXPFormButton.Create(Self);
   FButtonHelp.bitmap.LoadFromResourceName       (HInstance, 'buttonHelp');
   FButtonHelp.bitmapPressed.LoadFromResourceName(HInstance, 'buttonHelpPressed');
   FButtonHelp.bitmapOver.LoadFromResourceName   (HInstance, 'buttonHelpOver');
   FButtonHelp.bitmapBack.LoadFromResourceName   (HInstance, 'buttonHelpBack');
   FButtonHelp.OnClick := ButtonHelpClick;

   FTopImage.LoadFromResourceName         (HInstance, 'top');
   FTopImageBack.LoadFromResourceName     (HInstance, 'topBack');
   FTopLeftImage.LoadFromResourceName     (HInstance, 'topLeft');
   FTopLeftImageBack.LoadFromResourceName (HInstance, 'topLeftBack');
   FTopRightImage.LoadFromResourceName    (HInstance, 'topRight');
   FTopRightImageBack.LoadFromResourceName(HInstance, 'topRightBack');

   FCaption := TForm(Parent).Caption;

   FColor := $00DEE7E7;
   Color := FColor;

   FWindowState := bwsNormal;

   Self.OnDblClick := TituloDoubleCLick;
   Self.OnMouseDown := TituloMouseDown;
   Self.OnMouseUp := TituloMouseUp;
   Self.OnMouseMove := TituloMouseMove;

   Align := alClient;
   TForm(Parent).BorderStyle := bsNone;

   OldClient := Pointer(GetWindowLong(TForm(Owner).Handle, GWL_WndProc));
   NewClient := MakeObjectInstance(ClientWNDProc);
   SetWindowLong(TForm(Owner).Handle, GWL_WndProc, LongInt(NewClient));

   Paint;
end;

destructor TBmsXPForm.Destroy;
begin
   FBody.Free;
   FTopImage.Free;
   FTopLeftImage.Free;
   FTopRightImage.Free;
   FBUttonHelp.Free;
   FButtonClose.Free;
   FButtonMinimize.free;
   FButtonMaximize.free;
   FIcon.Free;

   if Assigned(TForm(Parent)) and Assigned(OldClient) then
      SetWindowLong(TForm(Owner).Handle, GWL_WndProc, LongInt(OldClient));
   if Assigned(NewClient) then
      FreeObjectInstance(NewClient);

{   NewClient := nil;
   OldClient := nil;}

   inherited;
end;

procedure Register;
begin
  RegisterComponents('BMS XP', [TBmsXPForm]);
end;

end.
