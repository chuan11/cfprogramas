unit Justificativas;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, Db, DBTables, ADODB, DBCtrls, Grids,  DBGrids, ComCtrls,
  funcoes, funcDatas, Spin, fCtrls;
type
  TJustificativa = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn2: TBitBtn;
    edHoraFim: TMaskEdit;
    edHoraInicio: TMaskEdit;
    cbOcorrencia: TComboBox;
    cbJust: TComboBox;
    btGerajustificativa: TBitBtn;
    btCancela: TBitBtn;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label9: TLabel;
    DBGrid1: TDBGrid;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    edBusca: TEdit;
    edMesAno: TMaskEdit;
    Label11: TLabel;
    qrJustificativas: TADOQuery;
    dsJustificativas: TDataSource;
    dtp2: TDateTimePicker;
    DTP1: TDateTimePicker;
    sg1: TStringGrid;
    Label2: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    cbLojas: TComboBox;
    cbEmp: TComboBox;
    SpinButton1: TSpinButton;
    dtRefFolga: TDateTimePicker;
    lbRefFolga: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure RGroup1Click(Sender: TObject);
    procedure btGerajustificativaClick(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Consulta();
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn9Click(Sender: TObject);
    procedure cbOcorrenciaChange(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure edBuscaEnter(Sender: TObject);
    procedure dtp1Change(Sender: TObject);
    procedure Ajustasg1();
    procedure sg1DblClick(Sender: TObject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure limpaSg1(sender:TObject);
    function haErros(matricula, cartao, nome:String):boolean;
    procedure incluiFuncionario(matricula, nome:String);
    procedure cbLojasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure cbJustClick(Sender: TObject);
    function getCodJust():String;

  private
      linhasg1:integer;

  public
    { Public declarations }
  end;
var
   Justificativa :TJustificativa;
   COD_FOLGA:String;
implementation

uses RelogioPonto, uUtil;

{$R *.DFM}

function TJustificativa.getCodJust(): String;
begin
   result := copy(cbJust.items[cbJust.itemIndex], 01, 04);
end;

procedure TJustificativa.FormCreate(Sender: TObject);
begin
   fmMain.posicionarTela(Justificativa);
   cbLojas.Items :=  uUtil.getNomeLojasPonto(true, true);
   cbJust.Items := uUtil.getJustificativas();
   cbEmp.Items := uUtil.obterDadosFuncionarios('');
   edMesAno.Text := copy(dateToStr(now),04,07);
   COD_FOLGA := uUtil.lerParametroBD('ponto.CodJustFolga');
end;


procedure TJustificativa.limpaSg1(sender: TObject);
var
   i:integer;
   j:integer;
begin
   for i:=0 to sg1.RowCount - 1 do
      for j:= 0 to sg1.ColCount - 1 do
         sg1.Cells[j,i] := '';
  sg1.RowCount := 2;
  ajustasg1();
end;

procedure TJustificativa.ajustasg1();
var
   i:integer;
begin
   sg1.ColWidths[0] := 10;
   sg1.RowHeights[0]:= 15;
   sg1.Cells[00,0] := 'Matricula';
   sg1.Cells[01,0] := 'Nome';
   sg1.Cells[02,0] := 'Data';
   sg1.Cells[03,0] := '';
   sg1.Cells[04,0] := 'Tipo';
   sg1.Cells[05,0] := 'Hora';
   sg1.Cells[06,0] := '';
   sg1.Cells[07,0] := 'Ocorrencia';
   sg1.Cells[08,0] := 'Justificativa';
   sg1.Cells[10,0] := 'Observação';

   for i:=1 to sg1.RowCount -1 do
      sg1.RowHeights[i]  := 15;

   sg1.ColWidths[0] := 57;
   sg1.ColWidths[1] := 150;
   sg1.ColWidths[2] := 65;
   sg1.ColWidths[3] := 65;
   sg1.ColWidths[4] := 63;
   sg1.ColWidths[5] := 34;
   sg1.ColWidths[6] := 34;
   sg1.ColWidths[7] := 135;
   sg1.ColWidths[8] := 152;
   sg1.ColWidths[9] := -1;
   sg1.ColWidths[10] := 152;
   sg1.FixedRows := 1;
   sg1.ColWidths[11] := -1;
   sg1.ColWidths[12] := -1;

   edBusca.Enabled :=true;
   cbEmp.Enabled := true;
   cbEmp.itemindex := -1;
   edBusca.SetFocus;
end;

function ValorDaHora(Hora:String):integer;
begin
   ValordaHora := ( StrToInt(copy(hora,01,02)) * 60 ) + StrToInt(copy(hora,04,02))
end;

function TJustificativa.haErros(matricula, cartao, nome:String ):boolean;
var
   erro:String;
   i:integer;
begin
   erro := '';
   for i:= 1 to sg1.RowCount - 1 do
      if (copy(sg1.Cells[0,i],01,08) = matricula ) and
         (copy(sg1.Cells[7,i],01,03) = copy(cbOcorrencia.items[cbOcorrencia.itemindex],01,03) ) and
         (DateToStr(dtp1.date) = sg1.Cells[2,i])   then
            erro := erro + ' - Já existe justificativa desta ocorrência para este empregado neste período. '+#13+#13;

   if ( getCodJust() = COD_FOLGA) and ( dtp1.Date <> dtp2.Date ) then
      erro:= erro + ' - Só posso gerar justificativa de folga para períodos de 01 dia' +#13;


   if (COD_FOLGA = getCodJust()) then
      if (uUtil.isDiaBaseFolga(matricula, dtRefFolga.Date) = true) then
         erro:= erro + ' - Existe folga refenciada p/ ' +trim(nome)+ ' nesse dia.'  +#13;

   if (COD_FOLGA = getCodJust()) then
      if (uUtil.isHaveBatida(dtRefFolga.Date, fmMain.getCartaoPonto(cbEmp)) = false ) then
         erro:= erro + ' - Não existe registro no dia '+ dateToStr(dtRefFolga.date) +' referenciado p/ '  +copy(nome,01,20) +'...'  +#13;

   if CbLojas.ItemIndex <= 0 then
      if cbEmp.ItemIndex < 0 then
         erro:= erro + ' - Selecione um empregado' +#13;

   if (dtp1.Date) > (dtp2.date) then
      erro:= erro + ' - A data inical não pode ser menor que a data final.' +#13;

   if (dtp2.Date - dtp1.date) > 14  then
      erro:= erro + ' - O período da justificativa não pode ser maior do que 15 dias.' +#13;

   if cbOcorrencia.ItemIndex > 1 then
      if (edHoraFim.text = '  :  ' )or (edHoraInicio.text='  :  ' ) or ( EhhoraValida(edHoraInicio.text) = false)   or ( EhHoraValida(edHoraFim.text)=false) or ( valorDaHora ( edHoraInicio.text) > ValordaHora( edHoraFim.text) )then
         erro:= erro + ' - Preencha corretamente o intervalo do horario.' + #13 ;

   if ( cbOcorrencia.ItemIndex > 1 ) and ( (edHoraInicio.text = '  :  ') or (edHoraFim.text = '  :  ')) then
      erro:= erro + ' - Se a ocorrência é atraso ou antecipação da saida, então deve haver hora inicial e final'+#13;

   if cbOcorrencia.ItemIndex = -1 then
      erro:= erro + ' - Falta a ocorrência.'+ #13;
   if cbJust.ItemIndex = -1 then
      erro:= erro + ' - Falta a justificativa para essa ocorrência.'+ #13;

   if  length(edit2.text) < 10 then
      erro:= erro + ' - É preciso informar a observação.'+ #13;

   if (erro <> '' )then
   begin
      erro := '  Corrija antes o(s) seguinte(s) campo(s): '+#13+#13 + erro;
      msgTela('', erro, mb_iconError + mb_ok);
   end;
   result := (erro <> '');
end;

procedure TJustificativa.FormShow(Sender: TObject);
begin
   left := 1;
   pagecontrol1.Align:= alclient;
   dtp1.MaxDate := now + 30;
   dtp1.date := now;
   dtp2.MaxDate := now + 30;
   dtp2.date := now;
   edMesAno.text := copy(datetoStr(now),04,02) +'/'+ copy(datetoStr(now),07,04);

   PageControl1.ActivePageIndex := 0;
   Ajustasg1();
   edBusca.SetFocus;
end;

procedure TJustificativa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.Show;
   action := cafree;
   Justificativa := nil;
end;

procedure TJustificativa.RGroup1Click(Sender: TObject);
begin
   edHoraFim.visible := NOT(edHoraFim.visible);
   label4.visible := NOT(label4.visible);
   edHoraInicio.visible := NOT(edHoraInicio.visiblE);
   label8.visible := not(label8.visible);
end;

Function ValidaData(data:string):boolean;
begin
   ValidaData:=true;

   try
      StrToDate(data)
   except
      on e:exception do
         ValidaData := false;
   end;
end;

procedure TJustificativa.btGeraJustificativaClick(Sender: TObject);
var
   err:String;
   i:integer;
begin
  if  sg1.RowCount -1 > 1 then
  begin
     for i:=1 to sg1.RowCount -2 do
     begin
        err:= uUtil.Justificar( copy(sg1.Cells[0,i],01,08),  getCodJust(), sg1.Cells[2,i], sg1.Cells[3,i], copy(sg1.Cells[4,i],02,01), funcoes.SohNumeros(sg1.Cells[5,i])  , funcoes.SohNumeros(sg1.Cells[6,i]), copy(sg1.Cells[7,i],01,03), sg1.Cells[9,i], dateToStr(now) +' '+timetoStr(now) ,sg1.Cells[10,i], sg1.Cells[11,i], sg1.Cells[12,i], LOJA, sg1.Cells[13,i]  );
        if (err <> '0') then
           if (err = 'keyViolation') then
               msgTela('','Já consta uma justificativa para o funcionário: ' +#13+
                           copy(sg1.Cells[1,i],01,30) +#13+
                           'Dia: '+ sg1.Cells[2,i] +#13+
                           'Ocorrência: '+ sg1.Cells[7,i] +#13+
                           'Essa justificativa não será lançada', mb_iconwarning + mb_ok)
            else
               msgTela('','Houve um erro não especificado ao tentar incluir a justificativa, se ele persistir entre em contato com o T.I',0);
     end;
     btCancelaClick(Sender);
   end;
   edBusca.setfocus;
end;

procedure TJustificativa.btCancelaClick(Sender: TObject);
begin
   cbEmp.itemindex:= -1;
   cbOcorrencia.itemindex:= -1;
   cbJust.itemindex:= -1;
   cbOcorrencia.itemIndex:=-1;
   edHoraInicio.text:='';
   edHoraFim.text:='';
   edBusca.setfocus;
   dtRefFolga.Visible := false;
   lbRefFolga.Visible := false;   
   limpaSg1(sender);
end;

procedure TJustificativa.Consulta();
var
  i:smallint;
  data:String;
begin
   Data:='01/' + edMesAno.text;
   uUtil.listaJustificativas( fmMain.getMatricula(cbEmp.Items[cbEMp.ItemIndex]) , funcDatas.DateTimeToSqlDateTime(data,''), qrJustificativas);
   dsJustificativas.DataSet := qrJustificativas;

   for i:=0 to dbgrid1.Columns.Count-1 do
   begin
      dbgrid1.Columns[i].Title.alignment:=tacenter;
      dbgrid1.Columns[i].Title.Font.Style := [fsbold];
   end;
   with dbgrid1 do
   begin
      Columns[0].Title.caption := 'TIPO';
      Columns[1].Title.caption := 'DE        ';
      Columns[2].Title.caption := 'ATE       ';
      Columns[3].Title.caption := 'INICIO';
      Columns[4].Title.caption := 'FIM   ';
      Columns[5].Title.caption := 'OCORRENCIA';
      Columns[6].Title.caption := 'JUSTIFICATIVA';
      Columns[7].Title.caption := 'DATA GERAÇÃO';
      Columns[8].Title.caption := 'LJ GERACAO';
      Columns[09].Title.caption := 'OBSERVAÇÃO';
      Columns[ qrJustificativas.FieldByName('jus_referencia').Index ].Visible := false;

      Columns[0].Width:=55;
      Columns[1].Width:=70;
      Columns[2].Width:=70;
      Columns[3].Width:=50;
      Columns[4].Width:=50;
      Columns[5].Width:=180;
      Columns[6].Width:=180;
      Columns[7].visible := true;
   end;
   edBusca.setfocus;
   dbgrid1.Enabled := true;
   qrJustificativas.First();
end;

procedure TJustificativa.DBGrid1CellClick(Column: TColumn);
begin
   bitbtn9.enabled:=true;
end;
procedure TJustificativa.BitBtn9Click(Sender: TObject);
begin
   if (qrJustificativas.IsEmpty = false) then
      if (msgTela('','Você deseja realmente excluir essa Justificativa ??',mb_yesno+mb_iconquestion) = mryes) then
      begin
         uUtil.deletajustificativa(qrJustificativas.fieldByName('jus_referencia').AsString  );
         BitBtn7Click(Sender);
      end;
end;


procedure TJustificativa.cbOcorrenciaChange(Sender: TObject);
begin
   if cbOcorrencia.itemIndex < 2 then
   begin
      label8.visible := false;
      label4.visible := false;
      edHoraInicio.visible := false;
      edHoraFim.visible := false;
      edHoraInicio.Text:='  :  ';
      edHoraFim.Text:='  :  ';
   end
   else
   begin
      label8.visible := true;
      label4.visible := true;
      edHoraInicio.visible:= true;
      edHoraFim.visible := true;
   end;
end;


procedure TJustificativa.edBuscaChange(Sender: TObject);
var
   i:integer;
begin
  for i:=cbEmp.items.count-1 downto 0 do
     if pos(edBusca.text, cbEmp.items[i])  > 0 then
        cbEmp.itemindex := i;
end;

procedure TJustificativa.BitBtn7Click(Sender: TObject);
begin
  if cbEmp.itemindex < 0 then
   begin
      msgTela('', 'Selecione um empregado.      '+#13,Mb_iconerror + mb_ok);
      cbEmp.SetFocus;
   end
   else
      consulta();
end;

procedure TJustificativa.edBuscaEnter(Sender: TObject);
begin
   edBusca.text := '';
end;

procedure TJustificativa.dtp1Change(Sender: TObject);
begin
   dtp2.DateTime := dtp1.DateTime;
end;

procedure TJustificativa.incluiFuncionario(matricula, nome:String);
begin
{ LAYOUT DO CADASTRO
  NOME INICIO-01 TAM-30
  CARTAO I-42 T-08
  HORARIOS I-55 T-24
  MAT I-84 T-08
  BD I-92 T-01
  LOCAL I-93 T-02
  eSTABELECIMENTO I-95 T-03
 }
   sg1.Cells[0,sg1.RowCount-1] :=  matricula;
   sg1.Cells[1,sg1.RowCount-1] := nome;
   sg1.Cells[2,sg1.RowCount-1] := datetostr(dtp1.Date);
   sg1.Cells[3,sg1.RowCount-1] := datetostr(dtp2.Date);

   if pos('  ',edHoraInicio.Text) <> 0 then
      sg1.Cells[4,sg1.RowCount-1] := '02 - Dia todo'
   else
     sg1.Cells[4,sg1.RowCount-1] := '01 - Parcial ';

   sg1.Cells[5,sg1.RowCount-1] := edHoraInicio.Text;
   sg1.Cells[6,sg1.RowCount-1] := edHoraFim.Text;

   sg1.Cells[7,sg1.RowCount-1] := copy(cbOcorrencia.items[cbOcorrencia.itemindex],01,30);
   sg1.Cells[8,sg1.RowCount-1] := copy(cbJust.items[cbJust.itemindex],01,30);

   sg1.Cells[10,sg1.RowCount-1] := edit2.Text; // OBSERVACAO


   sg1.Cells[13, sg1.RowCount-1] := datetostr(dtRefFolga.Date);
   SG1.RowCount :=    SG1.RowCount+1;
end;


procedure TJustificativa.BitBtn2Click(Sender: TObject);
var
   ds:TdataSet;
begin
   if (cbLojas.ItemIndex <= 0) then
   begin
      if (haErros(fmMain.getMatricula(cbEmp.Items[cbEMp.ItemIndex]),  fmMain.getCartaoPonto(cbEmp), fmMain.getNomeCB(cbEmp)) = false) then
         incluiFuncionario( fmMain.getNome(fmMain.getMatricula(cbEmp.items[cbEMp.itemIndex])), fmMain.getNome(cbEmp.items[cbEMp.itemIndex]) );
   end
   else
   begin
      ds := uUtil.getNomeMatPorLocalizacao(  fmMain.getLocalizacaoLoja(cbLojas) );
      while (ds.Eof = false) do
      begin
         if (haErros(ds.fieldByName('matricula').AsString, ds.fieldByName('matricula').AsString, ds.fieldByName('nome').AsString  ) = false) then
            incluiFuncionario(ds.fieldByName('matricula').asString, ds.fieldByName('nome').asString);
         ds.Next();
      end;
      ds.Destroy();
   end;
   Ajustasg1();



{   if HaErros(sender) = False then
   Begin
      if cbLojas.ItemIndex > 0 then
      begin
         ds := uUtil.getNomeMatPorLocalizacao(  fmMain.getLocalizacaoLoja(cbLojas) );
         while (ds.Eof = false) do
         begin
            incluiFuncionario(ds.fieldByName('matricula').asString, ds.fieldByName('nome').asString);
            ds.Next();
         end;
         ds.Destroy();
      end
      else
         incluiFuncionario(fmMain.getNome(fmMain.getMatricula(cbEmp.items[cbEMp.itemIndex])), fmMain.getNome(cbEmp.items[cbEMp.itemIndex]) );
   end;
   Ajustasg1(sender);
}
end;

procedure TJustificativa.sg1DblClick(Sender: TObject);
var
  J,i:integer;
begin
   if (linhasg1 > 0) then
   begin
      if (sg1.Cells[1,LinhaSg1] <>'')then
      begin
         for i:=0 to sg1.ColCount-1 do
            sg1.Cells[i,linhasg1] := '';
      end;
      for i:=LinhaSg1 to sg1.RowCount - 1 do
         for j:=0 to sg1.ColCount-1 do
            sg1.cells[j,i ] := sg1.cells[j,i+1 ];

      for i:=LinhaSg1 to sg1.rowcount-1  do
         if sg1.Cells[1,i] = '' then
            sg1.RowCount := sg1.RowCount - 1;

      sg1.rowcount := sg1.rowcount +1;
      ajustasg1();
   end;
end;

procedure TJustificativa.sg1SelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  LinhaSg1:= arow;
end;

procedure TJustificativa.cbLojasClick(Sender: TObject);
begin
   if cbLojas.ItemIndex > 0 then
   begin
      edBusca.enabled := false;
      cbEmp.enabled := false;
   end
   else
   begin
      edBusca.enabled := true;
      cbEmp.enabled := true;
   end;
end;

procedure TJustificativa.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
   if sg1.rowcount-1 > 1 then
      CanClose := ( msgTela('', '  Deseja abandonar a inclusão das justificativas ?  ',mb_yesNo + Mb_IconQuestion) = MrYes);
end;

procedure TJustificativa.SpinButton1DownClick(Sender: TObject);
begin
   edMesAno.text:= funcDatas.ajustaDataMes(edMesAno.Text, '-');
end;

procedure TJustificativa.SpinButton1UpClick(Sender: TObject);
begin
   edMesAno.text:= funcDatas.ajustaDataMes(edMesAno.Text, '+');
end;

procedure TJustificativa.cbJustClick(Sender: TObject);
begin
   dtRefFolga.Visible :=  (getCodJust() = COD_FOLGA );
   lbRefFolga.Visible := dtRefFolga.Visible;
   dtRefFolga.Date := DTP1.Date -1;
   dtRefFolga.MinDate := DTP1.Date - 30;
   dtRefFolga.MaxDate := DTP1.Date - 1;
end;


end.
