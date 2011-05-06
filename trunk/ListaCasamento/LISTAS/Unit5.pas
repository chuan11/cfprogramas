unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Db, DBTables, Grids, DBGrids, Buttons, ExtCtrls,
  ComboBoxColor, MEditColor, Edit1ColorFocus, ADODB;

type
  TForm5 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Edit1: TEdit1ColorFocus;
    maskedit1: tMeditColor;
    Cbox1: TComboBoxColor;
    ADOConnection1: TADOConnection;
    Query1: TADOQuery;
    procedure consultaItem(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MaskEdit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses unit2, Unit1;

{$R *.DFM}
procedure Tform5.consultaItem(Sender: TObject);
begin
  with query1 do
  begin
     sql.Clear;
     sql.add(' select codigo, nome from recurso where codigo = '  + #39+maskedit1.text+#39);
   end;
   query1.open;

   if (dbgrid1.fields[0].AsString <> '') then
   begin
      label3.caption := dbgrid1.fields[0].AsString;
      edit1.text := dbgrid1.fields[1].AsString;
      bitbtn1.setfocus;
   end
   else
   begin
      form1.msgderodape('O código ' + MaskEdit1.text +' não é Cadastrado !!!!!');
      messagebeep(MB_ICONASTERISK);
      edit1.text := '';
      maskedit1.text := '';      
      maskedit1.setfocus;
   end;
end;


procedure TForm5.FormActivate(Sender: TObject);
begin
   Form5.left := form1.left +20;
   Form5.top  := form1.top +10;
   edit1.setfocus;
end;


procedure TForm5.BitBtn1Click(Sender: TObject);
var
   erro:string;
begin
   if (edit1.text <> '') and ( cbox1.itemindex > -1 ) then
   begin
      if label3.caption <> '' then
         produtosnalista.IncluirItens(Sender, label3.caption, edit1.text, copy(cbox1.items[cbox1.itemindex],01,02) )
      else
         produtosnalista.IncluirItens(Sender, '0000000', edit1.text,copy(cbox1.items[cbox1.itemindex],01,02) );
      maskedit1.text := '';
      edit1.text := '';
      label3.caption := '';
   end
   else
   begin
      erro := 'Preencha o(s) seguinte(s) campo(s):     ' + #13;
      if edit1.text = '' then erro := erro + '   -Falta a descricao do produto.' + #13;
      if cbox1.itemindex = -1 then erro := erro + '   -Falta o tipo do produto.' ;
      application.messagebox(pchar(erro), pchar(form1.caption), mb_Ok + MB_iconerror);
   end;
   maskedit1.setfocus;
end;


procedure TForm5.BitBtn2Click(Sender: TObject);
begin
   if maskedit1.text = '       ' then
   begin
      form5.close;
      ProdutosNaLista.Popup1.AutoPopup := true;
   end;
end;


procedure TForm5.Timer1Timer(Sender: TObject);
begin
  if (length(maskedit1.text) = 7 )and (pos(' ',maskedit1.Text) = 0 )then
  begin
     consultaItem(Sender);
     maskedit1.text := '';
  end;
end;


procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ProdutosNaLista.bitbtn3.enabled := true;
   Form5 := nil;
   action := cafree;
end;


procedure TForm5.MaskEdit1Exit(Sender: TObject);
begin
  if (length(maskedit1.text) = 7 )and (pos(' ',maskedit1.Text) = 0 )then
  begin
     consultaItem(Sender);
     maskedit1.text := '';
  end;
end;

end.
