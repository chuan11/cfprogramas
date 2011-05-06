unit unConflistas;

interface

uses
  Windows, Classes, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, adLabelEdit,funcoes,
  ExtCtrls, ComCtrls, Controls;

type
  TForm8 = class(TForm)
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel2: TBevel;
    Edit1: TadLabelEdit;
    Edit2: TadLabelEdit;
    Edit3: TadLabelEdit;
    edit4: TadLabelEdit;
    CB2: TadLabelComboBox;
    CB3: TadLabelComboBox;
    EDIT8: TadLabelEdit;
    TabSheet3: TTabSheet;
    Bevel3: TBevel;
    edit12: TadLabelEdit;
    Bevel4: TBevel;
    edit9: TadLabelEdit;
    edit11: TadLabelEdit;
    Bevel1: TBevel;
    edit5: TadLabelEdit;
    Edit6: TadLabelEdit;
    edit7: TadLabelEdit;
    edit13: TadLabelEdit;
    edit15: TadLabelEdit;
    edit16: TadLabelEdit;
    Edit10: TadLabelEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit14: TadLabelEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    edit17: TadLabelEdit;
    edit18: TadLabelEdit;
    edit19: TadLabelEdit;
    procedure FormActivate(Sender: TObject);
    procedure EDIT8DblClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure GravaValores(sender:Tobject);
    procedure FlatButton2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure AjustaEdit(sender:tobject;edit:TadLabelEdit);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;
  
implementation

{$R *.dfm}

procedure TForm8.FormActivate(Sender: TObject);
begin
   edit1.text:= funcoes.RParReg('listas','Loja');
   edit2.text:= funcoes.RParReg('listas','PortaImp');
   edit3.text:= funcoes.RParReg('listas','Versao');
   edit4.text:= funcoes.RParReg('listas','TitRel');
   edit5.text:= funcoes.RParReg('listas','HostFTP');
   edit6.text:= funcoes.RParReg('listas','User');
   edit7.text:= funcoes.RParReg('listas','Password');
   if edit7.text = '' then
      checkbox3.Checked := true;

   edit8.text:= funcoes.RParReg('listas','ArqLogo');

   if funcoes.RParReg('listas','MostraErros')= 'S' then
      cb2.itemindex := 0
   else
      cb2.itemindex := 1;

   if funcoes.RParReg('listas','TipoImp')= 'M' then
      cb3.itemindex := 0
   else
      cb3.itemindex := 1;

   edit9.text:= funcoes.RParReg('listas','IPServer');
   edit10.text := funcoes.RParReg('listas','DBName');
   edit11.text := funcoes.RParReg('listas','DBUserName');
   edit12.text := funcoes.RParReg('listas','DBPassWord');
   if edit12.text = '' then
      checkbox1.Checked := true;

   edit13.text := funcoes.RParReg('listas','IpServerWell');
   edit14.text := funcoes.RParReg('listas','DBNameWell');
   edit15.text := funcoes.RParReg('listas','UserNameWell');
   edit16.text := funcoes.RParReg('listas','PassWordWell');

   edit17.text := funcoes.RParReg('listas','UoPreco');
   edit18.text := funcoes.RParReg('listas','CodPreco');
   edit19.text := funcoes.RParReg('listas','CodEmpWell');

   if edit16.text = '' then
      checkbox2.Checked := true;

   pageControl1.ActivePageIndex := 0;
   flatbutton1.Enabled := false;
end;

