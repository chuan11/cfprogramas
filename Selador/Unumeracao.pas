unit Unumeracao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Buttons;

type
  TFnumeracao = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit5: TEdit;
    cbox1: TComboBox;
    lb1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure habilitaParaNF1(sender:TObject);
    procedure HabilitaParaNFCV(sender:tobject);
    procedure HabilitaParaFormularios(sender:tobject);
    procedure DesabilitarEdits(sender:TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IncluirNF1(sender:TObject);
    procedure Button1Click(Sender: TObject);
    procedure incluirFormularios(sender:TObject);
    procedure IncluirNFCV(sender:TObject);
    procedure lb1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure cbox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fnumeracao: TFnumeracao;
  Devesalvar : boolean;
implementation

uses Uselador;

{$R *.DFM}
procedure TFnumeracao.DesabilitarEdits(sender:TObject);
begin
   edit1.enabled := false;
   edit2.enabled := false;
   edit3.enabled := false;
   edit4.enabled := false;
   edit5.enabled := false;
   edit6.enabled := false;
   label1.enabled:= false;
   label2.enabled:= false;
   label3.enabled:= false;
   label4.enabled:= false;
   label5.enabled:= false;
   label6.enabled:= false;
   cbox1.setfocus;
   edit1.text:='';
   edit2.text:='';
   edit3.text:='';
   edit4.text:='';
   edit5.text:='';
   edit6.text:='';
end;


procedure TFnumeracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key= #13 then
      Perform (CM_DialogKey, VK_TAB, 0);

end;


procedure TFnumeracao.habilitaParaNF1(sender:TObject);
begin
   DesabilitarEdits(sender);
   edit1.enabled := true;
   edit2.enabled := true;
   edit3.enabled := true;
   edit4.enabled := true;
   edit6.enabled := true;
   label1.enabled:= true;
   label2.enabled:= true;
   label3.enabled:= true;
   label4.enabled:= true;
   label6.enabled:= true;
   edit1.setfocus;
end;


procedure TFnumeracao.HabilitaParaFormularios(sender:tobject);
begin
   DesabilitarEdits(sender);
   edit1.enabled := true;
   edit2.enabled := true;
   edit3.enabled := true;
   edit5.enabled := true;
   edit6.enabled := true;
   label1.enabled:= true;
   label2.enabled:= true;
   label3.enabled:= true;
   label5.enabled:= true;
   label6.enabled:= true;
   edit1.setfocus;
end;

procedure TFnumeracao.HabilitaParaNFCV(sender:tobject);
begin
   DesabilitarEdits(sender);
   label6.enabled := true;
   edit6.enabled := true;
   edit6.setfocus;
end;

procedure TFnumeracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     fnumeracao := nil;
end;

procedure TFnumeracao.IncluirNF1(sender:TObject);
begin
   lb1.items.add( form1.AjTamanho(' ',10,cbox1.items[cbox1.itemindex])  +
                  form1.AjTamanho(' ',10,edit1.text) +
                  form1.AjTamanho(' ',10,edit2.text) +
                  form1.AjTamanho(' ',10,edit3.text) +
                  form1.AjTamanho(' ',10,edit4.text) +
                  form1.AjTamanho(' ',10,edit5.text) +
                  form1.AjTamanho(' ',10,edit6.text)
                );
end;


procedure TFnumeracao.IncluirFormularios(sender:TObject);
begin
   lb1.items.add( form1.AjTamanho(' ',10,cbox1.items[cbox1.itemindex])  +
                  form1.AjTamanho(' ',10,edit1.text) +
                  form1.AjTamanho(' ',10,edit2.text) +
                  form1.AjTamanho(' ',10,edit3.text) +
                  form1.AjTamanho(' ',10,'0') +
                  form1.AjTamanho(' ',10,edit5.text) +
                  form1.AjTamanho(' ',10,edit6.text)
                );
end;

procedure TFnumeracao.IncluirNFCV(sender:TObject);
begin
   lb1.items.add( form1.AjTamanho(' ',10,cbox1.items[cbox1.itemindex])  +
                  form1.AjTamanho(' ',10,' ') +
                  form1.AjTamanho(' ',10,' ') +
                  form1.AjTamanho(' ',10,' ') +
                  form1.AjTamanho(' ',10,' ') +
                  form1.AjTamanho(' ',10,' ') +
                  form1.AjTamanho(' ',10,edit6.text)
                );
end;


procedure TFnumeracao.Button1Click(Sender: TObject);
var
   erro :string;
begin
     erro := ' Corrija antes estes erros:';
     if cbox1.ItemIndex =0 then
     begin
        if  (edit2.text <> '') and (edit1.text <> '') then
           if ( StrToInt(edit2.text) - StrToInt(edit1.text) ) <> ( StrToInt(edit4.text) - StrToInt(edit3.text) ) then
              erro := erro +#13+'   - A numeração está errada.';

        if (edit1.text  = '') or (edit2.text = '') then
           erro := erro +#13+'   - Preencha a numeração e o selo da nota inicial.';

        if (edit4.text  = '') or (edit3.text = '') then
           erro := erro +#13+'   - Preencha a numeração e o selo da nota final.'

     end;

     if cbox1.ItemIndex = 1 then
     begin
        if (edit1.text  = '') or (edit2.text = '') then
           erro := erro + #13+'   - Preencha a numeração e o selo da nota inicial.';

        if  edit3.text  = '' then
           erro := erro + #13+'   - Preencha a numeração da nota final.';


        if  edit5.text  = '' then
           erro := erro + #13+'   - Preencha a numeração do primeiro formulário.';

     end;

     if length(edit6.text) <> 9   then
        erro := erro + #13+'   - Preencha corretamente a numeração da AIDF';

     if erro <>  ' Corrija antes estes erros:' then
        application.messagebox(pchar(erro),pchar(form1.caption),mb_ok + mb_iconError)
     else
     begin
        case cbox1.itemindex of
           0:IncluirNF1(sender);
           1:IncluirFormularios(sender);
           2:IncluirNFCV(sender);
        end;
        fnumeracao.DesabilitarEdits(sender);
     end;

   cbox1.SetFocus;
   Devesalvar := true;
end;

procedure TFnumeracao.lb1Click(Sender: TObject);
begin
    if application.messagebox(' Deleta mesmo???',pchar(form1.caption), mb_yesno + mb_iconquestion) = mryes then
       lb1.items.delete(lb1.itemindex);
end;

procedure TFnumeracao.Button2Click(Sender: TObject);
begin
  edit1.text:='';
  edit2.text:='';
  edit3.text:='';
  edit4.text:='';
  edit5.text:='';
  edit6.text:='';
  Fnumeracao.DesabilitarEdits(sender);
end;

procedure TFnumeracao.BitBtn2Click(Sender: TObject);
var
  str:string;
begin
   form1.savedialog1.InitialDir:='c:\Sefaz-ce\_AIDFS';
   form1.savedialog1.Filter := 'Arquivos de selagem *.SNF | *.snf';
   form1.SaveDialog1.FileName :='AIDF ';
   if form1.SaveDialog1.Execute then
   begin
      Str := form1.savedialog1.filename;
      while pos('.snf',  Str) > 0 do
         delete(Str,pos('.snf', Str ),04);
      lb1.items.SaveToFile(Str + '.snf');
      Devesalvar := false;
   end;
end;

procedure TFnumeracao.BitBtn1Click(Sender: TObject);
begin
   form1.opendialog1.Filter := 'Arquivos de selagem *.SNF | *.snf';
   form1.openDialog1.InitialDir:='c:\Sefaz-ce\_AIDFS';
   if form1.openDialog1.execute then
   begin
      lb1.items.LoadFromFile(form1.openDialog1.filename);

   end;
end;

procedure TFnumeracao.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
begin
   if devesalvar = true then
   begin
      application.messageBox(' Salve antes para poder fechar',pchar(form1.caption), mb_ok + mb_iconerror);
      canclose:=false;
   end;
end;

procedure TFnumeracao.Edit1Exit(Sender: TObject);
begin
   edit2.text := edit1.text;
end;

procedure TFnumeracao.Edit3Exit(Sender: TObject);
begin
   edit4.text:= edit3.text;
end;

procedure TFnumeracao.cbox1Change(Sender: TObject);
begin
   case cbox1.itemindex of
      0:HabilitaParaNF1(sender);
      1:HabilitaParaFormularios(sender);
      2:HabilitaParaNFCV(sender);
   end;
end;

procedure TFnumeracao.FormCreate(Sender: TObject);
begin
lb1.items.add('MODELO   |  N NICIO| S INICIO|  N FINAL|  S FINAL| F INICIO|    AIDF |');
end;



end.
