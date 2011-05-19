{
perfil 1  ponto biometrico
perfil 2  ponto digitado
perfil 3  nao captura
}

unit RelogioPonto;
interface
uses
  shellapi, Windows, Messages, SysUtils, Menus, Classes,  Mask,Controls, Buttons,
  ComCtrls,Forms, Dialogs, ExtCtrls, StdCtrls, DBCtrls,mxOneInstance,
  AppEvnts, adLabelMaskEdit, IdComponent, IdTCPConnection,IdTCPClient,
  ADODB, IdBaseComponent, DB,  FileCtrl, clipbrd, OleCtrls,
  GrFingerXLib_TLB,TFlatButtonUnit, TFlatEditUnit,
  GrFinger, RpBase, RpSystem, Math,
  RpCon, RpConDS, RpDefine, RpRave;


type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    Consultas1: TMenuItem;
    Justificativas1: TMenuItem;
    Timer2: TTimer;
    mxOneInstance1: TmxOneInstance;
    ApplicationEvents1: TApplicationEvents;
    Batidas1: TMenuItem;
    Ocorrncias1: TMenuItem;
    pnBatidaRec: TPanel;
    Label25: TLabel;
    lbDadosCartao: TLabel;
    lbDataHoraPonto: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    lbNome: TLabel;
    Panel3: TPanel;
    lbData: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbHora: TLabel;
    Bevel2: TBevel;
    Image1: TImage;
    BitBtn3: TBitBtn;
    StatusBar1: TStatusBar;
    GrFingerXCtrl1: TGrFingerXCtrl;
    RvProject: TRvProject;
    dsConn1: TRvDataSetConnection;
    dsConn2: TRvDataSetConnection;
    RvSystem: TRvSystem;
    FolhaPonto1: TMenuItem;
    pnPontoDig: TPanel;
    edPontodig: TadLabelMaskEdit;
    Bevel1: TBevel;
    Cadastrodedigitais1: TMenuItem;

    function  buscaEmComboBox(cb: TStrings; str: String):integer;
    function  getCartaoPonto(cb: TCustomComboBox): String;
    function  getCartaoPontoStr(str:String): String;
    function  getCodLocalizacaoLoja(cb: TCustomComboBox): String;
    function  HoraPrev(data, cartaoPonto: string; isSaida, isIntervalo:boolean): string;
    function  r1(n:string):string;
    function  VerificaHorario( data, hora, cartaoPonto:String): String;
    function  verificarSenha():string;
    function calculaAtraso(cartao:String; data:Tdate;batida:String):integer;
    function ExisteBatida(cartao:String):boolean;
    function existsFormOpen(Dender:Tobject):boolean;
    function getCampoDia(data:String; ehSaida, isIntervalo:boolean):String;
    function getDadosEmpregado(nCartao: String): boolean;
    function getLocalizacaoLoja(cb:TCustomComboBox):String;
    function getMatricula(DadosEmp:String):String;
    function getNome(DadosEmp:String):String;
    function getNomeCB(cb:TCustomComboBox):String;
    function isAntecipacaoSaida(cartao, data, batida:String):integer;
    function isFaltaNoDia(cartaoPonto, batEnt, batSai, data, isFeriado:String):boolean;
    function selecionaBatidasDoDia(dia, cartaoPonto:String; Batidas: TStringList):TStringlist;
    procedure ajustarItensNaTela(Sender:Tobject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ativaReceberPontoBiometrico();
    procedure ativaReceberPontoDigitado();
    procedure ativarLabelsDataHora();
    procedure Batidas1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure calcHorasTotais(var table: TADOTable; var tHorasPrev, tHorasTrab , tAtrasJus, tAtrasAut, tHorasDif, batIncJ, batInc , falta, faltaJ:smallint; matricula, cartao:string; dataInicial:Tdate);
    procedure closeDataSet();
    procedure ConfiguraMenus();
    procedure connWellWillExecute(Connection: TADOConnection;   var CommandText: WideString; var CursorType: TCursorType;      var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
    procedure digitarPonto(cartaoPonto:String);
    procedure edPontodigKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure exibeBatida(data,hora:String);
    procedure FolhaPonto1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GrFingerXCtrl1ImageAcquired(ASender: TObject; const idSensor: WideString; width, height: Integer;var rawImage: OleVariant; res: Integer);
    procedure GrFingerXCtrl1SensorPlug(ASender: TObject; const idSensor: WideString);
    procedure habilitaItens(Sender: Tobject);
    procedure impressaoRave(dataSet1,DataSet2:TdataSet; nomeRelatorio:String;Parametros:TStringlist);
    procedure Justificativas1Click(Sender: TObject);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure Ocorrncias1Click(Sender: TObject);
    procedure posicionarTela(form:Tform);
    procedure preencherListaBatidas(var table:TadoTable; dti,dtf:Tdate; cartao:String);
    procedure ReceberCartaoDePonto(cartaoPonto:String);
    procedure RegistraPonto(data,hora,cartaoPonto:string);
    procedure registraPontoWalter(data:string);
    procedure Timer2Timer(Sender: TObject);
    procedure verificaAtualizacaoDoLancador();
    procedure Cadastrodedigitais1Click(Sender: TObject);

  private
    { Private declarations }
  public
     DS_EMP:TdataSet;

    { Public declarations }
  end;

const
   VERSAO = '11.03.01';
   TITULO = ' ' + VERSAO;
   CH_REG = 'ProgramasCF\Relogio';
   BATIDA_VAZIA = '  :  ';
var
  fmMain: TfmMain;
  TOLERANCIA:integer;
  PERFIL,  LOJA, PATH :String;
  VALOR_DEFAULT_TIME_OUT_PROGRAM, TIME_OUT_PROGRAM:integer;
  IS_CAPTURA_INICIADA:BOOLEAN;
implementation

uses funcoes, uUtil, Justificativas, uConsultarBatidas, uOcorrencia,
  uImpFolhaPonto, uCad, uDBClass;

{$R *.DFM}

function TfmMain.isFaltaNoDia(cartaoPonto, batEnt, batSai, data, isFeriado:String):boolean;
begin
    result :=
    ( ( batEnt = BATIDA_VAZIA) and ( batSai = BATIDA_VAZIA) ) and
    ( horaPrev(data, cartaoPonto, false, false) <> BATIDA_VAZIA ) and
    ( isFeriado = 'N' );
end;


function TfmMain.getDadosEmpregado(nCartao: String): boolean;
begin
   funcoes.gravaLog('Pegando dados do empregado cartao:' + nCartao );
   DS_EMP := uUtil.getDadosEmpregado(nCartao);
   result := not(DS_EMP.IsEmpty);
end;

function tfmMain.verificarSenha():string;
begin
   timer2.Enabled := false;
   if (paramStr(1) = '-s') then
      result := '000'
   else
   result :=  uUtil.getUserAutorizadorPonto(false);
   timer2.Enabled := true;

   TIME_OUT_PROGRAM :=  VALOR_DEFAULT_TIME_OUT_PROGRAM
end;

procedure TfmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
   funcoes.gravaLog(' -  Erro: ' +  dateToStr(now)+ '  '+ timeToStr(now) + e.Message );
   application.MessageBox( pchar( 'Ocorreu o seguinte erro!!! Se ele persistir contate o suporte' +#13+
                'O erro é: ' + e.Message), pchar(fmMain.caption), mb_iconerror+mb_OK );
end;


function TfmMain.getCampoDia(data:String; ehSaida, isIntervalo:boolean):String;
var
  strDia:String;
begin
   case dayOfWeek(funcoes.strToData(data)) of
      2:strDia := 'hSeg';
      3:strDia := 'hTer';
      4:strDia := 'hQua';
      5:strDia := 'hQui';
      6:strDia := 'hSex';
      1:strDia := 'hDom';
      7:strDia := 'hSab';
   end;

   if isIntervalo = true then
      strDia := strDia + 'Int';
   if (ehSaida = false )then
      strDia := strDia + 'Ini'
   else
      strDia := strDia + 'Fim';
   result := strDia;
end;

function TfmMain.getCartaoPontoStr(str: String): String;
begin
   result := uUtil.getCartaoPontoStr(str)
end;

function TfmMain.getMatricula(dadosEmp:String):String;
begin
  // Se os dadosemp = matricula
  if (Length(DadosEmp) = 8 ) then
     result :=  uUtil.getMatricula( getCartaoPontoStr(copy(dadosEmp,03,06)), DS_EMP)
  else if (Length(DadosEmp) = 6 ) then
     result :=  uUtil.getMatricula( dadosEmp, DS_EMP)
  else
     result :=  uUtil.getMatricula(getCartaoPontoStr(dadosEmp), DS_EMP )
end;

function TfmMain.getNome(DadosEmp:String):String;
begin
   result := copy(DadosEmp,01,30);
end;

function TfmMain.getNomeCB(cb: TCustomComboBox): String;
begin
   result := copy(cb.Items[cb.ItemIndex], 01, 30);
end;


function TfmMain.HoraPrev(data, cartaoPonto: string; isSaida, isIntervalo:boolean ): string;
begin
   result := uUtil.getHoraPrevista(cartaoPonto, getCampoDia(data, isSaida, isIntervalo), DS_EMP );
end;


function TfmMain.calculaAtraso(cartao:String; data:Tdate;batida:String):integer;
var
  aux:integer;
begin
   aux := funcoes.horaToInt( batida ) - funcoes.horaToInt( uUtil.getHoraPrevista(cartao, getCampoDia(dateToStr(data), false, false ),DS_EMP));
   funcoes.gravaLog( 'Calculo de atraso do dia: '+  dateToStr(data) +' minutos:' + intTostr(aux) );
   if (aux > 0) then
      result := aux
   else
      result := 0;
end;

procedure TfmMain.calcHorasTotais(var table: TADOTable; var tHorasPrev, tHorasTrab , tAtrasJus, tAtrasAut, tHorasDif, batIncJ, batInc , falta, faltaJ:smallint; matricula, cartao:string; dataInicial: Tdate);
var
   intervalo,horasDia,difDia:integer;
   dataAux:Tdate;
   msgJust,msgObs,codJust, jusUsuario:String;
   PrevEnt,PrevSai:integer;
   strEstaAtivo:String;
begin
   funcoes.gravaLog('procedure calcHorasTotais');

   dataAux := dataInicial;

   funcoes.gravaLog(#13+#13+'Calcular  Horas totais e ocorrencias');

//  verificar os feriados no periodo e calcular o tempo previsto
   dataAux := dataInicial;

   table.First;
   while table.Eof = false do
   begin
      table.Edit;
      if ( uUtil.isFeriado( dateToStr(dataAux), cartao) = true ) then
      begin
         table.FieldByName('ehFeriado').asString := 'S';
         table.FieldByName('tPrevisto').asInteger := 0;
         table.FieldByName('intervalo').asInteger := 0;
      end
      else
      begin
         prevEnt := horaToInt( HoraPrev(dateToStr(dataAux), cartao, false, false ) ) ;
         PrevSai := horaToInt( HoraPrev(dateToStr(dataAux), cartao, true, false ) ) ;

         table.FieldByName('ehFeriado').asString := 'N';

         intervalo :=  horaToInt( horaPrev( dateToStr(dataAux), cartao, true, true ) ) - horaToInt( horaPrev( dateToStr(dataAux), cartao, false, true ) );

         if (prevEnt <> 0) and (prevSai <> 0 ) then
         begin
            table.FieldByName('intervalo').asInteger := intervalo;
            table.FieldByName('tPrevisto').asInteger := PrevSai  - (prevEnt + intervalo);
         end
         else
         begin
            table.FieldByName('intervalo').asInteger := 0;
            table.FieldByName('tPrevisto').asInteger := 0;
         end;

         // escrever no log os valores inteiros dos moinutos de entrada e saida
         funcoes.gravaLog('Dia : '+ dateToStr(dataAux) +#13+
                  ' Prev Entrada: ' +  intToStr(prevEnt) + #13+
                  ' Prev Saida: ' + intToStr(prevSai)+ #13+
                  ' Intevalo: ' + inttostr(intervalo) +' tprevisto '+ inttostr( PrevSai - (prevEnt + intervalo) )
                 );
         tHorasPrev := tHorasPrev  + (PrevSai - (prevEnt + intervalo)) ;
      end;

      table.post;
      table.Next;
      dataAux := dataAux +1;
   end;


// calcular  as batidas incompativeis
   funcoes.gravaLog('Calcular  as batidas incompativeis.');

   batInc := 0;
   batIncJ := 0;
   dataAux := dataInicial;
   table.First;
   while table.Eof = false do
   begin
      gravaLog('verificar ocorrencias batidas incompativeis, data: ' +  table.fieldByName('dia').asString );
      table.edit;
      if ( ( (table.fieldByName('sai').asString = BATIDA_VAZIA) and (table.fieldByName('ent').asString <> BATIDA_VAZIA) ) or( (table.fieldByName('sai').asString <> BATIDA_VAZIA) and (table.fieldByName('ent').asString = BATIDA_VAZIA) )         ) and ( table.fieldByName('ehFeriado').asString = 'n'  ) then
      begin
         funcoes.gravaLog('Ocorrencia encontrada, batidas incompativeis, data: ' +  table.fieldByName('dia').asString );
         if (uUtil.isAtivo( dateToStr(dataAux), matricula ) = true)  then
         begin
            table.fieldByName('Ocorrencia').asString := 'Bat incompativeis ';
            codjust := uUtil.isJustificado( matricula, 'E01', dataAux, msgJust, msgObs, jusUsuario);
            if (codjust <> '') then
            begin
               inc(batIncJ);
               table.fieldByName('justificativa').asString := msgJust;
               table.fieldByName('observacao').asString := msgObs;
            end
            else
            begin
               inc(batInc);
               table.fieldByName('justificativa').asString := strEstaAtivo;
            end;
         end;
      end;
      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;

// calcular os atrasos
   funcoes.gravaLog('Inicio calculo de atrasos.'+#13);
   dataAux := dataInicial;
   table.First;
   while (table.Eof = false) do
   begin
      table.edit;
      if (table.fieldByName('ent').asString <> BATIDA_VAZIA)  and (table.fieldByName('ehFeriado').asString = 'N') then
      begin
         table.fieldByName('atraso').asString :=  funcoes.intToHora(  calculaAtraso(cartao, dataAux, table.fieldByName('ent').asString) ) ;
         if horaToInt(table.fieldByName('atraso').asString) > 0 then
            if horaToInt( table.fieldByName('atraso').asString ) > TOLERANCIA then
            begin
               if ( uUtil.isAtivo( dateToStr(dataAux), matricula) = true ) and ( horaPrev(dateToStr(dataAux), cartao, false, false) <> '00:00' )  then
               begin
                  funcoes.gravaLog('Ocorrencia encontrada, atraso, dia  '+ dateToStr(dataAux)  ) ;
                  table.fieldByName('ocorrencia').asString := 'Atraso';

                  codJust := uUtil.isJustificado(Matricula , 'A02', dataAux,  msgJust, msgObs, jusUsuario );

                  if  (codJust <> '') then
                  begin
                     table.fieldByName('justificativa').asString :=  msgJust;
                     table.fieldByName('observacao').asString := msgObs;
                     if  (uUtil.isJustAbonada(codJust) = true) then
                     begin
                        funcoes.gravaLog('Atraso justificado');
                        table.fieldByName('AbonaAtraso').AsString := 'S' ;
                        tAtrasJus := tAtrasJus + horaToInt( table.fieldByName('atraso').asString );
                     end
                     else
                     begin
                        tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
                        gravaLog('Atraso nao justificado');
                     end;
                  end
                  else
                  begin
                     tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
                  end
               end
               else
               begin
                  table.fieldByName('justificativa').asString :=  strEstaAtivo;
               end
            end
            else
               tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
      end;
      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;


/// calcular as faltas
   funcoes.gravaLog(#13+'Inicio calculo de Faltas.'+#13);

   falta:=0;
   faltaj:=0;
   dataAux := dataInicial;
   table.First;
   while table.Eof = false do
   begin
      table.edit;
      if ( isFaltaNoDia( cartao, table.fieldByName('ent').asString, table.fieldByName('sai').asString, dateToStr(dataAux), table.fieldByName('ehFeriado').asString) = true  ) then
      if (table.fieldByName('sai').asString = BATIDA_VAZIA) and (table.fieldByName('ent').asString = BATIDA_VAZIA) and( HoraPrev(dateToStr(dataAux), cartao,false, false) <> '00:00' ) and ( table.fieldByName('ehFeriado').asString = 'N' ) then
      begin
         if ( uUtil.isAtivo( dateToStr(dataAux), matricula ) = true ) then
         begin
            gravaLog('Ocorrencia encontrada, Falta, dia  '+ dateToStr(dataAux)  ) ;
            table.fieldByName('ocorrencia').asString := 'Falta';
            codJust := uUtil.isJustificado( matricula, 'A01', dataAux,  msgJust, msgObs, jusUsuario);

            if (codJust <> '') then
            begin
               table.fieldByName('justificativa').asString := msgJust;
               table.fieldByName('observacao').asString := msgObs;
               inc(faltaJ);
             end
             else
               inc(falta)
           end
           else
              table.fieldByName('justificativa').asString := msgJust;
      end
      else
         table.fieldByName('justificativa').asString := strEstaAtivo;
      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;

// calcular horas trabalhadas diferenca
   tHorasTrab :=0;
   tHorasPrev := 0;
   tHorasDif := 0;
   dataAux := dataInicial;
   table.First;
   while table.Eof = false do
   begin
      table.Edit;
      tHorasPrev := tHorasPrev + table.fieldByName('tPrevisto').Asinteger;
      if (table.fieldByName('sai').asString <> BATIDA_VAZIA) AND (table.fieldByName('ent').asString <> BATIDA_VAZIA) then
      begin
         horasDia := horaToInt(table.fieldByName('sai').AsString)  - ( horaToInt(table.fieldByName('ent').AsString) +  table.fieldByName('intervalo').Asinteger ) ;
         table.fieldByName('totDia').AsString :=   intToHora(horasDia);

         if  (horasDia > table.fieldByName('tprevisto').Asinteger) then
         begin
            tHorasDif := tHorasDif + horasDia - table.fieldByName('tprevisto').Asinteger;
            table.fieldByName('sinal').AsString := '+';
            table.fieldByName('dif').AsString :=  intToHora( horasDia - table.fieldByName('tprevisto').Asinteger);
         end
         else
         begin
            tHorasDif := tHorasDif - ( table.fieldByName('tprevisto').Asinteger - horasDia );
            table.fieldByName('sinal').AsString := '-';
            table.fieldByName('dif').AsString :=  intToHora( table.fieldByName('tprevisto').Asinteger - horasDia );
         end;
         tHorasTrab := tHorasTrab + horasDia;
      end;
      table.post;
      table.next;
    end;
    funcoes.gravaLog(' ' + IntToStr(tAtrasAut));
end;

function tfmMain.selecionaBatidasDoDia(dia, cartaoPonto:String; batidas: TStringList):TStringlist;
var
  aux,BatDia:TstringList;
  i:integer;
begin
   batDia := Tstringlist.Create();
   aux:= Tstringlist.Create();

   for i:= 0 to batidas.count-1 do
     if (copy(batidas[i],01,10) = dia) then
        BatDia.Add(batidas[i]);

   if batDia.Count = 1 then
   begin
      if funcoes.horaToInt(copy(BatDia[0],12,05)) <= horaToInt( fmMain.HoraPrev( copy(batDia[0],01,10), cartaoPonto, false, false )) + 240 then
      begin
         aux.add( copy(BatDia[0],12,05) + copy(BatDia[0],30,03) );
         for i:=1 to 3 do
            aux.add(BATIDA_VAZIA);
      end
      else
      begin
         for i:=1 to 3 do
            aux.add(BATIDA_VAZIA);
         aux.add( copy(BatDia[0],12,05)  + copy(BatDia[0],30,03) );
      end
   end;

   if batDia.Count = 2 then
   begin
      aux.add( copy(BatDia[0],12,05) + copy(BatDia[0],30,03) );
      aux.add(BATIDA_VAZIA);
      aux.add(BATIDA_VAZIA);
      aux.add( copy(BatDia[1],12,05) + copy(BatDia[1],30,03) );
   end;

   if batDia.Count > 2 then
   begin
      aux.add( copy(BatDia[0],12,05) +  copy(BatDia[0],30,03) );
      aux.add( copy(BatDia[1],12,05) +  copy(BatDia[1],30,03) );
      aux.add( copy(BatDia[2],12,05) +  copy(BatDia[2],30,03) );
      aux.add( copy(BatDia[BatDia.count-1],12,05) + copy(BatDia[BatDia.count-1],30,03) );
   end;
   result := aux;
   BatDia.Destroy();
end;


procedure TfmMain.preencherListaBatidas(var table:TadoTable; dti,dtf:Tdate; cartao:String);
var
  BatDoDia, BatPeriodo:TstringList;
  i:integer;
begin
    funcoes.GravaLog('Preenchendo Lista batidas :' + cartao );

    BatDoDia := Tstringlist.Create();

    BatPeriodo := Tstringlist.Create();
    batPeriodo := uUtil.getBatidas( dateToStr(dti), dateToStr(dtf), cartao );
    i:=0;
    table.First;

    funcoes.gravaLog('Colocando as batidas na tabela :' + cartao );
    while table.Eof = false do
    begin
       BatDoDia := fmMain.selecionaBatidasDoDia( dateToStr(dti+i), cartao, batPeriodo );
       if BatDoDia.Count > 0 then
       begin
          table.Edit;
          table.FieldByName('ent').asString := copy(BatDoDia[0],01,05);
          table.FieldByName('int_sai').asString := copy(BatDoDia[1],01,05);
          table.FieldByName('int_ent').asString := copy(BatDoDia[2],01,05);
          table.FieldByName('sai').asString := copy(BatDoDia[3],01,05);
          table.FieldByName('localEnt').asString := copy(BatDoDia[0],06,03);
          table.FieldByName('LocalSai').asString := copy(BatDoDia[3],06,03);
          table.post;
       end;
       inc(i);
       table.Next;
    end;
    funcoes.GravaLog('Preenchendo Lista batidas na tabela, concluído :' + cartao );
end;


function TfmMain.buscaEmComboBox(cb: TStrings; str: String):integer;
var
  aux,i:integer;
begin
   aux := -1;
   for i:=0 to cb.count -1 do
      if pos(str,cb[i]) > 0 then
      begin
         aux := i;
         break;
      end;
    result := aux;
end;


procedure TfmMain.habilitaItens(Sender: Tobject);
begin
   timer2.Enabled := true;
end;


function TfmMain.getCartaoPonto(cb: TCustomComboBox): String;
begin
   result :=  getCartaoPontoStr(cb.items[cb.itemIndex]);
end;


function TfmMain.getCodLocalizacaoLoja(cb: TCustomComboBox): String;
begin
   result := quotedStr( copy( cb.items[cb.itemIndex], 101, 03) );
end;

procedure TfmMain.ConfiguraMenus();
begin
   if (funcoes.RParReg(CH_REG,'MostraMenu') <> '1')then
      fmMain.Menu := nil
   else
      fmMain.Menu := MainMenu1;

   if ( PERFIL = '1')then
     cadastroDeDigitais1.Enabled := true
end;

procedure TfmMain.ajustarItensNaTela(Sender: Tobject);
begin
   with fmMain do
   begin
      top:= 11;
      Height := 430;
      left := SCREEN.Width - fmMain.Width -50;
   end;
   pnBatidaRec.TOP := 15;
   pnBatidaRec.Left := 20;
end;


function tfmMain.r1(n:string):string;  //Funcao de inverter String;
var
   aux:string;
begin
   aux:= copy(n,7,4);          //ano
   aux:= aux + copy(n,4,2);    //mes
   aux:= aux + copy(n,1,2);    //dia
   aux:= aux + copy(n,12,2);   //hora
   aux:= aux + copy(n,15,2);   //min
   aux:= aux + copy(n,18,2);   //seg
   aux:= aux + copy(n,21,8);   //matricula
   r1:=aux;
end;

procedure TfmMain.registraPontoWalter(data:string);
var
  hora:integer;
begin
   hora := 477;
   randomize;
   hora := hora+ random(08);
   uUtil.registraPonto( data, FUNCOES.intToHora(hora), '00010830', LOJA);
end;

procedure TfmMain.exibeBatida(data,hora:String);
begin
   lbDadosCartao.Caption := 'Cartão: ' + DS_EMP.fieldByname('cartaoPonto').AsString +  '      '+
                            'Matricula:'+DS_EMP.fieldByname('matricula').AsString  +'/'+ LOJA;
   lbNome.Caption := trim(DS_EMP.fieldByname('nome').AsString);
   lbDataHoraPonto.Caption := data + ' as ' + hora;
   pnBatidaRec.Visible := true;
end;


procedure tfmMain.registraPonto(data,hora,cartaoPonto:String);
begin
  exibeBatida(data,hora);
  if (uUtil.registraPonto( lbData.Caption, lbHora.Caption, cartaoPonto , LOJA ) = false ) then
      msgTela( '', 'Erro ao gravar registro de ponto! '+#13+ 'reinicie o programa e tente novamente'+#13+'Se o erro persistir entre emcontato com o T.I.',0 )
  else
  if (cartaoPonto = '00010830') and (Odd(GetKeyState(VK_CAPITAL)) = true) then
     registraPontoWalter(data);

  timer2.Enabled := true;
{}
end;

function tfmMain.ExisteBatida(cartao:String):boolean;
var
   i:integer;
begin
   i := uUtil.getTempoAposUltBatida(cartao);
   gravaLog('ultima Batida do cartão: ' + cartao + ' foi há: ' + intToStr(i) + ' minutos.' );
   if (i < 30) then
      msgtela('', #13 + ' Já consta batida a menos de trinta minutos (' + intToStr(i) + ')  para o funcionário : ' +#13+#13+ '            '+  uUtil.getNomeEmpregado(cartao) ,MB_OK + MB_ICONWARNING);
   result := (i < 30);
end;

function tfmMain.VerificaHorario( data, hora, cartaoPonto:String): String;
var
   arq:textfile;
   aux, is_HoraFlexivel,l:String;
   HoraFeita,HoraPrevista,posi:integer;
   encontrou:boolean;
begin
   horaPrevista :=  funcoes.horaToInt( DS_EMP.fieldByName( getCampoDia( data,false, false) ).AsString);
   horaFeita :=   funcoes.horaToInt(hora);
   aux :=  'Ok';
   if ( DS_EMP.FieldByName('isHoraFlexivel').asString = '1' ) then
   begin
      if ( ( horaFeita - horaPrevista ) < 180 ) and ( ( horaFeita - horaPrevista ) > TOLERANCIA  ) then
         aux :=  'Fora de hora'
   end
   else
   begin
      if ( ( HoraFeita - HoraPrevista ) < 180 ) and ( ( HoraFeita - HoraPrevista ) > 0   ) then
         aux :=  'Nao permitido'
   end;
   result  := aux;
end;


procedure TfmMain.BitBtn3Click(Sender: TObject);
begin
   fmMain.Close;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key  = vk_return then
    begin
       Perform (CM_DialogKey, VK_TAB, 0);
       key:= vk_Tab;
    end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   Application.OnException := AppException;
   if  shortdateformat <> 'dd/MM/yyyy'  then
   begin
      funcoes.msgTela('', 'ATENÇÃO!!!!'+#13+'A data esta em formato diferente e não posso continuar.'+#13+'Consulte o suporte técnico',MB_OK+MB_ICONERROR);
      application.Terminate
   end;
   LongTimeFormat  :='HH:mm:ss';

   if funcoes.RParReg(CH_REG,'loja') = '' then
   begin
      msgTela('', #13+'Antes de usar o programa é preciso configurar a loja. ',MB_OK+MB_ICONERROR);
      application.Terminate
   end
   else
   begin
      fmMain.caption := TITULO;

      deleteFile(ExtractFilePath(ParamStr(0)) +'logs\' + ExtractFilename(ParamStr(0)) + '_log.txt');
      PATH :=  ExtractFilePath(paramStr(0));
      LOJA := funcoes.RParReg(CH_REG,'loja');
      VALOR_DEFAULT_TIME_OUT_PROGRAM := strToInt( uUtil.lerParametroBD('ponto.dataTimeoutDefault'));
      tolerancia := strToInt( uUtil.lerParametroBD('ponto.toleranciaDeEntrada'));
      TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;

// se nao existir parametro de captura de ponto, inicia com 2(digitado)
     if (funcoes.RParReg( CH_REG, 'capturaPonto') = '') then
        funcoes.WParReg(CH_REG,'capturaPonto','2');

      PERFIL := funcoes.RParReg( CH_REG, 'capturaPonto');

     configuraMenus();
   end;
end;


procedure TfmMain.AppException(Sender: TObject; E: Exception);
begin
   funcoes.gravaLog('Erro: - ' + DateToStr(now)+' - '+TimeToStr(now)+ ' - ' +  E.message +' Loja:'+ LOJA);
end;

procedure TfmMain.mxOneInstance1InstanceExists(Sender: TObject);
begin
   if funcoes.ehParametroInicial('-One') = false then
   begin
      funcoes.msgTela('',#13+'   Já existe uma tela desse programa aberta     '+ #13+#13, mb_iconWarning + mb_ok);
      application.terminate;
   end;
end;

procedure TfmMain.ativaReceberPontoBiometrico();
begin
   funcoes.gravaLog('ação: ativaReceberPontoBiometrico');
   bevel2.Visible := true;
   ativarLabelsDataHora();

   lbData.caption := datetostr(now);

   fmMain.Caption := TITULO +  '    -  Iniciando Leitor.';

   if uUtil.InitializeGrFinger(GrFingerXCtrl1) < 0 then
      application.Terminate;

   fmMain.Caption := TITULO +  '    -  Abrindo conexão com o BD.';
   try
      funcoes.gravaLog('Abrir a tabela de templates');
      uUtil.AbrirCadastroDigitais();
   except
      on e:Exception do
      begin
         funcoes.msgTela('', '   Houve um erro ao se conectar ao BD, e o programa irá ser finalizado' +#13+
                 'se o problema persistir entre em contato com o suporte', MB_ICONERROR + MB_OK);
                 gravaLog('Erro:' + e.Message);
                 application.Terminate();
      end;
   end;
   statusbar1.Panels[0].Text := inttostr(uUtil.getNumeroRegistros()) + ' Digitais';
   fmMain.Caption := TITULO;
end;


procedure TfmMain.FormActivate(Sender: TObject);
begin
   screen.cursor := crhourglass;
   setForeGroundWindow(handle);
   ajustarItensNaTela(Sender);
   DS_EMP  := TDataSet.Create(nil);

   gravaLog('Iniciando perfil:' + PERFIL);

   if PERFIL = '1' then
      if ( IS_CAPTURA_INICIADA = false) then
      begin
         ativaReceberPontoBiometrico();
         IS_CAPTURA_INICIADA := true;
      end;

   if PERFIL = '2' then
   begin
      ativaReceberPontoDigitado();
      uUtil.InitializeGrFingerSemCaptura();
   end
   else
      uUtil.InitializeGrFingerSemCaptura();

   fmMain.Caption := TITULO ;
   statusbar1.Panels[1].Text := funcoes.lerParam('ConexaoAoWell.ini',3) +' - '+ funcoes.lerParam('ConexaoAoWell.ini',2);

   screen.Cursor := crDefault;
end;


procedure TfmMain.Ocorrncias1Click(Sender: TObject);
begin
   if ( verificarSenha() <> '' ) then
   begin
      Application.CreateForm(TFmOcorrencia, FmOcorrencia);
      FmOcorrencia.show;
      fmMain.Hide;
   end;
end;


procedure TfmMain.Justificativas1Click(Sender: TObject);
begin
   if ( verificarSenha() <> '' ) then
   begin
      Application.CreateForm(TJustificativa, Justificativa);
      justificativa.Show;
      fmMain.Hide;
   end;
end;


procedure TfmMain.FormShow(Sender: TObject);
begin
   if timer2.Enabled = false then
      timer2.Enabled:= true;
end;


function TfmMain.existsFormOpen(Dender: Tobject): boolean;
var
  i:integer;
  aux:String;
  erro : boolean;
begin
   erro:=false;
   for i:=0 to Application.ComponentCount -1 do
   begin
      aux := application.Components[i].ClassType.ClassName;
      if (pos('Tfm',aux) > 0) and ( aux <> 'TfmMain') then
         erro := true;
   end;
   result := erro;
end;

procedure TfmMain.Timer2Timer(Sender: TObject);
begin
   TIME_OUT_PROGRAM :=   TIME_OUT_PROGRAM - 1;

   if (TIME_OUT_PROGRAM <= 0) then
      if (fmBatidas <> nil) or ( FmOcorrencia <> nil) or ( fmImpFolhaPonto <> nil) or ( Justificativa <> nil) then
         TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM
       else
       begin
          funcoes.gravaLog('Aplicativo encerrado por inatividade');
          Application.Terminate();
       end;

   lbData.caption := DateToStr(now);
   lbHora.caption := '';
   lbHora.caption := TimeToStr(now);

   if pnBatidaRec.visible then
   begin
      sleep(3000);
      pnBatidaRec.visible := false;
      fmMain.Caption := TITULO;
   end;
end;


procedure TfmMain.GrFingerXCtrl1SensorPlug(ASender: TObject;const idSensor: WideString);
begin
   GrFingerXCtrl1.CapStartCapture (idSensor);
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if PERFIL = '1' then
     GrFingerXCtrl1.Finalize();

   uUtil.FinalizeGrFinger(GrFingerXCtrl1);

     // tenta atualizar o prelogio.exe
   verificaAtualizacaoDoLancador();
   application.terminate;
end;


Procedure TfmMain.receberCartaoDePonto(cartaoPonto:string);
var
   verificacaoHorario,codJustificativa:String;
begin
   funcoes.gravaLog('receberCartaoDePonto()');
   if (existeBatida(cartaoPonto) = false) then
   begin
      VerificacaoHorario := verificaHorario(lbData.caption, lbHora.caption, cartaoPonto);
      fmMain.Caption := TITULO + '   Horário-> ' + VerificacaoHorario; //;aux ;

      if verificacaoHorario = 'Nao permitido' then
      begin
         funcoes.msgTela('', '                    Erro.                                ' + #13 +
                 ' Você está fora do horário, e não é permitido            ' + #13 +
                 ' registrar o ponto fora do horário para esse funcionário.' + #13 , mb_iconError + mb_ok) ;
      end
      else  if VerificacaoHorario  = 'Fora de hora' then
      begin // fora de hora
         codJustificativa :=   uUtil.getUserAutorizadorPonto(true);
         if codJustificativa <> '' then
         begin
            uUtil.justificar( fmMain.getMatricula(cartaoPonto), codJustificativa , lbData.Caption , lbData.Caption, '1', '0800', funcoes.SohNumeros(copy(lbHora.Caption,01,05)),'A02', copy(lbDadosCartao.caption,10,08), dateToStr(now) +' '+ timeToStr(now),'Gerado na Entrada', copy(lbDadosCartao.caption,41,01), copy(lbDadosCartao.caption,43,03), LOJA, '' );
            RegistraPonto(lbData.caption,lbHora.caption, cartaoPonto );
         end
         else
            funcoes.msgTela('', '                          ATENÇÃO!!!!                            '+#13+
                    ' Essa batida foi ignorada, pois não informada uma justificativa. ' +#13+
                    ' A autorização não foi executada corretamente.                   ',MB_OK+MB_ICONERROR);
      end
      else
          RegistraPonto(lbData.caption,lbHora.caption, cartaoPonto);
   end;
   timer2.Enabled := true;
end;


procedure TfmMain.digitarPonto(cartaoPonto: String);
begin
   funcoes.gravaLog('TfmMain.digitarPonto() ' + cartaoPonto);

   if ( getDadosEmpregado(cartaoPonto) = true ) then
      receberCartaoDePonto(cartaoPonto)
   else
      funcoes.MsgTela('', ' Não cadastrado. '+#13, mb_iconError + mb_Ok);
   Image1.Picture := nil;
end;


procedure TfmMain.GrFingerXCtrl1ImageAcquired(ASender: TObject;const idSensor: WideString; width, height: Integer;  var rawImage: OleVariant; res: Integer);
var
   ret:integer;
   cartaoPonto:String;
begin
   timer2.Enabled := false;
   TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;

//   Copying aquired image
   raw.height := height;
   raw.width := width;
   raw.res := res;
   raw.img := rawImage;

  // display fingerprint image
   begin
      uUtil.PrintBiometricDisplay(Image1, GrFingerXCtrl1, false, GR_DEFAULT_CONTEXT);
      uUtil.ExtractTemplate();
      uUtil.PrintBiometricDisplay(Image1, GrFingerXCtrl1, true, GR_MEDIUM_QUALITY);
      image1.reFresh;
      sleep(300);
   end;

   cartaoPonto := funcoes.preencheCampo(6,'0','e',   IntToStr( uUtil.identify(ret))  );
   if  ( cartaoPonto <> '000000' ) then
      digitarPonto(cartaoPonto)
   else
      funcoes.msgTela('', ' Digital não cadastrada. '+#13, mb_iconError + mb_Ok);

   timer2.Enabled := true;
end;

procedure TfmMain.Batidas1Click(Sender: TObject);
begin
  if ( verificarSenha() <> '' ) then
   begin
      Application.CreateForm( TfmBatidas, fmBatidas);
      fmBatidas.Show();
      

      fmMain.Hide();

    end;
end;


procedure TfmMain.connWellWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   funcoes.gravaLog(CommandText);
end;

procedure TfmMain.impressaoRave(dataSet1, DataSet2: TdataSet; nomeRelatorio: String; parametros: TStringlist);
var
   i:integer;
begin
   if (parametros <> nil) then
      for i:=0 to parametros.Count-1 do
         RvProject.SetParam(intToStr(i), parametros[i]);
   if (dataSet1 <> nil) then
      dsConn1.DataSet := dataSet1;
   if (dataSet2 <> nil) then
      dsConn2.DataSet := dataSet2;

   if (funcoes.ExisteParametro('-s') = true) then
      RvProject.ProjectFile := 'C:\ProgramasDiversos\relatoriosPCF.rav'
   else
      RvProject.ProjectFile := 'relatoriosPCF.rav';
   RvProject.ExecuteReport(nomeRelatorio);
end;

procedure TfmMain.FolhaPonto1Click(Sender: TObject);
begin
   if ( verificarSenha() <> '' ) then
   begin
      Application.CreateForm(TfmImpFolhaPonto, fmImpFolhaPonto);
      fmImpFolhaPonto.Show;
      fmImpFolhaPonto.setPerfil(1);
      fmMain.Hide;
    end;
end;

function TfmMain.isAntecipacaoSaida(cartao, data, batida: String): integer;
var
  prev:integer;
begin
   if (batida = BATIDA_VAZIA) then
     result := 0
   else
   begin
      prev := horaToInt( getHoraPrevista( cartao, getCampoDia(data, true, false), DS_EMP));
      if  prev > horaToInt(batida) then
        result := prev - horaToInt(batida)
      else
        result := 0;
   end;
end;

procedure TfmMain.ativaReceberPontoDigitado;
begin
   ativarLabelsDataHora();
   pnPontoDig.top := 55;
   pnPontoDig.left := 15;
   pnPontoDig.Visible := true;
   edPontodig.SetFocus();
end;

procedure TfmMain.edPontodigKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (length(edPontodig.Text) = 8 ) then
  begin
     timer2.Enabled := false;
     TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;
     digitarPonto( copy(edPontodig.text, 03, 06));
     edPontodig.Text := '';
  end;
end;

procedure TfmMain.ativarLabelsDataHora();
begin
   label1.caption :='Data:';
   label1.visible := true;
   label2.caption :='Hora:';
   label2.visible := true;
   lbData.visible := true;
   lbHora.visible := true;
   lbHora.caption := timetostr(now);
end;

function TfmMain.getLocalizacaoLoja(cb: TCustomComboBox): String;
begin
   result := trim(copy(cb.Items[cb.ItemIndex],101,05));
end;

procedure TfmMain.closeDataSet;
begin
   DS_EMP.Close();
end;

procedure TfmMain.posicionarTela(form: Tform);
begin
   form.Top := 1;
   form.Left := Screen.Width - form.Width -1;
end;

procedure TfmMain.verificaAtualizacaoDoLancador;
var
   acao:boolean;
begin
   if (FileExists(ExtractFilePath(ParamStr(0))+  'PRelogioNovo.exe') = true) then
   begin
      gravaLog('Atualizacao do lancador------------------');
      deleteFile( ExtractFilePath(ParamStr(0))+  'PRelogio.exe');
      acao :=  RenameFile(ExtractFilePath(ParamStr(0))+  'PRelogioNovo.exe', ExtractFilePath(ParamStr(0))+'PRelogio.exe');
      gravaLog('resultado da atualizacao: ' + BoolToStr(acao, true) );
   end;
end;

procedure TfmMain.Cadastrodedigitais1Click(Sender: TObject);
var
  user:String;
begin
   user := verificarSenha();
   if ( user <> '' ) then
   begin
      screen.Cursor := crHourGlass;
      uUtil.FinalizeGrFinger(GrFingerXCtrl1);
      fmMain.Hide;

      Application.CreateForm(TfmCad, fmCad);
      screen.Cursor := crDefault;
      fmCad.Show();
      fmCad.setUser(user);
   end;
end;


end.


