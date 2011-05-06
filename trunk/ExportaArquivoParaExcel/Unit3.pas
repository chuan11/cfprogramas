unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, adLabelEdit,funcoes, TFlatButtonUnit,
  adLabelComboBox, DB, ADODB, RpCon, RpConDS, RpBase, RpSystem, RpDefine,
  RpRave, RpRender, RpRenderPDF, fCtrls;

type
  TForm3 = class(TForm)
    edit1: TadLabelEdit;
    FlatButton1: TFlatButton;
    cb3: TadLabelComboBox;
    cb4: TadLabelComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    rvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvDsAnaliseD: TRvDataSetConnection;
    QAnalize: TADOQuery;
    RvRenderPDF1: TRvRenderPDF;
    Connection: TADOConnection;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    CheckBox3: TfsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure GerarAnalise(sender:tobject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RvSystem1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation


{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
var
  aux:string;
begin
   if (length(ParamStr(1)) = 0) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end;

   if FileExists(ExtractFilePath(ParamStr(0)) + 'AnaliseDeDistribuicao.rav') then
      rvProject1.ProjectFile := ExtractFilePath(ParamStr(0)) + 'AnaliseDeDistribuicao.rav'
   else
   begin
      funcoes.MsgTela(form3.caption, 'O arquivo '+ ExtractFilePath(ParamStr(0)) + 'AnaliseDeDistribuicao.rav '+ ' está faltando. '+#13+ 'Não posso continuar. ', mb_IconError+ MB_Ok );
      Application.Terminate();
   end;

   Connection.Connected := false;
   Connection.ConnectionString := funcoes.getDadosConexaoUDL(ExtractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini');
   Connection.Connected := true;

   dtf.DateTime := now;
   aux:= dateToStr(now-60);
   delete(aux,01,02);
   aux:= '01'+ aux;
   dti.Date := StrToDate(aux);

   if funcoes.RParReg('Estoque','estoque') <> '' then
      cb3.itemindex := StrToInt(funcoes.RParReg('Estoque','estoque'));

   if funcoes.RParReg('Estoque','ordem') <> '' then
      cb4.itemindex := StrToInt(funcoes.RParReg('Estoque','ordem'));
    form3.top := 100;
    form3.left := 300;
end;

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_return) then
      FlatButton1Click(Sender);
end;

procedure TForm3.GerarAnalise(sender: tobject);
var
  aux:string;
begin
   aux := '   Exec Z_CF_analiseDistribuicaoTotalizada @EhExecutar =''1'' ' +
          ' , @forn = ' + QuotedStr(edit1.text) +
          ' , @Ordem= ' + QuotedStr(intToStr(cb4.itemindex))+
          ' , @di= ' + funcoes.StrToSqlDate(DateToStr(dti.Date)) +
          ' , @df= ' + funcoes.StrToSqlDate(DateToStr(dtf.Date)) +
          ' , @disponivel = ' ;
   if checkBox3.Checked = true then
      aux := aux + quotedStr('1')
   else
      aux := aux +quotedStr('0');
      aux := aux+
      ' , @sohComEstoque= ' + inttostr(cb3.itemIndex) +

      ' , @01=1, @03=1, @04=1, @05=1, @06=1, @07=0, @08=1, @09=1, @10=1, @11=1, @12=1, @16=016, @17=1';

      QAnalize.sql.Clear;
      QAnalize.SQL.Add(aux);
      QAnalize.SQL.SaveToFile(funcoes.TempDir() + 'qrAnalizeEstoque.tmp');
      QAnalize.Open;
      RvProject1.SetParam('di',DateToStr(dti.date));
      RvProject1.SetParam('df',DateToStr(dtf.date));

      if qAnalize.IsEmpty = false then
         RvProject1.ExecuteReport('rptAnalise')
      else
         application.MessageBox(pchar(' Nenhum item atende aos critérios da seleção.'+ #13 + ' Lembre-se que o campo estoque é referente ao estoque do CD. '),pchar(form3.caption), mb_iconerror+mb_Ok)
end;

procedure TForm3.FlatButton1Click(Sender: TObject);
begin

   screen.cursor := crHourglass;
   if dtf.DateTime < dti.DateTime then
        application.MessageBox(pchar('A data final está menor que a inicial'),pchar(form3.caption), mb_iconerror+mb_Ok)
   else
   if (length(edit1.Text) >= 3) then
      GerarAnalise(sender);
   edit1.SetFocus;
   screen.cursor := crdefault;


end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   connection.Close;
   funcoes.WParReg('Estoque','estoque', inttoStr(cb3.ItemIndex));
   funcoes.WParReg('Estoque','ordem', inttoStr(cb4.ItemIndex));
end;

procedure TForm3.RvSystem1BeforePrint(Sender: TObject);
begin
   rvsystem1.OutputFileName :=  rvsystem1.OutputFileName +  '.pdf';
end;

end.
