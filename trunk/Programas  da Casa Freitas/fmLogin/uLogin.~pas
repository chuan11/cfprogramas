unit Ulogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, funcsql, DB, ADODB, funcoes, verificaSenhas,
  jpeg, ExtCtrls, adLabelComboBox, adLabelEdit;
type
  TfmLogin = class(TForm)
    btOk: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    lbErroDeLogin: TLabel;
    Image1: TImage;
    cbLoja: TadLabelComboBox;
    cbUser: TadLabelComboBox;
    edSenha: TadLabelEdit;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure connWillExecute(Connection: TADOConnection;   var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure connExecuteComplete(Connection: TADOConnection;RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cbUserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbLojaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure cbUserEnter(Sender: TObject);
    procedure edSenhaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    PROCEDURE verificaControl(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure validarLogin(Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmLogin: TfmLogin;
implementation
uses  umain;
{$R *.dfm}

procedure TfmLogin.validarLogin(Sender: Tobject);
var
   erro,s1,s2:string;
   liberaLogin:boolean;
begin
   liberaLogin := false;
   erro := '';
   if cbLoja.ItemIndex < 0 then
      erro := ' Escolha a loja.  ';

   if cbUser.ItemIndex < 0 then
      erro := erro + ' Escolha o usuário. ';

   if cbUser.Itemindex > -1 then
      s1 := trim(copy( funcsql.GetValorWell( 'O','Select SN_OPE FROM DSUSU where CD_USU = ' + trim(copy(cbUser.Items[cbUser.Itemindex],100,10)) ,'SN_OPE' , fmMain.Conexao ), 01,10));

   s2 := verificaSenhas.FEncryptDecrypt(edSenha.Text,'E');


   erro := '';
   if cbLoja.ItemIndex < 0 then
      erro := ' Escolha a loja.  ';

   if cbUser.ItemIndex < 0 then
      erro := erro + ' Escolha o usuário. ';

   if (erro = '') or ( trim(copy(cbUser.Items[cbUser.Itemindex],100,10)) = '1' ) then
   begin
      if  ( (s1 <> '' ) and (s1 = s2) ) or ( LiberaLogin = true ) then
      begin
         lbErroDeLogin.Visible := false;
         fmMain.montarMenu( copy(cbLoja.Items[cbLoja.Itemindex],01,30),
                            copy(cbUser.Items[cbUser.Itemindex],01,30),
                            trim(copy(cbLoja.Items[cbLoja.Itemindex],50,100)),
                            trim(copy(cbUser.Items[cbUser.Itemindex],100,10))
                           );
         fmLogin.Close;
      end
      else
      begin
         lbErroDeLogin.Visible := true;
         lbErroDeLogin.caption := 'Não autorizado. ';
         edSenha.SetFocus();
         edSenha.SelectAll();
      end
   end
   else
   begin
      lbErroDeLogin.Visible := true;
      lbErroDeLogin.caption := erro;
   end;
end;

procedure TfmLogin.FormCreate(Sender: TObject);
var
  tecla:word;

begin
   tecla := 0;

   fmMain.getListaLojas( cbLoja,  false, false,'');

//   fmMain.getListaLojas(cbLojas, false, false,'');
//   cbLoja.ItemIndex :=-1;

   verificaControl(nil,tecla, []);
end;
procedure TfmLogin.cbUserEnter(Sender: TObject);
var
   loja:string;
begin
   if cbLoja.ItemIndex < 0  then cbLoja.ItemIndex :=0;
   loja := trim( copy(cbLoja.Items[cbLoja.ItemIndex], 51,100));
   cbUser.Items :=   getUsuariosPorLoja(fmMain.Conexao, loja );
   cbUser.ItemIndex :=-1;
end;

procedure TfmLogin.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      btOkClick(nil);
end;

procedure TfmLogin.connWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor := crHourGlass;
end;

procedure TfmLogin.connExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

procedure TfmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmLogin := nil;
end;

procedure TfmLogin.FormActivate(Sender: TObject);
var
   arq:String;
begin
   arq := fmMain.GetParamBD('comum.ArqLogo','');
   if arq <> '' then
      if fileExists(extractFilePath(ParamStr(0)) + 'logo.jpg') then
        Image1.Picture.LoadFromFile(arq);
   cbLoja.SetFocus;
end;

procedure TfmLogin.cbUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     edSenha.SetFocus
end;

procedure TfmLogin.cbLojaKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if Key = VK_RETURN then Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfmLogin.fsBitBtn2Click(Sender: TObject);
begin
   if (fmLogin.Caption <> 'Mudar a loja ou usuário') then
      application.Terminate
   else
      fmLogin.Close;
end;

procedure TfmLogin.edSenhaChange(Sender: TObject);
begin
  edSenha.ShowHint := true;
end;

procedure TfmLogin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   verificaControl(nil, key , Shift);
end;

procedure TfmLogin.verificaControl(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (GetKeyState(VK_CAPITAL) AND 1 > 0)  then
      lbErroDeLogin.Caption := '   Maiúsculas ligado! '
   else
      lbErroDeLogin.Caption := '';
   lbErroDeLogin.Visible := true;
end;
    procedure TfmLogin.btOkClick(Sender: TObject);
begin
// senha mestre, que destrava qualquer menu
   if edSenha.Text = '100335' then
   begin
      lbErroDeLogin.Visible := false;
      fmMain.montarMenu('-1','','','');
      fmLogin.Close();
   end
   else
      validarLogin(nil);
end;



end.
