//==============================================================================
// Unit........: adServerConnection.pas
// Created.....: 14/06/2005
// Type Unit...: Cross platform
// -----------------------------------------------------------------------------
// Author......: Dennys dos Santos Sobrinho
// E-Mail......: dennys@activedelphi.com.br
// Copyright...: Revista ActiveDelphi
// Distribui��o: Licen�a p�blica GNU GPL
//               http://lie-br.conectiva.com.br/licenca_gnu.html
// Observa��o..: Qualquer modifica��o ou implementa��o, dever� ser enviada para
//               o autor a fim de atualizar os demais beneficiados.
// .............................................................................
// Hist�rico
// ---------
// 14/06/2005 - Foi implementado a propriedade About para informar a vers�o 
//              atual do componente e os cr�ditos dos colaboradores.
//==============================================================================

unit adServerConnection;

interface

uses
  SysUtils, Classes;

type

  //-----| Class: TadServerConnection

  TadServerConnection = class(TComponent)
  private
    { Private declarations }
    FAbout : string;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property About : string read  FAbout  write FAbout;
  end;

implementation

// TadServerConnection ---------------------------------------------------------

constructor TadServerConnection.Create(AOwner: TComponent); 
begin
  inherited Create(AOwner);
  FAbout := '';
end;

// -----------------------------------------------------------------------------

destructor TadServerConnection.Destroy;
begin
  inherited Destroy;
end;

// -----------------------------------------------------------------------------

end.
 