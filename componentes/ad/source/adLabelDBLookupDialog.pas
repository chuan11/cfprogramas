//==============================================================================
// Unit........: adLabelDBLookupDialog.pas
// Created.....: 28/04/2005
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
//==============================================================================

unit adLabelDBLookupDialog;

interface

{$I ActiveDelphi.inc}
{$R adComponents.res}

uses Classes, SysUtils, DB, {$IFDEF VERSION6_OR_HIGHER} Types {$ELSE} WinTypes {$ENDIF},
{$IFDEF LINUX}
     Qt, QStdCtrls, QControls, QButtons, QTypes,
     QDBGrids, QForms, QGraphics,
{$ELSE}
     Messages,
     Windows, StdCtrls, Controls, Buttons,
     DBGrids, Forms, Graphics,
{$ENDIF}
    adBoundLabel, adLabelDBEdit, adDBGridEX;

type

  TadLabelDBLookupDialog  = class;
  TadCustomButtonEdit     = class;
  TadDialogDefs           = class;
  TadDialogTranslations   = class;

  TOnClickBtnLocate       = procedure(Sender : TObject; var sSQL : string; var bAccept : boolean) of object;
  TOnClickBtnApply        = procedure(Sender : TObject; var bAccept : boolean) of object;
  TOnClickBtnCancel       = procedure(Sender : TObject; var bAccept : boolean) of object;
  TOnDBGridTitleClick     = procedure(const oColumn: TColumn; var bAccept : boolean) of object;
  TOnSortByTitle          = procedure(var sOrderBy : string; var bAccept : boolean) of object;
  
  //-----| Class: TadBoundButton
  
  TadBoundButton = class(TBitBtn{TSpeedButton})
  private
    { Private declarations }
    function GetTop     : integer;
    function GetLeft    : integer;
    function GetWidth   : integer;
    function GetHeight  : integer;
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Owner : TadLabelDBLookupDialog;
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    procedure AdjustPosition(Sender : TControl; var FButtonDefs : TadBoundButton; var FButtonPosition : TadControlPosition; FButtonSpacing : Integer; ButtonPosition: TadControlPosition);
  published
    { Published declarations }
    property Height : integer read  GetHeight  write SetHeight;
    property Left   : integer read  GetLeft;
    property Top    : integer read  GetTop;
    property Width  : integer read  GetWidth   write SetWidth;
  end;

  //-----| Class: TadCustomButtonEdit
  
  TadCustomButtonEdit = class(TadLabelDBEdit)
  private
    { Private declarations }
    FButtonDefs     : TadBoundButton;
    FButtonPosition : TadControlPosition;
    FButtonSpacing  : Integer;
    procedure SetPosition(const Value: TadControlPosition);
    procedure SetSpacing(const Value: Integer);
  protected
    { Protected declarations }
{$IFDEF LINUX}
    procedure SetParent(const Value: TWidgetControl); override;
    procedure Visiblechanged;
    procedure Enabledchanged;
{$ELSE}     
    procedure SetParent(AParent: TWinControl); override;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMVisiblechanged(var Message: TMessage);  message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);  message CM_ENABLEDCHANGED;
{$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetBounds(ALeft: integer; ATop: integer; AWidth: integer; AHeight: integer); override;
  published
    { Published declarations }
    property ButtonDefs     : TadBoundButton      read  FButtonDefs;
    property ButtonPosition : TadControlPosition  read  FButtonPosition write SetPosition  default adRight;
    property ButtonSpacing  : integer             read  FButtonSpacing  write SetSpacing   default 1;
    property ReadOnly default True;
  end;

  //-----| Class: TadDialogTranslations
  
  TadDialogTranslations = class(TPersistent)
  private
    { Private declarations }
    Owner                 : TadDialogDefs;
    FCaptionTitleOptions  : TCaption;
    FHintOptions          : string;
    FCaptionEditSearch    : TCaption;
    FHintEditSearch       : string;
    FHintGridRecords      : string;
    FCaptionBtnLocate     : string;
    FHintBtnLocate        : string;
    FCaptionBtnApply      : string;
    FHintBtnApply         : string;
    FCaptionBtnCancel     : string;
    FHintBtnCancel        : string;
    FCaptionRecordCount   : TCaption;
    FSearchCondition      : TStrings;
    FTitle                : TCaption;
    procedure SetSearchCondition(Value : TStrings);
  public
    { Public declarations }
    constructor Create(AOwner: TadDialogDefs);
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property CaptionTitleOptions  : TCaption  read  FCaptionTitleOptions  write FCaptionTitleOptions;
    property HintOptions          : string    read  FHintOptions          write FHintOptions;
    property CaptionEditSearch    : TCaption  read  FCaptionEditSearch    write FCaptionEditSearch;
    property HintEditSearch       : string    read  FHintEditSearch       write FHintEditSearch;
    property HintGridRecords      : string    read  FHintGridRecords      write FHintGridRecords;
    property CaptionBtnLocate     : string    read  FCaptionBtnLocate     write FCaptionBtnLocate;
    property HintBtnLocate        : string    read  FHintBtnLocate        write FHintBtnLocate;
    property CaptionBtnApply      : string    read  FCaptionBtnApply      write FCaptionBtnApply;
    property HintBtnApply         : string    read  FHintBtnApply         write FHintBtnApply;
    property CaptionBtnCancel     : string    read  FCaptionBtnCancel     write FCaptionBtnCancel;
    property HintBtnCancel        : string    read  FHintBtnCancel        write FHintBtnCancel;
    property CaptionRecordCount   : TCaption  read  FCaptionRecordCount   write FCaptionRecordCount;
    property SearchCondition      : TStrings  read  FSearchCondition      write SetSearchCondition;
    property Title                : TCaption  read  FTitle                write FTitle;
  end;
  
  //-----| Class: TadDialogDefs
  
  TadDialogDefs = class(TPersistent)
  private
    { Private declarations }
    Owner                 : TadLabelDBLookupDialog;
    FFreeOnCloseDialog    : boolean;
    FBorderIcons          : TBorderIcons;
    FBorderStyle          : TFormBorderStyle;
    FBorderWidth          : integer;
    FFormStyle            : TFormStyle;
    FShowModal            : boolean;
    FPosition             : TPosition;
    FGridOptions          : TDBGridOptions;
    FGridTitleFont        : TFont;
    FTranslations         : TadDialogTranslations;
    FGridDefs             : TadGridDefs;
    FAutoOpenListSource   : boolean;
    FAutoCloseListSource  : boolean;
    FDesignColumnsDefs    : TStrings;
    FCharCase             : TEditCharCase;
    procedure SetDesignColumnsDefs(Value : TStrings);
    procedure SetGridDefs(Value : TadGridDefs);
  public
    { Public declarations }
    constructor Create(AOwner: TadLabelDBLookupDialog);
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property  BorderIcons           : TBorderIcons          read  FBorderIcons          write FBorderIcons          default [biMinimize,biMaximize];
    property  BorderStyle           : TFormBorderStyle      read  FBorderStyle          write FBorderStyle          default {$IFDEF LINUX}fbsSizeable{$ELSE}bsSizeable{$ENDIF};
    property  BorderWidth           : integer               read  FBorderWidth          write FBorderWidth          default 0;
    property  FormStyle             : TFormStyle            read  FFormStyle            write FFormStyle            default fsNormal;
    property  ShowModal             : boolean               read  FShowModal            write FShowModal            default True;
    property  Position              : TPosition             read  FPosition             write FPosition             default poDesktopCenter;
    property  GridOptions           : TDBGridOptions        read  FGridOptions          write FGridOptions          default [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
    property  GridTitleFont         : TFont                 read  FGridTitleFont        write FGridTitleFont;
    property  GridDefs              : TadGridDefs           read  FGridDefs             write SetGridDefs;
    property  FreeOnCloseDialog     : boolean               read  FFreeOnCloseDialog    write FFreeOnCloseDialog    default True;
    property  Translations          : TadDialogTranslations read  FTranslations         write FTranslations;
    property  AutoOpenListSource    : boolean               read  FAutoOpenListSource   write FAutoOpenListSource   default True;
    property  AutoCloseListSource   : boolean               read  FAutoCloseListSource  write FAutoCloseListSource  default True;
    property  DesignColumnsDefs     : TStrings              read  FDesignColumnsDefs    write SetDesignColumnsDefs;
    property  CharCase              : TEditCharCase         read  FCharCase             write FCharCase             default ecNormal;
  end;
  
  //-----| Class: TadLabelDBLookupDialog
  
  TadLabelDBLookupDialog = class(TadCustomButtonEdit)
  private
    { Private declarations }
    FormInternal        : TForm;
    FListSource         : TDataSource; 
    FDialogDefs         : TadDialogDefs;
    FOnClickBtnLocate   : TOnClickBtnLocate;
    FOnClickBtnApply    : TOnClickBtnApply; 
    FOnClickBtnCancel   : TOnClickBtnCancel;
    FOnDBGridTitleClick : TOnDBGridTitleClick;
    FOnSortByTitle      : TOnSortByTitle;
    procedure SetDialogDefs(Value : TadDialogDefs);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    ShowDialog : TModalResult; virtual;
  published
    { Published declarations }
    property  ListSource          : TDataSource         read  FListSource         write FListSource;
    property  DialogDefs          : TadDialogDefs       read  FDialogDefs         write SetDialogDefs;
    property  OnClickBtnLocate    : TOnClickBtnLocate   read  FOnClickBtnLocate   write FOnClickBtnLocate;
    property  OnClickBtnApply     : TOnClickBtnApply    read  FOnClickBtnApply    write FOnClickBtnApply; 
    property  OnClickBtnCancel    : TOnClickBtnCancel   read  FOnClickBtnCancel   write FOnClickBtnCancel;
    property  OnDBGridTitleClick  : TOnDBGridTitleClick read  FOnDBGridTitleClick write FOnDBGridTitleClick;
    property  OnSortByTitle       : TOnSortByTitle      read  FOnSortByTitle      write FOnSortByTitle;
  end;
  
  procedure CreateButtonDefs(var FButtonDefs : TadBoundButton; Sender : TControl);
  
implementation

uses adLabelDBLookupDialogForm;

// -----------------------------------------------------------------------------

procedure CreateButtonDefs(var FButtonDefs : TadBoundButton; Sender : TControl);
begin
  if not Assigned(FButtonDefs) then begin
    FButtonDefs       := TadBoundButton.Create(Sender);
    FButtonDefs.Owner := TadLabelDBLookupDialog(Sender);
    FButtonDefs.FreeNotification(Sender);
  end;
end;

// TadBoundButton ---------------------------------------------------------------

constructor TadBoundButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF VERSION6_OR_HIGHER}
  SetSubComponent(True);
  {$ENDIF}
  Height    := 21;
  Width     := 22;
  Name      := 'Button';
  Caption   := '';
  if (csDesigning in ComponentState) then begin
    Glyph.LoadFromResourceName(HInstance, 'TADLABELDBLOOKUPDIALOGIMAGE');
    NumGlyphs := 2;
  end;
end;

// -----------------------------------------------------------------------------

procedure TadBoundButton.Click;
begin
  inherited Click;
  TadLabelDBLookupDialog(Owner).ShowDialog;
end;

// -----------------------------------------------------------------------------

function TadBoundButton.GetHeight: Integer;
begin
  Result := inherited Height;
end;

// -----------------------------------------------------------------------------

function TadBoundButton.GetLeft: Integer;
begin
  Result := inherited Left;
end;

// -----------------------------------------------------------------------------

function TadBoundButton.GetTop: Integer;
begin
  Result := inherited Top;
end;

// -----------------------------------------------------------------------------

function TadBoundButton.GetWidth: Integer;
begin
  Result := inherited Width;
end;

// -----------------------------------------------------------------------------

procedure TadBoundButton.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

// -----------------------------------------------------------------------------

procedure TadBoundButton.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

// -----------------------------------------------------------------------------

procedure TadBoundButton.AdjustPosition(Sender : TControl; var FButtonDefs : TadBoundButton; var FButtonPosition : TadControlPosition; FButtonSpacing : Integer; ButtonPosition: TadControlPosition);
var
  P: TPoint;
begin
  with Sender do begin
    FButtonDefs.Visible        := (ButtonPosition <> adNone);
    if (FButtonDefs <> nil) and Visible then begin
      FButtonPosition          := ButtonPosition;
        
      // Implementação feita em 28/04/2004 por Dennys S. Sobrinho.
      // Sua finalidade é de ajustar corretamente a propriedade Align da 
      // instância FButtonDefs, conforme objeto associado.
      if (Align = alNone) then
        FButtonDefs.Align := alNone
      else if (Align in [alClient, alTop, alBottom]) then begin
        case FButtonPosition of
          adLeft: 
          begin
            if (Align = alClient) then 
              FButtonDefs.Align := alLeft
            else  
              FButtonDefs.Align := alNone;
          end;    
          adRight:
          begin
            if (Align = alClient) then 
              FButtonDefs.Align := alRight
            else
              FButtonDefs.Align := alNone;
          end;  
          adAboveLeft,
          adAboveRight: FButtonDefs.Align := alTop;
          adBelowLeft,
          adBelowRight: FButtonDefs.Align := alBottom;
        else  
          FButtonDefs.Align := alNone;
        end;
      end;
      // Final da implementação.
      
      case ButtonPosition of
        adAboveLeft  : P := Point(Left, Top - FButtonDefs.Height - FButtonSpacing);
        adAboveRight : P := Point((Left+Width)-FButtonDefs.Width, Top - FButtonDefs.Height - FButtonSpacing);
        adBelowLeft  : P := Point(Left, Top + Height + FButtonSpacing);
        adBelowRight : P := Point((Left+Width)-FButtonDefs.Width, Top + Height + FButtonSpacing);
        adLeft       : P := Point(Left - FButtonDefs.Width - FButtonSpacing, Top + ((Height - FButtonDefs.Height) div 2));
        adRight      : P := Point(Left + Width + FButtonSpacing, Top + ((Height - FButtonDefs.Height) div 2));
      end;
      FButtonDefs.SetBounds(P.x, P.y, FButtonDefs.Width, FButtonDefs.Height);
    end;
  end;
end;

// TadCustomButtonEdit ---------------------------------------------------------

constructor TadCustomButtonEdit.Create(AOwner: TComponent); 
begin
  inherited Create(AOwner);
  Width           := 145;
  FButtonPosition := adRight;
  FButtonSpacing  := 1;
  ReadOnly        := True;
  CreateButtonDefs(FButtonDefs, Self);
end;

// -----------------------------------------------------------------------------

destructor TadCustomButtonEdit.Destroy;
begin
  if Assigned(FButtonDefs) then FreeAndNil(FButtonDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------
{$IFNDEF LINUX}
procedure TadCustomButtonEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if Assigned(FButtonDefs) then
    FButtonDefs.BiDiMode := BiDiMode;
end;
{$ENDIF}

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomButtonEdit.Visiblechanged;
{$ELSE}
procedure TadCustomButtonEdit.CMVisiblechanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FButtonDefs) then
    FButtonDefs.Visible := Visible;
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomButtonEdit.EnabledChanged;
{$ELSE}
procedure TadCustomButtonEdit.CMEnabledchanged(var Message: TMessage);
{$ENDIF}
begin
  inherited;
  if Assigned(FButtonDefs) then
    FButtonDefs.Enabled := Enabled;
end;

// -----------------------------------------------------------------------------

procedure TadCustomButtonEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FButtonDefs) then
    FButtonDefs := nil;
