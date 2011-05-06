//==============================================================================
// Unit........: adFrmAbout.pas
// Created.....: 08/04/2005
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

unit adFrmAbout;

interface

{$I ActiveDelphi.inc}

uses {$IFDEF VERSION6_OR_HIGHER}Types, {$ELSE}WinTypes, {$ENDIF}
{$IFNDEF LINUX}
     Windows, 
     StdCtrls, Buttons, Graphics, Controls, ExtCtrls, Forms, jpeg, ShellApi,
{$ELSE}
     QTypes,
     QStdCtrls, QButtons, QGraphics, QControls, QExtCtrls, QForms,
{$ENDIF}
     SysUtils, Classes;
     
const
  aURLs : array[1..3] of string = ('http://www.activedelphi.com.br',
                                   'http://www.softworkti.com.br',
                                   'http://www.edudelphipage.com.br');
                                   
type

  TmyHackControl = class(TControl);
  TWebKind = (wkEmail, wkHttp);
   
  Tfrm_About = class(TForm)
    Panel1: TPanel;
    pnl_LogoActiveDelphi: TPanel;
    pnl_Developer: TPanel;
    pnl_ColorDeveloper: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    pnl_Title: TPanel;
    Panel5: TPanel;
    lbl_OfficialSite: TLabel;
    lbl_OfficialSiteLink: TLabel;
    bb_Close: TBitBtn;
    mm_CreditsGratitudes: TMemo;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel3: TPanel;
    img_LogoActiveDelphi: TImage;
    img_Colaborador1: TImage;
    img_Colaborador2: TImage;
    img_Colaborador3: TImage;
    tm_ShowLogoMarca: TTimer;
    procedure bb_CloseClick(Sender: TObject);
    procedure OnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tm_ShowLogoMarcaTimer(Sender: TObject);
    procedure img_LogoActiveDelphiClick(Sender: TObject);
  private
    { Private declarations }
    sDefaultHint : string;
  public
    { Public declarations }
    FVersion : string;
  end;

var
   frm_About: Tfrm_About;

implementation

{$IFNDEF LINUX}
   {$R *.dfm}
{$ELSE}
   {$R *.xfm}
{$ENDIF}

procedure OpenLink(const FWebKind : TWebKind; AWebSource: string);
var
  Buffer : string;
begin
  //caso o tipo selecionado seja...
  case FWebKind of
    // para Email.
    wkEmail : Buffer := 'Mailto:' + AWebSource;
    // para URL.              
    wkHttp  : Buffer := {'Http://' +} AWebSource;
  end;
  {$IFNDEF LINUX}
    ShellExecute(Application.Handle, nil, PChar(Buffer), nil, nil, SW_SHOWNORMAL);
  {$ELSE}
  
  {$ENDIF}
end;

// -----------------------------------------------------------------------------

procedure Tfrm_About.FormShow(Sender: TObject);
begin
  sDefaultHint := img_LogoActiveDelphi.Hint;
  tm_ShowLogoMarcaTimer(Sender);
  Self.Caption := 'About: ActiveDelphi Components - '+FVersion;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_About.bb_CloseClick(Sender: TObject);
begin
  Self.Close;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_About.OnClick(Sender: TObject);
begin
  with TmyHackControl(Sender) do begin
    Font.Color := clNavy;
    Font.Style := [fsBold, fsUnderline];
    OpenLink(TWebKind(Tag), Caption);
  end;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_About.tm_ShowLogoMarcaTimer(Sender: TObject);
begin
  img_LogoActiveDelphi.Tag := (img_LogoActiveDelphi.Tag + 1);
  if (img_LogoActiveDelphi.Tag > 3) then
    img_LogoActiveDelphi.Tag := 1;
  img_LogoActiveDelphi.Picture := nil;
  case img_LogoActiveDelphi.Tag of
    1: img_LogoActiveDelphi.Picture.Assign(img_Colaborador1.Picture);
    2: img_LogoActiveDelphi.Picture.Assign(img_Colaborador2.Picture);
    3: img_LogoActiveDelphi.Picture.Assign(img_Colaborador3.Picture);
  end;
  img_LogoActiveDelphi.Hint := Format(sDefaultHint, [aURLs[img_LogoActiveDelphi.Tag]]);
end;

// -----------------------------------------------------------------------------

procedure Tfrm_About.img_LogoActiveDelphiClick(Sender: TObject);
begin
  OpenLink(wkHttp, aURLs[img_LogoActiveDelphi.Tag]);
end;

// -----------------------------------------------------------------------------

end.
