unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,printers, DB, ADODB, DBITYPES, DBIPROCS, DBIERRS, DBTables,Registry,
  Grids, DBGrids, SoftDBGrid,funcoes,WinSpool, fCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Query: TADOQuery;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    checkNaoConfigurar: TCheckBox;
    CheckRel: TCheckBox;
    CheckCont: TCheckBox;
    CheckPed: TCheckBox;
    Connection: TADOConnection;
    CbThin: TCheckBox;
    cBox: TfsComboBox;
    cbBoleto: TCheckBox;
    cbNotas: TCheckBox;
    cbCarne: TCheckBox;
    query2: TADOQuery;
    function NomeComputador : String;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckPedClick(Sender: TObject);
    procedure CheckRelClick(Sender: TObject);
    procedure CheckContClick(Sender: TObject);
    procedure checkNaoConfigurarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CbThinClick(Sender: TObject);
    procedure configurarGenericaThinClient(sender:tobject);
    procedure FormCreate(Sender: TObject);
    procedure GetListaImpressoras(Sender: TObject);
    procedure cBoxChange(Sender: TObject);
    function  getClientTs():string;
    procedure cbCarneClick(Sender: TObject);
    procedure cbNotasClick(Sender: TObject);
    procedure cbBoletoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Function tform1.getClientTs():String;
var
  Reg: Tregistry;
  S: string;