end;

// -----------------------------------------------------------------------------

procedure TadCustomButtonEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetPosition(FButtonPosition);
end;

// -----------------------------------------------------------------------------

procedure TadCustomButtonEdit.SetPosition(const Value: TadControlPosition);
begin
  if Assigned(FButtonDefs) then
    FButtonDefs.AdjustPosition(Self, FButtonDefs, FButtonPosition, FButtonSpacing, Value);
end;

// -----------------------------------------------------------------------------

procedure TadCustomButtonEdit.SetSpacing(const Value: Integer);
begin
  FButtonSpacing := Value;
  SetPosition(FButtonPosition);
end;

// -----------------------------------------------------------------------------

{$IFDEF LINUX}
procedure TadCustomButtonEdit.SetParent(const Value: TWidgetControl);
begin
  inherited SetParent(Value);
  if Assigned(FButtonDefs) then begin
    FButtonDefs.Parent  := Value;
    FButtonDefs.Visible := True;
  end;
end;
{$ELSE}
procedure TadCustomButtonEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FButtonDefs) then begin
    FButtonDefs.Parent  := AParent;
    FButtonDefs.Visible := True;
  end;
end;
{$ENDIF}

// TadLabelDBLookupDialog ----------------------------------------------------------------

constructor TadLabelDBLookupDialog.Create(AOwner: TComponent); 
begin
  inherited Create(AOwner);
  FDialogDefs := TadDialogDefs.Create(Self);
