unit uDestinoEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, ExtCtrls,
  TFlatButtonUnit;

type
  TfmDestEmail = class(TForm)
    rg: TRadioGroup;
    cbLoja: TadLabelComboBox;
    edMail: TadLabelEdit;
    pnConfirma: TPanel;
    BitBtn1: TFlatButton;
    FlatButton1: TFlatButton;
    lbEmail: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure rgClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDestEmail: TfmDestEmail;

implementation

uses uMain, funcsql, funcoes;

{$R *.dfm}


procedure TfmDestEmail.BitBtn1Click(Sender: TObject);
begin
   if (rg.ItemIndex = 0) then
      lbEmail.Caption := funcsql.openSQL('Select email from zcf_tbuo (NOLOCK) where is_uo = ' + funcoes.getCodUO(cbLoja), 'email', fmMain.conexao)
   else
      lbEmail.Caption := trim(edMail.Text);
end;

procedure TfmDestEmail.rgClick(Sender: TObject);
begin
   if rg.ItemIndex  = 0 then
   begin
      cbLoja.Visible := true;
      edMail.Visible := false;
      cbLoja.ItemIndex := 0;
   end
   else
   begin
      cbLoja.Visible := false;
      edMail.Visible := true;
   end;
end;

procedure TfmDestEmail.FormShow(Sender: TObject);
begin
//   cbLoja.Items := funcsql.GetNomeLojas(fmMain.conexao, false,false,'','');
//   cbLoja.ItemIndex := -1;
   fmMain.getListaLojas(cbLoja, false, false, '' );

end;

end.
