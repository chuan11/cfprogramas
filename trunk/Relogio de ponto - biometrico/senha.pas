unit senha;

interface

uses Windows, SysUtils, Classes,{ Graphics,} Forms,{ Controls, StdCtrls,}
     Buttons,{ Messages,} dialogs, StdCtrls, Controls { Controls;};

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit3: TEdit;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AjusteparaAlterar(sender:tobject);
    procedure AjusteparaIncluir(sender:tobject);
    procedure AlteraSenha(sender:tobject);
    Procedure IncluiSenha(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  PasswordDlg: TPasswordDlg;
  Acao:Smallint; // 01 incluir , 02 alterar, 03 exluir
implementation

uses RelogioPonto;

{$R *.DFM}

procedure TPasswordDlg.AlteraSenha(sender:tobject);
var
   achei:boolean;
   ent,sai:textfile;
   lin:string;
begin
   achei:= false;
   assignFile( ent, ARQ_SENHAS );
   reset(ent);
   assignFile( sai, 'temp.cfg');
   rewrite(sai);

   while eof( ent ) = false do
   begin
      readln(ent,lin);
      if lin  = form1.CodificaSenha(edit3.text) then
      begin
         achei := true;
         writeln( sai, form1.CodificaSenha(edit1.text) );
      end
      else
         writeln( sai, lin );
   end;
   CloseFile(ent);
   CloseFile(sai);
   deletefile( ARQ_SENHAS );
   RenameFile( 'temp.cfg',ARQ_SENHAS );

   if achei = false then
   begin
      showmessage(' A senha informada não confere.        '+ #13 + 'Tente novamente.');
      edit3.Text :='';
      edit1.Text :='';
      edit3.setfocus;
   end
   else
   begin
      application.MessageBox(pchar('A senha foi alterada com sucesso !'),TITULO,MB_OK + Mb_ICONEXCLAMATION);
      passworddlg.close;
   end;
end;


procedure TPasswordDlg.BitBtn2Click(Sender: TObject);
begin
   passwordDlg.close;
end;

procedure TPasswordDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   form1.timer2.enabled := true;
   action := cafree;
end;


procedure TPasswordDlg.AjusteparaAlterar(sender:tobject);
begin
    acao := 2;
    label3.caption:='Senha atual';
    label1.caption:='Digite a nova senha:';
    bitbtn1.visible := true;
    bitbtn2.visible := true;
end;


procedure TPasswordDlg.AjusteparaIncluir(sender:tobject);
begin
    acao := 1;
    label3.caption:='Senha supervisor';
    label1.caption:='Digite a nova senha:';
    bitbtn2.visible := true;
    bitbtn1.Caption:='Incluir';

end;

Procedure  TPasswordDlg.IncluiSenha(Sender: TObject);
var
   arq:textfile;
begin
   assignFile( arq, ARQ_SENHAS );
   append(arq);

   if edit3.text = SENHA_MESTRA then
   begin
      writeln( arq, form1.CodificaSenha(edit1.text) );
      application.MessageBox(pchar('  Senha incluida com exito!      '),TITULO, mb_ok+MB_ICONEXCLAMATION);
      passwordDlg.close;
   end
   else
      application.MessageBox(pchar(' Senha inválida!!        '+ #13 + 'Tente novamente.'),TITULO,mb_ok+ MB_ICONERROR);
   CloseFile( arq);
end;

procedure TPasswordDlg.BitBtn1Click(Sender: TObject);
var
   erro:string;
begin
   erro:= 'Falta preencher um dos campos        ' + #13 ;
   if edit3.text = '' then
      erro := erro + ' - Senha atual ' + #13 ;

   if edit1.text = '' then
      erro := erro + ' - Nova  senha ' ;

   if erro  <> ('Falta preencher um dos campos        ' + #13) then
      application.MessageBox(pchar(erro),TITULO,MB_OK + MB_ICONERROR)
   else
      case acao of
         2:AlteraSenha(sender);
         1:IncluiSenha(Sender);
      end;
end;


end.

