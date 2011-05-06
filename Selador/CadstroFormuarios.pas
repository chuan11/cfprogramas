unit CadstroFormuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Menus, Buttons;

type
  TForm2 = class(TForm)
    SEdit1: TSpinEdit;
    SEdit2: TSpinEdit;
    lb1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure SEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure IncluirNota(sender:tobject);
    procedure SEdit4Exit(Sender: TObject);
    procedure SEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lb1DblClick(Sender: TObject);
    procedure lb1Click(Sender: TObject);
    procedure SEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  DeveSalvar:boolean;
implementation

uses Uselador;

{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
begin
   form2.top := form1.top;
   form2.left := form1.left;
   form2.height := form1.Height;
end;


procedure Tform2.IncluirNota(sender:tobject);
var
   i:integer;
begin
   for i := 1 to StrToint(sedit2.text) do
   begin
//      lb1.Items.add( sedit1.text  +' '+ InttOsTR(StrToint(sedit3.text) -1 + i));
   end;
end;

procedure TForm2.SEdit4KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   begin
      IncluirNota(sender);

   end;
end;

procedure TForm2.SEdit4Exit(Sender: TObject);
begin
 IncluirNota(sender);
end;

procedure TForm2.SEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) or (key  = VK_insert) then
      sedit2.setfocus;
end;


procedure TForm2.SEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_RETURN then
   begin
      lb1.items.add( form1.AjTamanho('0',06,sedit1.text)  +'    '+form1.AjTamanho('0',09,sedit2.text) );
      sedit1.setfocus;
      lb1.ItemIndex := lb1.items.count-1;
      DeveSalvar := true;
   end;
end;


procedure TForm2.BitBtn2Click(Sender: TObject);
var
   Str:string;
begin
   form1.savedialog1.Filter := 'Arq selos Formulario continuo *.not | *.not';
   form1.savedialog1.InitialDir:='c:\Sefaz-ce\_Selos_de_formularios\';
   if (lb1.items.count-1 >0) and (form1.savedialog1.execute) then
   begin
      Str := form1.savedialog1.filename;
      while pos('.not',  Str) > 0 do
         delete(Str,pos('.not', Str ),04);
      lb1.items.SaveToFile(Str + '.not');
      Devesalvar := false;
   end;

end;


procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if devesalvar = true then
   begin
      if devesalvar = true then
      begin
        case application.messagebox('Essa digitação ainda não foi salva, deseja salvar agora??','selador', MB_YESNOCANCEL + MB_ICONQUESTION) of
           MRYES :BitBtn2Click(Sender);
           MRNO: CanCLose := true;
           MRCANCEL :CanCLose := false;
        end;
      end;
   end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
   form1.opendialog1.Filter := 'Arquivos de selos For cont *.not | *.not';
   form1.openDialog1.InitialDir:='c:\Sefaz-ce\_Selos_de_formularios';
   if form1.opendialog1.execute then
   begin
      lb1.items.LoadFromFile(form1.opendialog1.filename);
      lb1.itemIndex := lb1.items.count -1;
      lb1Click(Sender);
      devesalvar := false;
   end;
end;

procedure TForm2.lb1DblClick(Sender: TObject);
begin
    lb1.Items.Delete(lb1.ItemIndex);
    DeveSalvar := true;
end;

procedure TForm2.lb1Click(Sender: TObject);
begin
   sedit1.Text := copy(lb1.items[lb1.itemindex],01,06);
   sedit2.Text := copy(lb1.items[lb1.itemindex],11,09);
   sedit1.setfocus;
end;

procedure TForm2.SEdit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (KEY = vk_up) AND (strtoInt(sedit1.text) <> 0) then
   begin
      sedit2.text:= inttostr(   StrToInt(sedit2.text) + 1     );
   end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    form2:=nil;
    action := cafree;
end;

procedure TForm2.Label3Click(Sender: TObject);
var
   Shift: TShiftState;
   enter:word;
begin
   enter:= VK_RETUrN;
   SEdit2KeyDown(Sender,enter,SHift);
end;

procedure TForm2.Label5Click(Sender: TObject);
begin
   Sedit1.text :=  IntToStr( StrToInt(sedit1.text)+1   );
   Sedit2.text :=  IntToStr( StrToInt(sedit2.text)+1   );
end;

procedure TForm2.Label4Click(Sender: TObject);
begin
   Sedit2.text :=  IntToStr( StrToInt(sedit2.text)+1   );
end;




end.
