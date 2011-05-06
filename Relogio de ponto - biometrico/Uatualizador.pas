unit Uatualizador;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatButtonUnit, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP,funcoes, AppEvnts,ShellApi,
  TFlatGaugeUnit, IdDayTime, TFlatMemoUnit, ComCtrls, Gauges;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    ApplicationEvents1: TApplicationEvents;
    Label1: TLabel;
    Label2: TLabel;
    dt: TIdDayTime;
    pBar: TGauge;
    FlatButton2: TFlatButton;
    procedure FlatButton1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);
    procedure MostraMensagem(sender:Tobject;Mensagem:string;intervalo:integer);
    function AcertarDataeHora(l:string):boolean;
    function PodeBaixarArq(Arq:string):boolean;
    function CopiaArquivo( Origem: String; Destino: String; sobrescrever:boolean): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ExecutarAplicativo(sender:Tobject; NomeAplicativo:string);
    procedure FormActivate(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure Atualizar(Sender:Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PATH, ARQ_ERROS, PATH_ORIGEM :string;
  listtemp2:tstringlist;
  ProgramaAExecutar:string;
  ParamLancador:string;
implementation
uses unit2;
{$R *.dfm}

function DataDeCriacao(Arq: string): TDateTime;
var
  FileH: THandle;
  LocalFT: TFileTime;
  DosFT: DWORD;
  LastAccessedTime: TDateTime;
  FindData: TWin32FindData;
begin
  FileH := FindFirstFile(PChar(arq), FindData);
  if FileH <> INVALID_HANDLE_VALUE then
  begin
   Windows.FindClose(FileH) ;
   if (FindData.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY) = 0 then
   begin
      FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFT);
      FileTimeToDosDateTime(LocalFT,LongRec(DosFT).Hi, LongRec(DosFT).Lo);
      LastAccessedTime := FileDateToDateTime(DosFT);
      Result := LastAccessedTime;
   end;
  end;
end;

function TamArq(Arquivo: string): Integer;
begin
   with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
   try
      Result := Size;
   finally
       Free;
   end;
end;

function tform1.PodeBaixarArq(Arq:string):boolean;
begin
//   form1.memo.Lines.add('Verificando '+ arq);
   if (FileExists(PATH + arq) = false) or
      ( DataDeCriacao( PATH_ORIGEM + ARQ )  <> DataDeCriacao( PATH + arq )  ) then
      PodeBaixarArq := true;
end;

procedure tform1.ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);
var
  i: integer;
  listatemp: TStrings;
  procedure ListarDiretorios(Folder: string; lista: Tstrings);
  var
    Rec: TSearchRec;
    i: integer;
    temps: string;
  begin
    lista.Clear;
    if SysUtils.FindFirst(Folder + '*', faDirectory, Rec) = 0 then
    try
      repeat
        lista.Add(rec.Name);
      until SysUtils.FindNext(Rec) <> 0;
    finally
      if lista.count <> 0 then
      begin
        lista.Delete(1);
        lista.Delete(0);
        i := 0;
        if lista.count <> 0 then
        begin
          repeat
            temps := lista.Strings[i];
            temps := extractfileext(temps);
            if temps <> '' then
              lista.Delete(i)
            else
              inc(i);
          until i >= lista.Count;
        end;
      end;
    end;
  end;

  procedure ListarAtahos(Folder, mask: string; Lista: Tstrings);
  var
    Rec: TSearchRec;
  begin
    lista.Clear;
    if SysUtils.FindFirst(Folder + mask, faAnyFile, Rec) = 0 then
    try
      repeat
        lista.Add(rec.Name);
      until SysUtils.FindNext(Rec) <> 0;
    finally
      SysUtils.FindClose(Rec);
    end;
  end;

  procedure AddLIstInOther(ListSource, ListDestino: TStrings);
  var
    f: integer;
  begin
    for f := 0 to ListSource.Count - 1 do
    begin
      ListDestino.Add(ListSource.Strings[f]);
    end;
  end;