procedure TForm8.EDIT8DblClick(Sender: TObject);
begin
   EDIT8.TEXT := FUNCOES.DialogAbrArq('Arquivos BMP|*.bmp','c:\');
end;

procedure TForm8.FlatButton1Click(Sender: TObject);
var
   erro:string;
begin
   if edit1.text = '' then
      erro := erro + ' - Informe o ' + edit1.LabelDefs.Caption + #13;
   if edit2.Text = '' then
      erro := erro + ' - Informe a ' + edit2.LabelDefs.Caption + #13;
   if edit4.Text = '' then
      erro := erro + ' - Informe a ' + edit4.LabelDefs.Caption + #13;
   if edit8.Text = '' then
      application.MessageBox(pchar('Atenção ! Se não for informado o ' + edit8.LabelDefs.Caption + ',  a impressão não terá o logo da loja. '), pchar( form8.Caption), mb_iconWarning + mb_Ok);
   if edit5.Text = '' then
      erro := erro + ' - Informe o ' + edit5.LabelDefs.Caption + #13;
   if edit6.Text = '' then
      erro := erro + ' - Informe o ' + edit6.LabelDefs.Caption + #13;

   if checkBox3.Checked = false then
      if edit7.Text = '' then
         erro := erro + ' - Informe o ' + edit6.LabelDefs.Caption + #13;

   if edit9.Text = '' then
      erro := erro + ' -  ' + label2.caption +' - '+ edit9.LabelDefs.Caption + #13;
   if edit10.Text = '' then
      erro := erro + ' -  ' + label2.caption +' - '+ edit10.LabelDefs.Caption + #13;
   if edit11.Text = '' then
      erro := erro + ' -  ' + label2.caption +' - '+ edit11.LabelDefs.Caption + #13;
   if checkBox1.Checked = false then
      if edit12.Text = '' then
         erro := erro + ' -  ' + label2.caption +' - '+ edit12.LabelDefs.Caption + #13;

   if ( edit13.Text <> '') then
      if ( edit14.Text = '') or (edit15.Text = '' ) or (edit16.Text = '') or(edit17.Text = '')  or (edit18.Text = '')  or(edit19.Text = '')   then
      begin
         application.MessageBox(pchar('Atenção ! Se os campos de conexão ao BD Well não forem preenchidos, '+#13+'não posso consultar os itens no BD do Well'), pchar( form8.Caption), mb_iconWarning + mb_Ok);
         edit13.Text := '' ;
      end;

   if erro <> '' then
   begin
      erro := 'Informe antes esses campos              ' +#13+ erro;
      application.MessageBox( pchar(erro), pchar(form8.Caption), mb_Ok + mb_iconerror );
   end
   else
   begin
      GravaValores(sender);
      application.MessageBox( pchar('Configuração gravada com sucesso.'), pchar(form8.Caption), mb_Ok + mb_iconExclamation);
      application.terminate;
   end;
end;


procedure tform8.GravaValores(sender:Tobject);
begin
   funcoes.WParReg('listas','Loja',edit1.text);
   funcoes.WParReg('listas','PortaImp',edit2.text);
   funcoes.WParReg('listas','ArqLogo',edit8.text);
   funcoes.WParReg('listas','TitRel',edit4.text);
   if cb2.ItemIndex = 0 then
      funcoes.WParReg('listas','MostraErros','S')
   else
      funcoes.WParReg('listas','MostraErros','N');
   funcoes.WParReg('listas','HostFTP',edit5.text);
   funcoes.WParReg('listas','User',edit6.text);
   funcoes.WParReg('listas','Password',edit7.text);


   case cb3.ItemIndex of
      0:funcoes.WParReg('listas','TipoImp','M');
      1:funcoes.WParReg('listas','TipoImp','D');
      2:funcoes.WParReg('listas','TipoImp','I');
   end;
   {
   if cb3.ItemIndex = 0 then
      funcoes.WParReg('listas','TipoImp','M')
   else
      funcoes.WParReg('listas','TipoImp','D');
    }
   funcoes.WParReg('listas','IPServer',edit9.text);
   funcoes.WParReg('listas','DBName',edit10.text);
   funcoes.WParReg('listas','DBUserName',edit11.text);
   funcoes.WParReg('listas','DBPassWord',edit12.text);

   funcoes.WParReg('listas','IpServerWell',edit13.text);
   funcoes.WParReg('listas','DBNameWell',edit14.text);
   funcoes.WParReg('listas','UserNameWell',edit15.text);
   funcoes.WParReg('listas','PassWordWell',edit16.text);

   funcoes.WParReg('listas','UoPreco',edit17.text);
   funcoes.WParReg('listas','CodPreco',edit18.text);
   funcoes.WParReg('listas','CodEmpWell',edit19.text);
end;

procedure TForm8.FlatButton2Click(Sender: TObject);
begin
   if flatbutton1.Enabled = true then
   begin
      if application.MessageBox( pchar('Deseja abandonar as alterações?' ), pchar(form8.Caption), mb_YesNo + mb_iconQuestion) = MrYes then
         application.terminate;
   end
   else
      application.terminate;
end;

procedure TForm8.Edit1Change(Sender: TObject);
begin
  flatbutton1.Enabled := true;
end;

procedure TForm8.CheckBox1Click(Sender: TObject);
begin
   AjustaEdit(sender,edit12);
end;

procedure TForm8.AjustaEdit(sender: tobject; edit: TadLabelEdit);
begin
   edit.Enabled := not(edit.Enabled);
   edit.Text:='';
   if edit.Enabled= true then
      edit.setfocus;
   Flatbutton1.Enabled := true;
end;

procedure TForm8.CheckBox2Click(Sender: TObject);
begin
   AjustaEdit(sender,edit16);
end;

procedure TForm8.CheckBox3Click(Sender: TObject);
begin
   AjustaEdit(sender,edit7);
end;

end.