end;

// -----------------------------------------------------------------------------

destructor TadLabelDBLookupDialog.Destroy;
begin
  if Assigned(FDialogDefs) then FreeAndNil(FDialogDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBLookupDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FListSource) then
    FListSource := nil
end;

// -----------------------------------------------------------------------------

function TadLabelDBLookupDialog.ShowDialog : TModalResult;
begin
  Result := mrNone;
  if Assigned(ListSource) then begin
    if not Assigned(FormInternal) then
      FormInternal := Tfrm_LookupDialog.Create(Application.MainForm);
    with Tfrm_LookupDialog(FormInternal) do begin
      FDBLookupDialog     := Self;
      BorderIcons         := DialogDefs.BorderIcons;
      BorderStyle         := DialogDefs.BorderStyle;
      {$IFNDEF LINUX}
      BorderWidth         := DialogDefs.BorderWidth;
      {$ENDIF}
      FormStyle           := DialogDefs.FormStyle;
      Position            := DialogDefs.Position;
      grd_Records.Options := DialogDefs.GridOptions;
      SetInternalDefs;
      if DialogDefs.ShowModal then begin
        ShowModal;
        Result := iModalResult;
        if DialogDefs.FreeOnCloseDialog then begin
           Release;
           FreeAndNil(FormInternal);
        end;
      end else
        Show;   
    end;
  end else
    Application.MessageBox('É necessário atribuir um DataSource para a propriedade ListSource.', 'ATENÇÃO !', MB_ICONINFORMATION+MB_OK);