begin
  listatemp := TStringList.Create;
  ListarAtahos(diretorioInicial, mascara, listatemp);
  if listtotaldir = true then
  begin
    for i := 0 to listatemp.Count - 1 do
    begin
      listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];
    end;
  end;
  AddLIstInOther(listatemp, listtemp2);
  if recursive = true then
  begin
    ListarDiretorios(diretorioInicial, listatemp);
    for i := 0 to listatemp.Count - 1 do
    begin
      ListarArquivos(diretorioInicial + listatemp.Strings[i] + '\', mascara, listtotaldir, recursive);
    end;
  end;
  listatemp.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ParamLancador := ParamStr(1);
  ProgramaAExecutar := ParamStr(2);
end;


function tform1.AcertarDataeHora(l:string):boolean;
var
   SystemTime : TSystemTime;
   dia,mes,ano,hora,min:string;
   i:integer;
begin
   for i:=1 to pos(':',l)-1 do
      hora := hora + l[i];
   if length(hora) < 2 then insert('0',hora,01);
   delete(l,01,pos(':',l));

   for i:=1 to pos(':',l)-1 do
      min := min + l[i];
   delete(l,i,pos(':',l));
   if length(min) < 2 then insert('0',min,01);

   for i:=0 to pos(' ',l)do
      delete(l,1,pos(' ',l));

   for i:=1 to pos('/',l)-1 do
      dia := dia + l[i];
   if length(dia) < 2 then insert('0',dia,01);
   delete(l,1,pos('/',l));

   for i:=1 to pos('/',l)-1 do
      mes := mes + l[i];
   if length(mes) < 2 then insert('0',mes,01);
   delete(l,1,pos('/',l));

   ano:=copy(l,01,04);

   With SystemTime do
   begin
       wYear:= StrToint(ano);
       wMonth:= StrToint(mes);
       wDay:= StrToint(dia);
       wHour:= StrToint(hora);
       wMinute:= StrToint(min);
       wSecond:= 00;
    end;
    SetLocalTime(SystemTime);
    funcoes.GravaLinhaEmUmArquivo(funcoes.tempdir()+'AcertosAcertaHora.txt','Acerto da hora '+  hora +' '+ min );
end;


procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
   showmessage(' - Ocorreu o seguinte erro no programa      ' +#13+#13+ e.Message);
   funcoes.GravaLinhaEmUmArquivo(ARQ_ERROS , DateToStr(now)+' '+ timetostr(now) +' '+ e.ClassName + '  '+ e.Message);
   ExecutarAplicativo(sender, ProgramaAExecutar );
   Application.Terminate;
end;

procedure TForm1.MostraMensagem(sender: Tobject; Mensagem: string;intervalo:integer);
begin
   label2.caption :=  Mensagem;
   form1.Refresh;
   sleep(intervalo);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Winexec(pchar('CMD.EXE /C net use '+ funcoes.RParReg('listas','HostFTP')+ ' /delete /yes'), sw_hide);
end;

function TForm1.CopiaArquivo(Origem, Destino: String; sobrescrever: boolean): Boolean;
var
 Dados: TSHFileOpStruct;
begin
   form1.Refresh;
   sleep(500);
   if not CopyFile(PChar(Origem), PChar(Destino), false) then
   begin
      Label2.Caption := ' Erro ao Copiar o arquivo     ' + #13+ Origem ;
     sleep(1000);
   end;
end;



procedure TForm1.FlatButton1Click(Sender: TObject);
begin
   if (funcoes.RParReg('ProgramasCF\Upgrade','edRemoto') = '' ) then
   begin
      MsgTela(form1.Caption, ' Configure antes, o diretório de atualização', mb_iconError+mb_ok  );
      application.Terminate;
   end
   else
   begin
      if funcoes.RParReg('ProgramasCF\Upgrade','edLocal') <> '' then
         PATH := funcoes.RParReg('ProgramasCF\Upgrade','edLocal')
      else
         PATH := ExtractFilePath(ParamStr(0));

      ARQ_ERROS := ExtractFilePath(ParamStr(0)) + 'ErrorLog.txt' ;

      label1.Caption := 'Verificando se existe atualização';
      Atualizar(Sender);
   end;
end;

procedure Tform1.Atualizar(Sender:Tobject);
var
   i:integer;
   cmd:string;
   usuarioRemoto, senha: String;
begin
   try
      PATH_ORIGEM := funcoes.RParReg('ProgramasCF\Upgrade','edRemoto');

      if funcoes.RParReg('ProgramasCF\Upgrade','edRemoto') <> '0' then
      begin
         usuarioRemoto :=funcoes.RParReg('ProgramasCF\Upgrade','edUser');
         if usuarioRemoto = '' then
            usuarioRemoto := 'convidado2';

         senha := funcoes.RParReg('ProgramasCF\Upgrade','edSenha');
         if senha = '' then
            senha := 'convidado2';

         cmd := 'CMD.EXE /c net use '+ PATH_ORIGEM +' /delete';
      //   funcoes.GravaLinhaEmUmArquivo('Errorlog.txt',cmd);
         Winexec(pchar(cmd) , sw_hide);
         cmd := 'CMD.EXE /c net use '+PATH_ORIGEM+ ' /USER:'+ usuarioRemoto +' '+senha;
     //    funcoes.GravaLinhaEmUmArquivo('Errorlog.txt',cmd);
         Winexec(pchar(cmd) , sw_hide);
      end;

      PATH_ORIGEM := PATH_ORIGEM + '\';
      PATH := PATH + '\';

      listtemp2 := Tstringlist.Create;
      ListarArquivos(PATH_ORIGEM,'*.*', false, false);
      MostraMensagem(sender, 'Ajustando data e hora',300);
      AcertarDataeHora( dt.DayTimeStr);
      MostraMensagem(sender,' Verificando atualização ... ',300   ) ;

      if listtemp2.Count-1 < 1 then
      begin
         Label2.Caption := ' Não consigo alcançar o diretório de atualização ' + PATH_ORIGEM +#13+ ' Verifique os parâmetros de atualização e tente novamente' ;
         sleep(300);
      end
      else
      begin
         pBar.Visible := true;
         pbar.MaxValue := listtemp2.Count -1;
         for i:=2 to listtemp2.Count -1 do
         begin
            sleep(50);
            pbar.Progress := i;
            if (listtemp2[i] <> 'Upgrade.exe') then
               if PodeBaixarArq( listtemp2[i] ) = true then
               begin
                  MostraMensagem(sender,' Copiando arquivo ' + listtemp2[i] , 0 ) ;
                  CopiaArquivo( PATH_ORIGEM + listtemp2[i],  PATH + listtemp2[i], true );
            end;
         end;
      end;
      MostraMensagem(sender,' Abrindo o programa: ',300   ) ;
      ExecutarAplicativo(sender, ProgramaAExecutar );
      application.terminate;
   except
      on e: exception do
      begin
         ApplicationEvents1Exception(Sender,e);
      end
   end;
end;

procedure TForm1.ExecutarAplicativo(sender: Tobject; NomeAplicativo: string);
begin

   if fileExists( PATH+ 'conexaoAowell.ini') = false then
   begin
      funcoes.GravaLinhaEmUmArquivo(PATH+ 'conexaoAowell.ini','password=');
      funcoes.GravaLinhaEmUmArquivo(PATH+ 'conexaoAowell.ini','user ID=');
      funcoes.GravaLinhaEmUmArquivo(PATH+ 'conexaoAowell.ini','initial Catalog=');
      funcoes.GravaLinhaEmUmArquivo(PATH+ 'conexaoAowell.ini','data Source=');
   end;

   winExec(pchar('cmd /c start '+ NomeAplicativo + ' ***')  ,sw_hide );
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if (ParamStr(1) = '') and ( ParamStr(2) = '' ) then
  begin
     label1.Caption := '';
     flatButton1.Visible := true;
     flatButton2.Visible := true;
  end
  else
     FlatButton1Click(Sender);
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
  Application.CreateForm(TForm2, Form2);
  form2.show;
end;

end.

