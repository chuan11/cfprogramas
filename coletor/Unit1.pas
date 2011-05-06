unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, funcoes, verificaSenhas ;
type
  TfmMain = class(TForm)
    edEan: TEdit;
    lbEanRecebido: TLabel;
    menu: TMainMenu;
    File1: TMenuItem;
    NovaCaptura1: TMenuItem;
    DeletaItem1: TMenuItem;
    edQuant: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edDescricao: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure edEanKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function getDadosProduto():boolean;
    procedure tratarQuantidade();
    procedure gravaContagem();
    procedure desabilitaItens();
    procedure habilitaItens();
    procedure NovaCaptura1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  ITENS:Tstringlist;
  EAN:String;
  CRITICA_CODIGO, CONTAGEM_UNITARIA: BOOLEAN;

  COD_POS_INICIO:integer;
  COD_POS_TAMANHO:integer;

implementation
uses uNovaContagem;

{$R *.dfm}

procedure TfmMain.FormActivate(Sender: TObject);
var
  arq:String;
begin
   COD_POS_INICIO := 01;
   COD_POS_TAMANHO := 13;

   CRITICA_CODIGO := true;
   CONTAGEM_UNITARIA := true;

   arq := extractFilePath(ParamStr(0))  + '\lookUp\LookUp.txt';
   if (fileExists(arq) = true) then
   begin
      ITENS := TStringList.Create();
      ITENS.LoadFromFile(arq) ;
      ITENS.Sort();
   end
   else
      showMessage('Não achei o arquivo de lookup');
end;

function TfmMain.getDadosProduto():boolean;
var
  i:integer;
  achou:boolean;
begin
  screen.Cursor := crHourGlass;
  achou := false;
  lbEanRecebido.Caption := edEan.Text;
  for i:=0 to ITENS.Count -1 do
  begin
     if ( edEan.Text = trim(copy(ITENS[i], COD_POS_INICIO, COD_POS_TAMANHO)))  then
     begin
        edDescricao.text := copy(ITENS[i], COD_POS_TAMANHO+1 , 20) ;
        achou := true;
        break;
     end;
     if(achou = false) then
        edDescricao.Text := 'Não Cadastrado.';
  end;
  result := achou;
  screen.Cursor := crDefault;
end;

procedure TfmMain.tratarQuantidade;
begin
   if ( CONTAGEM_UNITARIA = true ) then
   begin
      edQuant.Text := '000001';
      gravaContagem();
   end
   else
      edQuant.SetFocus();
end;

procedure TfmMain.edEanKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = VK_RETURN THEN
  begin
     if ( getDadosProduto() = true )then
        tratarQuantidade()
     else
     begin
        if ( CRITICA_CODIGO = true ) then
        begin
           edQuant.Text := '';
           edQuant.SetFocus();
           edEan.SetFocus();
        end
        else
           tratarQuantidade();
     end;
  end;
end;

procedure TfmMain.gravaContagem;
begin //

end;

procedure TfmMain.desabilitaItens;
begin
   label2.Visible := false;
   label3.Visible := false;
   edEan.Visible := false;
   edQuant.Visible := false;
   edDescricao.Visible := false;
end;
procedure TfmMain.habilitaItens;
begin
   label2.Visible := true;
   label3.Visible := true;
   edEan.Visible := true;
   edQuant.Visible := true;
   edDescricao.Visible := true;
end;

procedure TfmMain.NovaCaptura1Click(Sender: TObject);
begin
   if verificaSenhas.telaAutorizacaoSimples('walter') = true then
   begin
      desabilitaItens();
      application.CreateForm(TfmNovaContagem, fmNovaContagem);
      fmNovaContagem.Show;
   end
end;

end.