end;

// -----------------------------------------------------------------------------

procedure TadLabelDBLookupDialog.SetDialogDefs(Value : TadDialogDefs);
begin
  if (FDialogDefs <> Value) then 
    FDialogDefs.Assign(Value);
end;

// TadDialogDefs ---------------------------------------------------------------

constructor TadDialogDefs.Create(AOwner: TadLabelDBLookupDialog);
begin
  inherited Create;
  Owner                           := AOwner;
  FBorderIcons                    := [biMinimize,biMaximize]; 
  FBorderStyle                    := {$IFDEF LINUX}fbsSizeable{$ELSE}bsSizeable{$ENDIF};
  FBorderWidth                    := 0;
  FFormStyle                      := fsNormal;
  FShowModal                      := True;
  FPosition                       := poDesktopCenter;
  FGridOptions                    := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  FGridTitleFont                  := TFont.Create;
  FGridTitleFont.Style            := [fsBold];
  FGridDefs                       := TadGridDefs.Create(AOwner);
  FFreeOnCloseDialog              := True;
  FTranslations                   := TadDialogTranslations.Create(Self);
  FAutoOpenListSource             := True;
  FAutoCloseListSource            := True;
  FDesignColumnsDefs              := TStringList.Create;
  FCharCase                       := ecNormal;
