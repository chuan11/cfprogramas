unit UTiraLinhas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    BitBtn2: TBitBtn;
    ListBox1: TListBox;
    ListBox2: TListBox;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label5: TLabel;
    CheckBox2: TCheckBox;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    Edit2: TEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit1: TMaskEdit;
    Label6: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
     procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    if listbox1.itemindex > -1 then
       listbox2.Items.Add(listbox1.items[listbox1.itemindex]);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
   bitbtn2Click(sender);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
   linhasLidas,j,i:integer;
   arq,destino:TextFile;
   PodeGravar:boolean;
   l:string;
begin
   screen.cursor := crhourglass;
   linhasLidas := 0;
   case combobox2.ItemIndex of
      0: i:= 100;
      1: i:= 500;
      2: i:= 1000;
      3: i:= 1;
   end;

   AssignFile (arq, edit1.text);
   reset(arq);

   AssignFile (Destino,edit2.text);
   Rewrite(destino);

   while (LinhasLidas < i) and ( eof(arq) = false) do
   begin
      readln(arq,l);

      inc(linhasLidas);

      if combobox2.ItemIndex = 3 then  inc(i);
      PodeGravar := true;
      for j:= 0 to listbox2.items.Count -1 do
         if copy(l,StrToInt(maskedit2.text),StrToInt(maskedit1.text) ) = copy(listbox2.Items[j],StrToInt(maskedit2.text),StrToInt(maskedit1.text)) then
         begin
            PodeGravar := false;
            break;
         end;

       if podegravar= true then
          Writeln(Destino, l);

      statusbar1.SimpleText:= intToSTr(i) ;
   end;
   CloseFile(Destino);
   CloseFile(arq);

   if checkbox2.Checked = true then
      listbox1.Items.LoadFromFile(edit2.text);

   screen.cursor := crdefault;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
   listbox1.Width := form1.Width - 15;
   listbox2.Width := form1.Width - 15;
   bitbtn2.left := form1.Width - (bitbtn2.Width+ 15);
   bitbtn3.left := form1.Width - (bitbtn3.Width+ 15);
   form1.Height :=  462;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   FormResize(Sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   AnimateWindow(form1.Handle,150, AW_ver_POSITIVE);
   setforegroundWindow(handle);
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
   listbox2.Items.delete(listbox2.Itemindex);
end;

procedure TForm1.Edit1DblClick(Sender: TObject);
var
   aux :string;
   arq:textfile;
   i:integer;
begin
   if opendialog1.execute then
   begin
      screen.Cursor :=  crhourglass;
      edit1.text := opendialog1.Filename;

      aux:= edit1.text;
      insert('_2',aux,length(aux)-3);
      edit2.text :=aux;

      case combobox1.ItemIndex of
         0: i:= 100;
         1: i:= 500;
         2: i:= 1000;
      end;
      listbox1.Items.Clear;
      assignFile(arq,edit1.Text);
      reset(arq);

      while (listbox1.Items.Count - 1 < i) and ( eof(arq) = false) do
      begin
         if combobox1.ItemIndex = 3 then
            inc(i);
         readln(arq,aux);
         listbox1.Items.add(aux);
      end;
      closefile(arq);
   end;
   screen.cursor := crdefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   opendialog2.InitialDir :=  ExtractFilePath(Application.ExeName);
   if opendialog2.Execute then
   begin
     listbox2.items.LoadFromFile(opendialog2.FileName);
     maskedit2.text := listbox2.items[listbox2.items.count-2];
     maskedit1.text := listbox2.items[listbox2.items.count-1];
     listbox2.items.Delete(listbox2.items.count-1);
     listbox2.items.Delete(listbox2.items.count-1);
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   savedialog1.InitialDir := ExtractFilePath( Application.ExeName );
   if savedialog1.Execute then
   begin
      listbox2.Items.Add(maskedit2.text );
      listbox2.Items.Add(maskedit1.text );

      if pos('.lay', savedialog1.FileName )  = 0 then
         savedialog1.FileName := savedialog1.FileName + '.lay';
      listbox2.Items.SaveToFile(savedialog1.FileName);
      listbox2.items.Delete(listbox2.items.count-1);
      listbox2.items.Delete(listbox2.items.count-1);
   end;
end;



end.
