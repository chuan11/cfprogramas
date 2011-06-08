unit uDadosFolhaGerencial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, Grids, DBGrids, SoftDBGrid, DB, ADODB,
  TFlatButtonUnit,funcoes, comObj, RpBase, RpSystem, RpCon, RpConDS,
  RpDefine, RpRave;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    FlatButton1: TFlatButton;
    Connection1: TADOConnection;
    Query1: TADOQuery;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    Connection2: TADOConnection;
    Query2: TADOQuery;
    DataSource2: TDataSource;
    DP1: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Connection3: TADOConnection;
    Query3: TADOQuery;
    DataSource3: TDataSource;
    Query3emp_nome: TStringField;
    Query3Salario: TFloatField;
    Query3SalarioFamilia: TFloatField;
    Query3QuebraDeCaixa: TFloatField;
    Query3SalarioMaternidade: TFloatField;
    Query3Unimed: TFloatField;
    Query3Faltas: TFloatField;
    Query3INSS: TFloatField;
    Query3ValeTransporte: TFloatField;
    Query3OdontoSystem: TFloatField;
    Query3DentalMaster: TFloatField;
    Query3MensalidadeSindical: TFloatField;
    Query3ContribuicaoSindical: TFloatField;
    Query3PensaoAlimenticia: TFloatField;
    Query3Adiantamento: TFloatField;
    Query3ValesECompras: TFloatField;
    Query3HapVida: TFloatField;
    Query3AdicionalNoturno: TFloatField;
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    RvSystem1: TRvSystem;
    Query3Vtloja: TFloatField;
    function AjustaMesANo(Sender: TObject; Button: TUDBtnType;text:string):string;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function PegarData(sender:tobject):string;
//    procedure ExportaParaExcel(sender:tobject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Function ObterSomaDoCampo(Campo:String):real;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

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


{$R *.dfm}
{
procedure TForm1.ExportaParaExcel(sender: tobject);
var
 // Excel : Variant;
//  q:TadoQuery;
//  i,Linha:integer;
//  aux:string;
begin
{   Excel := CreateOleObject('Excel.Application');
   Excel.WorkBooks.open( ExtractFilePath(ParamStr(0))+'Pasta1.xls');

   Linha:=3;
   I:=0;

   Query3.first;
   While Query3.Eof = false do
   Begin
      I:=0;
      Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+2]:= Query3.Fields[0].AsVariant;
      for i:=1 to Query3.FieldCount -1 do
      begin
         Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+2]:=  Query3.Fields[i].AsVariant;
      end;
      Query3.Next;
      inc(Linha);
   end;
   Excel.Visible :=True;

end;
}

function TForm1.ObterSomaDoCampo(Campo: String): real;
var
   aux:real;
begin
   aux:=0;
   query3.First;
   while query3.Eof = false do
   begin
      aux := aux + query3.fieldByName(Campo).AsFloat;
      query3.Next;
   end;
//  showmessage(campo + floattostrf(aux,ffNumber,18,2));
   result := aux ; //floattostrf(aux,ffNumber,18,2)
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   dp1.Date := now;
   query3.SQL.Clear;
   dp1.Date := StrToDate(funcoes.RParReg('FolhaGerencial','Data'));
   COmbobox1.ItemIndex := StrToInt(funcoes.RParReg('FolhaGerencial','loja'));
end;

function TForm1.PegarData(sender: tobject): string;
begin
   Pegardata := '01/'+ copy(datetostr(dp1.Date),04,02) +'/'+ copy(datetostr(dp1.Date),07,04);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   funcoes.WParReg('FolhaGerencial','Data',DateToStr(dp1.Date));
   funcoes.WParReg('FolhaGerencial','loja',intToStr(Combobox1.ItemIndex));
end;




procedure TForm1.FlatButton1Click(Sender: TObject);
var
   i:smallint;
   Proventos,descontos:real;
   salario,salarioFamilia,QuebraDeCaixa, SalarioMaternidade,AdicionalNoturno :real;

   Unimed,Faltas,INSS,ValeTransporte,OdontoSystem,MensalidadeSindical,DentalMaster,ContribuicaoSindical,
   PensaoAlimenticia,Adiantamento,ValesECompras,HapVida,vtLoja:real;