end;

// -----------------------------------------------------------------------------

destructor TadDialogDefs.Destroy;
begin
  if Assigned(FGridTitleFont)         then FreeAndNil(FGridTitleFont);
  if Assigned(FDesignColumnsDefs)     then FreeAndNil(FDesignColumnsDefs);
  if Assigned(FGridDefs)              then FreeAndNil(FGridDefs);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadDialogDefs.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadDialogDefs) then begin
    FBorderIcons          := TadDialogDefs(Source).FBorderIcons;
    FBorderStyle          := TadDialogDefs(Source).FBorderStyle; 
    FBorderWidth          := TadDialogDefs(Source).FBorderWidth; 
    FFormStyle            := TadDialogDefs(Source).FFormStyle;   
    FShowModal            := TadDialogDefs(Source).FShowModal;   
    FPosition             := TadDialogDefs(Source).FPosition;    
    FGridOptions          := TadDialogDefs(Source).FGridOptions;
    FFreeOnCloseDialog    := TadDialogDefs(Source).FFreeOnCloseDialog;
    FAutoOpenListSource   := TadDialogDefs(Source).FAutoOpenListSource;  
    FAutoCloseListSource  := TadDialogDefs(Source).FAutoCloseListSource;  
    FCharCase             := TadDialogDefs(Source).FCharCase;         
    FGridTitleFont.Assign(TadDialogDefs(Source).FGridTitleFont);
    FTranslations.Assign(TadDialogDefs(Source).FTranslations);
    FDesignColumnsDefs.Assign(TadDialogDefs(Source).FDesignColumnsDefs);
    FGridDefs.Assign(TadDialogDefs(Source).FGridDefs);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDialogDefs.SetDesignColumnsDefs(Value : TStrings);