begin
   Reg:=Tregistry.create;
   with Reg do
   begin
      rootkey := HKEY_CURRENT_USER;
      Openkey('Volatile Environment\',false);
      S := readstring('CLIENTNAME');    //
      closekey;
   end;
   getClientTs := s;
end;


function GetDefaultPrinterName : string; // Retorna o nome da impressora padrão do Windows
var
   aux:string;
begin
  aux := '';
   try
      if(Printer.PrinterIndex >= 0)then
        aux := Printer.Printers[Printer.PrinterIndex];

        if pos('(', aux) = 0 then
           aux:= '';
        Result := aux;
   except
      begin
         Result := '';
      end;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   aux:string;
begin
   Screen.Cursor := crHourGlass;
   edit2.Text := NomeComputador();
   if funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa') = '' then
     edit1.text := GetDefaultPrinterName()
   else
     if funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa') <> '' then
     begin
        edit1.Text := trim( funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa') );
        edit2.Text := getClientTs();
     end;


   form1.Refresh;

   // verifica se ja ha impressora para o terminal
   query2.sql.Clear;
   query2.SQL.Add('Select * from  timpr where ds_est = '+ quotedStr(edit2.text) );
   query2.Open;

   aux := '';
   if (edit1.Text <> '') then
   begin
      if funcoes.RParReg('ProgramasCF\ImpressoraTS','impThinClient') = '1' then
         configurarGenericaThinClient(sender);

      query.sql.Clear;
      if query2.IsEmpty = false then
      begin
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impped') <> '1' then
            aux := aux+ ('update timpr set  cd_impped ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text)) +#13 ;

         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impRel') <> '1' then
            aux := aux+ ('update timpr set  cd_impRel ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text)) +#13;

         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impfin') <> '1' then
            aux := aux+ ('update timpr set  cd_impfin ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text));

         // boletos
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impBole') <> '1' then
            aux := aux+ ('update timpr set  cd_impBole ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text));

         // notas
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impNot') <> '1' then
            aux := aux+ ('update timpr set  cd_impNot ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text));

         // carnes
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impCar') <> '1' then
            aux := aux+ ('update timpr set  cd_impCar ='+ quotedStr(edit1.text) + ' where ds_est = ' + quotedStr(edit2.text));


      end
      else
      begin
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impped') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impped) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' ) +#13;

         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impRel') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impRel) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' ) +#13;

         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impfin') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impfin) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' );

         // Boletos
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impBole') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impBole) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' );

         // Notas
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impNot') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impNot) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' );
         // Carnes
         if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impCar') <> '1' then
            aux := aux + (' insert timpr (ds_est, cd_impCar) values(' + quotedstr(edit2.text) + ' , ' + quotedstr(edit2.text)+')' );
      end;
      query.SQL.Add(aux);
      query.ExecSQL;

      funcoes.GravaLinhaEmUmArquivo(ExtractFilePath(paramStr(0)) + 'Log_Impressoras.txt',DateTimeToStr(now)+'  '+'Ok! ' + edit1.text + '  '+ edit2.text );
      funcoes.GravaLinhaEmUmArquivo(ExtractFilePath(paramStr(0)) + 'Log_Impressoras.txt',DateTimeToStr(now)+'  '+aux );
      form1.caption := 'Impressora configurada.';
   end
   else
   begin
      aux := (' delete from timpr where ds_est = '+ quotedstr(edit2.text) );
      query.SQL.Add(aux);
      query.ExecSQL;
      funcoes.GravaLinhaEmUmArquivo(ExtractFilePath(paramStr(0))+ 'Log_Impressoras.txt',DateTimeToStr(now)+'  '+'Sem impressoras no local ' + edit2.text );
      form1.caption := 'Nenhuma impressora de instância.';
   end;
   sleep(1500);
   Screen.Cursor := crDefault;
end;

function tform1.NomeComputador : String;
const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
var
  lpBuffer : PChar;
  nSize : DWord;
  aux1,aux2:string;
  inicio,tam:integer;
begin
   aux1 := GetDefaultPrinterName();
   inicio := pos('(de ',aux1)+4;
   tam := pos(')',aux1) - (pos('(de ',aux1)+4);
   aux2 := copy(aux1,  inicio , tam  );

   if aux2 <> '' then
   begin
      NomeComputador := aux2;
   end
   else
   begin
      nSize := Buff_Size;
      lpBuffer := StrAlloc(Buff_Size);
      GetComputerName(lpBuffer,nSize);
      NomeComputador := String(lpBuffer);
      StrDispose(lpBuffer);
   end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   form1.top := 100;
   form1.Left := screen.Width - form1.Width - 20;

   Connection.Open;
// se na houver nenhuma configuracao roda a configuracao da  impressao
   if funcoes.RParReg('ProgramasCF\ImpressoraTS','NaoConfigurar') = '' then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','NaoConfigurar','0');

   form1.Refresh;
   query2.ConnectionString := query.ConnectionString;
   if ParamStr(1) <> '' then
   begin
      form1.BorderIcons := BorderIcons - [biMaximize,biMinimize,biHelp];
      form1.Height := 255;
      Button1.Visible := true;
      groupBox1.Visible:= true;
      checkPed.Visible:= true;
      checkCont.Visible:= true;
      checkRel.Visible:= true;
      CbThin.visible := true;
      cbNotas.Visible := true;
      cbCarne.Visible := true;
      cbBoleto.Visible := true;
      Cbox.Visible := true;

      checkNaoConfigurar.Visible:= true;

      if funcoes.RParReg('ProgramasCF\ImpressoraTS','NaoConfigurar') = '1' then
         checkNaoConfigurar.Checked := true
      else
         checkNaoConfigurar.Checked := false;

      if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impped') = '1' then
         checkPed.Checked := true;
      if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impRel') = '1' then
         CheckRel.Checked := true;

      if funcoes.RParReg('ProgramasCF\ImpressoraTS','cd_impfin') = '1' then
         checkCont.Checked := true;

      if funcoes.RParReg('ProgramasCF\ImpressoraTS','impThinClient') = '1' then
         CbThin.Checked := true;

      if funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa') <> '' then
         edit1.Text := trim( funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa') );

      GetListaImpressoras(Sender);
   end
   else
   begin
      form1.Height := 110;
      try
        sleep(4000);
        if funcoes.RParReg('ProgramasCF\ImpressoraTS','NaoConfigurar') = '0' then
            Button1Click(Sender)
        else
        begin
           Form1.caption := 'Não configurar impressora';
           sleep(3000);
        end;
        application.Terminate;
      except
         on e:Exception do
         begin
            showmessage(e.Message);
            funcoes.GravaLinhaEmUmArquivo(ExtractFilePath(paramStr(0))+ 'Log_Impressoras.txt',DateTimeToStr(now)+'  '+'Erro ' + edit1.text + '  '+ edit2.text );
            application.Terminate;
            showmessage(e.message);
         end;
      end;
      query2.Close;
      query2.Destroy;
   end;
end;

procedure TForm1.CheckPedClick(Sender: TObject);
begin
   if CheckPed.Checked = true then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impped','1')
   else
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impped','0');
end;

procedure TForm1.CheckRelClick(Sender: TObject);
begin
   if CheckRel.Checked = true then
      funcoes.wParReg('ProgramasCF\ImpressoraTS','cd_impRel','1')
   else
      funcoes.wParReg('ProgramasCF\ImpressoraTS','cd_impRel','0');
end;

procedure TForm1.CheckContClick(Sender: TObject);
begin
   if checkcont.Checked = true then
      funcoes.wParReg('ProgramasCF\ImpressoraTS','cd_impfin','1')
   else
      funcoes.wParReg('ProgramasCF\ImpressoraTS','cd_impfin','0');
end;


procedure TForm1.checkNaoConfigurarClick(Sender: TObject);
begin
  if checkNaoConfigurar.Checked = true then
  begin
     groupBox1.Visible := false;
     Button1.Visible := false;
  end
  else
  begin
     groupBox1.Visible := true;
     Button1.Visible := true;
  end;
   if checkNaoConfigurar.Checked = true then
      funcoes.wParReg('ProgramasCF\ImpressoraTS','NaoConfigurar','1')
   else
      funcoes.wParReg('ProgramasCF\ImpressoraTS','NaoConfigurar','0');
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   Connection.close;
end;

procedure TForm1.CbThinClick(Sender: TObject);
begin
   if CbThin.Checked = true then
      funcoes.wParReg('ProgramasCF\ImpressoraTS','impThinClient','1')
   else
      funcoes.wParReg('ProgramasCF\ImpressoraTS','impThinClient','0');
end;

procedure TForm1.configurarGenericaThinClient(sender: tobject);
var
  arq:TstringList;
  aux:string;
begin
   arq := TStringList.Create();


   aux :='';
   arq.LoadFromFile('01DefinirPapel.reg');
   aux := arq[2];
   delete( aux,69,100 );
   insert(edit1.text+'\DsDriver]', aux, 69);
   arq[2] := aux;
   arq.saveToFile( funcoes.TempDir() + '01DefinirPapel.reg');
   winExec(pchar('cmd.exe /c regedit.exe -s '+ funcoes.TempDir() + '01DefinirPapel.reg'),sw_hide);


   aux :='';
   arq.LoadFromFile('02DefinirQuebra.reg');
   aux := arq[3];
   insert(edit1.text, aux, 02);
   arq[3] := aux;
   arq.saveToFile( funcoes.TempDir() + '02DefinirQuebra.reg');
   winExec(pchar('cmd.exe /c regedit.exe -s '+ funcoes.TempDir() + '02DefinirQuebra.reg'),sw_hide);


   aux :='';
   arq.LoadFromFile('03DefinirLinhaPosImpressao.reg');
   aux := arq[2];
   insert(edit1.text, aux, 72);
   arq[2] := aux;
   arq.saveToFile( funcoes.TempDir() + '03DefinirLinhaPosImpressao.reg');
   winExec(pchar('cmd.exe /c regedit.exe -s '+ funcoes.TempDir() + '03DefinirLinhaPosImpressao.reg'),sw_hide);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   connection.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) + 'ConexaoAoWell.ini');
end;

procedure TForm1.GetListaImpressoras(Sender: TObject);
var
  i : Integer;
  Flags, Count, NumInfo: DWORD;
  Buffer : String;
  PrinterInfo : PChar;
begin
  Flags := PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL;
  EnumPrinters(Flags, nil, 5, nil, 0, Count, NumInfo);
  if Count = 0 then
    Exit;
  SetLength(Buffer, Count);
  if not EnumPrinters(Flags, nil, 5, PByte(Buffer), Count, Count, NumInfo) then
    Exit;
  PrinterInfo := PChar(Buffer);
  for i := 0 to NumInfo - 1 do begin
    with PPrinterInfo5(PrinterInfo)^ do
      cBox.Items.Add(String(pPrinterName));
    Inc(PrinterInfo,Sizeof(TPrinterInfo5));
  end;
end;

procedure TForm1.cBoxChange(Sender: TObject);
begin
   if cbox.ItemIndex = 0 then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa', '')
   else
      funcoes.WParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa', Trim(cbox.Items[cbox.ItemIndex]));

   edit1.Text := funcoes.RParReg('ProgramasCF\ImpressoraTS','ImpressoraFixa');
end;

procedure TForm1.cbCarneClick(Sender: TObject);
begin
   if cbCarne.Checked = true then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impCar','1')
   else
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impCar','0');
end;

procedure TForm1.cbNotasClick(Sender: TObject);
begin
   if cbNotas.Checked = true then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impNot','1')
   else
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impNot','0');
end;

procedure TForm1.cbBoletoClick(Sender: TObject);
begin
   if cbBoleto.Checked = true then
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impBole','1')
   else
      funcoes.WParReg('ProgramasCF\ImpressoraTS','cd_impBole','0');

end;

end.



