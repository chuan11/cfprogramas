unit bmsXPUtils;

interface
uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, bmsXPConsts, math;

Type
  TBmsState = set of (sFocused, sMouseOver, sDown);
  TGradientKind = (gkHorizontal, gkVertical);
  TBmsXPShadowStyle = (ssTopLeft, ssTop, ssTopRight,
                       ssLeft, ssRight,
                       ssBottomLeft, ssBottom, ssBottomRight);

  TBmsXPShadow = class(TPersistent)
  private
    FShadowColor: TColor;
    FShadowStyle: TBmsXPShadowStyle;
    FShadowOffSet: Integer;
    FParent: TWinControl;

    procedure setShadowColor (Value: TColor);
    procedure setShadowStyle (Value: TBmsXPShadowStyle);
    procedure setShadowOffSet(Value: Integer);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); virtual;
    { Public declarations }
  published
    property Color : TColor            read FShadowColor  Write setShadowColor;
    property Style : TBmsXPShadowStyle read FShadowStyle  Write setShadowStyle;
    property OffSet: Integer  read FShadowOffset Write setShadowOffset;
    { Published declarations }
  end;

  TBmsXPGradientColors = class(TPersistent)
  private
    FStartColor: TColor;
    FEndColor: TColor;
    FParent: TWinControl;

    procedure setStartColor(Value: TColor);
    procedure setEndColor(Value: TColor);
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); virtual;
    { Public declarations }
  published
    property StartColor: TColor read FStartColor Write setStartColor;
    property EndColor  : TColor read FEndColor   Write setEndColor;
    { Published declarations }
  end;

  procedure criaGradient(AWidth, AHeight: Integer; const StartColor, EndColor: TColor; const Colors: integer; const Style: TGradientKind; const Dithered: Boolean; var Bitmap: TBitmap);
  procedure Morph( Imagem1, Imagem2: TBitmap; Destino: TCanvas; X,Y: Integer; Rate: Integer);

implementation
Var
   EBX, ESI, EDI, ESP, EBP, FinA, Dens1, Dens2 : Longint;

procedure Morph( Imagem1, Imagem2: TBitmap; Destino: TCanvas; X,Y: Integer; Rate: Integer);

   Function Pt(B : TBitmap) : Pointer;
   Begin
     Pt := B.Scanline[(B.Height-1)]
   End;

   procedure Blendit(bFr,bTo,bLn : Pointer ; Width,Height : Integer ; Dens : LongInt); assembler;
   Const
     Mask0101 = $00FF00FF;
     Mask1010 = $FF00FF00;
   ASM
     MOV &EBX, EBX
     MOV &EDI, EDI
     MOV &ESI, ESI
     MOV &ESP, ESP
     MOV &EBP, EBP

     MOV EBX, Dens
     MOV Dens1, EBX

     NEG BL
     ADD BL, $20
     MOV Dens2, EBX
     CMP Dens1, 0
     JZ  @Final
     MOV EDI, bFr
     MOV ESI, bTo
     MOV ECX, bLn

     MOV EAX, Width
     lea EAX, [EAX+EAX*2+3]
     AND EAX, $FFFFFFFC
     IMUL Height
     ADD EAX, EDI
     MOV FinA, EAX

     MOV EBP,EDI
     MOV ESP,ESI
     MOV ECX,ECX

   @LOOPA:
     MOV  EAX, [EBP]
     MOV  EDI, [ESP]
     MOV  EBX, EAX
     AND  EAX, Mask1010
     AND  EBX, Mask0101
     SHR  EAX, 5
     IMUL EAX, Dens2
     IMUL EBX, Dens2
     MOV  ESI, EDI
     AND  EDI, Mask1010
     AND  ESI, Mask0101
     SHR  EDI, 5
     IMUL EDI, Dens1
     IMUL ESI, Dens1
     ADD  EAX, EDI
     ADD  EBX, ESI
     AND  EAX, Mask1010
     SHR  EBX, 5
     AND  EBX, Mask0101
     OR   EAX, EBX
     MOV [ECX], EAX

     ADD  EBP, 4
     ADD  ESP, 4
     ADD  ECX, 4

     CMP  EBP, FinA
     JNE  @LOOPA

   @FINAL:

     MOV EBX, &EBX
     MOV EDI, &EDI
     MOV ESI, &ESI
     MOV ESP, &ESP
     MOV EBP, &EBP
   End;

var
   bmpResult: TBitmap;
   i: Integer;
begin
   bmpResult := TBitmap.Create;
   bmpResult.Assign( Imagem1 );

   Imagem1.PixelFormat := pf24bit;
   Imagem2.PixelFormat := pf24bit;
   Imagem2.Width := Imagem1.Width;
   Imagem2.Height := Imagem1.Height;

   for i := 0 to Rate do
   begin
      Blendit(Pt(Imagem1),Pt(Imagem2),Pt(bmpResult),Imagem1.Width,Imagem1.Height,(i*$20 Div Rate));
      Destino.Draw(X,Y,bmpResult);
   end;

end;

constructor TBmsXPShadow.Create(AOwner: TComponent);
begin
   inherited create;
   FParent := TWinControl(AOwner);
end;

procedure TBmsXPShadow.setShadowColor(Value: TColor);
begin
   if FShadowColor <> Value then
   begin
      FShadowColor := Value;
      FParent.Invalidate;
   end;
end;