begin
  if (FDesignColumnsDefs <> Value) then 
    FDesignColumnsDefs.Assign(Value);
end;

// -----------------------------------------------------------------------------

procedure TadDialogDefs.SetGridDefs(Value : TadGridDefs);
begin
  FGridDefs.Assign(Value);
end;

// TadDialogTranslations -------------------------------------------------------

constructor TadDialogTranslations.Create(AOwner: TadDialogDefs);
begin
  inherited Create;
  Owner                 := AOwner;
  FCaptionTitleOptions  := 'Condições de Busca';
  FHintOptions          := '|Escolha uma das opções...';
  FCaptionEditSearch    := 'Informe (%s) : ';
  FHintEditSearch       := 'Informe o texto|Informe neste campo o conteúdo a ser localizado...';
  FHintGridRecords      := 'Lista dos registros localizados|Click no título da coluna para definir a ordem de busca...';
  FCaptionBtnLocate     := 'Localizar...';
  FHintBtnLocate        := 'Click para localizar|Click neste botão para iniciar o processo de localização das informações...';
  FCaptionBtnApply      := 'Aplicar';
  FHintBtnApply         := 'Click para aplicar|Click neste botão para aplicar o registro selecionado...';
  FCaptionBtnCancel     := 'Cancelar';
  FHintBtnCancel        := 'Click para cancelar|Click neste botão para cancelar...';
  FCaptionRecordCount   := 'Registros Localizados : %s';
  FTitle                := 'Tela de localização de registro.';
  FSearchCondition      := TStringList.Create;
  FSearchCondition.Add('Inicie com :  = macro[being]');
  FSearchCondition.Add('Termine com : = macro[end]');
  FSearchCondition.Add('Contenha : = macro(contain]');
  FSearchCondition.Add('Seja igual a : = macro[equal]');
  FSearchCondition.Add('Seja diferente de : = macro[different]');
  FSearchCondition.Add('Seja maior que : = macro[larger]');
  FSearchCondition.Add('Seja menor que : = macro[smaller]');
  FSearchCondition.Add('Seja maior ou igual que : = macro[larger_equal]');
  FSearchCondition.Add('Seja menor ou igual que : = macro[smaller_equal]');
end;

// -----------------------------------------------------------------------------

destructor TadDialogTranslations.Destroy;
begin
  if Assigned(FSearchCondition) then FreeAndNil(FSearchCondition);
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

procedure TadDialogTranslations.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TadDialogTranslations) then begin
    FCaptionTitleOptions  := TadDialogTranslations(Source).FCaptionTitleOptions;
    FHintOptions          := TadDialogTranslations(Source).FHintOptions; 
    FCaptionEditSearch    := TadDialogTranslations(Source).FCaptionEditSearch; 
    FHintEditSearch       := TadDialogTranslations(Source).FHintEditSearch;   
    FCaptionBtnLocate     := TadDialogTranslations(Source).FCaptionBtnLocate;   
    FHintBtnLocate        := TadDialogTranslations(Source).FHintBtnLocate;    
    FHintGridRecords      := TadDialogTranslations(Source).FHintGridRecords;
    FCaptionBtnApply      := TadDialogTranslations(Source).FCaptionBtnApply;
    FHintBtnApply         := TadDialogTranslations(Source).FHintBtnApply;
    FCaptionBtnCancel     := TadDialogTranslations(Source).FCaptionBtnCancel;
    FHintBtnCancel        := TadDialogTranslations(Source).FHintBtnCancel;
    FCaptionRecordCount   := TadDialogTranslations(Source).FCaptionRecordCount;
    FTitle                := TadDialogTranslations(Source).FTitle;
    FSearchCondition.Assign(TadDialogTranslations(Source).FSearchCondition);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadDialogTranslations.SetSearchCondition(Value : TStrings);
begin
  if (FSearchCondition <> Value) then
    FSearchCondition.Assign(Value);
end;

// -----------------------------------------------------------------------------

end.
