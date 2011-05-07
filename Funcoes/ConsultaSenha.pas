unit ConsultaSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, adLabelEdit, funcsql,
  DB, ADODB,funcoes;

type
  TFmSenha = class(TForm)
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    edit: TadLabelEdit;
    cbUsuarios: TadLabelComboBox;
    Conexao: TADOConnection;
    cbLoja: TadLabelComboBox;
    cbJustificativa: TadLabelComboBox;
    lbMsg: TLabel;
    lbMsgTelaSimples: TLabel;
    procedure VerificaSenha(Sender:Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editKeyDown(Sender: TObject; var Key: Word; shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure habilitaJustificativa(Sender:Tobject);
    function verificaErros(Sender:Tobject):string;
    procedure FlatButton2Click(Sender: TObject);
    procedure cbLojaChange(Sender: TObject);
    procedure desabilitaJustificativa();
    procedure preparaSenhaSimples(Senha:String);
    procedure autorizacaoGeral();
    procedure autorizacaoSimples();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    { Private declarations }
  public
    { Public declarations }
  end;
var
  FmSenha: TFmSenha;
  PERFIL:INTEGER;
implementation

{$R *.dfm}

procedure TFmSenha.desabilitaJustificativa();
begin
   cbLoja.Visible := false;
   cbUsuarios.Visible := true;
   cbUsuarios.Top := 20;
   cbJustificativa.Visible := false;
   edit.Visible := true;
   edit.Top := cbUsuarios.Top + cbUsuarios.Height + 20;
   FlatButton1.top := edit.top + edit.Height + 20;
   FlatButton2.top := FlatButton1.top;
   fmSenha.ClientHeight :=  FlatButton1.Top + FlatButton1.Height + 30;
end;


procedure TFmSenha.habilitaJustificativa(Sender:Tobject);
begin
   fmSenha.cbLoja.Visible := false;
   fmSenha.cbJustificativa.visible := true;

   cbUsuarios.Top := 20;
   edit.Top := 60;
   cbJustificativa.Top := 100;
   fmSenha.flatButton1.top := 130;
   fmSenha.flatButton2.top :=   flatButton1.top;

   fmSenha.Height := 210;
end;

function FEncryptDecrypt(pTexto : String; pT : String) : String;
var
 wStr    : String;
 wReturn : String;
 wLB : Integer;
 wS  : Integer;
 wB  : Integer;
 i   : Integer;
begin
  // Retornará o pTexto Encrypt ou decrypt
  // ptexto - String a ser (E)criptografada ou (D)descriptografada
  // pT     - Letra (E ou D) que identifica a função a ser usada em pTexto.
  pT      := UpperCase(pT);
  wStr    := '0A1b2C3d4E5f6G7h8I9j10L11m12N13o14P15q16R17s18T19u20V21x22Z23';
  wLB     := Length(wStr);
  wReturn := '';
  wS      := 0;
  wB      := 0;
  For i := 1 To Length(pTexto) do
  begin
    wB := wB Mod wLB + 1;
    wS := wS + Ord(wStr[wB]);
    If pT = 'E' Then
      wReturn := wReturn + Chr(Ord((pTexto[i])) + (ord(wStr[wB]) + wS) Mod 128)
    Else If pT = 'D' Then
      wReturn := wReturn + Chr(Ord((pTexto[i])) - (ord(wStr[wB]) + wS) Mod 128);
   result := wReturn;
  end;
end;

procedure TFmSenha.VerificaSenha(Sender: Tobject);
begin
   modalREsult := MrOk;
end;

procedure TFmSenha.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_Return then
   begin
       Perform (CM_DialogKey, VK_TAB, 0);
       key:=VK_TAB;
       if FlatButton1.Focused = true then
          FlatButton1Click(Sender);
   end;
end;

procedure TFmSenha.editKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_Return then
   begin
      if cbJustificativa.Visible = false then
        FlatButton1.SetFocus
      else
        cbJustificativa.SetFocus;
   end;
end;

procedure TFmSenha.autorizacaoSimples;
begin
   lbMsgTelaSimples.Visible := true;
   if ( UpperCase(edit.Text) = UpperCase(cbLoja.LabelDefs.Caption) ) then
   begin
      lbMsgTelaSimples.Caption := 'Ok!';
      lbMsgTelaSimples.Refresh();
      sleep(500);
      ModalResult := mrOk
   end
   else
   begin
      lbMsgTelaSimples.Caption := 'Erro!';
      lbMsgTelaSimples.Refresh();
      sleep(500);
      ModalResult := mrNo;
   end;
end;

procedure TFmSenha.autorizacaoGeral;
var
  s1,s2:String;
begin
   if verificaErros(nil) = '' then
   begin
      screen.Cursor := crHourglass;
      Conexao.Connected := true;

      s1:=  FEncryptDecrypt(trim(copy(edit.text,01,06)), 'E')  ;
      if cbUsuarios.ItemIndex > -1 then          {P_WSEN_OPE}
         s2 := trim(copy( funcsql.GetValorWell( 'O','Select SN_OPE FROM DSUSU where CD_USU = ' + trim(copy(cbUsuarios.Items[cbUsuarios.Itemindex],100,10)) ,'SN_OPE' , Conexao ), 01,06));

      if ( s1 <> '' ) and ( s2 <> '' ) then
      begin
         if( s1 = s2 ) then
         begin
           ModalREsult := MrOk;
           Conexao.Close();
         end
         else
         begin
            funcoes.MsgTela(APPLICATION.Title,'  Senha incorreta          '+#13+#13  , mb_IconError + mb_ok );
            edit.Text := '';
            edit.SetFocus;
         end;
       end
       else
       begin
          funcoes.MsgTela(APPLICATION.Title,' Escolha o usuário e informe a senha ', mb_IconError + mb_ok );
          ModalResult := MrCancel;
       end;
   end
   else
      funcoes.MsgTela(APPLICATION.Title, verificaErros(nil), mb_iconerror + mb_Ok );
   screen.Cursor := crDefault;
end;

procedure TFmSenha.FormShow(Sender: TObject);
begin
   if  (FmSenha.cbUsuarios.Visible = true) then
      FmSenha.cbUsuarios.SetFocus;
end;


function TFmSenha.verificaErros(Sender: Tobject): string;
var
  err:string;
begin
   err:= '';
   if cbUsuarios.ItemIndex < 0 then
     err := err + ' - Escolha um usuário para autorização' + #13;

   if edit.Text = '' then
     err := err + ' - Informe a Senha' + #13;

   if cbJustificativa.visible then
      if cbJustificativa.itemindex < 0 then
        err := err + ' - Informe uma justificativa' + #13;

   if err <> '' then
      err := '   Erros encontrados:          ' +#13+ ERR;
   Result := err;
end;

procedure TFmSenha.FlatButton2Click(Sender: TObject);
begin
   Conexao.Close();
   FmSenha.Close;
   ModalResult := mrAbort;
end;

procedure TFmSenha.cbLojaChange(Sender: TObject);
begin
    cbUsuarios.Items := funcsql.getUsuariosPorLoja(Conexao, trim(copy(fmSenha.cbLoja.Items[fmSenha.cbLoja.Itemindex],50,10)) );
end;

procedure TFmSenha.preparaSenhaSimples(Senha:String);
begin
   cbLoja.Visible := false;
   cbJustificativa.Visible := false;
   cbUsuarios.Visible := false;
   cbUsuarios.Items.Add('--------------');
   cbUsuarios.ItemIndex := 0;

   edit.Top := cbLoja.Top;
   cbLoja.LabelDefs.Caption := senha;

   with FlatButton2 do
   begin
      Caption := '';
      Width := 20;
      top := cbUsuarios.Top -15;
      Left := (edit.Width + edit.Left) - FlatButton2.Width;
   end;
   with FlatButton1 do
   begin
      Caption := '';
      Width := 20;
      top := FlatButton2.Top ;
      Left := FlatButton2.Left - Width - 10;
   end;
   PERFIL := 2;
   FmSenha.ClientHeight := FlatButton1.Top + FlatButton1.Height + 20;
end;

procedure TFmSenha.FlatButton1Click(Sender: TObject);
begin
   if (PERFIL = 2) then
      autorizacaoSimples()
   else
      autorizacaoGeral();
end;



procedure TFmSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Conexao.Close();
   action := CaFree;
end;

end.
