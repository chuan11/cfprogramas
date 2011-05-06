//==============================================================================
// Unit........: adLabelImageEX.pas
// Created.....: 20/04/2005
// Type Unit...: Cross platform
// -----------------------------------------------------------------------------
// Author......: Eduardo Rocha
// E-Mail......: eduardo@activedelphi.com.br
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
// 12/05/2005 - Foi modificada a herança desta classe para TadLabelImage e 
//              também alguns ajustes em seu código.
//==============================================================================

unit adLabelImageEX;

interface

{$I ActiveDelphi.inc}
  
uses Classes, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF}, SysUtils,
{$IFDEF LINUX}
     QStdCtrls, QControls, QTypes, QExtCtrls, QGraphics,
{$ELSE}
     StdCtrls, Controls, Messages, ExtCtrls, Graphics,
{$ENDIF}
     adLabelImage;

type

  TadLabelImageEX = class (TadLabelImage)
  private
    FOldPictureChanged    : TNotifyEvent;
    FMousePressed         : boolean;
    FMouseOver            : boolean;
    FMouseLeave           : boolean;
    FCapturePictureDefault: Boolean;
    FOnMouseLeave         : TNotifyEvent;
    FOnMouseEnter         : TNotifyEvent;
    FPictureDefault       : TPicture;
    FPictureClick         : TPicture;
    FPictureOver          : TPicture;
    procedure SetPictureClick(Value: TPicture);
    procedure SetPictureOver(Value: TPicture);
    procedure PictureChanged(Sender: TObject);
  protected
    { Protected declarations }
{$IFDEF LINUX}
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
{$ELSE}     
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$ENDIF}
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;    
    destructor Destroy; override;    
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  published
    { Published declarations }
    property Action;
    property Align;
    property PictureClick   : TPicture          read FPictureClick    write SetPictureClick;
    property PictureOver    : TPicture          read FPictureOver     write SetPictureOver;
    property OnMouseEnter   : TNotifyEvent      read FOnMouseEnter    write FOnMouseEnter;
    property OnMouseLeave   : TNotifyEvent      read FOnMouseLeave    write FOnMouseLeave;
  end;

implementation

// TadLabelImageEX ------------------------------------------------------------------

constructor TadLabelImageEX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMousePressed           := False;
  FMouseOver              := False;
  FMouseLeave             := True;
  
  FCapturePictureDefault  := True;
  FOldPictureChanged      := Picture.OnChange;
  Picture.OnChange        := PictureChanged;
  FPictureDefault         := TPicture.Create;
  FPictureClick           := TPicture.Create;
  FPictureOver            := TPicture.Create;
end;

// -----------------------------------------------------------------------------

destructor TadLabelImageEX.Destroy;    
begin
  FreeAndNil(FPictureClick);
  FreeAndNil(FPictureOver);
  FreeAndNil(FPictureDefault);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FMousePressed := True;
  if not (csDesigning in ComponentState) then begin
    if Assigned(FPictureClick) then
    begin
      FCapturePictureDefault := False;
      try
        Picture.Assign(FPictureClick);
      finally
        FCapturePictureDefault := True;
      end;
    end;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FMousePressed := False;
  if Assigned(FPictureDefault) then begin
    FCapturePictureDefault := False;
    try
      if FMouseOver then
        Picture.Assign(FPictureOver)
      else
        Picture.Assign(FPictureDefault);
    finally
      FCapturePictureDefault := True;
    end;
  end;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLabelImageEX.MouseEnter(AControl: TControl);
{$ELSE}
procedure TadLabelImageEX.CMMouseEnter(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  FMouseLeave := False;
  FMouseOver  := not FMouseLeave;
  DoMouseEnter;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadLabelImageEX.MouseLeave(AControl: TControl);
{$ELSE}
procedure TadLabelImageEX.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  FMouseLeave := True;
  FMouseOver  := not FMouseLeave;
  DoMouseLeave;
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.DoMouseEnter;
begin
  if not (csDesigning in ComponentState) then begin
    if Assigned(FPictureOver) then
    begin
      FCapturePictureDefault := False;
      try
        if FMousePressed then
          Picture.Assign(FPictureClick)
        else
          Picture.Assign(FPictureOver);
      finally
        FCapturePictureDefault := True;
      end;
    end;
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.DoMouseLeave;
begin
  if not (csDesigning in ComponentState) then begin
    if Assigned(FPictureDefault) then begin
      FCapturePictureDefault := False;
      try
        if FMousePressed then
          Picture.Assign(FPictureClick)
        else
          Picture.Assign(FPictureDefault);
      finally
        FCapturePictureDefault := True;
      end;
    end;
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.SetPictureClick(Value: TPicture);
begin
  FPictureClick.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.SetPictureOver(Value: TPicture);
begin
  FPictureOver.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadLabelImageEX.PictureChanged(Sender: TObject);
begin
  if Assigned(FOldPictureChanged) then FOldPictureChanged(Sender);
  if FCapturePictureDefault then FPictureDefault.Assign(Picture);
end;

// -----------------------------------------------------------------------------

end.

