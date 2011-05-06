unit Uatualizador;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatButtonUnit, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP,funcoes, AppEvnts,ShellApi,
  TFlatGaugeUnit, IdDayTime, TFlatMemoUnit, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    ApplicationEvents1: TApplicationEvents;
    Label1: TLabel;
    Label2: TLabel;
    dt: TIdDayTime;
    Animate1: TAnimate;
    procedure FlatButton1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);
    procedure FormActivate(Sender: TObject);
    procedure MostraMensagem(sender:Tobject;Mensagem:string;intervalo:integer);
    function AcertarDataeHora(l:string):boolean;
    function PodeBaixarArq(Arq:string):boolean;
    function CopiaArquivo( Origem: String; Destino: String; sobrescrever:boolean): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PATH, ARQ_ERROS, PATH_ORIGEM :string;
  listtemp2:tstringlist;
implementation

{$R *.dfm}

function DataDeCriacao(Arq: string): TDateTime;
//function FileLastModified(const TheFile: string): string;
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
   gravaLog('Verificando arquivo:' + Arq);
   if ( arq <> 'Lista.exe') then
   begin
      if (FileExists(PATH + arq) = false) or ( DataDeCriacao( PATH_ORIGEM + ARQ ) <> DataDeCriacao( PATH + arq )  ) then
         PodeBaixarArq := true
   end
   else
      if (FileExists(PATH + 'Lista.exe') = true ) and ( DataDeCriacao( PATH + 'Lista.exe'  ) <> DataDeCriacao( PATH_ORIGEM + 'ListaNovo.exe' )  ) then
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


procedure TForm1.FormActivate(Sender: TObject);
begin
  PATH := ExtractFilePath(ParamStr(0));
  ARQ_ERROS := ExtractFilePath(ParamStr(0)) + 'ErrorLog.txt' ;
  Winexec(pchar('CMD.EXE /c net use '+ PATH_ORIGEM +' /delete') , sw_hide);
  if ParamStr(1) <> '' then
     flatButton1.Visible := true
  else
    FlatButton1Click(Sender);
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
    gravaLog('Acertar a hora para: '+  hora +':'+ min );
end;


procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
   showmessage(' - Ocorreu o seguinte erro no programa      ' +#13+#13+ e.Message);
   funcoes.gravaLog('Erro:' + DateToStr(now)+' Loja:'+ funcoes.RParReg('listas','loja') +' '+ timetostr(now) +' '+ e.ClassName + '  '+ e.Message);
   winexec(pchar('listas.exe'),sw_normal );
   Application.Terminate;
end;

procedure TForm1.MostraMensagem(sender: Tobject; Mensagem: string;intervalo:integer);
begin
   label2.caption :=  Mensagem;
   form1.Refresh;
   sleep(intervalo);
end;

function TForm1.CopiaArquivo(Origem, Destino: String; sobrescrever: boolean): Boolean;
var
 Dados: TSHFileOpStruct;
begin
  animate1.Visible := true;
  form1.Refresh;
  sleep(2000);
  if not CopyFile(PChar(Origem), PChar(Destino), false) then
     Application.MessageBox(pchar(' Erro ao Copiar o arquivo     ' + #13+ Origem), pchar(form1.Caption), Mb_iconError + mb_OK );
  animate1.Visible := false;
end;


procedure TForm1.FlatButton1Click(Sender: TObject);
var
   i:integer;
   cmd:string;
begin
   try
      PATH_ORIGEM := funcoes.RParReg('listas','HostFTP') ;

      cmd := 'CMD.EXE /c net use \\125.0.250\package /USER:'+ funcoes.RParReg('listas','User')+' '+funcoes.RParReg('listas','Password');
      Winexec(pchar(cmd) , sw_hide);

      PATH_ORIGEM := ( PATH_ORIGEM + '\' ) ;
      listtemp2 := Tstringlist.Create;
      ListarArquivos(PATH_ORIGEM,'*.*', false, false);
      MostraMensagem(sender, 'Ajustando data e hora',300);

      dt.Host := funcoes.RParReg('listas','IPServer');

      AcertarDataeHora( dt.DayTimeStr);
      MostraMensagem(sender,' Verificando atualização ... ',300   ) ;

      if listtemp2.Count-1 < 1 then
         Application.MessageBox(Pchar(' Não consigo alcançar o diretório de atualização ' + PATH_ORIGEM +#13+ ' Verifique os parâmetros de atualização e tente novamente'), pchar(form1.caption), mb_iconError+Mb_ok)
      else
      begin
         for i:=2 to listtemp2.Count -1 do
         begin
            if (listtemp2[i] <> 'Lista.exe') then
               if PodeBaixarArq( listtemp2[i] ) = true then
               begin
                  MostraMensagem(sender,' Copiando arquivo ' + listtemp2[i] , 0 ) ;
                  CopiaArquivo( PATH_ORIGEM + listtemp2[i],  PATH + listtemp2[i], true );
            end;
         end;
      end;
      MostraMensagem(sender,' Abrindo o programa... ',100 ) ;
      application.terminate;
      winexec(pchar('listas.exe'),sw_normal );
   except
      on e: exception do
      begin
         ApplicationEvents1Exception(Sender,e);
      end
   end;
end;



end.

