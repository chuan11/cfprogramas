unit Uatualizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatButtonUnit, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP,funcoes, AppEvnts,
  TFlatGaugeUnit, IdDayTime, IdExplicitTLSClientServerBase;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    FTP: TIdFTP;
    ApplicationEvents1: TApplicationEvents;
    Gauge1: TFlatGauge;
    Label1: TLabel;
    Label2: TLabel;
    dt: TIdDayTime;
    Label3: TLabel;
    procedure FlatButton1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    function BaixarArquivo(DadosDoArquivo:string):boolean;
    procedure FTPWork(Sender: TObject; AWorkMode: TWorkMode;const AWorkCount: Integer);
    function DataArqFTP(dadosArq:string):Tdatetime;
    function DefineDataHoraArq(NomeArq: string; DataHora: TDateTime): boolean;
    procedure FTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormActivate(Sender: TObject);
    procedure MostraMensagem(sender:Tobject;Mensagem:string);
    function AcertarDataeHora(l:string):boolean;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PATH_DEST,PATH,ARQ_INI:STRING;
  TAMANHOARQUIVO:INTEGER;
implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
  PATH := ExtractFilePath(ParamStr(0));
  ARQ_INI := ParamStr(1);
  PATH_DEST := funcoes.lerParam(arq_ini,01);
  Label1.caption:= Label1.caption + funcoes.lerParam(arq_ini,02);

  if ParamStr(2) <> '' then
     flatButton1.Visible := true
  else
    FlatButton1Click(Sender);
end;


function tform1.AcertarDataeHora(l:string):boolean;
var
   SystemTime : TSystemTime;
   dia,mes,ano,hora,min:string;
   horaEmInteiro,i:integer;
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
       //Definindo o dia do sistema
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
   Application.Terminate;
end;

procedure TForm1.FTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
   if TAMANHOARQUIVO <> 0 then;
   begin
      gauge1.Progress := AWorkCount;
      label3.Caption := InttoStr(AWorkCount) + ' de ' +  InttoStr(TAMANHOARQUIVO);
   end;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
var
   i:integer;
   items:tstringList;
begin
   items := tstringList.Create;
   try
      if ftp.Connected = true then
         ftp.Disconnect;
      ftp.ReadTimeout :=  300;    
      ftp.Connect();
      ftp.ChangeDir('\');
      ftp.ChangeDir(funcoes.tiraEspaco(funcoes.lerParam(ARQ_INI,00)));
      ftp.List(Items);

      for i:=0 to Items.Count-1 do
      begin
         MostraMensagem(sender, ExtractFilename(copy(items[i], 40,100)) );
         BaixarArquivo(Items[i]);
      end;

      if uppercase(funcoes.lerParam(ARQ_INI,04)) = 'S' then
      begin
         MostraMensagem(sender, 'Verificando data e hora');
         AcertarDataeHora( dt.DayTimeStr);
      end;

   except
      on e: exception do
      begin
         ApplicationEvents1Exception(Sender,e);
      end
   end;

   MostraMensagem(sender,' Executar ' + funcoes.lerParam(arq_ini,02) ) ;
   winexec(pchar(funcoes.lerParam(ARQ_INI,03)),sw_normal );
   application.terminate;
end;

function TForm1.BaixarArquivo(DadosDoArquivo: string): boolean;
var
   arq:string;
begin
   TAMANHOARQUIVO :=  StrToint( funcoes.tiraEspaco(copy(DadosDoArquivo,23,15) ) );
   arq := ExtractFilename(copy(DadosDoArquivo, 40,100));

   if (FileExists( FUNCOES.lerParam(ARQ_INI,01)  + arq) = false) or (  funcoes.DataDoArquivo( FUNCOES.lerParam(ARQ_INI,01)  + arq)   < DataArqFTP(DadosDoArquivo) ) then
   begin
      gauge1.visible := true;
      gauge1.MaxValue := TAMANHOARQUIVO;

      ftp.Get(arq, ExtractFilePath(funcoes.lerParam(ARQ_INI,01)) + arq, true,false );
      DefineDataHoraArq( ExtractFilePath(funcoes.lerParam(ARQ_INI,01))+arq , DataArqFTP(DadosDoArquivo) ) ;
      result := true;
   end;
end;

function tform1.DefineDataHoraArq(NomeArq: string; DataHora: TDateTime): boolean;
var
  F: integer;
begin
  Result := false;
  F := FileOpen(NomeArq, fmOpenWrite or fmShareDenyNone);
  try
  if F > 0 then
  begin
     Result := FileSetDate(F, DateTimeToFileDate(DataHora)) = 0;
     Result := true;
  end;
  finally
     FileClose(F);
  end;
end;

function TForm1.DataArqFTP(dadosArq: string): Tdatetime;
var
   data:string;
   hora:integer;
begin
   hora := strtoint( copy(dadosArq,11,02) );
   if copy(dadosArq,16,02) = 'PM' then
      hora := hora+12;
   result :=  StrToDateTime (copy(dadosArq,04,02) +'/'+ copy(dadosArq,01,02) +'/20'+ copy(dadosArq,07,02) +' '+intToStr(hora) +':'+ copy(dadosArq,14,02) + ':00' ) ;
end;

procedure TForm1.FTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
   form1.Refresh;
   sleep(300);
   gauge1.Visible := false;
end;



procedure TForm1.MostraMensagem(sender: Tobject; Mensagem: string);
begin
   label2.caption := ' Verificando - ' + Mensagem;
   form1.Refresh;
   sleep(300);
end;

end.


