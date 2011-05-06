unit RelogioPonto;
interface
uses
  shellapi, Windows, Messages, SysUtils, Menus, Classes,  Mask,Controls, Buttons,
  ComCtrls,Forms, Dialogs, ExtCtrls, StdCtrls, DBCtrls,mxOneInstance,
  AppEvnts, adLabelMaskEdit, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, ADODB,funcoes,IdBaseComponent, DB;
type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label35: TLabel;
    Label5: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    MainMenu1: TMainMenu;
    Consultas1: TMenuItem;
    Panel2: TPanel;
    Label6: TLabel;
    Edit3: TEdit;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    Label14: TLabel;
    Justificativas1: TMenuItem;
    cb5: TComboBox;
    Timer2: TTimer;
    BackUp1: TMenuItem;
    mxOneInstance1: TmxOneInstance;
    Tarefas1: TMenuItem;
    AlterarCodigo1: TMenuItem;
    AlterarSenha1: TMenuItem;
    IncluirSenha1: TMenuItem;
    TruncarArquivoBatidas1: TMenuItem;
    Enviararquivo1: TMenuItem;
    FTP: TIdFTP;
    Query1: TADOQuery;
    ADOConnection1: TADOConnection;
    Medit1: TadLabelMaskEdit;
    ApplicationEvents1: TApplicationEvents;
    Configuraesiniciais1: TMenuItem;
    procedure CopiaParaServidor(DataInicio:String;sender:tobject);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MEdit1Enter(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Consultas1Click(Sender: TObject);
    procedure Justificativas1Click(Sender: TObject);
    procedure BackUp1Click(Sender: TObject);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure ChamaSenha(motivo:String);
    procedure CarregaParametros(sender: TObject);
    procedure DesabiliataitemsparaCopia(Sender: TObject);
    procedure HabiliataitemsparaCopia(Sender: TObject);
    procedure RegistraPonto(sender:TObject;data,hora,registro:string);
    procedure IncluirSenha1Click(Sender: TObject);
    procedure AlterarSenha1Click(Sender: TObject);
    procedure AlterarCodigo1Click(Sender: TObject);
    procedure TruncarArquivoBatidas1Click(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure ExecutarProgExterno(Prog:string);
    procedure Enviararquivo1Click(Sender: TObject);
    procedure FTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    function lerParametro(l:string):string;
    function r1(n:string):string;
    function r2(m:string):string;
    function  AjData(data:string):String;
    function  validaSenha(Sender: TObject):boolean;
    function  AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
    function  VerificaHorario( data, hora, registro:String): String;
    function  CodificaSenha(Str:String):String;
    function  GetEstab(mat:string):string;
    procedure Justificar(sender:Tobject; mat, just, data1, data2, tipo, hora1,hora2, ocorr:string);
    function  AjHora(Str:string):string;
    procedure FTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Integer);
    function MsgTela(Msg:string;iconeBotao:integer):integer;
    procedure Configuraesiniciais1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   VERSAO = '5.49';
   PATH = 'C:\_ponto\';
   ARQ_JUSTIFICATIVAS = PATH+'justificativas.cfg';
   ARQ_EMPREGADOS = PATH +'Cadastros.cfg';
   ARQ_CONF = PATH + 'relogio.ini';
   SENHA_MESTRA = 'H2SO5';
   COPIA_BATIDAS = PATH + 'BatidasAcopiar.cfg';
   ARQ_ERROS = PATH + 'ErrorLog.txt';
   HOR_EMPREGADOS = 'c:\_ponto\Cadastros.cfg' ;
   TITULO = 'Relógio de Ponto ' + VERSAO;
   ARQ_SENHAS = PATH + 'acessos.cfg';
var
  Form1: TForm1;
  Atualizacao:Boolean;
  TempRestCopia:integer;
  BytesTotal:Longint;
implementation
uses Consultas, senha, Justificativas, uCpRegistros;
{$R *.DFM}
function tform1.CodificaSenha(Str:String):String;
const
   aux = 'A0B1C2D3EF4GH5IJ6KL7MN8OP9Q0RESUVXYWZ';
var
   i:integer;
   s1,s2:string;
begin
   str:=uppercase(str);
   s2 := '';
   for i:=1 to length(Str)do
   begin
      s1 := '';
      s1:= intToSTr(pos(str[i],aux));
      if length(s1) < 2 then insert('0',s1,01);
      s2:=s2+s1;
   end;
   CodificaSenha := s2;
end;


function TForm1.lerParametro(l:string):string;
begin
   while pos('=',l) > 0 do
      delete(l,01,01);
   lerParametro := l;
end;


function tform1.r1(n:string):string;  //Funcao de inverter String;
var
   aux:string;
begin
   aux:= copy(n,7,4);          //ano
   aux:= aux + copy(n,4,2);    //mes
   aux:= aux + copy(n,1,2);    //dia
   aux:= aux + copy(n,12,2);
   aux:= aux + copy(n,15,2);
   aux:= aux + copy(n,18,2);
   aux:= aux + copy(n,21,8);
   r1:=aux;
end;

function Tform1.r2(m:string):string; // tambem para inverter string
var
   aux:string;
begin
   aux:= copy(m,7,4);
   aux:= aux + copy(m,4,2);
   aux:= aux + copy(m,1,2);
   aux:= aux + copy(m,12,2);
   aux:= aux + copy(m,15,2);
   aux:= aux + copy(m,18,2);
   aux:= aux + copy(m,21,8);
   r2:=aux;
end;


function TForm1.AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
var
  mes,ano:integer;
  data:string[6];
begin
   mes := strtoint(copy (text,01,02));
   ano := strtoint(copy (text,03,04));
   data := copy (text,01,02) + (copy (text,03,04));
   if button = btnext then
      mes := mes + 1
   else  if button = btprev then
    mes := mes - 1;
   if mes = 13 then
   begin
      mes := 01;
      inc(ano);
   end;
   if mes = 0 then
   begin
      mes := 12;
      dec(ano);
   end;
   data:= ( inttostr(mes) + inttostr(ano));
   while length(data) < 6 do insert('0',data,01);
      AjustaMesANo:=data;
end;


function Tform1.AjData(data:string):String;
begin
   ajdata := copy(data,04,02)+'/'+copy(data,01,02)+ '/' + copy(data,07,04);
end;


function Tform1.AjHora(Str:string):string;
begin

   while pos(' ',Str) > 0 do
      delete(Str, pos(' ',Str), 01);
   while pos(':',Str) > 0 do
      delete(Str, pos(':',Str), 01);
   Str := copy(Str,01,04);
   AjHora := str;
end;


function tform1.validaSenha(Sender: TObject):boolean;
var
 lin:string;
 arq:textfile;
begin
   validaSenha := false;
   assignFile(arq, ARQ_SENHAS );
   reset(arq);
   while eof(arq) = false do
   begin
      readln(arq,lin);
      if  (lin = CodificaSenha(edit3.text) ) then
         validaSenha := true;
   end;
   if( edit3.text = SENHA_MESTRA ) then
      validaSenha := true;
   CloseFile(arq);
end;


procedure tform1.DesabiliataitemsparaCopia(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 0;
   screen.cursor := crhourglass;
   timer2.enabled:= false;
   bitbtn3.enabled := false;
   MEdit1.enabled:= false;
   label2.visible:= false;
   label3.visible:= false;
   label4.visible:= false;
end;


procedure tform1.HabiliataitemsparaCopia(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 0;
   screen.cursor := crdefault;
   timer2.enabled:= true;
   bitbtn3.enabled := true;
   MEdit1.enabled:= true;
   label2.visible:= true;
   label3.visible:= true;
   label4.visible:= true;
   label1.caption:='Data:';
end;


procedure tform1.ChamaSenha(motivo:String);
begin
   if motivo = 'Senha Supervisor - Fora de hora' then
      cb5.Visible:=true
   else
      pagecontrol1.Visible := false;

   timer2.enabled:= false;
   label6.caption := motivo;
   panel2.visible:= true;
   edit3.SetFocus;
end;


procedure tform1.RegistraPonto(sender:TObject;data,hora,registro:string);
var
   arq:TextFile;
begin
   AssignFile( arq, funcoes.lerParam(ARQ_CONF,0));
   Append( arq );
   writeln( arq, data +',' +hora + ',' + registro);
   CloseFile(arq);

   AssignFile( arq, PATH + 'batdodia.cfg');
   Append( arq );
   writeln( arq , data +',' + hora + ',' + registro);
   CloseFile( arq );

   form1.panel1.visible := true;
   form1.label29.caption := data + '  as  ' + hora ;
end;


function  ExisteBatida(hora,registro:String ):boolean;
var
   arq:textfile;
   l:string;
   achou:boolean;
begin
    achou := false;
    AssignFile( arq, PATH + 'batdodia.cfg');
    Reset(arq);
    while eof(arq) = false do
    begin
       readln(arq,l);
         if copy (l,21,8) = registro then
            if (( ( StrToInt( copy(hora,01,02))  * 60 ) +  StrToInt( copy(hora,01,02)) ) - ((  StrToInt( copy(l,12,02))  * 60 ) +  ( StrToInt( copy(l,15,02)) )          ) ) < 30 then
               achou := true;
    end;
    CloseFile(arq);
    ExisteBatida := achou
end;


function tform1.VerificaHorario( data, hora, registro:String): String;
var
   arq:textfile;
   l:String;
   HoraFeita,HoraPrevista,pos:integer;
   encontrou:boolean;
begin
   verificaHorario:= 'Ok';
   pos := 0;HoraFeita:=0; HoraPrevista:=0;
   case DayOfWeek(strtodate(data)) of
      2:pos:=59;     5:pos:=71;
      3:pos:=63;     6:pos:=75;
      4:pos:=67;     7:pos:=79;
      1:pos:=83;
   end;
   encontrou := false;

   assignFile( arq, ARQ_EMPREGADOS);
   reset(arq);

   while eof(arq) = false do
   begin
      readln(arq,l);
      if copy(l,10,08) = registro then
      begin
         encontrou := true;
         form1.label14.caption := copy(l,19,40);
         form1.label28.caption := 'Cartão : '+copy(l,10,08)+ '          Matricula: '+copy(l,01,08);
         horaprevista := ( StrToint (copy(l ,pos, 02)) *60 ) + ( StrToint (copy(l, pos+2, 02)));
         HoraFeita :=   ( StrToInt( copy(hora,01,02))  * 60 ) +  StrToInt( copy(hora,04,02)) ;
      end;
   end;
   Closefile(arq);
   if encontrou = false then
      verificaHorario := 'Nao Existe'
   else
   begin
      if ( ( HoraFeita - HoraPrevista ) < 240 ) and ( ( HoraFeita - HoraPrevista ) > strToInt( funcoes.lerParam(ARQ_CONF,4) {form1.Lerparametro(Mem1.lines[4]))})   ) then
         VerificaHorario :=  'Fora de hora';
   end;
end;


procedure TForm1.BitBtn3Click(Sender: TObject);
begin
   application.terminate;
end;


procedure TForm1.carregaParametros(sender: TObject);
var
  arq:TExtfile;
  l:string;
begin
   atualizacao := false;
   TempRestCopia := StrToInt(  funcoes.lerParam(ARQ_CONF,1) ) * 120; // 120 pq i timer e de 500ms
   assignFile(arq, PATH + 'batdodia.cfg');

   if FileExists(PATH + 'batdodia.cfg') = true then
   begin
      reset(arq);
      readln(arq,l);
      if copy(l,1,10) <> DateToStr(now) then
      begin
        CloseFile(arq);
        assignFile(arq, PATH + 'batdodia.cfg');
        rewrite(arq);
        writeln(arq,datetoStr(now) + ',' + timeToStr(now) +','+'9999999');
      end;
   end
   else
   begin
      rewrite(arq);
      writeln(arq, datetoStr(now) + ',' + timeToStr(now) +','+'99999999');
   end;
   CloseFile(arq);
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   case key of
      vk_return:
                begin
                   Perform (CM_DialogKey, VK_TAB, 0);
                   key:= vk_Tab;
                end;
      VK_F8:begin
               tarefas1.Visible:= Not(tarefas1.Visible)
            end;
   end;
end;


procedure TForm1.Consultas1Click(Sender: TObject);
begin
   ChamaSenha('Senha Supervisor - Consulta');
end;


procedure TForm1.MEdit1Enter(Sender: TObject);
begin
   MEdit1.text:= ''
end;


procedure TForm1.Edit3Enter(Sender: TObject);
begin
  edit3.text:='';
end;


function ajusatadata2(dt:string):string;
begin
   delete(dt,01,pos(' ',dt));
   ajusatadata2:=dt;
end;


function ajustadata2(dt:string):string;
begin
   if (length(dt) <= 19  ) and ( copy(dt,11,01) = '/' ) then   insert('0',dt,10);
   if (length(dt) <= 20  ) and ( copy(dt,14,01) = '/' ) then   insert('0',dt,13);
   ajustadata2:=dt;
end;


procedure TForm1.BitBtn11Click(Sender: TObject);
begin
   edit3.text := '';
   panel2.visible := false;
   timer2.enabled :=true;
   pagecontrol1.Visible := true;
   MEdit1.text:= '';
   cb5.Visible := false;
   if label6.caption = 'Senha Supervisor - Fora de hora' then
      panel1.visible := false
end;


procedure TForm1.FormCreate(Sender: TObject);
var
   arq:textfile;
begin
   Application.OnException := AppException;
   if  shortdateformat <> 'dd/MM/yyyy'  then
   begin
      MsgTela( 'ATENÇÃO!!!!'+#13+'A data esta em formato diferente e não posso continuar.'+#13+'Consulte o suporte técnico',MB_OK+MB_ICONERROR);
      application.Terminate
   end;
   LongTimeFormat  :='HH:mm:ss';
   with form1 do
   begin
      top:= -3;
      caption := TITULO;
      Width:=pagecontrol1.Width + 05;
      clientheight := PAGECONTROL1.Height;
      left := 800 - form1.Width;
   end;
   panel1.TOP := 15;
   panel2.TOP := 36;

   assignFile( arq, PATH + 'UVPonto.cfg');
   Rewrite(arq);
   writeln(arq,  'Versao='+ VERSAO);
   closefile(arq);
   assignFile( arq, 'UVPonto.cfg');
   Rewrite(arq);
   writeln(arq,  'Versao='+ VERSAO);
   closefile(arq);
end;


procedure TForm1.AppException(Sender: TObject; E: Exception);
var
  dest:textfile;
begin
   assignFIle(dest, ARQ_ERROS );
   if FileExists(ARQ_ERROS) = true then
      append(dest)
   else
      rewrite(dest);
   writeln(dest,'- ' + DateToStr(now)+' - '+TimeTOStr(now)+ ' - ' +  E.message );
   closefile(dest);
end;


procedure TForm1.Justificativas1Click(Sender: TObject);
begin
  chamaSenha('Senha Supervisor - Justificativas');
end;


function  Tform1.GetEstab(mat:string):string;
begin
   case StrToint( copy(mat,03,02)  ) of
      01,05:GetEstab:='000';
      02:GetEstab:='002';
      03:GetEstab:='003';
      06:GetEstab:='006';
      10:GetEstab:='010';
      11:GetEstab:='011';
      12:GetEstab:='012';
      17:GetEstab:='017';
   end;
   case StrToint( copy(mat,03,02) ) of
      01,02,03 : AdoConnection1.DefaultDatabase := 'FLUXUS001';
   else
      AdoConnection1.DefaultDatabase := 'FLUXUS002';
   end;
end;

Procedure tfOrm1.Justificar(sender:Tobject; mat, just, data1, data2, tipo, hora1,hora2, ocorr:string);
var
   comando :String;
begin
   screen.Cursor := crHourGlass;
   query1.SQL.Clear;
   comando := comando + 'Insert Justificativas values ( ';
   comando := comando +  #39 + GetEstab(Mat)+ #39 + ', ';
   comando := comando +  #39 + mat          + #39 + ', ';
   comando := comando +  #39 + just         + #39 + ', ';
   comando := comando +  #39 + data1        + #39 + ', ';
   comando := comando +  #39 + data2        + #39 + ', ';
   comando := comando +  #39 + tipo         + #39 + ', ';
   comando := comando +  #39 + hora1        + #39 + ', ';
   comando := comando +  #39 + hora2        + #39 + ', ';
   comando := comando +  #39 + ocorr        + #39 + ', ';
   comando := comando +  #39 + ''           +#39  + ') ';
   query1.SQL.Add(comando);
   query1.ExecSQL;
   screen.Cursor := crDefault;
end;


procedure TForm1.BitBtn10Click(Sender: TObject);
begin
   if label6.caption = 'Senha Supervisor - Fora de hora' then
   begin
      if validasenha(sender) = true then
      begin
         if cb5.itemindex > -1 then
         begin
          RegistraPonto(sender,label3.caption,label4.caption,MEdit1.text);
            Justificar(sender,MEdit1.Text, copy(cb5.items[cb5.itemIndex],01,04), AjData(Label3.Caption), AjData(Label3.Caption), '1', '0800', AjHora(label4.Caption),'A02');
            msgTela('Justificativa Feita com sucesso',MB_OK+MB_ICONINFORMATION);
            BitBtn11Click(Sender);
         end
         else
         begin
            msgTela('ATENÇÃO!!!!'+#13+'Você tem de informar uma justificativa para autorizar entradas por atrasos!!!!',MB_OK+MB_ICONERROR);
            edit3.setfocus;
         end;
      end
      else
      begin
         msgtela('   Senha Inválida!    '+ #13,MB_OK+MB_ICONERROR);
         edit3.setfocus;
      end;
   end
   else if label6.caption =  'Senha Supervisor - Consulta' then
   begin
      if validasenha(sender)= true then
      begin
         edit3.text:='';
         panel2.Visible := false;
         pagecontrol1.Visible := false;
         Application.CreateForm(Tfmconsultas, fmconsultas);
      end
      else
      begin
         msgtela('   Senha Inválida!    '+ #13,MB_OK+MB_ICONERROR);
         edit3.setfocus;
      end;
      edit3.text := '';
   end
   else if label6.caption =  'Senha Supervisor - Justificativas' then
   begin
      if validasenha(sender) then
      begin
         edit3.text:='';
         panel2.Visible := false;
         pagecontrol1.Visible := false;
         timer2.Enabled := false;
         pagecontrol1.Visible := false;
         Application.CreateForm(TJustificativa, Justificativa);
      end
      else
      begin
         msgtela('   Senha Inválida!    '+ #13,MB_OK+MB_ICONERROR);
         edit3.setfocus;
      end;
      edit3.text := '';
   end;
end;


procedure TForm1.mxOneInstance1InstanceExists(Sender: TObject);
begin
   msgTela(#13+'   Ja existe uma tela desse programa aberta     '+ #13+'                e esta será Fechada                          '+ #13,mb_iconerror+mb_ok);
   application.terminate;
end;


procedure TForm1.IncluirSenha1Click(Sender: TObject);
begin
   timer2.enabled := false;
   Application.CreateForm(TPasswordDlg, PasswordDlg);
   passworddlg.show;
   passworddlg.AjusteparaIncluir(sender);
end;

procedure TForm1.AlterarSenha1Click(Sender: TObject);
begin
   timer2.enabled := false;
   Application.CreateForm(TPasswordDlg, PasswordDlg);
   passworddlg.show;
   passworddlg.AjusteparaAlterar(sender);;
end;


procedure TForm1.ExecutarProgExterno(Prog:string);
begin
   if  WinExec(Pchar(prog), SW_SHOW) <= 31 then { Se ocorreu erro... }
      msgtela('Não posso executar.',MB_OK + MB_ICONERROR);
end;


procedure TForm1.AlterarCodigo1Click(Sender: TObject);
begin
   ExecutarProgExterno('c:\_ponto\AltReg.exe h2so4')
end;


procedure TForm1.TruncarArquivoBatidas1Click(Sender: TObject);
begin
   ExecutarProgExterno('c:\_ponto\MRegAnt.exe h2so4');
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
   tarefas1.visible:= false;
   screen.cursor := crhourglass;
   if atualizacao = false then
   begin
      carregaParametros(sender);
      timer2.Enabled := true;
      label1.Caption := 'Data:';
      Label2.visible:= true;
      label3.visible := true;
      label4.visible := true;
      label4.caption := timetostr(now);
      label3.caption := datetostr(now);
      atualizacao:= true;
   end;
   screen.cursor :=  crdefault;
   setforegroundWindow(handle);
   backup1.Enabled:=true;
   consultas1.Enabled:=true;
   justificativas1.Enabled:=true;
end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
   form1.caption := TITULO;
   label3.caption := DateToStr(now);
   label4.caption := TimeToStr(now);

   TempRestCopia := TempRestCopia - 1 ;

   if (TempRestCopia = 0)  then
   begin
      BackUp1Click(Sender);
      TempRestCopia := StrToInt( funcoes.lerParam(ARQ_CONF,1)) * 120 ;
   end;

   if panel1.visible then
   begin
      sleep(3000);
      panel1.visible := false;
      MEdit1.setfocus;
   end;

   if pagecontrol1.ActivePageIndex = 0 then
      MEdit1.setfocus;

   if (length(MEdit1.text) = 8 ) and (pos(' ',MEdit1.text) = 0) then
   begin
      form1.label29.caption := DateToStr(now)+ '  as  ' + timeToStr(now);
      if ExisteBatida(label4.caption,MEdit1.text) then
      begin
         MEdit1.text := '';
         msgtela(#13 + '  Já consta batida com esse número e menos  ' + #13 + '                      de trinta minutos',MB_OK + MB_ICONWARNING);
      end
      else
      begin
         if VerificaHorario(label3.caption, label4.caption, MEdit1.text) = 'Fora de hora' then
         begin
            timer2.Enabled:= false;
            cb5.Items.LoadFromFile( ARQ_JUSTIFICATIVAS);
            ChamaSenha('Senha Supervisor - Fora de hora');
            panel1.visible := true;
         end
         else if VerificaHorario(label3.caption, label4.caption, MEdit1.text) =  'Nao Existe' then
         begin
             MEdit1.text := '';
             msgtela('     Este Registro não é cadastrado!         '+ #13,MB_OK + MB_iconerror);
         end
         else
         begin
              RegistraPonto(sender,label3.caption,label4.caption,MEdit1.text);
              MEdit1.text := '';
         end;
      end;
   end;
end;

procedure tform1.CopiaParaServidor(DataInicio:String;sender:tobject);
var
   aux:integer;
   dest,arq:textfile;
   ArqCopia,l:string;
   mesAnoI,mesAnoF:string;
begin
   ArqCopia:=  'Cp_Bat_'+ funcoes.lerParam(ARQ_CONF,2) + '.txt';
   timer2.Enabled := false;
   label2.visible := false;
   label3.visible := false;
   label4.visible := false;
   label1.caption := 'Montando o arquivo de batidas... ';
   form1.Refresh;

   mesAnoF := Copy(label3.caption,04,07);

   aux := strToInt(copy(label3.caption,04,02)) - 1;

   mesAnoI := '0' + IntToStr( aux ) + '/' + Copy(label3.caption,07,04);

   if aux < 1 then
      mesAnoI :=  IntToStr( aux + 12 ) + '/' + intToSTr(StrToInt(Copy(label3.caption,07,04))-1  );


   AssignFile(arq ,  funcoes.lerParam(ARQ_CONF,0) );
   Reset(arq);

   AssignFile(dest, PATH + ArqCopia);
   Rewrite(dest);
   while eof(arq) = false do
   begin
      readln(arq,l);
      if (pos(mesanoI,copy(l,01,28)) > 0) or (pos(mesanof,copy(l,01,28)) > 0) then
      begin
         writeln(dest,copy(l,01,28));
         label1.caption := 'Montando o arquivo de batidas ' + copy(l,01,10);
         form1.Refresh;
      end;
   end;
   CloseFile(arq);
   CloseFile(dest);
   try
       with ftp do
       begin
         ftp.Connect();
         ChangeDir('\ponto');
         Put(PATH + ArqCopia, ArqCopia );
         ftp.Disconnect;
       end;
       DeleteFile(PATH + ArqCopia);
       label1.caption :='Data:';
       label2.caption :='Hora:';
       label2.visible := true;
       label3.visible := true;
       label4.visible := true;
       timer2.Enabled := true;
     except
     on e:Exception do
     begin
       label1.caption :='Data:';
       label2.caption :='Hora:';
       label2.visible := true;
       label3.visible := true;
       label4.visible := true;
       timer2.Enabled := true;
     end;
   end;
       label1.caption :='Data:';
       label2.caption :='Hora:';
       label2.visible := true;
       label3.visible := true;
       label4.visible := true;
       timer2.Enabled := true;

end;

procedure TForm1.Enviararquivo1Click(Sender: TObject);
begin
  timer2.Enabled:=false;
  Application.CreateForm(TcpRegistros, cpRegistros);
  cpRegistros.Show;
end;

procedure TForm1.BackUp1Click(Sender: TObject);
begin
   CopiaParaServidor(label3.caption,sender);
end;


procedure TForm1.FTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
   form1.Refresh;
   label1.caption := 'Enviando Arquivo.... '+ inttoStr(AWorkCount) +' de '+ IntToStr(bytesTotal);
end;


procedure TForm1.FTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Integer);
begin
     BytesTotal :=  AWorkCountMax;
end;

function TForm1.MsgTela(Msg:string; iconeBotao: integer):integer;
begin
   result := application.MessageBox(pchar(msg),pchar(titulo), iconeBotao );
end;

procedure TForm1.Configuraesiniciais1Click(Sender: TObject);
begin
   if winexec(pchar(path+'AltIni.exe ' +ARQ_CONF  ),sw_normal) <= 31 then form1.MsgTela('Não encontrado',mb_iconerror+mb_Ok);
end;

end.

