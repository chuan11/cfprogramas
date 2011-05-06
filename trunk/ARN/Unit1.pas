unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, DB, DBTables, Grids, DBGrids, ComCtrls, Menus,
  ToolWin, AppEvnts, StdCtrls, Mask, adLabelDBEdit, Buttons,funcoes,
  adLabelMaskEdit,   adLabelDBLookupComboBox,
  FileCtrl, ADODB, adLabelDBDateTimePicker,REGISTRY ;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    Relatorios1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    DBEdit2: TadLabelDBEdit;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    DBEdit3: TadLabelDBEdit;
    MaskEdit1: TadLabelMaskEdit;
    dbedit1: TadLabelDBEdit;
    DBEdit4: TadLabelDBEdit;
    DBEdit5: TadLabelDBEdit;
    DBEdit6: TadLabelDBEdit;
    LookupCB1: TadLabelDBLookupComboBox;
    Agendadores1: TMenuItem;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    ADOTable2: TADOTable;
    dtchegada: TadLabelDBDateTimePicker;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure DBEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    Procedure HabilitaEdits;
    Procedure DesabilitaEdits;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DesHabilitaBTnOperacoes(Sender: TObject);
    procedure HabilitaBTnOperacoes(Sender: TObject);
    procedure Relatorios1Click(Sender: TObject);
    function  ErroNoPreeenchimento:String;
    procedure Agendadores1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
    procedure FormActivate(Sender: TObject);
  private
  procedure ProcessaMsg(var Msg: TMsg; var Handled: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;
Const
    TITULO = 'Agenda de recebimentos R03 - Conexão Via Access';
    PATH = 'C:\AgendaRecebimento\';
var
  Form1: TForm1;

implementation
uses unit2,unit3;

{$R *.dfm}

procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
   funcoes.GravaLinhaEmUmArquivo('ErrosPrograma.txt', funcoes.GetNomeDoMicro() + '  Message:'+ e.Message );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Application.OnMessage := ProcessaMsg;
   ADOconnection1.Connected := false;
   ADOConnection1.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   ADOconnection1.Connected := true;
   ADOTable1.Active := true;
   ADOTable2.Active := true;   
   form1.Left := screen.DesktopWidth-form1.Width-20;
   form1.Top:=-2;
   form1.caption := TITULO;
   dtchegada.MinDate := now - 10;
   FORM1.LerColunasDbgrid('form1',DBGRID1)
end;


procedure TForm1.DBEdit1Change(Sender: TObject);
begin
   if dbedit1.Text <> '' then
      maskedit1.text := dbedit1.text;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
   adotable1.Edit;
   HabilitaEdits;
   form1.desHabilitaBTnOperacoes(sender);
   form1.Caption := TITULO + '  - ALTERAR'
end;

Procedure TForm1.HabilitaEdits;
var
   i : Integer;
begin
   for i := 0 to ComponentCount -1 do
   begin
      if (Components[i] is TdbEdit) then
         TdbEdit(Components[i]).enabled:= true;
      if (Components[i] is TMaskEdit) then
      begin
        TMaskEdit(Components[i]).enabled:= true;
      end;
      if (Components[i] is TDBLookupComboBox) then
      begin
         TDBLookupComboBox(Components[i]).enabled:= true;
      end;
      dtchegada.Enabled:= true;
      dtchegada.Date := now;
   end;

   dbgrid1.Enabled := false;
end;

Procedure TForm1.DesabilitaEdits;
var
   i : Integer;
begin
   for i := 0 to ComponentCount -1 do
   begin
      if (Components[i] is TdbEdit) then
      begin
         TdbEdit(Components[i]).enabled:= false;
         TdbEdit(Components[i]).text:='';
      end;
      if (Components[i] is TMaskEdit) then
      begin
        TMaskEdit(Components[i]).text:= '';
        TMaskEdit(Components[i]).enabled:= false;
      end;

      if (Components[i] is TDBLookupComboBox) then
      begin
         TDBLookupComboBox(Components[i]).enabled:= false;
         TDBLookupComboBox(Components[i]).refresh;
      end;
   end;
   dtchegada.Enabled:= false;
   dbgrid1.Enabled := true;
end;


procedure TForm1.MaskEdit1Change(Sender: TObject);
begin
   dbedit1.text := maskedit1.text;
end;

function tform1.ErroNoPreeenchimento:String;
var
  erro:string;
begin
   erro:='';
   if  funcoes.EhDataValida(maskedit1.text) = false then
      erro:= erro + ' - Data de lançamento é inválida' +#13;;
   if dbedit3.Text = '' then
      erro:= erro + ' - Preencha o nome do fornecedor'  +#13;
   if dbedit4.Text = '' then
      erro:= erro + ' - Preencha o numero da nota'  +#13;
   if erro <> '' then
     erro := ' Corrija antes estes erros antes de confirmar...        '   +#13+ erro;
   if  dtchegada.Date < strtoDate(maskedit1.text) then
      erro:= erro + ' - Data da previsão de chegada anterior a de agendamento.' +#13;
   ErroNoPreeenchimento := erro;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
   if ErroNoPreeenchimento <> '' then
      application.MessageBox(pchar(ErroNoPreeenchimento),pchar(TITULO),mb_Ok + MB_iconquestion)
   else
   begin
      adotable1.Post;
      DesabilitaEdits;
      HabilitaBTnOperacoes(sender);
   end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  adotable1.Cancel;
  form1.DesabilitaEdits;
  form1.HabilitaBTnOperacoes(sender);
  form1.Caption := TITULO
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
   if application.MessageBox('Deseja realmente escluir esse registro???',pchar(TITULO),mb_YesNo + MB_iconquestion) = mryes then
      adotable1.Delete;
end;

procedure TForm1.DesHabilitaBTnOperacoes(Sender: TObject);
begin
   bitbtn2.visible:= false;
   bitbtn3.visible:= false;
   bitbtn4.visible:= false;
   bitbtn1.visible:= true;
   bitbtn5.visible:= true;
   maskedit1.setfocus;
end;


procedure TForm1.HabilitaBTnOperacoes(Sender: TObject);
begin
   bitbtn2.visible:= true;
   bitbtn3.visible:= true;
   bitbtn4.visible:= true;
   bitbtn1.visible:= false;
   bitbtn5.visible:= false;
   bitbtn2.setfocus;
end;

procedure TForm1.Relatorios1Click(Sender: TObject);
begin
   Application.CreateForm(TForm2, Form2);
   form2.Show
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   adotable1.Append;
   HabilitaEdits;
   maskedit1.text:='';
   maskedit1.SetFocus;
   maskedit1.Text := DateToStr(now);

   adotable1.FieldByName('PREVCHEGADA').AsDatetime := dtchegada.Date;



   form1.DesHabilitaBTnOperacoes(sender);
   form1.Caption := TITULO + '  - INCLUIR'
end;
procedure TForm1.ProcessaMsg(var Msg: TMsg; var Handled: Boolean);
begin
if Msg.message = WM_KEYDOWN then
    if not (Screen.ActiveControl is TCustomMemo) and not (Screen.ActiveControl is TButtonControl) then
    begin
      if not (Screen.ActiveControl is TCustomControl) then
      begin
        if Msg.wParam = VK_Down then    Msg.wParam := VK_Tab;
        if Msg.wParam = VK_UP then
        begin
          Msg.wParam := VK_CLEAR;
          Screen.ActiveForm.Perform(WM_NextDlgCtl,1,0);
        end;
      end;
      if Msg.wParam = VK_Return then Msg.wParam := VK_Tab;
    end;
end;

procedure TForm1.Agendadores1Click(Sender: TObject);
begin
  Application.CreateForm(TForm3, Form3);
  form3.show;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   If odd(adoTable1.RecNo) then
   begin
     DBGrid1.Canvas.Font.Color:= clblack;
     DBGrid1.Canvas.Brush.Color:=$00E1FFFF;
   end
   else
   begin
      DBGrid1.Canvas.Font.Color:= clblack;
      DBGrid1.Canvas.Brush.Color:= clwhite;;
   end;
   DBGrid1.Canvas.FillRect(Rect);
   DBGrid1.Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);

end;

procedure TForm1.SalvaColDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount-1 do
    funcoes.WParReg('ARN','Z_' +NomeForm+ '_'+ IntToStr(i) , IntToStr(dbgrid.Columns[i].Width) );
end;

procedure Tform1.LerColunasDbgrid(NomeForm:string;Dbgrid:tdbgrid);
var
  i:integer;
begin
   for i:=0 to dbgrid.FieldCount -1 do
   begin
      dbgrid.Columns[i].Title.Font.name := 'MS Sans Serif';
      dbgrid.Columns[i].Title.Font.Style := [fsbold];
      if funcoes.RParReg('ARN','Z_' +NomeForm+ '_'+ IntToStr(i) ) <> '' then
         dbgrid.Columns[i].width := StrToint( funcoes.RParReg('ARN','Z_' +NomeForm+ '_'+ IntToStr(i))  );
   end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form1.SalvaColDbgrid('form1',DBGRID1);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

   ADOConnection1.Open;

end;

end.