//   INSSEmpresa:real;
begin
   screen.Cursor := crhourglass;

   connection2.Connected := FALSE;
   Connection2.ConnectionString := 'Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;User ID=secrel;Initial Catalog=FLUXUS001;Data Source=125.4.4.200';
   connection2.Connected := true;

   query2.SQL.Clear;
   query2.SQL.Add('Exec Z_CF_CriaTabelaFolha');  // PARA CRIAR A TABELA dadosfolha
   query2.ExecSql;

   query1.SQL.Clear;
   query1.SQL.Add('Select * from DadosFolha');  // para iniciar a insercao de registros
   query1.Open;

   connection2.Connected := FALSE;
   Connection2.ConnectionString := 'Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;User ID=secrel;Initial Catalog=FLUXUS001;Data Source=125.4.4.200';
   connection2.Connected := true;
   query2.SQL.Clear;
   query2.SQL.add('Exec Z_CF_obterDadosFolha '+ quotedStr(copy(combobox1.Items[combobox1.ItemIndex],01,02)   ) + ', ' + funcoes.StrToSqlDate(PegarData(sender)) );
   query2.SQL.saveToFile('c:\zteste.txt');
   query2.open;

   query2.First;
   while query2.Eof = false do
   begin
      query1.Append;
      for i:=0 to query2.FieldCount-1 do
         query1.Fields[i] := query2.Fields[i];
      query1.Post;
      query2.Next;
   end;


   connection2.Connected := FALSE;
   Connection2.ConnectionString := 'Provider=SQLOLEDB.1;Password=welladm;Persist Security Info=True;User ID=secrel;Initial Catalog=FLUXUS002;Data Source=125.4.4.200';
   connection2.Connected := true;
   query2.SQL.Clear;
   query2.SQL.add('Exec Z_CF_obterDadosFolha '+ quotedStr(copy(combobox1.Items[combobox1.ItemIndex],01,02)   ) + ', ' + funcoes.StrToSqlDate(PegarData(sender)) );
   query2.open;

   query2.First;
   while query2.Eof = false do
   begin
      query1.Append;
      for i:=0 to query2.FieldCount-1 do
         query1.Fields[i] := query2.Fields[i];
      query1.Post;
      query2.Next;
   end;
   screen.Cursor := CrDefault;

   query3.SQL.Clear;
   query3.SQL.Add('Select *  from DadosFolha order by emp_nome');
   query3.Open;

   salario :=  ObterSomaDoCampo('salario') ;
   salarioFamilia := ObterSomaDoCampo('salarioFamilia');
   QuebraDeCaixa  := ObterSomaDoCampo('QuebraDeCaixa');
   SalarioMaternidade  := ObterSomaDoCampo('SalarioMaternidade');
   AdicionalNoturno    := ObterSomaDoCampo('AdicionalNoturno');

   proventos := salario+salarioFamilia+QuebraDeCaixa+SalarioMaternidade+AdicionalNoturno;

   INSS := ObterSomaDoCampo('INSS');
   ValeTransporte :=    ObterSomaDoCampo('ValeTransporte');
   OdontoSystem := ObterSomaDoCampo('OdontoSystem');
   MensalidadeSindical := ObterSomaDoCampo('MensalidadeSindical');
   DentalMaster := ObterSomaDoCampo('DentalMaster');
   ContribuicaoSindical := ObterSomaDoCampo('ContribuicaoSindical');
   PensaoAlimenticia := ObterSomaDoCampo('PensaoAlimenticia');
   Adiantamento := ObterSomaDoCampo('Adiantamento');
   ValesECompras := ObterSomaDoCampo('ValesECompras');
   Unimed := ObterSomaDoCampo('Unimed');
   Faltas := ObterSomaDoCampo('Faltas');
   HapVida := ObterSomaDoCampo('HapVida');
   vtLoja := ObterSomaDoCampo('vtLoja');

   Descontos :=    Unimed+Faltas+INSS+ValeTransporte+odontoSystem+MensalidadeSindical+DentalMaster+ContribuicaoSindical+
   PensaoAlimenticia+Adiantamento+ValesECompras+HapVida+AdicionalNoturno;

   RvProject1.SetParam('Loja', copy(Combobox1.Items[ComboBox1.itemIndex],01,30));
   RvProject1.SetParam('periodo', copy(DateToStr(dp1.Date),04,10) );//    copy(Combobox1.Items[ComboBox1.itenIndex],30);

   RvProject1.SetParam('Salario',             floattostrf(salario ,ffNumber,18,2) );
   RvProject1.SetParam('salarioFamilia' ,     floattostrf(salarioFamilia,ffNumber,18,2) );
   RvProject1.SetParam('QuebraDeCaixa' ,      floattostrf(QuebraDeCaixa ,ffNumber,18,2) );
   RvProject1.SetParam('SalarioMaternidade' , floattostrf(SalarioMaternidade ,ffNumber,18,2) );
   RvProject1.SetParam('AdicionalNoturno' ,   floattostrf(AdicionalNoturno ,ffNumber,18,2) );

   RvProject1.SetParam('Proventos' ,   floattostrf(proventos,ffNumber,18,2) );
   RvProject1.SetParam('descontos' ,   floattostrf(descontos,ffNumber,18,2) );

   RvProject1.SetParam('INSS' ,   floattostrf(INSS,ffNumber,18,2) );
   RvProject1.SetParam('ValeTransporte' ,   floattostrf(ValeTransporte,ffNumber,18,2) );
   RvProject1.SetParam('OdontoSystem' ,   floattostrf(OdontoSystem,ffNumber,18,2) );
   RvProject1.SetParam('MensalidadeSindical' ,   floattostrf(MensalidadeSindical,ffNumber,18,2) );
   RvProject1.SetParam('DentalMaster' ,   floattostrf(DentalMaster,ffNumber,18,2) );
   RvProject1.SetParam('ContribuicaoSindical' ,   floattostrf(ContribuicaoSindical,ffNumber,18,2) );
   RvProject1.SetParam('PensaoAlimenticia' ,   floattostrf(PensaoAlimenticia,ffNumber,18,2) );
   RvProject1.SetParam('Adiantamento' ,   floattostrf(Adiantamento,ffNumber,18,2) );
   RvProject1.SetParam('ValesECompras' ,   floattostrf(ValesECompras,ffNumber,18,2) );
   RvProject1.SetParam('Unimed' ,   floattostrf(Unimed,ffNumber,18,2) );
   RvProject1.SetParam('Faltas' ,   floattostrf(Faltas,ffNumber,18,2) );
   RvProject1.SetParam('HapVida' ,   floattostrf(HapVida,ffNumber,18,2) );
   RvProject1.SetParam('vtloja' ,   floattostrf(vtloja,ffNumber,18,2) );

   RvProject1.SetParam('saldoSalario' ,  floattostrf((proventos - descontos)    ,ffNumber,18,2) );
   RvProject1.SetParam('INSSeMPRESA' ,   floattostrf((( salario+ QuebraDeCaixa+ SalarioMaternidade+ AdicionalNoturno)* 0.278 )    ,ffNumber,18,2) );
   RvProject1.SetParam('INSSrArECOLHER', floattostrf((salario+ QuebraDeCaixa+ SalarioMaternidade+ AdicionalNoturno) + INSS - SALARIOFAMILIA ,ffNumber,18,2));
   RvProject1.SetParam('BASECALCULOFGTS' , floattostrf( (salario+ QuebraDeCaixa+ SalarioMaternidade+ AdicionalNoturno) ,ffNumber,18,2) );
   RvProject1.SetParam('FGTSArECOLHER' ,   floattostrf(((salario+ QuebraDeCaixa+ SalarioMaternidade+ AdicionalNoturno) * 0.08) ,ffNumber,18,2) );


{
'Salario'
'SalarioFamilia'
'QuebraDeCaixa'
'SalarioMaternidade'
'Unimed'
'Faltas'
'AdicionalNoturno'

  FieldName = '
  FieldName = ''
  FieldName = '
  FieldName = 'dical'
  FieldName = '
  FieldName = 'ndical'
  FieldName = 'cia'
  FieldName = '
  FieldName = '
  FieldName = '
}

//   RvProject1.SetParam('Salario', floattostrf(  ,ffNumber,18,2) );  //ObterSomaDoCampo( query3.fieldByName('Salario').AsString ) );

//   RvProject1.SetParam('TotSalario', floattostrf(aux,ffNumber,18,2));  //ObterSomaDoCampo( query3.fieldByName('Salario').AsString ) );
   RvProject1.Execute;

end;



end.