procedure TBmsXPShadow.setShadowStyle(Value: TBmsXPShadowStyle);
begin
   if FShadowStyle <> Value then
   begin
      FShadowStyle := Value;
      FParent.Invalidate;
   end;
end;

procedure TBmsXPShadow.setShadowOffSet(Value: Integer);
begin
   if FShadowOffset <> Value then
   begin
      FShadowOffset := Value;
      FParent.Invalidate;
   end;
end;

constructor TBmsXPGradientColors.Create(AOwner: TComponent);
begin
   inherited create;
   FParent := TWinControl(AOwner);
end;

procedure TBmsXPGradientColors.setStartColor(Value: TColor);
begin
   if FStartColor <> Value then
   begin
      FStartColor := Value;
      TWinControl(FParent).Width := TWinControl(FParent).Width +1;
      TWinControl(FParent).Width := TWinControl(FParent).Width -1;
   end;
end;

procedure TBmsXPGradientColors.setEndColor(Value: TColor);
begin
   if FEndColor <> Value then
   begin
      FEndColor := Value;
      TWinControl(FParent).Width := TWinControl(FParent).Width +1;
      TWinControl(FParent).Width := TWinControl(FParent).Width -1;
   end;
end;


procedure criaGradient(AWidth, AHeight: Integer; const StartColor, EndColor: TColor; const Colors: integer; const Style: TGradientKind; const Dithered: Boolean; var Bitmap: TBitmap);
const
  PixelCountMax = 32768;
type
  TGradientBand = array[0..255] of TColor;
  TRGBMap = packed record
    case boolean of
      True: (RGBVal: DWord);
      False: (R, G, B, D: Byte);
  end;
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..PixelCountMax-1] of TRGBTriple;
const
  DitherDepth = 16;
var
  iLoop, xLoop, yLoop, XX, YY: Integer;
  iBndS, iBndE: Integer;
  GBand: TGradientBand;
  Row:  pRGBTripleArray;
  procedure CalculateGradientBand;
  var
    rR, rG, rB: Real;
    lCol, hCol: TRGBMap;
    iStp: Integer;
  begin
      lCol.RGBVal := ColorToRGB(StartColor);
      hCol.RGBVal := ColorToRGB(EndColor);

    rR := (hCol.R - lCol.R) / (Colors - 1);
    rG := (hCol.G - lCol.G) / (Colors - 1);
    rB := (hCol.B - lCol.B) / (Colors - 1);
    for iStp := 0 to (Colors - 1) do
      GBand[iStp] := RGB(
        lCol.R + Round(rR * iStp),
        lCol.G + Round(rG * iStp),
        lCol.B + Round(rB * iStp)
        );
  end;
begin

  if Bitmap.PixelFormat <> pf24bit then
    Bitmap.PixelFormat := pf24bit;

  CalculateGradientBand;

  with Bitmap.Canvas do
  begin
    Brush.Color := StartColor;
    FillRect(Bounds(0, 0, AWidth, AHeight));
    if Style = gkVertical then
    begin
      for iLoop := 0 to Colors - 1 do
      begin
        iBndS := MulDiv(iLoop, AWidth, Colors);
        iBndE := MulDiv(iLoop + 1, AWidth, Colors);
        Brush.Color := GBand[iLoop];
        PatBlt(Handle, iBndS, 0, iBndE, AHeight, PATCOPY);
        if (iLoop > 0) and (Dithered) then
          for yLoop := 0 to DitherDepth - 1 do if (yLoop < AHeight)  then
            begin
            Row := Bitmap.Scanline[yLoop];
            for xLoop := 0 to AWidth div (Colors - 1) do
              begin
              XX:= iBndS + Random(xLoop);
              if (XX < AWidth) and (XX > -1) then
               with Row[XX] do
                begin
                rgbtRed := GetRValue(GBand[iLoop - 1]);
                rgbtGreen := GetGValue(GBand[iLoop - 1]);
                rgbtBlue := GetBValue(GBand[iLoop - 1]);
                end;
              end;
            end;
      end;
      for yLoop := 1 to AHeight div DitherDepth do
        CopyRect(Bounds(0, yLoop * DitherDepth, AWidth, DitherDepth),
          Bitmap.Canvas, Bounds(0, 0, AWidth, DitherDepth));
    end
    else
    begin
      for iLoop := 0 to Colors - 1 do
      begin
        iBndS := MulDiv(iLoop, AHeight, Colors);
        iBndE := MulDiv(iLoop + 1, AHeight, Colors);
        Brush.Color := GBand[iLoop];
        PatBlt(Handle, 0, iBndS, AWidth, iBndE, PATCOPY);
        if (iLoop > 0) and (Dithered) then
          for yLoop := 0 to AHeight div (Colors - 1) do
            begin
            YY:=iBndS + Random(yLoop);
            if (YY < AHeight) and (YY > -1) then
             begin
             Row := Bitmap.Scanline[YY];
             for xLoop := 0 to DitherDepth - 1 do if (xLoop < AWidth)  then with Row[xLoop] do
               begin
               rgbtRed := GetRValue(GBand[iLoop - 1]);
               rgbtGreen := GetGValue(GBand[iLoop - 1]);
               rgbtBlue := GetBValue(GBand[iLoop - 1]);
               end;
             end;
            end;
      end;
      for xLoop := 0 to AWidth div DitherDepth do
        CopyRect(Bounds(xLoop * DitherDepth, 0, DitherDepth, AHeight),
          Bitmap.Canvas, Bounds(0, 0, DitherDepth, AHeight));
    end;
  end;

end;


end.
