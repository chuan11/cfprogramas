//==============================================================================
// Unit........: adClientConnection.pas
// Created.....: 14/06/2005
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
// 14/06/2005 - Foi implementado a propriedade About para informar a versão 
//              atual do componente e os créditos dos colaboradores.
//==============================================================================

unit adClientConnection;

interface

uses
  SysUtils, Classes, Variants, DBClient, Midas, Provider;

type

  //-----| Class: TadClientConnection

  TadClientConnection = class(TCustomRemoteServer, IAppServer)
  private
    { Private declarations }
    FAbout      : string;
    FAppServer  : IAppServer;
    FProviders  : TList;
    function GetProviderCount: integer;
  protected
    { Protected declarations }
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
    { IAppServer }
    function AS_GetProviderNames: OleVariant; safecall;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant;
      MaxErrors: Integer; out ErrorCount: Integer;
      var OwnerData: OleVariant): OleVariant; safecall;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: WideString;
      var Params, OwnerData: OleVariant): OleVariant; safecall;
    function AS_DataRequest(const ProviderName: WideString;
      Data: OleVariant): OleVariant; safecall;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; safecall;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant;
      RequestType: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: WideString;
      const CommandText: WideString; var Params, OwnerData: OleVariant); safecall;
    function GetConnected: Boolean; override;
    procedure GetProviderNames(Proc: TGetStrProc); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RegisterProvider(Prov: TCustomProvider);
    procedure UnRegisterProvider(Prov: TCustomProvider);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AppServer: IAppServer read FAppServer;
    function GetServer: IAppServer; override;
    property Providers[const ProviderName: string]: TCustomProvider read GetProvider;
    property ProviderCount: integer read GetProviderCount;
  published
    { Published declarations }
    property About : string read  FAbout  write FAbout;
  end;
  
  resourcestring
  { App Server }
    SProviderNotExported = 'O "Provider" não foi exportado: %s';
  
implementation

// TadClientConnection ---------------------------------------------------------

constructor TadClientConnection.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
  RCS;
  FAbout      := '';
  FProviders  := TList.Create;
  FAppServer  := Self as IAppServer;
  for i := 0 to (AOwner.ComponentCount-1) do begin
    if (AOwner.Components[i] is TCustomProvider) then
      RegisterProvider(TCustomProvider(AOwner.Components[i]));
  end;
end;

// -----------------------------------------------------------------------------

destructor TadClientConnection.Destroy;
begin
  FProviders.Free;
  FAppServer := nil;
  inherited;
end;

// -----------------------------------------------------------------------------

function TadClientConnection.GetProviderCount: integer;
begin
  Result := FProviders.Count;
end;

// -----------------------------------------------------------------------------

function TadClientConnection.GetConnected: Boolean;
begin
  Result := True;
end;

// -----------------------------------------------------------------------------

function TadClientConnection.GetServer: IAppServer;
begin
  Result := FAppServer;
end;

// -----------------------------------------------------------------------------

procedure TadClientConnection.GetProviderNames(Proc: TGetStrProc);
var
  List  : Variant;
  I     : Integer;
begin
  Connected := True;
  VarClear(List);
  try
    List := AppServer.AS_GetProviderNames;
  except
    { Assume any errors means the list is not available. }
  end;
  if VarIsArray(List) and (VarArrayDimCount(List) = 1) then begin
    for I := VarArrayLowBound(List, 1) to VarArrayHighBound(List, 1) do
      Proc(List[I]);
  end;
end;

// -----------------------------------------------------------------------------

procedure TadClientConnection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent is TCustomProvider) then begin
    if (Operation = opInsert) then
      RegisterProvider(TCustomProvider(AComponent)) 
    else
      UnRegisterProvider(TCustomProvider(AComponent));
  end;
end;

// -----------------------------------------------------------------------------

procedure TadClientConnection.RegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Add(Prov);
end;

// -----------------------------------------------------------------------------

procedure TadClientConnection.UnRegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Remove(Prov);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_GetProviderNames: OleVariant;
var
  List: TStringList;
  i: Integer;
begin
  List := TStringList.Create;
  try
    for i := 0 to (FProviders.Count-1) do begin
      if TCustomProvider(FProviders[i]).Exported then
        List.Add(TCustomProvider(FProviders[i]).Name);
    end;    
    List.Sort;
    Result := VarArrayFromStrings(List);
  finally
    List.Free;
  end;
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_ApplyUpdates(const ProviderName: WideString;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].ApplyUpdates(Delta, MaxErrors, ErrorCount, OwnerData);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_GetRecords(const ProviderName: WideString; Count: Integer;
  out RecsOut: Integer; Options: Integer; const CommandText: WideString;
  var Params, OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].GetRecords(Count, RecsOut, Options, CommandText, Params, OwnerData);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_RowRequest(const ProviderName: WideString;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].RowRequest(Row, RequestType, OwnerData);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_DataRequest(const ProviderName: WideString;
  Data: OleVariant): OleVariant; safecall;
begin
  Result := Providers[ProviderName].DataRequest(Data);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].GetParams(OwnerData);
end;

// -----------------------------------------------------------------------------

procedure TadClientConnection.AS_Execute(const ProviderName: WideString;
  const CommandText: WideString; var Params, OwnerData: OleVariant);
begin
  Providers[ProviderName].Execute(CommandText, Params, OwnerData);
end;

// -----------------------------------------------------------------------------

function TadClientConnection.GetProvider(const ProviderName: string): TCustomProvider;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do begin
    if (AnsiCompareText(TCustomProvider(FProviders[i]).Name, ProviderName) = 0) then begin
      Result := TCustomProvider(FProviders[i]);
      if not Result.Exported then
        Result := nil;
      Exit;
    end;
  end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);
end;

// -----------------------------------------------------------------------------

end.
 